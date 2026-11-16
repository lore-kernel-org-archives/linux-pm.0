Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836828;
	b=jHsmnLWYiNqefq7CdjSAZvcs1QQ6r6PtehpbSAXQDsLuqfHrLBGtAN643mQloBKVwUv2
	 N/JGmHgGj3fgbkmgEN1FCmtmojBVA5+hlwnzD7f75qAjbvb953qLbZQeMzqj/n3AENriQ
	 8zo9njzRnGdjDBExw3rNAyc9nfNAGwHDjfzluYOJJkjjRnWYkAY6hmX5M0HaP/nPry4Jz
	 pLeDK+QP1SP6TvD2EOlDfiTgzBjsdMcPJIcXytnGehSuB0yJn8UMSf/bjOvvsJhhigpiU
	 Mfgqy89FjMZUj5VmReYsVTNin7Xxy3yr7peilGSvn6mAHdBXpnWHUkYmy7VTHVFcDSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=s6+we+zNEogUULxek8r/se8xwtl5vHAyZIOGOEG2TtU=;
	b=ZbqFjmg0wqwMIBwxFovRf9kN1ih5dOuPyxtqPrZ9f9Bpmdol7wOG4q0v91Pldc0kXvD5
	 IQF4v8GZN2GIOistcnyb/eCnmR+PrMafNK4AIZZyE+Y+zKDI/aQF014P8dIn1wO7BDFZi
	 Nfsb5KAZyAMtFEXX4bSOy+LJiJ7fMmviOIC40IltrnSJLsEOSTzqcwUhpIOxvnfnQ8zsq
	 oLaOeLLzpcqx01md3DNBF4Ym/x7kv3jqWm7k4zK0AXjUVLTpigW25LDcHiwrnWR5l7NNB
	 C5BmWKpBRBKwt//GMMjzVzS472xFPwdcRw3x/qEKszT5La/8vLmfW/vUNADm5GX6YiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MnCv8Fdj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.23
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06761606A31C;
	Mon, 16 Nov 2026 13:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06761606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MnCv8Fdj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTT/QqNSgHGjx2ttCvzygsHXut3Q8X89Rb8bFWG+Yu0cvQK052LM7yeNwX/AxBAXrIMvmwfEZcEgzq942hiAOF0nzB+u/HGXFPUwbi/T8cgSkOuUt4pxBhO/JT+gjJ7tgSMLQQr4D9Zwhh1jiG0nAf7R/R5omME3EiC26SSmnMRC5fG5Us2gvlc7Jhljvmnl75swQQK0abVekbtwin4yiq/jDLQQyYelrkdz1ZzRNpefGYmEMTry0WTFDGpAG5afnyflJ0/gZwhOINtES+rwO96Y3Kgd9GgT0TxdAgu+SxvTgfVFVg8WllvoafE42AcyXB83CdgoPyXbcsiyy7E6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6+we+zNEogUULxek8r/se8xwtl5vHAyZIOGOEG2TtU=;
 b=ewwsrdv58MwJRmzDyRVrysPiVfh+UsGjqPR6OGlidHAV7/9jxFaV57eFwvDeD6HK4neQufPybEayIG1ydG3A9r1oARescdcwv2IGz9LhN0A3hYvUHXbygoAMpY1eJG4A6fTly5rj1C0c0vM1Wa0R9xJKSLOrX8yQVsJMfqSza9CWNZpJOYvWGdUzTAm7Zb3lB2J0vQF9kST1OP5U3CGz00KKwHS10hbs7aovE9QT5RvghexVSEWtr6Y74Da5lIoc55gNDJUiZTl7G3Vj1URJbbRzxT1tDbvR2OxoRSqMM0GTmg2yCqACSrDNykMrP5NQSMg6WUwQO6Y475VYT/5zLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6+we+zNEogUULxek8r/se8xwtl5vHAyZIOGOEG2TtU=;
 b=MnCv8FdjIyxwwMpHhAB0ZJsbYV2Pw54iJRL3zINQDbQWGRthffO81OEnMVKcQ+sSm92yYvL5DoYTG4KTCVKe3ltB0cZgFYRgGjsCI/7o3pfDh00jNPsU+JoSr2s/O4jOBe65RVkt6xYycihEmv3Y15+aT5beYiQzCrV+SU+waDT0wQCCrSH2rIqa835DyJphcXQ+MiMyw2j8qxx2qkxTNPp3XwmgGGhH83+fV7anb3bTgkO6xy9GemkbIw/L8OER3Gne7UrX91dRNEGCFe6V3LJijHMmNZSFl6Y/mglfOVlHJ/+utlITvXI/enn90sMTeMVUsESJuiObKYuIbLPLbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10126.eurprd04.prod.outlook.com (2603:10a6:150:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 13:47:02 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:02 +0000
Date: Mon, 16 Nov 2026 08:46:49 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <avsJSUvOTl1Pp6Qe@lizhi-Precision-Tower-5810>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
 <CAJZ5v0jyuMjh4En_r2TYui+sNbGveJ0Rz1Da39LEK9e-HxHgGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jyuMjh4En_r2TYui+sNbGveJ0Rz1Da39LEK9e-HxHgGA@mail.gmail.com>
X-ClientProxiedBy: PH8P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10126:EE_
X-MS-Office365-Filtering-Correlation-Id: c5eb739a-d46b-40eb-7b63-08df43e8182e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|19092799006|10067099003|11063799006|4143699003|56012099006|261021121427099003|261026121527099003|261102123227099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	arWDUWabQbUJW+iJBHLLTlm4QNkiF1ZoS9iwwa+uuoHQ2r9xjWchQVEzlJMdLcU/gO5sG10EtSwCSOPzu3EAKz7n4X47gR4Rvk5ccOvW7J3yYScGQUFlepv8ZWgzVePs+SbZwOHY3aUYr6xj9aogd2ejo8QoDk0VEgs+ZVpAAp1rqPEEhS0EX3uPiZY3KsRRHRsVkXYeaEPK6ddnHDi3ZovPGztOFNo6UV+pY7i3aU8SPD65nYD6mTvBC+dl3mHu8qy0GZ0gVv5dNqVC7lxdQCBlGW1m+lg7JC5xqz4PLOI2dxHH5IJPZoj/mtY7jZ/2ueeGImwrL1ilFQBRN0MOx2+SxArzOKOigaQzwGZ+pV6AlhC0e9xgRJFpnK2tCOyXldWYQPPD16BXNffXp42Qf7+lMb5I294KbW65u6JLVshT7JjSv0JImjCP3kOMvByKEyK+FPnjZZf1LKtoq7RR5ByrHJVrSm9qZHJx1orBuQ8SpUlMxJjcEPRg6YhzpXpcgFN6qSdr1yB6RWtz3yR/Fx8foSLHBiNI7MUETfTc8BbJOGVBTru70xP9AWDDWjcIM/TUkIZGSeN4/85uCKw/WjlsEyFLxjudKt0fpgjcWh7WLZHxYbC4Gsckch5U14Ka15zDoNKBiFkh19GxTWFCLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHp4dnV3T01RODltYW0xWTlGdkRHME9VWkJ1MDZXY3gvTlBlU0IzZ0ZpcU1a?=
 =?utf-8?B?ZG5KZ2xqb0VDOGhKVnovRDMzZWFSRWl2MkozNHNWTzJ2WlBkN2wyMFB3RmZQ?=
 =?utf-8?B?bkFsRVhYcWFlaFpoS1J0K1Y4cmVXWGlNak85c1B0TFZ2MU9Mek1HQzB6b2U0?=
 =?utf-8?B?alROVjhySUFPbFZMRVBzSDVjMFNWc2diOUpnYWltOUJPVlBRZ3ozYWJqWWxH?=
 =?utf-8?B?cDh3WDJ5SDJLSEJOYUxhU2RpNXRiN3NiendOaVVvL3hxMlQ5ZDl6ZkwyZTlU?=
 =?utf-8?B?ekZrSEE1Y0JEMk5VM3pONTZMSkVoYnZsQlJkaEpodFRyaEYwdnc2dm8vd0RE?=
 =?utf-8?B?bHZ6Y2MxbWp5R0hNeEVIa3ZOUUpPTWV4ZVVCWk5jK1czUHJ1bDJDOGhaQi9W?=
 =?utf-8?B?K29VTko4N2wvaU5Tc3ZIM3JEOGRhT0pqS012VWRZQzg0V3IreE9mTmNweGtx?=
 =?utf-8?B?ME9ZUFFaQWR4bmNtYkR6eGtrUTBGUE55QWJ6WEtuTW1VY1hhR2VvakxOd1Uy?=
 =?utf-8?B?Unh0U2U4RDZqdWFiRW55ZFpaKzBzMFNSZ1pZMUxiNmtoa3p3YWFvOTI3WDlV?=
 =?utf-8?B?SW4zYkNhVzNMUng1Y3hpSzYyUzR0Qm11QktVZWdFVEdtVGlqc3BienVzUWhv?=
 =?utf-8?B?Qyt2aE9QNUx1VG9lZTk2bUpyY2lpZjVpOXB3ZXVtYjVMYUNJWlVQdDNUdG1F?=
 =?utf-8?B?R3YveHZUMFJ2NmZVRU5SVEtaOXVOTW8vMjFaL01kdVhaSGRFeEZUMGdNV1Z1?=
 =?utf-8?B?cS9YamFNTk9LelRUcWpEa1kzQlZNSjhRVGZHU2pTUXA1UjB2V1dwanVSdzcr?=
 =?utf-8?B?NTlTVXovS0RkTkFsRzdEeE4vRmNWdEZ4ZUdYMjFab1E1SHd0Zk5FajNOc1Zn?=
 =?utf-8?B?VzE1REtzMkZFek5tdWd2STRDVXRtVmJaT3JRLy9GMFdNZUkwVVo5eE80a1dB?=
 =?utf-8?B?bFZ4eTUzbmhJVW5vMnkvTVZDSmlkQUlDaWU5cnZaZWhGOTVDT3lVclRCTlMw?=
 =?utf-8?B?dlA2Z3NTUTV0WnYwVUszNDcrbnUwaDZIR1MvbTBwd2ZwRGswNGJFRW04N21Y?=
 =?utf-8?B?VFFzZ1dDWG52R1lYeGZjd1JUSzhjL1JEc0ZBYlFaSHJkQjNzMklZNTlub0gw?=
 =?utf-8?B?eHRtYTFoU2NXSWg0RFVtbU0xK24zM3YvdDQ1bmNpYWljcFJVYkFoWXp2cWpu?=
 =?utf-8?B?MnRKSk12Skx3dXJ4N0ptc1ZjZC82bWswU1ZJQUVGSWZJQ1VHYkFFOXZCYVEz?=
 =?utf-8?B?UGk2T1NxaVFLWHcyaWxCSkFCdVFPNkxTaTV5UHRRd0NxdE9reHByRlF2YWxW?=
 =?utf-8?B?S3JuVzdESXduWGt6d3VQOVVRN0VVbXluS21jSTkrNTZzazVCWEFBVHZpek5T?=
 =?utf-8?B?Tll4V1RYN3hWUmlhVHBjdnVIOUNLblpvbGs1NEdxZm5VZ3dRODQ1K1hBMjdL?=
 =?utf-8?B?ckExUTl5TjBjandzYmduNXpWTjVoVHdEWVAxMVkvZ0JJSTRUbEdWWUhzSmR1?=
 =?utf-8?B?a1FiQnBYL3JQS2lPQjJDTlFudThpTTNTd240TmNhM255eGEvUFdlNStHaFpn?=
 =?utf-8?B?blgvOFg2OXEwVUpIeEZWTkpzVjBGdGwvbkdqWUdHejdJSk9KTUVUdzlYSjNk?=
 =?utf-8?B?ekg0S2ZQZTVYU3dFaEpyTlRmV3JORmJRM2w5MzhCV0xva3l6Q1FJcGpleDVK?=
 =?utf-8?B?LzJaZXFjY3lURytMeE1aQ0s1UEdEWGU0NWZRSE03L0MxRlB5M0k1WDYxZmp6?=
 =?utf-8?B?QjJPZ3lZVE1OZUg3dkpHa1RpZkI4ejZEU253UU5NbzQ0TzhzcVlpUjd4NzJR?=
 =?utf-8?B?WGhNVWNkWllVWGlDeTdLR3AxT3V5TlRJdmpOQmVpQ3BIUEZJZUN2ajRia0dK?=
 =?utf-8?B?K28vU2dUc1FHNG9Zc2MxSTI5OGIvSCtrRkhwekY3ajlrelB6VDBnUGtSc25F?=
 =?utf-8?B?TFh3WTVZRHF5bDFUNHMrUTBwMlIrVVhrcVYzMmoxSlBWVWJlVHQzOHdDdHFa?=
 =?utf-8?B?K3VwUHpWM2grNnc5eGVaQ1JqNU1FUU52cldYOXErVnNhL2V2dkNmNzVibWpy?=
 =?utf-8?B?S1lSWEk1U3l5U0dCdmJPM212NVFVZVNwMU1DMWZWb0NRcVVNd1REengxbzVo?=
 =?utf-8?B?TEdPcGZhRmE3a0tFdDNtYlFyemhpZDAwZXBrOEF2UEQyYjZtb2RPY1h3MklG?=
 =?utf-8?B?N2VZUE5VclFKUDBGUDgreDVwaCtiQUJyRlpzd29mNGJvb2I5bXJCazEzSVZW?=
 =?utf-8?B?SlVxWHhSYlpSeHFxVVF2UUM5T20xZ2podFJTbDU4VWxzdlRNdTdsV1N0WExw?=
 =?utf-8?B?Z1R1UUV1cWlEZHdlK1BwbFROV3BjMk1kcjBvekM0N0IrSVpYZkdhbitrMXRB?=
 =?utf-8?Q?lg/KbMN6cDJNuuk9DdarxLt9LxDJFBekHGGff?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eb739a-d46b-40eb-7b63-08df43e8182e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:02.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdqg3vBx9hCegs+4Ra+oGFNChPKkebTPci0RDlWfSahWAH72anKnjKucUH5I32fNbky99Zkq9wFEGh3xTQuOsi3Vee9ykMTZE7mksrDtekO/x23SaNtnjo2olyRkHE8L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10126

On Fri, Nov 13, 2026 at 07:18:55PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Thu, Oct 29, 2026 at 5:31 PM <Frank.Li@oss.nxp.com> wrote:
> >
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > When CONFIG_PM is not enabled, all devices runtime PM state should be
> > treated as active.
> >
> > __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> > pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
> > stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> > should return the same value as the stub pm_runtime_get(), which is 1.
> >
> > Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
> >
> > Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
> >   Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
> >   Callers: drivers/accel/ethosu/ethosu_perfmon.c,
> >            drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
> >            drivers/gpu/drm/msm/msm_perfcntr.c,
> >            drivers/gpu/drm/v3d/v3d_mmu.c,
> >            drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
> >            drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
> >            drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
> >            drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
> >            drivers/media/pci/intel/ipu6/ipu6-buttress.c,
> >            sound/hda/core/device.c
> >
> > Pattern B: if (!ret) after get -- no impact
> >   Both -EINVAL and 1 are non-zero, !ret is false in both cases.
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
> >     in kernels without CONFIG_PM), drivers/pci/pci.c
> >
> > Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
> >   drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
> >     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
> >   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
> >     spuriously triggered WARN. Fixed: 1 > 0, no warn.
> >   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
> >     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
> >   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
> >     Fixed: proceeds correctly without CONFIG_PM.
> >   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
> >     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
> >     xe_pxp.c) now correctly treat !CONFIG_PM as active.
> >   drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
> >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
> >     executes stall register update.
> >   drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
> >     return now skipped, correctly proceeds.
> >
> > Pattern D: explicit -EINVAL check
> >   drivers/hwmon/prom21-xhci.c: checks (> 0) then (== -EINVAL).
> >     Old: took -EINVAL fallback. New: takes (> 0) fast path.
> >     Both succeed when CONFIG_PM is disabled; functionally equivalent.
> >   drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
> >     stub is never reached. No impact.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> People sent feedback, so I'm wondering if there's going to be a v2 or
> does someone else need to take care of this going forward?

Sorry, I forget this thread. I will post v2 soon.

Frank

