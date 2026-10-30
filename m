Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352313;
	b=pNAjLl7I3ETrRBfU/op3u0/h09/ovnjGnUdLMnhYHJQ7mrSbzSyR2PLdMd5sK0/UKnf2
	 dcLaQU+tmzU2WCaU5raRGab65HU+IrTyV7VTsGQ8DSVcCUH7gwOQluh3sFK1zf28QlLhM
	 0RG9A86vWVWeNxMedM7++RLDfRYf/V8jDtI6LEJFNnPh3/gi8PjScqVM5vIaQ2/67cQkV
	 xrBtNnhl2lOq/mLzHkLW6CdaJQykR5/xee+sGGVEvEeQEG+dlqkEVyQinMPJGpA8macS+
	 60xCQA91/Oa649NlMZ5fIEl9UTPoqK8iaCJ6+F38HPlqV42xI56Q3KjxDkHhKDFw4lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352313;
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
	bh=DzV7YV6KqVeBXddI8aiAAnuVSqmBpyl2bBIm4q+xu0E=;
	b=EXmQYfJcWfpv3s4e+JV5CG/S+NuWX+ywVdu4WJjCHO7Mw6106HSXFXWGnKiJtR3T12da
	 IS6jaozjGk6mMAY7WS4AEiVDCBmSA1Lywnqa+zEsIan1ri9yqnCf8JxDi7PmC16Bep5v/
	 cdTTiVXwVUan/VQt1FlKzADdWn4zHfB2rlwy35V+ospTZnlkucUTHil72N/YmLmQGCJAz
	 zK6zO+hu2mXV2L/5ioriHVeIRFhXF0TDSSKBS3gyjZMbh4QdQN1PvoAK29y1k+4zMhgYn
	 4qhF8yWH4y0fC0Av2vvhxzgocBEBxSdOBEdqz6iB4lT/XK4kg5qNd2wk0HNiTWJJA3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uM0PjAre;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.22
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBE606A326;
	Fri, 30 Oct 2026 09:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FBE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uM0PjAre
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXbo4HFhY+GM/f4lvBjh0Xes37EomLAIwYroIWcCSlOwL+ybKqjh9W3DzDROj7HYJb24gtzQ4c8zrcZ+NtESLL9DsPcT/2pUSif3ZvY1XfsgZ6C4AcYs9feJlVXsfAQo6FCmPnM/EQZ1bCmO5cprJZTYi3Rf1Pe9UBxLZctccGg4MkcQzCOJRo6riXZJLo8cdQhjzBJEE7uSY7uPPfkVgdFLUyfTrKoH40sex9Jbyb50YDhVfZWvXpQOe1b9njKRcyyEIW5vqcuiRvPzVB0vluNboTnA4X3qqQDSI8mg3K2DjQAGuZIWSlItbpdUzefJvEj+uxi8j9hQtgvBBe70Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzV7YV6KqVeBXddI8aiAAnuVSqmBpyl2bBIm4q+xu0E=;
 b=zQTsMQ2Sv9tUI8ae+rYZ1gtoHWY+Uvi+JLs982NRuqkjeC2RJugjWRH6MOHv6m4EFkY5/QfEPR7RrrGcQTELrlIFjTSm1aHMohCkkCjFTe6f4adZgFRFyaLFVBwUhZBXU5MqXaqrQIcAgGb8iMwXLu2xMGb1yXwfs5rDZ4azuytWvAXCrEc73kvO7Kcl2Ou/1cnlm/onAwrvix8iOOt+Lib5NxeHFP5gn/0i6rl/gRrfW7Omymi1cHT6fwGCwm9u72UMrOvy9wu5uIgVOqTLGVNFB9O/xVoWcL9Xz9NCe5cuCpGRQKijEzW8QyuJZ4z/FWnpRqS5jm6lE+Qt9uUlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzV7YV6KqVeBXddI8aiAAnuVSqmBpyl2bBIm4q+xu0E=;
 b=uM0PjAreX3r4JSbZ9N10eH0l4KOskPCNX/bSG7r693qzGKNXlEEVIoxvch1vJrfqgqmh0GvDRj1i4CKJ3nxBUoB3ZFs/eL/3wcFzIe4ZUg9bE6LFtNPgmOgGgiizlGdbtqkjp/w028dEtejrLwVUoF9wj6ZNfwFu9lLSwVVruAQe4HtrUZcBtcj3D/WNGMJlU93IRV8JTkmIXN1zMuLhDhRWVdhPZcLRu2rUzRfE//57Gxue98gm2zSbeSVIsLTtBPj2/QnboHKZm/RO+DSLNYEmfCMz/12bTy0fPvUPGBV5aIo3Z2LYZb6QDCByRg9XNJSVp90P39yZp5J9lJYa9Q==
