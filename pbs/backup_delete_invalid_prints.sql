
-- Use this script to backup and delete invalid patient template from NMRS DB.
-- After running this script the invalid dat will be backed up on biometricinfo_backup table.


CREATE TABLE if not exists `biometricinfo_backup`  (
  `biometricInfo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_Id` int(11) NOT NULL,
  `template` text,
  `imageWidth` int(11) DEFAULT NULL,
  `imageHeight` int(11) DEFAULT NULL,
  `imageDPI` int(11) DEFAULT NULL,
  `imageQuality` int(11) DEFAULT NULL,
  `fingerPosition` varchar(50) DEFAULT NULL,
  `serialNumber` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `new_template` longblob,
  PRIMARY KEY (`biometricInfo_Id`),
  KEY `patient_Id` (`patient_Id`),
  KEY `creator` (`creator`)
) ENGINE=MyISAM AUTO_INCREMENT=27774 DEFAULT CHARSET=utf8;


INSERT INTO biometricinfo_backup (patient_Id, template, imageWidth, imageHeight, imageDPI, imageQuality, fingerPosition, serialNumber, model, manufacturer, creator, date_created) 
SELECT patient_Id, template, imageWidth, imageHeight, imageDPI, imageQuality, fingerPosition, serialNumber, model, manufacturer, creator, date_created
FROM biometricinfo where template not like 'Rk1S%';

delete from biometricinfo where template  not like 'Rk1S%';