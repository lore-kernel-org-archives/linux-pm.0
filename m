Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB243CCFDE;
	Mon, 20 Jul 2026 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536068; cv=fail; b=k8v6FQVIN41/r3UA1eJbGRh+5Cow4rOFbsSc3/ucfgqsHE0iCpuM6tXnO3JC5mveF5nyOPP+cJkx7oqsyZMIclcohzbWpOFRhP9IXmxMhG5h9/mY9/+jecCXDMIzNqSOxLv/39a6I9NnptezGGHhP0zOhC5rbPqbEYHT30SfS0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536068; c=relaxed/simple;
	bh=nrDpF95wu4UKeEVyPUHEGF4kyKSe3fZaWcMXzp/uz+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCKZ2L/n/8NgKG7mko4MYoONLFkRzEXWUHpQrkN7BKaXnWtnNacSda0oRn1YolySx8RcI6R5f0pQ7AzKArwkEEHU53ZChUYMrxqLYN2pZhRaNouKf03vril6O3tAemALZA1c8enmTpdQv+65djURPuaI53UBUzcekY8UkMWgORY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=R5MmloeC; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="R5MmloeC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM+V0+Wu6/2psQT1OBx77pEn7rXE9GfBCS6E6FjpXBeDjIJw4U7ZVXtnT+YK31pEWRsIO+hNbnN83QI1cGs50fA2j+l5TroUzhzVk+8nvGGQBJXeSVh4MUeSl1G1b1CRqUwFURSkXZlmxZiFlvm5g7xlk3NvV81qsfjRJTPTgEgtCnPwPogx8g082BjO7BISWlbImoQOoVHOWVZbhEHHJ9cZSRPL7BDPgEQMWhGdzOI6Y9QiTwyZtcFgHKlJKdYDHIY5DzjcL/2klBpaaA+OxYpFW8oqRMjHJavSMiK/8tbES4EGKz+iOwkeYrIazfMDSRTXD6vID8b4rPuk6y9cJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RfFJezOgIiNsgp05GP4syUtkTURbMDdxIP6+LImR8w=;
 b=zHCA9ZQsOx9i8pFEk2tKQBPEVGJTNddGi9tI8rOu/U91siH97nw6AO8bUtxb77qy2mq+YqgMEvZmOD2rEnFHQEa51BuVgpXsCfJz+jYAaGELzAgEbSPDAdS+M9ilRmlcfXG4dvGs3TOLIVIwngqVi8NNVF4Ot3cnn25uMQQsSrUlt+zvRebtEYAKFYqFxguPhzRDMNiEDZXoi0sji46g2w5xZAghLkWCstNb5BMKRchATmSEW7KWblTSMrxaSOMCdnn8rWkYOWiqPS6Ht00FmAFQBiy0iccJfdqdEw2MiLmwNPkl3tFH1wqta5ykz1lMnVpMw8s1zgm5KBk9rJ8g0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RfFJezOgIiNsgp05GP4syUtkTURbMDdxIP6+LImR8w=;
 b=R5MmloeCMNmQtyuLgvA5I1AKd4YJ6Gs4pFTyb7XOj42om8YhN88sUlP0/7BOCJfHYlBPHWvNTBAeKpg9jUbWqFxmA2OsbY40qSd0/aY0AYuz2720fw8edOsivgQf9gaMxDX0x3z6OeDhKkKgpyGgHKAdcPCQIH1AWuwOMHHyNdSUEwjA2QeHRPIAKiJAIRFdKK7Gvg1IFlNTb+WEGgl6zvxgGFrU4oTpOJ+sQzNLwEDVjZOC2W1/K2ieHrlbGZeoY1BISvMBkXuxVYNMtSrhrxN0SlxJhUG9aILnLKHHVqeH+zZOzQLhc4QVx0N9piOX60LxUcZqQ1I0yrdYM/dLaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::22)
 by AS8PR10MB5949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:528::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 08:27:34 +0000
Received: from PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6aec:a389:7814:860f]) by PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6aec:a389:7814:860f%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:27:34 +0000
Message-ID: <cf03ce93-bd08-411c-9ca3-2a3238e38eec@kontron.de>
Date: Mon, 20 Jul 2026 10:27:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] thermal/drivers/imx: Add calibration offset
 support
