Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E83DAAB1;
	Thu, 23 Jul 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835610; cv=fail; b=WpQqMAKot3MAo+OpegVQAOsXAA163zSvnpPx2s2va3piUax+sRpjpTrRBhpiXOjzGEj6m6EoH/bvKXgxa0rbxhF77JQCMtXWeCLwQu1zJfGJtFA5HqZnn+zYy5mCS22RRH6ftZ5+X61PMMDN03TD9u44XjmwS4BZOaIeS8OCzFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835610; c=relaxed/simple;
	bh=th5VGDqaFo7u6qG5tXOLUKjs/l8fbipdQZHYuh0KXg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkBIy9CCDxMF/+ayRLwvh3uam06ztpXTJkJYrutCpLcfMhm6MCRaXoNCj+v6H5YsnLC3Q6eicom7cWDq4R1jtLvMQSb3+TwZ+HwMjzxtpLEmJfpTRz8sIne2eccgtemcsflp/H6esRqB9bpl0HA+yZOR7eSzvY75mgVTJNH5NLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=szYcjCUn; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="szYcjCUn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQo3AZ0spDang4cDHtTIK5NUX0Pjvtapx8nees8CdPpj0rBJmSimkRmsaV7orFgB8dSPDJymlZU/a5Us2s3txg5zAjwTuX0wjoR9X9MRAKSgIE1j5F8n/nY0qSs19y1C7DBmn4ZXh/NqqgS/BGzjsTu4akg5gB8scFRe/BCbJAk1Ba2KqKLu0YRzckNYZ2hJ0h64CyrbPBQ188wDjJQhidWpdI9LtF4rvJgiUjrUo40ZLBbIyN/0ZJdGT8/zK13316jlCudoIbUAKlHo+1h/G/lEWc0VsTStRdh6w8NuXXpxI1qZdPjgH71ufvPmAK+oC7nDHaL39exFWCEq42tLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JXioYeriEb6U9ZkaAyNqJVGZgnZ4WLOwRXqi7ePgOY=;
 b=mjpjeWGPRGrkYDsfYNNzueMjfmI+frGe6EUbxePAHYRFU3QZn0fuPSt3jJZgGA/0Cx1z4lWfleFSX4l/XUqjtWc9uUJ59+XkE8o8oN6raEyxAbt4eWGQY4iNdfvX17O/ZntkMIw9F4QgvI1oRrdGpPI40uS6nXY/MqKDzFOZE4aX+9Wi2sPEMIZZwnOoYmefgm41ZvfmceESk7Rny/imEH6ZrA5moUzSFt4nSXQJeusWcIwvWBt9bE+IUVmyoWdbHf38DN8ltLT0AsJhKaUHWyjTujqg64pRfyXcZwlWzO7ocmRZSeWzr/29Xz9L5w+wm6h367RhTP5Y4xZH081yQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JXioYeriEb6U9ZkaAyNqJVGZgnZ4WLOwRXqi7ePgOY=;
 b=szYcjCUn1bWbTYiw35R9Mx8xGEilc6Pz1vjkN/v5qe7hTyReyINSvXvjknKzwEIa95Tej/CRS4pl2uzaKV6y3dNnwjSFHmQYp3UhXulM38MLe2gJYAJA37XPDCu7gDTpjRN82MHLva+2RY9uZepZDcPPe9816+QPQiWuh3L884T1WCkNZkDZdJypKhUAiWZbL0dMMvlbkZlXfXEAVR1Dk3xZnbyzQnrC+N5rG1sCzxN1yILstvcNcWZieDt+JzuB7DdZGTDJOtS4HQx+S3MHD9qgMrSbMBR8Po06KOsBKy86n8VGHMalN16fxPjrNqaL/1EBxhVDm8CXcyguYFO1Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 19:39:48 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:39:48 +0000
