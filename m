Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0134750F;
	Fri, 24 Jul 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930447; cv=fail; b=fA3GVApPn74yhZ0QNL7pgqYmHWxu9VcX3ET2nQrSYYjFZPZwxd3r/rpJFNjx4yFgZDQDnmK1R29+2FXgNWT8C/4LP4doG60T7YlPy81Ip15bNecd9tZhZWKFJ7Iuuo2/gVU1SClUeZdVQ0aEfj3Vdf+owTPlWJbzK8ZS1b53G9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930447; c=relaxed/simple;
	bh=S12NAMHmT/hGkfAjfB6jWGMqN75DSdnYQSBp1TsAmVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbFltuhtnVD9TIs32m0IB13o3mgI2Rzl6uQoop4Rb8Cm6LxCA1ljnfEwU89+5zb0dOd4mPkbzFEpKmgELkuttoeww5IknGrlJEBQOqYKE02/KlG/LKSVdfCfoujL/GxHfjjr0Vq5YYl3+fzfllQAJ3LUZwTTP3IoXLRz+GHVTU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HSBAz3Ht; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HSBAz3Ht"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdvNmxIDFd0tEhfSZCjolIRmpOzmqwKnDHdUWO95vGmD5IC9tN5L5S2nnunF/5TgPlQYg48WgEBpRS/7V+x+Ac3FooNU/YKQfMrL6O+Ids+/vdDL5l+dDeKW0QHokqSzIcpVz8dsdECZArbe1/mRxEsCGFrv2q6XjYgrMik6zvZ+z/b8fQ6n8V57KtYCLcjQ2qaCWf7O4t4eCMZ1eCHM1VIeunRBqaEAo7LInopV6k9I039RHpLFCt58hGnqEklq8mDaA0UrXw0qXOKsBjM3vA0q8EQ5UihXumJSfwAuoN2ZntY4ppBT6Hkw1Z/YwezQddqDyJcN8Vcy4U07vTQiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FIlZFgFN0UwmQj6n+yCYVjvkJeTLXkyTrOpTGaA4/Y=;
 b=UKg5GED7yiN9Z4pQl4iA8dDetXJXqObLW6DuncKS7kK6faY1mPbWP4TqkgnyEGX6AYcjvFAKtEpN1mWeGxJxt+aTZcExhXWQAgEtyzzOM88H098cpJWW1UTas67D9YpcenRMEsgCoYYhFUmFSUY83AI6va4YbeV8jIaUE+LNU+v6t1DH9wLfkrTR4Bir65iO5N8vQla43bAei0y2jzDQxvII96ZUs0yHHqv48nhL0AxwL2seBZ5yF6Gh9BFgP2yIZXgB/iY2YS71Ud2Q76rQfBnJl3xh+g2qkuiognC0jr0S60BfXa9ygp2snYFyw9a829GNL2JzuXLTerEKNnLV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FIlZFgFN0UwmQj6n+yCYVjvkJeTLXkyTrOpTGaA4/Y=;
 b=HSBAz3Htb79b/Ne5iGT4tnKUYvVrH6zw1t2tlmhUsF+I6Ed7tz0Qz4x6ScCGiLOLUlLQu9pACUPzKG3HGiuOduQ/Pde72270WDNR4OJqT5KjWfC3bhQJLHOMgiEUhAxQqoB0tAuI4YKXrRVU/eAlz/P/iFys6qJh/2xx+6Fo3H870Ii+R3e2SH5lzl76c5RpdKSR/xQDR0wKKbancGMMP2cFEKaE2JvHokVL+qeq80X4T2RR2/QogWCIieedOevguMCkqHQZjh8aalxMT0aQ+hIeyh9y4GN11qH/ZmLoEjTaI/QFrCZTrAizRsoADvCnF3w4r3aHKz5ZXmSPEQneRA==
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 22:00:37 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::3) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Fri, 24
 Jul 2026 22:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 22:00:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 15:00:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 15:00:14 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 15:00:08 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 2/4] ACPI: CPPC: Make autonomous selection helpers take a u64
