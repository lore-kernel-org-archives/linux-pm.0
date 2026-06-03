Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AD373BF4;
	Wed,  3 Jun 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510145; cv=fail; b=OzbYwIDXjTVcH6W69vXgFE0M/phsAQ2OQ1xfwO7LLFqKJ2DUpqNf0QbMC3K3hx2x8rUQW833LsANE4QZJsySPG+fa17sCdAmM4Wh18jBv8dDBaI0ERrLrHuy2yeF4TqJqYD0A7CjuTa0BG9CUKcpIcLB8QqntsXsgOwBstsSWEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510145; c=relaxed/simple;
	bh=KFYJt9B8BP2T+fMzqAggCh+Dxvl7s3WnludWGg6L5ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dMOqGKvWUVDXq+C5Df7HFWUMLlruVqKrzm+Plb2LlJt+JR/IvNHoSDtRZtn1O7+Lz16q+P7KwO20vVpYR7Ta5vaVM44bj3zrocokm8ndZK6qbm5hc5yh+OIj9y9ibj9+PBWFpvrxd7uJdXw3VaFxyYL1k5SnM5J5dGqX+rPrJ+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zHdjbnSc; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zHdjbnSc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY+f93wtj3b49gO3QkTRQjLZWljONgemt/eAtMYqP1LxMMvo7nnAg0jCp555eYA4aNXznXjxJ2UvtDDzc16cVQx9g/5N32j7ocJpryA9GLG9lnImZZsRavA7Cd3HkHe28gAcqlfqSEsFtZbRXddql0IXXQg46BI4EEjVTAB0sUksDajGEoUPbFMbyuGiSEvX/eEJKb6NBBnwQL4A1bWrT1PGgATcmkXTFi2Qq4RckGLX61HVIkf+AK/qew2smzjUm6uei5Z6XJVa5mCcdYIHxOvoUtp/t0U9CxOEqK5q8L4061FscxzMhfJRNnYpSsXBPJm1emJPWVSfWX0AZpj9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeWptkWQJ7bWNmdlLiHI/QTRIOLreDgmYllx7FoS2Ps=;
 b=AokbWpS/IwyL4nn6xXd0KTTOfuEej+yruQy3ohecixumqUcqWc0H1qp65cveus+DbQG7byC4bnGg62Lp5FjeNIccctpo9ARcVZTh51wWq6O9AsGPx5hHRYgGe0/zqklDiwiOhpLInhUw84gVpSokTlJqN01rbztDYnUhs8NdF555DGRp06GjO0FpzVlXQ3GlwKCOJaZ9txdqN3dx4VIAY6RrgD/8uEJEzKydAbVTyUOpGSv8JyCBmHLydnNgTuI985GSNEt6HUs5H6o53V7OH1060jd8r8JffNzLi50xW9da+wEWu8ngGuDZ8jrm4IBx42wQYmOstWEiYkGSs3Z8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeWptkWQJ7bWNmdlLiHI/QTRIOLreDgmYllx7FoS2Ps=;
 b=zHdjbnScyujtnS5jjpZQbl4eD8Ix1hiWyixtyUsCwWbFGE+DqxRXSPEWJjohSC3tA1Bu2bLfij+WC5lMjnoDDcFpOs4gaOXAp3ykEHTLjCv7jicY7uTjTie/yzItDy7X24fKkazJ2C1QmUCJc+GL8Es8Dbq5QVzsM225A7sG6zM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DSVPR12MB999149.namprd12.prod.outlook.com (2603:10b6:8:383::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:08:59 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:08:59 +0000
Message-ID: <bfa57f02-7005-4bca-aaac-d466e37fb662@amd.com>
Date: Wed, 3 Jun 2026 13:08:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cpufreq/amd-pstate: Fix EPP initialization and add
 capability check
Content-Language: en-US
To: Marco Scardovi <scardracs@disroot.org>, kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org, wyes.karny@amd.com
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <20260603120121.25772-1-scardracs@disroot.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260603120121.25772-1-scardracs@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:610:57::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DSVPR12MB999149:EE_
X-MS-Office365-Filtering-Correlation-Id: 08415984-9b3f-4a1a-3a3e-08dec19b2f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eiQxi4Ga9uSLMDPutvPI1n76ygJzjILFaSa6aVPZRihQjzLidVB3aX5RT+q5FjOjZtlUaBNa7FDPXdWmcIkJUV7wXL/l/ZcbBOoF044DsSLDhL42oN4s/rdGYDB0LP+3eZkF1TKh46O2LC0gY8EBL7FUmimGvE92Mu51xgINQMp96A8vZ2tU4Zo+WIZNhDNdczwcMSOdgth7HUWBsGs7GpdfzkVNkzlnYtcmPoRs/59x7y6/3RU73iizTX6myHML5zuf7Jgu26LE0HEfaa2/KUavU5u/37vZk1AlWP3rsfmifo3n9QU5awW+OYj4Xep/vUTrP+n1xD/sdus3G4NQaixCHo8LenFH59vUkiosYyh6As6fm0AgF7cPJtRuj8UNLOkWHt0TtfyUoLxr88QUEbXJ3adkRuiBv1qscojkLQdt1M6fiZHPgdsRtxWYfUFsWrCpOdaY8xuPnF3rfVL8AofMRYRu/YKI1znxJMrW7G3d0NWAGaOEbWUu/B85ZTsdPCOfZWHRZnJ6xYpyooSf/+5O1D/iWAdVkdcSQzKG/nJ7JgM7P7LW6/iNfKLx4OKDF6t5sIk//xcTiIMFaASztqhGIdexduUaWHTtORYLO1UOytq9g07ZleyW8j38oqAEj/wRdNsgOLcXVrtuEAFfIV8o4COknCEJnTx1wvTZIjCasYlUBZCl6oy3F5c/s5ug
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUtnMzRKZ01zNzFlWXBaNXNQSFUxNTJRMlJUejhPZ3dnMWRQcHAzTkVWRS80?=
 =?utf-8?B?RzNGUHdxb3Y0Qkk4MDZuWEk1Vm53MTNIMHJ1b1pzdEpNNlBRZ2RUanAxb3hT?=
 =?utf-8?B?eUl0cnhLN1Izb0hFdVA4RndBc3NRWU5xZithdVh3dGxQZW13Zm9rbUpmblh1?=
 =?utf-8?B?b3ZCdmhhNkx3OCtEOXQwTy9iNE5iZDVxa2dxcmxwbHYrb3dnc0xKMWljTXE4?=
 =?utf-8?B?Y0hDMXBNU09mSzB0N29wOVBOY2Q1VitTN1lZR1hrU3ZDZXpMV3FkWkZrVmJY?=
 =?utf-8?B?ZXJWdXV3VGh0cDUxS1JMOGdhS0ZucXA3dlZsRDFLVHJkSmgvSGhsMWVDbXBH?=
 =?utf-8?B?SGJlOW1kcmNFcWZsMTRzcTNPTWk4Vi9OWXdpTVJUbjM2N3B1a2UyWmdydWZV?=
 =?utf-8?B?djB5TkZwWGVES05Cckxxa3BqMW5DVjdGWG9jZ2NiSmxvVWx2ODZEOXpIVWVN?=
 =?utf-8?B?cWlFVEJPR0dYTitBWElxSDVibFZTZko5My84Mnl6SzYwY0lPWEdHOCtWS2tq?=
 =?utf-8?B?Q0NyNnBEaEYyNWJYOVc0cTNOSnE0dXRzTTZoQ3J5bjFuVWp3LzNOTU1xQU1l?=
 =?utf-8?B?MmxiVnpqc2tSRElnRDg2Vm5PRmprdFB2RU50WFJXazhEL1hLWDFrT3kzcm91?=
 =?utf-8?B?RDdMdy95Mkh1ZzlVVVkzb3NudmZlK2FZZ2pKaExpTDM0WXI2RVZRTDAxZlJl?=
 =?utf-8?B?UVlta1R2cEkrSjVkbW03enBqTE1wWUlVTCsvemswSG5kL0hacEhEd0tTSUd4?=
 =?utf-8?B?TjI1djkyWVJOYmRIaG5RTUp4alFaYTBldnlQdFE1RXJVWnlvRDBwZ1V0YlJE?=
 =?utf-8?B?WWNqYTB3YWF5L1NHbFY1L01XWFRsK3Noc2ZlSXhtaGVtNWZ0SE8zK0JVMENk?=
 =?utf-8?B?T25jWEcvRUpDMUtyRnArWkp6UDdwNEhlYldNUGlLSVV1M0tzdXpWR2YwL2Rr?=
 =?utf-8?B?cmZBc1c4Y3VNMkJKZlBtWGRlTnZzTkVod0RES3VjUWxkOGI1Um4xeitLUHhN?=
 =?utf-8?B?c2ZPRjFBY3A3SDNnNjRsSjU4NFA0NGJ3eHJ4LzRTRm9HYXN0MGNrdG9rcWNp?=
 =?utf-8?B?ZGU3VDNydFlMbXlsZnlVbmRZN1JKSmlTNUNKSmx5YUROK2ZNTkFJSFFwSnpW?=
 =?utf-8?B?RHh5KzJqTGJPUmc5V21icEZrUXZRRVZZcVBpZXdoUFJjSS9ka09mL3VFTWdl?=
 =?utf-8?B?RUVrcXo2RVpiYjBtOWYybDVORTBOWWFvbGhheUNJSVpYNFFtVkE0RkNCNWRK?=
 =?utf-8?B?TXVLZWJiZkZWZ1VzWGltMzZaT3FDYXRSMkVISEVWSGlmNjNwaTc0aUdrTGlm?=
 =?utf-8?B?UGVGNWpWZUhEVmdWa0NTdFpXMW1VTDhyWGtyOVRoUW1jZ3ExN0RlNXNaWlFF?=
 =?utf-8?B?eWVwd3NwMWwrQzlUQnhPdkFLMUhCU292S0pSa0d5NjJOUENIckE1aUNwcmNa?=
 =?utf-8?B?VG9vVS9PR0VHSUZqeGVZQ0VXTTlmRmJHQkxxU0JiYjFrd3NrTGRMTkZtNUs3?=
 =?utf-8?B?YW05dWRqTzl5UlI5VUZrbE5VelNKUEtqVEw4TzJ6aGtJb1hzeTBTWUNOUXhS?=
 =?utf-8?B?UHFLRDFsMG4zRVRkeUhoYUs0U01HMUR3N1pLWVZ2cDRQVXh3RzU4OWo0ZXdv?=
 =?utf-8?B?dDNVcDQvYXU5NlVzS3Njb2dRQURDSkhPdWc5K0F4NEdFOGQ3Znk1dytZV0d3?=
 =?utf-8?B?QVFQNHVFdGpyeitaa3habGpITUhRT09VRnAxUkNuSThWSjh6WEp0eG82T1JG?=
 =?utf-8?B?R21tM3JLc0UvbzZPSVBPK3lNWXJOS3FrZ2FCVVZaQ2MzY1ZkbjdiK3dnZSs3?=
 =?utf-8?B?SVZpR1Ric2phM01ybitJSWVYRGNtL3hrWllyY3o0VW5FekIwQnprYVlrMUJh?=
 =?utf-8?B?Sit4SUJqaHJDWDE2QUUwVVZoR3o3Z0xZd0lkUUVXU3cxZWJDOThyZFY5YmtZ?=
 =?utf-8?B?MklqcGcreDIxR29jUHlpSlQ0RU1sZVZlTndwTTNycmYzYWoyY3ExNUZ2REhC?=
 =?utf-8?B?dWdwbVR3d2hPbGZUZTFhcUtmNW1TYk45MDlSbHNnYzR2M3dRWGM5NCs0Uk5w?=
 =?utf-8?B?WGZ1NysxQzFCM3JJcG15TEpOcGs3YzN5VFprYWVCcDdDK0d0VTlJcjg4NDJN?=
 =?utf-8?B?cE4xRXkrK0hpUlY1blRzdXBUbEk2dzNicGQrNDFnSnFPbS9wdmxCdzhsblpI?=
 =?utf-8?B?WFdRZWRLNnNRSXRubTFFR0x2TVQyMVV5UXUveHgvTTNjVld0S1pMVTJFVWtq?=
 =?utf-8?B?OXBGdDdIRTNOV2dnRDl0aUIyYWFSZTMxa0hjZTMzSS9QbGhERjN3VTM5ZXFF?=
 =?utf-8?B?ZHNOVnhGN2VYck1CSGhoVmVaQ0NRWjJjREhMTHhpYkVPRk1sc0xIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08415984-9b3f-4a1a-3a3e-08dec19b2f19
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:08:58.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EplHcfCmrdiErrqs9TvbNH72GAnnQP6aJeHDnWMSayinlSJWuT74hvn1x5b49S7MNxSUGqCq2piAv/1KvKp7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999149



On 6/3/26 06:56, Marco Scardovi wrote:
> Hi Prateek and all,
> 
> before trying merging in @Mario's git il post the new patches with the
> changes you suggested. If something doesn't feel right let me know.
> 
> This series addresses a boot-time performance regression on shared memory
> systems where the CPU gets stuck at the lowest non-linear frequency
> (1.7GHz), and adds proper EPP capability checks to prevent active mode from
> being incorrectly enabled on systems without EPP support.
> 
> Patch 1 fixes the boot-time initialization regression by introducing an
> `epp_hw_programmed` flag in struct amd_cpudata to track whether EPP has
> been configured on the hardware. This bypasses a false cache hit on boot
> due to zero-initialized caching registers, ensuring that EPP and auto_sel
> are always written during CPU initialization, while still preserving the
> cache guard optimization for all subsequent runtime transitions.
> 
> Patch 2 implements an EPP capability check at boot time using a new
> amd_pstate_epp_supported() helper, which queries the EPP performance
> capability on the first online CPU. If EPP is unsupported, the driver falls
> back to passive mode at boot, and rejects any subsequent runtime
> transitions to active mode.
> 
> Changes in v2:
> - Patch 1: Rename `epp_initialized` to `epp_hw_programmed`, explicitly
>    document the flag semantics, and add a comment documenting the EPP cache
>    guard optimization behavior.
> - Patch 2: Add comments explaining the uniform CPU capability check on x86,
>    handle EPP capability check errors robustly using a tri-state model (only
>    treat -EOPNOTSUPP as unsupported, warn and assume supported for other
>    errors to avoid false negatives), and reject runtime active mode transitions
>    at sysfs store time (preventing the driver from being left in an
>    unregistered state).
> 
> Changes in v1:
> - Fix the boot-time CPPC EPP/auto_sel initialization regression in
>    shmem_set_epp() using a state tracking flag while preserving runtime
>    cache optimization.
> - Add an EPP capability check helper during initialization.
> - Fall back to passive mode at boot if EPP is not supported, and reject
>    transitions to active mode at runtime if EPP is not supported.
> 
> Marco Scardovi (2):
>    cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
>    cpufreq/amd-pstate: Prevent active mode on systems without EPP support
> 
>   drivers/cpufreq/amd-pstate.c | 52 +++++++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.h |  2 ++
>   2 files changed, 53 insertions(+), 1 deletion(-)
> 

Did you see Prateek's suggestion?  Can you check if that helps before we 
go down this path?

Thanks,
