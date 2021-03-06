unit uSettings;

interface

uses
  // Delphi
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Menus, ExtCtrls, Math, ComCtrls, DateUtils,
  // Dev Express
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxCheckBox, cxLabel, cxTextEdit, cxGroupBox, cxCheckGroup, cxSpinEdit,
  cxMaskEdit, cxDropDownEdit, cxGridLevel, cxGridCustomTableView, cxPC, cxGridTableView, cxBlobEdit, cxListBox, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxCheckListBox, cxContainer, cxButtons, cxListView, cxMemo, cxButtonEdit, cxTrackBar, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu,
  cxNavigator, dxCheckGroupBox, dxBarBuiltInMenu,
  // OmniThreadLibrary
  OtlParallel, OtlTaskControl,
  // AnyDAC
  // uADStanIntf, uADPhysIntf,
  // Frames
  ufAddWebsiteWizard,
  // Common
  uBaseConst, uBaseInterface, uAppConst, uAppInterface,
  // HTTPManager
  uHTTPConst, uHTTPManager,
  // DLLs
  uExport,
  // Utils
  uFileUtils, uPathUtils,
  // Api
  uApiConst, uApiMultiCastEvent, uApiMain, uApiPlugins, uApiPluginsAdd, uApiSettings, uApiSettingsExport, uApiSettingsPluginsCheckListBox, uApiXmlSettings, uApiXml,
  // Plugin
  uPlugInInterface, uPlugInInterfaceAdv, uPlugInClass, uPlugInConst;

