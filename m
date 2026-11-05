Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882252;
	b=JDTeLFkZLRG3uva5FUEDignXazPm64Mlvc/x4G2/3drYY8STu5j2MTep7A4oWOS6hRSm
	 cAh6a5+lqrpFW3vsmXaty3NUGWKGzXU1UhWg1suEFf/5UZMbVvRBeX3A3+UsPx1P7EV3w
	 gTX9uHJqr785jNEeEtRQ6QBJq78P3DLVoqKE3s4saJVCBjXo9Poepm+5SBsgGlpQaxNv7
	 ZYFDTSS9GX3KQxoN5MItPXCJEeyP/iJ63wooL4QO6Xc5jvi+o1vGdxMiRZUFT8N0TNQXJ
	 VJ6pikxHMb2/C6Oi9q3A++REopVy6DqKoWT026WQtoB+K5ou9iMIs+9GYpQuHIMgttg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882252;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=5mD/HsqFJT0BD5PiZuqrLJrVuOi84aY3Se+ZwxfzfQk=;
	b=pXbl9Ir98NkcPsPjUct5I2zwF6TckNl0sjEz1X8uWDPOmn/77nkWxfb35vpeQQh0RQQu
	 RsoHSzmaJp86AbOzBqjk3vJ+V6W85mJeX2IwEYiu2FCwDTm6t2dciAetjP+PVIR783zeb
	 zjsQo/seMiXV/1M1HdDVC3mOUJ8nX5YgqBUH25utr3yPZamtceN03PHq/au6i3h1gV1Aa
	 mw9Pw+0O7Cx0bs+TaT4uzX3QKL/fLQc/jDnekLDNSNvzXVbke7ER7BG9zudBmxZ013Kkd
	 k0lAZMetfEaSCcil0VdOLx4tSVfyYmDFcBAknll76Q0SNG93iWyrFV2DLnbtZFtwO7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cnuLunv4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.52
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A491606A326;
	Thu,  5 Nov 2026 12:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A491606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cnuLunv4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRCeENOb1s4vdwhStG82kvPW4QyLB7+lPP0GT4iLanIeiNsbknXTl8vtHaje/LFbI2PrEvwsPX6DnU0o4afOBFBhg8ASRuDGPPwF1wqALy4Kl7kOffsep+8CpZ45ln9WdvmFyHXxJUgoXlaroaruWs0VeyOllWO9n16aPP4QxLumZeud1Dwja6GgNVS+dEAIy9SErSSLTSdyYPoguHu+oXtnmsVXTuTAdDDf0GCfEWnY+v1aPHTQiIIcDglbdpYCeusHKBpA0A51gNXHRRi64NtUeuVt2aiGdjEAhvFoLPdJrXJNSNL446Bbr1LdlIV3jHCwW87p3NW9BS5zfapigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mD/HsqFJT0BD5PiZuqrLJrVuOi84aY3Se+ZwxfzfQk=;
 b=en9ekwS00xglViJeJ6iEgVJ/ebWigStlOe7zLNZzvf8h52U3RYumiJHK6jXPDMNegnEFW/k2bhYnwlikNoiwO0OjSEvyddy0HzxLFoZTGA8yQKTyrEtTgGKCHRtxOg09936GdV/+aa31RWfI9lm73IolOPkPA96ANn2BOTgHha/6zyV8zD40ckw3UCdWoEVHfjhtxs9mK5RU99btVz4XbWInbpjk0koNzlL6MqZn7faeBfvcFesT5FQ46w06D2g3NaueHKPo3R5bfLrAcyHHntz4ZxrvPVjLaAoIpAG7I6sRYas0/Ga6iVA3pZ2D73jUClaIOPd2LrOg4qcoV5zEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mD/HsqFJT0BD5PiZuqrLJrVuOi84aY3Se+ZwxfzfQk=;
 b=cnuLunv4OUjlLqKh6tW9tLYfkPYLfFT/qJRKaCup+3hY8dexiFR/vmHAsknjfgYydM0lsgsvXXTElDYIHvI3BO7n/VTzJTC6s1KI8Xzy/g9uS7MlC63FTkPINeJOzRGcXFv209opBxxUBY5L4cNIGF1JP9Rm1eT905piB87z76jjkPoZc+ofQ3Xx5Q4Nr8CwIe/RfZu2cXGLEeBFaUMI4TOY4QIbsXbP3BUfStyLsEwiyHPxQ7DU88Vq3ecnbmPNs2yi2irmUaCi7neTxMh7ojA6rJqqObpu+cAxGRJDDnyVTz6Ydica4YJoGmmhgbYpm3kkFq4QmOiFuDORdxUdLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by LV3PR12MB9265.namprd12.prod.outlook.com
 (2603:10b6:408:215::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 12:37:26 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:37:26 +0000
Message-ID: <54b3291a-f557-45c9-a963-4023e739e059@nvidia.com>
Date: Thu, 5 Nov 2026 18:07:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] cpufreq: CPPC: Set CPPC Enable register in
 cpu_init
