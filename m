Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993684;
	b=XWaY9ANMl8KnU1iwexY4Ax9Lo7ohZ6aKzxGueh1HL3DS6jt0L1GF0Sq+CSILg4xD/IWS
	 VKYOtt7Q1ssxAmSFz2JFRuvq9W9LKMIKMtmmzXzp5qyw7Ty9ynt3b3908tUvMXGB3GD95
	 emwvWbEOMwX5+UdWBvYgSununruvA2sg3uf6j5SWBY2GkME/4+xngXB0VK+IQPQ1N0Cfy
	 TUpbGBeAmI3O1htS3dDLMc/5eufIM7hqcDKpcuP22l7p2TVbGE0S5+7SvkN6S6Rr2B6zo
	 0sLA1NzJ2CJrJMiXB3JlZfW9aL0Obg1i65onaFSqxVu/nDItX2deKXYNkw6aRY9c1BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993684;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2Ge4SLDahCfXVf8j6zE4B7XssXPo+q/75j4x7oTI7lQ=;
	b=dVIGkq2NsPymptJ2qznCCJP3RQ664T5tpip3vQM8c9dUPCpgx5oNWaFDFKier4MrUqIR
	 Ig0SgtbOtq5tULfq1Xp4kNbIAO3DCgStknSswyUI+llpBfgpJxbSJec+ipkTs47lUYS9E
	 9ByKqNdA8xquROkPZExmiK255ze3YTDRMYxMzuKqHTj7Yp9lka7pGJ2vRoEpjuJIex9sa
	 oRFzwpN+ZJQqBTNa2+i0nKcGRFnCPh3CycdKbZ3t37Rejk3DYMx2oyUPiMp0uWxgr4v4C
	 Vz88bDDp9ODcCt/GHbJDoiTBPkaiYiwtx1OnprdrP1jK63GgK9e7bkjmL7it3rFdeRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F8NZ3PvI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.64
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B2606A33B;
	Fri,  6 Nov 2026 19:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF2B2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F8NZ3PvI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyPy2aoyOkgjk30bf7TRHSdD9qxSGHdGVHlvglTf8bhftNbOPvYcCQDfa6wwEGFQijaigWpQdlezGfit9NyNW+UuZFR2sq0QaXlfX81QzOAYdgbXA96wGi2KbXlKBukegfw6/e/FPvk0DYYoeja8GMYrGnGK/ib9WCtGm1fSANs7/Y1EM9MPHi5eMCwJsQy0yjXcZ4hzFydLJq9NsRR3gfXc7dI1uW2dLScPWIj4FVoeZVGCD1MK82ruHTH00RU9qCOm3aJzQ6vr99hwlfSONBgQ0Vr3t5FPYGNcfo1mh04JTQqz2t5bwdXIE82tUNxi3KVd6I6obpaLuaoZ5lEFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ge4SLDahCfXVf8j6zE4B7XssXPo+q/75j4x7oTI7lQ=;
 b=R082VCMm7TvkpMScGT1MciN8txi15QVb/6IO5tr03Vk3o7ASgQzyXSR/nicvapfSNOpghfVen8Z1fOFtvuFGnjDulwJmf5LFc/a1eWwDkfAzTn0t/uIZKx1kaeg5WKxn6FS+6LJwrV2FVXFLE8mAk9+BjhNwocNfM0xWey68jWHUBkuyJ/BoM5V+9PQFE6kr/EzXalgT8j+IQ+nzgdsr1GZ0SmNpyXML1ptwgUaceYNeeavJnJepa+U1VGqWX2cmO5X0Teq2rGuW01oCpZRq/2m8k3PInHP1e09tSCgEAj9YYOOC9WxnNWj6IWx0Rou2QVJmADyb6LOZJ/12nhbE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ge4SLDahCfXVf8j6zE4B7XssXPo+q/75j4x7oTI7lQ=;
 b=F8NZ3PvIkPsnKKz1nyFy4iWtEwJ6M41XHEtP7WEvTQmFNLlY0jcBF2hbg38pxgq85T1n/bT2G70UOIC6CM/ZwFVKzWhourWB7740jID4mp0WXQsdM+nDE915k0QWDGcNkb1jJ6AnURJmvKUCGaPKJxSTlTZsPUS/ReUQUJYb2XOx9LtxG1sboJOhDXhVGQ3Ljk43xxfC5o5RDO+1UKvY3Q+1ATzczuG+SGrWJtqmCl3QW57PcqZUT7WWEcoIkC7dbaznK2+wtdTXPGaXjqgDdg37XlUZdSaFI9wZj4ZafRhO/cz2sF/jV5bm1aqarKYtLRnDvaOMUy7iW47WN2UnMQ==
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:34:35 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::2c) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:34:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:34:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:34:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:34:18 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:34:12 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v9 5/8] cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
Date: Sat, 7 Nov 2026 01:03:01 +0530
Message-ID: <20261106193304.3347374-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106193304.3347374-1-sumitg@nvidia.com>
References: <20261106193304.3347374-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1ebbef-7ae6-4e76-ade9-08df3c3cfd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|921020|11063799006|56012099006|261021123027099003|261022075727099003|261009223027099003|261022105027099003|261021121427099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z8unxQMPCKfs/vAG1Z1d+kpMpcaubdW6MXjFgXCAL9TQbrNfLzwWEsklkF6L01JidC6ESwzvaERLuWLSpO3Xj6LGaFq0W9cIQkDpUfHI9eP161+ibBR3ko8IcTby05pGsu4KZvYk2iKDi6X80kt/tCDDUrPT2uPfIWbZljNZdQ0N9iKS0N6kSVR8jpkApmGDKn/5ZqqJA6H5Df/JUUisquzrtOmsW+cIxVNQhZbJ9CJpmOjAITrOYzx/E6i5PyBf4jqmbK40UEhVHkHFgCq0CDqN0v1O5ZLUVwjLr7gFnF8J9SXaz9wgw7ML7jwEUx/yHmfMfNpGbWf0sirrSE6azYh0qUFvOCAW3XneFth8vGxJuvcQY2BiYElUKpxHy0xrDbvFrLEUvzrwhak06qcAzUDbp5j3B8mIy2AHg27M5rapF+Ms9P/C53MMl4qN7a/NSPIuD7/DAQH50N4PFWdCkH8DqDsGNA1CoozJLj4B7ONU8wVuOyxy9reWyZ6LLyyzwieJcT0BGSTkhV3yxzVbiBveNdPjDdczeXqzXMAgxcLtAh/oJ0PxtIUACNlRvg0Wk8MD9BlGAPwrU7qMyAMMT3xoA8J4fZlfVjSyuxS2EAAWBJzymveLVnLGGl0P9JkoL2usdph5DBqoBFQHuyvT6XknSpRmGFdfunMUzXWJmsaihxb1AlQIeMZ7sew2eHKIFSEzU3Jrsr0AwBKdVifb/j++1pfnarjc6XLfXFQ+YzqHpnraIc1SOlwl9j7fopCO
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(6133799003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	arbs9cxVraXMz33/E2zZ+t9M7S3sDnhoITt2yY6Ux1H+xYRfzIT9v4AjJLc8Q19/XeiW96Y1QvFcgWPUEE6hhdKhvoQuQkbbCaOF/VCOrz9jk2Jb7UyNuuvCERVYscWIwk2pnlwcj1KdJauhFZK8/rpYm6fqvrDpCzy+lz9LdLiYPEIB0zv81yVRk35JPLWRjJU3SRk29YRbwdCRdb/hEIQhuFSh5Pj3VrbEpNj4z4pAOxMf8c5HkQDpl8pE35aU2Or1uQgS0ZrR+1bGSzHVgptbSzvVcjOPM2C5dfzS/MgbQvzfleaFd8a+KpAVkCZybTUl8HgcKPpCN6MF/tl+PM7Kxx2UvbhijBFgJtVRYyHdoIdVlRc1WzfbrnPIUbAAw3z2imTNdbUcPaOp3RvnsPsl1CVPWPKvaUFtneHDdy/S6sakTyuDMqFPOOfMV01w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:34:34.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1ebbef-7ae6-4e76-ade9-08df3c3cfd18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

Some platforms reset the OSPM-set registers and the performance controls
across system suspend, losing the values the OS set. The hotplug
callbacks do not cover this. offline() runs only when a policy's last
CPU goes down. The boot CPU stays up during suspend-to-RAM, so offline()
never runs for its policy. During suspend-to-idle, no CPU goes down at
all.

The cpufreq core calls the driver's suspend() for every active policy
before any CPU goes offline, and resume() after the CPUs come back. Use
them to restore and reapply the registers, as offline() and online() do:

  - suspend() restores the firmware values and sets a per-policy flag to
    record it. It also stops the frequency invariance updates, so that
    no sample spans the suspend.
  - offline() skips the firmware restore while the flag is set, as
    suspend() has already done it. The rest of offline() still runs.
  - online() does the same as after hotplug. It re-enables CPPC and
    reprograms the performance controls. It reapplies the requested
    values and restarts the frequency invariance updates. It also clears
    the flag, so that the next offline() restores the firmware values
    again.
  - resume() calls online() only if the flag is still set. This covers
    the boot CPU's policy in suspend-to-RAM and every policy in
    suspend-to-idle. For any other policy, online() already ran when its
    first CPU came back.

resume() no longer marks the copy of MIN and MAX that fast_switch() uses
as out of date. online() does it, and every policy goes through online()
on the way back, from CPU hotplug or from resume().

Also make fie_init() cover related_cpus, as fie_exit() does. suspend()
stops the updates on all CPUs of the policy, even offline ones. When
resume() calls online(), policy->cpus holds only the online CPUs. An
offline CPU that comes up later does not trigger online() again, as its
policy is already active. Without this, its updates would never restart.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 74 ++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 27ef1ea41a3e..76cb803617f5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -86,6 +86,12 @@ enum cppc_saved_type {
  */
 struct cppc_policy_state {
 	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
+	/*
+	 * Set by suspend() after it restores the firmware values. While it is
+	 * set, offline() skips that restore and resume() calls online().
+	 * Cleared by init() and online().
+	 */
+	bool suspend_regs_handled;
 };
 
 static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
@@ -332,6 +338,7 @@ static struct scale_freq_data cppc_sftd_pcc = {
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
+	const struct cpumask *cpus = policy->related_cpus;
 	struct scale_freq_data *sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
@@ -339,7 +346,15 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	for_each_cpu(cpu, policy->cpus) {
+	/*
+	 * When resume() calls online(), policy->cpus has only the online CPUs.
+	 * online() does not run again for a CPU in the same policy that comes
+	 * up later, so use related_cpus. It is empty only during init().
+	 */
+	if (cpumask_empty(cpus))
+		cpus = policy->cpus;
+
+	for_each_cpu(cpu, cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		cppc_fi->cpu = cpu;
 		cppc_fi->cpu_data = policy->driver_data;
@@ -354,10 +369,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 
-		/*
-		 * Don't abort as the CPU was offline while the driver was
-		 * getting registered.
-		 */
+		/* Don't abort for a CPU that is offline. */
 		if (ret && cpu_online(cpu)) {
 			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
 				__func__, cpu, ret);
@@ -366,7 +378,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	}
 
 	/* A shared policy may contain both PCC and non-PCC counters. */
-	for_each_cpu(cpu, policy->cpus) {
+	for_each_cpu(cpu, cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		if (cppc_fi->pcc_work_initialized)
 			sftd = &cppc_sftd_pcc;
@@ -969,6 +981,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
 	ret = cppc_cpufreq_save_firmware_regs(policy);
 	if (ret) {
 		pr_debug("Err reading CPU%d firmware values: ret:%d\n", cpu, ret);
@@ -1023,6 +1036,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
+
 	/*
 	 * The platform may have reset MIN and MAX, so mark the copy that
 	 * fast_switch() uses as out of date until the restore below succeeds.
@@ -1078,8 +1093,12 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
-	/* Leave the platform in its pre-driver state. */
-	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	/*
+	 * Leave the platform in its pre-driver state, unless suspend() already
+	 * did so earlier in this suspend cycle.
+	 */
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
+		cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
 
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
@@ -1105,16 +1124,46 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+/*
+ * Run for every active policy when the system suspends, before any CPU goes
+ * offline.
+ *
+ * Restore the firmware values. Doing it here covers a policy that keeps a CPU
+ * online, for which offline() never runs. offline() does not write them again
+ * in the same suspend cycle.
+ *
+ * Stop the frequency invariance updates too, so that no sample spans the
+ * suspend window. online() restarts them on the way back, from hotplug or
+ * from resume().
+ */
+static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = true;
 
-	/* The platform may have reset the controls during suspend. */
-	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+	cppc_cpufreq_cpu_fie_exit(policy);
 
 	return 0;
 }
 
+/*
+ * Run the online() restore for a policy that kept a CPU online through
+ * suspend.
+ *
+ * For any other policy, online() ran when its first CPU came back, before the
+ * core calls resume(). That cleared the flag. Only a policy that still has it
+ * set needs online() here. Either way every policy goes through online(), so
+ * resume() does not need to mark the copy of MIN and MAX that fast_switch()
+ * uses as out of date.
+ */
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
+		return 0;
+
+	return cppc_cpufreq_cpu_online(policy);
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -1446,6 +1495,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.exit = cppc_cpufreq_cpu_exit,
 	.online = cppc_cpufreq_cpu_online,
 	.offline = cppc_cpufreq_cpu_offline,
+	.suspend = cppc_cpufreq_cpu_suspend,
 	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
-- 
2.34.1

