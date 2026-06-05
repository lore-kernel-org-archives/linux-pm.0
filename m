Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54E33ADB1;
	Fri,  5 Jun 2026 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630908; cv=fail; b=lflTAnhrg/pAN6O0UX/aTcSJJWBY+r939zwJUDt8RjSv1aBlfx08GFf5kun3Cg0pNc12O5mBmF8HzDa8S6HJEqRrVKl9HQcpQ+E85T1ExQuvxrsCU3RIh0Mnc3YhntsOYqBKzYha1miBwhjiXQso1jP9IxcYRMHuFE/Q2yIKdQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630908; c=relaxed/simple;
	bh=8GvwXI1ZYsKFp5hHFsjpQQDrxJw2Vrk4SRQnR3Osnic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UM+RKr/tYliPTFg4rJkVYCOronGTaWwofdt4MYCOk4cR/cQMpXCJgXbHikoOrnFg/HFWVOPu7//IFcZQISwN0N3k4mPqeQi9oRdiDmHhpTWD6Z+eOTSY9zWggXco1iHQmcEy2QCFCixql/VwcpcrtIugxeqsfZzyzlSfhlEw654=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VUbnV0eq; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VUbnV0eq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No16dvy00XybwhMv10tZIzJiKZIia3jJ1bmt3MKRMQ2KJra5Slykr6GwFk/2lBAEYdYZaOsNCNySCPwopFW1wCQ7EyXuDBCWNHqt91U/21ZMbKmjXb+8MoLiXD9oWcstErrjsAiCvixadcA+Jw+6wHUk/0Wq1+iYPbdHHpOvA0LDaaSXqhh7TktdUn0pnL3leElRv3o/6IETsXCcu0sTczef4n6k+3K+E6gtVyIB23Zh8r49hj6ykKAZpcvLfGpsYaSqeSrG4oi0JJvHCBKnkWg2cxdngz7ts8oRDc5hXIbMDvLABNDkDexHFnI1CN1sqHg+t100cM4vIFqR0ejGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KtcZDlHCmd7bTQPp6rIChB02FHuCxfKD88Ncry6KXI=;
 b=KMEKAfLbh7gBSe+rmf5py9AkCvz+TCbf5E8nLTBdQYXY547Pyb8+0HW+f8J8vaGTwaJFj77BlAAR9WXr2/KaF10p/hEb7Wibscr9R2p3VMlfWtqi2qu2TfthnqoqEDU0F/E1W9hfIFMugi6gAeJ/bDigRhu8rgBff3lWQBZLoJuvv5FdGn7V/gpcKLzbsn2bzra5L7BAZLLdOYXuoHzwWDkTOZjBldMxC+xZsLvQ0fqZzDsqR6RhmgzacZmTlFElyE18fjrhSSQyUlXCOV25JJxMD7JvfVdTrfCeJFNc5NTASx2QVzbucPD7qjBDkqqR3mkUG+I2n3kUDGA37s59yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KtcZDlHCmd7bTQPp6rIChB02FHuCxfKD88Ncry6KXI=;
 b=VUbnV0eqwTs4yWqBbPzchQz5Exmyfiegb7ee0ihlP4wZ6XNXQAWmR2YYpMk6nFcJ+wj1sHKHlfeR9ymh9iHYHZX+i2Djun3f8Rl8NbZ8+qiGzjx7e4aNM2BOs2BV89fzNiWTAITQ+9u+80n/xyFDMomc9t1c1Vgs/l5iLqu3l3I=
