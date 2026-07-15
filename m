Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D71286D5E;
	Wed, 15 Jul 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127115; cv=fail; b=lJmzS9uEad2ltO9OahpSuow7GsuZrXK1qiRX7FH2/pKwA5RD2dPWpP9dLFTJVKrQ6s3jV3XJ/WJhFAk3RPvl8dDqWxIHccwa6vkG7ig120c5xXZQXh4eznuI/ZnJamxFhYi5X6HNEnZ8RA+6TB7oYcHT+PyamUiVSaVMx1DUTrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127115; c=relaxed/simple;
	bh=++OVLa3Q+K27ibFdhjm5Ob/BEK8qwZzE6tNkpbKWhd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o1IZdL7NC7Ob/S92IqKUfLOSN6/C5SLu0O+S1Ps8leOT6zjHIdkApzFjOKOoBOhuQRoX3ACH2TDStXBYKSFiAaIBbCre3zSy597NeNn6JyFOp6A8UsMtCLQndRuQ9PpEFcbcGIt0IR71+pwK3BFR+J1lA8CoEIvsIznTyg/VnlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/wqXCVq; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/wqXCVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg5AATBUEkVBUrkH5V0QQ1x/jU6EYxuL7AzYptvsc/IAK7QiuPS+rJXZu/J9zm45UrjCqBJQShKnbzjBGTev9QXrBvbfRdLYqwXVKbzvtPts+xmYcOT/Q1Rc0McAG6e5gOZcfnqYE+TZKBciYJE+V0GWL4DIuyDQugAYVVR2jBw7I7i0m+6dKXaSI9pgbP+MAYcfbUYATmFzJYx/kdQmp48G+NF+N0OJHWd3/3Ml0KI/8u9gCo9ukWoN1SkODRn6OfFn6pmbUN30t6cuQ4uEJkNgj/V4FxWs0C9m6lhY7eWc7wRUbHm9oRpElzyWqFUkyejWpFdSd6/97js90TNyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG7o6JpxKL0rMCUfMvx6/MerwkEHwn3KLXS4ZwTi0F8=;
 b=eZW6R814x3MxCMXLCzNVFjXOiYwcV/Gf0ZAEid884zn8PEjfQZ/2YzKSaEu68ZSmA7QSHXSDD2Gi3pYlxiJEzkQz87jgStLll9FPRjEu35VRDoAeU36uAQSpVz4Z/7iQTz2pqdiC+kHzaUdQd3bKXlxEVk4AQSQZ2/BxCr8bgfAcPo0W4NKAkIZv4o3B/515CzdkzU3VXPtaS8mjDKFxTfk1KfXHzOi6ObjhstNfKxHQBXjBaFMA/3vAuY6fDdTg8JctCalljCB5EhR2MiVbcYJvQdtk70tAsfsYOpPNWntyTm480aA86S56RfZNiG3WoJLSz9yyUXvdot3BRLH2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG7o6JpxKL0rMCUfMvx6/MerwkEHwn3KLXS4ZwTi0F8=;
 b=b/wqXCVqpEizdgbEp/KLpn5xogDitPiH11aZwnXEOxxAdPU9QHj1eiOnftUQKMwLykUpNnETmz37uv2/S9jOURq+yJYl+UUEvadoKkjZbq88moLzTomCdwtybvS/DpevbTa7h7dae9KMyCPGPZoKdvxlXWzFX9Yg6Ei9s1uAGiI=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 14:51:48 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::49) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:51:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 09:51:40 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 09:51:35 -0500
Message-ID: <ed6781c7-8f10-4580-a3f3-c8819428d845@amd.com>
Date: Wed, 15 Jul 2026 20:21:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: amd-pstate-ut: fix null pointer dereference
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Qianheng Peng
	<pengqh1@chinatelecom.cn>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangxb12@chinatelecom.cn>, <xiongl24@chinatelecom.cn>,
	<zhangar@chinatelecom.cn>