type
  TControlsValues = reference to procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem);
  TActiveControlAccess = reference to procedure(const AControl: IControlBasic);

  TSettings = class(TForm)
    cxPCMain: TcxPageControl;
    cxTSGeneral: TcxTabSheet;
    cxcbNativeStyle: TcxCheckBox;
    cxcbUseSkins: TcxCheckBox;
    cxcbCheckForUpdates: TcxCheckBox;
    cxTSPlugins: TcxTabSheet;
    cxPCPlugins: TcxPageControl;
    cxTSControlAligner: TcxTabSheet;
    cxSEMirrorCount: TcxSpinEdit;
    cxSEMirrorColumns: TcxSpinEdit;
    cxBSaveSettings: TcxButton;
    cxTSDatabase: TcxTabSheet;
    cxCLBDatabase: TcxCheckListBox;
    pDatabaseSettings: TPanel;
    lAddDatabase: TLabel;
    lRemoveDatabase: TLabel;
    lDatabaseType: TLabel;
    cxTEDatabaseName: TcxTextEdit;
    lDatabaseName: TLabel;
    cxCOBDatabaseType: TcxComboBox;
    cxTEDatabaseServer: TcxTextEdit;
    cxTEDatabaseDatabase: TcxTextEdit;
    cxTEDatabaseUsername: TcxTextEdit;
    cxTEDatabasePassword: TcxTextEdit;
    cxCOBDatabasePort: TcxComboBox;
    lDatabaseServer: TLabel;
    lDatabaseDatabase: TLabel;
    lDatabaseUsername: TLabel;
    lDatabasePassword: TLabel;
    lDatabasePort: TLabel;
    cxTSCAPTCHA: TcxTabSheet;
    cxTSCMS: TcxTabSheet;
    cxTSCrawler: TcxTabSheet;
    pCrawlerSettings: TPanel;
    lLimit: TLabel;
    cxSELimit: TcxSpinEdit;
    cxTSCrypter: TcxTabSheet;
    pCrypterSettings: TPanel;
    lCrypterAccountName: TLabel;
    lCrypterAccountPassword: TLabel;
    cxTECrypterAccountName: TcxTextEdit;
    cxTECrypterAccountPassword: TcxTextEdit;
    cxTSImageHoster: TcxTabSheet;
    pCMSSettings: TPanel;
    cxCOBMirrorPosition: TcxComboBox;
    cxCBSaveOnClose: TcxCheckBox;
    lCrypterVisitorpassword: TLabel;
    cxTECrypterVisitorpassword: TcxTextEdit;
    cxCBCrypterUseAccount: TcxCheckBox;
    cxCBCrypterUseVisitorpassword: TcxCheckBox;
    lCrypterAdminpassword: TLabel;
    lCrypterEMailforStatusNotice: TLabel;
    cxTECrypterAdminpassword: TcxTextEdit;
    cxTECrypterEMailforStatusNotice: TcxTextEdit;
    cxCBCrypterUseAdminpassword: TcxCheckBox;
    cxCBCrypterUseEMailforStatusNotice: TcxCheckBox;
    cxCOBCrypterFolderName: TcxComboBox;
    lCrypterFolderName: TLabel;
    cxCBCrypterUseCoverLink: TcxCheckBox;
    cxCBCrypterUseDescription: TcxCheckBox;
    cxTECrypterWebseiteLink: TcxTextEdit;
    lCrypterWebseiteLink: TLabel;
    cxCBCrypterUseWebseiteLink: TcxCheckBox;
    cxCGCrypterFoldertypes: TcxCheckGroup;
    cxCGCrypterContainerTypes: TcxCheckGroup;
    cxCBCrypterUseCaptcha: TcxCheckBox;
    cxGCMSLevel1: TcxGridLevel;
    cxGCMS: TcxGrid;
    cxGCMSTableView1: TcxGridTableView;
    cxGCMSTableView1Column1: TcxGridColumn;
    cxGCMSTableView1Column2: TcxGridColumn;
    cxGCMSTableView1Column3: TcxGridColumn;
    cxGCMSTableView1Column4: TcxGridColumn;
    cxGCMSTableView1Column5: TcxGridColumn;
    cxGCMSTableView1Column6: TcxGridColumn;
    cxGCrawlerLevel1: TcxGridLevel;
    cxGCrawler: TcxGrid;
    cxGCrawlerTableView1: TcxGridTableView;
    cxGCrawlerTableView1Column1: TcxGridColumn;
    cxGCrawlerLevel2: TcxGridLevel;
    cxGCrawlerTableView2: TcxGridTableView;
    cxGCrawlerTableView2Column1: TcxGridColumn;
    cxGCrawlerTableView2Column2: TcxGridColumn;
    cxTSControls: TcxTabSheet;
    cxTCControls: TcxTabControl;
    lControlsHelp: TLabel;
    pControlsSettings: TPanel;
    lControlsTitle: TLabel;
    cxTEControlsTitle: TcxTextEdit;
    cxBEControlsHelp: TcxBlobEdit;
    lControlsValue: TLabel;
    cxTEControlsValue: TcxTextEdit;
    pControlTemplateType: TPanel;
    lControlsTemplateTypeSelectAll: TLabel;
    lControlsTemplateTypeSelectNone: TLabel;
    lControlsTemplateTypeSwitch: TLabel;
    cxLVControlsTemplateType: TcxListView;
    lControlsItems: TLabel;
    cxMControlsItemAlsoKnownAs: TcxMemo;
    lControlsItemsSort: TLabel;
    cxCOBDefaultSkin: TcxComboBox;
    cxLBControlsItems: TcxListBox;
    lControlsItemsAdd: TLabel;
    lControlsItemsEdit: TLabel;
    lControlsItemsRemove: TLabel;
    cxTSFileFormats: TcxTabSheet;
    cxPCCrypterAdvertisment: TcxPageControl;
    cxTSCrypterAdvertismentLayer: TcxTabSheet;
    cxTSCrypterAdvertismentLink: TcxTabSheet;
    cxTSCrypterAdvertismentBanner: TcxTabSheet;
    cxLCrypterAdvertismentLayerName: TcxLabel;
    cxTECrypterAdvertismentLayerName: TcxTextEdit;
    cxLCrypterAdvertismentLayerValue: TcxLabel;
    cxTECrypterAdvertismentLayerValue: TcxTextEdit;
    cxLCrypterAdvertismentLink: TcxLabel;
    cxTECrypterAdvertismentLink: TcxTextEdit;
    cxCBCrypterAdvertismentLink: TcxCheckBox;
    cxLCrypterAdvertismentBannerLink: TcxLabel;
    cxTECrypterAdvertismentBannerLink: TcxTextEdit;
    cxCBCrypterAdvertismentBannerLink: TcxCheckBox;
    cxLCrypterAdvertismentBannerPicture: TcxLabel;
    cxTECrypterAdvertismentBannerPicture: TcxTextEdit;
    cxCBCrypterAdvertismentBannerPicture: TcxCheckBox;
    cxLDefaultMirrorCount: TcxLabel;
    cxLMirrorColumns: TcxLabel;
    cxLMirrorPosition: TcxLabel;
    cxLMirrorHeight: TcxLabel;
    cxSEMirrorHeight: TcxSpinEdit;
    cxTSApp: TcxTabSheet;
    cxCBCMSAll: TcxCheckBox;
    cxGCMSTableView1Column7: TcxGridColumn;
    cxPCControls: TcxPageControl;
    cxTSControls_: TcxTabSheet;
    cxTSControlsSettings: TcxTabSheet;
    cxCBControlsIRichEditWrapText: TcxCheckBox;
    cxBAddCMSWebsite: TcxButton;
    cxBRemoveCMSWebsite: TcxButton;
    lCrypterCheckDelay: TLabel;
    cxTBCrypterCheckDelay: TcxTrackBar;
    cxBResetControls: TcxButton;
    cxTSFileHoster: TcxTabSheet;
    cxTSHTTP: TcxTabSheet;
    cxLProxyServerName: TcxLabel;
    cxTEProxyServername: TcxTextEdit;
    cxLProxyServerPort: TcxLabel;
    cxLProxyAccountName: TcxLabel;
    cxTEProxyAccountName: TcxTextEdit;
    cxLProxyAccountPassword: TcxLabel;
    cxTEProxyAccountPassword: TcxTextEdit;
    cxCGEnableProxyAt: TcxCheckGroup;
    cxTSPublish: TcxTabSheet;
    cxLPublishMaxCount: TcxLabel;
    cxSEPublishMaxCount: TcxSpinEdit;
    cxLPublishDelaybetweenUploads: TcxLabel;
    cxSEPublishDelaybetweenUploads: TcxSpinEdit;
    cxLPublishDelaybetweenUploadsMSec: TcxLabel;
    cxLRetryCount: TcxLabel;
    cxSERetryCount: TcxSpinEdit;
    pFileFormatsSettings: TPanel;
    cxCBFileFormatsForceAddCrypter: TcxCheckBox;
    cxCBFileFormatsForceAddImageMirror: TcxCheckBox;
    cxGBProxy: TcxGroupBox;
    cxGBTimeout: TcxGroupBox;
    cxLConnectTimeout: TcxLabel;
    cxLReadTimeout: TcxLabel;
    cxCBCrypterUseFilePassword: TcxCheckBox;
    cxCBCrypterUseCNL: TcxCheckBox;
    cxLProxyServerType: TcxLabel;
    cxCOBProxyServerType: TcxComboBox;
    cxCOBProxyServerPort: TcxComboBox;
    cxLCAPTCHAPosition: TcxLabel;
    cxCOBCAPTCHAPosition: TcxComboBox;
    cxGBDefaultStartup: TcxGroupBox;
    cxCBDefaultStartupAActive: TcxCheckBox;
    cxCBDefaultStartupBActive: TcxCheckBox;
    cxCBDefaultStartupCActive: TcxCheckBox;
    cxCBDefaultStartupDActive: TcxCheckBox;
    cxCBDefaultStartupEActive: TcxCheckBox;
    cxCOBDefaultStartupAType: TcxComboBox;
    cxCOBDefaultStartupBType: TcxComboBox;
    cxCOBDefaultStartupCType: TcxComboBox;
    cxCOBDefaultStartupDType: TcxComboBox;
    cxCOBDefaultStartupEType: TcxComboBox;
    cxLDefaultMirrorTabIndex: TcxLabel;
    cxcobDefaultMirrorTabIndex: TcxComboBox;
    cxCBSwichAfterCrypt: TcxCheckBox;
    cxBExportSettings: TcxButton;
    cxSEDropDownRows: TcxSpinEdit;
    cxLDropDownRows: TcxLabel;
    cxCBModyBeforeCrypt: TcxCheckBox;
    cxLDirectlinksView: TcxLabel;
    cxCOBDirectlinksView: TcxComboBox;
    fAddWebsiteWizard: TfAddWebsiteWizard;
    cxGBProxyRequireAuthentication: TcxGroupBox;
    pImageHosterSettings: TPanel;
    lImageHosterAccountName: TLabel;
    lImageHosterAccountPassword: TLabel;
    cxTEImageHosterAccountName: TcxTextEdit;
    cxTEImageHosterAccountPassword: TcxTextEdit;
    cxCBImageHosterUseAccount: TcxCheckBox;
    cxCOBImageHosterResize: TcxComboBox;
    cxLImageHosterResize: TcxLabel;
    cxCBImageHosterUploadAfterCrawling: TcxCheckBox;
    cxLImageHosterUploadAfterCrawling: TcxLabel;
    cxCGBProxyRequireAuthentication: TdxCheckGroupBox;
    cxGBManager: TcxGroupBox;
    cxLMaxSimultaneousConnections: TcxLabel;
    cxSPMaxSimultaneousConnections: TcxSpinEdit;
    cxSEConnectTimeout: TcxSpinEdit;
    cxLConnectTimeoutMSec: TcxLabel;
    cxSEReadTimeout: TcxSpinEdit;
    cxLReadTimeoutMSec: TcxLabel;
    cxTSLog: TcxTabSheet;
    cxGBLog: TcxGroupBox;
    cxLMaxLogEntries: TcxLabel;
    cxSEMaxLogEntries: TcxSpinEdit;
    cxBGHTTPLog: TcxGroupBox;
    cxLMaxHTTPLogEntries: TcxLabel;
    cxSEMaxHTTPLogEntries: TcxSpinEdit;
    cxLMaxLogEntriesInfo: TcxLabel;
    cxLMaxHTTPLogEntriesInfo: TcxLabel;
    procedure cxcbNativeStylePropertiesChange(Sender: TObject);
    procedure cxcbUseSkinsPropertiesChange(Sender: TObject);
    procedure cxCOBDefaultSkinPropertiesChange(Sender: TObject);
    procedure cxcbCheckForUpdatesPropertiesChange(Sender: TObject);
    procedure cxCOBCAPTCHAPositionPropertiesChange(Sender: TObject);
    procedure cxCBCMSAllPropertiesChange(Sender: TObject);
    procedure cxGCMSTableView1Column3PropertiesInitPopup(Sender: TObject);
    procedure cxGCMSTableView1Column5PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGCMSTableView1Column6PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGCMSTableView1Column7PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGCMSTableView1DataControllerDataChanged(Sender: TObject);
    procedure cxGCMSTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxBAddCMSWebsiteClick(Sender: TObject);
    procedure cxBRemoveCMSWebsiteClick(Sender: TObject);
    procedure cxGCrawlerTableView1DataControllerDataChanged(Sender: TObject);
    procedure cxGCrawlerTableView2DataControllerDataChanged(Sender: TObject);
    procedure cxSELimitPropertiesChange(Sender: TObject);
    procedure cxTECrypterAccountNamePropertiesChange(Sender: TObject);
    procedure cxTECrypterAccountPasswordPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseAccountPropertiesChange(Sender: TObject);
    procedure cxCGCrypterFoldertypesPropertiesChange(Sender: TObject);
    procedure cxCGCrypterContainerTypesPropertiesChange(Sender: TObject);
    procedure cxCOBCrypterFolderNamePropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseCaptchaPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseCoverLinkPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseDescriptionPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseFilePasswordPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseCNLPropertiesChange(Sender: TObject);
    procedure cxTECrypterWebseiteLinkPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseWebseiteLinkPropertiesChange(Sender: TObject);
    procedure cxTECrypterEMailforStatusNoticePropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseEMailforStatusNoticePropertiesChange(Sender: TObject);
    procedure cxTECrypterAdminpasswordPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseAdminpasswordPropertiesChange(Sender: TObject);
    procedure cxTECrypterVisitorpasswordPropertiesChange(Sender: TObject);
    procedure cxCBCrypterUseVisitorpasswordPropertiesChange(Sender: TObject);
    procedure cxTBCrypterCheckDelayPropertiesChange(Sender: TObject);
    procedure cxPCCrypterAdvertismentChange(Sender: TObject);
    procedure cxTECrypterAdvertismentLayerNamePropertiesChange(Sender: TObject);
    procedure cxTECrypterAdvertismentLayerValuePropertiesChange(Sender: TObject);
    procedure cxTECrypterAdvertismentLinkPropertiesChange(Sender: TObject);
    procedure cxCBCrypterAdvertismentLinkPropertiesChange(Sender: TObject);
    procedure cxTECrypterAdvertismentBannerLinkPropertiesChange(Sender: TObject);
    procedure cxCBCrypterAdvertismentBannerLinkPropertiesChange(Sender: TObject);
    procedure cxTECrypterAdvertismentBannerPicturePropertiesChange(Sender: TObject);
    procedure cxCBCrypterAdvertismentBannerPicturePropertiesChange(Sender: TObject);

    procedure cxCBFileFormatsForceAddCrypterPropertiesChange(Sender: TObject);
    procedure cxCBFileFormatsForceAddImageMirrorPropertiesChange(Sender: TObject);
    procedure cxTEImageHosterAccountNamePropertiesChange(Sender: TObject);
    procedure cxTEImageHosterAccountPasswordPropertiesChange(Sender: TObject);
    procedure cxCBImageHosterUseAccountPropertiesChange(Sender: TObject);
    procedure cxCOBImageHosterResizePropertiesChange(Sender: TObject);
    procedure cxCBImageHosterDirectUploadPropertiesChange(Sender: TObject);

    procedure cxSEMirrorCountPropertiesChange(Sender: TObject);
    procedure cxSEMirrorColumnsPropertiesChange(Sender: TObject);
    procedure cxSEMirrorHeightPropertiesChange(Sender: TObject);
    procedure cxCOBMirrorPositionPropertiesChange(Sender: TObject);
    procedure cxCOBDirectlinksViewPropertiesChange(Sender: TObject);
    procedure cxcobDefaultMirrorTabIndexPropertiesChange(Sender: TObject);
    procedure cxcobDefaultMirrorTabIndexPropertiesInitPopup(Sender: TObject);
    procedure cxCBModyBeforeCryptPropertiesChange(Sender: TObject);
    procedure cxCBSwichAfterCryptPropertiesChange(Sender: TObject);
    procedure cxCBDefaultStartupActivePropertiesChange(Sender: TObject);
    procedure cxCOBDefaultStartupTypePropertiesChange(Sender: TObject);
    procedure cxCOBDefaultStartupTypePropertiesInitPopup(Sender: TObject);

    procedure cxCLBDatabaseClick(Sender: TObject);
    procedure cxCLBDatabaseClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure cxTEDatabaseNamePropertiesChange(Sender: TObject);
    procedure cxCOBDatabaseTypePropertiesChange(Sender: TObject);
    procedure cxTEDatabaseServerPropertiesChange(Sender: TObject);
    procedure cxTEDatabaseDatabasePropertiesChange(Sender: TObject);
    procedure cxCOBDatabasePortPropertiesChange(Sender: TObject);
    procedure cxTEDatabaseUsernamePropertiesChange(Sender: TObject);
    procedure cxTEDatabasePasswordPropertiesChange(Sender: TObject);
    procedure lAddDatabaseClick(Sender: TObject);
    procedure lRemoveDatabaseClick(Sender: TObject);

    procedure cxTCControlsChange(Sender: TObject);
    procedure cxLVControlsTemplateTypeSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lControlsTemplateTypeSelectAllClick(Sender: TObject);
    procedure lControlsTemplateTypeSelectAllMouseEnter(Sender: TObject);
    procedure lControlsTemplateTypeSelectAllMouseLeave(Sender: TObject);
    procedure lControlsTemplateTypeSwitchClick(Sender: TObject);
    procedure lControlsTemplateTypeSwitchMouseEnter(Sender: TObject);
    procedure lControlsTemplateTypeSwitchMouseLeave(Sender: TObject);
    procedure lControlsTemplateTypeSelectNoneClick(Sender: TObject);
    procedure lControlsTemplateTypeSelectNoneMouseEnter(Sender: TObject);
    procedure lControlsTemplateTypeSelectNoneMouseLeave(Sender: TObject);
    procedure cxTEControlsTitlePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxBEControlsHelpPropertiesInitPopup(Sender: TObject);
    procedure cxBEControlsHelpPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxTEControlsValuePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure lControlsItemsSortClick(Sender: TObject);
    procedure lControlsItemsAddClick(Sender: TObject);
    procedure lControlsItemsEditClick(Sender: TObject);
    procedure lControlsItemsRemoveClick(Sender: TObject);
    procedure cxLBControlsItemsClick(Sender: TObject);
    procedure cxLBControlsItemsDblClick(Sender: TObject);
    procedure cxLBControlsItemsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure cxLBControlsItemsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure cxMControlsItemAlsoKnownAsPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxCBControlsIRichEditWrapTextPropertiesChange(Sender: TObject);
    procedure cxSEDropDownRowsPropertiesChange(Sender: TObject);
    procedure cxBResetControlsClick(Sender: TObject);

    procedure cxSPMaxSimultaneousConnectionsPropertiesChange(Sender: TObject);
    procedure cxSEConnectTimeoutPropertiesChange(Sender: TObject);
    procedure cxSEReadTimeoutPropertiesChange(Sender: TObject);
    procedure cxCOBProxyServerTypePropertiesChange(Sender: TObject);
    procedure cxTEProxyServernamePropertiesChange(Sender: TObject);
    procedure cxCOBProxyServerPortPropertiesChange(Sender: TObject);
    procedure cxCGBProxyRequireAuthenticationPropertiesChange(Sender: TObject);
    procedure cxTEProxyAccountNamePropertiesChange(Sender: TObject);
    procedure cxTEProxyAccountPasswordPropertiesChange(Sender: TObject);
    procedure cxCGEnableProxyAtPropertiesChange(Sender: TObject);
    procedure cxSEPublishMaxCountPropertiesChange(Sender: TObject);
    procedure cxSEPublishDelaybetweenUploadsPropertiesChange(Sender: TObject);
    procedure cxSERetryCountPropertiesChange(Sender: TObject);

    procedure cxSEMaxLogEntriesPropertiesChange(Sender: TObject);
    procedure cxSEMaxHTTPLogEntriesPropertiesChange(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure cxCBSaveOnCloseClick(Sender: TObject);
    procedure cxBExportSettingsClick(Sender: TObject);
    procedure cxBSaveSettingsClick(Sender: TObject);
  private
    FOnCrawlerContingentChange: Boolean;
    FAppPluginsCheckListBox, FCAPTCHAPluginsCheckListBox, FCMSPluginsCheckListBox, FCrawlerPluginsCheckListBox, FCrypterPluginsCheckListBox, FFileFormatsPluginsCheckListBox, FFileHosterPluginsCheckListBox,
      FImageHosterPluginsCheckListBox: TPluginsCheckListBox;
    FcxLBControlsItemsIndex: Integer;

    procedure AppClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure AddAppClick(Sender: TObject);
    procedure AppAddAllClick(Sender: TObject);
    procedure RemoveAppClick(Sender: TObject);

    procedure CAPTCHAClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure CAPTCHAEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure CAPTCHAAddClick(Sender: TObject);
    procedure CAPTCHAAddAllClick(Sender: TObject);
    procedure RemoveCAPTCHAClick(Sender: TObject);

    procedure CMSClick(Sender: TObject);
    procedure CMSClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure CMSEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure AddCMSClick(Sender: TObject);
    procedure CMSAddAllClick(Sender: TObject);
    procedure RemoveCMSClick(Sender: TObject);
    procedure RemovedCMSClick(Sender: TObject);

    procedure CrawlerClick(Sender: TObject);
    procedure CrawlerClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure CrawlerEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure AddCrawlerClick(Sender: TObject);
    procedure CrawlerAddAllClick(Sender: TObject);
    procedure RemoveCrawlerClick(Sender: TObject);
    procedure RemovedCrawlerClick(Sender: TObject);

    procedure CrypterClick(Sender: TObject);
    procedure CrypterClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure CrypterEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure AddCrypterClick(Sender: TObject);
    procedure CrypterAddAllClick(Sender: TObject);
    procedure RemoveCrypterClick(Sender: TObject);
    procedure RemovedCrypterClick(Sender: TObject);

    procedure FileFormatsClick(Sender: TObject);
    procedure FileFormatsClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure FileFormatsEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure FileFormatsAddClick(Sender: TObject);
    procedure FileFormatsAddAllClick(Sender: TObject);
    procedure RemoveFileFormatsClick(Sender: TObject);
    procedure RemovedFileFormatsClick(Sender: TObject);

    procedure FileHosterClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure FileHosterAddClick(Sender: TObject);
    procedure FileHosterAddAllClick(Sender: TObject);
    procedure RemoveFileHosterClick(Sender: TObject);

    procedure ImageHosterClick(Sender: TObject);
    procedure ImageHosterClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
    procedure ImageHosterEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure ImageHosterAddClick(Sender: TObject);
    procedure ImageHosterAddAllClick(Sender: TObject);
    procedure RemoveImageHosterClick(Sender: TObject);
    procedure RemovedImageHosterClick(Sender: TObject);

    procedure InitializePluginCheckListBoxes;
    function GetDefaultPluginLoadedFunc(const APluginType: TPlugInType; var ACollection: TCollection; var ACheckListBox: TcxCheckListBox): Boolean;
    function GetCMSCheckAllStatus: Byte;
    procedure SetCMSCheckAllStatus;
    procedure RefreshAccountlist;
    procedure cxcobDefaultMirrorTabIndexItemsRefresh(ALoadFormSettings: Boolean = False);
    procedure RefreshControlsValues;
    procedure ControlsValues(AControlsValues: TControlsValues);
    procedure ControlsItemsEdit;
    procedure UpdateAllOpenedTabs(AActiveControlAccess: TActiveControlAccess); overload;
    procedure UpdateAllOpenedTabs(ATypeID: TTypeID; AComponentID: TControlID; AActiveControlAccess: TActiveControlAccess); overload;
    function GetSelectedTemplateTypes(TemplateTypeListView: TcxListView): TTypeIDs;
    procedure UpdatePublishDelaybetweenUploadsHint;
  public
    procedure SetComponentStatusFromSettings;
    property CMSPluginsCheckListBox: TPluginsCheckListBox read FCMSPluginsCheckListBox write FCMSPluginsCheckListBox;
    procedure AddCMSWebsite(const AFileName, AWebsiteName, AWebsiteType: string);
  end;

var
  Settings: TSettings;

implementation

uses
  uMain;
{$R *.dfm}

procedure TSettings.cxcbNativeStylePropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.NativeStyle := cxcbNativeStyle.Checked;

  Main.cxLookAndFeelController.NativeStyle := SettingsManager.Settings.NativeStyle;

  cxcbUseSkins.Enabled := not cxcbNativeStyle.Checked;
end;

procedure TSettings.cxcbUseSkinsPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.UseSkins := cxcbUseSkins.Checked;

  // Main.dxSkinController.UseSkins := SettingsManager.Settings.UseSkins;
end;

procedure TSettings.cxCOBDefaultSkinPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.DefaultSkin := cxCOBDefaultSkin.EditValue;

  // Main.dxSkinController.SkinName := SettingsManager.Settings.DefaultSkin;
end;

procedure TSettings.cxcbCheckForUpdatesPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.CheckForUpdates := cxcbCheckForUpdates.Checked;
end;

procedure TSettings.cxCOBCAPTCHAPositionPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.CAPTCHAPosition := TCAPTCHAPosition(cxCOBCAPTCHAPosition.ItemIndex);
end;
{$REGION 'CMS'}

procedure TSettings.cxCBCMSAllPropertiesChange(Sender: TObject);

  procedure SetStatus(AStatus: Boolean);
  var
    LFileIndex: Integer;
    LCMSWebsitesCollectionItem: TCMSWebsitesCollectionItem;
  begin
    with cxGCMSTableView1.DataController do
    begin
      OnDataChanged := nil;

      BeginUpdate;
      try
        for LFileIndex := 0 to RecordCount - 1 do
        begin
          with TCMSCollectionItem(SettingsManager.Settings.Plugins.CMS.Items[FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
          begin
            LCMSWebsitesCollectionItem := FindCMSWebsite(Values[LFileIndex, cxGCMSTableView1Column2.index]);

            if not(LCMSWebsitesCollectionItem.Enabled = AStatus) then
            begin
              Values[LFileIndex, cxGCMSTableView1Column1.index] := AStatus;

              // Do here everything EXCEPT "SetCMSCheckAllStatus" from "cxGCMSTableView1DataControllerDataChanged"
              LCMSWebsitesCollectionItem.Enabled := AStatus;

              if Assigned(OnSettingsChange) then
                OnSettingsChange.Invoke(cctEnabled, LCMSWebsitesCollectionItem.Index, IfThen(AStatus, 1));
            end;
          end;
        end;
      finally
        EndUpdate;
      end;

      OnDataChanged := cxGCMSTableView1DataControllerDataChanged;
    end;
  end;

begin
  case cxCBCMSAll.State of
    cbsUnchecked:
      SetStatus(False);
    cbsChecked:
      SetStatus(True);
  end;
end;

procedure TSettings.cxGCMSTableView1Column3PropertiesInitPopup(Sender: TObject);
begin
  RefreshAccountlist;
end;

procedure TSettings.cxGCMSTableView1Column5PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  _SubjectFileName: string;
begin
  with cxGCMSTableView1.DataController do
    _SubjectFileName := VarToStr(Values[FocusedRecordIndex, cxGCMSTableView1Column5.index]);

  PromptForFileName(_SubjectFileName, '', '', '', ExcludeTrailingPathDelimiter(GetTemplatesCMSFolder));

  with cxGCMSTableView1.DataController do
    Values[FocusedRecordIndex, cxGCMSTableView1Column5.index] := ExtractRelativePath(GetTemplatesCMSFolder, _SubjectFileName);
end;

procedure TSettings.cxGCMSTableView1Column6PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  _MessageFileName: string;
begin
  with cxGCMSTableView1.DataController do
    _MessageFileName := VarToStr(Values[FocusedRecordIndex, cxGCMSTableView1Column6.index]);

  PromptForFileName(_MessageFileName, '', '', '', ExcludeTrailingPathDelimiter(GetTemplatesCMSFolder));

  with cxGCMSTableView1.DataController do
    Values[FocusedRecordIndex, cxGCMSTableView1Column6.index] := ExtractRelativePath(GetTemplatesCMSFolder, _MessageFileName);
end;

procedure TSettings.cxGCMSTableView1Column7PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  LCMSCollectionItem: TCMSCollectionItem;
  LCMSWebsitesCollectionItem: TCMSWebsitesCollectionItem;
begin
  LCMSCollectionItem := TCMSCollectionItem(SettingsManager.Settings.Plugins.CMS.Items[FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex]);

  with cxGCMSTableView1.DataController do
    LCMSWebsitesCollectionItem := LCMSCollectionItem.FindCMSWebsite(Values[GetFocusedRecordIndex, cxGCMSTableView1Column2.index]);

  if FileExists(LCMSWebsitesCollectionItem.GetPath) then
  begin
    if TPluginBasic.CMSShowWebsiteSettingsEditor(LCMSCollectionItem.Path, LCMSWebsitesCollectionItem, Main) then
    begin
      // TODO: FUTURE: This should be handled by the DirectoryMonitor!
      LCMSCollectionItem.UpdateWebsite(LCMSWebsitesCollectionItem.Index);
    end;
  end
  else
    raise Exception.Create('Websitefile not found! (' + LCMSWebsitesCollectionItem.Path + ')');
end;

procedure TSettings.cxGCMSTableView1DataControllerDataChanged(Sender: TObject);
var
  CMSCollectionItem: TCMSCollectionItem;
  CMSWebsitesCollectionItem: TCMSWebsitesCollectionItem;
  FileName: string;
begin
  with cxGCMSTableView1.DataController do
    if (FocusedRecordIndex <> -1) and (FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1) and (Values[FocusedRecordIndex, cxGCMSTableView1Column2.index] <> Null) then
    begin
      CMSCollectionItem := TCMSCollectionItem(SettingsManager.Settings.Plugins.CMS.Items[FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex]);
      with CMSCollectionItem do
      begin
        CMSWebsitesCollectionItem := FindCMSWebsite(Values[FocusedRecordIndex, cxGCMSTableView1Column2.index]);
        CMSWebsitesCollectionItem.Enabled := Values[FocusedRecordIndex, cxGCMSTableView1Column1.index];

        if Assigned(OnSettingsChange) then
          OnSettingsChange.Invoke(cctEnabled, CMSWebsitesCollectionItem.Index, IfThen(CMSWebsitesCollectionItem.Enabled, 1));
      end;

      SetCMSCheckAllStatus;

      if Values[FocusedRecordIndex, cxGCMSTableView1Column3.index] = Null then
        CMSWebsitesCollectionItem.AccountName := ''
      else
        CMSWebsitesCollectionItem.AccountName := Values[FocusedRecordIndex, cxGCMSTableView1Column3.index];
      if Values[FocusedRecordIndex, cxGCMSTableView1Column4.index] = Null then
        CMSWebsitesCollectionItem.AccountPassword := ''
      else
        CMSWebsitesCollectionItem.AccountPassword := Values[FocusedRecordIndex, cxGCMSTableView1Column4.index];

      FileName := CMSWebsitesCollectionItem.GetSubjectFileName;
      if Values[FocusedRecordIndex, cxGCMSTableView1Column5.index] = Null then
        CMSWebsitesCollectionItem.SubjectFileName := ''
      else
        CMSWebsitesCollectionItem.SubjectFileName := Values[FocusedRecordIndex, cxGCMSTableView1Column5.index];
      if not SameText(FileName, CMSWebsitesCollectionItem.GetSubjectFileName) then
      begin
        with CMSCollectionItem do
          if Assigned(OnSubjectsChange) then
          begin
            if FileExists(FileName) then
              OnSubjectsChange.Invoke(cctDelete, CMSWebsitesCollectionItem.Index, -1);
            if FileExists(CMSWebsitesCollectionItem.GetSubjectFileName) then
              OnSubjectsChange.Invoke(cctAdd, CMSWebsitesCollectionItem.Index, -1);
            OnSubjectsChange.Invoke(cctChange, CMSWebsitesCollectionItem.Index, -1);
          end;
      end;

      FileName := CMSWebsitesCollectionItem.GetMessageFileName;
      if Values[FocusedRecordIndex, cxGCMSTableView1Column6.index] = Null then
        CMSWebsitesCollectionItem.MessageFileName := ''
      else
        CMSWebsitesCollectionItem.MessageFileName := Values[FocusedRecordIndex, cxGCMSTableView1Column6.index];
      if not SameText(FileName, CMSWebsitesCollectionItem.GetMessageFileName) then
      begin
        with CMSCollectionItem do
          if Assigned(OnMessagesChange) then
          begin
            if FileExists(FileName) then
              OnMessagesChange.Invoke(cctDelete, CMSWebsitesCollectionItem.Index, -1);
            if FileExists(CMSWebsitesCollectionItem.GetMessageFileName) then
              OnMessagesChange.Invoke(cctAdd, CMSWebsitesCollectionItem.Index, -1);
            OnMessagesChange.Invoke(cctChange, CMSWebsitesCollectionItem.Index, -1);
          end;
      end;

      // Main.fPublish.GenerateColumns;
    end;
end;

procedure TSettings.cxGCMSTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  cxBRemoveCMSWebsite.Enabled := (cxGCMSTableView1.Controller.SelectedRecordCount > 0);
end;

procedure TSettings.cxBAddCMSWebsiteClick(Sender: TObject);
begin
  fAddWebsiteWizard.cxBCancel.Visible := FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;
  fAddWebsiteWizard.Visible := True;
  pCMSSettings.Visible := not fAddWebsiteWizard.Visible;
end;

procedure TSettings.cxBRemoveCMSWebsiteClick(Sender: TObject);
var
  CMSWebsitesCollectionItem: TCMSWebsitesCollectionItem;
begin
  with cxGCMSTableView1.DataController do
  begin
    with TCMSCollectionItem(SettingsManager.Settings.Plugins.CMS.Items[FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    begin
      CMSWebsitesCollectionItem := FindCMSWebsite(Values[FocusedRecordIndex, cxGCMSTableView1Column2.index]);
      if Assigned(OnSettingsChange) then
        OnSettingsChange.Invoke(cctDelete, CMSWebsitesCollectionItem.Index, -1);
      CMSWebsitesCollectionItem.Free;
    end;
    DeleteRecord(FocusedRecordIndex);
  end;

  cxBRemoveCMSWebsite.Enabled := (cxGCMSTableView1.Controller.SelectedRecordCount > 0);

  SetCMSCheckAllStatus;

  // Main.fPublish.GenerateColumns;
end;
{$ENDREGION}
{$REGION 'Crawler'}

procedure TSettings.cxGCrawlerTableView1DataControllerDataChanged(Sender: TObject);
begin ;
end;

procedure TSettings.cxGCrawlerTableView2DataControllerDataChanged(Sender: TObject);
var
  I, X: Integer;
  CustomDataController: TcxCustomDataController;

  LTypeID: TTypeID;
  LControlID: TControlID;
  LStatus: Boolean;
begin
  if (FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1) and not FOnCrawlerContingentChange then
    with cxGCrawlerTableView1.DataController do
    begin
      for I := 0 to RecordCount - 1 do
      begin
        LTypeID := StringToTypeID(Values[I, cxGCrawlerTableView1Column1.index]);
        CustomDataController := GetDetailDataController(I, 0);

        for X := 0 to CustomDataController.RecordCount - 1 do
        begin
          LControlID := StringToControlID('I' + CustomDataController.Values[X, cxGCrawlerTableView2Column1.index]);
          LStatus := CustomDataController.Values[X, cxGCrawlerTableView2Column2.index];

          if not(TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]).ContingentStatus[LTypeID, LControlID] = LStatus) then
            TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]).ContingentStatus[LTypeID, LControlID] := LStatus;
        end;
      end;
    end;
end;

procedure TSettings.cxSELimitPropertiesChange(Sender: TObject);
begin
  TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Limit := cxSELimit.Value;
end;
{$ENDREGION}
{$REGION 'Crypter'}

procedure TSettings.cxTECrypterAccountNamePropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AccountName := cxTECrypterAccountName.Text;
end;

procedure TSettings.cxTECrypterAccountPasswordPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AccountPassword := cxTECrypterAccountPassword.Text;
end;

procedure TSettings.cxCBCrypterUseAccountPropertiesChange(Sender: TObject);
begin
  cxTECrypterAccountName.Enabled := cxCBCrypterUseAccount.Checked;
  cxTECrypterAccountPassword.Enabled := cxCBCrypterUseAccount.Checked;
  TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]).UseAccount := cxCBCrypterUseAccount.Checked;
