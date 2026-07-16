Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012012.outbound.protection.outlook.com [52.103.14.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2C43031C;
	Thu, 16 Jul 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223869; cv=fail; b=roZHGaKPLebSfPGlEu2Xqsvpy5vwEitZVptk4O4f6/3kb4/G8QEirUvfqGs8GpKBYLG4x1C88cR0E5Z8LeH5M99rIi8Oew6gFnqYE3UAZL9fK5m/ynuMLgcHZOutIqX3G8663VbBDbcAp9Z++lTPpYOY7VKvP36xi8wuNsVruAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223869; c=relaxed/simple;
	bh=SlJ3H8vdT/Pl/SVGmd6DfJgNNCG4g6XIjwBvjVsX7mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWu0w1R/WeNmB+dXsBnMywIV9kBvhkTpMjQzPMiK6XU1T9fJO/XIvtp1zrSFR8ffPWMldFdUKn5zzALnIWstMhoCt4NAkvJ2yqedquc3SqW4T24XxOd0uAP9dGmKSuzlKbHXkybsz0rxN1JKbD484yhYJ1hNB5XEwtt6+FqxhFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iKZeR0K7; arc=fail smtp.client-ip=52.103.14.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iKZeR0K7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaMDbVDYjFI5v7tCpZj2kDSRgmnk0f2JDsfox7v9ZFn1SXZMSB2C9aLoJuXBl63EFTwwrP2YREsz+L2e9QiGVKGPx12G95ySM/YOMCF+SqmsE1yePjNp5zfeFKWfN/4N0SyBFRGhGIWWAiqwkE/zKSK9avN32Rg/R6BMSA2pjgFWq0K7Isna47qJvZ+AbBjLd/qmBJTCrBspH5Jclij32AvgI1clRZ0303+ed+q7eGAvgANZEwAkiJQjNevsYOtb25dbiEG6+2sufdj6vdsXI+yUM2iYcF/5SFYIDR99rI0I7WVdPmIqUH7Ltc03szxmLvi9SpYumssQ77l8FIzbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlJ3H8vdT/Pl/SVGmd6DfJgNNCG4g6XIjwBvjVsX7mY=;
 b=yQl4Yu6Ecdd2xCibIIiuzIWTIpRNtiUA1ADImkgoWe9ex9/hgGrz5owQHc6cA4FVpbfXpaeqvfqLQT5DmgE0TNyymIJsIpVh/edPDH63/9+PMRycireyLfxiyNitwPyYMAfnWZBo+JIuXNEt9lxEA+FgID5d6pFKknugFWEaGD6uKcZlNGC9c7FheXpm1Uh8u/5CqpGyEkHf3gkOzzGYRitPqoEmkfD4NzM0AuQMM3ntMjaWOT3i/J4CKbcmyQxAcU1puWwcSalcfYiSyLkiO2I7B+YBxkYpqnGvH2W/0sC0grxJJVP0tYiV60cAeC5GzjmDIrnDXl06xO2jnGgTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlJ3H8vdT/Pl/SVGmd6DfJgNNCG4g6XIjwBvjVsX7mY=;
 b=iKZeR0K74XcUOQTGb93OJVOGWd66W6g9z3FKdXaXRRYo1KerxVk7cvW+vKlmfnlvaAaZ0PkKy2152veZ1bq3l7xVDhFRenWeTYZJbrWcpp37JMV6q+KUgTRDK4jgHTU3kypft7C7EG4eubpU4ZJ2TKvqRpyPkR6hGY4r74wcyLaFL1BZccL42N9oocD8q3gjCzGoWaBlZBW8W91N9rQLExsswbnqdRCCjTl5vpGNGV9e1qAZhZJ02pCGDSudPMyHKwae07Pm0arXpFcFXL9t+MrDUtzPuRYN5+SP1yhFRQ+cbCxBmButb3q/HigAC7PfI7WGhtjofMOCyBukiGd6cQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV5PR02MB11202.namprd02.prod.outlook.com (2603:10b6:408:363::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 17:44:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 17:44:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rong Zhang <i@rong.moe>, Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>
CC: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, "Andryuk, Jason" <Jason.Andryuk@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Thread-Topic: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Thread-Index: AQIrPSTZ8vlDsNovD5GCISbceOWLTAI2anW+AWto1XkCiaptCrWivaFQ
Date: Thu, 16 Jul 2026 17:44:26 +0000
Message-ID:
 <SN6PR02MB41573CF78E076D8E4C30F6BAD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
			 <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
			 <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
 <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
In-Reply-To: <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV5PR02MB11202:EE_
x-ms-office365-filtering-correlation-id: ac6c48a3-665c-4458-1547-08dee361e11c
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CI9kCRe25aszSnVF2OCFUG7xloWnDLuHFb42+LSULZR4DZmInKCfO0wStnUs6zpnLiUJIe1Sw6bwe8LQUL7ZOmEXuTjWIXsJKspBK+HALwDTLrjUy/7z7w2t7NrZ9NBfxbkkrnEbxH0ShgWPgJL8NGvAp7oXvtg0we1cGXXpGnfYF6nybTHQUk8tgOckWAg4JtoXd8Ws5sCPqdHMtwAUJEZNo90nx6038i2f1gj4oBIozCTIAwk7QuEGtv08NHupGxZ8/EotiDmT5gbf4V6VolQqHXRi4mH3oyAp+2DnZZQzrN+SN4bko8jXNWSjAQ/JZ8rgsK2IGLAaOSMkmMhzm6LFKzAYQQpM4m44yTQvdu3cmDh/G1mOqXdk/zuDO3y4BnDK340l+XCoaJLB/I/oU7qgdrKWkj9StQIGDFPNYXdSfhPF4Q2hDdmHOHNg+23wAjQMydz3kLdC0l3hUiVu6ozJJqCjNfan5dp+VNM4vBDS1uFeWgQCfdNAENXl4BKXzl1iUqMhZNO7zu+PtiTVfo+4SwxF4MpUAHu/tUGj+lY0ys3ZhiMTM5iPv1BAdL1s1ejjUjnzCHaFJ63G+h/crdpyiNx/hxz/WhnZnNsMBlAahTX5hUZH/MYJainAtEditBWNZCU7BJSErOIkcpy8Sr3wlP+IfPr1EbI5GvEcydxYQSluWzTuGfylErIQ4Jxo7Sy6/1vbzxOdNEJLJNbVfyh7eKbgR9zEXuRw6mDSvOVz8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|4140399003|12121999013|22121099003|15080799012|19110799012|8062599012|39105399006|8060799015|31061999003|13091999003|24021099003|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTl4Q0RsTjJlUHZtcHNKSWhxMUJCeTdYQStrSW8vU2JjaU5sOGs1YWhMTUlK?=
 =?utf-8?B?NFhuNjFNc2lGaGUzdjFwTXlnU0NPTUcvWElDMldDcTZYbDlDSGtubGNTbjE0?=
 =?utf-8?B?UDUzSS9FUVk5U3hpOEJIaFRiTDhyYVF2eFVGSFhzTEtMRWJMZDhyc1VXVEsw?=
 =?utf-8?B?NmZVS29yQXltZmpNdGhVZGhvOC9HbXdlTmM4b3I3MjA0YkhjMDVOVlFneFkr?=
 =?utf-8?B?M2VrR01xZmhPSUh0SGFsajV3KzRHVWdaVmEweFdHa3hLT0tqc3lvd0FDbWlo?=
 =?utf-8?B?ZWc2dVhVRHRtL1QrS0FWSFVzelhPMGRsZ1RTL05EaHpaNTZqTVpUUmxocXJ2?=
 =?utf-8?B?eU1YRE9pMkhhWWhoZzJaWTBXRlJXakl0cjZoY1pKclFZdCtQYmsxR1BlbU5U?=
 =?utf-8?B?elhzTkZVeFpwUU5SRmJaVlhZVzczdnBjd0YydFBLbDFDUWlyQTREY3lyMElu?=
 =?utf-8?B?RnpXa1RqNzRqRXpWcjRlKzAray9LemIvV2dGUTZ5bEdtK2RLdXpOZHcvVXM3?=
 =?utf-8?B?K04yUlMzQkNTbHJ5SkZ4cjR5Q3N4MWRoN0lIb01aWFZFb0JHdUEzTGJqSGlj?=
 =?utf-8?B?dUVzY1UxcU5ucmFvQ2gzR2NNR3ZpNTk4YWNjMDUxOTBNRUUxd3MrbVBpRktV?=
 =?utf-8?B?RkcvZ0JpbG9aZWVPTmNYdDBXV2U5MlcxK2lCY3VTbjBqcGpEeklKZGUyMVo1?=
 =?utf-8?B?MkZHWFU2cHYvZ1d4SldRN3hXL3hCdStFM0FnTGV2YlVoTmRMNlBvTzFsd0Fw?=
 =?utf-8?B?cTVtbjBoci9rd1ZPVkxKbWc4SDZURHJWQUZWMExjU3dnU2U0cjk3SDJUZEEy?=
 =?utf-8?B?aitSUk1vRXlic3FxN2YrRVd4cUoyc1RCUUZsbGZTR3RHV2hSck9PNVkzQVZK?=
 =?utf-8?B?VjB1akV4YUkxbHlFK2pWczZIK3F6NTNDRG1ZdEZvL3hUa21JYkhaTVVjUVFM?=
 =?utf-8?B?NUtZVUs0OWVsdFdpdEo4VUl2My94N2pydGVJVDUvNWxUcWtORmhialY3MS9k?=
 =?utf-8?B?d25DQjZLWkhYWmxXMFJOTlVONHBIS3dOSEtPQk91Z3dEemN5N240Q0xJS3Zi?=
 =?utf-8?B?WWxLSUZ4bnpBVEZLSW0vMThmdGtJUGV1NERFVWR0MlNGTXpsTkN0Q01QOXRD?=
 =?utf-8?B?M3JLbUdhQ0drN0pzNnFoejc4eGgvWEdOZFp6b2I2S1A3Uys0Q250OWFueEgr?=
 =?utf-8?B?czhKR1AyNjlpUWRDZkVGRFBBQXJlVWZReWc1VVFqQzl5K0hwZkhON3BLcjlm?=
 =?utf-8?B?VVpWSlEwOSs0R3BGTGNUT3JIRDVSWEpPWDY4TmtmWURvb2hEKzk1cDAyUzM3?=
 =?utf-8?B?OFhaNDRKNVJpU29UWHJkKzd4M3kwSlFtWWpMUWdBZnNaQ1FnMUxJMUZFM2Va?=
 =?utf-8?B?T1V3Y2l2ai9lekVodldzbWptVndVZHRTelVNOW5weUlpZTVkZjY3VkI0a2VB?=
 =?utf-8?Q?K4jbEBpw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWtieGw2VHFuZXFuYUJZZ0EvRjY3citrUWF6ckVPR2FQY0FBN1kySzJLNW5W?=
 =?utf-8?B?R3FSZCtURkZRT1Q5WFIrdXBMbHJwbnBXeHduY08rYTF5dDB2cHVPeHQySVQx?=
 =?utf-8?B?bHdaNzkyeHg1TjlPRlorWmlyajhSNTNWMHZPeTljOTFIU0dtMnRXbVN1dHdD?=
 =?utf-8?B?RGlGdEI1NU1ZOTJyUGs1U2JWaUdZNXczVXpxOFZUTG9mRnhycXM5Qjh5NzZs?=
 =?utf-8?B?N1JwVm9OM3BWVUVWSjNlaDc2UXZ0UGc1K25RaUhycmg4cENVS2JpZ09GcTFI?=
 =?utf-8?B?ZEhCSG1mTHFGN1h1L3FWUEhXNXNXOU1rNnZ5UGJtaWxNOWNIT0cvOFpybnRD?=
 =?utf-8?B?MGd1QW9Udllmekhrc1ZKanI3aUljYitlSkJDYU5iOHJkdnZpKzh0ZVJXVGJu?=
 =?utf-8?B?LzRHaFhJNDl0akV3MktPU2twZ1d0SnZKWGZ5Y01tOW5Fd0NNcXRwUEMvZFkv?=
 =?utf-8?B?RzBCaW11eXBXZW1rQVY3cG4ySThGQndyZElPQmxMakMycVhMUG1kNkZISkNv?=
 =?utf-8?B?YmUrMTArcnFhYjRrNkt6eHZVMVRpK0cvZHcxUVNpZ0hubVFoVDg0QjNvZHVL?=
 =?utf-8?B?U0MrZmlPWU9HaktRNHg0cE5KaEdGendCQ3grNEV0NzM5bUx5RFEvb0xNbWs2?=
 =?utf-8?B?S05xeldRVTBHdlZoc2syOGg2elhBSE9ycTQzOUc1aWxmZ3NwaGVNb2lVbURV?=
 =?utf-8?B?b1JxZkRGTHhEQTZEUTFQZjhxUWVpUENSWkpUUWhlZC9DcVJwOGdpRS9jcmZ4?=
 =?utf-8?B?aWNkeGp1R2xIS0djWXJHeVowRUdDd3lGU2RTcFJTVk9HbEhINGszc083dU1i?=
 =?utf-8?B?YW5ZOTFkOFlUdHZaSDlQMmxlT0Z6bUw5WSt0U3diLzdHaHV1THRVVGRJUXZv?=
 =?utf-8?B?MFdBQ1lWWkowbVQxQmxBRWFHSEVRYjBvK2xka3VhN0I0T2tmL2RHWjA4RnNp?=
 =?utf-8?B?TnpST1llbEF4Snc5K3hNYU1TVWgxSGkyaHJKR1RUakJnS1FBbmJwYWlIeUkw?=
 =?utf-8?B?Z2VpK2cvU2E3b1RJalZ4c3BFd2VPKzdaUmZNTkVZdjhYSUJ3cjUwbE5VcVBa?=
 =?utf-8?B?M2dJMkxNTTRydWZtOWMrU2x5aUxFVGN6Q0xGak1VS2dsTWlFazhJcmJaUnAr?=
 =?utf-8?B?MWpvZ2g0ZTNMenRXYi9ZMnVjRkpJYVp2STlzekpEbUNjeGNPTGQwK2pRNkNo?=
 =?utf-8?B?clJ4U29IcjJ4Z083OXEwRG0yVnJmUGJHZzZpdDExL3NDNjdiZS9XeWlpK1lR?=
 =?utf-8?B?QVpwZi9OVDcrZk5kOElMcjlEanFtRVMyNlN4WE04Z1AzUkU3SHVxNlVBcDJ0?=
 =?utf-8?B?NkNUSE1wd2dkT0E2QXl5SmxYNm5Ma2J5enRQL0FYN00yaUhrOVIvQ1F5cE1m?=
 =?utf-8?B?Wm9SaHR2TWswc3RoNmE0NDBweDlsN3hFdERVaVpzSHlNM1lUZ2s4SjVCdkp4?=
 =?utf-8?B?OXFPZnVDelNTcmZvUkhnQWhpR2lSZVY0cnp6Y0NiSDlEK2tBNW1HaS8yaWN2?=
 =?utf-8?B?VDhTT2hQOFcrblBFWXNQUk5iQ3B4eWJTMTBzalcrb250WkFmYWh5SzJSYnUz?=
 =?utf-8?B?bWpyRmJCLytUZDFQSGtXd2FuS0xtSE8vRERMZENWMVZ6Y05uNGQ2U0VWTmN6?=
 =?utf-8?B?TisxcjdMWWJUeUdZcFhKYjlvM1FZSGNLczFURXh5L0VCS21PenR1ZzdoUVVS?=
 =?utf-8?B?a2dtVVpVUmo4UkNWaDhyOXVBWnRBTnRObUZIcWg1RGRUb21uMlEwTGpSZXFj?=
 =?utf-8?B?U0lkVTZtTHdZYm5sbFF5M0lSbFluU0k2eXY0SnJUdE1mSjNXU0NyTGxaNk83?=
 =?utf-8?Q?vhBvJBjEepbK/oznrbaws0CkxdAMcZW3I5d5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6c48a3-665c-4458-1547-08dee361e11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 17:44:26.1087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR02MB11202

RnJvbTogUm9uZyBaaGFuZyA8aUByb25nLm1vZT4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE1LCAy
MDI2IDEyOjIyIFBNDQo+IA0KPiBIaSBCb3Jpc2xhdiwNCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3
aW5nIHRoZSBwYXRjaC4NCj4gDQo+IE9uIFdlZCwgMjAyNi0wNy0xNSBhdCAxMTowNCAtMDcwMCwg
Qm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+IE9uIFdlZCwgSnVsIDE1LCAyMDI2IGF0IDEyOjQ2
OjI0UE0gLTA1MDAsIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiA+ID4gQ29uY2VwdHVhbGx5
IHRoaXMgbWFrZXMgc2Vuc2UgdG8gbWUsIGJ1dCBJIHdvdWxkIGxpa2Ugc29tZSBjb21tZW50cyBm
cm9tDQo+ID4gPiBvdGhlcnMgaWYgdGhpcyBpcyB0aGUgcmlnaHQgd2F5IGZvcndhcmQuDQo+ID4g
Pg0KPiA+ID4gSmFzb24sIEJvcmlzLA0KPiA+ID4NCj4gPiA+IGNvbW1lbnRzIHBsZWFzZT8NCj4g
Pg0KPiA+IFdlIGRvbid0IGNhcmUgaWYgc29tZW9uZSAicGFzc2VzLXRocm91Z2ggYSByZWxhdGl2
ZWx5IG5ldyBDUFVJRCIgLSBJIGFtIG5vdA0KPiA+IHN1cmUgd2hhdCB0aGF0IG1lYW5zIC0NCj4g
Pg0KPiANCj4gU29ycnksIHR5cG8gaGVyZS4gSSBtZWFudCBDUFUgbW9kZWwuDQo+IA0KPiBJIHVz
dWFsbHkgYm9vdCBhIEtWTSB3aXRoIGBxZW11LXN5c3RlbS14ODZfNjQgLWFjY2VsIGt2bSAtY3B1
IGhvc3QNCj4gPG90aGVyX2FyZ3MuLi4+JyB0byB0ZXN0IHZhcmlvdXMgcGF0Y2hlcy4gVGhlc2Ug
bWVzc2FnZXMgaXMgYSBiaXQNCj4gZGlzdHVyYmluZyB0byBtZSBhcyB0aGV5IGFyZSBLRVJOX1dB
Uk5JTkcgbWVzc2FnZXMuDQo+IA0KPiBGWUksIG15IGRldmljZSBpcyBaZW4gNSBiYXNlZCBhbmQg
YWx3YXlzIHRyaWdnZXJzIGJvdGggbWVzc2FnZXMuDQo+IA0KPiBJIGNhbiBhbHNvIHJlcHJvZHVj
ZSBib3RoIG1lc3NhZ2VzIHdpdGggYC1jcHUgRVBZQy1HZW5vYScgYW5kIGAtY3B1DQo+IEVQWUMt
VHVyaW4nLiBJdCdzIGp1c3QgZHVlIHRvIGhvdyBhbWRfY3BwY19zdXBwb3J0ZWQoKSBpcyBpbXBs
ZW1lbnRlZC4NCj4gDQo+ID4gYnV0IHdlIHdvbid0IHBhdGNoIHRoZSB1cHN0cmVhbSBrZXJuZWwg
anVzdCBiZWNhdXNlIGl0DQo+ID4gZHVtcGVkIGFuIGVycm9yIG1lc3NhZ2UgaW4gdGhlIGd1ZXN0
Lg0KPiANCj4gV2VsbCwgdGhlIHJlYXNvbiB3aHkgSSBkZWNpZGVkIHRvIHNlbmQgdGhpcyBpcyBu
b3Qgb25seSBhYm91dCBob3cgbm9pc3kNCj4gaXQgaXMsIGJ1dCBhbHNvIGFib3V0IHRoZSBjb3Jy
ZWN0bmVzcy4NCj4gDQo+IFRoZSBmaXJzdCBtZXNzYWdlcyBzYXlzOg0KPiANCj4gICAgVGhlIENQ
UEMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgYnV0IGN1cnJlbnRseSBkaXNhYmxlZCBieSB0aGUgQklP
Uy4NCj4gICAgUGxlYXNlIGVuYWJsZSBpdCBpZiB5b3VyIEJJT1MgaGFzIHRoZSBDUFBDIG9wdGlv
bi4NCj4gDQo+IFRoZSBDUFBDIGZlYXR1cmUgaXMgbmVpdGhlciBzdXBwb3J0ZWQgaW4gYSBLVk0g
bm9yIGRpc2FibGVkIGJ5IHRoZSBWTSdzDQo+IEJJT1MuDQo+IA0KPiBJSVVDLCBpdCdzIGRpc2Fi
bGVkIGJ5IGt2bV9jcHVfY2FwX2luaXQoQ1BVSURfODAwMF8wMDA4X0VCWCwgLi4uKSwgc28NCj4g
dGhlIHVwc3RyZWFtIGtlcm5lbCBib3RoIGRpc2FibGVzIGl0IGFzIGEgaHlwZXJ2aXNvciBhbmQg
d2FybnMgYWJvdXQgaXQNCj4gYXMgYSBndWVzdC4gV2hhdCBhIHBhcmFkb3ghDQo+IA0KPiBBdCBs
ZWFzdCB0aGUgZmlyc3QgbWVzc2FnZSBpcyBub25zZW5zZSBpbiB0aGlzIGNhc2UgYW5kIHRoZSBw
YXJhZG94DQo+IHNob3VsZCByZWFsbHkgYmUgZml4ZWQuIElmIHlvdSBwcmVmZXIgcHJlc2Vydmlu
ZyB0aGUgc2Vjb25kIG1lc3NhZ2UNCj4gKCJ0aGUgX0NQQyBvYmplY3QgaXMgbm90IHByZXNlbnQg
aW4gU0JJT1Mgb3IgQUNQSSBkaXNhYmxlZCIpIGFzIGFuDQo+IGluZm9ybWF0aXZlIGhpbnQgYW55
d2F5LCBob3cgYWJvdXQgbW92aW5nIHRoZSB2aXJ0dWFsaXphdGlvbiBjaGVjayBpbnRvDQo+IGFt
ZF9jcHBjX3N1cHBvcnRlZCgpIHRvIG9ubHkgbXV0ZSB0aGUgZmlyc3Qgb25lPyA7LSkNCj4gDQo+
IFRoYW5rcywNCj4gUm9uZw0KDQpGV0lXLCB0aGUgc2FtZSB3YXJuaW5ncyBhcmUgb3V0cHV0IHdo
ZW4gcnVubmluZyBhcyBhIGd1ZXN0IG9uIEh5cGVyLVYNCmhvc3RzLiBPdmVyIHRoZSB5ZWFycywg
SSd2ZSBjbGVhbmVkIHVwIHZhcmlvdXMgYm9ndXMgd2FybmluZ3MgYW5kIGVycm9ycyBpbg0KdGhl
IGJvb3QgbG9ncyBmb3IgSHlwZXItViBndWVzdHMgc28gdGhleSBsb29rcyBjbGVhbi4gSSdkIGxv
dmUgdG8gc2VlIHRoZXNlDQpnbyBhd2F5IGFzIHdlbGwuDQoNCkp1c3QgbXkgJC4wMiAuLi4NCg0K
TWljaGFlbA0KDQo=