To: Jiri Benc <jbenc@redhat.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 mario.limonciello@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260623080652.3353386-1-sumitg@nvidia.com>
 <20260623080652.3353386-2-sumitg@nvidia.com>
 <20261105105106.23238599@jbenc-thinkpadp1gen4i.rmtcz.csb>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20261105105106.23238599@jbenc-thinkpadp1gen4i.rmtcz.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::16) To CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10)
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 326c62a8-db77-43b1-1171-08df3b398c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261102123227099003|261021121427099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	1oFeAYOjNkDysBJGueUPSvFkzl1xuu8viLpGXCrq1Lk2aFf4YxQyVIr+R9u6bcG5hopLSrfk/Hy9qXb5E0Ci/TnCTwmm6cOzlh8WRcqqk8HFFCudeVgy5PIeFWcaackafUKAZsl2CGQHSx/f5Mg8G3/5xzb7qIQtL2T4Zk/C3G2HzHxU+RGxtbaWVuy0KE+hLoUARCtTl2sjhQe0ECi7e4Ege8iYbjf6tr7DyrnkgSIoM0WbYtKCWfobexSCJ69h61WLRD/oN8ZkCZI7IYgK++02mS5lDIo4T8zsLEXguisJKRvuUwAm6FoA+7E9pZDVR7ro/XFW/6WQUMXlFfgOMFNZZbA5AvdqZR+Kq1xHVyNI0ysoA5wDRBtNqxI661foGSUT/dpWYkbJVCqpkoy1zhoQfg6wMHYyFBexFvBwAyZA3NR/TZccgF9IqpttqRsi3y4uUU27J/C0m2ROlX4stLv3BDgWkKWXKrwl/4avmD9VZEHWhPPx4lBbAGIoP5+JcUj5GwCGfznXRH4E3oQl2zm6sKlxG8sQ1a5ABeGs1xHm8GsQgTUy9+GPwC2la2FTJ3aSTJO+m02WNQw9g8hIJ2dI9/cF1IigDkDP1vN3WkJwXkH7mln6xDUbjoMrGxPv4a4f1+KWbCaMdg2qQstB7Wzmro8hZj+azeTed+/7Sg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261102123227099003)(261021121427099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnI3M1dIbWc2c1doK1g0ZlY5eGVsaU11YU0zQWhjaVhmSGhDK3dmZVFyd2oy?=
 =?utf-8?B?T3Q4Y2plYWxTcnJhc1lEZlNVVnhIb3p5ZXZYUlNJMlJGT0VrL2Q0dXZ4YWs4?=
 =?utf-8?B?WTNaRWhQbWZRRjFhVndRM3I3Y0FKZ3hJZHh0c1NqWWlONUZ4S1hWY0x2ZHlx?=
 =?utf-8?B?VW1hRFo1bU9JekVpRi94bGN2b0laMGJLbGx0VEd3VW9nVDFsZ3p6VXpxS0t1?=
 =?utf-8?B?cU9nYm1xcHlzWG5VWG8vdDlOaUl2RFVrMlJuYlZ6TFl0NDFTQ1pnci9SSjZh?=
 =?utf-8?B?eHVSdEVYb0ZsaXAvVlVGejByb3g1T0VrdjFwbERwRVdWek1FNjl2TTQzaXg2?=
 =?utf-8?B?THorTUpSWG5JUXNtTDcyWklNOTh3RFFxYmhxd1VpckQ4eWMrM2xzb09kdkN4?=
 =?utf-8?B?VGVHZ3VSUi9YM1JYeC94TzZpSHJYNUxPVWVVT0NTR0RaNTBqU01EQ1V3QWha?=
 =?utf-8?B?aHRjVGJqazR1YzB4TVNvZXFPbzR2L1cvN2kzcDJmQ2I0d0hCOVVBSkluRGZ4?=
 =?utf-8?B?NlJLWUQ5TEpkRytsMjV5OVI2a0g2UEZ3clN6bmxWdkNaa3g3cEoxcWRnSXFo?=
 =?utf-8?B?aXBXMXJEUVBMMXNFOGI2UXZyVzNKM0VQZkhIOXYxUlBPekJ6Nm90b0MwU1lY?=
 =?utf-8?B?WXBUdnhOdzM3cWxhRkNLYjFhT2JQaGpZYlJhV05qS2pHYktnZThHRVJmUTRQ?=
 =?utf-8?B?VVlQb0tYaXB0U0VESkN5cDBtVHVuZnRWMFNJVFEvNlFGM0RwZm9aZ1d1YXNn?=
 =?utf-8?B?S1NvWERSUk52TFF1WER3cEpCbU0wT0RjWFpGdlM3bHNLcjFsbktMTzM3VmZz?=
 =?utf-8?B?NWliTFJlMkwrOHkweCtSd2R3bXlmQVVEamNjZnhGSU1WTlhQUStKQlRnNmYr?=
 =?utf-8?B?OCtOa3BEQjNYSDhLRjJzTVk3RkRKTVI3bFVPQ2RWMkFOTjBQdWpZa3NhZDMx?=
 =?utf-8?B?a0JWanJzenhBSUN6Rjl6djU2c2VwK3Z5R0dQWGgwU0RhQzdLeHd3eXVEVjJJ?=
 =?utf-8?B?NFd1V1JrOU1CeGhBRDhpd3dXci96alYzdmQvUVhkNkF0ZjJsVWp6ZVFBTkND?=
 =?utf-8?B?enQvaXdrbUJ6WUVLNHlnQWV6WXY1WVJseG1acktoSUI4NTlhQTNiV2ZRd083?=
 =?utf-8?B?S2lINmhzcTRqUjVsVU90QlNzcy8xRGdIVGloVncwMkhjbGh2QnJiYUkvOCtQ?=
 =?utf-8?B?aFNDUklwZEJBMWUrUDJqVGNTekFlT0Y4dlNpMTBlWU5KQVhxbFZnNWFMVC9Q?=
 =?utf-8?B?aWp0ZEFGZUMyWEZ2eG8wUDlDVHIzNnc0LzIreS84YzhMTmlQcXpxRkQxelFZ?=
 =?utf-8?B?em5aN0ozMnBOYXVMc3FTY1A5aTFZVGN2bjJ6ZTQwREMvVldiUkxDeVhld01V?=
 =?utf-8?B?QlpxOFNvWm4vVHJaaERIRk90SkpERGVFc2JmN1B3dEl3SC9WUUMzaTJBWU9I?=
 =?utf-8?B?ekNmeG9aZFQxWHpUK0d2SVNZaGJQYmY2L21zWk5zNHBBN0lQeWdNRU5rTThU?=
 =?utf-8?B?SnlWVG1rUnh1d0NIekZzV2JLRUxCTWlIL0tDdU5PeWVQRm9MRUJBR1haQ3kw?=
 =?utf-8?B?eHprQUMyNUNGdGJpMVZ3K213cVExVXhCTXpTNHM4dnBqL1FDTndXNEw4dW9y?=
 =?utf-8?B?OGNVNU5MSXVUYzJRc2o3Sy9jYngxUldnSXlJR1NhUzcxZDFmTEV1K3hhTEF3?=
 =?utf-8?B?OXhXSFBpRVRHYnJOeWduV3BiSmdud0RsNEp4MVJyaWhZK05wME41SDc0QzF0?=
 =?utf-8?B?OEpGZTM3RytzU1ppODkzSElnR29LWkRnanI1bUx0TGswRXpYZS9scEp2MWVD?=
 =?utf-8?B?YllLUHpwK1k0T0tOT2hkWitNSU5ybUcxcUdWSXlrOHlYUjRmOTU3M3loRWpQ?=
 =?utf-8?B?KzlaWEMrSVB3ZHRqUVZMdUR0NjFlbW4rbVZRSmo4Y01FS1hTeW1KNExCWEEy?=
 =?utf-8?B?eWZ0bDMvY0x5MjZjbFBCNm9NUTVjY2NhalMvK3lYZUNJSTQ3VTRRekNjU25D?=
 =?utf-8?B?aVh5Y3hxODhtYXZ4MENUdEJvaTBvUlNuWTZ5SWU3eWtveUloczN1TjNHNHhr?=
 =?utf-8?B?Qkdqa283SEVQRnB1OUFHQ0JPdEVtajl6QmE2aEd6UFRrYUFlK2c1Skt5TXhQ?=
 =?utf-8?B?andUZXQ0RGI1bkM1MExKdHphQ0xuS0pYZVVwNndqVjhvMFNucmtHeDd3M1A5?=
 =?utf-8?B?RDBXME51aVZHbVp5SG9Rc0JaTjJjbjhkZW54VkgxVVZlN2NPbWdUMUVmTkhx?=
 =?utf-8?B?WmphQU9XbzhrazR5L3hDc3dnQUdVYW93Y1pwdDRrc0hLdlBkUThjNmgrbzR4?=
 =?utf-8?B?anhmRjhEcmt4SURsNyt5c3BtYTR5VU40eU5WMXZORmEvTmRVYUZsZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326c62a8-db77-43b1-1171-08df3b398c4f
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:37:26.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXwE6khcuHOLiUtxt+J5cYmm7MGpUXpOvHamuSwBT65dq6EMOZlwUGl+zdKdGjEX7GXyfU5L+hy5LRhI+Mnkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265



On 05/11/26 15:21, Jiri Benc wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, 23 Jun 2026 13:36:51 +0530, Sumit Gupta wrote:
>> As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
>>    "If supported by the platform, OSPM writes a one to this register
>>     to enable CPPC on this processor. If not implemented, OSPM assumes
>>     the platform always has CPPC enabled."
>>
>> Call cppc_set_enable() at the start of cppc_cpufreq_cpu_init() so
>> this is done for both OS-driven and autonomous CPPC control modes.
>> Errors are logged but non-fatal as the register is optional.
> 
> Sumit, given this is a bug fix to the CPPC driver (e.g. NVIDIA GB10
> doesn't enable CPPC without writing the register, keeping the CPUs
> always at the lowest freq) and is largely unrelated to the autonomous
> mode feature, could you please resubmit this as a standalone patch?
> 
> Thanks!
> 
>   Jiri
> 

Posted separately.

https://lore.kernel.org/lkml/20261105123244.3132560-1-sumitg@nvidia.com/

Thanks,
Sumit


>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index f6cea0c54dd9..f7a47576717a 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -655,6 +655,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        caps = &cpu_data->perf_caps;
>>        policy->driver_data = cpu_data;
>>
>> +     /*
>> +      * Enable CPPC for both OS-driven and autonomous modes.
>> +      * The Enable register is optional - some platforms may not support it
>> +      */
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
>> +
>>        /*
>>         * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>>         * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
> 