Date: Sat, 25 Jul 2026 03:29:35 +0530
Message-ID: <20260724215937.3368276-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724215937.3368276-1-sumitg@nvidia.com>
References: <20260724215937.3368276-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1e0a9a-073d-44fa-4038-08dee9cefe43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|921020|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YZkXN9gZM1NU3Km6uzGLPOvtWJTVvSnhVnk+N6dFh2Z7gUWuFHTsBc2iOAD7EGLHTnSZ4aUn/12IXh6rfQkd51zzHezpM+8MeiiMhN7y8T92SgRsU0tMsZ2Z32C8q9yd1me5zRkZKSVdJ6Cgfmk4W23B+TX0HlnjkcUFh+2ggIOAnkpcK2zsCYq7clfb4/EdiHoDbUKCLoRlqgslLvQRjBDsl/2y4gUVlzueokRjkYPK7NyDdk11QuK3T9OcIatD4BGdqbvj47ll0NUy5evVs7WwuuOt+2VK3YhXYPwmyPvkV3y/Ig9cxwfRf/zkYUIhz/4DKiKZCPf6M9UpEYA7LcJ8+PdtKhiPijm7Z/K8IsSiKzV0JO0CIiRR4G+UqzhfoODDblYfBynXR5BsQqUxEhnNxGBH8RuduqPt4caGRmyH2oBUKHVl3XUNtgH7gTyT9GtwhcMfcjRLng4u6vaJzuFRywrqYTnb3PyTKZfkwZK2TrFKBDFy1mgS9i1BHonaRuR2hHYMARPFwfnU0UbosAqTO47egeda8GKCD6eZWRHvEr+cFenngZNdPAUot9J5V/pA3baqjfzXWshIHL21KG0XqAS5+5CTGlWzr19Ru/H4kD009+SJzFFuWxWHBPxG5tXCXZ9EjSthWKWs+xk6JJPY96IG+55f5kv41e1FYcDIYVgUhHDTa+LxMlnn24IkF4ljEbrLgrPTW+gwJC3E2+pYz2eE8WZOYJRcWoDR8SJvvi9CnriGVxfIlVMHSc4r
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(921020)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EpXXMGLzsM9qoiz27IafZRnQRuOsuhnbi78nvwxMaXksori/FoDUQZrLZxWAIQoItNYmpDRfyecjqakI3GYdvvmEgIYx4CZx4Tpud4OoHs9r18AuKSKo5JtJ9GPIGX7Y7r0s2BKCJAWyzmzXUuRXwjxtSjYKuCRgx7zf82LATFw/oLGcE6pHUGPGRsrhCCIGXanOENKjRGhRWJYkUbgzQjSFtVWwQU4F9j8IkDGoY+tXuGXe8789xmaZhuXvOauFQVPRcp4+sVqYdZUcH2JgiQhutUk2+dJb4DbvD78ylD+QCZ03PqueRU9x7EGt1H4B1wYkQ13A+etdepc4BzyfH8RiqYwlImgqSii9OfDqjSxVrs7YZemrQvXAI0vEpLfCKcifTCcmkFf6ABeFJl9ewm9U1AWdBd47yVSnBtmPdp0ZAyk9dyFo84umokQR8jHW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:00:36.9657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1e0a9a-073d-44fa-4038-08dee9cefe43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623

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
index 9f572f481241..ffadd2ca26b1 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1757,23 +1757,11 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
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
 
@@ -1782,7 +1770,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
  * @cpu    : CPU to which to write register.
  * @enable : the desired value of autonomous selection resiter to be updated.
  */
-int cppc_set_auto_sel(int cpu, bool enable)
+int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return cppc_set_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f8d8288d644f..0f99bb86c3a3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -507,7 +507,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
-	bool auto_sel;
+	u64 auto_sel;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6dc59f99d880..34cdba00e61a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -893,7 +893,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 {
-	bool val;
+	u64 val;
 	int ret;
 
 	ret = cppc_get_auto_sel(policy->cpu, &val);
@@ -905,7 +905,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..f4da73876287 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -182,8 +182,8 @@ extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
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
@@ -274,11 +274,11 @@ static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
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

