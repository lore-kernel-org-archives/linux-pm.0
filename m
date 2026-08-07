Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63F3546CF;
	Fri,  7 Aug 2026 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139396; cv=fail; b=aBhSQ0AsDPZ2JNj8pHnIp4Br/Tezu/Q0fSXAxdPbwHPiAQUv+POwopGCM5g2QmRdT1jFnkWenEyPvHalPeqVmXFG3CyzCSn5Sg2tFLWjLcDWPGydVhcdYs5vHmSv0VPSjVIV+iZZF/j24RN1/qN+ZNvbEiDFwm/+EoaDbTFZmOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139396; c=relaxed/simple;
	bh=7Laf5vwbfqDjveHOfT+yDWuPMHLaXvJnHti/SkHxEpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdTB2PnqXMPffx2gTkkict81SdTKfdwpbxe4dqw4iH0NSo8iI8HdCsNn+60jPWPLTxH237iF8oSDLgNT8oAYinWyBgEFozcdEJpzN9jcOlXZ9wkzbohCHCKQj+y/CPGNlSpMDKkQbyuhtEjDcDn2/6THsnkxsiBixsgI+k7HmLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2stfrQo; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2stfrQo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+nQDBHzw6ZDdtx8Dhb2OdEvt8grHaIjmx814jg663BwE2B4L3Lqdo7FLuJmKM5lxtxZxQ3/igu7fl4pVtN/oO/5P1m0LR8B9OiDQhRkB3vaeP7W88FC0USuLLEFSi6+jYpGAyH+eWjD+MYQy3TshManGSnkP9jczLZrzq2q1BYeF2pr++MyxnLfdRx63LZZCcPQG5bUzgE+K9tU8Zz+B1csmNtYZfWRbJbYZnLgkuUCoGTc2v7OaNN3Fck6Jrh5ucMm22NB5vYT/7OSW96cKJ5HUhreFmThSjH4KzzmfGhcPEAlw3SjBPmSoIYms5V4UD9LXAJhFH/369aFYFEt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfrAVW6krSwnY8c/gbZIS8Nb16CcK+izLwzk5gdupCE=;
 b=SUjpdLwvUyGx5s5Gh/L0QBp6cAjBx92AOuvzJpakeC7ZSwS3R5zLFAWQfIT8KnC8+IzQkdSncFD44QITEpSlOV1sIIsjXzmpAuxdrsd7xGRZfxtxRxr/E2vUrTt53K1xNT0Z+P1emu1VBrH1TNreZ0g8g7XBsWdqNXO4LiYmQg724znFnuDNdkiNp86a7S7KUZABuS6Iv1j//C0WkJV1JDqq9VN7VjXWSTKLlgjMBdPo6aYvRX5QjxlOSKrASPWZj4cyvdCqyg39BQxxe1Ogs1DlUDx7ucMNW2f64zxuW3IFwO9rSd9/1vO1lrQ0bb+IR1uBVRCBs1iOk7es0socxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfrAVW6krSwnY8c/gbZIS8Nb16CcK+izLwzk5gdupCE=;
 b=Q2stfrQoHRINICFwjk+sEGi6mrayeibidP5ElLosPZc5CGX0RxKOu08kFpjFwTEsC8um98rlsdEEoFecD3mkL5JilcuqUNZAmNqgr9ZCPoJs6oDmJ/42n9NgF3jGX9NCIiFA7x/bwiKCZ/acIkFFX6nqs5adzreXZFnSVerh18V+bY/hRcPbpsy0JFdfqHw3ys/4ilaH2l3zuG1lVAozJok+XCjvmgRY5qpHjVgRK/DB++8lvOSOh49kh2g4mQAXOuIVePbQRpZ/UOIe6sBEgg7CZtwmEyww8FXBJ7KoFgCLAsBnHN2eEinM/2Dth/D+WNObF/YBukCoWVkqSQ0Gvw==
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 21:49:46 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::6d) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 21:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 21:49:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 14:49:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:49:30 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Aug 2026 14:49:24 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <mario.limonciello@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v7 3/3] cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
Date: Sat, 8 Aug 2026 03:18:37 +0530
Message-ID: <20260807214837.863209-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807214837.863209-1-sumitg@nvidia.com>
References: <20260807214837.863209-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db03e87-46e9-4ec4-eb3d-08def4cdcc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|921020|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JDY9U3vfcevP0Jhan1cnyw4MxxqVvoqQuyECAo6e9M9BTy51zbplM67HAE1xznSCpLiRBAvRnQS6C+dBiIPY5PfK4uYCIs4NsAugtqgyyAjuG6CsSxri0OfpNzPSFhbmQoAq8e3aX8Yhwo+JAM+/COrcs+SW3CfzLzbB08mF/VyR55QVwyzD3uGz0nZF6JgvtAcnPR6NiiPLn+f7iv8u5FUGoUbwfDfOhoR3LJvmUkAXHyleFhw/0PKS1mNtYdWfJY1+/vc6pBLMlaBTEMrVTk1Svt2s9p71LuS7stl26Yd/IbQIHCGlDvo53Lm5sBioldgdufpw6bB962qlMKhlvlOosT9/KYzcX4PvAiQg0qIGCuN7nsDNSLnzFd7X/jDVA1TQUQMy8uy47z20f6OV2kzvrr6cqBQH8H6ljx16PDB6Hj+7P8Unfy9bZxEbqfP5VtBEuXRO5/bfsYSrU+jjbPDmfQdbx/xMR/q6cSKTxL0ZyQkSloGgsIcKAwOs62VFt7NVMI/BhNUIG3H8wN6Z1xDmkvbxlYEjaIAZEcrqOUIOCP1vqXHpWU835/G91Yu0t/zWf3WWyk59GxIsXeslUm7U7NWaRgsHgIgo/D9k7tVXPUNq9MzUCIJQtWMYH16nfZ/ZlisrE76oTrjXL8zqueBwk3KD3IWjG57EHuzlkwcJV+pXiaIQtbuBG3wVs5p67TiKbMsWTgJAFa7EEUxGdL0k4hX1xX1DbJnUFGsk1lwaJ/O3/+1Zo7WoPjqDlnJw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nPW+M/9I8wgJC/C2u/kClo2CMYjlKAkt4rEEnlfQ9uNbM9Wd+cpSXcGnqStolv9hCVnjDrXikWGYWjf9rNE7EC8RhROhJhcB+o2CsDoxVQaBPD03DMn5GxQL4sl9T1jd1HRo7IaBJ/jROA0baH9Z0AfvO//AAx1z2v5G1zKi3N0P1iaU7vHu1VukXL2AGV4/dq4wh19xBy3bBIZYTh2e/aGhnfhF5M0Rd16pW34qFdAoY6EsKjv4N1rxMopRYao+CxnqIB/GP/49b978YLdpf0cWUs7YcJYjaPiIu5LI3UoDHcx9Fq8xsNtcfVTmpiCy299Jg1fKO5MqYMkZ5BYig3vETTFJYMvQIMX+uOfet3u/Ysv4y9Em7pG95O14l/jYh3/E2vb1dvKbpf5OzLKj95gcaRMiFLHfkeEnzJWvNLVBWBTbrmDc+/Cp3eCFIs1/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:49:46.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db03e87-46e9-4ec4-eb3d-08def4cdcc08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179