end;

procedure TSettings.cxCGCrypterFoldertypesPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
  begin
    with cxCGCrypterFoldertypes do
    begin
      Foldertypes := [];
      if States[0] = cbsChecked then
        Foldertypes := [ftWeb];
      if States[1] = cbsChecked then
        Foldertypes := Foldertypes + [ftPlain];
      if States[2] = cbsChecked then
        Foldertypes := Foldertypes + [ftContainer];
    end;
  end;
end;

procedure TSettings.cxCGCrypterContainerTypesPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
  begin
    with cxCGCrypterContainerTypes do
    begin
      ContainerTypes := [];
      if States[0] = cbsChecked then
        ContainerTypes := [ctCCF];
      if States[1] = cbsChecked then
        ContainerTypes := ContainerTypes + [ctDLC];
      if States[2] = cbsChecked then
        ContainerTypes := ContainerTypes + [ctRSDF];
    end;
  end;
end;

procedure TSettings.cxCOBCrypterFolderNamePropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    FolderName := TFoldername(cxCOBCrypterFolderName.ItemIndex);
end;

procedure TSettings.cxCBCrypterUseCaptchaPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseCaptcha := cxCBCrypterUseCaptcha.Checked;
end;

procedure TSettings.cxTECrypterWebseiteLinkPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    WebseiteLink := cxTECrypterWebseiteLink.Text;
end;

procedure TSettings.cxCBCrypterUseWebseiteLinkPropertiesChange(Sender: TObject);
begin
  cxTECrypterWebseiteLink.Enabled := cxCBCrypterUseWebseiteLink.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseWebseiteLink := cxCBCrypterUseWebseiteLink.Checked;
end;

procedure TSettings.cxCBCrypterUseCoverLinkPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseCoverLink := cxCBCrypterUseCoverLink.Checked;
end;

procedure TSettings.cxCBCrypterUseDescriptionPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseDescription := cxCBCrypterUseDescription.Checked;
end;

procedure TSettings.cxCBCrypterUseFilePasswordPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseFilePassword := cxCBCrypterUseFilePassword.Checked;
end;

procedure TSettings.cxCBCrypterUseCNLPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseCNL := cxCBCrypterUseCNL.Checked;
end;

procedure TSettings.cxTECrypterEMailforStatusNoticePropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    EMailforStatusNotice := cxTECrypterEMailforStatusNotice.Text;
end;

procedure TSettings.cxCBCrypterUseEMailforStatusNoticePropertiesChange(Sender: TObject);
begin
  cxTECrypterEMailforStatusNotice.Enabled := cxCBCrypterUseEMailforStatusNotice.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseEMailforStatusNotice := cxCBCrypterUseEMailforStatusNotice.Checked;
end;

procedure TSettings.cxTECrypterAdminpasswordPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdminPassword := cxTECrypterAdminpassword.Text;
end;

procedure TSettings.cxCBCrypterUseAdminpasswordPropertiesChange(Sender: TObject);
begin
  cxTECrypterAdminpassword.Enabled := cxCBCrypterUseAdminpassword.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseAdminPassword := cxCBCrypterUseAdminpassword.Checked;
end;

procedure TSettings.cxTECrypterVisitorpasswordPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    VisitorPassword := cxTECrypterVisitorpassword.Text;
end;

procedure TSettings.cxCBCrypterUseVisitorpasswordPropertiesChange(Sender: TObject);
begin
  cxTECrypterVisitorpassword.Enabled := cxCBCrypterUseVisitorpassword.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseVisitorPassword := cxCBCrypterUseVisitorpassword.Checked;
end;

procedure TSettings.cxTBCrypterCheckDelayPropertiesChange(Sender: TObject);
begin
  cxTBCrypterCheckDelay.Hint := FloatToStr(cxTBCrypterCheckDelay.Position / 1000) + ' seconds';
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    CheckDelay := cxTBCrypterCheckDelay.Position;
end;

procedure TSettings.cxPCCrypterAdvertismentChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdvertismentType := TAdvertismenttype(cxPCCrypterAdvertisment.ActivePageIndex);
end;

procedure TSettings.cxTECrypterAdvertismentLayerNamePropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdvertismentLayerName := cxTECrypterAdvertismentLayerName.Text;
end;

procedure TSettings.cxTECrypterAdvertismentLayerValuePropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdvertismentLayerValue := cxTECrypterAdvertismentLayerValue.Text;
end;

procedure TSettings.cxTECrypterAdvertismentLinkPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdvertismentLink := cxTECrypterAdvertismentLink.Text;

  cxTECrypterAdvertismentBannerLink.Text := cxTECrypterAdvertismentLink.Text;
end;

procedure TSettings.cxCBCrypterAdvertismentLinkPropertiesChange(Sender: TObject);
begin
  cxTECrypterAdvertismentLink.Enabled := cxCBCrypterAdvertismentLink.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseAdvertismentLink := cxCBCrypterAdvertismentLink.Checked;

  cxCBCrypterAdvertismentBannerLink.Checked := cxCBCrypterAdvertismentLink.Checked;
end;

procedure TSettings.cxTECrypterAdvertismentBannerLinkPropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdvertismentLink := cxTECrypterAdvertismentBannerLink.Text;

  cxTECrypterAdvertismentLink.Text := cxTECrypterAdvertismentBannerLink.Text;
end;

procedure TSettings.cxCBCrypterAdvertismentBannerLinkPropertiesChange(Sender: TObject);
begin
  cxTECrypterAdvertismentBannerLink.Enabled := cxCBCrypterAdvertismentBannerLink.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseAdvertismentLink := cxCBCrypterAdvertismentBannerLink.Checked;

  cxCBCrypterAdvertismentLink.Checked := cxCBCrypterAdvertismentBannerLink.Checked;
end;

procedure TSettings.cxTECrypterAdvertismentBannerPicturePropertiesChange(Sender: TObject);
begin
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AdvertismentPicture := cxTECrypterAdvertismentBannerPicture.Text;
end;

procedure TSettings.cxCBCrypterAdvertismentBannerPicturePropertiesChange(Sender: TObject);
begin
  cxTECrypterAdvertismentBannerPicture.Enabled := cxCBCrypterAdvertismentBannerPicture.Checked;
  with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseAdvertismentPicture := cxCBCrypterAdvertismentBannerPicture.Checked;
end;
{$ENDREGION}
{$REGION 'FileFormats'}

