Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889706;
	b=nlQDbD3tu+HDYiW7EhemK1GUDga/S2tB1Hf05craDooV+ob3pSbDmWL0cItLdB+ejiTg
	 dfi0Q1CmtRs6IEGxh0y4KyZys7dzDankXIkMTJnfpNgo7OFrMI9yTN72caqaKerseyw+m
	 dtz+N9XvJMhWywVovDrs6PkqIlVrl/BOYWcznuibjnSg82+nTxFauWMe+3Hnl5VdnVq3p
	 bU9GQKTWpw+E3G2arpttPsTfvvkjnimXGlsF9sn6moXxwBTfG/8BTwGMpnox/99I6sYm0
	 E9CSeCQsb72Zti5l7nqOUI0+tLeU7H/hLI3Lj5LMZfAITfoRGG7zevcgTfcpaEnOaIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889706;
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
	bh=tRi5AhML9q3WnelGuupUJdCjWPJjnaL+3YESrBVP/Z4=;
	b=4IXKfM6WkE9CLgjDv4BVXUPq9vFYxdrapZNSzujTKTlWHxHl/mG6JEL/Auzf/DATveaO
	 7fUsbUWV5AEo+mYPLBOis//AE+6wR02SK3Tr2W7SzLaDNGeyoXix0oFfO0r8TDmVeD3eB
	 z7Go+2meoYvrTKt3g9Wv3y7/MM7IDz+hEw5dwvdvWiP6NCNZYT2lVUyHqGcSugka5eIkH
	 LaBQ4HdgIVwxSd964iBW71wDTK420rwyxpgQgUilNhMvyLzWhOKb9944Q598J1OFVaVAR
	 nAfVHVBChjknoOgGfnjrVTOezhqHbFf/q+scbeM+Vdy74WaFX1MWcIzoRJ9R73Ry/gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="s7/oYPCf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.11
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47D606A31B;
	Thu,  5 Nov 2026 14:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C47D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s7/oYPCf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3HOKdZJZcoQmxy30Pk0Bb7zHnoZcYs+FQIAzUiXa70sJuUJsC7gqPORoD2gJ7AXZtvsvZo2mElfm25MYy042YzgHeD+KgQrQ/qIIaWofdGqrEmrSlY9IziWXXRiWAYrRlLQoBH0OMhKYD9Dx3nNwq8fKVoQ+gQITYrlAclPPZsaZJ6rupG6Z9oT0L6/dhfteWE87gtL0ZFZp4BkUi48fHS+Mddmf1ad5S/ug+tVq4zWBf/sebpvupSFKo5bFVZO/qQit0/aeTCTHU5YnCh47VBbkkS/JpZxIdUUkMBUp8QYwHt4qMkP0duchzO5C86MfIoCO0raf1rlqjeafpt2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRi5AhML9q3WnelGuupUJdCjWPJjnaL+3YESrBVP/Z4=;
 b=X1AOqCYxm7vJbJznRi/G+5LMLlVME2LhdZk9uqdsybydrDiGRWLX3XHoUvtApLH51Bv+L1Th9W/yeu2KIv2cIqv4F5fLZmov+O4/16KgIFyjahp4fax1yKxeH8fKnFVwiB/+TCHfbX3Obe3YATZbs23ZapFJx9X+2eEeVuQrEBxNKc2gVz1ZrWerCTXJLTOvlgqIiDtVTacgK7lx6iPHmTmWKBb5gXQ9QLRkIyL0xrOULe1oPPXxQjwaTlCJ6ou9qs8NQjyVRN9wFNqQUOxv6rY39xtyvH1UrMvdjdwWrNvCSUzRmlioHK4zX42gDSsajkvbJkADhR72LFOWgRUsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRi5AhML9q3WnelGuupUJdCjWPJjnaL+3YESrBVP/Z4=;
 b=s7/oYPCfGrWkg60ekSqp4PxZL/JHp9rujsg/S64CPxC8YmvP62rMO0ufKDP2gGGHMeHstf23/RDTKEjEKX/Mv9EyessCwtRsTbXJFi6/KcL/b7kihair0Y77z1Z78diLG7eftWrp+HL845U0Dw+MEWD7Wi71jFYFCtpdt6xWnO7xUWzDR67RpKNIOrqqTzd3K9YAl8lWxde7juIIxzLdp3xfFospiXhVPk+92ZBSkMyfoQT86xsPEde6wH2KndDPPP44KmLwSn2OZDlQbkqUxnALGGnQMg9Jz2ENdJHPMBYjzo2dx7yBmBSSjOhsXa6InXjpanfiNYHvCUEHjaQagw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by SJ2PR12MB7894.namprd12.prod.outlook.com
 (2603:10b6:a03:4c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 14:41:43 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:41:43 +0000
Message-ID: <fd2b81d0-df9c-4a07-bc47-a2a6460304f0@nvidia.com>
Date: Thu, 5 Nov 2026 20:11:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: Serialize global boost updates
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, superm1@kernel.org, zhangpengjie2@huawei.com
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-3-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20261105090311.1026648-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To CH4PR12MB720178.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a89830-87bc-4ed2-5dd5-08df3b4ae8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261102130727099003|261026140227099003|261022105027099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SmW3AjSW6lWJxccA+HZ0Hhl0XP1zw4XxFdFUbMlAXn63+xJITreh7RdtlcP/efznMgLgS0CPRMF7ByuZZno50d+Clvbb6X+ac1qo0LZxRLfgK4CeTVU22Rkvs+y2zaMsHNdz1Cw9/GjvfvihMQGv4kekh8lvrMODm0RYi6RZqAgoU3rkVNl9peA94MPXg2nu0dwSzVgSjxowE/7LHOsuzRP5zqWVf2+hVlvmD58O22i1BMcSSK0o07ikBOKkKlKRn8g/bfR74zdHa649dZgC3JAX/SZ8pKlHM92+HzHSnwWah7y8HNX9DJcJDQDMEZO15y729Lm8BMERDVUPNNIKRP+WjEGbYrtZjSbls1Prdkj3qcp1HSbgir9ukkGP1El1cmyL5WSXtHgK6i2PbWDmdg5UcsxMgexIgn0RHpNa8dC9KYpDv2nAYZqBziosFMysys8FxnSE2eI0iYR0sdJd4z++zxL9YYPGmtcA8j8blvHNHsTzrTKsAVLvKpkbIxxxFumsiQQxjg+Slr1kLooK5K5t/r0qNpbXATt7BQduEpnLo9uEHKtS38j6ZeW0jU4ONY/jUZUXvzvzKBDNyWpb0WNyfcQ3RUFiBuTnXT6krmV5mnTgBjyZkRq4KRhcEFI1rMlKHEDxUPiXAqI4fxmcyY/87DGaBtj4vpxgJnN74QQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261102130727099003)(261026140227099003)(261022105027099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2h3ZXI4MHVYRXpNVWk3SFhweVJ6NjBFWVFaeXJmL2JyTFcxZDVrczM2Szg3?=
 =?utf-8?B?L0ZaRlk4Rm42UGVPblNIbUZFa3ZxMzBjOVBnZmxTNWErTzE1Nm13RHZ3L0FO?=
 =?utf-8?B?Rnl5SjdFYUUzUnc0d2ZSMDZMZG1XdWs3MW4raGtUV3lVV1FCYlZKbVpaekVF?=
 =?utf-8?B?ZHhDMk4vd1F0enFBNkdlR0JYQzQvV3pUNW1MOVE2S3BmS3hGeUJ0bEJxRTF5?=
 =?utf-8?B?bkNzLy9mTkFtVHhzQWZLNDJUcmRkQmozUnNXSEJEYWxCNEVHUUNXMGF0UW5Q?=
 =?utf-8?B?K3U0T3p3VVFoY29WKzFQZXJxMUNqMGN1NjQ4U1BLc0VaVktXNzRUSU9NL0hy?=
 =?utf-8?B?QWtFZVFsVkF0T2RkMDJPY0YzMUttS1hUa2g4VC9zdDJlMUV5RjlyNnMyb1Jz?=
 =?utf-8?B?UzgvdTFaQ3paZ2hKSURjaXF0cm9HbVpoNDRPcTJaaUlmTXp2d2EzVGI2UnNB?=
 =?utf-8?B?TkVaMm1kVmNCcFczZXdRRnAwajBrMzJVNGdEZGFjalpDNFNPakREeW96cGsw?=
 =?utf-8?B?MkRQQTBmQTFSL3hGVko5N0FSUis4bkJMcnZpNHZIb1BYVVhsS3BvZUJpR3JR?=
 =?utf-8?B?MnNqMHlNZFNmWTVRa1g0cTIwYzRFR3huT1B2TFExWU5BbWNXd1Nka1ZoeUJs?=
 =?utf-8?B?V3dzVFZmRlFIRnZkUWdnMXpkR0IzdnhXSDR1TmF6N1NJZXFhcWRTbEIvQmN6?=
 =?utf-8?B?Z3k5VmpROG9EOCttN0c1K296ci9PVGF4d0dQSHJWOTZrZVhEMUtCdk1tK0Fo?=
 =?utf-8?B?bUx2ZjlWb2hUdFhsTFpKVjNsSlpUTEFKeUF1ekdKVDEvamhLOFdQSnpESDBz?=
 =?utf-8?B?dDU5SU9wbHR6TUVMMzU5ZjFtSENBVkJPanB6MzFKWkQxTFZiWUtIaDFUMkJP?=
 =?utf-8?B?SjFUSzV1bG4yc2VTRnlYdzhKV1doZUVMRlhwZDdUSXMyK0xUWFJvL3NiUFNY?=
 =?utf-8?B?a0FSdlIxQ2FGUnk3UzNBTGwyYTJBRXFjL0N6cHZud2hoOU9qTkhmdzhDaVBi?=
 =?utf-8?B?RjVvbW5pRXBubFJ3R2N6akFMQ0twR2xna1FCZERVVEFQVnZ2QTVTOERmRjQ5?=
 =?utf-8?B?eHJ2TitObUlvd3dPL0s4NVVwclpiWG1pL0ZkKzJObzQ3YThmZGlKb1JNVHkw?=
 =?utf-8?B?WnhQNWZYUzhvTUhsYUc0UlVETmJOS0FmZGg4ME80WEF3MmJrOUpyaVhhVS9l?=
 =?utf-8?B?WVl6WUJhbFBzNVB2TXpqZDFpMEN0WXZESlNJNFc0NUg1TXJxNGZnakt0cmkx?=
 =?utf-8?B?WEh6b1kzenlabzAxYXk1TFFGUnd1TFExdWJ2Mlg4MEJ0RjJuVm5OK2R4ZE9F?=
 =?utf-8?B?ZVhva3ZRVnRZSU9ib3FyancyQ1JFRWJnMHB0WGZ0aDBOWGpaWHRMcVBNOHFs?=
 =?utf-8?B?UDhPQXBybHhYZWVWS3l3SjVhM1o1U2VUem5Ta1dBbStUSnZBcEx4K0pqRUcw?=
 =?utf-8?B?SkRBTnZnZ3NTSE9qKy95aGFxdCtwR2dqRnFRV0dBNk13TVE5ZzVXaUhka1NH?=
 =?utf-8?B?YzFGVENzUEFLcHdMN1VBekh4eXc3S1Zmb3hqZHdVS2plZ2NqQkJiK21kMFF4?=
 =?utf-8?B?T2wwR0JKeWFTVy8vQU9rbGtEY1BQbWtTNkpUeHhEZ3lOVmlZbllEOXV2d1lr?=
 =?utf-8?B?R24wRGJEVVI5Wk1SbWVOYTZWTlg5clVMY290QWNvY1djTTd5SWs2aWQvQTZr?=
 =?utf-8?B?U1crc2d5ejlzd1g5UnIycytQUlJ4M0o5QjJNWGxleFBsTmtVT3A4R0xyRTdi?=
 =?utf-8?B?STBKMDZBZlhCbzIyQVN0MlFRdTFIV09mRkVZcmZMbEJLalhMcVVwd2pzNm1F?=
 =?utf-8?B?RW5DOHRnOEc2cmV3Y0hRdUNnck5ISFhES1hteklLSmYxak9IUnkzMDNMTFR5?=
 =?utf-8?B?K3lwbHNuN2ZlY1RMeWxnYlJLc0FuUlF0NzN1S0hsQnVEZkN5cDlVazU5VUlH?=
 =?utf-8?B?a1NHNDIzMEVlVFczeEI4MjN0WFJKN09nbHh4c1EwK3lrTEZTRkg2dVRUYm42?=
 =?utf-8?B?d1pBKzE1NW8ybjI3dW5OeGQwZGJXWGNBdVViRzU1V21zT3JJTlFUQnpMc1F6?=
 =?utf-8?B?WExVb3BYWXFTRm9Wd3k0Uk5vNmpZdi9XeFpHTURhZW9MWEkzajhNMXFRVklN?=
 =?utf-8?B?Rkh5aUp4VWxua0hwZVJQM3F2OCtHWHg1clpsSWVkKzlmdFFzRk9XODZGOHEz?=
 =?utf-8?B?ZnVYaFpRN1BBYjI5YVRVYUpWdFRLbTJjTkZZZ3NiMmpUM0lRaStvTzl2K0Q3?=
 =?utf-8?B?VW53Yk56TmFsdmxiWVRHL0JyWXlreUY4ZXdiUzdjTzE1NUJHYjQwQ3lsczVE?=
 =?utf-8?Q?Lks9XI7HBm6hst4qPZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a89830-87bc-4ed2-5dd5-08df3b4ae8a2
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:41:42.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ok9PMF9T6LOho8Slng9roM9EfpTfg+2zYyVuUBKewjpsl/Z7QCo6ugVnd4TQfjJK1sDadN86nPl6iDINJM7qyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894



On 05/11/26 14:33, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> Serialize concurrent global boost sysfs writes with a mutex.
> 
> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   drivers/cpufreq/cpufreq.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 23a77f5524df..d95c849f79c5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
> 
> +static DEFINE_MUTEX(cpufreq_boost_mutex);
> +
>   static int cpufreq_boost_trigger_state(int state)
>   {
>          struct cpufreq_policy *policy;
> @@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
>          bool boost_enabled;
>          int ret = -EOPNOTSUPP;
> 
> +       guard(mutex)(&cpufreq_boost_mutex);
> +


The policy->rwsem case from [1] seems to be still open. The per-policy
boost attribute calls policy_set_boost() with policy->rwsem held, but
cpufreq_boost_trigger_state() and cpufreq_online() don't, so they can
race with per-policy writers like ospm_nominal_freq in [1].

Could cpufreq_boost_trigger_state() take the policy lock, as
cpufreq_suspend() does?

   scoped_guard(cpufreq_policy_write, policy)
       ret = policy_set_boost(policy, state);

[1] https://lore.kernel.org/lkml/20261030172745.2045743-4-sumitg@nvidia.com/

Thanks,
Sumit

