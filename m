Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E10501F39;
	Wed, 16 Sep 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555169; cv=fail; b=Nv/Yn9SVKXqNrs65wogpiQnHnNm4hB4ebSuGe1uztKyBrLNGsK2yOPbifMSfim2ULMuVCOb1JqnbFA65LrAbpGLrMgRzLo11qR2Qcknvks7SOyStkq7VkgyE0Kwfu0sSBhXVsv4EPOn/oFM1x4BfbbOMee9I19Ab00ACBYDSZnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555169; c=relaxed/simple;
	bh=b4Iyz6TcpExBktTMo7utxus7AY610Wq4N2USllXC1mA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YusJL39tod/j8YbMBvGLrsmXwfIgNPFYrk8FCEepor1sGMGtkfRWvasHctOji7STq6TmZaTbEwmyIHaHmSOCu/VLXhykJeQMGAtTPtTqpSDcXYvLK8LuV7mLp/o9gR/4USXBARzngCSaEus+sDVoj7c0/9yqgqW/m093Qdd74DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=REPsg6kj; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="REPsg6kj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQBcDwthThPuP3i+32j8ay/VuHj3gSTe0DwOON6BOa04ifxh2KiNJtCFcFYQjlMzmKIxgmOki01C2oHUoLbVZv+21Tb+ACEuvkYy4YEYMA4Z3m5P61F7UhZP0umPLC5XYoR4fs4r5VLHe2Tq2anAGkJjH2ZuA+KCPL7GVn3tOPqiZ3V8rLm45/IKIunz2fvD9pSu7jA7gcYqnOcuSfXH8UlGEYPWrUBdcQWTH+MJ6s/r74ylj/owtOJZv7IwWjCWbcHzJSaqrq6UGh4+lQtbHjW66F3dLB/dOkcIGcuHnMpwDbN3xbtVvs6bFSZlO5hx7/epwbIH/0F2jcxv7Ea2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSjJorp+NJxn+KUpZW10oyvcxrOcq69++07oUBicI+8=;
 b=kv9GpuPBBqe1SHDh8Rn0OcL+70OkB43mSnjQa77jO5zPSppCBj+DLxK+y977w4hyGAtvHCF0KAyy3maIK/rgHvjp0k3O17EoFqhApHb8ACZ+4q6sEzDPFv+TH8TtNlacGDDcmw7zlv46LaOlHr7SDNWfX93TJgBZkXbNUk5vFi+epDxhzYeIduUhEnAY8q2qfW2N+65XLrU8OzK3h1VFVqPbUMTfJJS4LoDBKVw78In/xfdcvH/oR/mHg+E8MZXIBVZvX1HapaAiB1w5h3dwU8SMk6GzYw6q+gHdzYT8Me16Au8hP4ve7Y/ljvjWF7ck4vN+pa4iuuswm01AfrKheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSjJorp+NJxn+KUpZW10oyvcxrOcq69++07oUBicI+8=;
 b=REPsg6kjGFdZGZD9CoZeK24gn7IDqODsr0aDkLC/bOvCzA+5vQ76EWWjlCyMpLoC5wQiX0JXdJ1EJg7ADhR8dEzsIQkzSVIFj/guvSTdwe/u9s0mcJIzB5hwnwEgLwtkmvrPwRwFI+Lf6vtwEgcKSpG7qNqYFJBK13yWiKgarPoD9CSQUauUdlQ7O6UnSkZVLJh9H/cjVDrEhBC3cBf7MIuyZMQtELgPybsKAw1ECpYMoWLcN8TYwND7VQR1U1xTMZpzvcmt2U83iDfJ7DiX7uLbSbQDCkfc9kcDbHi0I4R+ydp8z3dUH+cNm+h7vkCvHx2A6cupbNiqtdAQGZ8dsQ==
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 10:39:07 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a8) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 10:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:39:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:38:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 16 Sep
 2026 03:38:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 16 Sep 2026 03:38:42 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5 2/4] ACPI: CPPC: Make autonomous selection helpers take a u64
