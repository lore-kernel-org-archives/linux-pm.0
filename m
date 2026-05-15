Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8663AC0E4;
	Fri, 15 May 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848021; cv=fail; b=lriYFz7v8qJRFxDnNzP9vxyxBDPl2EpJVIMoBZ6uoj5Kp0l1Rnyu/6YAqLtZE2C1e6EPas/jdsvKGJjYHgfBrpCEqfq7YtjqgVXsqbJEyW80ckF3ZHuIxrj/emC73dKdHhP1v3ao7A/t5fGHMc8QW8UToEEImtscuNEdbFXgCrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848021; c=relaxed/simple;
	bh=HGKz8HqMN3T6rxhY893xEATqFUdfntiSi3uCHokNGkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsjmYbgE52KKyijGJ13ZTm72KiC2VU5f3qbFOung6Nz3mi9tu5+iRLsNoZ5Hnbx6l0ZjKG48rINTKtR3uXGkMESSgcHOhXa17bpAoH+QwG/t87KFp1XLWAckinslyc970/xJYpVqZmVxpV6oQWPC+VCnhL310D9KAG/GqA/Vqrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ekvISr7I; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ekvISr7I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiHp/PoQHNTQZLw6K3vP2Jq7qhggjzSoVi2IHviaPVInz8KVnayr4iDbwOfImie65nKhm3pRjsjjb4z6DnirUV8ZHPFl4n+d30sGvHUdw1Clr36mhgWfKzlpnBEmAX49vYJ+1L0K3a0zrGSkeOFSlgOLpBy4+FDAr5umKA3X6vCV0Puah4xDd1LlBd8EmGCzrCFEyO83fjqYX1648k29lu1Iv6qDH5FCu5tZVZ+dDt+qEFvIkOyEhkUIUpbMTsAMWX1uiPAMPjOfDLoN+wx7gB5cSgZoi0I18qadcXU4tVFdeTmPcdo0XlLz4GAxpL3SipBebEh/+6vEqJc/KOk/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llTLiy+YxlEnDOO5CzBYgwuM46axnO7eEC2rYWJTwbA=;
 b=bQLF+/auRMEDaj/o+hlJM8ilhIN/UNWjgK2CmrEItqptsAD5itnIkIQG307BWwQtW+WFUgWWJc597I7HT/aZVjxyMjb//kvRkb04V4k+ecMqS3zcce3o0EIaI3KxXTnqK3B9YyJo/QpNV1PFgLeAMHg6dkmS/l/ZiIIjqjnYssuuxhjLeMGSXm3e/rEJ+3z8KqFfz6KY0xIjUwIggrG2vxi6IUAZNubWR6Qs3gWZXvxInuu9BoW15AdCkMKCKHh/vHq+/Gyg9TxOwb/KfISPPdj8dQfqWsGQdYvx6XeaBEaq7SFjxYuBRqNjzIdtvXYCHEHvlynGN3sN2jmbWwalhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llTLiy+YxlEnDOO5CzBYgwuM46axnO7eEC2rYWJTwbA=;
 b=ekvISr7IVh7pEGPJs0U4nDRB+3xmoo9MwW8RU9wB+iZc34kannqRapaGW3vivr4Kmq5QnOztVlXuzyUYX+yeLrjdo/IbaHIzkvf8ukJ1t+4wqSk5Secbl1GKR0rzeDl/f50QZ87tb0d4++tioJ0Bf2fAXu5psPqpMzhVVhis46SFrnFjKmqzT+Q1LGKYMWALi2q9XkcrUlBi1RkBb934NEQewXgmx0iDJIO4A/ZfvenXqzGAlreObVDl721/ERJD0nJIDxt5PVs9vFQBmDh5cQmFtPjqXPjIR/UQY/Q353ULZXXuHjrbUes+bH3kVo8RcBSW7HT2jk1N8OgwxuQpDw==
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 12:26:52 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::46) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 12:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 12:26:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:26:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 05:26:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 15 May 2026 05:26:43 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Fri, 15 May 2026 17:56:24 +0530
Message-ID: <20260515122624.1920637-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515122624.1920637-1-sumitg@nvidia.com>
References: <20260515122624.1920637-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 793ca7f1-e96f-4016-f1d3-08deb27d3e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|921020|13003099007|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Q1G7uK31WLDVBCk4T8isoVZRZ5MNVGctfaXsIdtVYI0KgR1SX04Zmze0fXvL5UXaCf0evLjwYeH4lecHDVHijEH2B/+jVUoEpTO0nZFi3mNkT4vQR97IDMukM4FlePZqsAx4caFaku3gih7/VT1/KDwViQevqgkn6bfayG3Wol8NklvBU9W/07kSIfWksJyYkRADYgzCrIBujyys4VoMy+BZT8WnzDab1kpoM0KVk+T5CqBbKHDIyLVkW1Z/ufqfLBMXe1i/a+X5LJZuqHgAGHMdKbhpLSwM20/Rzy0yqhwWcC/ou8H9K7Ats6aH5BQ/gC9qbAtg2W33nrZaWJs/47rlRIr1+vXRwN2Dp4uCVvg3t1NMIw6nGbMM4Fa8JqGfA2iMrkCa7Qchc7+wikuv+DxLM5KcPeCoIH+dh0Am9TeSGdXuU/ef34zzdeqiN6bOssbYc+NAiPNTBm7ykm2xn08Ff/DXj1PjXXMgD7EWH9TGD5srVWGieJa6alu0xen0FyJ+dyeui9D1ThNyDQHQGXwT92tvoUS6yO5ImBJwySr50dWhUs3/sO7XmXjvAtWlle2xRVHI0q5l+tRp+gH0pS0uZbsNCk1Ys88Bnu/ae3cVqCibkximPM19ztZnvJDmEQIN/9OqFEz374xDAOPS1cbVd4Gc9KT5Sw442OZHh5Bn3UbdfS7Twffrw1Wfp34PrswNjq3+w1nk2Sh0iuLc00D6Ez91p8geT1NKAdhGS4uZtt6nAYFY86j2jlu+wVSYh5Y1NUeFl94GSrZt/uC+Rn/79x2u0orW4QUWrWMZn1o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(921020)(13003099007)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H5NcS1Y73jfx3KzvesXOH8hTgWTcWU+05BaRoZktOsZz+NHTgSCVgiFNVX0aHyAqE5ggz/5gVLT0lmkQVoRccr9Buu9KLodzo0HukKANpRrD4mijvEj8polXNrXhIY9JNjk436S1RiZbrra0AgwfkG6o1R/Vn53I0sn7IUQ/1HsHO8JnNbr9uZ5bS+QZCr469zmPdP1u5tVxyomy4+9aUZtu4rNp27zD//gB9Ydhexts6D5drx1yE0aeKqjLdd9NqVyys9iPjQTycrmVccQy3j60vaGHrMVSbwg4oXtvjfyVC6+vOxjb76WqAgv+FYzaoKo86IXnnGtDYw1+GpLVdppKuUwG+ka6ujHTJSxa8uBe+1HQWMqoo/kxXZoq5QJQu8+8hZdOXuWyx5brsS1v2+X3v3pV5Vi5wZ6Au0MIfLFnFd3FhDqlyIt70RlMsvNA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:26:52.0221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793ca7f1-e96f-4016-f1d3-08deb27d3e61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
CPPC autonomous performance selection on all CPUs at system startup.
When autonomous mode is enabled, the hardware automatically adjusts
CPU performance based on workload demands using Energy Performance
Preference (EPP) hints.