To: "CHENG Haoning (BCSC/ENG1)" <Haoning.CHENG@cn.bosch.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
 <5a000235-5e17-4d54-8bbe-42fda0b59db0@kontron.de>
 <PAWPR10MB741520A95E4822E935A0B7C0C2C62@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
 <PAWPR10MB7415DE998EA3CCA639F14EF2C2C32@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <PAWPR10MB7415DE998EA3CCA639F14EF2C2C32@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:97::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4288:EE_|AS8PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9017c8-65e6-447c-5715-08dee638bfdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vfQZgyu1GC78LYUGz6kJET9aCJmQ21hu9A0zJIkaiJMJd6bA4IMjJwepdpszR4VAr+y2/eeM+A7KZyL1sF6GscOfYzmBj7W42W5nUdMJdb5OIcb8fn9X5YXJ//jt7WfrVPKJNJKD+9Ka6uZZ9k8d8lgFXd2tk25lqq2fV3DZRYOlxa5My95qv3QQXJlbo/YV6fOnzsW9JPY3buX/TXa09rWQOmqLDcXXuxthQA5GcscP+bYsixJxchHGveus/R7LVpcs7uCLXp6f0cfFNVCOJUAl33NyolkxMlF2Q42jlkHmUNTYPj/2MBnXu00PVQCL0IF4S5ZNRDYsnUkCtzwy1gYPPTNZzBsEp0VY4/CpBZWBRQPund7s5erxwflUGDCjhtolO0VP6h3vOVWoZQWn5vM8BlrH31OwAcplKyXHODK/7Cqr7P/Tiz8Td88x6DXCxVvddwvRfhzfjy4dtgrjiSqS/jWjhmmYnfJfq8tiLyTiShXzw0YKOSioP/uwqPYIE8nU9XdDwgAJeLyict2yqPn8N4SaqlX2R9EfnCjPcEwrW0Fypjz/jInGCvO6f949IwjkhGC16uoWQNYhjk/h++kHEwhWMLditiPvbuu2akEiPxS/0WWQnxw04Lsabr0TS+zT0Ywf14l8LcpHNp8zyzyDrm4FwF/xTKqViSaTVFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmVnSDFRbzM3TU1UK1ZqVXJ0bGZoZ2FtbUk1L2svQlBodGpUMis2N3FVQjFw?=
 =?utf-8?B?VEFOWTBsWkdzSVE5Y0FsdTl2UW0xb1VGU1AwVWg2WVFHL1hKdHdBQlRyMnVE?=
 =?utf-8?B?aVR6MitndTVpeUpUQW9odGtxcnJYTzVJMUNmMklaZ01Na1Q0SnJCdWxJSkgv?=
 =?utf-8?B?Sm0velJmMHAxZGVnZDUxTndlTVphdmt5elJKUTdId2NHTGVXY1ZFTEN0QmNT?=
 =?utf-8?B?UDJiTzQzckJuNitGc2lGRTVzbjlRdGNZdTZPR3l6VGk4M01kM2FBRlVGT2tR?=
 =?utf-8?B?UW9XRlVHbjhGeVh3RSszL3ErTi9qbXZkSEZEZTA1QmlLdXFTUXUyRHdxYSto?=
 =?utf-8?B?NGhqT08vU25OYTYzWHhpdU1sUk90N3JYampEa0M4ckV3emdxRVdERzhzcldX?=
 =?utf-8?B?R1VHMHN0UWRveXVvU0dtQzd2VnhYN2k2WHVteUhwVUhLMGphbG5HWU9LT2tW?=
 =?utf-8?B?ei95NjRNTTErcEx2L0MxR2I5b3JPRG5iWkZZM3RRNlhpTWpNSkg0cXBNREtW?=
 =?utf-8?B?MXFOK1ZjYldORGk1VXFJdEN6Y1k5eWtVNFgrS0wvWEVYVDRmaGV0LzROOGJM?=
 =?utf-8?B?aEEvL21LeGZxTEc3bXJPeEpEanhleVBEeUlrcnY5WjJQQURSVm8wdEFYNTVT?=
 =?utf-8?B?SWVSdDV3QXBrQXBoZm9rV1pTRUE4NitCVWpsT2hIVVBHeTZDVU1scmEwbkpM?=
 =?utf-8?B?cUp4bHN0L2JBM2JWMnJqUmdFNTR3QTViMEk5SFBaUkltOG1peG9EbE9NRHN0?=
 =?utf-8?B?cXU5WnZPMURkSDlmTlNjUXBEZW92WUhTTzc5eGtBR2NHc2JGVkUxV2tIeWY4?=
 =?utf-8?B?TjdQUEM1T2tib1pENzk1SU5YZWFVczJVZ3NTa3RVdEZrdFpnKzNyMEpSOGp4?=
 =?utf-8?B?T2c3NDZLb0QrQXk4OHRENTJqY2J0K1NMcXFDTEorbElVZndIU2wvdVI5NEtO?=
 =?utf-8?B?S0V3TjQ3QVRIa3pTd0NWMlRCelBDZVlLSTcxUys1M2NXQmtkSDE2blQvRVFn?=
 =?utf-8?B?dTI2OU1GQ3pneG5QcXFyWTRFYXovbkF4ZHRkSXFtUS82UmlnaEJSMDVmb1Fx?=
 =?utf-8?B?M1FRVHFQTGV4Y09VRXVXb1ZsVUxIeGpGekYxZ2Q1djVhWERZVzZwWEx4R3dk?=
 =?utf-8?B?TGp1NnE2N3oxNlE1RWtEYlRCdy9qQm9aUk9BMjhGMHF2OUIvRHM5QnVENmZo?=
 =?utf-8?B?b2szSWVEbVhENHhCWDliMlR4NHhOTlp0VkRtenMxZlk1UnhGM2VpK1FMNTd2?=
 =?utf-8?B?MUovNlZlSFdLTkRXWUpYZVJKUjV0REFCaWVrQmhwQVJRaHRDSDdGWDRTV3FF?=
 =?utf-8?B?azh0YmFCTjAxdmFBcFAyaElmOUNjeUVBOFZXUWpKUTVoVEpVRkhWdXR0OTdt?=
 =?utf-8?B?MjVtVk1POTA3ZjZhNllpSUo5cldlUHlrSWRkUkFJSVdnRDZiYkRFOUxPK0ky?=
 =?utf-8?B?a3ppQy9XNXNINFEzakNBVTQwK01tQ1RaTlBZdXFTU3l3WnlMUnczcWtEMmlu?=
 =?utf-8?B?N1ltSVZyQStJcitSdjR1N1ZIbGRBNzRXSFFUUmt6T1hGQWRNOXpKTHMrWFZT?=
 =?utf-8?B?TktiNWhFWjd2SmNKYUsyMlk2OVFMTDNKZ2IvYlJVZFZmdVM5WmZDVG82SGtP?=
 =?utf-8?B?cTFMZDdLNGIzTi9rMXRnblNUVTNVK3p2S3EvWnNGNDVOVE83UGUwU2VzVlhZ?=
 =?utf-8?B?SzYyR29DNFEwdUFxWkVUM0xvZXlQMnBTYXN5emRjbHczZWxNSE1HRG1SNjVN?=
 =?utf-8?B?SnRWdGtwMEY3M2c2SVNjZ2VOWnpxSFhIaEVSWXBKaDlreHhOczNDYXR3aTdn?=
 =?utf-8?B?d0FBZnFHam9CU1FJZXRranRra1lsMGZYeUtKMXBtUVJpV0pRVFFmSFJsV3lL?=
 =?utf-8?B?bHhGNU4vUjdCZURSSGUrZXFCVzB3cll6eVBiZm1yYlMrWEo0QlQrL3h5RCtE?=
 =?utf-8?B?WVIzNk1CVWRZMmUxSDdGc0xTTTR4MlRzMFB5d2xyRVZlR2ZzNWlPZldyOExr?=
 =?utf-8?B?eWl3bGQ0QWZIaFBMSmVFZi85bmlhSDYvaWRMZDg5VlVPbVU2MUxsOVZWaUJN?=
 =?utf-8?B?dmN6OU9DUWRKaitJYVVHSFE5SnZOdjhZdUcvRjFyUnRrWGk3Q1VSSG1vckc5?=
 =?utf-8?B?Y3lmYU5NQVVNZFhub2pXcC9MQk1Nb0xVVG9RV3M1WWZaaVoyMjRnNnI2VlFO?=
 =?utf-8?B?cGloNEdkeVROYkZ6d3pBZ3E2VDhsY2J6NkxEb3lYaHNKaUJrRGxxajlLRXIx?=
 =?utf-8?B?RnZ0UzFKT053R3p3UEhSTFFJZE0zc2pBWkh0U1dkUFRwemljZTFKUG5MN0kx?=
 =?utf-8?B?dXVKRmZNRW41OXJ0SzdSMnpSaGhzWDVxbGlJamxRKzFrMmxtYUthU2JwanhW?=
 =?utf-8?Q?YedFL4sefPo587Zs=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9017c8-65e6-447c-5715-08dee638bfdb
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:27:34.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H31ntylUCJu8xeOvdUig3nv1b5UOqiQW0+a2iATSIrGpbTass96EC9Pv9WvgrlGlxZMhWc4cDwug9TKFcKtqQ+ImI54QANteEuKRBKutWIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5949