Boost is the performance range above nominal, so lowering the OSPM
Nominal Performance enlarges the boost range and drops the non-boost
ceiling. Keep the policy limits consistent with the register.

Add cppc_cpufreq_effective_nominal(), which returns the OSPM Nominal
Performance when set and the platform nominal otherwise. Use it for the
non-boost ceiling in set_boost(), and to update the policy limits when
ospm_nominal_freq is written.

The cpufreq core caps scaling_max_freq with a per-policy QoS request,
boost_freq_req, that it sets to cpuinfo.max_freq and refreshes only when
boost is toggled. A write to ospm_nominal_freq changes cpuinfo.max_freq
without toggling boost, so cppc_cpufreq_update_nominal_limits() updates
the request itself, rather than leaving scaling_max_freq at the old
nominal.

When boost is enabled the ceiling is highest_perf, not the nominal, so
the update is skipped. set_boost() applies the new nominal when boost is
turned off.

A platform with highest_perf == nominal_perf has no boost range at boot.
Lowering the OSPM nominal from sysfs can create one. The core, however,
adds its boost FREQ_QOS_MAX request only at policy setup, and only if
boost_supported is already set. Set boost_supported in init() when the
OSPM register is supported and highest_perf > lowest_perf. Boost can
then be enabled after the nominal is lowered.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 65 ++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fe714e71826a..bcac46ad25c3 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -892,6 +892,27 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+/*
+ * Return the non-boost performance ceiling: the OSPM Nominal Performance the
+ * driver last requested, or the platform-reported Nominal Performance if none
+ * was requested.
+ *
+ * The register is write-only, so the requested value comes from the
+ * software-tracked state rather than from hardware.
+ */
+static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
+{
+	const struct cppc_saved_vals *st = cppc_cpufreq_policy_state(policy)->regs;
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 ospm_nominal = st[CPPC_SAVED_OSPM_NOMINAL_PERF].requested_val;
+
+	/* U64_MAX means OSPM has not selected a nominal level. */
+	if (ospm_nominal == U64_MAX)
+		return cpu_data->perf_caps.nominal_perf;
+
+	return (u32)ospm_nominal;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -950,9 +971,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
-	 * is supported.
+	 * is supported. A writable OSPM Nominal Performance register can also
+	 * open a boost range at runtime by lowering the nominal, so assume
+	 * boost is supported in that case too, letting the core register its
+	 * QoS request up front.
 	 */
-	if (caps->highest_perf > caps->nominal_perf)
+	if (caps->highest_perf > caps->nominal_perf ||
+	    (caps->highest_perf > caps->lowest_perf &&
+	     cppc_ospm_nominal_perf_supported(cpu)))
 		policy->boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
@@ -1233,11 +1259,12 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 nominal = cppc_cpufreq_effective_nominal(policy);
 
 	if (state)
 		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, nominal);
 
 	return 0;
 }
