Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C747B409;
	Tue, 14 Jul 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039727; cv=fail; b=mYOE/LSqo0FlqXOyqDcHQVAkFgtHi+5mwZidevYMFBOUCfhal65wfe5hcIrJKhu9jb3vSPbTaSZmPGmKwherBxh2wnyHuKIVLNz8BSOGBx6e0i3v1RrsBlx3O1jHQJcr7iIDjm1+LXH3Vz4LswbGG1lm0zQNmxnfGtmban7rgNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039727; c=relaxed/simple;
	bh=B0D62jbvY+KUmr9vsJ7s3nA/yD2pdcUHtTNDPZSk1aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgEQqtH3ZFKxi6FMM6TuhC0qrgAJ/B0sCdUXnJntV39/axk3v9Y2jAlEsQ/+lfUCb+uHz4hXgPwasNthnxj1xGFqBE9fhmaW8qkFzDbYlzCOhYq2Xvz6y1j2Lk9HWbUnx21o2uNxro8YC7QBXQ9tj+eOngJe3FGHM3zFzoBqx9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Tf1j3CF/; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tf1j3CF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrdh0wKubAlvVAmJFr/vqpFqceMZWdMOcph3eY4K7c01SN4wkgRLoOtaCwDahZCNS0WnbH+GtEHmDhgYb3dQlo5KqCNsnlK6kbl1C7dMfOHSRfYTKi7WpcCyJJrtYg0/iJbqhDkzlCkr8oKIf5TEcjv9NMorrNg4fpJF6AnEy7qTCc+u12kj81x48hgBebbxTgygXloxcskzZZ7CaMerW2iLTSu3sSDvBAMAExg9NCY+TopUJvl8jdtRtUHrd6NZ196LB+5rQS258UCkvH1HLLg9hXGcrnSyu1pXxW4dqjkz7zOCRPPkp8riU7nw4P+Re6BIMCa2XLtUiiVYsl2orA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu8kjFHQD9n/W4C5mR3tlx/XfAAFJbYOzUzb0Wg1bRc=;
 b=NQvA5xgjKo7CCEbDebTPhSVEnSJcUhqxgpFXRN5PB1qC/3NmwVP0Zm/328hrNx/9O4/lDhQZNXCiC5JkCOhHj6AEQEINOt+/EXzC2yCH4i4qsHwshaoIPexiZLXk8ZJAvhIZA78KSlpkgq6qbMggKUDvSUsMRLst+ZaZurB4ZbFycTGRTFOIfwqKCaFNlpa8CcLtdbmU1XFRkYWJAI2oOg8hXQeyE2W2rHUbyvGCdY43q4Jv+rG6e1WPuA/TR5PPz0dKVT9QarTTvvHqsDTSCW+73g57FfwtYVIjTHvWhjpHf0vn/MU7xyZ9LIbYYVm4eW+t8+Ab6MOLBGAkD1pDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu8kjFHQD9n/W4C5mR3tlx/XfAAFJbYOzUzb0Wg1bRc=;
 b=Tf1j3CF/9/VREQQ3bpw/yyyOLbFrXfUpU+/ogckXffhXNA1QwkCa4Oe7aeCrKDAo3+M1celLsXec6Dxdme+oAeBWG3EmZuA2Z0Afg6Ajtffyqd4aY2yy+d9RV0EJbQ1IuVCrQ/Aqb7l9SQlxXopSQRXn3+l7AnvHykjZngTztkB9eGlSW6JCerkICKpG5Rwafge3n79d4jaoBFTnZVI5WTv7LIErt05blPogJg6h31rF06bb74UDGUMQJXFHZ6l2bRn6OjLuEZCWCPyTb8qUjNa9FV58UZ8imA48bp8fjkx1s+a0HPN9GRaJyn+Xf3jO/JM9x44YyXOfIhOpxwpe+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7474.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 14:35:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:35:16 +0000
Date: Tue, 14 Jul 2026 09:35:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Haoning.CHENG@cn.bosch.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] thermal/drivers/imx: Add calibration offset
 support