References: <1784108124-19988-1-git-send-email-pengqh1@chinatelecom.cn>
 <96c49e02-12bd-4f2b-b4bd-ccb98d2e530e@oss.qualcomm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <96c49e02-12bd-4f2b-b4bd-ccb98d2e530e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c42629-c797-4b6a-2e60-08dee28097f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|6133799003|4143699003|10067099003|56012099006|11063799006|18002099003|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info:
	0reyFEctvKM8yLeeDN8IGOfmsCoXThelbkeAJ7bLPjkIgvnaLwb1anLDQk6Kbd4g44DpfaJ3kVc3y8ZiMBzW//o+bdtmhCgUW0f59rSRoaOJPMhCXB6KI/M7Jq7FzWQO8Uaqi9mg/Er4tajxPXZ3xAil+/WyLqzDMTlZTwuIcNfEyunJgh/uSU2grYOeGDjMXtPnCK+vpEVg1CiNLdIuT7JUuJq94rL9PdCKSDFRHBNbKn4dKJzonOlM8koUZz6gq1iRAQiTNSAm9FDXlk0wBxJbg3ORZgh5/0p2heKJSz493esp5Um7PEvmAvRtEzNuYIj02d1zR6r+Nz77F0cu0CnWf9pAXDMSycZdhascfjmZfQ0a3SwZHFPrfiDHVlpoLQvTfaDkcUQFODdFvn7r5HYSJRb5LPJX4oUD6SWDfPBueIO34ZdngXsqn5sCVlV246eLSDM31GpKToULgmQ+qkm9QcNwIQONFpGZajaFkEchPSrouAUAZPS6fiInRvferydjCTHsuSy8wqzHuS+J0IODcLmjfVIxcj4OrLkvT0jVngSF4n8irXJibNErZOW3G1L7vAb0TxpGRrI1Naovks1ofrgMqxj0cK+hl3oWjuqMNQrEkg6PLF+qbYOQvYCmjSjkHFmKOceuKugISVd3I8hz2zJ+jykchRe1vri+siGNqZCqa5sWpOZVY3o3RDYU27kBD1P8IfyCJo0YUGCWBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(5023799004)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lz5KSZ8ZZzQ2XpDz6SRaG5np5/dEd5ai8Dk9cxTlr4t44/GQ//T6pubZHGWgOaCRGuh1jd01m+btK9K4uwxifwM2SRkligNNIzA6uoRKHOXnOy9IGqZVkmHzHu8psuSAhj+lL69RIz7QoS0WeB7i8Wt0EaEJQS3TT6tDGNcmLiOA7PSTRbDsXpz+IZoKz+IsEDKqsHWN0nlLekOhvpi/a6Yj+fWQo6trNZh+Z1LYIL+6Tg8HOD+guhiEJ1NPNQGhMQAVL+OwsiDPWvBYgbVoCQEGLe3ZPpsougzYZE9A0HzooQtsvCmZPL4ZYy1K9NT9MQCSrXpakoUV/Nj3mj5Fi+4o7oftXzXcNIpUNECjtf5wVQUd2qiRPZW/FnzpKga1+58I9fnefRNV52LAjMfYMiLL6pyFEC9EnUDtho6SRR0xh/WsEIhvisn7HNYP40Cy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:51:46.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c42629-c797-4b6a-2e60-08dee28097f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

Hello Zhongqiu, Qianheng,

Thank you both for taking a look at this!

