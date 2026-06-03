Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C443D502;
	Wed,  3 Jun 2026 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479557; cv=fail; b=P+o2IeD94cnI63bSkSxwLoCe2ad1Q2Rk3XOLG42p39BKutD64TgAp7IQPNvFkUU7rTwDISCEZD5FyGiyd54YI6/BVG9WQ4D6LHqVNl3P9BiwXrVfXM2gDSy/j5ZTNaueBrzlA2qZ91oudX/bQqEOhCik8BU5wbL5DwLQ2ffinpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479557; c=relaxed/simple;
	bh=ScvLr0uBLnV1tm6ZZO3L1vg0FHAcIu5yZysdgGRK1Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uEUD36EUDrHlDA0sk2ShBffSFL/M5BoXeMBS0TLwFWcEvT3H1LOLlLC41Cw2IkBCgQYD99n66ZLPWs5AI05Gz6IXy27E0hA5+Upaeyg4yLBd6gDi9vA5HN+vxM6DooKZGuJbp5GfR8hq2EJmzBjTSf9UG9JMYccLfukMhVoft1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nWZWtw2q; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nWZWtw2q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct5sWumlybFe2jsh3OCWg+iV4J0ax2VIa0uak5aYCUxque+kmw82dm62d+M+2AKVg3M2+VJC+X/jYGP7/1hYN1eq7mjMMaMEi1hl+DDMqJki47dxQWDDdXDacYbJEiAmLGnt06x6vD0CWtbp5wLMlPd5oVE0Qg/AJ/2Gq2gJTS3gGDN+Mgesw4ujAbOITQ9J4SvAFMC/9nR9qih6vrlJmTcl+XfHKpIYakdaZ5dU8c3b8V9B0sNx9QzVEjKHCqwDByxLlqDTgfim3PM+aIodtU952AVNGSsqSxqbpL1cBTT7D36zXrkq86MLKIyY6jKEu68UP0iTvQIC0cKtl57lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/Mn4RgE4TU4kr+kiKhtepJpDv7QfCngzRVj+wbN634=;
 b=cu4A3hFOAoctcI5RKjSpaqby5uThh8vrSe0DMuVeAi/6ExaA8ke4asdJLyWRyiOXWGOgb2jcOkolVFihjgHKIz6gGg77UV+UDMdcKayvspfOVtiuOY7xT6LbZPCYAOzOr9BuJSTmxRdPXABERn1n/p+XKR9OfVOL5hur5U45NKOj+uoNqs5cef8VwGYrX3BO5bLR5oNkCgziw5WsOQR0NdY0clHzGtljDwTOp3OWh7jhStIpTTP/ZIaaSEhapDrEszxf339663DEXau1EJ/GCmPkyo+C/Ob8V9N5FvlHhbMo89bB8sHq1fZl/uwy/B0wA7DXQobk5U/rkw2lv5ErQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Mn4RgE4TU4kr+kiKhtepJpDv7QfCngzRVj+wbN634=;
 b=nWZWtw2q3haG4zQM75r+1UflaUlQ6ITqfQV+c+4+JCrchne1NZbYYP+Ry63SeI00Uq+AEmGZSs+XrMT8qMjDeWJ5k/GVlYXLQHe5E24Q5mHZUPug20lZkcADATNSvdy/trCJzO7RAWFoxG55fOuVzAbHY3JnNaLNl1KiGoOAsyQ=
Received: from PH7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:33d::11)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 09:39:10 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::9b) by PH7PR02CA0009.outlook.office365.com
 (2603:10b6:510:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 09:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 09:39:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 04:39:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 04:39:09 -0500
Received: from [10.85.35.241] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 04:39:06 -0500
Message-ID: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
Date: Wed, 3 Jun 2026 15:09:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] cpufreq/amd-pstate: Prevent active mode on systems
 without EPP support
To: Marco Scardovi <scardracs@disroot.org>, <viresh.kumar@linaro.org>,
	<rafael@kernel.org>, <ray.huang@amd.com>, <mario.limonciello@amd.com>
