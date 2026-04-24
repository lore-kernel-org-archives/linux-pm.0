Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E063C3458;
	Fri, 24 Apr 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032661; cv=fail; b=UfHwzgKeXw+R+aB8ZgJXh8e3so5uwkhBHIjGbibzMmXHbm9II7G5pMXgje4P+9oy/E8Y5ehJ5biPkUPSGksh06TZeJxvTJPg4LdTCd2ECwUaFHPKPbrS+XMwEZH7Hz52q+jRobNwHgAq2h2oir4zMqO/790FEF6X/nkvhK1CE1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032661; c=relaxed/simple;
	bh=/BtVsCDUAQZ8w14xWu3W2bkiiN19J/9FwIYsKE64BSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j1UXORJg19CAdemP/QphW8ioRKfuGsCWpp2VuyP7KAbuUyt+zZOyhhRDzfRDM2bwKFsAwnqOG+n6o1PGJhdcO60CpXTQgfbAOztCf/YjNDyLIulTXqfcu7LRGZfepYxEdEj0aZs4wuHuMjLtTbaZxCDy224ohLg2wctAjCUy2rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZYLgdDNF; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZYLgdDNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvaP0KZzUER8ID3i2Vv5CR9HpQ97lTX8ar+0mZRlUgbLmUNxs3jn/N1PgOLnR0T2JPzM2g615EHgkjz4+22l5cM4XDMb37fcrybk2peHieAerxOR2PwR7WbpoD18Os91gXDwoccw3QS0NdOeMqzYhjuQD+Q4pZeBPxUZzCM834ZnJQaaOfxgMShbftMz5hdCO1kLnT6yn/V4ONETVd1Kbdu9uYF8yFhdXVCa5rvSU2Ws6MS0ifciISAk0TI2rSXWe2LeNTEFB7nN1DrdOouVF1Fhf0oXv/c+r9v9ii1PNW3dmyswX/J+FgWvXsIzS5oJ5DJmw0qLU3dVSsjDJ3gb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QtMyTQF7Gy9WUNeCXbM+DW7oKJvNV4fzk6MLh5wwW8=;
 b=okj1SKVlRMu+Fv295pquHmcaieqZd7IrKdaZbHNtN91xT7ubrJ/Xvu1bZgnXV79CfHgR/r/GqhLFgBKPs3B9FCAPn9fdG78LRnsI9skxm9QRV1OWcdcvJqG0X4nW4sFRqHwwSA5N0KW1pycIBCk1uPQPcAW/FH5P9g2fXmBpgyjzfNz2Dwb0dkgHc2i+kzi8cpQqxOPZ7MwpupKCE/4A/+KAihsrG2I2pF6TyfjS7pnQE+u5t5Sh2otmmlS7kk6fNJPO5SnXFtz7vM2lCxSA93J9/LXswV5cVuhDaLJ7q216qP7OIX+YRQMHGG3/0fx6142BWNOnMfDWA9jcaJXeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QtMyTQF7Gy9WUNeCXbM+DW7oKJvNV4fzk6MLh5wwW8=;
 b=ZYLgdDNFJ/NN0eYTFsknW+DahOGcpXFGhy80HNB2dOlKDZE8SVOy8aACWuD91EgeirNJi8hWPKNGv1OpqM9cxnxNy9PTwZmnfvCuIyn2JXX6/6CBHPttRM/1mRXdG7UpPQVo7/WPL5hV3+NOZ/pJ9XhsR/Fg9XAyFzlQpb3S3PWo3f/QEomZl64tbNt9PiwN+XmRr+wG6I95/uB/UgrnsoPYwZ+Bou1qQxHNEgZKxIDyN3j9Vg8ZseNqbKlBKrwt3PVzVctwdrewpvZD1msGMo9I2fJLtrq4BiUSTrl+tF22qW9yD52S9xR1GuKj35jgqmYUe2cFdBDRBL5biXjtrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 12:10:51 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 12:10:51 +0000