procedure TSettings.cxCBFileFormatsForceAddCrypterPropertiesChange(Sender: TObject);
begin
  with TFileFormatsCollectionItem(SettingsManager.Settings.Plugins.FileFormats.Items[FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    ForceAddCrypter := cxCBFileFormatsForceAddCrypter.Checked;
end;

procedure TSettings.cxCBFileFormatsForceAddImageMirrorPropertiesChange(Sender: TObject);
begin
  with TFileFormatsCollectionItem(SettingsManager.Settings.Plugins.FileFormats.Items[FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    ForceAddImageMirror := cxCBFileFormatsForceAddImageMirror.Checked;
end;
{$ENDREGION}
{$REGION 'ImageHoster'}

procedure TSettings.cxTEImageHosterAccountNamePropertiesChange(Sender: TObject);
begin
  with TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AccountName := cxTEImageHosterAccountName.Text;
end;

procedure TSettings.cxTEImageHosterAccountPasswordPropertiesChange(Sender: TObject);
begin
  with TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    AccountPassword := cxTEImageHosterAccountPassword.Text;
end;

procedure TSettings.cxCBImageHosterUseAccountPropertiesChange(Sender: TObject);
begin
  cxTEImageHosterAccountName.Enabled := cxCBImageHosterUseAccount.Checked;
  cxTEImageHosterAccountPassword.Enabled := cxCBImageHosterUseAccount.Checked;
  with TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UseAccount := cxCBImageHosterUseAccount.Checked;
end;

procedure TSettings.cxCOBImageHosterResizePropertiesChange(Sender: TObject);
begin
  with TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    ImageHostResize := TImageHostResize(cxCOBImageHosterResize.ItemIndex);
end;

procedure TSettings.cxCBImageHosterDirectUploadPropertiesChange(Sender: TObject);
begin
  with TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    UploadAfterCrawling := cxCBImageHosterUploadAfterCrawling.Checked;
end;
{$ENDREGION}
{ ****************************************************************************** }

procedure TSettings.cxSEMirrorCountPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.ControlAligner.MirrorCount := cxSEMirrorCount.Value;
end;

procedure TSettings.cxSEMirrorColumnsPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.ControlAligner.MirrorColumns := cxSEMirrorColumns.Value;
  Main.fMain.CallControlAligner;
end;

procedure TSettings.cxSEMirrorHeightPropertiesChange(Sender: TObject);
var
  I, J: Integer;
begin
  SettingsManager.Settings.ControlAligner.MirrorHeight := cxSEMirrorHeight.Value;
  with Main.fMain do
  begin
    for I := 0 to TabSheetCount - 1 do
      for J := 0 to TabSheetController[I].MirrorController.MirrorCount - 1 do
        TabSheetController[I].MirrorController.Mirror[J].Height := cxSEMirrorHeight.Value;
    CallControlAligner;
  end;
end;

procedure TSettings.cxCOBMirrorPositionPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.ControlAligner.MirrorPosition := TMirrorPosition(cxCOBMirrorPosition.ItemIndex);
  Main.fMain.CallControlAligner;
end;

procedure TSettings.cxCOBDirectlinksViewPropertiesChange(Sender: TObject);
var
  I, J: Integer;
begin
  SettingsManager.Settings.ControlAligner.DirectlinksView := TDirectlinksView(cxCOBDirectlinksView.ItemIndex);
  with Main.fMain do
  begin
    for I := 0 to TabSheetCount - 1 do
      for J := 0 to TabSheetController[I].MirrorController.MirrorCount - 1 do
        if TabSheetController[I].MirrorController.Mirror[J].DirectlinkCount > 0 then
          TabSheetController[I].MirrorController.Mirror[J].GetDirectlink.ActiveMirror.UpdateGUI;
  end;
end;

procedure TSettings.cxcobDefaultMirrorTabIndexPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.ControlAligner.DefaultMirrorTabIndex := cxcobDefaultMirrorTabIndex.Text;
end;

procedure TSettings.cxcobDefaultMirrorTabIndexPropertiesInitPopup(Sender: TObject);
begin
  cxcobDefaultMirrorTabIndexItemsRefresh;
end;

procedure TSettings.cxCBModyBeforeCryptPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.ControlAligner.ModyBeforeCrypt := cxCBModyBeforeCrypt.Checked;
end;

procedure TSettings.cxCBSwichAfterCryptPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.ControlAligner.SwichAfterCrypt := cxCBSwichAfterCrypt.Checked;
end;

procedure TSettings.cxCBDefaultStartupActivePropertiesChange(Sender: TObject);
begin
  case (Sender as TcxCheckBox).Tag of
    0:
      begin
        SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveA := (Sender as TcxCheckBox).Checked;
        cxCOBDefaultStartupAType.Enabled := (Sender as TcxCheckBox).Checked;
      end;
    1:
      begin
        SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveB := (Sender as TcxCheckBox).Checked;
        cxCOBDefaultStartupBType.Enabled := (Sender as TcxCheckBox).Checked;
      end;
    2:
      begin
        SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveC := (Sender as TcxCheckBox).Checked;
        cxCOBDefaultStartupCType.Enabled := (Sender as TcxCheckBox).Checked;
      end;
    3:
      begin
        SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveD := (Sender as TcxCheckBox).Checked;
        cxCOBDefaultStartupDType.Enabled := (Sender as TcxCheckBox).Checked;
      end;
    4:
      begin
        SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveE := (Sender as TcxCheckBox).Checked;
        cxCOBDefaultStartupEType.Enabled := (Sender as TcxCheckBox).Checked;
      end;
  end;
end;

procedure TSettings.cxCOBDefaultStartupTypePropertiesChange(Sender: TObject);
begin
  case (Sender as TcxComboBox).Tag of
    0:
      SettingsManager.Settings.ControlAligner.DefaultStartup.TypeA := (Sender as TcxComboBox).Text;
    1:
      SettingsManager.Settings.ControlAligner.DefaultStartup.TypeB := (Sender as TcxComboBox).Text;
    2:
      SettingsManager.Settings.ControlAligner.DefaultStartup.TypeC := (Sender as TcxComboBox).Text;
    3:
      SettingsManager.Settings.ControlAligner.DefaultStartup.TypeD := (Sender as TcxComboBox).Text;
    4:
      SettingsManager.Settings.ControlAligner.DefaultStartup.TypeE := (Sender as TcxComboBox).Text;
  end;
end;

procedure TSettings.cxCOBDefaultStartupTypePropertiesInitPopup(Sender: TObject);
var
  StringList: TStrings;
begin
  StringList := GetTemplateList;
  try
    case (Sender as TcxComboBox).Tag of
      0:
        (Sender as TcxComboBox).Properties.Items.Text := StringList.Text;
      1:
        (Sender as TcxComboBox).Properties.Items.Text := StringList.Text;
      2:
        (Sender as TcxComboBox).Properties.Items.Text := StringList.Text;
      3:
        (Sender as TcxComboBox).Properties.Items.Text := StringList.Text;
      4:
        (Sender as TcxComboBox).Properties.Items.Text := StringList.Text;
  end;
  finally
    StringList.Free;
  end;
end;

{ ****************************************************************************** }
{$REGION 'Database'}

procedure TSettings.cxCLBDatabaseClick(Sender: TObject);
begin
  pDatabaseSettings.Visible := cxCLBDatabase.ItemIndex <> -1;

  lRemoveDatabase.Enabled := cxCLBDatabase.ItemIndex <> -1;

  if pDatabaseSettings.Visible then
  begin

    with TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]) do
    begin
      cxTEDatabaseName.Text := name;
      // with cxCOBDatabaseType do
      // ItemIndex := Properties.Items.IndexOf(C_AD_PhysRDBMSKinds[Connectivity]);
      cxTEDatabaseServer.Text := Server;
      cxTEDatabaseDatabase.Text := Database;
      cxCOBDatabasePort.Text := IntToStr(Port);
      cxTEDatabaseUsername.Text := Username;
      cxTEDatabasePassword.Text := Password;
    end;

  end;

end;

procedure TSettings.cxCLBDatabaseClickCheck(Sender: TObject; AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[AIndex]).Enabled := (ANewState = cbsChecked);
end;

procedure TSettings.cxTEDatabaseNamePropertiesChange(Sender: TObject);
begin
  TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]).name := cxTEDatabaseName.Text;

  cxCLBDatabase.Items[cxCLBDatabase.ItemIndex].Text := cxTEDatabaseName.Text;
end;

procedure TSettings.cxCOBDatabaseTypePropertiesChange(Sender: TObject);
begin
  // TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex])
  // .Connectivity := TADRDBMSKind(cxCOBDatabaseType.ItemIndex + 1);
end;

procedure TSettings.cxTEDatabaseServerPropertiesChange(Sender: TObject);
begin
  with TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]) do
    Server := cxTEDatabaseServer.Text;
end;

procedure TSettings.cxTEDatabaseDatabasePropertiesChange(Sender: TObject);
begin
  with TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]) do
    Database := cxTEDatabaseDatabase.Text;
end;

procedure TSettings.cxCOBDatabasePortPropertiesChange(Sender: TObject);
begin
  if cxCOBDatabasePort.Text <> '' then
    with TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]) do
      Port := StrToInt(cxCOBDatabasePort.Text);
end;

procedure TSettings.cxTEDatabaseUsernamePropertiesChange(Sender: TObject);
begin
  with TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]) do
    Username := cxTEDatabaseUsername.Text;
end;

procedure TSettings.cxTEDatabasePasswordPropertiesChange(Sender: TObject);
begin
  with TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]) do
    Password := cxTEDatabasePassword.Text;
end;

procedure TSettings.lAddDatabaseClick(Sender: TObject);
var
  DatabaseCollectionItem: TDatabaseCollectionItem;
begin

  DatabaseCollectionItem := TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Add);
  with DatabaseCollectionItem do
  begin
    // Name := GenerateNewName(StrNewDatabaseConnect, cxCLBDatabase.Items);
  end;
  with cxCLBDatabase.Items.Add do
  begin
    Checked := DatabaseCollectionItem.Enabled;
    Text := DatabaseCollectionItem.name;
  end;

end;

procedure TSettings.lRemoveDatabaseClick(Sender: TObject);
begin

  TDatabaseCollectionItem(SettingsManager.Settings.Database.Database.Items[cxCLBDatabase.ItemIndex]).Free;
  with cxCLBDatabase do
    Items[ItemIndex].Free;

  pDatabaseSettings.Visible := cxCLBDatabase.ItemIndex <> -1;

  lRemoveDatabase.Enabled := cxCLBDatabase.ItemIndex <> -1;

end;
{$ENDREGION}
{ ****************************************************************************** }
{$REGION 'Controls'}

procedure TSettings.cxTCControlsChange(Sender: TObject);
begin
  RefreshControlsValues;

  pControlTemplateType.Visible := (cxTCControls.TabIndex <> -1);
  lControlsItemsEdit.Enabled := cxLBControlsItems.ItemIndex <> -1;
  lControlsItemsRemove.Enabled := cxLBControlsItems.ItemIndex <> -1;
  cxMControlsItemAlsoKnownAs.Visible := cxLBControlsItems.ItemIndex <> -1;
end;

procedure TSettings.cxLVControlsTemplateTypeSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  RefreshControlsValues;

  pControlsSettings.Visible := (cxLVControlsTemplateType.SelCount > 0);
  lControlsItemsEdit.Enabled := cxLBControlsItems.ItemIndex <> -1;
  lControlsItemsRemove.Enabled := cxLBControlsItems.ItemIndex <> -1;
  cxMControlsItemAlsoKnownAs.Visible := cxLBControlsItems.ItemIndex <> -1;
end;

procedure TSettings.lControlsTemplateTypeSelectAllClick(Sender: TObject);
begin
  cxLVControlsTemplateType.SelectAll;
end;

procedure TSettings.lControlsTemplateTypeSelectAllMouseEnter(Sender: TObject);
begin
  lControlsTemplateTypeSelectAll.Font.Style := [fsUnderline];
end;

procedure TSettings.lControlsTemplateTypeSelectAllMouseLeave(Sender: TObject);
begin
  lControlsTemplateTypeSelectAll.Font.Style := [];
end;

procedure TSettings.lControlsTemplateTypeSwitchClick(Sender: TObject);
var
  I: Integer;
begin
  with cxLVControlsTemplateType.Items do
    for I := 0 to Count - 1 do
      Item[I].Selected := not(Item[I].Selected);
end;

procedure TSettings.lControlsTemplateTypeSwitchMouseEnter(Sender: TObject);
begin
  lControlsTemplateTypeSwitch.Font.Style := [fsUnderline];
end;

procedure TSettings.lControlsTemplateTypeSwitchMouseLeave(Sender: TObject);
begin
  lControlsTemplateTypeSwitch.Font.Style := [];
end;

procedure TSettings.lControlsTemplateTypeSelectNoneClick(Sender: TObject);
var
  I: Integer;
begin
  with cxLVControlsTemplateType.Items do
    for I := 0 to Count - 1 do
      Item[I].Selected := False;
end;

procedure TSettings.lControlsTemplateTypeSelectNoneMouseEnter(Sender: TObject);
begin
  lControlsTemplateTypeSelectNone.Font.Style := [fsUnderline];
end;

procedure TSettings.lControlsTemplateTypeSelectNoneMouseLeave(Sender: TObject);
begin
  lControlsTemplateTypeSelectNone.Font.Style := [];
end;

procedure TSettings.cxTEControlsTitlePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if not(cxTCControls.TabIndex = -1) then
  begin
    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)begin AControlCollectionItem.Title := cxTEControlsTitle.Text;
      UpdateAllOpenedTabs(ATypeID, AComponentID, procedure(const AControl: IControlBasic)begin AControl.Title := cxTEControlsTitle.Text; end); end);
  end;
end;

procedure TSettings.cxBEControlsHelpPropertiesInitPopup(Sender: TObject);
begin
  cxBEControlsHelp.Properties.PopupWidth := cxBEControlsHelp.Width;
end;

procedure TSettings.cxBEControlsHelpPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if not(cxTCControls.TabIndex = -1) then
  begin
    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)begin AControlCollectionItem.HelpText := cxBEControlsHelp.Text;
      UpdateAllOpenedTabs(ATypeID, AComponentID, procedure(const AControl: IControlBasic)begin AControl.Hint := cxBEControlsHelp.Text; end); end);
  end;
end;

procedure TSettings.cxTEControlsValuePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if not(cxTCControls.TabIndex = -1) then
  begin
    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)begin AControlCollectionItem.Value := cxTEControlsValue.Text;
      UpdateAllOpenedTabs(ATypeID, AComponentID, procedure(const AControl: IControlBasic)begin AControl.Value := cxTEControlsValue.Text; end); end);
  end;
end;

procedure TSettings.lControlsItemsSortClick(Sender: TObject);
begin
  //
end;

