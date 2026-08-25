Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B63E49CD;
	Tue, 25 Aug 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692836; cv=fail; b=iYS6n75++VYhMeQLsPvnBhv5ig/N1/x+/5DX7qLCprLDd1yycQpue6iYIExaLDSsUQ+3UOmpq2qHVccoqhpjS8O/vZoAZyXa7PczAiVMGW6POX0+I2ui9rAXH7qSoFKGjHPz3BKpUgJwx3T0QFj0qfG3ImJB0IYzvMaFAjSFp+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692836; c=relaxed/simple;
	bh=85K0ZbzkrcN33hQ9ivp4xHYtuVl3iQWoNSi30CK2cfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JE+3tMvN7YFU6El2cIBQgY+CRNuhJOlQby8g9EfZSflLWFq+PrDl9IsIDzEvGXtSBgRFYM/Jn9Ai8Hk/y8TavKE5Wph9E2+P1qEqiLdLTxq38QK6Y/RkIplJZglOaBCPolm8ku7sPadBT191yvUoc5s/ughnjd32jByfN7YGoYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FC7je+ok; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FC7je+ok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H25Xj3qCQJCWUX/eg3hnLc9QI4sF9qHEUd1jLOon8/NaWjuCGLM4iEo9BUujE+zdkPBH9QzkQ4mksu9tubSor0M+AxzDgBfVSfftsWl1qh43OouL6+S22LWMxgSek5qQP1WfNid3CtL47/TcXT80GAHV+5bKSTSuj/n8SgiJrCiOfC9qyPKUX0x17JOIMKekW7cv3A3jd0eEUnvtSM17rtmWYzCD/MfsVRqgTisflKkLY3HvIt0+I3njAXb4S1zb13PDv6bPxbhmG96cBHioE9NFJp/Af516+GxVckuanrn1B6jUzgzBCHCqolGTLyEsqK8RdRtnsgxfohYRl+I/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg/YK0i9DDalpgmMhPEaF7gLvEIvyzANRvquthFDkvA=;
 b=EE2SniUDquxPKHid3pOWsZGaEIGHE6qKmqsLigx0fsh7SZ4m7zXvjtCJbWPYJO+wX63mZo8wsfcoW4oA00zS1HLvtuJo5x0d6cZ6wB8/Tc4X8cyI4gjfPlm6z+HZX6dwLC5zW2OZ4hqnrOCdo9kqSqk3GP/vRtlZYaNjhiN3Ct8VBDnrxwNLopo0F/SYyr68heyCj3d754SOWpAoZvbfU0OdiUrtz+4HGiSB5GpZtmwYv4OwM6ePkFy0+1l9en8db7LLbpiPf1l6dpdIqjPaCwK/vvkkFnLGdEpspz6NkNPne3ZjdmnlAqFTTl/zBaoLqiQ4+dUS45f5v6c7/FfW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg/YK0i9DDalpgmMhPEaF7gLvEIvyzANRvquthFDkvA=;
 b=FC7je+ok7y7LAj7deX4JRz/N96JWgs1cNsRP0K4a6YR8K7pGe3Y2nZj2WuWUzb9xoLYplInRz5KXRtczpWod6zhiYMxHV5vsmUbRyr7lS4BwQBsonytiyowQT4n5ofbvR5wEZo4syPkoVB++tzuJLnDuLqsh1p5mWZc+yr5c7ccQCF1IcocPnmMGanWYVkeEeKOghUQ7DyyDlfv5+kkvORwcMm1Qmoe34CfhaRMwTIK/RY8L2XFeI0A3nq92TfEEbBRGixA137y5HsFdDeUGyWEtiVxvc55SpM/C0/Fp+jKXZEzpThjPOKAHZG0wFMXpjE8eAPnkE9zDoFpXoQtDPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 21:20:26 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 21:20:26 +0000
