Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498786;
	b=CigcnYkF94kdDE6tkhPWfm4uQ8yIMrvp6kjK6bdGSptlMV4e9mg+85iODqBgpdGbS1NZ
	 FLidDbv+AYOdmDK5J/nEq0cRU0iQKzoWoU2eYApKR0oENiGBVn/JJ9K0WAKlJUBnF4w0f
	 6PXiImeK9aaIhSVM4mmzlrLMA8EEAyuluertjyOKPcJDKg55PXnNWT1IS68lFRl+hc86K
	 FTuzEn/NXM4m1+cB2R9fqK+cgZ8W7vTQ1J7KgRPaJYvGFIMdJ/brScMB4KrCucSNgJOqE
	 XdepxDu+xWAPyCwqpL4dZvuQJc9bvU7e3VQVO3lb1Po39h1zk2xZVnI9HLBpRnpXWSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498786;
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
	bh=okqriUrzmHgBcVD4LMB3EqMSheLH5sLHWyLsIdir5bM=;
	b=bNmC9PPEcbu1AmybghQ/MudK39vNslxNhMBbku6DLo9iuQ3Q/37v+7FAH9usnqgu0NNK
	 pfNe+LDrJSce/RzEW0ZKeFNBnUj5GTV7MZIhbmN6DRp40xcAc3SKmEyAqS2flQrdTn/o7
	 ZuNZhauDhpszhlyOCIJmUVAqnXkfi3VFwX69NpXSbdia83sfRJv+LDhHt7WVNmja+rJum
	 36lZPT7njrHhy6EOISCNiKXCspFo95SUZqehVzjrypAT9YQLheyJu9nQltzMwz2yPDTD+
	 1b7X5eRWhDfZ2xM0U5nxDw+QNu9QACRAh8Pxn09jjCQXGov9HkYPaXeSEadShBBUDMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kUkjPPHc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3F606A323;
	Tue, 20 Oct 2026 12:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA3F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kUkjPPHc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVkkDI9WiGWorihL57Mu1LLr6iOCtPFiqHygh3ti7P3y5xtaN73CrmkNIWbJmI1jb9Plal8rZOdhLEdJhmvZqLO+xwra3l2tyvHUN0ACTSPF0tscSLtINibRtmW31I9XC7ffIOoU9nHFRtBP+SSjv8G+uLZYf9PrE+Bd3JzaQb9nxol74EjYwQJZdDgRblZwvLnh/GUMRMMjbO+NQWln27q9LCx9WGDxhExwqxx/m/j7DpCHJz3T22jMXelAWUDEGLPjrvOB6NgTMZwETiGGaauiI/1Z5jgr3tJhBugmT8Z60xjuNov6Iv0/O6J/Emnni3/WGBFbPBSDWlloNGzElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okqriUrzmHgBcVD4LMB3EqMSheLH5sLHWyLsIdir5bM=;
 b=eJEfdU1CT4XDMcGsUv9rHGUL5R1uLj/10fDCelul12tzT+zC19y63fZEtNInL3nlguOqSJxPmes2eyDvkLZxYphxLs2V+h8vsrC6QNMpP/AaN8nd0vNY4EVmfLu3KI8k09mj/Qg+FCe2J7dPygEzGjvILRl6vuA52v2oYILpDDbT2AfhYdUq+U3TMuZtZ/0PQ+hRwtDWta03PAxtmyaDNg5zG4OhvlP3s6qeomOZQFuUzsC9GzehEMpxJioHNxMG8Xd6EAC26S9UypIdCJHu5aV3V8Uldopn7M7YdiYvrTFJtFMrel45Myb8uK+dblJPKR1StCwDAvXf3rouwGz/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okqriUrzmHgBcVD4LMB3EqMSheLH5sLHWyLsIdir5bM=;
 b=kUkjPPHcjutC8K8S6Y9HleC2YNrjrTUQhFq6NnmF9MRy81+p7i9ZN//y0e2jqBNPMFcpDU8RGQ7s48QUgquPlQsd2AcR0jANkXxkSvLqPK4KuY55n2Kkef46+OJ1TVqho3jsLp6BYlxogqs0gdCLTGomW4mHllRCh3xWx8wKj3G5bA5DT84RUmbXveBdcJAXqkEiseNU3bKQDivi85IUXK/lDWr/UHTdkztcNlIiC6w4q6Lr1c/bIITRUjqRdVgvxfbVo1O5hUMxqBIFymABP5JrjfLHb7l+XpSViBxm+IAt1g/rb06gMrpmkU9iBlKemwcg/OAx4XUtzxzMmVZu9g==
Received: from BN0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:e7::16)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:19:41 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::81) by BN0PR03CA0041.outlook.office365.com
 (2603:10b6:408:e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 12:19:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 12:19:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:19:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 05:19:25 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 05:19:18 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 3/5] ACPI: CPPC: Make autonomous selection helpers take a u64