Received: from BN1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:408:e2::9)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:25:08 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::a5) by BN1PR13CA0004.outlook.office365.com
 (2603:10b6:408:e2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 09:25:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:25:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:24:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:24:50 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 02:24:44 -0700
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
Subject: [PATCH v7 3/5] ACPI: CPPC: Make autonomous selection helpers take a u64
Date: Fri, 30 Oct 2026 14:54:14 +0530
Message-ID: <20261030092416.1993889-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030092416.1993889-1-sumitg@nvidia.com>
References: <20261030092416.1993889-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c21319-8882-4245-f613-08df3667b04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|921020|11063799006|56012099006|261009221227099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261022113327099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QP//fqdshP1gyNXYnd+4YKVENBiF3LDLMU8bOsjWyERE2MCLnLEHbidMmD69tBl6Z/n+ojYsEV4RUyM8w3QTGx/IAbvr5vMSoSFpdeyYcjvNZ6AtzTqjlUaFXTmXMkZdJuyvXyrIl3QTEXkZMB7aodkRxLO6pqdEjamYblGsvkIgk2paSEKodbna3ItemfTfNxk2VQ/eyF95F2Yu3QiYc5Pxi184OwTQwW7boHLFSN8ZNBKEx3/AEA/UNEUmsSYdL/T6d/5O6IL1qiy3uFv3vJ+lmX8YENZ1AfC2u2C2kp1KpQFukujhxHIoc5+32yOUww7a+xYuemlv5JKQ4Gu/4kQte2Zlpt5lDUhjS7z7nYN1/9P6B130RP6oDc3NIvuT+Ku6fHDoTEbP9+j28+67jXzCGuYs7d830OBCgVlSkZ5AH73qoMute+RrZP9RRez2sAgUNLFXb1T1MbnJmVL6oAotAsNI5d8JVFrG+u33vsqGUFOZXIY6ldzzwElZKEr0AQEsg+DIlLEKiFPY44j6M0HazAoLjNDvvmVpoO5N1KCO8UK9Ibmtv8bEjI4730i1wt0mq3DHvl/rtWyr0soDmQ4TmpTU1MpWBoNmV5yb+mUaTBlkkX9qjVrbDuPYGEGRh1Q2WbCsJTaTYnF/ZiLam1Uw17m/p6Df2JQvpaHY30ekg+OLphbSaVvCX1onFrNkjiyDNy9VP6/fkMXkTFCBgbZauWCOVDkH/IR4lrst6VHBacIX+hmhy8dAutkvyr+8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SGryuOLoN1yUdW3pVTkusmdy9PCD/GTK8h0hFSdnejcHkPYRTNb43CoEvEqorh9Y24fxer7qeNlWmmmFIHIyZKpxgloIr+VDqozTBo0rSPn+QnZPVToEpYuz5HSYjEpy7hiKgsDfWLOTnyFxibULmn913jQtOdJca7LwS2tGKfW6QDsdkoLgVhEHyjQ5BBGH0kR1yiK4qjurO3ENDRtKNRazaw9lWUxpyA1smzEKbOa19LCo+eiG+t9Ss8rJveH7V2gsFmCyYVvzKXPVnpm5IQ1+Fjkw60W8l31oxNQMOocuW4dp2XcjarsntYWiW95Pn5/dZRcvD3CoheUtstplgs+/gN4y5Lz2TAhpA4Ykt5847AgrpI080Ul0CBsru3fZh7qB8GMZ9AUPnTdCy2WidNMbU59E1gzwxcvCA6M9+DWO+VXTjPWlWFYIAzv2kiuH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:25:07.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c21319-8882-4245-f613-08df3667b04a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

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
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 20 ++++----------------
 drivers/cpufreq/amd-pstate.c   |  2 +-
 drivers/cpufreq/cppc_cpufreq.c |  4 ++--
 include/acpi/cppc_acpi.h       |  8 ++++----
 4 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f49c6152a013..5a1f84fddb7f 100644
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
index 2cf250b38633..3f7d740e04af 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1033,7 +1033,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 {
-	bool val;
+	u64 val;
 	int ret;
 
 	ret = cppc_get_auto_sel(policy->cpu, &val);
@@ -1045,7 +1045,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
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