Message-ID: <46d81167-1548-4b6a-b6cc-38542b2d093e@nvidia.com>
Date: Wed, 26 Aug 2026 02:50:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 christian.loehle@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, lenb@kernel.org, saket.dumbre@intel.com,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260806200857.601152-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f697843-5d91-472c-6c4a-08df02eeae48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5w9CwAVF47MSXKRQ9l1P7AnqZuZquAgDMAgnYGEo40gC7yl1rzOypfY02k4jkwBY4WO5VfcNQY7jIyNkg76/52jyRpBTMhB98uUzqv8xSEJWm8cYLb8RdXwUl1mz5yAtVVGP9Gau90zbB9mzm6Jz7CEpXmrxzG0RBaXPsJ5X8Ew1tWpt/lwieBvVpGr/OZuJS0qqRjRNOyysEG8rfcCjIF/CBhGx0XqFv2rC8TWRyoFaysoVmx3N93BadbIqFhgLT8rLePhZqPy+Cu++EXI+ZDOIaensRXGmfy37Rtg5kw8bOYMgX9V7G8uMZ1cm3MY1fzIkLE/mhPeDQg8CcGBJsQZA5aezVtCaqyR+bBCNnnIDlxwCOByX5uRAZN1D+fPysZEEG+waQWQolInBHUJppNb4jOdUyKGLEG3C8WKndh10isDNiJFO4zFNPXi5MFHAFwcH3E8FAqsxZxZmQzRcyn4q/G7FZw6AHtGV/7voqS/+RumLs1jXo8EKA0ZiBVjO0vUGOHYywV7tPy5TZ2IKTgSPcPaQfpuOQmJrzifgUL4gYfL9wrdjqZL/pfhc9zS0tiAQC6ib/Or+eDV2l+a7PY1cHvWqvhBvyTotoiDiHm2nkWjwPnKpFLmFRbvIrnNuIPqJel0fN3LgpQwgLTiwUPeu4w1OVblXzNAqpu1qwOwxXxsDNepzaOIvIR838h7yY2QbVtP1pAMXxCjg8lq6KQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFNlWHpwc3BQMXJyYmk0SlhKaGw4aGdVOFFwc0gwWTd4KzkxOGtwcUh6Z1ZB?=
 =?utf-8?B?a1pGOVh0aWhLdTZFUzFsWXlCd1hhbGlUczBuMmdJeHRTRGp2dHlHTXFDRmJL?=
 =?utf-8?B?RFpsd1VwNit6WW9jeUROMkdBdmNhaGR0NWtkVG5YcGhpV05CaXprNTI4RDNM?=
 =?utf-8?B?MEhmWHRQS3Z2Z3I2bllEbUhrNUdudHVLc3pBWnZ0eG5mdHZKVFNCZXp4VWM1?=
 =?utf-8?B?STBteTB2eG9qQUY5MDJIenVXMlZnaVlOaElGNUxVSVh0YmdORTNKWlViYWs4?=
 =?utf-8?B?Y1FXYyszMlBrSHVScFJVMmhpQk8zdUF0ZWhYbUVpZGNkTkdnWWpBSjNlZU1Z?=
 =?utf-8?B?R0xVYXQ2MFM0WXBzMW5ReS9CTHhyRXZQZTJ4aXhRWis4a090WG92byt4V1cx?=
 =?utf-8?B?SUtxL3FlZ2lRVFBzR0RvY1JtQ1J0aGN0QUV1YUNkd0ZIcGN6eFk5WkNDdU5s?=
 =?utf-8?B?VG40VS8wWDUzbG5uOU5iajErRmM0eWpnRDR1MUZ1M2R5c3FvNEp1R0c3c0dX?=
 =?utf-8?B?N2I2aWM4VS9DU0lIT043WWV4K1dvVGpiSXhwMlZrTXhwWUs1UFlyclQwVXBF?=
 =?utf-8?B?elNJUkRIcXJ1RHRyYTh1bTBITU5lVldiNmhxeEE2Y2pVUUNJZXlrT1ltS2JT?=
 =?utf-8?B?bFRVMXFmamhFUlc3RzNiWjhiVW8yc2Jnajl6bjJ1eklJZ1V1N0FVSXo2VS9M?=
 =?utf-8?B?byt4WWYwOFFOUHhEMWxveVduVXcwMkJ2RG1GWmdZVkFYYUYrSmgxSndJWFVB?=
 =?utf-8?B?K1VOT21CblJEcE9sSG1Vd0tjRGdOcklwd3BQWU5Za3ZvUmVlREU1T3VLaU44?=
 =?utf-8?B?SzdaVzRaTjdPUk9sUWI0MUc4V2h0QzN2T2FGMHcxVWNQaXVtSVliKzhmRDlm?=
 =?utf-8?B?cU1kWUhJQmpVQTJwWTEzek5kaVN0Q0Qxa3RTYXlZczJ4OGxzSldkNVB3SmlY?=
 =?utf-8?B?VlExaVd1REI4c0hnTXYzb043OFgrVkZud0lEMTJUY2ZtbGRHMjNhczFSMEdw?=
 =?utf-8?B?dDVWVDhFRXhQOHp0YmQwajREODNLZ21rdGpBenhpMU5qYzRrNGxvQ0JaY0dD?=
 =?utf-8?B?QjhEK1hSVi9ZUnF2QkVkeStIREF0MHh1QnM5cFN3YVg4dGVWcGMzdWc5ZjlG?=
 =?utf-8?B?NVZnUHNHYWt4c0VEcUE2eHNSMlpmY25LL08xWEdDQjVLdGVnbWJQUWhoRmcz?=
 =?utf-8?B?bmtlUUJuMHJVRTI5bXEwaDlIc2RoY1lYVEVLSzBTbEF5TEFKeUo3WTBPRDk4?=
 =?utf-8?B?NHdEQmUvN2VMd3pVT3Rab1ZGUUkrY0JWRlJ2VllxL3FtcXY3VlR5eFRyc2FR?=
 =?utf-8?B?TklNWFk3bzR6OHlpOU11MmkzY0NpSjlaQWRpb2dka2JuTzJFejN2cjRkR1FW?=
 =?utf-8?B?QTF4Vk9PRzhiNGc2dHlIaC9kWU53ZlE4amVuakVCMTMyRjA1bGN4STc5T0di?=
 =?utf-8?B?dUtsMlJrWWdGYTQ2ZkFndVpVVUU0RXZjMzVSa3E2K2FESUFoWGpOaDY1MkNs?=
 =?utf-8?B?TTBXQUF0Qk1vV2pDVVc2OFFpekhZWFVxamdWWFBGR1hWYVAraEtvVWxzeHhL?=
 =?utf-8?B?eG5WeEJjYzJEalJWQ0VqVjlBQytqN2NLVDZKNVZTQzdCVGlSbE83NXRISDA1?=
 =?utf-8?B?ak1lZ1NSMjlJbG95dDZ4OUpTWGxDUkV4Z05qeW1yMGV1TTVNQnJqalU4OXZw?=
 =?utf-8?B?cWdENk1vU1htSjhCKzNqalYwM1NzaDF0MXZVUkZtd0pGSldTa3BxTW1QZ0hS?=
 =?utf-8?B?dVNkSytoTW5CYm55SER5Z0YwSXRNQk5HRVVpeG45QzVpcjZWaGdGaHh6Lysv?=
 =?utf-8?B?OWdSZ0V5N1ZtUXFnTUUveVhFYU16SngwdWhYT1JsMXZ0KzJTREVoVXp4QWNP?=
 =?utf-8?B?YmJqaStoRjNodVZsYnJPalpZYmxvL29oR3RkTzRocmtHWFVvS09ONGJrZnJG?=
 =?utf-8?B?WWk1MzZSS1VjNVM1VDRSaFYrcmtFbWhGYklBa2lNc1hzS0tZaCtyTStXY3g5?=
 =?utf-8?B?a0MyQzUzc3E5Wi9abm41WHVmcjcxTFVKRmx5MjJkdzVoWjFKV0w0YzBRNmdw?=
 =?utf-8?B?REluUnBncFdXemhYaVBNYkNoeFFoVTJHK1VGUlBDakxRdldlNXgwZVdhSnpw?=
 =?utf-8?B?SVlCcktxODJGeTNKZDE0cHlVY0p4QS82b2lnR0dLbkJPSlowclhUSUhRSmhE?=
 =?utf-8?B?enEvQm9DTDRDZGVXeE9HQzJiUXpKOVFEaE0yaHBnV2xpdzBIWHlhcXFMRXpS?=
 =?utf-8?B?RFdHcklTNW81am1ndWxpdTFjcnQzK3lZWFUxWjAvT3V6RHNPWFA0YVhERHZw?=
 =?utf-8?Q?+jCqlr05focooq/seL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f697843-5d91-472c-6c4a-08df02eeae48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:20:26.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Htt+9SON9ZPSW2wIZMXNqnWeJSZwSYWcH1bAfti3cMrRSpN0mVIIOOHtoQhEwupUmvImLOl2VrkZBQ1PvFoRSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121


