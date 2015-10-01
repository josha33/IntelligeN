<?php

require_once(__ROOT__.'/sql/data.inc.php');

require_once(__ROOT__.'/xml/message.php');

/**
 * Class SQLUpdateVersion
 */
class SQLUpdateVersion {

	/**
	 * @var
     */
	public $id;
	/**
	 * @var
     */
	public $major_version_number;
	/**
	 * @var
     */
	public $minor_version_number;
	/**
	 * @var
     */
	public $major_build_number;
	/**
	 * @var
     */
	public $minor_build_number;
	/**
	 * @var
     */
	public $created;
	/**
	 * @var
     */
	public $modified;
}

/**
 * Class SQLUpdateVersionFile
 */
class SQLUpdateVersionFile {

	/**
	 * @var
     */
	public $id;
	/**
	 * @var
     */
	public $version_id;
	/**
	 * @var SQLUpdateVersion
     */
	public $version;
	/**
	 * @var
     */
	public $file_id;
	/**
	 * @var SQLUpdateSystemFile
     */
	public $file;
	/**
	 * @var
     */
	public $created;
	/**
	 * @var
     */
	public $modified;
}

class SQLUpdateSystem {
	/**
	 * @var
     */
	public $id;
	/**
	 * @var
     */
	public $filesystem_id;
	/**
	 * @var
     */
	public $path_appendix;
	/**
	 * @var
     */
	public $name;
}

class SQLUpdateSystemFile {
	/**
	 * @var
     */
	public $id;
	/**
	 * @var
     */
	public $system_id;
	/**
	 * @var SQLUpdateSystem
     */
	public $system;
	/**
	 * @var
     */
	public $major_version_number;
	/**
	 * @var
     */
	public $minor_version_number;
	/**
	 * @var
     */
	public $major_build_number;
	/**
	 * @var
     */
	public $minor_build_number;
	/**
	 * @var
     */
	public $size;
	/**
	 * @var
     */
	public $checksum;
}

class SQLSystem
{
	/**
	 * @var mysqli
     */
	private $link;

	/**
	 * @param $major_version
	 * @param $minor_version
	 * @param $major_build
	 * @param $minor_build
	 * @return null|SQLUpdateVersion
     */
	private function GetLastUpgrade($major_version, $minor_version, $major_build, $minor_build) {

		$result = null;

		// Select latest stable upgrade version
		$sql = "SELECT * FROM `intelligen_2k9_update_versions` WHERE (`active` = '1')";
		$sql .= " AND (`major_version_number` = '" . $this->link->escape_string($major_version) . "')";
		$sql .= " AND (`minor_build_number` = '0')";
		$sql .= " ORDER BY `minor_version_number` DESC, `major_build_number` DESC LIMIT 1";

		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}
		else if ($query_result->num_rows == 0)
		{
			// If the are no stable upgrade versions, select latest unstable upgrade version
			$sql = "SELECT * FROM `intelligen_2k9_update_versions` WHERE (`active` = '1')";
			$sql .= " AND (`major_version_number` = '" . $this->link->escape_string($major_version) . "')";
			$sql .= " ORDER BY `minor_version_number` DESC, `major_build_number` DESC, `minor_build_number` DESC LIMIT 1";
			$query_result = $this->link->query($sql);
		}

		if ($query_result->num_rows == 1)
		{
			$result = new SQLUpdateVersion();

			$row = $query_result->fetch_assoc();

			$result->id = $row['id'];
			$result->major_version_number = $row['major_version_number'];
			$result->minor_version_number = $row['minor_version_number'];
			$result->major_build_number = $row['major_build_number'];
			$result->minor_build_number = $row['minor_build_number'];
			$result->created = $row['created'];
			$result->modified = $row['modified'];
		}

