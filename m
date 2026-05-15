Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE330C144;
	Fri, 15 May 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879610; cv=fail; b=dL1XrnsCDWn7FqxIxO9HmoR68Dsn98igJZORrvudeSOmeoF1TXtU8/5EO214XMYiJhAsCBdoTrM1BCIgAk5QGgV7Ldkaczmuz4XVQ8GuQrNcV8CDN67aV8ZxXv4AEtwOb5MMRz017YZ9wxeYMN9sHgATA5zx6NiMcSJNht3gMbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879610; c=relaxed/simple;
	bh=HHqXfPiqC02Zv0O21odd7ZTyANNtYFVtgBOx8uYjdjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C37vcAR3ufWqjc5186l6JmeKiI0WMeYcPkezV/m3vDs9juPkiTx2uir5MpLB6UDl9wbQ2VkbaNO9PjZg1xr8t52csDveuYgtD+Mi9XeEcrGCCoovm+39AWlVWR+APYjxYlkdYqeRYysHtbJ7kMigCtFPrz4f1spMJkledDszRPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cPq5lhZZ; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cPq5lhZZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWrRBMsavYjO+DunDdQpQRi/pxOpKNMV+FHhahTtLDAUA0kCNpAeGyYQajxoHVl7c3+TsH2Wcxcom/UZFaSlYplxv1U8nS6DYqdncbj5H1Q/8P2coga8dAm8mfUKqzNQtwBot8pLYYno7nzi+ttrsf6mMmgmEORO4t2YHZyOw5MgAJeJsqTMczgZu5loBTXUbMqIL81Omb2NQOUlpYZvUWzPiNQz3UhfyzDiijnrMg69wmB7AU58O6jM6j96oJISslz5YV68PmVHq4Qg8LoE9JlWDqe46o1dclvD7aBbaIw8EwSrEXeI6Va3a9ivFR1Un2ryqw4DYUhWL3lEuR9FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnFkzP5o+vgRcNsplXFxDF3G50mqLctsHOICex6HK+s=;
 b=koEN9eWSdRRuD6QA3iTBu6rX4QvXwQdH/5v1f3HxPGzztJMOwUKXMOP8pX1itPXSUozHLOkqvsqjDjZwaou8OCO2T5tZE1X/xxt/+zYUiaN6kqFWPtqM5ew+BkjhFbPtLcBClsFUU4jaT3g0+vmYK8qC8nvurfhKDQNYNpyBfDdag1LRg8qwfjjL8youtgjf5Ac3q3Lj2vbsNqFa2zMfi9AmEoxAfNvRe3XUD5ehsJtd/Yp2xNo2/s+aKCA1Dgv+AoFyrkDW857VKKtuZpV/eOzcp6G7TiEhd4P4SRTSkwNavpzAmYpXMQqmZO+3XFzOoKhye3JYKq+ggVg6nFV5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnFkzP5o+vgRcNsplXFxDF3G50mqLctsHOICex6HK+s=;
 b=cPq5lhZZFlRVTm4KjXFOSdUuQdT+s/PnbwlqWp4jLpY2DkG3j1+fKewX3GDpftlbyDflYv1V+VyTTTzXvSP9c4dHttOkkChd4HjuUZnbDu6qCuQpU4x/IV/epUh99aaygmwk+dVmHs0W6PHIE2E7TjK2biMIhoCq/3CrISDw4A0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 21:13:25 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Fri, 15 May 2026
 21:13:25 +0000