Date: Tue, 20 Oct 2026 17:48:44 +0530
Message-ID: <20261020121846.691218-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020121846.691218-1-sumitg@nvidia.com>
References: <20261020121846.691218-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab4ab16-25ec-4598-07e1-08df2ea46ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	a9m3OXhRo0O8A1aLewtcL/GgPOU82CfcvkBmcMq6hpI5Ra0kAbhX0LGo5XQLwQ2bRlh3TihsDDMAx1Gn8rDuTW8ZaCAatlPtjdWRfoj9gPxaFVlSd5Hb7n7JTqOS8wUxwRMhepx+ubXKzJ0tzxDSQl4zaSTjXyafc9Jd7Q2CQFVjlNpdvmnBjE87RLUYsK3d5i2dSq4hwOHWIIqnhIDgB675ygoHWe+aZ2WqPOa0QfmD1mUSN0AgOPu4sVcDHjYfqNRX9bsjNZXYtXAVEKJzFtTb4Qn17jI4aEWIXBXXesZ/tQxn/7Z5L245LteBBmRRgmegzWC0eygth4XulgkH6+zqezNkbdhjXLxEwn8x8VaTq1L/PlO9udRnEfqccj6Pbt42JOH4HGhKXQmMnebhbKNNDwtpcujPenxGUKgNcU2cXNth2ClRkbedXns/d/Cq8puTMB/ED5zIONKXgspw275fsr5iSOVV2Zt+BmWHoHc5oErYqG/vhiLOu56H0WcMi4aK0u5AGvq6S8VWKPDaBYvw78vCrpoH0p/Xz2piW1SIx1ZnmDUi1tFQa9tR7Bdr0oB0ZlS3U+1tlCC5n+Qzal2/lnwDWkdEykkfDFzMr8V6rw9sfN1Tof5OTfgA5TdhV71WJtT7ueV9ysEaSCLcDODtQqtAzuyvpKQi/Ztq1GYaqRYe8NtEeI3y5JjFMF2ObsUysNEen0E4F9i7BpZYhfVRsSNsrmesR/mzqIkUTO/klduwS0sjmlpyK+0+L7o/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GE0BD9fghdSL4jZE6Mucd87eqVAF+/gcWoipnu4IL3UKlg5IMzyJMUg8f+3eLQy+IndbX1pCOLBB1BNJm4HoydFm/8QdU/IsBVT+EdiV2SwK6E01vvlNKHagGuFzYRsuY5ZiEAJBYELTeyIeSLAzuEHtOlRqz90vC301KDAdq7jrBbGXeGgBtiZCxhP5pSn1ARgYcHgS/Hrl5riZZ4utdOQ96ECorq2lgyTB8/sLlZoTH0Htf8pKKt9lT7DmEiuhk3nUfpm+Gh029oacv2DCZI13KHDpw+1iHI52FfQ52EQOTKt39svIpxj5aH5xQkGW3lhuuDp20WEIL1L301iBNbvaoP7LAeEyCZ4eb6hNlQ3iFH3s3cbOYhK1Qix2ZB0+euP7H6B3qtYJNm+X8iixzQExo6pGwcB7t3X8JUrLmx4gh5NMA4PufkabvkZkZJei
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:19:40.8804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab4ab16-25ec-4598-07e1-08df2ea46ac5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423

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
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/acpi/cppc_acpi.c       | 20 ++++----------------
 drivers/cpufreq/amd-pstate.c   |  2 +-
 drivers/cpufreq/cppc_cpufreq.c |  4 ++--
 include/acpi/cppc_acpi.h       |  8 ++++----
 4 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8d38924e0750..11a895fa9199 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -3304,23 +3304,11 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
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
 
@@ -3351,7 +3339,7 @@ EXPORT_SYMBOL_GPL(cppc_auto_sel_is_immutable);
  * @cpu    : CPU to which to write register.
  * @enable : the desired value of autonomous selection resiter to be updated.
  */
-int cppc_set_auto_sel(int cpu, bool enable)
+int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return cppc_set_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b6..bf7d25e89d2a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -546,7 +546,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
-	bool auto_sel;
+	u64 auto_sel;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7448ca43b363..9e1214e1cb0d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1059,7 +1059,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 {
-	bool val;
+	u64 val;
 	int ret;
 
 	ret = cppc_get_auto_sel(policy->cpu, &val);
@@ -1071,7 +1071,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4495ee4ab71e..a5545fd3f8bd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -197,9 +197,9 @@ extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
 extern int cppc_set_epp(int cpu, u64 epp_val);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
-extern int cppc_get_auto_sel(int cpu, bool *enable);
+extern int cppc_get_auto_sel(int cpu, u64 *enable);
 bool cppc_auto_sel_is_immutable(int cpu);
-extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_set_auto_sel(int cpu, u64 enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
@@ -298,7 +298,7 @@ static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_get_auto_sel(int cpu, bool *enable)
+static inline int cppc_get_auto_sel(int cpu, u64 *enable)
 {
 	return -EOPNOTSUPP;
 }
@@ -308,7 +308,7 @@ static inline bool cppc_auto_sel_is_immutable(int cpu)
 	return false;
 }
 
-static inline int cppc_set_auto_sel(int cpu, bool enable)
+static inline int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.34.1

