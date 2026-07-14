Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C0426ED3;
	Tue, 14 Jul 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020158; cv=fail; b=kMeuQ/WTlgyJLTMXF8yO6Ygmxgql9o3baXJ6J8qTwSxs7NWXkJv7tcpX/hgTryTr0qHcnrj/d4yUvEa9ojJ5Bg0Jmg4E2qAfUfgTV3OOkk9aL/wOxg0QUcf6A+2c9egMX6ONPn5R2iLzkBmHgz/SvqRV+1qgq04bllvzVH3LOyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020158; c=relaxed/simple;
	bh=oAf28+ccyYGOctNskFAWO9GN+EpKH40+l4MysBiqpcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VfQHYdsB3O/b3yUVZk9ReM0fJNu1gXCEZbar7mbjq7FgG1Wr7pnYHf+e6VWUiKHtyeVjn/cnhfuE+FBPgLdZyA3rY0xNUZS2NnQyTXxbHfys2/3lULuzW0s9Mz4cKWv0Zd7nypxzLy+7A5Xoi/xUh/27koLJlZ85gZAJyy20gsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZPJOBPn; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZPJOBPn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/AFHoFJWRDqfCZyX1BpKYtalSFu/jRv/Dqxuqzv82TNIhG4a+GdznUJXb9tFYI/OvMVdMyxvnfjpyheOCEMCatNuBPAa6Iii0/xTbIOwtkMmZdSvyJA6TIrLUiF8Dj9oaprAknYHywOAczvoj16oomsp28PzV3GnJ/l0VmkjxmYoJvHt7T0XN+c/mA49Hj4KiUCMhd1oazdoHtlTBPil0egVpIkfzz+tymcCknBW7gA5dxfnN+QGZr73OggBoYleNTvSR74YFuiY9tcYFwlx1m+/AtG8NCHuSvzyhIDT9qN6FPo+rFFT6brBYCTCAxlXZwdxnWkeJrqm1Zp2YNeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL1icSXz0iVdkLnLfFpHxioVvIEmq5clvC7GBGgy/zs=;
 b=WlpzqWccl8NkSTvosjM5VPSHB5TxK8T8i7Zlm6PmUEyLJf3EKDxeJHhn+HIFJ+HOsIttCU120TZGwWDtCboLj2+83Lv0fP1fw9ROYJa+wRQFub5tzex9sy0AGp48UJ4UD8jsoH9Ht/bxAc/R3isAR3epTja9/kYEXg/i2YW93EQS3ui6UmTgXKx/IImJTVrcdz+R9uEcP3GatkG9ovUMvdACYRfI2JVpIOZfH5bBAQAYsh09zezt+MXQDuLxBCkew2OAPRw2kMU2vahq3DEvEnK4IBPG8K5Ek3k2FDLEXqMes4CTcf/Tgqy+bZeJ3+21vueJBHrh15PgVYaNiAGopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chinatelecom.cn smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL1icSXz0iVdkLnLfFpHxioVvIEmq5clvC7GBGgy/zs=;
 b=NZPJOBPn0LmjVDwmuzQ7BA4OUxKe5+xs1Jh6H4MJsml6l1NuJY0RUUJtrTF74Rp63jzF2BPkyED4ZysAYK2ItYowxKQk3ZpChRrWhKCVaHMQvsK8bhx9fdKC/LsOLn6dkMX/hValRi97QtdN5ZQEEEshfgWHKGOzUbqQnaQHYf4=
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 09:09:12 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::70) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 09:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 09:09:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 04:09:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 02:09:11 -0700
Received: from [10.136.35.249] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 04:09:07 -0500
Message-ID: <b2835252-409f-4188-aea7-195be3c4e69a@amd.com>
Date: Tue, 14 Jul 2026 14:39:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
To: Qianheng Peng <pengqh1@chinatelecom.cn>, <ray.huang@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <skhan@linuxfoundation.org>, <li.meng@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangxb12@chinatelecom.cn>, <xiongl24@chinatelecom.cn>,
	<zhangar@chinatelecom.cn>