Date: Wed, 16 Sep 2026 16:08:18 +0530
Message-ID: <20260916103820.1760297-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916103820.1760297-1-sumitg@nvidia.com>
References: <20260916103820.1760297-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 648bd8cd-2abe-448c-c336-08df13debc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	1uukuzgAQTZVaGp6xec456zVt4wmNDcsizXHzqJFhvkSzLm7w9riyoe3NmhC75azkeQk5PQKK5Ju/EdAaDpHFZqOHWmkvLxiXOGlrL4QUqwlRIiwTrlyV/BFSWP1xtqEhu4P8enNaZZYr9TOsBZ6RZusQEY/+l69BA5wPShkxDm9dx9j2BDV0md6x8t5H4Zaf4avuH6Jedu3K6hiv37F+JiYSs6PGNJU4pXIUsfqwvwoSc36n+Z6p97IyHUzd0qwrfqjtBg2vR0FKKSZf9dYbF6Ig+LOdwWX5UaF2awTJ92pYG0UC1uO511u/CCuSYPy4yL2MUWxfXcn+DgLFmIjUTEHLU7zk9JK4nK62w95Z2oM8j0tUAJ/cS7JNieFnkId2K+Xfn8HcqSdOhj0anh7jbisJAx2JBmDDSJWc8xUcv4rVeEdbm/JojuVw/0A4hygvp7r+jnZMfTxNaCCDHbPi5LS3rXZAFu+gJhCiLJNS9EBhfcg2EBgfDuI29p6eF5KF2u7stAkee3ydh9VO2P01DSffIBUzi0diriQ9AuPhsTS1bTXiJpkGFbUNosSlHlulIbfAgVQkeAEuyEBb42YEX5xE8SGkXXamz0OyKjt3tSih4ylpyoarE02FRAd3HvY/mQ+yKcLsEC5WWUuUSZXivkVMmRf+wswOEaqBV8Ykt6muSZ8vJekrffZYhKuUsPX8EU4sxDcg7U7pd8pyKQWdmsuIDKFwLfBDz1GIxW/nNgQVbc2iWPxeWXSe25KpLF1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mAXJ+sU83234iD5+2Wzu4qsiV0ELFfffw5mjvgNUE2inUdMLURGSXjehhtn50Mt5U6PoKCFxjE/mPA/Lmuj2CV8ibIQ81EaTo7VUAtDrXDi/N19ga+KH/gFbqcDBlIdOfkUPxYnC8wx/F7ZL17T8bs4ocIkOxXJ9PYY1pJD2Vu0+xqwC8JdI/xC3plZuYNk87gtXubiAxJ9BwUkg6rK8KGHRsNPPIDEt4nN8u+GV50ZUWy4nHrcT/Qiec2GEjRRDN+1qC9dQ7j8rRDfeEkXYU0rew5X/QPKXh5hBk9Ko0cuEskvuHFLazt3/nivtZQPM0xmTGXq4XcqYiT2s8MUVvqIH3mgG9vBseLMQQOJ9lVcgV/sSqMc9At7UceZ3hbbdsoGa87QUFptb5TUkUxKr3NcKHYsENLiYcsRnl5JqD8mEqFDrzpf1lWdvqXZkNDQ8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:39:07.6500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648bd8cd-2abe-448c-c336-08df13debc9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
CPPC register get/set helpers which use a u64.

The next patch in this series saves and restores the OSPM-set registers
across CPU hotplug and driver unload through a common table of register
get/set helpers that all take a u64. The bool autonomous selection
helpers cannot be added to that table.

Change cppc_get_auto_sel()/cppc_set_auto_sel() to take a u64 so the
autonomous selection register fits alongside the others, and update
their callers.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 20 ++++----------------
 drivers/cpufreq/amd-pstate.c   |  2 +-
 drivers/cpufreq/cppc_cpufreq.c |  4 ++--
 include/acpi/cppc_acpi.h       |  8 ++++----
 4 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b7..9e882b3911e6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1904,23 +1904,11 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
 /**
  * cppc_get_auto_sel() - Read autonomous selection register.
  * @cpu: CPU from which to read register.
- * @enable: Return address.
+ * @enable: Return address, set to 0 or 1.
  */
-int cppc_get_auto_sel(int cpu, bool *enable)
+int cppc_get_auto_sel(int cpu, u64 *enable)
 {
-	u64 auto_sel;
-	int ret;
-
-	if (enable == NULL)
-		return -EINVAL;
-
-	ret = cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &auto_sel);
-	if (ret)
-		return ret;
-
-	*enable = (bool)auto_sel;
-
-	return 0;
+	return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
 
@@ -1929,7 +1917,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
  * @cpu    : CPU to which to write register.
  * @enable : the desired value of autonomous selection resiter to be updated.
  */
-int cppc_set_auto_sel(int cpu, bool enable)
+int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return cppc_set_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8bfd46d60843..20b9e216670c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -499,7 +499,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
-	bool auto_sel;
+	u64 auto_sel;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 37ead7f6c179..d7d96fe0da1b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -984,7 +984,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 {
-	bool val;
+	u64 val;
 	int ret;
 
 	ret = cppc_get_auto_sel(policy->cpu, &val);
@@ -996,7 +996,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 94a6277edab2..3394e1b208be 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -187,8 +187,8 @@ extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
 extern int cppc_set_epp(int cpu, u64 epp_val);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
-extern int cppc_get_auto_sel(int cpu, bool *enable);
-extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_auto_sel(int cpu, u64 *enable);
+extern int cppc_set_auto_sel(int cpu, u64 enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
@@ -285,11 +285,11 @@ static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_get_auto_sel(int cpu, bool *enable)
+static inline int cppc_get_auto_sel(int cpu, u64 *enable)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_set_auto_sel(int cpu, bool enable)
+static inline int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.34.1