Message-ID: <8349bae0-ec72-40bb-a6cf-6232d8c0cfe2@nvidia.com>
Date: Fri, 24 Apr 2026 17:40:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
 Thierry Reding <treding@nvidia.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "ionela.voinescu@arm.com" <ionela.voinescu@arm.com>,
 Krishna Sitaraman <ksitaraman@nvidia.com>,
 Sanjay Chandrashekara <sanjayc@nvidia.com>,
 "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Matt Ochs <mochs@nvidia.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 Bibek Basu <bbasu@nvidia.com>, "rdunlap@infradead.org"
 <rdunlap@infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>, sumitg@nvidia.com
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
 <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
 <208360b1-36a5-419d-80f4-431914407f61@arm.com>
 <0fdc7e64-31aa-4bfd-ab27-dea2f349693b@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <0fdc7e64-31aa-4bfd-ab27-dea2f349693b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 96874bf1-386d-4a41-8be0-08dea1fa8695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	x8DmDy0pEWvTPD+2BSVQe6VtJniTgPDyGEdFqe6oNCo+8Do7s7VeIvGyVqgNQVv6pjKRLOg/DhxfTvjoy+kc2Xgvk/6279tcE3d+HxIloujf0RU3zmCC7LtpElJB+zg9nGyVVbwBlRd1FJPocmKjZ2/bZ8chbkSkWGF4P+7lvCw5cd1S7KB/pzBZlzNWnx5fbH8sscV6iHMLwej6Yz09TIz/79nMLD8IBX3F6yzU2O9PWcl7KcLKY9MnVHfUTv1OgUelwyePvItKPZ4VpdrDRp8ZfOaDOu4sShWhKhmZ6pcTHy8nLmXqxRuXuBz2b3k3iNRvLyL54swaYIfCrJGQ5SuzKUAQUTLSV+9sxQ4iFaOOa98bY3CPrkhz9lyE30gpnl0FdUS5JytvqQR8E+pU3c9MygECEuYgcTPhp7a8lZdcdNlcfu4jOK61nU5UfpurcvgnFsi17dgZDnoLaD/lXnaIhRtRfNFIQJmA95WXJSAenUGXJntovGeLs6KydoXeT9PrCuxCTLf2Al7NwyukXkOGCTSUCniSHtWh43WQPHluhvBRHrUcMqsU5hE1omiOhB0rW/hsLF/mtmqMLFD6T6GBIjR+ICVfE5q/lDLs0gY11v0ahteSwinr1LyMU42WPrr5PYD8kEO99ZH1U020a9en/W2z0BZp4YwaqgittOblc/jApowjM6NKxje7aSVSZvhs50qcQXkxit4X8GXIzg0Tjxkx9Il19Q0v1RWQRRi3yBR2GM29pH7Ar+gdrBP+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkR6MW9vb2JqeENPdnNaMEMvTkZQZEFuditqaTN3bkEvanVyRjlEWGZNS0xH?=
 =?utf-8?B?VG9pcjFJWUtzOW04cUliaGI5YTZ6dnpxMzBNdHB4N000YzcrUU5DcWFKNEM3?=
 =?utf-8?B?cDVZWW9KaVllSzc4SWZyZUp5VVNqb0VMOWVDQ2pSU1U4cjRGcm05blhFZUJI?=
 =?utf-8?B?Q053MHMzaDk0cW94VHp2aEJ3Q1JpMkRBRE9lKy9xdDZDSmVhcENuWEZXZ3Zs?=
 =?utf-8?B?NkNpOVZDMHpDUncvZmdtSnRnV1lGNDl2MFBUZTdYR2RvcGl4YWFCY3luL01w?=
 =?utf-8?B?YUE2eGFadEFmRkxVOHM2UEtyVEZaUngyKzRiNDVYOTN4T3RTYU5vSm9Pci9O?=
 =?utf-8?B?YkF1V08wbDdSaXlFWUlVbEd1VEVZWWFLNzZmbTlRNCt6WlV6V3FGTytMMzVH?=
 =?utf-8?B?VFA3YUNMYVNGYnhkampSakovaHpCU0FkTTFqRy96MGVpaDhEQUpWZmd5ZGxX?=
 =?utf-8?B?cUQveU8vUkF1TnZidkoySEN0ZGxITmlvcEVYV29zZ20wWU9VNE1hZjhRbTZw?=
 =?utf-8?B?Umo5OFppazYrRXlrTGZtSXRwcEJ1WFFtQVJXQVBoR3FnSDJ2M1R5ZEtRYS9h?=
 =?utf-8?B?emZVeGhPaDgzZTNCSG14NEUrWUdYTHlLdFlRdFdyTzRjRy9wRjFtcStObUFr?=
 =?utf-8?B?TlJJOEFSUCszUXQzR1RFbGFLZG85QlZsb2xrSnFNM0U2R1ZrRis1QzJ3QmlW?=
 =?utf-8?B?bHllUHNkUndLNEwyTHNjUUNnMUZUZzdOTnRub2YzajVYdUMwejM5VmQ2cUlP?=
 =?utf-8?B?WThEMmFqWEg2N2ZLN2ZiUEZ4b0hPYTExN3VSSTFnTnp1QTkyQVlMMy92Qjlp?=
 =?utf-8?B?NnluRzNyWkxycE9kczhBVDJBbVNJQ0xDM2YzbndWRUgzY3prNDdQd3hmekxj?=
 =?utf-8?B?UHhsbmQ0bzJoZlFzUzQ2NFdGbWwxVVNnUythbTdNSEJ3MURmLzZlU1VJNmF1?=
 =?utf-8?B?eHoybHNZbVZnWW0xQ2IxU0Q5UmlDSENwNWptRkxHdTdjemdrSDB6WDZML1U0?=
 =?utf-8?B?cWYvU3liNlRUS0pHNWg0VFV5NzhSZnFSU1pYN2w2WEJ4cGljYUlrbDdiNURs?=
 =?utf-8?B?b2c1L1FsOTlFTXpkdjFWRGRGcThFNThQaTFSOWpRSVJ1NmdSOEhqNEVPRUNS?=
 =?utf-8?B?RU02TENReVZocDZINTJNQldlSkZPR3VpQ2VHOG9UNHYwYXBEWGg5akFLOHBH?=
 =?utf-8?B?alh1ekRiMUFwd1RNWmh4TWZWTjFCdmppb0N6aFgrbENvZGt3SUxSZy9NOWwz?=
 =?utf-8?B?a2VqdlU4cVZNZ3JHNExnOENpc0E3TktySlRXdGpZNitnaVgydFB0R2xBZXhs?=
 =?utf-8?B?eG96ckp5T3lMOGFCUjdjNERTWnZVNXBwOEhOcks3N0swdGx3SnRZaDErdVZp?=
 =?utf-8?B?Z0lPT3p5cnlqVWhlSmVFR1QzVmVmMEdVYWtITGJJd1cvYVlOV2oyV1M0MVhv?=
 =?utf-8?B?Vm1nVGJmS1NBYWp5b3Q0WHYrRVllc3lFT2NEaFJDU1ZwdGdEWTlKLzhvYmJu?=
 =?utf-8?B?QkNLQjMyL21EWFFVcEt1eUFLMzZqL2JiUWlpcmcyUnNqZ3h1RnpvYzYzVnly?=
 =?utf-8?B?R1Vtd05PV1JjYzloVjNIMTBEQ28zanhGSk80dDhVRjZPUFRZdFF4ellDT0o3?=
 =?utf-8?B?ZnJDa1hEY0RVbEo0emZDUk5tUlEyaEtUN2ppU3JjRHZtaG9EUlpnc3dJdldC?=
 =?utf-8?B?TmxBWmJ2T1NaTkhyc1NyRmtRUjlhYTFqV1ZBbGRJakNFb3JJWDJIQW02N2gw?=
 =?utf-8?B?UUNoL21HUkZabDFOTDVzZHFwMGowVVlqSW1rcHU4cHlqdmlzNC9EYVdjcVRw?=
 =?utf-8?B?VFNpaElqeEJ2SlV4dTIxZmxsbWFXa1RlKzNDc0Q4TzhneXJPd0RYbDFvUGpz?=
 =?utf-8?B?eEpQSTRaMFBNaTdIdm1COG02aUo2MFNhcUtUUTI2bHRiUFBjL0FsSkFQV0Jo?=
 =?utf-8?B?ay9RU0JZR1JmNkR5WkZMU2JPaU8rZVZid0dmUG5OK2Y1Uk9vbDlpbnloRWtZ?=
 =?utf-8?B?SmRYa05pd2ZhMkFEc3JJdjhXb2pRMGpUSndDUmxtb3dxcTVaTHBjMnhjOVds?=
 =?utf-8?B?ZC9VbFUvdGlUVjJjNDRDdVNpdVl3aGFadEpxZ09EY0xscjJhQjV2WVJZUEhX?=
 =?utf-8?B?dDdEeVo1WG45b2hCRWh3c1pjbXRoMjBNQmVQK2M2ZG5ZNTVWaHJySTNOY21N?=
 =?utf-8?B?RTVDcnppWFNtRE1jdUZ1VzgyeTBCZy9xVGxsSjNUZUQ3OW1WblE2cDZvb05W?=
 =?utf-8?B?RmJDOFZDenBzbngvY1JBNjJ0NXRxd3RSRUVRamp0RVE4NGFGa0Z6RlRNTkxw?=
 =?utf-8?B?enBqcUJFTGRubGxwNnQ4Q0hZTjZ6eFlCc1RxYlZmWGZaaG1Zajl2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96874bf1-386d-4a41-8be0-08dea1fa8695
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 12:10:50.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3uNfOOClqZ9zrxJZfsp8PhxDGRp6g6nRzODzEg0dS0p9fhAB45vpqo8V5xF9Y0EY91PDW39ub1ep+L9O34ApA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597


