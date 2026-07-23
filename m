Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAE339386;
	Thu, 23 Jul 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834896; cv=fail; b=LPgKfNOziR/92u2WKFKlfkcVL1yz83Ed16EuhzCiTHY0pu0cQ8vrKziILEolG7C6AoI7Pr0Q2o849cQGV8TYcz9s/9YspYTH9I/m25wBudzjMG+QEtqvp5blvsb9XzvLOgyz2YMNpFXBjuTa8ln5Symt1n/lFaeSC0333I5jW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834896; c=relaxed/simple;
	bh=/YUVhNbVgQx3nkKRSZsBHMZczhJMu6GjwFkIqLwUzUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WY0amE24QKZbAn5YxHHD1Tp0wh3mIF2e6AocMezPPTjApAH3XgvhIlHe0XNvvcuqExQ62wZhyUqTE64ogJ0rnxJPzp+zU1ZtEhMLwpIQPmUp3idM6sqAqxVoawARK7fTbnZ8CrUuO4A4pf9P/WTCAzyjgqYjq9ke+7ZADsVFmPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=guC18tFQ; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="guC18tFQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlxIpq2Nrk6n3qIbts3E1c3apsk1ddyPIyQ2AnEYI2G2Qc4Bi2Ek8+tBrEDmL8M3lm7qU7AmH1x2s1+0ly9SmkHgDIXe79LA9/P6WA4EtZTChuu2kfhHI6A3GbrELBdcaui7xKxVFun/Jip2y7QLR8ZL/L4zVeCOgFF7chuipDDDL97TI16yXsaAtXT3vIp/H4MhhYAuB+GQHFvQeFY6uNqA+9yJNDbzTPl9haNdwes9eTYtJnTB6yqNmUUn1AzkO1uG83fvxCRD/LL0AvEyz7JQm/tXQIGuVxqTvDWyIg5FcpTgZdbR3qKL7Y56SAq6WGtkeYuXIPNNLKC9Rfg/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YUVhNbVgQx3nkKRSZsBHMZczhJMu6GjwFkIqLwUzUM=;
 b=fHzI9sOzX7+jW9aaHC0sCDvYs+gfhDkJ3dV2yEHxmLk55oMLECjjv7yiKeI3mO9+g0VstGKadIb29Osh/RiJdx0dd7w0Ns9ZacLptVsPsbzwdBrEYrilxU6scEDTYDAdx1IYxX/rlhKXTVviiNGlSbwjrzc5Q8wfh/ZPPG4PqX8GpstvqgxRUSBLBH8bj20F2RwgV1fioZSQyWatiKkcjAx4dJHMOQImljPDrysZcBvR//hp9S7JojfBrVaS8KETHXfJVzsbtbBhdUP9x4mADEQyHkUS5AuCZDprtncoIEscDkZ7pCxG7QgDShDx5tJJ2fddTTzxOl9dKhl4Tqxghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YUVhNbVgQx3nkKRSZsBHMZczhJMu6GjwFkIqLwUzUM=;
 b=guC18tFQxh5Fk6wQOdrilQbj0y8fGU4kX5D8pSBLlCiZmuH2K8R9EWwKR1/MtfuIZguR/jnwIj1ddzLQ1GvSJVmhv57inAwaJF1tKaV2AY23BQ4Z6Gt2xTlckmy/fNuT0qPjdfVG7yckDfHdZIWE3J8L6Wpbxl4DX9CHegykOQGRAqQmuvMTXSRLrc13wvChRW4Nyd01ldn2rQrsesmR0QE1meTCDtV2FmThm3F0AfdeKus/ICQjUUd2IVyNLsqkq9+M7f5E+GoqqwKD1qKVnzxan4erRhAl2jGFdln/28P6TpR1ZUaHgssRD2rQPcBEJ/P8PjRyfhtvy0WP+hpmfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:28:12 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:28:11 +0000
