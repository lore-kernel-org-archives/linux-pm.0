Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1E303C83;
	Thu,  4 Jun 2026 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545393; cv=fail; b=qiIO2DHGbLcKGP1A57I5SIArkLLbGdc6cNTMogj+1nWYsG+TM3CfXMYWKzJH9rybKK/6b8P+ke064OekOwB/0BcArMIAiVgP3lHVkE3lGfOlh0mYDJjhzjTizS5uYHJYxlFMJSkBl3vgbjxC/EHJ5IONw0gfnU1SYXvd5gf+6RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545393; c=relaxed/simple;
	bh=1HKToh9eiEMzlsMvOusutQHCUUYs+wHri9FKymfQ5Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b38iAj8FNk36j0lx4I6E3fIq1uCNvBb8cdc5gzlAFLxPYuEKiBHBIgwHm66xTmrXo36md0plFAsAmpmZn3F35lOFGVg2WtewqfjIGIADfu4URwbxR3VQnHk9zJeol5fCtae2LvF6aoG/pUKV1R48czBylEzEulF9ztawvxj7QCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4yGwJdcP; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4yGwJdcP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTpk89fypDFzLAYVkOsTvmcVqwPiJUgZr5HIkuzELykPm8bduVgQ++Ig/ZF3URWhpBwUYtPLZuTMLqdeP6MvQgAkQvUOYd9cG1Omud3PPyjv3wN9sWQzD8HjxzFGPZ20TxiuYlvLaWWardsU1ps75RPziY3jKGZ+Vby6nrFAk6VdjQxDw/nXyN6LJ3qv0sEDf9Vy0VTdOFZfeY2aFD58NPFggkTmb2d9ieEmV57rUcyQT4hVLsthQnSSQkKOS4HcjRpYQT1r/DPlMDZA5m3SZZ0FAlVAj77nwNefDhyyLz6t1Qg4j7qg7RwGNak5PjuazhcNjox+eAjiQbenHoeK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksyVGkZTf+0R1qvW1NijjvaxMC2o9xsYnEjW0RaHSDs=;
 b=tt4jm62tsWmX6O1Of0017MD36pBEk7smAnEed6TUJp93apAu+4pRwRbjuauN42jONM4o0DXseuqpnvaYtMXqhqaaMNxc2Ufe6zvsjaA/RR/lNJGhtmToTxQhfQi3Frc6JSyvqhTAeCNoMZ5YrcYE0BedAXMVFqKAEmdf0Jfq3XV/NHLl9gVlr76XRU/VeIFdiywlzN+TfWyYoEkTAbC2k+iaJkcaSWGKUYPBclw5c76SXN7HlHP6RjXztnSorlmWgga+JIPUYR5YjXaGeH3RpEY9/6onLoQLa+pWc1mM6gjkjfaQK8wBjvPFaw4To4nlRSvgXt8WZ5oThvqNFVpF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksyVGkZTf+0R1qvW1NijjvaxMC2o9xsYnEjW0RaHSDs=;
 b=4yGwJdcPFwG88BV97hlRRxl7aPlRJ+UvFF5o6VumfcUoNJ/Gxz+Ej19PPp2XjfowTiVUKSCcZQNg2udAhRoTMaZz07WRU6JHxbwdR3UVciFAxu0QWcGEQX0EuAlBbMRYFZzD9/rlYlRdesiyPFcdex33wS098vJSwOdnljfMG1k=
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 03:56:28 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3c) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 03:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 03:56:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 22:56:24 -0500
Received: from [10.136.33.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 22:56:21 -0500
Message-ID: <b4e23498-492a-40b2-8517-6d44eaec8502@amd.com>
Date: Thu, 4 Jun 2026 09:26:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Fix EPP initialization for
 shared memory systems
To: Mario Limonciello <mario.limonciello@amd.com>, Marco Scardovi
	<scardracs@disroot.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <ray.huang@amd.com>,
	<stuartmeckle@gmail.com>, <viresh.kumar@linaro.org>, <wyes.karny@amd.com>
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <20260603120121.25772-1-scardracs@disroot.org>
 <20260603120121.25772-2-scardracs@disroot.org>
 <2e3a5f9a-69fe-4790-8b8b-2d1622977a2f@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2e3a5f9a-69fe-4790-8b8b-2d1622977a2f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b40d831-adac-4b76-114e-08dec1ed3f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	RPzXnRvpuDmeNAGCMQOOyOfEDi0y8Zz+hxFgoQwDWmviXhc6v2vhKczv29UMsUXBRW8DcPmwvwipVKs5EMRgMJUF+qrvKHciwM+QU4MqhvY0qSMgWRMmlNkvx3OB1Rbl7OLfGh9s0cyu/6b5PZliIkg5N0Uk9iH6NzBuJhijRTc2pYx5nYZ/yhemk7M3YoZ0iZ24WkGPA37OevhBmYRtOwMd5M+KFFabZkmmTrq/ShwUHeZEIAeoAIVh03D8Q4jA5TkOdrnQbnabYLeAfHedxuGuIeQmwUJTCG4z3k4fXFIqCL8K1TV7FNVfhentuRACehguPYFCImRHEYXXIBU0f2SmUAw7glsTS2Qpq8yjo/JqpayQHnL67xENK8/rTMLE2/lYQiy+zOWI10DIOk8Y37+Kv1rPtWsZraEAOEc3ob2+gv/w9FLDM1Ni/rtTpQ67jMb75UVy2hodIyZtpEv1D2JVlqm8xQT6g9kdVsHelwjAoR6PUJtWixrxllyStaaZ3tBgefvQaZtnCc6JQ5bzNYUaq+x1PNnINygyfzDJZXiMVQ8UcpOdyzkdKyf2ShUgsLaFvXarVzebdGkO2OL2L3ipB1GebxlfjVKuAWup71StHCJqSXWXqMG+neC1YRX3TgbTsVELpnTNuR0xex7MqJ+oeUszBP8bF8Zz4IEpK0Khi5VMLREv61qmGQIpmsCviYzllAqxnMqCfUMQ0shDvPIr2RFca4cAlnjPp4MUPVI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YEm2Cl8NCCFTq+POzNomcs43hWFGAvsGZo9ssNYLAAQoajX5EZv/krRQjWHN/B6HCUEKnyfwoAZJbK5zverLZOg8ZZqxmqJdnis+ZTH4xwn21imHTR8vzDyZF+M1gQ3+sbFkzYq+sqCDFFTgsuM61HFOSM8CCopw8DmuUylxtYw9c4efXQ6GsTK83Vr0ryAr0cnhQBm5y4vArUeTtEOKSzIDn2lbl3FlXtYAPZPSHTF5qO7//LrgzmIrCgkc/WEYSgkDBsRgnpf4JrqEiWXep0wK6lKyGRaQRSYRdqG4PIA7BkaFKFIF0B5ekf1i9sfYQOds1mjTONHjwphN3uCGbCtThlnhbhDUzG9/6k7Nlob0WIULwNBIivSBNDGTOCNA6Ucp3tFIGWbHo7q1ODeCHgXc0zTH2hkH+QSd3ETjpwumOmMClYNeuoJnmfNzt5M6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 03:56:24.7417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b40d831-adac-4b76-114e-08dec1ed3f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

Hello Mario,

On 6/4/2026 12:23 AM, Mario Limonciello wrote:
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -128,6 +128,8 @@ struct amd_cpudata {
>>       u8    epp_default_dc;
>>       bool    dynamic_epp;
>>       bool    raw_epp;
>> +    /* Indicates that EPP has been successfully programmed at least once since boot. */
>> +    bool    epp_hw_programmed;
>>       struct notifier_block power_nb;
>>         /* platform profile */
> 
> I'm having a hard time following why this is needed.  Let me explain my chain of thought.
> 
> We start at amd_pstate_epp_cpu_init().
> * cpudata (and thus cppc_req_cached) is initalized to 0 via kzalloc()
>    - On a server we initialize "epp_default" via a lookup to the HW (amd_pstate_get_epp).
>    - On a non-server we initialize "epp_default" to 0x80.
> * we call amd_pstate_set_epp() with epp_deafult as the argument.
> 
> Now in the shared mem backend (shmem_set_epp) we do a lookup of epp_cached and it should be 0.  We do a comparison of the argument sent to the function, and this should be 0x80.
> 
> So how do we get into a case that amd_pstate_set_epp() is actually called with 0?

This was the path I traced yesterday considering amd_dynamic_epp enabled for
a shared memory system that is plugged into the wall:

  amd_pstate_epp_cpu_init()
    cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
    cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
    cpudata->current_profile = PLATFORM_PROFILE_BALANCED;

    /* cpudata->cppc_req_cached has epp_cached as 0 */

    amd_pstate_set_dynamic_epp(policy)
      epp = amd_pstate_get_balanced_epp(policy); /* returns cpudata->epp_default_ac which is EPP_PERFORMANCE */

      amd_pstate_set_epp(policy, epp /* AMD_CPPC_EPP_PERFORMANCE */)
        if (epp == epp_cached)
          return;

        /*
         * Skips cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1)
         * where the last argument "enable" enables EPP via the
         * AUTO_SEL_ENABLE path.
         */

> 
> There are some trace points specifically for this purpose - you could confirm there really is such a call by using them at bootup (or by starting in passive and with a mode change to active at runtime).

It should show up in the traces yes!

> 
> Then we call amd_pstate_set_epp() with that epp_default value.

I think this patch has some merit, although the second patch, I'm not
too sure of. After some digging, it seems we always had AUTO_SEL_ENABLE
and ENERGY_PERF right from the time CPPC was introduced (including Zen1
systems that had CPPC support).

Marco, do you have actually have a system that neither has
AUTO_SEL_ENABLE, nor ENERGY_PERF? Seems very unlikely a configuration
like that made it out.

-- 
Thanks and Regards,
Prateek

