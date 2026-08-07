Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954894519A5;
	Fri,  7 Aug 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139386; cv=fail; b=PTWxYsArLTRycgwedJbodOt+yqgV2OdjZ9nj7wk0K54Io5j9cM3EIfVxZW+FgwpYPzJ2wR/2YzJ0r6HBp99Ty2SiIFRbIvKA6EYddCvEhnWwBJT8br39Sxq24IUiWsEKvqR4iCciH7EkVkzIT6g9sPk8lYWeBAUaq++6M3jweL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139386; c=relaxed/simple;
	bh=NmQHoFbkff7z/1qbHHuFsABLgSs91eeU0XsUuy+xaec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osWKYuzvUulG7TzQA85ewfykyJvkIsM1OT37NJ2zSjkR3BfdEoD70QruuSI5H4b9DMxxd29yyZRmxHN4AfS0wpfHYYbEb8wlj3xWSOZMug+nlSSQUVCG26eKZuxMJPBMFE1pzSSklIMdMpMTld5OJWCpL8TxxK3popaq7RZ516s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3Z0eXB9; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3Z0eXB9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6uUMdn/PaBCEAh5og/kiY8gAjELwP9B1RVpCAZg7Z14WY3QANUWB0IT0WYo0T35frRWbmtMEZcsdzR98n6y2OiGObxB11/vzA+rm2rC2X+eIkuQiqRl36zC1i9+tTqeIscQ+J+p37Jx0/R95rcK0BXzQlet6jlnI8+oWOZXw971h4AhruMYpncNrjjJXBaA+rgXXs4pKC4E8yoyy2w3qAVLqRrhZsYY5RJ7HmsKhhFGj5Pm/bBVplN0Pf2AMcqw87djnFds374pTcT8zTsAxRHohaJunNQWLx7ZR2vd7rG+IiVRrJh9zZoEGaGFct/s7ctvt6LMms4mX9WeD9YElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lym1rL/qn6z7zlvtpm4oIQvSc0X1EeSlUZF66y5vmSE=;
 b=W3Q0MPZgYYcMJYPHrNssZJ6xDzG4WGZk53rn6e+RlLlHDZL5cY1+9JXyxB4zUYqn5mYXq2hjBwMU7BIvwZkWfl8IzGUOWuMByD9cjMzPyfVEBcFt+mR/1T0P05B+/HzvuWPDyqungMpqpGNhA5xDmHyMJkZsnKMuWtV/Sn+AbRZZ5bK/KrLZCWyhWuPJ7m9LArOXBOpeXegnbNWaetNi2C0pOtJZl7LZnCB3W9MwAYYsv+wLIwHEXpbniTvpPdG8i33f4R3tnaTbBjTxCbCMQC7I0ImBRISnAKTzlP2AtiLDyyR16ZfMwPl/RSiZOMa4o1JVheN9fAfiq2ormA5gXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lym1rL/qn6z7zlvtpm4oIQvSc0X1EeSlUZF66y5vmSE=;
 b=l3Z0eXB9V8EdKnsJWGVyun26Dwl4kqjh6veGP1BJ5nQ06YHhSgs7M3H0ETHOR9hS8oXsYihec1YkyjiyoOr2WxvsgMSnDFXsMkntKTffEwwgXGs9vBPAsD6eyOOZHo3I4Xg3ZVmkkqAlV8xQjAPzpr0d4jFgRFGjsqVM0A2NbzzXChv52oa1RAbfz7BJXGIwMZXqDw4BAJNZgw+G+Q/DFvpz/xw/E5thqNCrcL15rYgNaJsNjG3+gPBkGLISbcCbKdJjYmTQ/ykwnFxDsXAOixCA1zgX2tK66hQIKZmgLgK2kowWsxXeb0V87jM+R90pO+jC/PK6HbRRQu6GlLuh5A==
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 21:49:38 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Fri, 7
 Aug 2026 21:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 21:49:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:49:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:49:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Aug 2026 14:49:16 -0700
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
Subject: [PATCH v7 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
Date: Sat, 8 Aug 2026 03:18:36 +0530
Message-ID: <20260807214837.863209-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: de1ec0d1-48f7-4a7f-3802-08def4cdc775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|1800799024|36860700016|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IFPHOQzIGzcMHFBlx0xTTRoLDqM3ii5YUrVeObU7jVz8t0IkIXJTgOqZxoMz821T+ZzAcl8pM7mx1ipPA6bmkpvkYK1pZOKQ9CuvnmpQSwBbyQRmCaHmfdJdWkady3/gsYuiNw1ekmC1HJD1bx9jAOjdny8FdEet2ajEhzDAUZaGRnVVAZWR+GpzUhYAcmrKYdMdG3uepi8+Kz6KOJpp6h6cYKG4UMzAj6R9pnfJdoFXEtdhGoB005B+k5IbklANaXcg0j/IHCiPrg6N6v+wDFNgIagPOdKXKP19OkdSdlxowBJ1xgOwv6o8p1+rkj6Ifu8FhGPCkGyuV2ph22KwiKd26y4QNu0cPkA52kfb+f0culd2EeYwg4Dzw5KVhSVLWWOZphbeypfcnzlvGvJfc3/2CGvY0LfkC3EI/bo9Qz2H2LLikZ9lvmE6n62SD1wV+5ch76l1bGZC0FSaxIXNGZdcJwXC2XhWukAl68sy5eQ88Gi1pAXL6GfWKHCEY45uqhZxef5Ekr3udBvERjsDdpVSW7dc+R0djUC5NVVbkI6fxWWYJZHArV5P+MbMkumNXlv+a4+YN9iDlAkdBShSjtHHMYySZnstGfJqYKQydw4cuDJhv3UMuwr2aVfHKq1G5LHl+VFBCrXsheR4xHdOKrLWL8nlQ+2Qq8VFfYd4kVJy/+VonJGBnecu6uO74iEEZmBhd3r/r9T689K25dHSC8Gt/zyD+/Cx7pAytf0NYk9zjh83z8+hFzjzqVV+vf9d
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(1800799024)(36860700016)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a7oHUQAPEATn400g79+OyUuBbvLMtqaHnibNfyHuAV/249ij2Cm2v/V/UvazKpJXpZ1urjcR+m2dptuO2w1q2mPAUsEqqEaD2qhi0/nI8ZqKULTxluNhx2s9HH9tKDG873TBIjyuAdWQ4GfCSXJ/KM1xPjwVGTWEE0J+E9/ZLu8S3cuQu/Kz/v5QNKZpa4v61XIQpvYo4/+rCq4T4w8iM4Ve8BV63F19BSWrCOsGpGSEFV2wMj9M9vprnhuuqL0x1tcLK2wYV1K4U1IebL6f2lKfYdzdFt9olT8eSSIsNV/hYbhh8N6xPuWIQdcS2HJfliRTGSH2dV2sk4d1GKQg4S711/8lHR8UxA+SlB+WwCRA5huYc99p9DV0owCJP+BaCW62cgeoqvKVxy7dIN/RDkanQadbBILkugg1PopGxLBKkrArBMChrosG6eT25quL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:49:38.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1ec0d1-48f7-4a7f-3802-08def4cdc775
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

OSPM Nominal Performance (ACPI 6.6, Section 8.4.6.1.2.6) lets the OS
request a nominal performance level below the platform-reported one. The
platform treats performance above that level as boosted and below it as
throttled for its power and thermal decisions. A lower value moves that
boundary down, so sustained work runs at a lower point while the range
above it remains available as boost.

Expose it as a per-policy cpufreq attribute in kHz, matching the unit
convention of the other frequency attributes:

  /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq

The attribute is write-only as the register cannot be read back. Writes
are converted with cppc_khz_to_perf() and rejected unless they fall in
[Lowest Performance, Nominal Performance].

Also track the register in the OSPM-set save/restore table, so a
requested value survives CPU hotplug and suspend/resume. The store
handler records the request rather than init() capturing a firmware
value, and driver unload reverts the register to the platform-reported
Nominal Performance.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 24 +++++++
 drivers/cpufreq/cppc_cpufreq.c                | 70 +++++++++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 82d10d556cc8..59aafcb2af97 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -346,6 +346,30 @@ Description:	Performance Limited
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
+Date:		August 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	OSPM Nominal Performance (kHz), write-only
+
+		OSPM uses this attribute to request a nominal performance level
+		lower than the platform-reported nominal. The platform treats
+		performance above this level as boost and below as throttle for
+		power and thermal decisions.
+
+		Write a value in kHz, between the frequencies corresponding to
+		Lowest Performance and Nominal Performance. The register cannot
+		be read back, so this attribute has no read side.
+
+		Note that tasks may be migrated from one CPU to another by the
+		scheduler's load-balancing algorithm, and if different OSPM
+		Nominal Performance values are set for those CPUs (through
+		different cpufreq policies), that may lead to undesirable
+		outcomes. To avoid such issues it is better to set the same
+		value across all policies, or to pin every task potentially
+		sensitive to it to a specific CPU.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
 KernelVersion:	2.6.27
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 32f38b0c492b..fe714e71826a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -33,11 +33,13 @@ static struct cpufreq_driver cppc_cpufreq_driver;
  * reapplied from online() across CPU hotplug, and the firmware value is
  * restored from offline().
  *
- * Autonomous Selection (auto_sel) is kept first, as writes to the registers
- * listed after it only have meaning while autonomous selection is enabled.
+ * Autonomous Selection (auto_sel) splits the list: the registers before it are
+ * independent of it, and those after it have meaning only while autonomous
+ * selection is enabled. Place a new register on the matching side.
  */
 enum cppc_saved_reg_id {
-	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_OSPM_NOMINAL_PERF,
+	CPPC_SAVED_AUTO_SEL,	/* Entries below need auto_sel enabled. */
 	CPPC_SAVED_EPP,
 	CPPC_SAVED_AUTO_ACT_WINDOW,
 	CPPC_NR_SAVED_REGS,
@@ -50,6 +52,11 @@ struct cppc_saved_reg {
 };
 
 static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	/* Write-only: the requested value is tracked in software. */
+	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
+		.name = "ospm_nominal_perf",
+		.set = cppc_set_ospm_nominal_perf,
+	},
 	[CPPC_SAVED_AUTO_SEL] = {
 		.name = "auto_sel",
 		.get = cppc_get_auto_sel,
@@ -79,6 +86,9 @@ enum cppc_saved_type {
  *                   could not be read
  *   requested_val - value in effect when the policy last went offline,
  *                   reapplied at online(). U64_MAX if none
+ *
+ * A write-only register cannot be read back, so its store handler sets
+ * firmware_val and requested_val instead of init() and offline().
  */
 struct cppc_saved_vals {
 	u64 firmware_val;
@@ -135,7 +145,17 @@ static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
 		st->suspend_regs_handled = false;
 
 	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
-		if (cppc_saved_regs[i].get(cpu, &val))
+		const struct cppc_saved_reg *reg = &cppc_saved_regs[i];
+
+		/*
+		 * A write-only register cannot be read back. It has no
+		 * firmware value to capture, and its requested value comes
+		 * from the store handler, so do not overwrite it here.
+		 */
+		if (!reg->get && saved_type == CPPC_SAVED_REQUESTED)
+			continue;
+
+		if (!reg->get || reg->get(cpu, &val))
 			val = U64_MAX;
 
 		if (saved_type == CPPC_SAVED_FIRMWARE) {
@@ -197,6 +217,12 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
 	u64 auto_sel, val;
 	int i;
 
+	/* Registers before auto_sel do not depend on it. */
+	for (i = 0; i < CPPC_SAVED_AUTO_SEL; i++) {
+		val = cppc_cpufreq_saved_reg_value(st, i, saved_type);
+		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
+	}
+
 	auto_sel = cppc_cpufreq_saved_reg_value(st, CPPC_SAVED_AUTO_SEL,
 						saved_type);
 
@@ -1385,11 +1411,46 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
+				       const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_saved_vals *st;
+	unsigned int freq_khz;
+	u32 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+	if (perf < cpu_data->perf_caps.lowest_perf ||
+	    perf > cpu_data->perf_caps.nominal_perf)
+		return -EINVAL;
+
+	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
+	if (ret)
+		return ret;
+
+	/*
+	 * Track the request in software: requested_val is reapplied across
+	 * hotplug, and firmware_val makes the register revert to the platform
+	 * Nominal on driver unload, since the value cannot be read back.
+	 */
+	st = &cppc_cpufreq_policy_state(policy)->regs[CPPC_SAVED_OSPM_NOMINAL_PERF];
+	st->requested_val = perf;
+	st->firmware_val = cpu_data->perf_caps.nominal_perf;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
 cpufreq_freq_attr_rw(perf_limited);
+cpufreq_freq_attr_wo(ospm_nominal_freq);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -1397,6 +1458,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&auto_act_window,
 	&energy_performance_preference_val,
 	&perf_limited,
+	&ospm_nominal_freq,
 	NULL,
 };
 
-- 
2.34.1

