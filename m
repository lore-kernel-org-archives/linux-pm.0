Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686B44A3EB;
	Thu,  6 Aug 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047005; cv=fail; b=BJAG/qXhmpEVLfizT9mcqRQIpfklj55QuzrYUBGmkkEwoTfiIlSBbG64XCPq5Q3NoogsjDmTwQWQK7OWKmtHcru1gcUh81sNR5NB8NgCKoP4biMA0WdZX3YVDDuGjzs07GHiAguUF1dtbvF2sWHRk3hXjZtxGOQc3t+AEJfFfJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047005; c=relaxed/simple;
	bh=WK7NYSXQMz8rVQqh6bwcgYpc26R21wUlLk135Jcw1pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoWARLRr8ccAUcdaFgYANaZarZPrl6Cb4ZoIvB/NofyCbEg4cr4E6ZTYvj+uw34A3KpM3HzAq/5WBchfEHtot36L6I5DMIdiXiCaW+wxOgKEaCAE6jEmL15zewdMJVavXxpaJrxlQCZsgcQioP9Jo5HW0R+kJmKipgTNX5vF0Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biCggxld; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biCggxld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fctQPsE3RG3W/KlcZXjNB70WdE8HtcDclC9EgDhjD4AMeYw4VOfKe4gPGyzJU3yUeKTCQVj8tKJu4Vlk4XilLS0p8IZw95yp39mI03Av/v0NC21zqAOTNIokHET8wyG8QI2tzA3ubKGDCbi6jjbssA/8+yS+mOl7ehZGWFaPLojkLBeSPFo+zfmbIRD9My8s1cBvHbIYzqqrSZmgVp85xJGJTQXtTOYoWQuh6sWqAS/ZpZOnOs6AbGsr7r6S9vKV/yOPmZwgFxSvaRdF9ccde3Ru84M/1GdrC0iJg0oqA9ZGrDBdDbvJwIjwlCnyYJAsGiyKkZ8tUivQd6WRm55g8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNJQNI4h3DD/CPGI/xRmJhwHJUak9HXat02SJ5+1H7M=;
 b=sqCCt42rFFlkZIlwoEgzoUXyeqtYdS94YGspoGORvxM+EznRVJ08qei1i8rtFJjlIzjJIW6XDsdXt03YA+yencqGpWrkVWoxA0UX+4pZTwbAU8VVk5Xvk2ufd77TCYxJgOxkQzLUrRA98P3xGFvh2oLM0XdaELu3wi+LtkC1yQRRtljIvv+vU0ooQ6H+CRkDmmNxwBaYX5EjDFoQtEDkdjPdsMGkNL5alU6oOjVi3DnKxE19fbk5+1wn+kFh8UdDZEu6xjVHV7YVjh1hQNXLs7hi2Uch51QPc1rpSgIHUx77IZaDw/XVGfSVk4OwDIH2P2dqQOkMdVddzDVo+5RQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNJQNI4h3DD/CPGI/xRmJhwHJUak9HXat02SJ5+1H7M=;
 b=biCggxldAQVijOBH5p9bhrCo3kFCsFhX5pNZ4qA4xOOLGKINYTo2Wbla+Zrw2t29hQVTIMjCFjXLBSs69CZaM4NmRvWKkOWZIuB3jEoTIXf/8c6pF4XzGhw4XhSJ2z2Mq7vhsSnRF4XzYPkn9U9bg14b9vcxu5gl4jjhZ7ioaoxXtFiXxT2dpn6fKYqWcZDUTPGrdZAHO46m+FB3gv8Zvkg+P0CFjUZqqUoYM9afuFWulfKtMTa/gufVtL+tJwVbXHlVGw6ryDnUHflJd2kjB85vy9XdUdAUbYZN067YbxlIisOIUiMUt+SSJ0dL17JA1xcJ5Pipsu1Gx8FkhUNnmw==
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:09:49 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4e) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 20:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:09:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:27 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Aug 2026 13:09:21 -0700
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
Subject: [PATCH v4 2/4] ACPI: CPPC: Make autonomous selection helpers take a u64
Date: Fri, 7 Aug 2026 01:38:55 +0530
Message-ID: <20260806200857.601152-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CH1PR12MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: 17136604-d8a7-44d6-d9e1-08def3f6ab21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|921020|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	s6vCKeaLvxx+Fm1plr8jYViii1DRI9vNJP3t9J4YM6LiD3sLxGboyj0evUdJHuCpleHrAVRCaOA/NZ2OXpdZEAwWp1eNxFLjsOUbfpuwVKTD9ks8Af+cCtNFYndmehVzCymKngxPKiYy2gPz/T5ydeIv1k6ftlShh7Rg0Ud5rOHieWPPvySAe3gbKQEhzviJiAhkqf1rTJpv4NXYoo/c0XSHJcFPQW2iQOZbkNanCqT40FMRCQsVgBavf0vT6i7aedO5PBrgs6blkDUl3j73hE6nL7C7ohZyrmTi5kdiSuzDKAx3IWXCnluFjwH2VqSW1+3dddtDqejj68kh37sZK/l9tFXxIUpooqlwseR3oAcVQzxltreKTpOnjUxYXnMHJLDZsG3GlB+dSl8BQk20U9NNdoPTbdIF7+ibNNqJ6tgjDyW9kyQddKrufhSaoddhx/UiGXYQ/CtlV30+MePQT5fZLVOmK1QOfqv47pOHMLZa/YfNHtIue8/rKdKts3C9hYoh9hd6FONC15zagstlaaT8/6jgd5DYt3dy8l+5SVbygkEUieLYEt2+sVGrJ/p0T1Aalh9O37KGKJ2EPfr9SpsLMR4spy5sMDv+ntqj2JMSHjUBnnILfKID7lWfgv95o0iZ6/ErS5uyJCdTxxULLXXHl/00M3yQPFS9ks6uLAEwLmgBKR1liZkY2GTV1mWBmfyZ0f+PIlSLEvP2aZ3Lj9qRl1vivT9GkRLtlj2xV1VN4fwaIUQSB0/eNjK1CgkS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZBPgEwYhjhipNa/OoFHzUka6DZVUZrNbkcloE1M0mKOS3A3DababwJhh7OMTtWcUWZA5UC69kERPQctkBTUW28E7GRVfHsy3OvZyQbbV5cohpSCEMpadwFVITWg+AOQnomGIgHC9k7/CgydIMdZVSP44QjXcgLU2lL8wVXUtgt6wsGKia+5YJSOqIi1O2z1V3eQAUJZaYRGAFDV/vyGC/m0tmhacgnfIxdmc/xAw5JfsfqTMvdCfhsG3taughK88hLmgJrHmEptDlh+BgGQmt92dv8Wqrq2onI4qN3ycY0+WAiO93CacLbYUcaMtMSfl/fSno7sp93rE19BxtEc6HfJXzTbk83FqFgvysuNQIBG/ai/dkLEGHB5g6nnuhvFGcM6YMxcy8A/LSEOh9rJwUhkHk4rEeQHB/vW1nd1+CH0XOvJw/VONYDA1UXb7kqp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:09:49.1421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17136604-d8a7-44d6-d9e1-08def3f6ab21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695

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
index d4ff8b228f86..de0b29bfad61 100644
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
index 4b3da9a3e122..b50d3f893b1d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -990,7 +990,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 {
-	bool val;
+	u64 val;
 	int ret;
 
 	ret = cppc_get_auto_sel(policy->cpu, &val);
@@ -1002,7 +1002,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
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