On 07/08/26 01:38, Sumit Gupta wrote:
> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
> preserves the OSPM-set CPPC registers (Energy Performance Preference,
> Autonomous Activity Window, Autonomous Selection - set via sysfs).
>
> Without online()/offline() callbacks, the core tears a policy down when
> its last CPU goes offline and rebuilds it on the way back, re-reading the
> CPPC capabilities each time. The values written to these registers can
> be lost:
>
>   - Across CPU hotplug or suspend/resume: the platform may reset them
>     while the CPU is offline.
>   - On driver unload: the driver-written value is left in the register
>     instead of returning to its pre-driver state.
>
> Handle these with:
>
>   - Patch 1: adds online()/offline() callbacks so the core keeps policy
>     alive across CPU hotplug instead of tearing it down and rebuilding it.
>   - Patch 2: makes the autonomous selection register helpers take a u64.
>   - Patch 3: adds a table-driven mechanism that captures each register's
>     firmware value at init(), restores it from offline(), and reapplies
>     the OSPM-set value from online().
>   - Patch 4: extends the same save/restore to system suspend/resume.

Gentle reminder.
Could this be considered for queuing if nothing further needs addressing.

Thanks,
Sumit


> v3[3] -> v4:
>   - Patch 1:
>     - offline() parks the perf request at lowest_perf, as exit() did.
>     - online() resyncs the frequency invariance counters.
>     - raise MAX before the perf restore when the saved MIN is above it.
>   - Patch 3:
>     - write auto_sel first when enabling it and last when disabling it.
>     - replace the four save/restore helpers into save_regs() and
>       apply_saved_regs(), each taking the firmware or requested type.
>     - keep the per-policy saved values in one struct, and name each
>       register for the pr_debug diagnostics.
>   - Patch 4:
>     - suspend() also restores the firmware values and flags it, so
>       offline() skips them and resume() only handles still-online policies.
>
> Sumit Gupta (4):
>    cpufreq: CPPC: Keep the policy across CPU hotplug
>    ACPI: CPPC: Make autonomous selection helpers take a u64
>    cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>    cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
>
>   drivers/acpi/cppc_acpi.c       |  20 +-
>   drivers/cpufreq/amd-pstate.c   |   2 +-
>   drivers/cpufreq/cppc_cpufreq.c | 369 ++++++++++++++++++++++++++++++++-
>   include/acpi/cppc_acpi.h       |   8 +-
>   4 files changed, 376 insertions(+), 23 deletions(-)
>
> [1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
> [2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
> [3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvidia.com/
>