Message-ID: <bf521e4e-1aa5-49ce-bec5-52845f02214e@amd.com>
Date: Fri, 15 May 2026 16:13:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260515122624.1920637-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: f29a2f41-2f09-487b-c0ad-08deb2c6cd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|4143699003|11063799003|3023799003|18002099003|56012099003|921020|22082099003;
X-Microsoft-Antispam-Message-Info:
	5AnRVaQRuKKw11cocN1xYSaMRgE4Dv4oKNe16NR3wzAROCOH/ialW/q50+s6PQDYlYRdcBOu7BVAtWh/VI/8tsgllCg329g642JlvOGzPqTtqojMQh9GbgO6gkl3EudtTf8VLUgQaClumzeYgVYQV6zC9Rz4skxh/HcbTh2tni4jzNcg/thfKm/8ieijm7GsCm8Wi45rorS5reLGon0GoA4t7bm5gZjE87RMlTGej72Y1LkyG9OptRY9Ni2xzpX5dbE1A6dadIO+3A+d57jOGKNUscQFjmw1HVyteIA7mJjoRpnr5MizTDXW8WQtV2HQZSrMe7jFD9LjIv1577IpYVF2t5Add0huK4pCThzu81WAuo+Ygr//5lYkyn0tg+VNu4r4Gv/v+TviIjyc61ytkhnbce2ktUr+Dre1ve94H4zz3hCyA3lr0luCw6oREQ+cEHqAA9qqUA9stTKsen02doCjESgtgm0z93Tno3EpY23Qc2xrwc/5y9TMRk0oXmTJRaxZrJP8903uCFO0T799twelq4ZJkZ7S/dudRvnKaVKfXiJxbEITgf2DdwtYzbLgC87jF7jjCAKLtHnnKM7MrtZba8p0TS9AtQuEWKke14eBD5cNIIlgV3uvmV+/MlFhZilMQcz+KHBVosyQbLAeoyF8LLVKz2yBR+UqqoWICg3n3VFNtvyJUap6vmGlYUlK2oM26u455sYta08vJt2/tH8tHFuUjcInBhlnloXSyJvVWQS/2WbjI8aC2fmBI87e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(4143699003)(11063799003)(3023799003)(18002099003)(56012099003)(921020)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnV2bS8ycVVYQVdtRTlJbFRGenNxdkxwY2lCT3FubWxHSlZkc3F5K2JlM3ky?=
 =?utf-8?B?OUVFNTcxcW5nOTBvdUxFcVNURDJJOGpMRDVJbk5CbDErb2EzVkNaejZyZGlk?=
 =?utf-8?B?TDh5OGtUY3owVjlkL0pDNmxoSzVsWG15R1VnSlBya2dBRjlBa3JEM3pjN0x4?=
 =?utf-8?B?OUlWbTV1aHZZQWlHSWMxVVA4YnZhVzFvSXdRcFU5ZytBNUpKTWYzNTVVOVk3?=
 =?utf-8?B?cEF0dU0vWWhLMVdaY0syUkoxRnlJTENUQitFMGo2LzFQM2dhRHZvWW50YUht?=
 =?utf-8?B?bmNVQ1dyaTYvTUhuckVZMCs1clRHVlR6OXIrdzhWeXlNWTZoN2JNc3p4Wmh5?=
 =?utf-8?B?T25HR2U4dGVYWjAzUTFRSk9rNVZBU0JhR2E0dkY2YmFwK05jaVRhSnRobHky?=
 =?utf-8?B?Ni9LWldZdi83c1NPeDFxOE85d0t1VGN1V3pQemZWaGwxTXBpYXd0RXhKa2tW?=
 =?utf-8?B?b2UxOEgzeDZBRFJMVlhlaTFwYzVtd1NiZkxGY1ZLbXVnVXVaM1pQSEVqeDY3?=
 =?utf-8?B?RTVSd1VteUsrYmpZbnhJaTFaUVFYaDg3OFlOZVNLSnF3Y1cyek9hQnRFRlVT?=
 =?utf-8?B?ZjJoeU9hSlRmWFR2SlZjNG9MeFBzM3oxTTQ5UlY4UmVGMFYwUGF3T3lhV2E4?=
 =?utf-8?B?QzBoZ3dSYUJIK3JrL2Y4aFFNVlhQQWpvaE50WFlPbEt1WW9SUzdudkZPMk5D?=
 =?utf-8?B?QXo3TVJpWU1FWVkxRlovZFF0WFd3dmhnRjRyL1VGOHJyWTF6cjRyT29qMEZQ?=
 =?utf-8?B?S2R1WWw1NmNTVDQzelA5RVFPUlBhQzRQUGJ5RjZzRzMzTnJTZm5VNG50U3NF?=
 =?utf-8?B?VDJoeDlKRS92RXFYbTFFWVgyaHVJRHJBVVpjS0xJMlBkSWhOcUQzUyszMU43?=
 =?utf-8?B?bjYva3VuRXpFcnN5c29YOVNIdGo5ekNDS1FtM1hJeTlQeSttUG5TN2xmNW1X?=
 =?utf-8?B?K2pyR2FRYlp6eUpnTktoNm1OSms4RVRDZXpocC9BN0VhcmdERHE3ZUFhL05a?=
 =?utf-8?B?OHowRDJNUk1pbkxIakExTXNPWmNiR1B5RkV3WDhUU0RIVjFpeHBqTkRFbkZI?=
 =?utf-8?B?SFl6YXBxYk43aGtCSHJqWW5Xa0U1b2FKZFQwMWp5NnFjcmZtbXR5QVNFQWpW?=
 =?utf-8?B?Mmdnamg0MGhYY09oY2lHdHFmbDFPTml3K2tPK0M5VkJkSVZjcWZtZFU2dWZ2?=
 =?utf-8?B?cm1pV3BXaEZyNGhrUzZYUmNybTB5V052UjRZVG00SXlTREpXbnpTeDRSeFFw?=
 =?utf-8?B?Qk5zSkxreExoT3J2WG9BcHI5WWR3bllNZkZzWlNHR3RJVGY0bVVVVDJxaDZt?=
 =?utf-8?B?dUc3L09CV1dYUEhlMnZJbWlWRVRISzBTLzNESmVRbmVlYlUwbjd3RXc3V3I1?=
 =?utf-8?B?RkhFeTlML01CRzN3ZWgwcFJDTFB0Y0FhUUZoMXBOOXRjUXRQaGR4aFROQXdM?=
 =?utf-8?B?Mlp0and3Z1llUDVFcVNiaXRXaVR3Lytpd0pscWZ4N0RKaFhUdFJJbmZndWp5?=
 =?utf-8?B?VjdBWDh4c213K05ab1BVdFcvd0tJbW5MYzZhdkdGZ0txUXdIRVhXNFlrNEh5?=
 =?utf-8?B?c0N4SU5meVBPcWhuUDJ1UVZQWHVBUXVFU0I0bFhjSEdTSlZKOTlWK2FqRWcy?=
 =?utf-8?B?T0RrS0VibHlrRk9mSCtBR0FDOWVRZEtnQ01KcmM2eFB5azhUKzZnTW4zVk9u?=
 =?utf-8?B?dWZxZ1hDd2t6ckhBRS9hVlByMHlWZm5ZazlzRXA2cmFDWVJrUHE2bHFib0VI?=
 =?utf-8?B?OEZYd2dWNW5aZWdsK011eVpPb0cvczFvcXhPVGx3V3BsK0xEZXp3RUFDQmoy?=
 =?utf-8?B?OFZEaW54VFFYZlc4UlZ2TEdRT1BnRWRHVXBGTEg3RXk4MzhiM2pHUURSYWpl?=
 =?utf-8?B?Y2VuNnc4Z3ZlUU01RElvNFpmNXNndjdyY0V1b1V6dStqQXhIVjk5VlpGZEVz?=
 =?utf-8?B?V0dPREt4ZC9GSnZtMU1GNDNERUpNQ2dQbkt6aFBvL3dnVjFXL3dlNmlaZUdG?=
 =?utf-8?B?elVKZ0VwL004anl4T1Z6LzVKOUN5MVFlQXduZkZZSTlnOWU1bVFCRFNxcy8r?=
 =?utf-8?B?OG5jMEgzTEtacFNCbTRRRjg5QlRhYWdRVGc0UUFidlhxSW03MnJ6ZzdwRkVR?=
 =?utf-8?B?dHZoaGlhWml5T0M1TlI0YmRwclZYdGVFbXFTY2p4cklXdldsOGJXZGlyeHox?=
 =?utf-8?B?VHJrZHM2emMyVkRpbDBiTnpKMEE2SHRoV1o3SjRYM3RMSzhyVHA2c0JVc2U3?=
 =?utf-8?B?cm9GcVBvRW8wWGZTaXh1YWN6Q3IzWHdiYW5udlFZc1I1QWo0c2Q3elA4bDdw?=
 =?utf-8?B?ZG5wY1lTMm01WThlaWIxYStuTi9UbUZQSTFZNnBoeHRqQVJkS0ptZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29a2f41-2f09-487b-c0ad-08deb2c6cd30
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 21:13:25.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi5SctPl0QwNK3TKd59QLqpDjCqcEhYMjv+I9GjM7xwzMTeFdL5GZWqEJZTnxTLc9MhEPMOEy5dhZfoSImQQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368