Message-ID: <3a08e892-71aa-47e9-b4eb-f545aa250620@nvidia.com>
Date: Fri, 24 Jul 2026 01:09:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260716153820.2007095-1-sumitg@nvidia.com>
 <20260716153820.2007095-4-sumitg@nvidia.com>
 <61942bf5-2ccc-4045-95e4-7fe78615e7a9@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <61942bf5-2ccc-4045-95e4-7fe78615e7a9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:262::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: edff5fb0-0ddb-4a48-0864-08dee8f227bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|5023799004|11063799006|4143699003|10067099003|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	p5h5J8zOd/ywWAnBUA6Ifz4v1YZCDpCvvPbi7xIR20MdySWrr0cZ0f9A0Pc8ZHjP1kJVOTL4QTkMnW/5BwwJICteU8K8pOQ95Vp3avq/HAfDjLk8aqiGNRUjIzwyof6p2/DCRaQ2FK/kqu2Q+IPIRSofv5vhW8th023yY5zZUVyzZrkX2CT1VRo+TtET5+a02OgPqQYTGqNog3zVghxRlAhq0WUIK3ZEOl5rcHNPACUNn0PHReUBEcopj9kTIvdDBbKG6kcNa0OUFT+DqvpeXvvizxSx7ITtx6vWGBOffiy3kTp89Z3UtFlyqjfImjOWY7zlo6DcVELG3wco9lWdG9mdhlsgQC6oMRvHlVckSHa/bkGL7p2PRiMR4cbEEOC3x+g4iYXILkw6v3f1CSEWNY4zo6zk79m6oOTJkr8CWNBM7Ry2KPsXpR2D6vsJd5pZ8svL7L/Tf7hl2NkHXkbQ/l3U95o4ONKI4u7XRUtZLsKuIRXsM267RNAy0Aal++DweRJjFK+dXUQWTIrj4eU3QQ0RC5tmKwSuF5py7fZaihfm7aCmhpHe3wouXEvTHga+gdS0NWO4oBQuVefOKQR4DjcxfMIlpz++eHIuV4cdMTOfz2hqKhdpsIBrApCckhcnlpMTBPkHl4yylscDIj3d4hMLvnr4nNGSKdHFl7R5BYdtjRat0rwydKH0pyMWhSOpmhSzdv485X5NZY2JS7gRpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0xFR3RwVEZjVFRHSXBJanAwWGUzM2g5VzdPSGRjeEJWWFJ0TGpXcVROdVdw?=
 =?utf-8?B?bzJRT21zQUtCZUdWQUoyU0ltN0xMNUw0eStGaThjWXpmeldlQ1BudXhGSGxl?=
 =?utf-8?B?aGt4ckRaUWZ5R3FRVldIbm92Y2dudmNLTXF1ZE5nMVJZTUdEaklDL1h2d2RF?=
 =?utf-8?B?MzdpSE5sVjRtWEFMdTB5RlpJbndCbnFGa1pkWGcrWlJjN0RrQzNjU0pOWmw1?=
 =?utf-8?B?NUhXV0dXQ3cxQmtPU21Sb1NZQUZ6OHg0R3YvNTVzMkZhcUhNandwek9POVY3?=
 =?utf-8?B?c2pNWU5hT1diRDJPMHhobXBqS04wendldEVKaExMd3lKcmVieGxjQ1libncw?=
 =?utf-8?B?UVVsRFpEYTFocERicUVtTGFwU3NqQ29QYmE5Y3hzZCtYcWd1NTczbnVoOUc3?=
 =?utf-8?B?dDhYaVlBaTNTcDhGaTFldzVMTWFJWENTWEtHWG9SakZwSUNVc1dXZTl1YmNo?=
 =?utf-8?B?d3JsQTZDd1hZNk55N1Q0TUpLcGhDM1VSd05sL1RqalFGc1YxYVlNWFdpblhk?=
 =?utf-8?B?Z2sxWnhMQXhPUGZJNmNQLzFDU3hzQWhZQUs3V2hLRW40WVgyenJmRkN0RkJD?=
 =?utf-8?B?cm4xNnUvY0pYdnNKcGxRQXZGdnhDV0VLS0xUbGRFVi9rblh1TzUzZXU4R2lU?=
 =?utf-8?B?cGtWN3pFbnVDNVhYYVBMbEFuV3JDdUhnaVFERjE5dkFXNjlBV3RmSnM4dS93?=
 =?utf-8?B?V3dybHVYQVJoeTducldmTlZybHNISUg2elZtMDlFR1RBVlI0VVlXTFVFZFNW?=
 =?utf-8?B?cnhVb05pMmhKK0pJaFFYejIyZU45ZzFVY1NycklwREFSN25MN3ZtSXJEZnhL?=
 =?utf-8?B?STdUbXJmblMvUnhFRnM2OFJKcEJIYXEzcmRkSDVIMXBqRHF1TW5uUC9TSmRz?=
 =?utf-8?B?SkpyaWhTckQ0eE4wNDBUcmtGOHpiZDJrcDB2akVPd2NLSC9weGZ4YXZzL3VV?=
 =?utf-8?B?Mm5rclNYSDVnRG0wNEc0dGJvV2VBSG9qZ3lkZktYYjFVOTdPQnhOQUN1TEEr?=
 =?utf-8?B?Q09mM1BVSnlmYTQyVmZBUkE1azdueXZOR1R4WG01RVZOMkVyRkdnUS9RcHVN?=
 =?utf-8?B?V2pRQ1pGS3BiekpBM0FvdFI2V1c3ZElydVhlOTJiUG1YSzdCOGdmZHVFRDdn?=
 =?utf-8?B?N0ZZek5FckZ4SVV3ZjdNTUFqL2xINHhNcC9nWHhBY0p1SW8vMlk1WTRlbkhN?=
 =?utf-8?B?MmdrKzJpeWs5WnJiQTZVaTJNNndFOHo0L1ZMT0hGdU0vdk4zTzRHMUk3T3lx?=
 =?utf-8?B?Ly9ST2tiaGtUd09acUhHTU1zZUVFRVY5Titoc3N6S1FGOFBOYk5SSk1aQ0cr?=
 =?utf-8?B?cEh6bFl4cUVqOHpsVVNvb3psemtBWjdROVBGNkgrRmwxYXhMWXhCeHlnVW1w?=
 =?utf-8?B?N2JpL3FhcUd3N2tEZzExRHBUNlVaMXloSDZsajZ2R050aWZvTkE3aHBjQ3dQ?=
 =?utf-8?B?TzI0b0c0QnlnZE1YR05kWDI4QTVBU1VtTXBDdThqUVRrZlpQUW1lbUQxV0Zi?=
 =?utf-8?B?cE1RTWJIRUJJcDZWN3FHK1B1aU8wYk8yS1Uyc1lKMCtmNUoxdmlYZGhBbHJW?=
 =?utf-8?B?MGNWUTIvenVPMXU4ZWY1cWRMQ29iTUpTMFFDUE10V1drR09IcFZjei8wZ2N1?=
 =?utf-8?B?blltb09ndXp4SWVIL2p0ekh0Vng1MHh6cDhON2VzWDhWaHNNRXp2V2Q3enpZ?=
 =?utf-8?B?cTFGWDd6MHo5WDdJR2JETnNJQTlpVHpXUytJUDNneG9mdG1KYlhLZFFOSkRo?=
 =?utf-8?B?RHFzdFB0ZVZieVJWQkZ1MytuZm4xQ1Bzblg1bGQ4cDlGbG1qeW9KVEVZUzhR?=
 =?utf-8?B?VkZRSWRoaThpYmpXUW1wNzM1czlGbWl4SGNiS3Y1MkgzazRESW9mcEx1eVNh?=
 =?utf-8?B?dFJxSE5mNndUZUJKZ09nNTYzV1ZiTjJjbkV2UHIyNnNmMmJpaWQ4QTRxUCtv?=
 =?utf-8?B?TnJEVURxV2NNZlc0ME1vVFVnZ1M2OGZadC9ocHdJUGR2R0hLaCtkVEgvVHZq?=
 =?utf-8?B?L242NEpaTkhTR3dJazBvU0pLcFZYSUQ1VzhWUHFOZEUyT1dTTlJETWpITWR4?=
 =?utf-8?B?L1I5NUorR2RBQ3NHUVFzM20zR2hTdUNsVGRXYnUwVU0xUkhEanJIWi9peVll?=
 =?utf-8?B?b2NRMG1aNUYxd2NVK0JqZUxZQlFjWWM2N2YrWmdha25Vb1lpYlZFdFdYdC9L?=
 =?utf-8?B?MUxkQzZUMExHQlpkc0s2WDZpdDY1OXhRaG5VSDNnZmZVa1UyQ0pKNDdpclBX?=
 =?utf-8?B?djJKbndqREwvc1B1aUVWR040eldtTlZzUHErYWVuYngyaWZEa1E4WmRocVRI?=
 =?utf-8?Q?u9dSyR31ADbRM5JFZB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edff5fb0-0ddb-4a48-0864-08dee8f227bb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:39:48.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m82dL2Tmu4EYdO3K+9IKCYkHsDbXNFPADaCpLiFfbIMUkSU/1fJ8lRkrHxzL0GYaJ65UTvdHF+omu++BS38zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

