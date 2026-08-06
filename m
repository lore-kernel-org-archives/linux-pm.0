Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733EE1C862D;
	Thu,  6 Aug 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047034; cv=fail; b=lwFbyZEbFWXgbLnWF8+CG5pc67ImxL9/r8vyx0OKqj7mQ89X+yPYspiw3NbDfnLpZzVChP3OAnSW3wTTuZ+FBuo0aJi7osAMzlvimpAJ835Fj1CNQq/1QLAWKbhlaJNZ0Fc+H4dUfzBmEcFiJDoS2+Uh4hQpB+ZRUAMOSMc8bqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047034; c=relaxed/simple;
	bh=FGMp0q2Ldx5eqHaUEPCgpU+FUdYysWD9e3ye/FlCqgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdXlIVapK5u2BrRhSD0eIBZcSjcNMGZWnlHrSoWF/5E6CNdkqOhajtvq3aAT92V9CVmlLFpA7bXMV7rgH1YpeR73qLuRoSQEKPYb8h5aevlx/tviV2xs+2vCNg+vDjjPwmvPTIv71BfPoEdly44RHQ2TSQYAg32w2lXjBa9bfjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibgESj/Z; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibgESj/Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YonMuiBIU+/HdBRzTNW3WhU84zLUC7Y/Nkvw6a3DZDmCz6pORIndNKq5KkegILK1xBW4v5GX3LUL/tDX+dSomuwu7apbwz9aKvFz3iHTYuSz9x/CfR8Fy3Cuiz8aoQK6Wr0RKYXCZXpyogAAd5eTQGNeKYF3IXvXkMJ92QL8n5LKW2oxDJ6Ulw0GqsqN2b+P+omvjcWrpMUFJIm3cKjVigM76mLTNrWN4lTi14hcH1McvJYV1JjHjFtuyfa6SYMNZBw1eyzEx0rVyDmRP15ZqMhFtxLb79Rmtkh4+VXEw+EjBkxP9Tm5DZTYOuIi3zBggfF8EkEZNOguEu+rixNUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ivBExqWQvFTJkUSGrjVpTXZyEoqSnaB5eDuUPg5wJE=;
 b=zBpPTCi9L0qkEil0Ijk4EdtEsf41VS65Lu5IrOBby7DTXtErRdswAGRd7cKwO+TrPhf2FG/hplKML8d3rhCJTxK1DWBiiPQoCD6MVNqU0//I/eRDV1Xn6QDtx7l2Oossh1UQbZh0gatK7qGmZweAjHG1SO6+TN+2lvg7wf4r2p7AwGkEXUX67Konmo32anlgwY6Ug/WxM6qu3MsaNDcMfBSUTKQQ7YLXNKeLoxlHiPSf8y0I8vg0lhQ+iMoHb1ZUpklV2PfMLtMrPmN+UMsvXpQD6H2KX+703qe/d+yKUdEYOpCPPX5f32gD3e2lKnQ5pjP3zxaFxkJkQUGW2Jtl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ivBExqWQvFTJkUSGrjVpTXZyEoqSnaB5eDuUPg5wJE=;
 b=ibgESj/ZctQQ3vytE/fSZmd4jhDbpXjKtnPnIiaGaExIdNKwIkX4U3N7p2Ztv83IvPQgprP5ghVyelCDI6t95ZZ5IXCTcMYqrrWeDnozWMNb5cekeII+VSQfpziPPcRZsBL1CG8S8qjgkA3Ycv/yfk2l7yBaKPGFjwXRcNrQYFZ5ZUOosc7CNUL+PNAWY/z6msPGTyQVGUao6Dt7ZJskUdI+hmI9xGRww/Q4Qp2I+FeTGx99nfvQT52SOgNke+b2ZRHnvcglGJDE7u6tj6FltR72DEZc43T3UukVYFDQ4kZP0DS+uXdjp7LyYZspNAk1QnoW9wYJeWs1uQrPJp1row==
Received: from BY3PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:39b::33)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 20:10:16 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::72) by BY3PR05CA0058.outlook.office365.com
 (2603:10b6:a03:39b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.8 via Frontend Transport; Thu, 6
 Aug 2026 20:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:10:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:56 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Aug 2026 13:09:50 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.com>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v4 4/4] cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