CC: <perry.yuan@amd.com>, <wyes.karny@amd.com>, <stuartmeckle@gmail.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260603082143.11215-1-scardracs@disroot.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260603082143.11215-1-scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 247be17e-5074-4635-f20d-08dec153f6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	z/BbKsLiKmLhYoRNBblgyQyzHg6BNMPTwomH/0bv/+WXBtvUbUPsv8dgGae1C+RitoIaTL9h0+0IfR14DT3TczgLpEiCRoDDLFWEK7BkyxRdFx5uEBcqVT4z6bhuagGtiq4ilNMp5dg1OCsEvxgBUTDL8vJXQMlCj3i2j64+gLKKAkgPtsU4Cny3SEoipWJ7PCUCYBvBwoHNtaZ1TYA5CaQXa9CmHhx3sj+pkoO5y9qy95B9YWRegVLcXIQmoAroTx9/mcQVamXNC3LM89sJPnDsjN3IIYgrzcvlSzXqiwBxQrdek9Z2IEvtgKx1gQgFfC3HRFYQECiztaFcwd4l+RH1u01XKDheMhhPZ3NPzMGBFeuhKy8T1wqxgtpsm1+HuTideitLDtvX0oY3T+cNhkq8GX4I1nHglKyhd2/xJQ9arEPyo7WP9OIBGeREJHBiQppLP2ABMy5mGZekzj+XHXyrYtfWVhh5Q9JDmCl84QnCa+RjB3URjThhr3hVF+h/NrkAHQy2UcL4/nG27HSFjvaAgWN6bblYZutSH+Js6rmG6kBi38s/4artVvLr5Xbns6h31YrE8jqroMb3BidElUR69fLPdlh0O+fUSJyDsYJ/M3oPIC+U/HpRFxYKdn9GbBqvBlQp1izi+RXXOcTk34hR6A3HL3OSwWZ02XAf4rGEddboTOl1Oa2iYzXdpWOj+DI9zbHlo4NNKe/mQFejumzJB1D6UuJiVBxavwfmYKk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iMxQJtvUuEJXhPTAILCpPbFprVbHGaHVMQoHWbLY9HHxG/C6JyY3u0zlLca5/KPpPwc9CMdUccx56lBQRXNbkF15MikFG+SDpi2a1mGaoG7koWJUrRh25XwAVwPGf5+Yb7AAp2acDtFgVBg5qW7pqJaQiJYVrQbAfMxjGhUeXBu/NAFBSR/Kvjr0jbFn5T2SZZe5crAhqiyJVcXIoC20HMeI+j4+UZy5l11dy1ctclV7FMu8EMp3LeO1vnDvtNSDvIBVJIuc/4OnDAmn5G0f41yJTZ6VxBIug2/K6VII68+YVbDZ1fN7PzFJvwaKyajXT2ncD5Ta6yswxo25YAOeu/h1W1sqot7CtVnyV39KveeD11pqSEjkR+oC4X65toIOg8Fo6uSS5vyfVg2M9Qo8uHEkKrv7pjSb/WkNrW/A9+cUcvZvOl641q0Ce0/rB7il
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:39:09.7108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247be17e-5074-4635-f20d-08dec153f6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

Hello Marco,

Sorry for the late follow up on this issue.

On 6/3/2026 1:49 PM, Marco Scardovi wrote:
> Hi all,
> 
> Mario, I've made the actual changes you have requested me on bugzilla for
> https://bugzilla.kernel.org/show_bug.cgi?id=221473 . Let me know if it sits
> right with you.
> 
> Prevent the amd-pstate driver from loading in EPP-reliant "active" mode on
> systems without Collaborative Processor Performance Control (CPPC) Energy
> Performance Preference (EPP) support (such as Zen 2 and older processors).
> 
> Zen 2 and older processors do not support EPP. Loading the driver in active
> mode on these systems pins the CPU frequency to the lowest non-linear
> frequency (1.7GHz).

In the initial report on that bugzilla, for the good case, you had:

  ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq <==
  3693566
  ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver <==
  amd-pstate-epp

Which is still the active mode driver. I'm a bit confused as to how that
got to 3.7GHz. Did you do a mode switch back then?

> 
> To resolve this:
> - Unconditionally probe EPP support during driver initialization via a new
>   amd_pstate_epp_supported() helper, which queries cppc_get_epp_perf() on
>   the first online CPU.
> - Lack of ENERGY_PERF support or any error from cppc_get_epp_perf() causes
>   EPP to be treated as unsupported.

I believe even the AUTO_SEL_ENABLE path allows cppc_set_epp_perf() to
work which would have otherwise failed the driver load during
amd_pstate_epp_cpu_init().

The EPP value makes no difference in that case but there is some
interaction that seems to cap your frequency to 1.7GHz

> - Cache EPP support to avoid repeated capability checks during mode switches.
> - Fall back to passive mode at boot if EPP is unsupported.
> - Reject runtime switches to active mode with -ENODEV.
> 
> Please review and provide feedback.

I think I may know what was happening: The initial cpudata->cppc_req_cached
is all 0s and as a result, you may be hitting the early bailout in
shmem_set_epp() which skips enabling EPP mode altogether if you start off
the driver with AMD_CPPC_EPP_PERFORMANCE (EPP: 0)

If it is not too much trouble, can you try applying the following on top
of amd-pstate-fixes branch [1]:

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 72df461e7b39..3a13ce7256e2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -426,9 +426,6 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 					  epp != epp_cached);
 	}
 
-	if (epp == epp_cached)
-		return 0;
-
 	perf_ctrls.energy_perf = epp;
 	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 	if (ret) {
---

and booting the kernel with "amd_pstate=active amd_dynamic_epp=enable" in the
kernel cmdline while being plugged into the wall and check if you can hit the
boost frequency with your workload?

[1] git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=amd-pstate-fixes

-- 
Thanks and Regards,
Prateek