On 5/15/26 07:26, Sumit Gupta wrote:
> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
> CPPC autonomous performance selection on all CPUs at system startup.
> When autonomous mode is enabled, the hardware automatically adjusts
> CPU performance based on workload demands using Energy Performance
> Preference (EPP) hints.
> 
> When the parameter is set:
> - Configure all CPUs for autonomous operation on first init
> - Use HW min/max_perf when available; otherwise initialize from caps
> - Initialize desired_perf to max_perf as a starting hint
> - Hardware controls frequency instead of the OS governor
> - EPP behavior depends on parameter value:
>    - performance (or 1): override EPP to performance preference (0x0)
>    - default_epp (or 2): preserve EPP value programmed by BIOS/firmware
> 
> The boot parameter is applied only during first policy initialization.
> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
> 
> This patch depends on patch series [1] ("cpufreq: Set policy->min and
> max as real QoS constraints") so that the policy->min/max set in
> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
> during init.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> [1] https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/
> ---
>   .../admin-guide/kernel-parameters.txt         |  16 +++
>   drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++++++-
>   2 files changed, 133 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0eb64aab3685..7e4b3a8fd76f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1048,6 +1048,22 @@ Kernel parameters
>   			policy to use. This governor must be registered in the
>   			kernel before the cpufreq driver probes.
>   
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance
> +			selection. When enabled, hardware automatically adjusts
> +			CPU frequency on all CPUs based on workload demands.
> +			In Autonomous mode, Energy Performance Preference (EPP)
> +			hints guide hardware toward performance (0x0) or energy
> +			efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register
> +			support.
> +			Accepts:
> +			  performance, 1: enable auto_sel + set EPP to
> +					  performance (0x0)
> +			  default_epp, 2: enable auto_sel, preserve EPP value
> +					  programmed by BIOS/firmware
> +			Unset: cpufreq governors are used (auto_sel disabled).

Rather than unset doing nothing, have you considered having it take a 
midpoint like 128?  That's what we do in amd-pstate (default to 
balance_performance).  I think it turns into a reasonable balance.

