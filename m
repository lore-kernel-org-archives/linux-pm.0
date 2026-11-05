Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889424;
	b=UTEc1QY6ThE607H2HQZUtDkJzDjpJIhe6vNoDBbvqxgt4QOXx2KrxV3ZIlbMTwQdUG8c
	 iROngj0EJ/iyY9jk8il+fO0Q3CtynadTfzI2voLO7K8bgxRkYlZqNZSIGsuxfrUYk2Uvh
	 bCexDd+SrL+R/MP63FDnR22h38XRq+rQ7OtuXeTBcVp38nECITQnXcvV+MRjFFzNnuNeu
	 hiA6fQLHKMsIZ/iOphapbpswGEBhoZWPESAjae0WcEvXnwHl3ElJn8nh8CNXqqIe8YYJZ
	 iZ8xRku4OpuZoPSSK/qxAP7K/CifxUECdeKjFfxCfxSKgJVuZhjaYG3G8oFL1mK0pZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889424;
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
	bh=ajG2PdnrQRXahTbmdG24bAnWouRPbh67ua5b0ft0fyQ=;
	b=qLZThhR9vE4hdmL8GLJgHGygxj+3lPOSms4PdT1tIPpsQfxY4oajhCYqRTISrs/W61f8
	 +OHNL3UucDIMbnQ2ARX/dUtS3Cl4jRiJ1CDL833XEfwTxgD2C7Z87+DRIkH6Ocf6+ajFR
	 eon5NLvKMUavzFuOJOH0eVw/Vl00cP/kf0SNB3h+08ZjpNfmJ6jW0VKwB7B7CmmUC5w8A
	 VRcYRCqfKfYvTBG6TM0qjQeCDcrgPu4N9E/4mH1lWkFxTwWiI5wg/lRvnljRPINv9vRQF
	 4aSzAQR8/JltGnRQk3GWx8DMT+PNQ33QUN+zXhb4frml7HnVqjjjaOeVI8KNq2KQe8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IGW44xqs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.59
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F272606A326;
	Thu,  5 Nov 2026 14:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F272606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IGW44xqs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFtS0Ib3A2Tva2yI7H1rvypAQBFXUkRjSxqRSMQHXOoF9NpCXH+LPVR6W65ZsEQd4bBag7y5BEsGHEL+yfP03UeujDbUD/7u/vrY4KkGl3dP36Ce1EHeS6O1z+FgCQQdHMrxdym78Cn2H1gfLcJiKst59xT2oIgR/hj6meHrzq9pPLJ38HQks34/5JJMxqQWUhhtlysBDS6NKrwG8Naw+2iYZVgnIPavWdVVF0UM3CDfr7+39zfJgb+2CD2nJ4lde4BZH0siMCPPYWxkPdqcs+QS5OrCAzdxKQ24iTLpt+MFfLJCZCrkLFXmMJMDIsh7BvA8KkXVlaFaNZOOpULSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajG2PdnrQRXahTbmdG24bAnWouRPbh67ua5b0ft0fyQ=;
 b=Sk9VJbPiBvK2cIqS1oyH6Bp691XuPCtEW/ImKSiah+eO5NMlJY+MeABdflKT0agy+IudGKWFfFw2NHVWDyUCRTLsvKtyS3kEuQyOVqgnwvC75IL4cM0DnFjg6iLF19a8Q4p3nw8MLgJt76qQHhyTU3X3Th0kK6IA0gftxOoByIgt8JAzJwMP30g3jk+uNuM1keDNQYiP31NMBKmGpXeOV0C9pmeo6DdPg3QNAh8xuhip3QPvViCvhU6HiyVcF2gzLCkL14jdl57NqXf+rvPP98gYgz2aLPX0qWTu8KXKhmzox2xW3p+xnEYuZMbZFiBOZLt1nPlq/BCt4YqDnCnueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajG2PdnrQRXahTbmdG24bAnWouRPbh67ua5b0ft0fyQ=;
 b=IGW44xqsh6e7/7t+QuDjO8falHCJWshMN81FNNPKVyI4jgVevgzUKo6qh3M3PlzpTWki1CDzXGZAQJf0QF9BZFo5cfK99t7CPYmiOKnLGUUTvB2wno5W9jilpauQO2wzXNfeBUjF5ycmbBRj4zBlJKdmiS53vml92mWMRllqYJXC8iSpXU1s0qxSYHtXs7UfgLaYM4w0Xz/9MotXjoBMOSdmR2A+ySrZQcSI2AP3wJcyG0YskriEXJRvk4nZqzsW7PqzysU8JO+Fhew+MGwvbnXz3qKy0/dEIFhIl/OTxcPiPseFSbnNFyk8s7BvmgTXosMP7cPRJKMqFhKYXHVdqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by LV0PR12MB999091.namprd12.prod.outlook.com
 (2603:10b6:408:32c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 14:36:57 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:36:56 +0000
Message-ID: <6fcd9a21-4ab6-48c5-ba6e-495653ac6da5@nvidia.com>
Date: Thu, 5 Nov 2026 20:06:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq: Preserve global boost state on failed
 updates
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, superm1@kernel.org, zhangpengjie2@huawei.com
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-2-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20261105090311.1026648-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::13) To CH4PR12MB720178.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: 326260f5-c65d-46ac-26bc-08df3b4a3e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|56012099006|4143699003|261009223027099003|261021121427099003|261028144727099003|261022105027099003|11063799006|261026140227099003|10067099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oLxX5gK4lyybCpkHU7IBYAVwGkft03O2YRpwiWSZpCHdmHFf4AqIfk0U2BUJHlXGgbFFwxPRg9DG1oRZp2T34dOJhRyaMOZ5XOakPWL0jb4K+5MDPzjrjuhwhQqMwdBxRMMP97iXcAFrt5c3VjwvLnbUlzGa332kwTd0WQzuCBSNDmhc4MwErT+BmuI9MEHTK8Lhw4l2zwGf0nyBupiwBUUD2emoYdZmAOfKFxYiOGhDubAfbRmylVASp7idcItXu6qf8GE5VXbX9yPVr1e0I4nT9a+76nDctkEL1f/QnLw4AhhEjzLwiD5td/uf4RqBIWVMDXlDkfvPFhvOXMrLj3rDjd3PhJjzdbI9iXWdGapZ+XPz/lABcd6c6eWOZUS2OfhBSaiAJChi7RBtpEW90G0G4Zhv3ekeJ/37e8gxcGVAJeAcR8GCEQRPn7ccVspPr9N9GA10sbNCB3kkpL2xpGchOYcTFiA8i33HIr4+5FMxGp8BK95jtBPkJMf15brnCTFOu7A0ZF35e4US0oCONtahl1fsu91Iry3uAVtuajNiAT4Xc+Alsk4eFU85aOYzbMiJJj2lk4Q1iSzS/DO6134gfrKpc5/O1FRv6LR20dOVk0hGargJfrvdhECxjJPxFjxlAjFT/+itk3k86b1/A0QBO2qp4JUi9vxKGnriILQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261028144727099003)(261022105027099003)(11063799006)(261026140227099003)(10067099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFLT1ZTRUdlQWM0SVYrRFYxZUNLL09WeXN5SDdub2owNGp0NDgxVkFsa05n?=
 =?utf-8?B?Yyt0elo2TFZwbnZGRUFHOHdQMDlBTzBVLzhLdTZuK3VTNVdNd1NwcmhBZXNG?=
 =?utf-8?B?ajNyMkRVcXUyMllCQTBOMm5oMFMzeG5PVVFqOUxtbmxoSWFPb3c1VUNEdW4v?=
 =?utf-8?B?TGZIL09HVUkwejZiM0RtMGlvZEpaZUNJdEVlWXdwWElzY292amhZK09nZXlx?=
 =?utf-8?B?QXZaRWZXMkpQMXhxZkg0NEUwbFFFSGxPTDI4SXFmeXhGQTFlVWFsa2tmVmQ5?=
 =?utf-8?B?dUtIdXdLOWQwQm1tZDlVd3liUHEyRExDQXkyM25hOGk1LzJpZjdIeHFnLzYy?=
 =?utf-8?B?THRZUjZyeXZXajZib1k0TDRjMGxkbnVmdkpEQmhPT1ZyWDRHY2FQZXAzT2pL?=
 =?utf-8?B?REZxSW9PTjNaYnU0ZDd1TGFXQXlPU0VhTlN6OEFIMUxNTkRONms0SThnTWFy?=
 =?utf-8?B?Z1Bwa0JMRFh3NmFoQlc1RG9YTkU1WEYzNGd6ZmgrSmZ5Z2JwMncxUTk4aTRk?=
 =?utf-8?B?SkFJUlFNZDA4djZVTEJWaVZtU2xiTGFiRHJGY0tjUXpiLy9HN3dwNm9YNFJh?=
 =?utf-8?B?L1MwVy9SQ1U5WHF5enFlRGNhWXk5VUs5N1NCSW9YR3U0enNJZ2VxZEN3RE1s?=
 =?utf-8?B?NjdTRmNGc2JLTk5mN3MwMXRGRklwak5mYTVhQlJQTkxqY2hGK2VRejVveE1G?=
 =?utf-8?B?OTVVa0pqWU40WXZVSEdTRWZTVGRCMWVhSFc4c0QzRzlzNHJFZmlIalh3eEN1?=
 =?utf-8?B?WUZhTGJFQ3VVclNKZGIzQktkRGxNMlZXdWdTRk5iZVhzbUROUVhKellCekJu?=
 =?utf-8?B?aXNrbThuTEF2Yy95YnVmY2RxZlNuSjYwRWlWNDRTRWMvcy9DVkxJZmhiVXVr?=
 =?utf-8?B?Zk9qNlZDc0o5MUZnbkU3R3hvbGI5c1VBS0pIVm5obmpyTk1ZMWxXVlhXL0tL?=
 =?utf-8?B?RitWVlVsUm5OMWNkRHNQOHlldVF1bEdad0R3T01PZHhZazc2N3loTHk1WHdN?=
 =?utf-8?B?SUx0aW9DRDlFajRlOXFsSzNhVFhsWndCTUtvcEV2YmJ0V1NqZmpZa0Nudko5?=
 =?utf-8?B?NUJQUFFtYVpPRHNFckFsMDMrb1d1UFd1MGlWYk0rN3N3RGNxczJUYktUdThh?=
 =?utf-8?B?OUZmb0pnMy81c0NzL1hJei9pQmhDVEdRTUxWMGhqVVd5VlVUcVpVYytaVWI5?=
 =?utf-8?B?ZGFkZkZ4QUVQRVlNRnZveFNETlRiRkprRmJuZUxNUXNzYURjU0ZnZnRnUFNW?=
 =?utf-8?B?Q2tkWmNIV0pVaWw0aDFEcjlhRjI2ak00OU9INDNORDBwZVkwYTV5TkoxcEtE?=
 =?utf-8?B?Q2swdzFRalF1N2RRQWtDZWU0SnQwNUw1VlUyUU9XaFR2eU5hZXJGNXJISnB0?=
 =?utf-8?B?a3Y1YUQ0WTB2T0hNYlJOZkxaZi9iQ0VZSC9YVnRvUTRENmVxMmdkUVNRNGpT?=
 =?utf-8?B?RVlkUkZndHFWUFJyeE9YaGZ0ODk5R2lCeDRqRG9nWVZvdFl3czNlYzRuWEYw?=
 =?utf-8?B?M1Y1STRpZzBGT05yR1hYY0RZYXUxRFJHM245U0Zta2Y4Nk9MK2VINnBpOGlU?=
 =?utf-8?B?MFYreDV3K1JxdWF2MEQyNTRMMTAvSC9XTGR0QnN4WDcxcnd4MTVVNG81a1RH?=
 =?utf-8?B?ejBsSFY2WEVBK2wweUU0NzRSNklHcFVXSHpWYk9oZ0RQRFZ3TVpwTGpvZDVK?=
 =?utf-8?B?UGkyVXJVU3VEcjFkZVdTTEgxRmEwMTdUS2xiZGczbGtJWlJ5RGttbzU3b1lH?=
 =?utf-8?B?MXZzQlNkQ0FoMU1LdXpKRE5xZUYrczl3d21jbUdhVjhaQlhKaWhjTTRqcWRC?=
 =?utf-8?B?VGVjU0tuYWhTUDRKQ3c4SjB1SURWQlkyL2UrVUtyTHplcFVVMisrMXg4RXl1?=
 =?utf-8?B?emdGNUpvU3pOelhPdjd5NUs1MXhlazhNQmZZaWRPRXFQQUx5TkZTTUd1cXpy?=
 =?utf-8?B?R0MwMUpEbE9iR1RxVkUycGpCODU1Yzh6N3FLbklJSTk4dTdpYThmK2daY1hz?=
 =?utf-8?B?ejg5L2xQaFF3K2NraUZKbUhJNndrSDBSR3B2eGR5WE1EeEEweVpOVWVXeGc3?=
 =?utf-8?B?VlV6V3c3S1o3UDhCTnRYRkpFeWpqdHdnbHpRM0V2YXAvRVhSS0w1bzZrc0o0?=
 =?utf-8?B?VEdSSWJITEdTYUVueElLOXk5dTZRU08rYjV3ZE1VMTZFYURSUmxiRzh0d2ZJ?=
 =?utf-8?B?ekoyNXNMZ2hpaVhReTlWRDVOSlNHUlFmK1VXWU9XMWR4QnpJVGw4WnAwSTA2?=
 =?utf-8?B?aENETUdyT0crRDA3aG1lb0I0SEpHVFh2VW92UGh6OTFGY0xNWEE3L2RQVFYw?=
 =?utf-8?B?Z0VzTEduYys3Q01TMloxR3lLK2ZYbjVYY0ZQRGF6WktMQllnZmNWdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326260f5-c65d-46ac-26bc-08df3b4a3e07
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:36:56.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHworu8GC3lmLtxrBDK3GwP7jivJ335XyO9mp4jaInm2+iOW5uJDAuzTCFwfjhDGBmW38ycBq6K42wiHQQzOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091



On 05/11/26 14:33, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> cpufreq_boost_trigger_state() restores the opposite of the requested
> state when updating policy boost state fails. For example, a failed
> write of 0 when global boost is already disabled enables the global
> flag without enabling any policies.
> 
> Save the original global boost state and restore it on failure.
> 
> Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>


>   drivers/cpufreq/cpufreq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..23a77f5524df 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2814,6 +2814,7 @@ static int cpufreq_boost_trigger_state(int state)
>   {
>          struct cpufreq_policy *policy;
>          unsigned long flags;
> +       bool boost_enabled;
>          int ret = -EOPNOTSUPP;
> 
>          /*
> @@ -2822,6 +2823,7 @@ static int cpufreq_boost_trigger_state(int state)
>           */
> 
>          write_lock_irqsave(&cpufreq_driver_lock, flags);
> +       boost_enabled = cpufreq_driver->boost_enabled;
>          cpufreq_driver->boost_enabled = state;
>          write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> @@ -2841,7 +2843,7 @@ static int cpufreq_boost_trigger_state(int state)
>                  return 0;
> 
>          write_lock_irqsave(&cpufreq_driver_lock, flags);
> -       cpufreq_driver->boost_enabled = !state;
> +       cpufreq_driver->boost_enabled = boost_enabled;
>          write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
>          pr_err("%s: Cannot %s BOOST\n",
> --
> 2.34.1
> 