Hi Christian,

Thanks for the review.


On 22/07/26 15:47, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sumit
>
> On 7/16/26 16:38, Sumit Gupta wrote:
>> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
>> boot parameter) can be lost in two ways:
>>
>>    - Across CPU hotplug: the platform may reset a CPU's registers while it
>>      is offline.
>>    - On driver unload: the value the driver wrote is left in the register
>>      instead of returning to its pre-driver state.
>>
>> Add a small table-driven mechanism that handles both:
>>
>>    - On init(), capture each register's firmware value before the
>>      driver programs anything.
>>    - On offline(), read back each register's current value (whatever was
>>      last set via sysfs or the boot parameter) so it can be reapplied, then
>>      restore the firmware value.
>>    - On online(), reapply the value captured at offline().
>>
>> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
>> (EPP) and Autonomous Activity Window (auto_act_window) registers.
>>
>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 130 +++++++++++++++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 432c6a6288a7..9c88512d635c 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,123 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/*
>> + * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
>> + * the autonomous boot parameter is reapplied from online() across CPU
>> + * hotplug, and the firmware value is restored from offline().
>> + */
>> +enum cppc_saved_reg_id {
>> +     CPPC_SAVED_AUTO_SEL,
>> +     CPPC_SAVED_EPP,
>> +     CPPC_SAVED_AUTO_ACT_WINDOW,
>> +     CPPC_NR_SAVED_REGS,
>> +};
>> +
>> +struct cppc_saved_reg {
>> +     int (*get)(int cpu, u64 *val);
>> +     int (*set)(int cpu, u64 val);
>> +};
>> +
>> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>> +     [CPPC_SAVED_AUTO_SEL] = {
>> +             cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
>> +     },
>> +     [CPPC_SAVED_EPP] = {
>> +             cppc_get_epp_perf, cppc_set_epp,
>> +     },
>> +     [CPPC_SAVED_AUTO_ACT_WINDOW] = {
>> +             cppc_get_auto_act_window, cppc_set_auto_act_window,
>> +     },
>> +};
>> +
>> +/*
>> + * Per-policy saved state for each register in cppc_saved_regs[]:
>> + *   firmware_val  - value before the driver touched it, captured at init()
>> + *                   and restored while the policy is offline. U64_MAX if it
>> + *                   could not be read
>> + *   requested_val - value in effect when the policy last went offline,
>> + *                   reapplied at online(). U64_MAX if none
>> + */
>> +struct cppc_saved_state {
>> +     u64 firmware_val;
>> +     u64 requested_val;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_saved_state);
>> +
>> +/*
>> + * Return this policy's saved state. Each policy keeps a single copy, stored in
>> + * the per-CPU variable of the first CPU it manages. related_cpus (the policy's
>> + * full set of CPUs) never changes while it exists, so this CPU (unlike
>> + * policy->cpu) stays the same across CPU hotplug, and every callback reaches
>> + * the same copy.
>> + */
>> +static struct cppc_saved_state *cppc_cpufreq_policy_saved_state(struct cpufreq_policy *policy)
>> +{
>> +     const struct cpumask *policy_cpus = policy->related_cpus;
>> +
>> +     /*
>> +      * related_cpus is empty until the core fills it in after init(). Until
>> +      * then, fall back to policy->cpus, which has the same first CPU.
>> +      */
>> +     if (cpumask_empty(policy_cpus))
>> +             policy_cpus = policy->cpus;
>> +
>> +     return per_cpu(cppc_saved_state, cpumask_first(policy_cpus));
>> +}
>> +
>> +/*
>> + * Capture each register's firmware value before the driver programs anything.
>> + */
>> +static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
>> +     unsigned int cpu = policy->cpu;
>> +     u64 val;
>> +     int i;
>> +
>> +     for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +             if (cppc_saved_regs[i].get(cpu, &val))
>> +                     val = U64_MAX;
>> +             st[i].firmware_val = val;
>> +             st[i].requested_val = U64_MAX;
>> +     }
>> +}
>> +
>> +/*
>> + * Save each register's current value so online() can later reapply it, then
>> + * restore the firmware value to leave the platform in its pre-driver state.
>> + */
>> +static void
>> +cppc_cpufreq_save_req_and_restore_firmware_regs(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
>> +     unsigned int cpu = policy->cpu;
>> +     u64 val;
>> +     int i;
>> +
>> +     for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +             if (!cppc_saved_regs[i].get(cpu, &val))
>> +                     st[i].requested_val = val;
>> +             if (st[i].firmware_val != U64_MAX)
>> +                     cppc_saved_regs[i].set(cpu, st[i].firmware_val);
>> +     }
>> +}
>> +
>> +/*
>> + * Reapply each register's requested value that offline() saved.
>> + */
>> +static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
>> +     unsigned int cpu = policy->cpu;
>> +     int i;
>> +
>> +     for (i = 0; i < CPPC_NR_SAVED_REGS; i++)
>> +             if (st[i].requested_val != U64_MAX)
>> +                     cppc_saved_regs[i].set(cpu, st[i].requested_val);
>> +}
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>        FIE_UNSET = -1,
>> @@ -707,6 +824,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>        cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>>
>> +     cppc_cpufreq_save_firmware_regs(policy);
>> +
>>        ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>        if (ret) {
>>                pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> @@ -725,15 +844,24 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   /*
>>    * With offline() defined, the cpufreq core keeps the policy alive when
>>    * a CPU is hotplugged out.
>> + *
>> + * Save each register's current value so online() can reapply it, then restore
>> + * the firmware value, leaving the platform in its pre-driver state while the
>> + * policy is down (CPU hotplug or driver unload).
>>    */
>>   static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>   {
>> +     cppc_cpufreq_save_req_and_restore_firmware_regs(policy);
>> +
>>        return 0;
>>   }
>>
>>   /*
>>    * Re-enable CPPC when the policy's CPU comes back online, since the platform
>>    * may have disabled it while the CPU was offline.
>> + *
>> + * offline() reset the registers to their firmware values, so reapply the
>> + * OSPM-set values it saved.
>>    */
>>   static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>   {
>> @@ -744,6 +872,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>        if (ret && ret != -EOPNOTSUPP)
>>                pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
>>
>> +     cppc_cpufreq_reapply_requested_regs(policy);
>> +
>>        return 0;
>>   }
>>
> I had a look as well and I think the saved registers aren't enough for the stated hotplug problem.
>
> CPPC also programs DESIRED_PERF, MIN_PERF and MAX_PERF. If the platform resets those controls
> while a policy is offline, online() your series reapplies AUTO_SEL_ENABLE, EPP and the activity
> window but leaves the main performance request unrestored.
> So autonomous selection may be re-enabled while MIN_PERF and MAX_PERF still contain
> reset values.
>
> I do not think these controls should simply be added to cppc_saved_regs[]:
> - MIN_PERF and MAX_PERF should be derived from the current policy, which may have changed.
> - After state loss, direct controls require safe ordering: establish [0, all-ones], restore
> a clamped DESIRED_PERF, then install the final bounds.
> PCC controls make this more complex, they should remain grouped in a coordinated transaction.
>
> Could the hotplug state instead retain the last requested DESIRED value, recompute the bounds
> during online(), restore the complete tuple, and only then reapply AUTO_SEL_ENABLE?
>

Agreed.
Will change online() to derive MIN/MAX from the current policy,
clamp the retained cpu_data->perf_ctrls.desired_perf into that range and
reprogram the tuple with cppc_set_perf() (one coordinated transaction
for PCC) before AUTO_SEL is reapplied.
With desired_perf clamped to the final [MIN, MAX] range, the temporary
[0, all-ones] widening is not needed.

Regards,
Sumit