procedure TSettings.lControlsItemsAddClick(Sender: TObject);
var
  NewItem: string;

  procedure A;
  var
    _ComboBoxIntf: IControlComboBox;
    _CheckComboBoxIntf: IControlCheckComboBox;
  begin
    with cxLBControlsItems do
    begin
      if InputQuery(StrNewItem, StrNewItemValue, NewItem) then
      begin
        if (Items.IndexOf(NewItem) = -1) and not(NewItem = '') then
        begin
          ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)begin TControlItemsCollectionItem(AControlCollectionItem.Items.Add).ItemName := NewItem;
            UpdateAllOpenedTabs(ATypeID, TControlID(cxTCControls.TabIndex), procedure(const AControl: IControlBasic)begin if AControl.QueryInterface(IControlComboBox, _ComboBoxIntf) = 0 then _ComboBoxIntf.List := _ComboBoxIntf.List + NewItem;
              if AControl.QueryInterface(IControlCheckComboBox, _CheckComboBoxIntf) = 0 then _CheckComboBoxIntf.List := _CheckComboBoxIntf.List + NewItem; end); end);
          Items.Add(NewItem);
        end
        else
          A;
      end;
    end;
  end;

begin
  A;

  lControlsItemsEdit.Enabled := cxLBControlsItems.ItemIndex <> -1;
  lControlsItemsRemove.Enabled := cxLBControlsItems.ItemIndex <> -1;
  cxMControlsItemAlsoKnownAs.Visible := cxLBControlsItems.ItemIndex <> -1;
end;

procedure TSettings.lControlsItemsEditClick(Sender: TObject);
begin
  ControlsItemsEdit;
end;

procedure TSettings.lControlsItemsRemoveClick(Sender: TObject);
var
  _SelectedItem: string;
begin
  if TaskMessageDlg(StrRemoveSelectedItem, StrRemoveItem, mtConfirmation, [mbyes, mbno, mbcancel], 0) = ID_YES then
  begin
    _SelectedItem := cxLBControlsItems.Items[cxLBControlsItems.ItemIndex];

    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)var I: Integer; _ComboBoxIntf: IControlComboBox; _CheckComboBoxIntf: IControlCheckComboBox;
      begin for I := AControlCollectionItem.Items.Count - 1 downto 0 do with TControlItemsCollectionItem(AControlCollectionItem.Items.Items[I]) do if (_SelectedItem = ItemName) then Free;
      UpdateAllOpenedTabs(ATypeID, AComponentID, procedure(const AControl: IControlBasic)begin if AControl.QueryInterface(IControlComboBox, _ComboBoxIntf) = 0 then _ComboBoxIntf.List := AControlCollectionItem.GetItems;
        if AControl.QueryInterface(IControlCheckComboBox, _CheckComboBoxIntf) = 0 then _CheckComboBoxIntf.List := AControlCollectionItem.GetItems; end); end);
    with cxLBControlsItems do
      Items.Delete(ItemIndex);
  end;

  lControlsItemsEdit.Enabled := cxLBControlsItems.ItemIndex <> -1;
  lControlsItemsRemove.Enabled := cxLBControlsItems.ItemIndex <> -1;
  cxMControlsItemAlsoKnownAs.Visible := cxLBControlsItems.ItemIndex <> -1;
end;

procedure TSettings.cxLBControlsItemsClick(Sender: TObject);
const
  _clear: string = '\0';
var
  _SelectedItem, _AlsoKnownAs: string;
begin
  lControlsItemsEdit.Enabled := cxLBControlsItems.ItemIndex <> -1;
  lControlsItemsRemove.Enabled := cxLBControlsItems.ItemIndex <> -1;
  cxMControlsItemAlsoKnownAs.Visible := cxLBControlsItems.ItemIndex <> -1;

  if cxLBControlsItems.ItemIndex <> -1 then
  begin
    _AlsoKnownAs := _clear;

    _SelectedItem := cxLBControlsItems.Items[cxLBControlsItems.ItemIndex];

    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)

        function Y(oldstr, newstr: string): string; var I, J: Integer; OldStringList, NewStringList: TStringList; begin with TStringList.Create do try OldStringList := TStringList.Create; NewStringList := TStringList.Create;
      try OldStringList.Text := oldstr; NewStringList.Text := newstr;

      for I := 0 to OldStringList.Count - 1 do for J := 0 to NewStringList.Count - 1 do if OldStringList[I] = NewStringList[J] then Add(OldStringList[I]); finally NewStringList.Free; OldStringList.Free; end; Result := Text; finally Free; end; end;

      var I: Integer; begin for I := 0 to AControlCollectionItem.Items.Count - 1 do with TControlItemsCollectionItem(AControlCollectionItem.Items.Items[I]) do if _SelectedItem = ItemName then if _AlsoKnownAs = _clear then _AlsoKnownAs :=
        AlsoKnownAs else _AlsoKnownAs := Y(_AlsoKnownAs, AlsoKnownAs); end);

    if _AlsoKnownAs = _clear then
      cxMControlsItemAlsoKnownAs.Lines.Text := ''
    else
      cxMControlsItemAlsoKnownAs.Lines.Text := _AlsoKnownAs;
  end;
end;

procedure TSettings.cxLBControlsItemsDblClick(Sender: TObject);
begin
  ControlsItemsEdit;
end;

procedure TSettings.cxLBControlsItemsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  FcxLBControlsItemsIndex := cxLBControlsItems.ItemAtPos(Point(X, Y), True);
  if (FcxLBControlsItemsIndex <> -1) and (FcxLBControlsItemsIndex <> cxLBControlsItems.ItemIndex) and (cxLBControlsItems.ItemIndex <> -1) then
  begin
    Accept := True;
  end
  else
    FcxLBControlsItemsIndex := -1;
end;

procedure TSettings.cxLBControlsItemsEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if FcxLBControlsItemsIndex <> -1 then
    with cxLBControlsItems do
    begin
      {
        SettingsManager.Settings.Controls.Controls[GetSelectedTemplateTypes(cxLVControlsTemplateType), TControlID(cxTCControls.TabIndex)].Items.Items[ItemIndex]
        .index := cxLBControlsItemsIndex;
        }
      Items.Move(ItemIndex, FcxLBControlsItemsIndex);
      // Items[ItemIndex].Index := cxLBControlsItemsIndex;

      Selected[FcxLBControlsItemsIndex] := True;
      // added: retain selection on dragged item

      FcxLBControlsItemsIndex := -1; // added: prevent further unwanted moves
    end;
end;

procedure TSettings.cxMControlsItemAlsoKnownAsPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  _SelectedItem: string;
begin
  if not(cxTCControls.TabIndex = -1) then
  begin
    _SelectedItem := cxLBControlsItems.Items[cxLBControlsItems.ItemIndex];

    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)var I: Integer;
      begin for I := 0 to AControlCollectionItem.Items.Count - 1 do with TControlItemsCollectionItem(AControlCollectionItem.Items.Items[I]) do if _SelectedItem = ItemName then AlsoKnownAs := cxMControlsItemAlsoKnownAs.Lines.Text; end);
  end;
end;

procedure TSettings.cxCBControlsIRichEditWrapTextPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.Controls.IRichEditWrapText := cxCBControlsIRichEditWrapText.Checked;
end;

procedure TSettings.cxSEDropDownRowsPropertiesChange(Sender: TObject);
var
  _ComboBoxIntf: IControlComboBox;
  _CheckComboBoxIntf: IControlCheckComboBox;
begin
  SettingsManager.Settings.Controls.DropDownRows := cxSEDropDownRows.Value;
  UpdateAllOpenedTabs( procedure(const AControl: IControlBasic)begin if AControl.QueryInterface(IControlComboBox, _ComboBoxIntf) = 0 then _ComboBoxIntf.DropDownRows := cxSEDropDownRows.Value;
    if AControl.QueryInterface(IControlCheckComboBox, _CheckComboBoxIntf) = 0 then _CheckComboBoxIntf.DropDownRows := cxSEDropDownRows.Value; end);
end;

procedure TSettings.cxBResetControlsClick(Sender: TObject);
begin
  with SettingsManager.Settings.Controls do
  begin
    ControlsTT.Clear;
    LoadDefaultControlValues(ControlsTT);
  end;
end;
{$ENDREGION}
{ ****************************************************************************** }
{$REGION 'HTTP'}

procedure TSettings.cxSPMaxSimultaneousConnectionsPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.MaxSimultaneousConnections := cxSPMaxSimultaneousConnections.Value;
  THTTPManager.Instance().ConnectionMaximum := cxSPMaxSimultaneousConnections.Value;
end;

procedure TSettings.cxSEConnectTimeoutPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.ConnectTimeout := cxSEConnectTimeout.Value;
end;

procedure TSettings.cxSEReadTimeoutPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.ReadTimeout := cxSEReadTimeout.Value;
end;

procedure TSettings.cxCOBProxyServerTypePropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.ProxyType := TProxyType(cxCOBProxyServerType.ItemIndex);
end;

procedure TSettings.cxTEProxyServernamePropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.Server := cxTEProxyServername.Text;
end;

procedure TSettings.cxCOBProxyServerPortPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.Port := StrToIntDef(cxCOBProxyServerPort.Text, 0);
end;

procedure TSettings.cxCGBProxyRequireAuthenticationPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.RequireAuthentication := cxCGBProxyRequireAuthentication.CheckBox.Checked;
end;

procedure TSettings.cxTEProxyAccountNamePropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.AccountName := cxTEProxyAccountName.Text;
end;

procedure TSettings.cxTEProxyAccountPasswordPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.AccountPassword := cxTEProxyAccountPassword.Text;
end;

procedure TSettings.cxCGEnableProxyAtPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.HTTP.Proxy.ProxySubActivations := TProxySubActivations(Byte(cxCGEnableProxyAt.EditValue));
end;
{$ENDREGION}
{ ****************************************************************************** }

procedure TSettings.cxSEPublishMaxCountPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.Publish.PublishMaxCount := cxSEPublishMaxCount.Value;
end;

procedure TSettings.cxSEPublishDelaybetweenUploadsPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.Publish.PublishDelaybetweenUploads := cxSEPublishDelaybetweenUploads.Value;
  UpdatePublishDelaybetweenUploadsHint;
end;

procedure TSettings.cxSERetryCountPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.Publish.RetryCount := cxSERetryCount.Value;
end;

{ ****************************************************************************** }

procedure TSettings.cxSEMaxLogEntriesPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.Log.MaxLogEntries := cxSEMaxLogEntries.Value;
end;

procedure TSettings.cxSEMaxHTTPLogEntriesPropertiesChange(Sender: TObject);
begin
  SettingsManager.Settings.Log.MaxHTTPLogEntries := cxSEMaxHTTPLogEntries.Value;
end;

{ ****************************************************************************** }
{$REGION 'TSettings'}

procedure TSettings.FormCreate(Sender: TObject);

  function internalGetTabControlTabWidth: Integer;
  begin
    Result := 0;
    with cxTCControls do
      if Tabs.Count > 0 then
        Result := (Tabs[0].FullRect.Right - Tabs[0].FullRect.Left);
  end;

var
  LTypeID: TTypeID;
  LControlID: TControlID;
begin
  Caption := StrSettings;

  FOnCrawlerContingentChange := False;

  // Need to be done here and not in SettingsManager initialization part,
  // because some APP plugins might require VCL stuff that will be loaded.
  // Later the main app is not capable to access the required packages
  // which end up in "Cannot load a RichEdit library" error or similar.
  if SettingsManager.FirstStart then
    SettingsManager.LoadDefaultPlugins;

  InitializePluginCheckListBoxes;

  // dxSkinsUserSkinPopulateSkinNames(ExtractFilePath(ParamStr(0)) + 'AllSkins.skinres', cxCOBDefaultSkin.Properties.Items);

  // for I := 1 to Ord( High(TADRDBMSKind)) - 1 do
  // cxCOBDatabaseType.Properties.Items.Add(C_AD_PhysRDBMSKinds[TADRDBMSKind(I)]);

  for LTypeID := Low(TTypeID) to High(TTypeID) do
    with cxLVControlsTemplateType.Items.Add do
      Caption := TypeIDToString(LTypeID);

  for LControlID := Low(TControlID) to High(TControlID) do
    cxTCControls.Tabs.Add(ControlIDToString(LControlID));

  SettingsManager.Settings.Layout.Settings.LoadLayout(Self);

  cxPCMain.ActivePageIndex := 0;
  cxPCPlugins.ActivePageIndex := 0;
  cxPCControls.ActivePageIndex := 0;
  cxTCControls.TabIndex := -1;

  FcxLBControlsItemsIndex := -1;

  pControlTemplateType.Left := internalGetTabControlTabWidth + 6;
  pControlTemplateType.Width := cxTCControls.Width - pControlTemplateType.Left - 6;
  pControlsSettings.Left := internalGetTabControlTabWidth + 6;
  pControlsSettings.Width := cxTCControls.Width - pControlsSettings.Left - 6;

  SetComponentStatusFromSettings;
end;

procedure TSettings.FormDestroy(Sender: TObject);

  procedure UnloadAppPlugins;
  var
    I: Integer;
  begin
    with SettingsManager.Settings.Plugins do
    begin
      with App do
      begin
        for I := 0 to Count - 1 do
        begin
          with TAppCollectionItem(Items[I]) do
            if Enabled then
              TPluginBasic.AppUnLoad(TAppCollectionItem(App.Items[I]))
        end;
      end;
    end;
  end;

begin
  UnloadAppPlugins;

  SettingsManager.Settings.Layout.Settings.SaveLayout(Self);

  FImageHosterPluginsCheckListBox.Free;
  FFileHosterPluginsCheckListBox.Free;
  FFileFormatsPluginsCheckListBox.Free;
  FCrypterPluginsCheckListBox.Free;
  FCrawlerPluginsCheckListBox.Free;
  FCMSPluginsCheckListBox.Free;
  FCAPTCHAPluginsCheckListBox.Free;
  FAppPluginsCheckListBox.Free;
end;

procedure TSettings.FormShow(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);
end;

procedure TSettings.cxCBSaveOnCloseClick(Sender: TObject);
begin
  SettingsManager.Settings.SaveOnClose := cxCBSaveOnClose.Checked;
end;

procedure TSettings.cxBExportSettingsClick(Sender: TObject);
var
  FormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings(LOCALE_USER_DEFAULT, FormatSettings);
  FormatSettings.ThousandSeparator := '-';
  FormatSettings.DecimalSeparator := '-';
  FormatSettings.DateSeparator := '-';
  FormatSettings.TimeSeparator := '-';
  FormatSettings.ListSeparator := '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yy';
  FormatSettings.ShortTimeFormat := 'hh-nn-ss';
  SettingsManager.SaveSettings;

  with TSaveDialog.Create(nil) do
    try
      Filter := 'Zip files (*.zip)|*.zip';
      FileName := 'intelligen_2009_backup_' + DateToStr(Now, FormatSettings) + '_' + TimeToStr(Now, FormatSettings) + '.zip';

      if Execute then
        with TApiSettingsExport.Create do
          try
            if not(ExtractFileExt(FileName) = '.zip') then
              FileName := FileName + '.zip';
            ExportSettings(FileName);
          finally
            Free;
          end;
    finally
      Free;
    end;
end;

procedure TSettings.cxBSaveSettingsClick(Sender: TObject);
begin
  SettingsManager.SaveSettings;

  Close;
end;
{$REGION 'App'}