On 20/04/26 18:37, Sumit Gupta wrote:
>
>>>> On 3/17/26 16:10, Sumit Gupta wrote:
>>>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>>>> autonomous performance selection on all CPUs at system startup 
>>>>> without
>>>>> requiring runtime sysfs manipulation. When autonomous mode is 
>>>>> enabled,
>>>>> the hardware automatically adjusts CPU performance based on workload
>>>>> demands using Energy Performance Preference (EPP) hints.
>>>>>
>>>>> When auto_sel_mode=1:
>>>>> - Configure all CPUs for autonomous operation on first init
>>>>> - Set EPP to performance preference (0x0)
>>>>> - Use HW min/max when set; otherwise program from policy limits 
>>>>> (caps)
>>>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>>>> - Hardware controls frequency instead of the OS governor
>>>>>
>>>>> The boot parameter is applied only during first policy 
>>>>> initialization.
>>>>> On hotplug, skip applying it so that the user's runtime sysfs
>>>>> configuration is preserved.
>>>>>
>>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>> ---
>>>>> Part 1 [1] of this series was applied for 7.1 and present in next.
>>>>> Sending this patch as reworked version of 'patch 11' from [2] based
>>>>> on next.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/ 
>>>>>
>>>>> [2]
>>>>> https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/ 
>>>>>
>>>>> ---
>>>>>    .../admin-guide/kernel-parameters.txt         | 13 +++
>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 84
>>>>> +++++++++++++++++--
>>>>>    2 files changed, 92 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index fa6171b5fdd5..de4b4c89edfe 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -1060,6 +1060,19 @@ Kernel parameters
>>>>>                        policy to use. This governor must be
>>>>> registered in the
>>>>>                        kernel before the cpufreq driver probes.
>>>>>
>>>>> +     cppc_cpufreq.auto_sel_mode=
>>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>>> performance
>>>>> +                     selection. When enabled, hardware
>>>>> automatically adjusts
>>>>> +                     CPU frequency on all CPUs based on workload
>>>>> demands.
>>>>> +                     In Autonomous mode, Energy Performance
>>>>> Preference (EPP)
>>>>> +                     hints guide hardware toward performance (0x0)
>>>>> or energy
>>>>> +                     efficiency (0xff).
>>>>> +                     Requires ACPI CPPC autonomous selection
>>>>> register support.
>>>>> +                     Format: <bool>
>>>>> +                     Default: 0 (disabled)
>>>>> +                     0: use cpufreq governors
>>>>> +                     1: enable if supported by hardware
>>>>> +
>>>>>        cpu_init_udelay=N
>>>>>                        [X86,EARLY] Delay for N microsec between
>>>>> assert and de-assert
>>>>>                        of APIC INIT to start processors. This delay
>>>>> occurs
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index 5dfb109cf1f4..49c148b2a0a4 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -28,6 +28,9 @@
>>>>>
>>>>>    static struct cpufreq_driver cppc_cpufreq_driver;
>>>>>
>>>>> +/* Autonomous Selection boot parameter */
>>>>> +static bool auto_sel_mode;
>>>>> +
>>>>>    #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>>    static enum {
>>>>>        FIE_UNSET = -1,
>>>>> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct
>>>>> cpufreq_policy *policy)
>>>>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>>        cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>>
>>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>> -     if (ret) {
>>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. 
>>>>> ret:%d\n",
>>>>> -                      caps->highest_perf, cpu, ret);
>>>>> -             goto out;
>>>>> +     /*
>>>>> +      * Enable autonomous mode on first init if boot param is set.
>>>>> +      * Check last_governor to detect first init and skip if 
>>>>> auto_sel
>>>>> +      * is already enabled.
>>>>> +      */
>>>> If the goal is to set autosel only once at the driver init,
>>>> shouldn't this be done in cppc_cpufreq_init() ?
>>>> I understand that cpu_data doesn't exist yet in
>>>> cppc_cpufreq_init(), but this seems more appropriate to do
>>>> it there IMO.
>>>>
>>>> This means the cpudata should be updated accordingly
>>>> in this cppc_cpufreq_cpu_init() function.
>>> In an earlier version [1], the setup was in cppc_cpufreq_init() but
>>> was moved to cppc_cpufreq_cpu_init() to improve per-CPU error handling.
>>> Keeping the setup in cppc_cpufreq_init() helps to avoid the 
>>> last_governor
>>> check. We can warn for a CPU failing to enable and continue so other
>>> CPUs keep autonomous mode.
>>> cppc_cpufreq_cpu_init() would then just check the auto_sel state
>>> from register and sync policy limits from min/max_perf registers when
>>> autonomous mode is active.
>>> Please let me know your thoughts.
>> FWIU the auto_sel_mode module parameter allows to
>> configure the default auto_sel_mode when the driver is
>> first loaded, so there should not need to check that again
>> whenever cppc_cpufreq_cpu_init() is called.
>> Maybe Ionela saw something we didn't see ?
>
> AFAIU, the concern in that review [1] was about error handling as the
> earlier version disabled auto_sel on all CPUs if any single CPU failed.
> Per-CPU error handling in cppc_cpufreq_init() (warn and continue)
> addresses that. Can't think of more reason.
> Do you have anything in mind?
>

Actually, one case where cppc_cpufreq_cpu_init() would be needed
is when CPUs are offline at boot. So I will keep the setup in
cppc_cpufreq_cpu_init() in v2 same as present in current version.

Thank you,
Sumit Gupta

....