On 20.07.26 04:10, CHENG Haoning (BCSC/ENG1) wrote:
> [Sie erhalten nicht h?ufig E-Mails von haoning.cheng@cn.bosch.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 2026-07-17 06:23:44+00:00, CHENG Haoning (BCSC/ENG1) wrote:
>> On Wed, Jul 15, 2026 at 11:06:07AM +0200, Frieder Schrempf wrote:
>>
>>> On 14.07.26 12:28, Haoning CHENG via B4 Relay wrote:
>>>
>>> Sorry to chime in so late. I just want to understand what this
>>> calibration offset is about. Why would there be a need of a
>>> board-specific offset? The sensor is in the SoC and if you add a
>>> board-specific offset, you no longer measure the SoC core temperature,
>>> right?
>>>
>>> How would you determine the offset in the first place? How would I know
>>> what fsl,temp-calibration-offset-millicelsius should be set to? I could
>>> put a sensor on the SoC case and use the delta as offset, but then I
>>> would just account for the thermal resistance of the casing and not
>>> measure the SoC core temperature anymore, right?
>>
>> Hi Frieder,
>>
>> Thanks for pointing this out. Your understanding is correct: after
>> applying the offset, the reported value no longer represents the raw
>> SoC die or junction temperature.
>>
>> For this board, the required "SoC temperature" is the package-surface
>> temperature. The offset was derived by comparing the TEMPMON reading
>> against a calibrated external sensor placed near the SoC package
>> surface under steady-state thermal conditions, and is used to
>> approximate the package-surface temperature from the internal TEMPMON
>> reading.
>>
>> The Linux thermal framework does not require a thermal zone to use a
>> specific temperature reference. It only requires the reported
>> temperature and trip points to use the same temperature domain.
>>
>> In this driver, the offset is added in get_temp() and subtracted in
>> set_alarm() and set_panic() when programming the hardware thresholds.
>> This keeps the reported temperature and trip points in the same
>> package-surface temperature domain. Doing this in the driver is
>> necessary because the hardware alarm thresholds must also be offset-
>> corrected; applying the offset only in userspace would cause the
>> TEMPMON IRQ to fire at the wrong die temperature.
>>
>> I agree that "calibration offset" is misleading, since this does not
>> calibrate TEMPMON to a more accurate junction temperature. In the next
>> revision, the commit messages and DT binding have been updated to
>> describe this as a board-specific conversion offset from the internal
>> sensor reading to an estimated package-surface temperature.
>>
>> Thanks,
>> Haoning
> Hi Frieder,
> 
> I need to correct my previous reply. After further discussion with our hardware team, the offset does NOT convert die temperature to package-surface temperature.
> 
> Their thermal characterization shows that the raw TEMPMON sensor reading itself deviates from the theoretical junction temperature - this deviation exists even at the die level, before any board or package influence. The offset corrects the sensor reading toward the actual junction temperature, so it is a genuine sensor calibration.
> 
> Board-level effects may contribute additionally, but they are not the primary reason for this feature. I apologize for the confusion - my earlier description was inaccurate. The v10 series reflects this corrected understanding.
Thanks for the update. If that is the case, then I would still be
interested to know:

1. How is the value for fsl,temp-calibration-offset-millicelsius
determined, if it is not provided by the SoC vendor.

2. Why do we need an additional offset, if there is already a
calibration using the value that NXP stores in the OTPs.

3. Who is supposed to set this property and where does it belong? The
SoC dtsi, the board dts?

Thanks
Frieder