@@ -1411,6 +1438,36 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+/*
+ * While boost is disabled, the nominal is the ceiling. Set cpuinfo.max_freq to
+ * it and update the core's boost_freq_req to match. The core only syncs
+ * boost_freq_req when boost is enabled or disabled, so a plain nominal change
+ * must update it here.
+ */
+static void cppc_cpufreq_update_nominal_limits(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 nominal;
+	int ret;
+
+	if (policy->boost_enabled)
+		return;
+
+	nominal = cppc_cpufreq_effective_nominal(policy);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(&cpu_data->perf_caps,
+						    nominal);
+
+	if (freq_qos_request_active(&policy->boost_freq_req)) {
+		ret = freq_qos_update_request(&policy->boost_freq_req,
+					      policy->cpuinfo.max_freq);
+		if (ret < 0)
+			pr_debug("Failed to update boost limit on CPU%u (%d)\n",
+				 policy->cpu, ret);
+	}
+
+	refresh_frequency_limits(policy);
+}
+
 static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
 				       const char *buf, size_t count)
 {
@@ -1442,6 +1499,8 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
 	st->requested_val = perf;
 	st->firmware_val = cpu_data->perf_caps.nominal_perf;
 
+	cppc_cpufreq_update_nominal_limits(policy);
+
 	return count;
 }
 
-- 
2.34.1