procedure TSettings.AppClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);
begin
  if (ANewState = cbsUnchecked) then
  begin
    try
      TPluginBasic.AppUnLoad(TAppCollectionItem(SettingsManager.Settings.Plugins.App.Items[AIndex]));
    except
      on E: Exception do
      begin
        ANewState := cbsChecked;
        TcxCheckListBox(Sender).Items[AIndex].State := cbsChecked;
        MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end;
  end
  else
  begin
    try
      TPluginBasic.AppLoad(TAppCollectionItem(SettingsManager.Settings.Plugins.App.Items[AIndex]), Main);
    except
      on E: Exception do
      begin
        ANewState := cbsUnchecked;
        TcxCheckListBox(Sender).Items[AIndex].State := cbsUnchecked;
        MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end;
  end;

  TPlugInCollectionItem(SettingsManager.Settings.Plugins.App.Items[AIndex]).Enabled := (ANewState = cbsChecked);
end;

procedure TSettings.AddAppClick(Sender: TObject);
begin
  TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptApp);
end;

procedure TSettings.AppAddAllClick(Sender: TObject);
begin
  TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptApp);
end;

procedure TSettings.RemoveAppClick(Sender: TObject);
begin
  with TAppCollectionItem(SettingsManager.Settings.Plugins.App.Items[FAppPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
  begin
    if Enabled then
      TPluginBasic.AppUnLoad(TAppCollectionItem(SettingsManager.Settings.Plugins.App.Items[FAppPluginsCheckListBox.InnerCheckListBox.ItemIndex]));
    Free;
  end;
end;
{$ENDREGION}
{$REGION 'CAPTCHA'}

procedure TSettings.CAPTCHAClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.CAPTCHA.Items[AIndex]).Enabled := (ANewState = cbsChecked);
end;

procedure TSettings.CAPTCHAEndDrag(Sender: TObject; OldIndex: Integer; NewIndex: Integer);
begin
  SettingsManager.Settings.Plugins.CAPTCHA.Items[OldIndex].index := NewIndex;
end;

procedure TSettings.CAPTCHAAddClick(Sender: TObject);
begin
  TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptCAPTCHA);
end;

procedure TSettings.CAPTCHAAddAllClick(Sender: TObject);
begin
  TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptCAPTCHA);
end;

procedure TSettings.RemoveCAPTCHAClick(Sender: TObject);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.CAPTCHA.Items[FCAPTCHAPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
end;
{$ENDREGION}
{$REGION 'CMS'}

procedure TSettings.CMSClick(Sender: TObject);
var
  I: Integer;
begin
  fAddWebsiteWizard.cxBCancel.Visible := False;
  fAddWebsiteWizard.Visible := FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex = -1;
  pCMSSettings.Visible := not fAddWebsiteWizard.Visible;

  if FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1 then
    with TCMSCollectionItem(SettingsManager.Settings.Plugins.CMS.Items[FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    begin
      with cxGCMSTableView1.DataController do
      begin
        // Required to disable OnDataChanged in order to update the table without
        // making the OnDataChanged call. Otherwise Invoke calls will be triggered.
        OnDataChanged := nil;

        BeginUpdate;
        try
          RecordCount := Websites.Count;

          for I := 0 to Websites.Count - 1 do
          begin
            Values[I, cxGCMSTableView1Column1.index] := TCMSWebsitesCollectionItem(Websites.Items[I]).Enabled;
            Values[I, cxGCMSTableView1Column2.index] := TCMSWebsitesCollectionItem(Websites.Items[I]).name;
            Values[I, cxGCMSTableView1Column3.index] := TCMSWebsitesCollectionItem(Websites.Items[I]).AccountName;
            Values[I, cxGCMSTableView1Column4.index] := TCMSWebsitesCollectionItem(Websites.Items[I]).AccountPassword;
            Values[I, cxGCMSTableView1Column5.index] := TCMSWebsitesCollectionItem(Websites.Items[I]).SubjectFileName;
            Values[I, cxGCMSTableView1Column6.index] := TCMSWebsitesCollectionItem(Websites.Items[I]).MessageFileName;
          end;
        finally
          EndUpdate;
        end;

        // Reset the OnDataChanged!
        OnDataChanged := cxGCMSTableView1DataControllerDataChanged;
      end;

      SetCMSCheckAllStatus;

      RefreshAccountlist;
    end;
end;

procedure TSettings.CMSClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);
begin
  with SettingsManager.Settings.Plugins do
  begin
    with TPlugInCollectionItem(CMS.Items[AIndex]) do
    begin
      Enabled := (ANewState = cbsChecked);
    end;
    if Assigned(OnCMSChange) then
      OnCMSChange.Invoke(pctEnabled, AIndex, Byte(ANewState));
  end;
end;

procedure TSettings.CMSEndDrag(Sender: TObject; OldIndex: Integer; NewIndex: Integer);
begin
  with SettingsManager.Settings.Plugins do
  begin
    CMS.Items[OldIndex].index := NewIndex;
    if Assigned(OnCMSChange) then
      OnCMSChange.Invoke(pctMove, NewIndex, -1);
  end;
end;

procedure TSettings.AddCMSClick(Sender: TObject);
begin
  if TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptCMS) then
  begin
    CMSClick(nil);
    // Main.fPublish.GenerateColumns;
  end;
end;

procedure TSettings.CMSAddAllClick(Sender: TObject);
begin
  if TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptCMS) then
  begin
    CMSClick(nil);
    // Main.fPublish.GenerateColumns;
  end;
end;

procedure TSettings.RemoveCMSClick(Sender: TObject);
begin
  with SettingsManager.Settings.Plugins do
  begin
    if Assigned(OnCMSChange) then
      OnCMSChange.Invoke(pctDelete, FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex, -1);
    TPlugInCollectionItem(CMS.Items[FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
  end;
  fAddWebsiteWizard.cxBCancel.Visible := False;

  // Main.fPublish.GenerateColumns;
end;

procedure TSettings.RemovedCMSClick(Sender: TObject);
begin
  fAddWebsiteWizard.Visible := FCMSPluginsCheckListBox.InnerCheckListBox.ItemIndex = -1;
  pCMSSettings.Visible := not fAddWebsiteWizard.Visible;
end;
{$ENDREGION}
{$REGION 'Crawler'}

procedure TSettings.CrawlerClick(Sender: TObject);
var
  I, X: Integer;
  ContingentList: TStringList;
  NewContingentItem: string;
  CustomDataController: TcxCustomDataController;
begin
  pCrawlerSettings.Visible := FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;

  if FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1 then
  begin
    FOnCrawlerContingentChange := True;

    ContingentList := TStringList.Create;
    try
      with TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
        for I := 0 to Contingent.Count - 1 do
        begin
          NewContingentItem := TypeIDToString(TCrawlerContingentCollectionItem(Contingent.Items[I]).TypeID);
          if ContingentList.IndexOf(NewContingentItem) = -1 then
            ContingentList.Add(NewContingentItem);
        end;

      with cxGCrawlerTableView1.DataController do
      begin
        BeginUpdate;
        try
          RecordCount := ContingentList.Count;
          for I := 0 to RecordCount - 1 do
            Values[I, cxGCrawlerTableView1Column1.index] := ContingentList.Strings[I];
        finally
          EndUpdate;
        end;
      end;
    finally
      ContingentList.Free;
    end;

    with cxGCrawlerTableView1.DataController do
    begin
      for I := 0 to RecordCount - 1 do
      begin
        ContingentList := TStringList.Create;
        try
          with TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
            for X := 0 to Contingent.Count - 1 do
              if SameText(TypeIDToString(TCrawlerContingentCollectionItem(Contingent.Items[X]).TypeID), Values[I, cxGCrawlerTableView1Column1.index]) then
                ContingentList.Add(ControlIDToReadableString(TCrawlerContingentCollectionItem(Contingent.Items[X]).ControlID) + '=' + BoolToStr(TCrawlerContingentCollectionItem(Contingent.Items[X]).Status));

          CustomDataController := GetDetailDataController(I, 0);
          with CustomDataController do
          begin
            BeginUpdate;
            try
              RecordCount := ContingentList.Count;

              for X := 0 to RecordCount - 1 do
              begin
                Values[X, cxGCrawlerTableView2Column1.index] := ContingentList.Names[X];
                Values[X, cxGCrawlerTableView2Column2.index] := StrToBool(ContingentList.ValueFromIndex[X]);
              end;

            finally
              EndUpdate;
            end;
          end;
        finally
          ContingentList.Free;
        end;
      end;
    end;

    FOnCrawlerContingentChange := False;

    with TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
      cxSELimit.Value := Limit;
  end;
end;

procedure TSettings.CrawlerClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);
begin
  with TPlugInCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[AIndex]) do
  begin
    Enabled := (ANewState = cbsChecked);
  end;
end;

procedure TSettings.CrawlerEndDrag(Sender: TObject; OldIndex: Integer; NewIndex: Integer);
begin
  SettingsManager.Settings.Plugins.Crawler.Items[OldIndex].index := NewIndex;
end;

procedure TSettings.AddCrawlerClick(Sender: TObject);
begin
  if TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptCrawler) then
    CrawlerClick(nil);
end;

procedure TSettings.CrawlerAddAllClick(Sender: TObject);
begin
  if TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptCrawler) then
    CrawlerClick(nil);
end;

procedure TSettings.RemoveCrawlerClick(Sender: TObject);
begin
  TCrawlerCollectionItem(SettingsManager.Settings.Plugins.Crawler.Items[FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
end;

procedure TSettings.RemovedCrawlerClick(Sender: TObject);
begin
  pCrawlerSettings.Visible := FCrawlerPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;
end;
{$ENDREGION}
{$REGION 'Crypter'}

procedure TSettings.CrypterClick(Sender: TObject);
var
  NotifyEvent: TNotifyEvent;
begin
  pCrypterSettings.Visible := FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;

  if FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1 then
    with TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    begin
      cxTECrypterAccountName.Text := AccountName;
      cxTECrypterAccountPassword.Text := AccountPassword;
      cxCBCrypterUseAccount.Checked := UseAccount;

      with cxCGCrypterFoldertypes do
      begin
        NotifyEvent := Properties.OnChange;
        Properties.OnChange := nil;
        if (ftWeb in Foldertypes) then
          States[0] := cbsChecked
        else
          States[0] := cbsUnchecked;
        if (ftPlain in Foldertypes) then
          States[1] := cbsChecked
        else
          States[1] := cbsUnchecked;
        if (ftContainer in Foldertypes) then
          States[2] := cbsChecked
        else
          States[2] := cbsUnchecked;
        Properties.OnChange := NotifyEvent;
      end;

      with cxCGCrypterContainerTypes do
      begin
        NotifyEvent := Properties.OnChange;
        Properties.OnChange := nil;
        if (ctCCF in ContainerTypes) then
          States[0] := cbsChecked
        else
          States[0] := cbsUnchecked;
        if (ctDLC in ContainerTypes) then
          States[1] := cbsChecked
        else
          States[1] := cbsUnchecked;
        if (ctRSDF in ContainerTypes) then
          States[2] := cbsChecked
        else
          States[2] := cbsUnchecked;
        Properties.OnChange := NotifyEvent;
      end;

      cxCBCrypterUseCaptcha.Checked := UseCaptcha;
      cxCOBCrypterFolderName.ItemIndex := Max(0, Integer(FolderName));

      cxCBCrypterUseCoverLink.Checked := UseCoverLink;
      cxCBCrypterUseDescription.Checked := UseDescription;
      cxCBCrypterUseCNL.Checked := UseCNL;
      cxCBCrypterUseFilePassword.Checked := UseFilePassword;
      cxTECrypterWebseiteLink.Text := WebseiteLink;
      cxCBCrypterUseWebseiteLink.Checked := UseWebseiteLink;

      cxTECrypterEMailforStatusNotice.Text := EMailforStatusNotice;
      cxCBCrypterUseEMailforStatusNotice.Checked := UseEMailforStatusNotice;
      cxTECrypterAdminpassword.Text := AdminPassword;
      cxCBCrypterUseAdminpassword.Checked := UseAdminPassword;
      cxTECrypterVisitorpassword.Text := VisitorPassword;
      cxCBCrypterUseVisitorpassword.Checked := UseVisitorPassword;

      cxTBCrypterCheckDelay.Position := CheckDelay;

      cxPCCrypterAdvertisment.ActivePageIndex := Max(0, Integer(AdvertismentType));
      cxTECrypterAdvertismentLayerName.Text := AdvertismentLayerName;
      cxTECrypterAdvertismentLayerValue.Text := AdvertismentLayerValue;
      cxTECrypterAdvertismentLink.Text := AdvertismentLink;
      cxCBCrypterAdvertismentLink.Checked := UseAdvertismentLink;
      cxTECrypterAdvertismentBannerPicture.Text := AdvertismentPicture;
      cxCBCrypterAdvertismentBannerPicture.Checked := UseAdvertismentPicture;
    end;
end;

procedure TSettings.CrypterClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);

  procedure CrypterUpdate(APageController: IPageController; ACrypter: TCrypterCollectionItem);
  var
    I, J, K: Integer;
  begin
    for I := 0 to APageController.TabSheetCount - 1 do
      for J := 0 to APageController.TabSheetController[I].MirrorController.MirrorCount - 1 do
        with APageController.TabSheetController[I].MirrorController.Mirror[J] do
          case ACrypter.Enabled of
            True:
              AddCrypter(ACrypter.name);
            False:
              begin
                for K := 0 to CrypterCount - 1 do
                  if Crypter[K].name = ACrypter.name then
                  begin
                    RemoveCrypter(K);
                    break;
                  end;
              end;
          end;
  end;

begin
  with TPlugInCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[AIndex]) do
  begin
    Enabled := (ANewState = cbsChecked);
  end;
  CrypterUpdate(Main.fMain, TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[AIndex]));

  if ANewState = cbsUnchecked then
    cxcobDefaultMirrorTabIndexItemsRefresh;
end;

procedure TSettings.CrypterEndDrag(Sender: TObject; OldIndex: Integer; NewIndex: Integer);
begin
  SettingsManager.Settings.Plugins.Crypter.Items[OldIndex].index := NewIndex;
end;

procedure TSettings.AddCrypterClick(Sender: TObject);
begin
  if TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptCrypter) then
    CrypterClick(nil);
end;

procedure TSettings.CrypterAddAllClick(Sender: TObject);
begin
  if TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptCrypter) then
    CrypterClick(nil);
end;

procedure TSettings.RemoveCrypterClick(Sender: TObject);
begin
  TCrypterCollectionItem(SettingsManager.Settings.Plugins.Crypter.Items[FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
end;

procedure TSettings.RemovedCrypterClick(Sender: TObject);
begin
  pCrypterSettings.Visible := FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;
end;
{$ENDREGION}
{$REGION 'FileFormats'}

procedure TSettings.FileFormatsClick(Sender: TObject);
begin
  pFileFormatsSettings.Visible := FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;

  if FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1 then
    with TFileFormatsCollectionItem(SettingsManager.Settings.Plugins.FileFormats.Items[FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    begin
      cxCBFileFormatsForceAddCrypter.Checked := ForceAddCrypter;
      cxCBFileFormatsForceAddImageMirror.Checked := ForceAddImageMirror;
    end;
end;

procedure TSettings.FileFormatsClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.FileFormats.Items[AIndex]).Enabled := (ANewState = cbsChecked);
end;

procedure TSettings.FileFormatsEndDrag(Sender: TObject; OldIndex: Integer; NewIndex: Integer);
begin
  SettingsManager.Settings.Plugins.FileFormats.Items[OldIndex].index := NewIndex;
end;

procedure TSettings.FileFormatsAddClick(Sender: TObject);
begin
  if TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptFileFormats) then
    FileFormatsClick(nil);
end;

procedure TSettings.FileFormatsAddAllClick(Sender: TObject);
begin
  if TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptFileFormats) then
    FileFormatsClick(nil);
end;

procedure TSettings.RemoveFileFormatsClick(Sender: TObject);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.FileFormats.Items[FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
end;

procedure TSettings.RemovedFileFormatsClick(Sender: TObject);
begin
  pFileFormatsSettings.Visible := FFileFormatsPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;
end;
{$ENDREGION}
{$REGION 'FileHoster'}

procedure TSettings.FileHosterClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.FileHoster.Items[AIndex]).Enabled := (ANewState = cbsChecked);
end;

procedure TSettings.FileHosterAddClick(Sender: TObject);
begin
  TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptFileHoster);