Date: Fri, 7 Aug 2026 01:38:57 +0530
Message-ID: <20260806200857.601152-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806200857.601152-1-sumitg@nvidia.com>
References: <20260806200857.601152-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb6ef59-b27d-465c-0812-08def3f6bb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	nkt94pJfx76cKaOqsOGfS0UhguOC++Ai+dGYioQABqRTmM4Zr54Z8cW9K9VQN+ZN5OwcdgW5B5pwpxOF8IrNIVKvR/vcAp6vPqJ3BJq0O9GgYXgULeX559M+LoiWtMdXnFDXNlt++iRsJySGIlkS3Fy4da89TcweGep8RNBQCtOFOe++UqsDBF5ko6Kcy7snHmvxsHcRbQO1lZzt0Bd5sqzPBaSFtGna3TI31Tyke6mbRKMtbg3kJrbdt4bMDEoprQyG+yZnga1feUbxc1DuNjXIb5R/X9/VpSGVLGzZbkBx2pvgdjNcfP7kzcEzyAs1TN6m0jSsaD7OsLkjL0wDguaflUO/S3hV5keYcd494IXfj29uxiXWAcKsi6GqDduK+C3iRnaKJ0asGRE6Dzp2I3Ydic3kG8j9hDWOYY/wLAQgOx3YMEsD1z1U7Js6hod5/hFxcQV6zK41Hd7GqkiDXxk6Iekw4i7sZc45xx4eDSRn+DbEKFVN1iy3a+ePSB33q7m755KDDIWw5xZ6PWr1u1IpNMFsCRb3NE/gkKlDh+neKf21iyMxe31FqpMbAsQyecnZ84E4R23BCa+vwnoVclntrxfJWgtKX1qSWWqbgJRyH+RiUaMRkd/9wTeTgHr0fpIjGj1oWRqVhB7c2v4kRvzpPW5KNGWXVK1tPNXWC2T9jIz/gs6l5VdG4mOLO9CkP3+pME5jGLgTv/xY3H6ZLx6ZZRKYqDrGyrreEAKWeT0Wbii7VF3UZtRZ4ckZ/ScI
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rlfTtxgwlgaktdx5N4X16tYnYszZyBlvjk3HzHH1apEB/th1W9rfoiWolZFf+ramgi3Y3riKRFt6Elec5NhHU8vVYeXwN4kEAU3rVZrq4c8qymYLftBCm3gbXTUs6/HaF8suRnPp91j6QNuRcVIKFglswr8OAbS03wIlfCRLh1j408TgQedx8UWYTxZPk0CIcTlJYwdXd8SsLE/RvSBBk92m5JU9ss5h9nFEMJpr3TfJJ8di9zbF0k/Np/7XaHD0Mm98/1yimUsDhHHHuTVLosA4pHFRYUQLM+Hhe8jEuXE98ngd0hWzzVtvFJ4aJ25cYGuFjuI6r23icy0rhOT4KXH+Jq8sQ9ZH99VZOQGfkQ51zeezswavQO3rrNwfukMZoK8nCl9XTE29SSipLBg+AukQzBLYE1hJeqdTgdq05n0ajr78yxfhuQFycTrHeREl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:10:16.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb6ef59-b27d-465c-0812-08def3f6bb8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430

The driver preserves the OSPM-set registers across CPU hotplug, but system
suspend/resume is a separate path. On platforms that reset those registers
or the performance controls across suspend, the values are lost.

Reuse the same save/restore mechanism for suspend/resume:

  - suspend() saves the current OSPM-set values, restores the firmware
    values and sets a per-policy flag. It runs before devices are
    suspended and before the secondary CPUs go offline, while CPPC access
    is still safe. It also covers a policy whose CPUs stay online, for
    which offline() never runs.
  - offline() sees the flag and leaves those register accesses alone,
    parking only the performance request.
  - resume() needs the same steps as online(). The core has already run
    online() for a policy whose CPUs were offlined and brought back.
    So, resume() calls it only for a policy that still has the flag set.
  - online() clears the flag, so that a later offline() takes a fresh
    snapshot.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 54 ++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f8628b1fc6b7..32f38b0c492b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -87,6 +87,12 @@ struct cppc_saved_vals {
 
 struct cppc_policy_state {
 	struct cppc_saved_vals regs[CPPC_NR_SAVED_REGS];
+	/*
+	 * Set by suspend() after it saves the OSPM-set values and restores the
+	 * firmware ones, so a later offline() does not repeat those accesses.
+	 * Cleared at init() and by online().
+	 */
+	bool suspend_regs_handled;
 };
 
 static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
@@ -125,6 +131,9 @@ static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
 	u64 val;
 	int i;
 
+	if (saved_type == CPPC_SAVED_FIRMWARE)
+		st->suspend_regs_handled = false;
+
 	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
 		if (cppc_saved_regs[i].get(cpu, &val))
 			val = U64_MAX;
@@ -952,9 +961,14 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
-	/* Leave the platform in its pre-driver state while offline. */
-	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
-	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	/*
+	 * Leave the platform in its pre-driver state while offline, unless
+	 * suspend() already did so earlier in this suspend cycle.
+	 */
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled) {
+		cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+		cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	}
 
 	/*
 	 * Request the lowest desired performance while the policy has no online
@@ -1014,6 +1028,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
+
 	cppc_cpufreq_cpu_fie_resync(policy);
 
 	ret = cppc_set_enable(cpu, true);
@@ -1050,6 +1066,36 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/*
+ * Save the OSPM-set values and restore the firmware values here, while CPPC
+ * access is still safe. Secondary CPUs go offline much later, with devices
+ * already suspended, so offline() is too late for these accesses and leaves
+ * them alone until resume. Doing it here covers every policy, including one
+ * whose CPUs stay online, for which offline() never runs.
+ */
+static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
+{
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = true;
+
+	return 0;
+}
+
+/*
+ * CPUs offlined during suspend come back before the core calls resume(), so
+ * online() has already run for their policies and cleared the flag. It remains
+ * set only for a policy whose CPUs stayed online, and only that policy needs
+ * online() here.
+ */
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
+		return 0;
+
+	return cppc_cpufreq_cpu_online(policy);
+}
+
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1364,6 +1410,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.exit = cppc_cpufreq_cpu_exit,
 	.online = cppc_cpufreq_cpu_online,
 	.offline = cppc_cpufreq_cpu_offline,
+	.suspend = cppc_cpufreq_cpu_suspend,
+	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.34.1