When the parameter is set:
- Configure all CPUs for autonomous operation on first init
- Use HW min/max_perf when available; otherwise initialize from caps
- Initialize desired_perf to max_perf as a starting hint
- Hardware controls frequency instead of the OS governor
- EPP behavior depends on parameter value:
  - performance (or 1): override EPP to performance preference (0x0)
  - default_epp (or 2): preserve EPP value programmed by BIOS/firmware

The boot parameter is applied only during first policy initialization.
Skip applying it on CPU hotplug to preserve runtime sysfs configuration.

This patch depends on patch series [1] ("cpufreq: Set policy->min and
max as real QoS constraints") so that the policy->min/max set in
cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
during init.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
[1] https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/
---
 .../admin-guide/kernel-parameters.txt         |  16 +++
 drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++++++-
 2 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0eb64aab3685..7e4b3a8fd76f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1048,6 +1048,22 @@ Kernel parameters
 			policy to use. This governor must be registered in the
 			kernel before the cpufreq driver probes.
 
+	cppc_cpufreq.auto_sel_mode=
+			[CPU_FREQ] Enable ACPI CPPC autonomous performance
+			selection. When enabled, hardware automatically adjusts
+			CPU frequency on all CPUs based on workload demands.
+			In Autonomous mode, Energy Performance Preference (EPP)
+			hints guide hardware toward performance (0x0) or energy
+			efficiency (0xff).
+			Requires ACPI CPPC autonomous selection register
+			support.
+			Accepts:
+			  performance, 1: enable auto_sel + set EPP to
+					  performance (0x0)
+			  default_epp, 2: enable auto_sel, preserve EPP value
+					  programmed by BIOS/firmware
+			Unset: cpufreq governors are used (auto_sel disabled).
+
 	cpu_init_udelay=N
 			[X86,EARLY] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6b54427b52e1..5f4d735e7c7d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,43 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/* Autonomous Selection boot parameter modes */
+enum {
+	AUTO_SEL_PERFORMANCE = 1,
+	AUTO_SEL_DEFAULT_EPP = 2,
+};
+
+static int auto_sel_mode;
+
+static int auto_sel_mode_set(const char *val, const struct kernel_param *kp)
+{
+	if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
+		*(int *)kp->arg = AUTO_SEL_PERFORMANCE;
+	else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "2"))
+		*(int *)kp->arg = AUTO_SEL_DEFAULT_EPP;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp)
+{
+	switch (*(int *)kp->arg) {
+	case AUTO_SEL_PERFORMANCE:
+		return sysfs_emit(buffer, "performance\n");
+	case AUTO_SEL_DEFAULT_EPP:
+		return sysfs_emit(buffer, "default_epp\n");
+	default:
+		return sysfs_emit(buffer, "disabled\n");
+	}
+}
+
+static const struct kernel_param_ops auto_sel_mode_ops = {
+	.set = auto_sel_mode_set,
+	.get = auto_sel_mode_get,
+};
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -715,11 +752,75 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret) {
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
-		goto out;
+	/*
+	 * Enable autonomous mode on first init if boot param is set.
+	 * Check last_governor to detect first init and skip if auto_sel
+	 * is already enabled.
+	 */
+	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
+	    !cpu_data->perf_ctrls.auto_sel) {
+		/* Init min/max_perf from caps if not already set by HW. */
+		if (!cpu_data->perf_ctrls.min_perf)
+			cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
+		if (!cpu_data->perf_ctrls.max_perf)
+			cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
+				caps->highest_perf : caps->nominal_perf;
+
+		/*
+		 * In autonomous mode desired_perf is only a hint; EPP and
+		 * the platform drive actual selection within [min, max].
+		 * Initialize it to max_perf so HW starts at the upper bound.
+		 */
+		cpu_data->perf_ctrls.desired_perf = cpu_data->perf_ctrls.max_perf;
+
+		policy->cur = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.desired_perf);
+
+		/*
+		 * Override EPP only in 'performance' mode; 'default_epp' mode
+		 * preserves the BIOS/firmware programmed EPP value.
+		 * EPP is optional - some platforms may not support it.
+		 */
+		if (auto_sel_mode == AUTO_SEL_PERFORMANCE) {
+			ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
+			if (ret && ret != -EOPNOTSUPP)
+				pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
+			else if (!ret)
+				cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
+		}
+
+		/* Program min/max/desired into CPPC regs (non-fatal on failure). */
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret)
+			pr_warn("set_perf failed CPU%d (%d); using HW values\n",
+				cpu, ret);
+
+		ret = cppc_set_auto_sel(cpu, true);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
+				cpu, ret);
+		else if (!ret)
+			cpu_data->perf_ctrls.auto_sel = true;
+	}
+
+	if (cpu_data->perf_ctrls.auto_sel) {
+		/* Sync policy limits from HW when autonomous mode is active */
+		policy->min = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.min_perf ?:
+					       caps->lowest_nonlinear_perf);
+		policy->max = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.max_perf ?:
+					       (policy->boost_enabled ?
+						caps->highest_perf :
+						caps->nominal_perf));
+	} else {
+		/* Normal mode: governors control frequency */
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+				 caps->highest_perf, cpu, ret);
+			goto out;
+		}
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -1079,10 +1180,21 @@ static int __init cppc_cpufreq_init(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	unsigned int cpu;
+
+	for_each_present_cpu(cpu)
+		cppc_set_auto_sel(cpu, false);
+
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
 }
 
+module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
+MODULE_PARM_DESC(auto_sel_mode,
+		 "Enable CPPC autonomous performance selection at boot: "
+		 "performance or 1 (EPP=performance), "
+		 "default_epp or 2 (preserve BIOS/firmware EPP)");
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
-- 
2.34.1