end;

procedure TSettings.FileHosterAddAllClick(Sender: TObject);
begin
  TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptFileHoster);
end;

procedure TSettings.RemoveFileHosterClick(Sender: TObject);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.FileHoster.Items[FFileHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
end;
{$ENDREGION}
{$REGION 'ImageHoster'}

procedure TSettings.ImageHosterClick(Sender: TObject);
begin
  pImageHosterSettings.Visible := FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;

  if FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1 then
  begin
    with TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]) do
    begin
      cxTEImageHosterAccountName.Text := AccountName;
      cxTEImageHosterAccountPassword.Text := AccountPassword;
      cxCBImageHosterUseAccount.Checked := UseAccount;
      cxCOBImageHosterResize.ItemIndex := Integer(ImageHostResize);
      cxCBImageHosterUploadAfterCrawling.Checked := UploadAfterCrawling;
    end;
  end;
end;

procedure TSettings.ImageHosterClickCheck(Sender: TObject; AIndex: Integer; APrevState: TcxCheckBoxState; ANewState: TcxCheckBoxState);

  procedure ImageHosterUpdate(APageController: IPageController; AImageHoster: TImageHosterCollectionItem);
  var
    I, K: Integer;
    Picture: IPicture;
  begin
    for I := 0 to APageController.TabSheetCount - 1 do
    begin
      Picture := APageController.TabSheetController[I].ControlController.FindControl(cPicture) as IPicture;
      if Assigned(Picture) then
        with Picture do
          case AImageHoster.Enabled of
            True:
              AddMirror(AImageHoster.Name);
            False:
              begin
                for K := 0 to MirrorCount - 1 do
                  if Mirror[K].name = AImageHoster.Name then
                  begin
                    RemoveMirror(K);
                    break;
                  end;
              end;
          end;
      Picture := nil;
    end;
  end;

begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[AIndex]).Enabled := (ANewState = cbsChecked);
  ImageHosterUpdate(Main.fMain, TImageHosterCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[AIndex]));
end;

procedure TSettings.ImageHosterEndDrag(Sender: TObject; OldIndex, NewIndex: Integer);
begin
  SettingsManager.Settings.Plugins.ImageHoster.Items[OldIndex].index := NewIndex;
end;

procedure TSettings.ImageHosterAddClick(Sender: TObject);
begin
  if TAddPlugin.Execute(GetDefaultPluginLoadedFunc, ptImageHoster) then
    ImageHosterClick(nil);
end;

procedure TSettings.ImageHosterAddAllClick(Sender: TObject);
begin
  if TAddPlugin.ExecuteFolder(GetDefaultPluginLoadedFunc, GetPluginFolder, ptImageHoster) then
    ImageHosterClick(nil);
end;

procedure TSettings.RemoveImageHosterClick(Sender: TObject);
begin
  TPlugInCollectionItem(SettingsManager.Settings.Plugins.ImageHoster.Items[FImageHosterPluginsCheckListBox.InnerCheckListBox.ItemIndex]).Free;
end;

procedure TSettings.RemovedImageHosterClick(Sender: TObject);
begin
  pImageHosterSettings.Visible := FCrypterPluginsCheckListBox.InnerCheckListBox.ItemIndex <> -1;
end;
{$ENDREGION}

procedure TSettings.InitializePluginCheckListBoxes;
begin
  FAppPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FAppPluginsCheckListBox do
  begin
    Parent := cxTSApp;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.AppImageList;
    end;

    OnClickCheck := AppClickCheck;
    OnAddPluginClick := AddAppClick;
    OnAddAllPluginClick := AppAddAllClick;
    OnRemovePluginClick := RemoveAppClick;
  end;

  FCAPTCHAPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FCAPTCHAPluginsCheckListBox do
  begin
    Parent := cxTSCAPTCHA;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    DragDrop := True;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.CAPTCHAImageList;
    end;

    OnClickCheck := CAPTCHAClickCheck;
    OnEndDrag := CAPTCHAEndDrag;
    OnAddPluginClick := CAPTCHAAddClick;
    OnAddAllPluginClick := CAPTCHAAddAllClick;
    OnRemovePluginClick := RemoveCAPTCHAClick;
  end;

  FCMSPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FCMSPluginsCheckListBox do
  begin
    Parent := cxTSCMS;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    DragDrop := True;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.CMSImageList;
    end;

    OnClick := CMSClick;
    OnClickCheck := CMSClickCheck;
    OnEndDrag := CMSEndDrag;
    OnAddPluginClick := AddCMSClick;
    OnAddAllPluginClick := CMSAddAllClick;
    OnRemovePluginClick := RemoveCMSClick;
    OnRemovedPluginClick := RemovedCMSClick
  end;

  FCrawlerPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FCrawlerPluginsCheckListBox do
  begin
    Parent := cxTSCrawler;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    DragDrop := True;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.CrawlerImageList;
    end;

    OnClick := CrawlerClick;
    OnClickCheck := CrawlerClickCheck;
    OnEndDrag := CrawlerEndDrag;
    OnAddPluginClick := AddCrawlerClick;
    OnAddAllPluginClick := CrawlerAddAllClick;
    OnRemovePluginClick := RemoveCrawlerClick;
    OnRemovedPluginClick := RemovedCrawlerClick;
  end;

  FCrypterPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FCrypterPluginsCheckListBox do
  begin
    Parent := cxTSCrypter;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    DragDrop := True;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.CrypterImageList;
    end;

    OnClick := CrypterClick;
    OnClickCheck := CrypterClickCheck;
    OnEndDrag := CrypterEndDrag;
    OnAddPluginClick := AddCrypterClick;
    OnAddAllPluginClick := CrypterAddAllClick;
    OnRemovePluginClick := RemoveCrypterClick;
    OnRemovedPluginClick := RemovedCrypterClick;
  end;

  FFileFormatsPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FFileFormatsPluginsCheckListBox do
  begin
    Parent := cxTSFileFormats;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    DragDrop := True;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.FileFormatsImageList;
    end;

    OnClick := FileFormatsClick;
    OnClickCheck := FileFormatsClickCheck;
    OnEndDrag := FileFormatsEndDrag;
    OnAddPluginClick := FileFormatsAddClick;
    OnAddAllPluginClick := FileFormatsAddAllClick;
    OnRemovePluginClick := RemoveFileFormatsClick;
    OnRemovedPluginClick := RemovedFileFormatsClick;
  end;

  FFileHosterPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FFileHosterPluginsCheckListBox do
  begin
    Parent := cxTSFileHoster;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.FileHosterImageList;
    end;

    OnClickCheck := FileHosterClickCheck;
    OnAddPluginClick := FileHosterAddClick;
    OnAddAllPluginClick := FileHosterAddAllClick;
    OnRemovePluginClick := RemoveFileHosterClick;
  end;

  FImageHosterPluginsCheckListBox := TPluginsCheckListBox.Create(Self);
  with FImageHosterPluginsCheckListBox do
  begin
    Parent := cxTSImageHoster;

    Left := 16;
    Top := 16;
    Width := 129;
    Height := 262;

    DragDrop := True;

    with InnerCheckListBox do
    begin
      Images := SettingsManager.Settings.Plugins.ImageHosterImageList;
    end;

    OnClick := ImageHosterClick;
    OnClickCheck := ImageHosterClickCheck;
    OnEndDrag := ImageHosterEndDrag;
    OnAddPluginClick := ImageHosterAddClick;
    OnAddAllPluginClick := ImageHosterAddAllClick;
    OnRemovePluginClick := RemoveImageHosterClick;
    OnRemovedPluginClick := RemovedImageHosterClick;
  end;
end;

function TSettings.GetDefaultPluginLoadedFunc(const APluginType: TPlugInType; var ACollection: TCollection; var ACheckListBox: TcxCheckListBox): Boolean;
begin
  SettingsManager.GetDefaultPluginLoadedFunc(APluginType, ACollection, ACheckListBox);

  case APluginType of
    ptNone:
      Exit(False);
    ptApp:
      ACheckListBox := FAppPluginsCheckListBox.InnerCheckListBox;
    ptCAPTCHA:
      ACheckListBox := FCAPTCHAPluginsCheckListBox.InnerCheckListBox;
    ptCMS:
      ACheckListBox := FCMSPluginsCheckListBox.InnerCheckListBox;
    ptCrawler:
      ACheckListBox := FCrawlerPluginsCheckListBox.InnerCheckListBox;
    ptCrypter:
      ACheckListBox := FCrypterPluginsCheckListBox.InnerCheckListBox;
    ptFileFormats:
      ACheckListBox := FFileFormatsPluginsCheckListBox.InnerCheckListBox;
    ptFileHoster:
      ACheckListBox := FFileHosterPluginsCheckListBox.InnerCheckListBox;
    ptImageHoster:
      ACheckListBox := FImageHosterPluginsCheckListBox.InnerCheckListBox;
  end;

  Result := True;
end;

function TSettings.GetCMSCheckAllStatus;
var
  LRecordCount: Integer;
  LStatus: Byte; // 0 = Unchecked, 1 = Checked, 3 = Grayed, 255 = Undefined
begin
  LStatus := 255;

  with cxGCMSTableView1.DataController do
    for LRecordCount := 0 to RecordCount - 1 do
    begin
      case Values[LRecordCount, cxGCMSTableView1Column1.index] of
        0:
          if (LStatus = 255) or (LStatus = 0) then
            LStatus := 0
          else
            LStatus := 2;
      else
        if (LStatus = 255) or (LStatus = 1) then
          LStatus := 1
        else
          LStatus := 2;
      end;
    end;
  if (LStatus = 255) then
    LStatus := 2;

  Result := LStatus;
end;

procedure TSettings.SetCMSCheckAllStatus;
var
  LEvent: TNotifyEvent;
begin
  with cxCBCMSAll do
  begin
    LEvent := Properties.OnChange;
    Properties.OnChange := nil;

    case GetCMSCheckAllStatus of
      0:
        State := cbsUnchecked;
      1:
        State := cbsChecked;
    else
      State := cbsGrayed;
    end;

    Properties.OnChange := LEvent;
  end;
end;

procedure TSettings.SetComponentStatusFromSettings;
var
  I: Integer;
  StringList: TStrings;
begin
  cxCBSaveOnClose.Checked := SettingsManager.Settings.SaveOnClose;

  cxcbNativeStyle.Checked := SettingsManager.Settings.NativeStyle;
  cxcbUseSkins.Enabled := not cxcbNativeStyle.Checked;
  cxcbUseSkins.Checked := SettingsManager.Settings.UseSkins;
  cxCOBDefaultSkin.ItemIndex := cxCOBDefaultSkin.Properties.Items.IndexOf(SettingsManager.Settings.DefaultSkin);
  cxcbCheckForUpdates.Checked := SettingsManager.Settings.CheckForUpdates;
  cxCOBCAPTCHAPosition.ItemIndex := Integer(SettingsManager.Settings.CAPTCHAPosition);

  with SettingsManager.Settings.Plugins do
  begin
    with App do
    begin
      for I := 0 to Count - 1 do
      begin
        with FAppPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          ImageIndex := FAppPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;

          if Enabled and Checked then
          begin
            try
              TPluginBasic.AppLoad(TAppCollectionItem(Items[I]), Main);
            except
              on E: Exception do
              begin
                TPlugInCollectionItem(Items[I]).Enabled := False;
                Checked := False;
                MessageDlg(E.Message, mtError, [mbOK], 0);
              end;
            end;
          end;
        end;
      end;
    end;
    with CAPTCHA do
    begin
      for I := 0 to Count - 1 do
      begin
        with FCAPTCHAPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          // ImageIndex := FCAPTCHAPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;

    with CMS do
    begin
      FCMSPluginsCheckListBox.InnerCheckListBox.Items.Clear;
      for I := 0 to Count - 1 do
      begin
        with FCMSPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          ImageIndex := FCMSPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;
    with Crawler do
    begin
      FCrawlerPluginsCheckListBox.InnerCheckListBox.Items.Clear;
      for I := 0 to Count - 1 do
      begin
        with FCrawlerPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          // ImageIndex := FCrawlerPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;
    with Crypter do
    begin
      FCrypterPluginsCheckListBox.InnerCheckListBox.Items.Clear;
      for I := 0 to Count - 1 do
      begin
        with FCrypterPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          ImageIndex := FCrypterPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;

    with FileFormats do
    begin
      for I := 0 to Count - 1 do
      begin
        with FFileFormatsPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          // ImageIndex := FFileFormatsPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;
    with FileHoster do
    begin
      for I := 0 to Count - 1 do
      begin
        with FFileHosterPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          ImageIndex := FFileHosterPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;
    with ImageHoster do
    begin
      for I := 0 to Count - 1 do
      begin
        with FImageHosterPluginsCheckListBox.InnerCheckListBox.Items.Add do
        begin
          Checked := TPlugInCollectionItem(Items[I]).Enabled;
          Text := TPlugInCollectionItem(Items[I]).name;
          ImageIndex := FImageHosterPluginsCheckListBox.InnerCheckListBox.Images.AddIcon(TPlugInCollectionItem(Items[I]).Icon);

          if not FileExists(TPlugInCollectionItem(Items[I]).GetPath) then
            Enabled := False;
        end;
      end;
    end;
  end;

  with SettingsManager.Settings.Database.Database do
  begin
    for I := 0 to Count - 1 do
    begin
      with cxCLBDatabase.Items.Add do
      begin
        Checked := TDatabaseCollectionItem(Items[I]).Enabled;
        Text := TDatabaseCollectionItem(Items[I]).name;
      end;
    end;
  end;

  cxSEMirrorCount.Value := SettingsManager.Settings.ControlAligner.MirrorCount;
  cxSEMirrorColumns.Value := SettingsManager.Settings.ControlAligner.MirrorColumns;
  cxSEMirrorHeight.Value := SettingsManager.Settings.ControlAligner.MirrorHeight;
  cxCOBMirrorPosition.ItemIndex := Integer(SettingsManager.Settings.ControlAligner.MirrorPosition);
  cxCOBDirectlinksView.ItemIndex := Integer(SettingsManager.Settings.ControlAligner.DirectlinksView);
  cxcobDefaultMirrorTabIndexItemsRefresh(True);
  cxCBModyBeforeCrypt.Checked := SettingsManager.Settings.ControlAligner.ModyBeforeCrypt;
  cxCBSwichAfterCrypt.Checked := SettingsManager.Settings.ControlAligner.SwichAfterCrypt;
  cxCBDefaultStartupAActive.Checked := SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveA;
  cxCBDefaultStartupBActive.Checked := SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveB;
  cxCBDefaultStartupCActive.Checked := SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveC;
  cxCBDefaultStartupDActive.Checked := SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveD;
  cxCBDefaultStartupEActive.Checked := SettingsManager.Settings.ControlAligner.DefaultStartup.ActiveE;
  StringList := GetTemplateList;
  try
    cxCOBDefaultStartupAType.Properties.Items.Text := StringList.Text;
    cxCOBDefaultStartupBType.Properties.Items.Text := StringList.Text;
    cxCOBDefaultStartupCType.Properties.Items.Text := StringList.Text;
    cxCOBDefaultStartupDType.Properties.Items.Text := StringList.Text;
    cxCOBDefaultStartupEType.Properties.Items.Text := StringList.Text;
  finally
    StringList.Free;
  end;
  cxCOBDefaultStartupAType.Text := SettingsManager.Settings.ControlAligner.DefaultStartup.TypeA;
  cxCOBDefaultStartupBType.Text := SettingsManager.Settings.ControlAligner.DefaultStartup.TypeB;
  cxCOBDefaultStartupCType.Text := SettingsManager.Settings.ControlAligner.DefaultStartup.TypeC;
  cxCOBDefaultStartupDType.Text := SettingsManager.Settings.ControlAligner.DefaultStartup.TypeD;
  cxCOBDefaultStartupEType.Text := SettingsManager.Settings.ControlAligner.DefaultStartup.TypeE;

  THTTPManager.Instance().ConnectionMaximum := SettingsManager.Settings.HTTP.MaxSimultaneousConnections;
  cxSPMaxSimultaneousConnections.Value := SettingsManager.Settings.HTTP.MaxSimultaneousConnections;
  cxSEConnectTimeout.Value := SettingsManager.Settings.HTTP.ConnectTimeout;
  cxSEReadTimeout.Value := SettingsManager.Settings.HTTP.ReadTimeout;
  cxCOBProxyServerType.ItemIndex := Integer(SettingsManager.Settings.HTTP.Proxy.ProxyType);
  cxTEProxyServername.Text := SettingsManager.Settings.HTTP.Proxy.Server;
  cxCOBProxyServerPort.Text := IntToStr(SettingsManager.Settings.HTTP.Proxy.Port);
  cxCGBProxyRequireAuthentication.CheckBox.Checked := SettingsManager.Settings.HTTP.Proxy.RequireAuthentication;
  cxTEProxyAccountName.Text := SettingsManager.Settings.HTTP.Proxy.AccountName;
  cxTEProxyAccountPassword.Text := SettingsManager.Settings.HTTP.Proxy.AccountPassword;
  cxCGEnableProxyAt.EditValue := Byte(SettingsManager.Settings.HTTP.Proxy.ProxySubActivations);

  cxCBControlsIRichEditWrapText.Checked := SettingsManager.Settings.Controls.IRichEditWrapText;
  cxSEDropDownRows.Value := SettingsManager.Settings.Controls.DropDownRows;

  cxSEPublishMaxCount.Value := SettingsManager.Settings.Publish.PublishMaxCount;
  cxSEPublishDelaybetweenUploads.Value := SettingsManager.Settings.Publish.PublishDelaybetweenUploads;
  UpdatePublishDelaybetweenUploadsHint;
  cxSERetryCount.Value := SettingsManager.Settings.Publish.RetryCount;

  cxSEMaxLogEntries.Value := SettingsManager.Settings.Log.MaxLogEntries;
  cxSEMaxHTTPLogEntries.Value := SettingsManager.Settings.Log.MaxHTTPLogEntries;