Received: from BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::20)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:41:42 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::f) by BLAP220CA0015.outlook.office365.com
 (2603:10b6:208:32c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 03:41:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 22:41:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 22:41:40 -0500
Received: from [10.136.33.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 22:41:38 -0500
Message-ID: <05977a61-5bc2-4a56-9105-f9731d1b12dd@amd.com>
Date: Fri, 5 Jun 2026 09:11:37 +0530
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
 <2e3a5f9a-69fe-4790-8b8b-2d1622977a2f@amd.com>
 <b4e23498-492a-40b2-8517-6d44eaec8502@amd.com>
 <CO-q9BQiTf6GLfZiYh_W4g@disroot.org>
 <cb4d800a-f5e4-4207-a36a-fde42d0a006f@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cb4d800a-f5e4-4207-a36a-fde42d0a006f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 27894d5d-6db5-4083-749c-08dec2b45b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pspE2yRRs9xmLat7jijMG/q3TGSw8Lm0G50Z1uluYYEnjE+L+EL3kw6UF00i5NC93+q0C8nczv3kYdI+9wGKWxU7K806uaS0tNeds9zpQC86P/nwozUa2oZnfuxCRvQd7aVHIAiAPsTYB9KCS/8LOGov18JSe30NmrhNIkuExKfKGSvx5ykLs0fqmyZfVLK/YbcGBVp5Iq+69ZDQt9ngyUI+an9Xz3FQ70uVxCjHjrI4h4Os+aA7WztVIFcxXPsML8oxdxLq5b7GeZboFM8cGL9kjRk39Xt+BQALvQwJlnlXd/TLZoyAa5pzfATpekH6Y2rxbrc0WzN0E/OtGqfc7VU92E4N/oRD6/y+DInVlrt4mvKZowRpkXGLbWcMQusNzCuTuOl6EUoFBYk1/j33SS4gZQ2psP3f+O7/X5Dj9CvMtA2501CL4agd2V9zq4RLbD0CSOLsZNnbbi397PsWyMPkEAAao2ADxd/lHJ/+s+dE8jL9vg6PHUZ9mM6Yhx7R9hA1PX+jY2b2LbVqjho/NHr3J2uVzz/EM/wi1+jsLSqqS90zV79BASZfJBhW2ZA54G2Aro/ENPosi6nnwhqIgGP1+iRz7cq07nUMhv/qIqJtAcfISZ6iiFb9tDtfIu+qc8VtLETA66ELpIPmtyRCoUYyQ74M6raJhn69hwEsC79B7uKPHcsWcRcdfcmhToed13rYZhWaa0Byte/MuI17NENtAanP3NUmbrj8b4hnOxU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ReAMjyf6qHaKW3SYpoqORoPbkLO/gcicnkF4ItTrXYfCpaMghoGysvgwQ91hSHg5yOQGM6ZMEv5IaXZvN1Do9NpFrboCVRGeYEeeoN+Pu/8jP6uCSTIWjIVfQ/b+SEInbmN1v0I++L6N9H5mWSPYCLGc8YLaQGXXIje/En9f/jq2tZlELxzKNcy+0ZblGFAuCNl5DGKqOreIIwSmNWLZPvR+v4DHo+yC3nCXpeHYa2RuQ7ftbjE4NyqAchnygFaYo3OTD9W04favigqFd4/oCEQlSg6VCUEmdwR+31BGc6t+6BDptqXmmYTWeGHrpzfz5p0yEZTJZH1gF76szqjspHjN41sYqCzvhXfdzYlGc3WqrEhOyB1ibfOFLh/E/2HABl5KuuYMZK/oU8EMaMQlA4dHXlyBrt24kc1pOWhu4QzddIhzN4eAjhdvvjcCREFO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:41:41.7740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27894d5d-6db5-4083-749c-08dec2b45b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

Hello Mario,

On 6/5/2026 12:13 AM, Mario Limonciello wrote:
> So at least for patch 1 if you run dynamic epp, and are plugged into a wall
> you start out on EPP 0, but I'm pretty sure that's usually the firmware
> default anyway.  But this gives me a (better?) idea.  How about we just
> read the EPP from the firmware initially at startup?

I'm looking at the ACPI tables across various generations and, from Zen4
onward, we stopped including the optional AUTO_SEL_ENABLE register as
the platforms introduced MSR based interfaces.

The Energy Performance Preference Register definition reads:

    If supported, contains a resource descriptor with a single
    Register() descriptor that describes a register to which OSPM writes
    a value to control the Energy vs. Performance preference of the
    platform’s energy efficiency and performance optimization policies
    when *Autonomous Selection is enabled*.

I think, the shmem platforms should call cppc_set_auto_sel(cpu, 1) just
as a safety during epp_cpu_init just to ensure we are not missing out
on enabling it if there is some dependency there.

> 
> Something like this:
> 
> ╰─❯ git diff
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3f06e33f47120..0e32f7f92651b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1939,6 +1939,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> 
>         policy->boost_supported = READ_ONCE(cpudata->boost_supported);
> 
> +       WRITE_ONCE(cpudata->cppc_req_cached, FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, amd_pstate_get_epp(cpudata)));
> +
>         /*
>          * Set the policy to provide a valid fallback value in case
>          * the default cpufreq governor is neither powersave nor performance.
> 

Building on top of your suggestion:

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 72df461e7b39..27ed0db02bcb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1882,6 +1882,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 	struct device *dev;
+	s16 default_epp;
 	int ret;
 
 	/*
@@ -1928,9 +1929,22 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-
 	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
+	/* Cache the firmware programmed EPP */
+	default_epp = amd_pstate_get_epp(cpudata);
+	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);
+
+	/*
+	 * Shared memory based systems may require the AUTO_SEL_ENABLE register
+	 * to be toggled on to function correctly. Since the first call to
+	 * amd_pstate_set_epp() may bail out early if the desired EPP is
+	 * same as the one configured by the firmware, attempt to toggle the
+	 * AUTO_SEL_ENABLE here, independent of EPP programming.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC))
+		cppc_set_auto_sel(policy->cpu, 1);
+
 	/*
 	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
@@ -1938,7 +1952,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (amd_pstate_acpi_pm_profile_server() ||
 	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
+		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
 		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
 	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
---

I'm not sure whether guided mode needs this but I'll get my hands on a
Zen2 part to test this out.

-- 
Thanks and Regards,
Prateek