References: <1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d7a8ba-74ad-4c4d-212c-08dee18791d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|3023799007|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7x2I3rSITEBsrq26z39ObgCBn0dFYQRpRDNiwGPbRsj4JFoWF/sWtrWholjw/QNtfZKeitcLEu4NHICePUhzfwMnFuXbPEOsKRs2FVZWSJWnKny9yVIEKr5UsX9J0zk6D58R9El0i9+fAf3zeIH5zh2hwmIKGhDY2aL9fGk6N/MaauSGimk97dH102si6NfLUMshwdKdo9VqA9/cZgsXojamrYObdtlu+Qew/eJa6aL8dRLC0/Rw2LedxTaz43heE3YfSmHne54tMCjpcl+WZ0gdwM6Z4tIso5mUGb3JwhxDiZxpO09i/5H9LHVeRw1nbZ7gMjMqHu5RimaMJCj56IyjR6MRdXsSChH3Vnt1sfh29222TOr1WgCLXvjCxEwSBJpSSfd1ddmDTzRhas3QGiANPAT4ASaKFEOC9D2ELxlP3rBFaLarN8ohQr5AJiWxOSigT8Tot6jVGYDTZnkytazEmcCleLYN9Tyv6AXIXqfabnEVhnAkWuwjepf8VzCqgEeXXl+3gHPEgEWqyhxJM+RzOKJWIOf6IgfoZn9YnzDXOQdzVwbMqWk94mFW6i5EekRWp7dmQ8K2WgFBrh1y9HWmtDbbAp9TpoOrmpTHmPh4zwcyQGqi70pYrmcr5u2lbw3PlJaa8ftpdCMSxyFAtxWGZD+1arqAgGiqhyvFmIasfaWl5yGBTK6F2/Kne7RE88WNdNyyzAIT0mOiSHPORQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ZWgGioYHXMmayL1ennfaKiKpA6mHfkfiAMOigIO1AzvjzVXZ7uXRCiSyiixKjLzdnWjNcf24/NmR4oV1B3ErIKsNKTFgIGw0xNKeTsqNnGD4ayGGTRUPsNttJFjnW0vrBetkWBkZ8tldCJVLeFSk6kp9CvBFg9WZkBdFkMh7Jt25VCgnKO/UY+hN1k6WE3+B/I50GFMBjugT3ni8005Mnyw95AsUGWSbFARdrEoJwdcQx2npRfFUMHg9dz2Rp+lTB9Q3zAJztuMe/pp+WgHAiV9t2JbpV30laBhw+pu6purXLDwxDELCTpYjM1HlZCr/8PvCwaaqKqcuY1u38rjf2bE+4o0kEHaTjF2iTJRGVrDkGNrPzFVeQaC/r9NH8gTNjPR/R1RzzAZMeNdciX8eT7F+r6pVZbfD0qa2D+ShbuVwljkTGZTeF6EbDf9DdDy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:09:11.5664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d7a8ba-74ad-4c4d-212c-08dee18791d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Hello Qianheng,

On 7/14/2026 1:29 PM, Qianheng Peng wrote:
> The crash issue may occur when insmod amd_pstate_ut modules.
> 
>    amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>    amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>    BUG: kernel NULL pointer dereference, address: 0000000000000080
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 0 PID: 20300 Comm: modprobe
>    Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>    Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020

Is this an AMD platform?

>    RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>    Call Trace:
>     <TASK>
>     amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>     ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>     do_one_initcall+0x42/0x2e0
>     ? kmalloc_trace+0x26/0x90
>     do_init_module+0x60/0x240
>     __se_sys_init_module+0x185/0x1c0
>     do_syscall_64+0x62/0x190
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     </TASK>
> 
> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
> 
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 735b29f..3b24260 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>                 if (!policy)
>                         continue;
>                 cpudata = policy->driver_data;
> +               if (!cpudata) {
> +                       pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
> +                       return -EINVAL;
> +               }
> 
>                 if (get_shared_mem()) {
>                         ret = cppc_get_perf_caps(cpu, &cppc_perf);
> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>                 if (!policy)
>                         continue;
>                 cpudata = policy->driver_data;
> +               if (!cpudata) {
> +                       pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
> +                       return -EINVAL;
> +               }

The only time I think this can happen is when the amd-pstate-ut races with a
the amd_pstate.*_cpu_exit() (probably as a result of concurrent mode switch)
or if you are running this without running amd-pstate as the cpufreq driver
(which the ut doesn't check for beforehand)

My setup fails at this exact same point when I have the driver unloaded.
What is the output of following before you run into this issue:

    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
    cat /sys/devices/system/cpu/amd_pstate/status

Are you doing any concurrent hotplug / mode switch?

> 
>                 if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>                         (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> --
> 1.8.3.1
> 

-- 
Thanks and Regards,
Prateek