end;

procedure TSettings.AddCMSWebsite(const AFileName, AWebsiteName, AWebsiteType: string);

  function FindRecordIndexByText(const AText: string): Integer;
  var
    LRecordIndex: Integer;
  begin
    Result := -1;

    with cxGCMSTableView1.DataController do
    begin
      for LRecordIndex := 0 to RecordCount - 1 do
        if SameText(Values[LRecordIndex, cxGCMSTableView1Column2.Index], AText) then
        begin
          Result := LRecordIndex;
          break;
        end;
    end;
  end;

var
  LCMSCollectionItem: TCMSCollectionItem;
  LCMSWebsitesCollectionItem: TCMSWebsitesCollectionItem;
  LOverrideWebsite: Boolean;
  LRecordIndex: Integer;
begin
  LOverrideWebsite := False;
  try
    with SettingsManager.Settings.Plugins do
      LCMSCollectionItem := TCMSCollectionItem(FindPlugInCollectionItemFromCollection(AWebsiteType, CMS));

    with LCMSCollectionItem do
    begin
      LCMSWebsitesCollectionItem := FindCMSWebsite(AWebsiteName);

      if not Assigned(LCMSWebsitesCollectionItem) then
        LCMSWebsitesCollectionItem := TCMSWebsitesCollectionItem(Websites.Add)
      else if (MessageDlg(Format('Override "%s"?', [AWebsiteName]), mtConfirmation, [mbyes, mbno, mbcancel], 0) = ID_YES) then
        LOverrideWebsite := True
      else
        Exit;
    end;
  except
    raise Exception.Create('Failed to allocate cms');
  end;

  with LCMSWebsitesCollectionItem do
  begin
    Enabled := False;
    Name := AWebsiteName;
    Path := ExtractRelativePath(GetTemplatesSiteFolder, AFileName);
  end;

  LCMSCollectionItem.UpdateWebsite(LCMSWebsitesCollectionItem.Index);

  with LCMSCollectionItem do
    if Assigned(OnSettingsChange) and not LOverrideWebsite then
      OnSettingsChange.Invoke(cctAdd, LCMSWebsitesCollectionItem.Index, -1);

  with FCMSPluginsCheckListBox.InnerCheckListBox do
    if (ItemIndex <> -1) and (Items[ItemIndex].Text = AWebsiteType) then
    begin
      if LOverrideWebsite then
        LRecordIndex := FindRecordIndexByText(AWebsiteName);

      with cxGCMSTableView1.DataController do
      begin
        BeginUpdate;
        try
          if not LOverrideWebsite then
          begin
            RecordCount := RecordCount + 1;
            LRecordIndex := RecordCount - 1;
          end;

          Values[LRecordIndex, cxGCMSTableView1Column1.index] := LCMSWebsitesCollectionItem.Enabled;
          Values[LRecordIndex, cxGCMSTableView1Column2.index] := LCMSWebsitesCollectionItem.Name;
          Values[LRecordIndex, cxGCMSTableView1Column3.index] := LCMSWebsitesCollectionItem.AccountName;
          Values[LRecordIndex, cxGCMSTableView1Column4.index] := LCMSWebsitesCollectionItem.AccountPassword;
          Values[LRecordIndex, cxGCMSTableView1Column5.index] := LCMSWebsitesCollectionItem.SubjectFileName;
          Values[LRecordIndex, cxGCMSTableView1Column6.index] := LCMSWebsitesCollectionItem.MessageFileName;
        finally
          EndUpdate;
        end;
      end;

      SetCMSCheckAllStatus;
    end;
end;

procedure TSettings.RefreshAccountlist;
var
  I, J: Integer;
  _accountname: string;
begin
  TcxComboBoxProperties(cxGCMSTableView1Column3.Properties).Items.Clear;

  with SettingsManager.Settings.Plugins.CMS do
    for I := 0 to Count - 1 do
      for J := 0 to TCMSCollectionItem(Items[I]).Websites.Count - 1 do
      begin
        _accountname := TCMSWebsitesCollectionItem(TCMSCollectionItem(Items[I]).Websites.Items[J]).AccountName;
        if (not(_accountname = '')) and ((cxGCMSTableView1Column3.Properties as TcxComboBoxProperties).Items.IndexOf(_accountname) = -1) then (cxGCMSTableView1Column3.Properties as TcxComboBoxProperties)
          .Items.Add(_accountname);
      end;
end;

procedure TSettings.cxcobDefaultMirrorTabIndexItemsRefresh(ALoadFormSettings: Boolean = False);
var
  I: Integer;
  _Text: string;
begin
  with cxcobDefaultMirrorTabIndex do
  begin
    _Text := Text;
    Properties.Items.Clear;
    Properties.Items.Add(StrDirectlinks);
    with FCrypterPluginsCheckListBox.InnerCheckListBox.Items do
      for I := 0 to Count - 1 do
        if Items[I].Enabled and Items[I].Checked then
          Properties.Items.Add(Items[I].Text);
    if ALoadFormSettings then
      ItemIndex := Max(0, Properties.Items.IndexOf(SettingsManager.Settings.ControlAligner.DefaultMirrorTabIndex))
    else
      ItemIndex := Max(0, Properties.Items.IndexOf(_Text));
  end;
end;

procedure TSettings.RefreshControlsValues;
const
  _clear: string = '\0';
var
  _Title, _Help, _Value, _Items: string;
begin
  if not(cxTCControls.TabIndex = -1) then
  begin
    _Title := _clear;
    _Help := _clear;
    _Value := _clear;
    _Items := _clear;

    ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)

        function Y(oldstr, newstr: string): string;

      var I, J: Integer; OldStringList, NewStringList: TStringList; begin with TStringList.Create do try OldStringList := TStringList.Create; NewStringList := TStringList.Create; try OldStringList.Text := oldstr; NewStringList.Text := newstr;

      for I := 0 to OldStringList.Count - 1 do for J := 0 to NewStringList.Count - 1 do if OldStringList[I] = NewStringList[J] then Add(OldStringList[I]); finally NewStringList.Free; OldStringList.Free; end; Result := Text; finally Free; end; end;

      procedure Z(const Value: string; var NewValue: string);

      function InSplittString(substr, s: string): Boolean; begin with TStringList.Create do try Text := s; Text := StringReplace(Text, ';', sLineBreak, [rfReplaceAll]); Result := (IndexOf(substr) <> -1); finally Free; end; end;

      begin if (NewValue = _clear) then NewValue := Value else if ((NewValue = '') and (Value = '')) or InSplittString(Value, NewValue) then

        else NewValue := NewValue + ';' + Value; end; begin

        Z(AControlCollectionItem.Title, _Title); Z(AControlCollectionItem.HelpText, _Help); Z(AControlCollectionItem.Value, _Value);

      if (_Items = _clear) then _Items := AControlCollectionItem.GetItems else _Items := Y(_Items, AControlCollectionItem.GetItems); end);

    if (_Title = _clear) then
      cxTEControlsTitle.Text := ''
    else
      cxTEControlsTitle.Text := _Title;
    if (_Help = _clear) then
      cxBEControlsHelp.Text := ''
    else
      cxBEControlsHelp.Text := _Help;
    if (_Value = _clear) then
      cxTEControlsValue.Text := ''
    else
      cxTEControlsValue.Text := _Value;
    if (_Items = _clear) then
      cxLBControlsItems.Items.Text := ''
    else
      cxLBControlsItems.Items.Text := _Items;
  end;
end;

procedure TSettings.ControlsValues(AControlsValues: TControlsValues);
// F�r alle markierten Kategorien wird die �bergebene Prozedur ausgef�hrt
var
  I: Integer;
  _TemplateTypeIDs: TTypeIDs;
begin
  _TemplateTypeIDs := GetSelectedTemplateTypes(cxLVControlsTemplateType);

  for I := Ord( low(TTypeID)) to Ord( high(TTypeID)) do
    if TTypeID(I) in _TemplateTypeIDs then
      AControlsValues(TTypeID(I), TControlID(cxTCControls.TabIndex), SettingsManager.Settings.Controls.Controls[TTypeID(I), TControlID(cxTCControls.TabIndex)]);
end;

procedure TSettings.ControlsItemsEdit;
var
  _OldName, _NewName: string;
begin
  with cxLBControlsItems do
  begin
    _OldName := Items.Strings[ItemIndex];
    _NewName := _OldName;

    if InputQuery(StrEditItem, StrNewItemValue, _NewName) then
    begin
      ControlsValues( procedure(const ATypeID: TTypeID; const AComponentID: TControlID; AControlCollectionItem: TControlCollectionItem)var I: Integer; _ComboBoxIntf: IControlComboBox; _CheckComboBoxIntf: IControlCheckComboBox;
        begin for I := 0 to AControlCollectionItem.Items.Count - 1 do with TControlItemsCollectionItem(AControlCollectionItem.Items.Items[I]) do if (_OldName = ItemName) then ItemName := _NewName;
        UpdateAllOpenedTabs(ATypeID, AComponentID, procedure(const AControl: IControlBasic)begin if AControl.QueryInterface(IControlComboBox, _ComboBoxIntf) = 0 then _ComboBoxIntf.List := AControlCollectionItem.GetItems;
          if AControl.QueryInterface(IControlCheckComboBox, _CheckComboBoxIntf) = 0 then _CheckComboBoxIntf.List := AControlCollectionItem.GetItems; end); end);
      Items.Strings[ItemIndex] := _NewName;
    end;
  end;
end;

procedure TSettings.UpdateAllOpenedTabs(AActiveControlAccess: TActiveControlAccess);
var
  _TabIndex, _ControlIndex: Integer;
begin
  with (Main.fMain as IPageController) do
    for _TabIndex := 0 to TabSheetCount - 1 do
      with TabSheetController[_TabIndex].ControlController do
        for _ControlIndex := 0 to ControlCount - 1 do
          AActiveControlAccess(Control[_ControlIndex]);
end;

procedure TSettings.UpdateAllOpenedTabs(ATypeID: TTypeID; AComponentID: TControlID; AActiveControlAccess: TActiveControlAccess);
var
  _TabIndex, _ControlIndex: Integer;
begin
  with (Main.fMain as IPageController) do
    for _TabIndex := 0 to TabSheetCount - 1 do
      if (ATypeID = TabSheetController[_TabIndex].ControlController.TypeID) then
        with TabSheetController[_TabIndex].ControlController do
          for _ControlIndex := 0 to ControlCount - 1 do
            if (AComponentID = Control[_ControlIndex].ControlID) then
              AActiveControlAccess(Control[_ControlIndex]);
end;

function TSettings.GetSelectedTemplateTypes(TemplateTypeListView: TcxListView): TTypeIDs;
var
  I: Integer;
begin
  Result := [];

  with TemplateTypeListView.Items do
    for I := 0 to Count - 1 do
      if Item[I].Selected then
        Result := Result + [StringToTypeID(Item[I].Caption)];
end;

procedure TSettings.UpdatePublishDelaybetweenUploadsHint;
var
  LPublishDelayInMSec: Integer;
begin
  LPublishDelayInMSec := cxSEPublishDelaybetweenUploads.Value;

  if (LPublishDelayInMSec > 0) then
  begin
    if (LPublishDelayInMSec < 60000) then
      cxSEPublishDelaybetweenUploads.Hint := IntToStr(round(LPublishDelayInMSec / 1000)) + ' seconds'
    else
      cxSEPublishDelaybetweenUploads.Hint := FloatToStr(RoundTo(LPublishDelayInMSec / 60000, -2)) + ' minutes';
  end;
end;
{$ENDREGION}

end.