On 7/15/2026 7:30 PM, Zhongqiu Han wrote:
> Hi Qianheng,
> 
> On 7/15/2026 5:35 PM, Qianheng Peng wrote:
>> The crash issue may occur when insmod amd_pstate_ut module on intel platform.
>>
>>     amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>>     amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>>     BUG: kernel NULL pointer dereference, address: 0000000000000080
>>     #PF: supervisor read access in kernel mode
>>     #PF: error_code(0x0000) - not-present page
>>     PGD 0 P4D 0
>>     Oops: 0000 [#1] SMP NOPTI
>>     CPU: 0 PID: 20300 Comm: modprobe
>>     Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>>     Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>>     RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>>     Call Trace:
>>      <TASK>
>>      amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>>      ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>>      do_one_initcall+0x42/0x2e0
>>      ? kmalloc_trace+0x26/0x90
>>      do_init_module+0x60/0x240
>>      __se_sys_init_module+0x185/0x1c0
>>      do_syscall_64+0x62/0x190
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>      </TASK>
>>
>> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
>> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
>> Otherwise, add driver name detection for amd_pstate_ut driver to prevent it
> 
> The driver-name check in amd_pstate_ut_init() is the actual fix: it
> prevents this module from running its test cases on non-AMD platforms.
> 
> The NULL check should not be necessary. On an already-registered amd
> pstate driver, policy->driver_data is set only after a successful
> ->init() and is cleared only in ->exit(), so it is never legitimately
> NULL for a live policy:
> 
> 1. Hotplug offline path: a normal CPU hotplug offline does not hit
> ->exit(). The driver's .offline callback makes __cpufreq_offline() take
> the light-weight teardown path and return early, so ->exit() (and the
> kfree) is not invoked and cpudata stays valid. The full teardown only
> happens on driver unregister / device unbind.
> 
> 2. Driver exit path: the NULL check does not close the theoretical UAF
> window here, since the test does not hold policy->rwsem: cpudata can be
> kfree()'d between the check and the subsequent dereference. Worse, the
> passive amd_pstate_cpu_exit() frees cpudata but does not reset policy
> ->driver_data to NULL, so the check would pass and then dereference a
> dangling pointer. This is a pre-existing issue and out of scope for this
> fix.
> 
> so it is better to drop the "NULL check of cpudata" commit msg and code.
> 
> (Others may have more context here, so please free free correct me if
> I'm wrong.)

Ack! amd-pstate-ut was intended to be run in isolation without any
other concurrent driver operation as a sanity check for developers.
Races with hotplug / any user initiated changes during the test run
can cause issues.

> 
> 
> 
>> from testing cpufreq driver on non-amd platform.
>>
>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
>> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
>> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
>>
>> ---
>> v2:
>>    - Print policy->cpu instead of policy->kboj.name
>>    - Add cpufreq driver name detection to amd_pstate_ut
>>
>> v1: https://lore.kernel.org/all/1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index 735b29f..5d71315 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>>           if (!policy)
>>               continue;
>>           cpudata = policy->driver_data;
>> +        if (!cpudata) {
>> +            pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
>> +            return -EINVAL;
> 
> Strictly speaking, it should be %u, right? Since policy->cpu is an
> unsigned int, using %d is a format-specifier type mismatch.
> 
>> +        }
>>             if (get_shared_mem()) {
>>               ret = cppc_get_perf_caps(cpu, &cppc_perf);
>> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>>           if (!policy)
>>               continue;
>>           cpudata = policy->driver_data;
>> +        if (!cpudata) {
>> +            pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
>> +            return -EINVAL;
>> +        }
>>             if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>>               (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>> @@ -560,6 +568,15 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
>>   static int __init amd_pstate_ut_init(void)
>>   {
>>       u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
>> +    const char *driver_name = NULL;
>> +
>> +    driver_name = cpufreq_get_current_driver();
>> +    if (!driver_name)
>> +        return -ENOENT;
>> +    /* don't test if non-amd cpufreq_driver exists */
>> +    else if (strcmp(driver_name, "amd-pstate") &&
> 
> Nit: Redundant else after a return: since the previous branch already
> returns, control can never reach the else if, so it is better to drop
> the else and use a separate if.

A simpler check would be:

  enum amd_pstate_mode mode = amd_pstate_get_status();

  if (mode == AMD_PSTATE_UNDEFINED || mode == AMD_PSTATE_DISABLE) 
           return -ENOENT;

Status always starts out as undefined and if the driver doesn't
load, it stays that way. If user has disabled the driver for any
reason, the unit test should bail out too.

> 
>> +         strcmp(driver_name, "amd-pstate-epp"))
>> +        return -EEXIST;
> 
> How about -EOPNOTSUPP or -ENODEV? And it would be helpful to log
> error info here.
> 
> 
>>         for (i = 0; i < arr_size; i++) {
>>           int ret;
> 
> 

-- 
Thanks and Regards,
Prateek