Message-ID: <53f1382c-7b70-4942-9283-bbe8bd180297@nvidia.com>
Date: Fri, 24 Jul 2026 00:58:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ACPI: CPPC: Add u64 wrappers for the autonomous
 selection register
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhanjie9@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260716153820.2007095-1-sumitg@nvidia.com>
 <20260716153820.2007095-3-sumitg@nvidia.com>
 <31525db3-a7a6-48fa-bea9-5de28a4332c4@huawei.com>
 <CAJZ5v0jGJ8HDjmnKP8HvPRqm6NKL1mzxd6=z-xDyxe6=SoNCCA@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jGJ8HDjmnKP8HvPRqm6NKL1mzxd6=z-xDyxe6=SoNCCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: ead55d9a-3cb4-45bd-fa52-08dee8f088a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MMuBRsCK1bIG2tjDARjqiXkU+MtZWUgddgvnwLGdwvpOKR1/bnZE1aJ+FWCvGmIf6ZI36uNbpD2wuOV5rX/o+ygOD7JPnP6+lyztXVI9lJcFKC+KA+TtkMVrzGnwbScRqSojgw1TspILL7AN2qMzvBRXBFRnQr48sLz1kybnc5qjYlrz0jiZQXTRaED24G8SEKzWfAQ35JpO+rCiXqkgWDuNBmB6jYPSvQhb/XT6vrCI5pXHwBB0HTEntKB0MC3DIMBo/3aApPNOgesvQEgoekI/ss3iPrawjoa0n8xgMrXgHzt5dKR59Sh/bDNXgNjTNznIFGj1pzJ8Er/sbZ/9UkeX80wygCeLb6vrTAOHypsGOSm9IWyfmtonkkxQiYnllU83hCSkEE15xCHS/XHYA/Sgn3sW81HAE4jrZCliQp0HDV0XRcYRKOfkijdvi17EmH0hndoZKXuiJlVREhxUw92TLDw7axsO8RJxqkAyCx4hEycIW6t+6kpVhLWMLTnGthooXR+b+Eu4zqrNKrcqgUuL9t9srNiosZeHkjMLhlpjuAS6cyOaaM0phwrJnoSsiLQuWlPBC61/c4hJihcoA+4he3woSEQflgwwA9UW4IrHra5GcS0zJO8HTn+LOjhoeb8oxLhePTyVBPFXRweSdZhS2GnCNGhDBD299eMaGTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJUMDZJbHp2STZJVUsrUVYrSEIxOHJrU0NFWnBxVWtXc3l4bkJJVVlYQXlZ?=
 =?utf-8?B?V0l2QWlXc1ZZblBJSGNsODhIblhmWGNqcUdMNVhQc0N5eFFPT2lFY2k3cllp?=
 =?utf-8?B?ZTZTVzVyQnlxcHE4L0h0Q0o5dmdLSlpOaXgzdEdMa1FCbjVCK21OL091aVc0?=
 =?utf-8?B?Rzl0c2tvN1cyeHFMbXBST2IvV2FhWW9UZEZHSkhHcEh0MkJCK0pXS1JDeDha?=
 =?utf-8?B?ZFlhYjFjNDY4Yk1QajdkVGtvYk9aa0dZOTJtczAyTHl1WmcwbGFTMmhpQTRG?=
 =?utf-8?B?bXF6SkU4SXRNTkZBaXlPb3NWWlBqdkw0eEdMQ1Q2SkVHdm5sV3h2elI5Yi8r?=
 =?utf-8?B?ZjRFdVBIUlZiRjEvZGM0ZEQ2cFp2UERCN0xEN1QrV1ZlUmo3cGdCZUNIQkFu?=
 =?utf-8?B?aFdJWjBYSUhRcFN1NGVzakYxaVhRWFFhNXlwcXA2VzhnSGppdlkrbnJlK2Ny?=
 =?utf-8?B?NmpyODFISlRLY3JGdDVqUmJwcTNUZEl6eEpncGxML2tNKzRrMDNxbnZ3UXNw?=
 =?utf-8?B?ZSs0cnlRQzI0WVEvc1ZFU1FYU3pnMEZMQ1R1L3NEeHBzRlJFMFZReHpBSUkw?=
 =?utf-8?B?VlJlZWhjL3habU9XYzBsZEZnTmFhY2doYy94YWJYVWRvZ0tMNVFhSTJzS3FY?=
 =?utf-8?B?ZEs2RmFIcWY2SjBvK2NPVFRrdjJwdjVvRHZKVDIwNTVyTy9wRkJKaXpKMDRO?=
 =?utf-8?B?RHpwYU9GekJYTmNQdnhkWVFhT244N2pYNlMzbWM1cTBKT1BxYlJxMzBuU3lG?=
 =?utf-8?B?WXJSTzZ4dFg5VjZ4Y1BlQkhBdnJ6U2cxeHhSU2dJNmYxeFhiUmZLTzZkSUhX?=
 =?utf-8?B?Vk5VUFVBTmdOSHNZMndma2VlWFo4U04vQ1Q3Uklkcm9KTlQ2dHZHdkw3L1gy?=
 =?utf-8?B?dzRqUWZDOVVkWnRkVmtTWHlwamwyVnFLNHYvZ1hqSG9xemRmcDVpNm5pVEdX?=
 =?utf-8?B?MUl5cXVETzdnd1YwNVVsQUNmaE5nd0hqYXpXVThEbGlvUERyU29iMFFrTVBI?=
 =?utf-8?B?enVnM0pvakFkVXk1eWtVdW03ZEd3YTFZb3ZidVlPQkhZUjlZQjZ5Zm54OWp1?=
 =?utf-8?B?ZllDUkRQcXh4Q3A4TjRpR1VMR05QQUE1Q2FocmZEbWJiczNoQ01iOGZaVXY1?=
 =?utf-8?B?Ny9QSlNwbUdQK21jejVYcExhTStRcDZ3WVJxSktzQU5ia1lsNEg0R2Q2dmNW?=
 =?utf-8?B?ek9XNEpmL3BIZjZIZlY0Umcxc1MveExwQUI5MmNCcVllRDlUbzArS3hDalFQ?=
 =?utf-8?B?YmtPS0FienVVT3hkZklkQUZFNDNFRFFpM0VWL3JkSiswS05qZXZEN0kwZ0FD?=
 =?utf-8?B?TTNzY250VWhZY2VlMUdTWWhSY2h4S2hxT3plWi9MeUFMTzFUUEZJajNjS09Q?=
 =?utf-8?B?NWFyeThxbEtpMk1rSjN4Tk1Zd3FNY3RWREpXN2Rlc1ZXcmloMWFObWlHcmdZ?=
 =?utf-8?B?OVpwWFpENVRQbzkyeE1ESGFIS1RUMVZuMHRtRGZzUmFFSFBpWDBLd2VBT3RX?=
 =?utf-8?B?TFJlQ0RMMzliVGFWdWtQMjNHT0h2WWpaTit1R2NQSU1NakNaSFdJVXYyL1Na?=
 =?utf-8?B?cDVqR3luNjg1ek1TRFRma09lUTZ3UEdya0NQUVRwenY0Zm9UNHZGWTNneTBL?=
 =?utf-8?B?dmtMZElRcE1mY1BYZXRoQSs3SXdWdFFmUklYR0swRkdLUUdqdE1FZDNPcGVs?=
 =?utf-8?B?QkQwYjNhci9YRndDdUF4eTRXNnIyNk83MFl1VzdiTytYSmpYd1duMmZZM3d1?=
 =?utf-8?B?dGlJTkRpREcweitGeERzMmxTcUFBUVgzYm9zUUVUaXJSMTZ2ODRLUXpGSjZL?=
 =?utf-8?B?WlZaZUNoZVBQZVoxS0gzekI1YS9KTHlZZUxTKys3eFZRSlpHclpzZ2lLbTl4?=
 =?utf-8?B?L2xUaWFTQzNyYzNDeXdFUXJuTTVpaXc5QmhseE42UElMdExxazU1SS9ZblpU?=
 =?utf-8?B?T0dUQ1JabStqejUrZXVpVE9lUEo1NFpvRUhoeEQxUDJ3cmhLL1h6SWFqa3RN?=
 =?utf-8?B?K29xemcwZmx1WlBOakFzcENPdDhjNHlsOHI5N3g4bGZvZXBDakxiam9ocC82?=
 =?utf-8?B?OEZBT3RiaXh4WlhkNmNrUWxHdTVqUW44R0RvVW1nM3hhYjQ0U1dwaUVLU2Iy?=
 =?utf-8?B?eWovZEgxTVljNGh6N0FibytCWXpGOGliVjBueTRDWUE5RE42MlVMSUpPcmZO?=
 =?utf-8?B?OFVkSTl3aUNnWEE3eVlkaGZ5UEI0bUlQL1N3OVVDL28zS2Z5KzIwT2xBYklO?=
 =?utf-8?B?U20vWnhmTzVCRDFncmFDcEswSkhxbTFPcWZndmg1eDd5Y3REY2RHNWorS1hp?=
 =?utf-8?Q?yYzK4ioCbc0PAeQM/s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead55d9a-3cb4-45bd-fa52-08dee8f088a1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:28:11.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hjoN9wWq2DMdY59hQuVG/AkxttTPNM/mWF3R1COaHcKo0FX6f5p9x2NIo819bpKiiEk/cnkuVtAWhUp+gAtaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792


On 21/07/26 21:04, Rafael J. Wysocki (Intel) wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Jul 17, 2026 at 5:47 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
>> On 7/16/2026 11:38 PM, Sumit Gupta wrote:
>>> cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
>>> CPPC register get/set helpers which use a u64.
>>>
>>> The next patch in this series saves and restores the OSPM-set registers
>>> across CPU hotplug using a common table of get/set helpers typed as
>>> int (*)(int, u64 *) and int (*)(int, u64), which the bool autonomous
>>> selection helpers do not fit.
>>>
>>> Add cppc_get_auto_sel_u64()/cppc_set_auto_sel_u64() wrappers with the u64
>>> signature so the autonomous selection register fits alongside the others.
>>>
>>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> If this is necessary, I think it is better to just change the input parameter
>> of the original cppc_get/set_auto_sel() to u64.
> Agreed.
>
> Sumit, why don't you just make cppc_get_auto_sel()/cppc_set_auto_sel()
> take a u64 argument

Yes, that makes sense. I originally added the wrappers to avoid changing
the existing interface, but updating them directly is cleaner.

In v3, I’ll drop the wrappers and change cppc_get/set_auto_sel() to take
a u64 directly, updating all callers accordingly.

Regards,
Sumit Gupta