		return $result;
		
	}

	/**
	 * @param $major_version
	 * @param $minor_version
	 * @param $major_build
	 * @param $minor_build
	 * @return null|SQLUpdateVersion
     */
	private function GetLastUpdate($major_version, $minor_version, $major_build, $minor_build) {
		
		$result = null;

		// Select latest stable update version
		$sql = "SELECT * FROM `intelligen_2k9_update_versions` WHERE (`active` = '1')";
		$sql .= " AND (`major_version_number` = '" . $this->link->escape_string($major_version) . "')";
		$sql .= " AND (`minor_version_number` = '" . $this->link->escape_string($minor_version) . "')";
		$sql .= " AND (`minor_build_number` = '0')";
		$sql .= " ORDER BY `major_build_number` DESC LIMIT 1";
		
		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}
		else if ($query_result->num_rows == 0)
		{
			// If the are no stable update versions, select latest unstable update version
			$sql = "SELECT * FROM `intelligen_2k9_update_versions` WHERE (`active` = '1')";
			$sql .= " AND (`major_version_number` = '" . $this->link->escape_string($major_version) . "')";
			$sql .= " AND (`minor_version_number` = '" . $this->link->escape_string($minor_version) . "')";
			$sql .= " ORDER BY `major_build_number` DESC, `minor_build_number` DESC LIMIT 1";
			$query_result = $this->link->query($sql);
		}

		if ($query_result->num_rows == 1)
		{
			$result = new SQLUpdateVersion();

			$row = $query_result->fetch_assoc();

			$result->id = $row['id'];
			$result->major_version_number = $row['major_version_number'];
			$result->minor_version_number = $row['minor_version_number'];
			$result->major_build_number = $row['major_build_number'];
			$result->minor_build_number = $row['minor_build_number'];
			$result->created = $row['created'];
			$result->modified = $row['modified'];
		}

		return $result;
	}

	/**
	 * @param SQLUpdateVersion $version
	 * @return SQLUpdateVersionFile[]|null
     */
	private function GetUpdateFilesByVersionId(SQLUpdateVersion $version) {

		$result = null;

		// Select all files that belong to the specified version_id.
		$sql = "SELECT
		`intelligen_2k9_update_version_files`.`id` AS `v_f_id`,
		`intelligen_2k9_update_version_files`.`version_id` AS `v_f_version_id`,
		`intelligen_2k9_update_version_files`.`file_id` AS `v_f_file_id`,
		`intelligen_2k9_update_version_files`.`created` AS `v_f_created`,
		`intelligen_2k9_update_version_files`.`modified` AS `v_f_modified`,

		`intelligen_2k9_update_system_files`.`id` AS `s_f_id`,
		`intelligen_2k9_update_system_files`.`system_id` AS `s_f_system_id`,
		`intelligen_2k9_update_system_files`.`size` AS `s_f_size`,
		`intelligen_2k9_update_system_files`.`major_version_number` AS `s_f_major_version_number`,
		`intelligen_2k9_update_system_files`.`minor_version_number` AS `s_f_minor_version_number`,
		`intelligen_2k9_update_system_files`.`major_build_number` AS `s_f_major_build_number`,
		`intelligen_2k9_update_system_files`.`minor_build_number` AS `s_f_minor_build_number`,
		`intelligen_2k9_update_system_files`.`size` AS `s_f_size`,
		`intelligen_2k9_update_system_files`.`checksum` AS `s_f_checksum`,

		`intelligen_2k9_update_systems`.`id` AS `s_id`,
		`intelligen_2k9_update_systems`.`filesystem_id` AS `s_filesystem_id`,
		`intelligen_2k9_update_systems`.`path_appendix` AS `s_path_appendix`,
		`intelligen_2k9_update_systems`.`name` AS `s_name`

		 FROM `intelligen_2k9_update_version_files`
		 INNER JOIN `intelligen_2k9_update_system_files` ON `intelligen_2k9_update_version_files`.`file_id` = `intelligen_2k9_update_system_files`.`id`
		 INNER JOIN `intelligen_2k9_update_systems` ON `intelligen_2k9_update_system_files`.`system_id` = `intelligen_2k9_update_systems`.`id`
		 WHERE (`intelligen_2k9_update_version_files`.`version_id` = '" . $this->link->escape_string($version->id) . "')";

		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}

		if ($query_result->num_rows >= 1)
		{
			$result = array();

			while($row = $query_result->fetch_assoc()){

				$version_file = new SQLUpdateVersionFile();

				$version_file->id = $row['v_f_id'];
				$version_file->version_id = $row['v_f_version_id'];
				$version_file->version = $version;
				$version_file->file_id = $row['v_f_file_id'];

				$version_file->file = new SQLUpdateSystemFile();
				$version_file->file->id = $row['s_f_id'];
				$version_file->file->system_id = $row['s_f_system_id'];

				$version_file->file->system = new SQLUpdateSystem();
				$version_file->file->system->id = $row['s_id'];
				$version_file->file->system->filesystem_id = $row['s_filesystem_id'];
				$version_file->file->system->path_appendix = $row['s_path_appendix'];
				$version_file->file->system->name = $row['s_name'];

				$version_file->file->major_version_number = $row['s_f_major_version_number'];
				$version_file->file->minor_version_number = $row['s_f_minor_version_number'];
				$version_file->file->major_build_number = $row['s_f_major_build_number'];
				$version_file->file->minor_build_number = $row['s_f_minor_build_number'];
				$version_file->file->size = $row['s_f_size'];
				$version_file->file->checksum = $row['s_f_checksum'];

				$version_file->created = $row['v_f_created'];
				$version_file->modified = $row['v_f_modified'];

				$result[] = $version_file;
			}
		}

		return $result;
	}

	/**
	 * @return SQLUpdateSystem[]|null
     */
	function GetAllSystems() {

		$result = null;

		// Select all entries from systems.
		$sql = "SELECT * FROM `intelligen_2k9_update_systems`";

		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}

		if ($query_result->num_rows >= 1)
		{
			$result = array();

			while($row = $query_result->fetch_assoc()){

				$system = new SQLUpdateSystem();

				$system->id = $row['id'];
				$system->filesystem_id = $row['filesystem_id'];
				$system->path_appendix = $row['path_appendix'];
				$system->name = $row['name'];

				$result[] = $system;
			}
		}

		return $result;
	}

	/**
	 * @param SQLUpdateSystem[] $systems
	 * @return bool
     */
	function AddSystems($systems) {

		$sql = "INSERT INTO `intelligen_2k9`.`intelligen_2k9_update_systems` (`id`, `filesystem_id`, `path_appendix`, `name`) VALUES";

		foreach ($systems as $system) {

			$sql .= " (NULL, " . $this->link->escape_string($system->filesystem_id) . ", '" . $this->link->escape_string($system->path_appendix) . "', '" . $this->link->escape_string($system->name) . "'),";
		}

		$sql = rtrim($sql, ",");

		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}

		return true;
	}

	private function VersionExists($major_version, $minor_version, $major_build, $minor_build) {

		$sql = "SELECT * FROM `intelligen_2k9_update_versions` WHERE";
		$sql .= " AND (`major_version_number` = '" . $this->link->escape_string($major_version) . "')";
		$sql .= " AND (`minor_version_number` = '" . $this->link->escape_string($minor_version) . "')";
		$sql .= " AND (`major_build_number` = '" . $this->link->escape_string($major_build) . "')";
		$sql .= " AND (`minor_build_number` = '" . $this->link->escape_string($minor_build) . "')";

		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}

		return ($query_result->num_rows > 0);
	}

	function AddVersion($major_version, $minor_version, $major_build, $minor_build) {

		if (!$this->VersionExists($major_version, $minor_version, $major_build, $minor_build)) {

			$sql = "INSERT INTO `intelligen_2k9`.`intelligen_2k9_update_versions` (`major_version_number`, `minor_version_number`, `major_build_number`, `minor_build_number`, `created`) VALUES";
			$sql .= " ('" . $this->link->escape_string($major_version) . "', '" . $this->link->escape_string($minor_version) . "', '" . $this->link->escape_string($major_build) . "', '" . $this->link->escape_string($minor_build) . "', CURRENT_TIMESTAMP)";

			$query_result = $this->link->query($sql);
			if(!$query_result)
			{
				die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
			}

			// TODO: return Version ID as result

			return true;
		}

		return false;
	}

	// TODO: add files

	function SetVersionActive($version_id) {

		$sql = "UPDATE `intelligen_2k9`.`intelligen_2k9_update_versions` SET `active` = '1', `modified` = CURRENT_TIMESTAMP";
		$sql .= " WHERE `intelligen_2k9_update_versions`.`id` = '" . $this->link->escape_string($version_id) . "'";

		$query_result = $this->link->query($sql);
		if(!$query_result)
		{
			die(status_message(0, 0, 'There was an error running the query [' . $this->link->error . ']'));
		}

		return true;
	}

	/**
	 *
     */
	function __construct() {

		$this->link = new mysqli(SQL_SERVER, SQL_LOGIN_USERNAME, SQL_LOGIN_PASSWORD, SQL_DATABASE);
		if ($this->link->connect_error) {
			die(status_message(0, 0, 'Unable to connect to database [' . $this->link->connect_errno . ': ' . $this->link->connect_error . ']'));
		}
	}

	/**
	 * @param $major_version
	 * @param $minor_version
	 * @param $major_build
	 * @param $minor_build
     */
	function VersionRequest($major_version, $minor_version, $major_build, $minor_build) {

		// Search for last upgrade
		$last_upgrade = $this->GetLastUpgrade($major_version, $minor_version, $major_build, $minor_build);

		// Search for last update
		$last_update = $this->GetLastUpdate($major_version, $minor_version, $major_build, $minor_build);

		if(is_null($last_upgrade) || is_null($last_update)) {

			echo status_message(1, 1, 'No update available');
		}
		else
		{
			$code = 1;

			// Search for last upgrade files
			$last_upgrade_files = null;
			if(!is_null($last_upgrade)) {
				$code++;
				$last_upgrade_files = $this->GetUpdateFilesByVersionId($last_upgrade);
			}

			// Search for last update files
			$last_update_files = null;
			if(!is_null($last_update)) {

				$code = ($code == 1) ? 4 : 3;

				$last_update_files = $this->GetUpdateFilesByVersionId($last_update);
			}

			// Code definition:
			$message = "";
			switch ($code) {
				case 1: $message = "No update available"; break;
				case 2: $message = "Update available"; break;
				case 3: $message = "Update and upgrade available"; break;
				case 4: $message = "Upgrade available"; break;
			}

			echo files_message(1, $code, $message, $last_upgrade_files, $last_update_files);
		}
	}
	
	function search_version($major_version, $minor_version, $major_build, $minor_build)
	{
		$result = new SQLVersionResult();
		
		$sql = "SELECT id FROM `int2k9_upd_version` WHERE";
		
		$sql .= " (`major_version_number` = '" . mysql_real_escape_string($major_version) . "')";
		
		$sql .= " AND (`minor_version_number` = '" . mysql_real_escape_string($minor_version) . "')";
		
		$sql .= " AND (`major_build_number` = '" . mysql_real_escape_string($major_build) . "')";
		
		$sql .= " AND (`minor_build_number` = '" . mysql_real_escape_string($minor_build) . "')";
		
		$query = mysql_query($sql, $this->link);
		if(!$query)
			die(message(0, 0, mysql_error()));
		
		if(mysql_num_rows($query) == 1)
		{
			$data = mysql_fetch_assoc($query);
			$result->id = $data['id'];
		}
		else
		{
			$result->new = true;
			
			$sql = "INSERT INTO `int2k9_upd_version`(`major_version_number`, `minor_version_number`, `major_build_number`, `minor_build_number`, `description`)";
			$sql .= " VALUES (" . mysql_real_escape_string($major_version) . ", " . mysql_real_escape_string($minor_version) . ", " . mysql_real_escape_string($major_build) . ", " . mysql_real_escape_string($minor_build) . ", '')";
			
			$query = mysql_query($sql);
			
			if($query)
				$result->id = mysql_insert_id($this->link);
			else
				die(message(0, 0, mysql_error()));
		}

		return $result;
	}

	/**
	 *
     */
	function __destruct() {

		if(is_resource($this->link))
			$this->link->close();
	}
}
?>