Message-ID: <alZJGAmh9WrEAAZ1@SMW015318>
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: be01b524-34ad-4e62-8ea1-08dee1b51ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	LODztohhwrBMPQop4DowOnVCIbTLspqJ25YJdJsc/EXmxjVdUW1X2/szBFRsNsP5qnnQ/ybYTrZjXc4bB10JvTSF8AYt/7pYx+Ou4p39Dc6ATRyADZ6WmepU9d2OVLcoQXLqPr1lO2KRzWrvEASE4ThKLzMONezSbnw3yUo7rhhyPhHlbsgx127KNoKqig5ovYirb0OwThAm3eAe0rV1dHOd1xaVUVwl65BIR04KVvLpq2ZeDKDE2frx28ckFCfs3PaJlH5LROLqsDBk8wYar8fphMZOp1ZhnKHUv0cUm96YmvmnvD203JtKsCamJ5/Fejc/5T42IfyGooeoU+Ar2LQx57EdlUSTh92f8FO5c2uqFhU6jNw5c0Kz3++53m25yjMKPGFg6RuvKtWDA2+glAfAAFnURNysVXmUcmLrhy3ROSonONNcsBHjc7yhttUYf94vE84SNynrI0vY/O5cV3xJpmR36hjM3y1xbK2dgAPunPIPy1CkvBY6Bk1DcnVZAgAHpTZ33q6w3Yu/1F4BzXJ3rbDU+wcTUlsqVJh2CCciSBGL7JlPCgBg4r2MvRdQBAROQWKtKgVzOjlC44JYP93goHsXnZM/iZbLLYfuSHgLpHa3N7/JmQOxgauey8v4EkxeM4WnzDyPEpCuL+i0X7Gb4Kl3In81zCuYYV9T860=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlhlY3FjVGVpQVMrWStoZVk2WjZYUmZoYW00aXlaaXlGSGFiMjVLdkc2YTE4?=
 =?utf-8?B?TklDUTFVY29ZMFArMHo5Z0dIUFhOU0VOdEx1VDN3eFhkL3dNMDZ1YnJyS2NP?=
 =?utf-8?B?cWRpMUYwYk4rYlBsY3oxTE9ZYjUyYWtleDA0RFYrbzFLV2VGQ1A3elFYYzBE?=
 =?utf-8?B?d1lTQmZiNnkxdXRlczNIcHBKQVFxQ2daUnM4MDdPRWIvclJNU3JITldQQkxu?=
 =?utf-8?B?UStvUXZDY0QvNjBidURrdk5OWEpHOXQ2TEZpNzF0cTI1T1Jrc2I5ZzRwOGZL?=
 =?utf-8?B?NTkzWUNYMTBPeUVqTFZaK3VZZGdJRGpvU0gzbFBwOFNQOWIzeUM0bjdiZWd5?=
 =?utf-8?B?dEdiR1BuWlpudjBNQ2ROSytzTGxpbEI3dnhXZzVNRjFZMlV0MXoyd3ArbUxG?=
 =?utf-8?B?ZW5YRnptOUdrODROUGl6akU2Tnd5Z3J3VW95YitleldiTkJoc3V4WVRiN1d6?=
 =?utf-8?B?SE94OFQybkJOczJHOXFYbDRtQU8wbm5FUmo4OFV5b2NMQkNPbno2MWFWUlNS?=
 =?utf-8?B?b1k5NUFhK2lCcmxidGZ2cUhGTlJoZDdMeGZhQnljL05vKzZDSXVuZGlhOGQv?=
 =?utf-8?B?SEdUNHNVbmdIRDVyRkhPZDkzckhFS2JCOUJiWHZMUXVwM1YzYjBoQ3pSUVVP?=
 =?utf-8?B?Z3I4cm5NcEtWdVhNQmh6Vm9PRnYvKzlQM1NYM1Q2VUs5RW5PUFdwN0NIRFFp?=
 =?utf-8?B?M2I2R01hbDB3UFB2NnAzOWZzaG16RndscEkxVFRQaFVVWUFKYkxPU2FGQ1Y1?=
 =?utf-8?B?WXllQjRUYUcyZDRIWkFLVkgwSFhFeDFNK1NDbElacUp6RlU1VHl5ZGUxQUp4?=
 =?utf-8?B?Q1Q2c3RZV0FkTG8wZy9jaksydVJxZzhablJRb1JrRkRxVzdnNUZCTFp6b284?=
 =?utf-8?B?Vmt2N01UdVBTTTZ3dmQ3QmpTSU43eHJVNkRxanp4MVl2OXVsZzhLczB0NDh0?=
 =?utf-8?B?VUw5N1ZIQXNJbTBWNDB6TTZkYTZlWmUyaDlwMHhiS3p1WWhkcEQwK3Axa0wz?=
 =?utf-8?B?aHZEc1krZm9kU0lUbkpZbXJjK050RVkxWk9RQVBGS1ZuK0x1RXVMZWVXakk1?=
 =?utf-8?B?Um9vNEhaVENqckJSeGR2eUlzQjJ6U3dxZHVOYzJTd2dKUUFCemxHR3J5Znp5?=
 =?utf-8?B?M3hFRWNrVDlES1lYWjVMaHFyQ0Q0bmVveHNSTFJrMVF4Mk5oMUE4Rnc0Y2Zt?=
 =?utf-8?B?OGsvelhmcGpGQnM1Wk1RdG5vZ3pQMHBGODJEUjB4emRiOFhxenB1UWdmSmVY?=
 =?utf-8?B?UE8vZUQvSUhDTVNsNnVEWHdzVHdzeDRNdWROS1R5UGhZVzNXN1F0UXdYMVhk?=
 =?utf-8?B?UnZLS0tlQ25QY2I1RFM0MkRVL3FXUzBsQ294SkRySjQ1WUJsQUVRNE9rcWZj?=
 =?utf-8?B?eGgxRjlQYmlOeFNFQmVYeEF2bDBQbEJkSkpudEJQbkZnbzNYeTRpZkxDNVhU?=
 =?utf-8?B?L3F2aXJsRjdoM0NjbWVaT2lyVHBSRWpnamh1b3VFbmVRcXY2NnlGQlRyNkVB?=
 =?utf-8?B?d1ZLdlVPWTBBdC8vRk5sd084NUVnSGJIR0FBMDlzYVU0TDZnV2ROcUpzNmJ2?=
 =?utf-8?B?bFVIcTNCVk5GbTZkTkJiY2NvbkhQS1FoVjduU2hzV3VrdmtWYlp4eDBUQklB?=
 =?utf-8?B?MGRaK3Q0VzZmSHJQUHRDQWpmRFFXVVBTV252bVRsQldJbGxWWEE3TXg5Y0pa?=
 =?utf-8?B?amdzanNuV3I4TmRETzZZZHFwSStYUUsyaWplQ3NBd0ZuNzdlTEFXNVFSWGIy?=
 =?utf-8?B?ZWVCQ2FjckhUN0lEWTBGM2pvLzE1MVcxTW9SSndmZ2ZJbkN0anN6bE54ZDR0?=
 =?utf-8?B?ZW02b0NoQjRqWWMrSzFkREpXdEVnQTZ5MGFNdDZ4SWcyUGovZ3FHajJJb3U2?=
 =?utf-8?B?UGkxUlR5SnNmam1JRjI1MVJHQXNwcml6ejFxTjFhd0xiUWpRL2YvRTdVa3VF?=
 =?utf-8?B?MWNKOGNkS1dwajY2L0R4YUhVdzRSUE5mYnpLYXJXdUpvQVpUMFF6Q01PVzFF?=
 =?utf-8?B?WEpnL2xzc0YwWXh0WTM2REFRZUhYTTk3aml0aUNyK2FtZ1JrVHkvWk1GRmRk?=
 =?utf-8?B?WEVLeTVmWURFeWVRSll0dy9sSE9oZjhLZUVjQTBPSnkxYnhMZU1hRnJIcDky?=
 =?utf-8?B?UDIyZ2dEbmJheUNKUFo1aHdtcE5uWGZOWGUyUEtVeWFCT0crbTVEZERib20y?=
 =?utf-8?B?dVg0SHY0S3djYjJhY0J3aHBOdkF5N2JZQkhQNUtIQTdibFlyd0RHa2VpRUNG?=
 =?utf-8?B?eUcycWdNR2VMaHQ1VWdWK2dBRWszQ2RCa0tuUnBxc1JMM001c3E3L1RTOGFI?=
 =?utf-8?B?OHloMzFBOGpKdjZxc3Z0Vmd2ZXptRmpJOUNjUEJteU1IQmQ5WkJML1hLSVox?=
 =?utf-8?Q?4vCp25DMnfXP0jexG6vtEVGCGq/cDIGxHR6a3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be01b524-34ad-4e62-8ea1-08dee1b51ee1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:35:15.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiENWOBSLw/2wFgk34C+hAZknjQ7v03RSXG6n6lcGouMFMlLRJSQ5aoUcS8PjshtGgetDRjtMHS7eYNGZPLBjUAey34Pxi3cQrJAICF++izchq+RlNheisDoMDOikBFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7474