> +
>   	cpu_init_udelay=N
>   			[X86,EARLY] Delay for N microsec between assert and de-assert
>   			of APIC INIT to start processors.  This delay occurs
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 6b54427b52e1..5f4d735e7c7d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,43 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +/* Autonomous Selection boot parameter modes */
> +enum {
> +	AUTO_SEL_PERFORMANCE = 1,
> +	AUTO_SEL_DEFAULT_EPP = 2,
> +};
> +
> +static int auto_sel_mode;
> +
> +static int auto_sel_mode_set(const char *val, const struct kernel_param *kp)
> +{
> +	if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
> +		*(int *)kp->arg = AUTO_SEL_PERFORMANCE;
> +	else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "2"))
> +		*(int *)kp->arg = AUTO_SEL_DEFAULT_EPP;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp)
> +{
> +	switch (*(int *)kp->arg) {
> +	case AUTO_SEL_PERFORMANCE:
> +		return sysfs_emit(buffer, "performance\n");
> +	case AUTO_SEL_DEFAULT_EPP:
> +		return sysfs_emit(buffer, "default_epp\n");
> +	default:
> +		return sysfs_emit(buffer, "disabled\n");
> +	}
> +}
> +
> +static const struct kernel_param_ops auto_sel_mode_ops = {
> +	.set = auto_sel_mode_set,
> +	.get = auto_sel_mode_get,
> +};
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -715,11 +752,75 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	/*
> +	 * Enable autonomous mode on first init if boot param is set.
> +	 * Check last_governor to detect first init and skip if auto_sel
> +	 * is already enabled.
> +	 */
> +	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
> +	    !cpu_data->perf_ctrls.auto_sel) {
> +		/* Init min/max_perf from caps if not already set by HW. */
> +		if (!cpu_data->perf_ctrls.min_perf)
> +			cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
> +		if (!cpu_data->perf_ctrls.max_perf)
> +			cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
> +				caps->highest_perf : caps->nominal_perf;
> +
> +		/*
> +		 * In autonomous mode desired_perf is only a hint; EPP and
> +		 * the platform drive actual selection within [min, max].
> +		 * Initialize it to max_perf so HW starts at the upper bound.
> +		 */
> +		cpu_data->perf_ctrls.desired_perf = cpu_data->perf_ctrls.max_perf;
> +
> +		policy->cur = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.desired_perf);
> +
> +		/*
> +		 * Override EPP only in 'performance' mode; 'default_epp' mode
> +		 * preserves the BIOS/firmware programmed EPP value.
> +		 * EPP is optional - some platforms may not support it.
> +		 */
> +		if (auto_sel_mode == AUTO_SEL_PERFORMANCE) {
> +			ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
> +			if (ret && ret != -EOPNOTSUPP)
> +				pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
> +			else if (!ret)
> +				cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
> +		}
> +
> +		/* Program min/max/desired into CPPC regs (non-fatal on failure). */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret)
> +			pr_warn("set_perf failed CPU%d (%d); using HW values\n",
> +				cpu, ret);
> +
> +		ret = cppc_set_auto_sel(cpu, true);
> +		if (ret && ret != -EOPNOTSUPP)
> +			pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
> +				cpu, ret);
> +		else if (!ret)
> +			cpu_data->perf_ctrls.auto_sel = true;
> +	}
> +
> +	if (cpu_data->perf_ctrls.auto_sel) {
> +		/* Sync policy limits from HW when autonomous mode is active */
> +		policy->min = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.min_perf ?:
> +					       caps->lowest_nonlinear_perf);
> +		policy->max = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.max_perf ?:
> +					       (policy->boost_enabled ?
> +						caps->highest_perf :
> +						caps->nominal_perf));
> +	} else {
> +		/* Normal mode: governors control frequency */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>   	}
>   
>   	cppc_cpufreq_cpu_fie_init(policy);
> @@ -1079,10 +1180,21 @@ static int __init cppc_cpufreq_init(void)
>   
>   static void __exit cppc_cpufreq_exit(void)
>   {
> +	unsigned int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +
>   	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>   	cppc_freq_invariance_exit();
>   }
>   
> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
> +MODULE_PARM_DESC(auto_sel_mode,
> +		 "Enable CPPC autonomous performance selection at boot: "
> +		 "performance or 1 (EPP=performance), "
> +		 "default_epp or 2 (preserve BIOS/firmware EPP)");
> +
>   module_exit(cppc_cpufreq_exit);
>   MODULE_AUTHOR("Ashwin Chaugule");
>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");