On Tue, Jul 14, 2026 at 06:28:43PM +0800, Haoning CHENG via B4 Relay wrote:
> From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
>
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements. Read the optional
> fsl,temp-calibration-offset-millicelsius property from DT and apply it
> uniformly to the i.MX6/6SX/7D calibration formulas.
>
> The offset is applied symmetrically at two points to ensure the thermal
> framework sees calibrated temperatures while hardware thresholds remain
> correctly positioned:
>
> 1. In imx_set_alarm_temp() and imx_set_panic_temp(): the temperature
>    threshold is *subtracted* by the offset before being converted to a
>    hardware register value. This shifts the hardware IRQ trigger to the
>    physical temperature that corresponds to the intended threshold.
>
> 2. In imx_get_temp(): after computing physical temperature from the
>    hardware register, the offset is *added* back. The thermal framework
>    always sees the calibrated temperature.
>
> For example, if DT sets offset = +3000 m°C (board reads 3°C too low)
> and the passive trip is 95°C:
>
>   imx_set_alarm_temp(95000):
>     alarm_temp = 95000 - 3000 = 92000
>     → hardware register programmed for 92°C physical
>
>   Hardware IRQ fires at 92°C physical
>
>   imx_get_temp():
>     reads hardware, computes 92°C physical
>     *temp = 92000 + 3000 = 95000
>     → thermal framework sees 95°C → correct trip
>
> When the property is not present, the offset defaults to 0, preserving
> the current behavior.
>
> Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/thermal/imx_thermal.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 7f7d1116b9d6..d471acc16bce 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -85,6 +85,10 @@ enum imx_thermal_trip {
>  #define TEMPMON_IMX6SX			2
>  #define TEMPMON_IMX7D			3
>
> +/* Calibration offset limits (±20 °C in millicelsius) */
> +#define IMX_TEMP_CALIB_OFFSET_MIN	(-20000)
> +#define IMX_TEMP_CALIB_OFFSET_MAX	20000
> +
>  struct thermal_soc_data {
>  	u32 version;
>
> @@ -207,6 +211,7 @@ struct imx_thermal_data {
>  	struct regmap *tempmon;
>  	u32 c1, c2; /* See formula in imx_init_calib() */
>  	int temp_max;
> +	s32 calibration_offset;
>  	int alarm_temp;
>  	int last_temp;
>  	bool irq_enabled;
> @@ -223,6 +228,7 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
>  	struct regmap *map = data->tempmon;
>  	int critical_value;
>
> +	panic_temp -= data->calibration_offset;
>  	critical_value = (data->c2 - panic_temp) / data->c1;
>
>  	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
> @@ -239,6 +245,7 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>  	int alarm_value;
>
>  	data->alarm_temp = alarm_temp;
> +	alarm_temp -= data->calibration_offset;
>
>  	if (data->socdata->version == TEMPMON_IMX7D) {
>  		if (alarm_temp >= 0)
> @@ -283,6 +290,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  		*temp = (n_meas - data->c1 + 25) * 1000;
>  	else
>  		*temp = data->c2 - n_meas * data->c1;
> +	*temp += data->calibration_offset;
>
>  	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>  	if (data->socdata->version == TEMPMON_IMX6Q) {
> @@ -635,6 +643,25 @@ static int imx_thermal_probe(struct platform_device *pdev)
>
>  	platform_set_drvdata(pdev, data);
>
> +	if (of_property_present(dev->of_node,
> +				"fsl,temp-calibration-offset-millicelsius")) {
> +		ret = of_property_read_s32(dev->of_node,
> +					   "fsl,temp-calibration-offset-millicelsius",
> +					   &data->calibration_offset);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read calibration offset\n");
> +
> +		if (data->calibration_offset < IMX_TEMP_CALIB_OFFSET_MIN ||
> +		    data->calibration_offset > IMX_TEMP_CALIB_OFFSET_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "calibration offset %d millicelsius out of range\n",
> +					     data->calibration_offset);
> +
> +		dev_dbg(dev, "calibration offset: %d millicelsius\n",
> +			data->calibration_offset);
> +	}
> +
>  	if (of_property_present(dev->of_node, "nvmem-cells")) {
>  		ret = imx_init_from_nvmem_cells(pdev);
>  		if (ret)
>
> --
> 2.43.0
>
>
>
