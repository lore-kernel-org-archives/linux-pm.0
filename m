Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495A4570E1;
	Fri,  7 Aug 2026 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139377; cv=fail; b=guY7POeTgUvri8l6M5URqmeuXHqXd6/KPgnkAjFvyMKowTR8ftOyAicFB95OzsEZJiGrk10Zg5p/r9GFGjSu+AwbBkHlLcTwpBA49DFMri+Psu3NBo9tevEwgfCqBtp3CtWdf4xYGw//ju8KS0a6kbyu/Tw/YFV6EiNI7iXJsUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139377; c=relaxed/simple;
	bh=VmX91WZ5UdubdWatOZ/oQOsi3lU60Tsjb8q3sbNq75U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rypPD5zSACPb+SnlYhBJwnNUjtiNUXacdVjllgOt8fPXRxUixLGQ7XyzRfxpq/bwWy8WCIkXD3wuo89foDO0joFxSds4YOwlXMb3YJSIPyIzLd05h8esgkTnO1B/9W9du1dYtVXF8tcpFBGys7L7i5BXaR4Y1NcYL7s0XNSZtrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tv/quz0B; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tv/quz0B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVxliHvOs8wChCcDlK6/+FvyQSf9X1wzx8psbYYohUdZG3r/RDJmU77Cm+DjoycpOJjXgX1N4n2iR6boElKLSWcjL1D/DAoDxNXRWCNFEFfVvwM69ZV7fMP9TvP1B5jxef+eg9ws/VOZImaoY4IF0EYxPK54ud++FY1Fz4Qx8mcLvwggBAO9i42pwF/EPloL+TCgUapsHa8CwK/MKb6z4ag3cwW8/aMNv6035BM0Zt0U7ZPWuIXwlnWUz7DOBOyy8M36jzLi2HZU6lIIVxakJdcin4Ak88prhhyUoAxJ2IcsDdbr3/N2kHnncZcZzO8mEwbpv44iKcBIjnzcV/cKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fowqZ9G1SCoOO34OGpKBpSlQTp1c/jJgJXFblI2lpBU=;
 b=FOzAG++bvAraCuuGzy2BtyCfvstGYavwnHvLEueHaDSJV2JKq4AFGZbxL1Buz158CiCn7LS/+X3hzKzc3qLAM+bd59bbGpNAHluXZqoFZl2/jOBH2cKSUBxuAOphP9ZL6v3FsqqZlXL6lRWmxibASnT1GWYnGvtOCf2sQX8qmmH3MeAYX+dD208xP4poS2FdVFB0okI2cHMks/IBsHSjoyqzJ14Z6/oFWMgVQg1jBQ3u3/bHQQrIfySx+jBInKLvvLN6n8Qg1OchiZSPZR682iDV5FeE3x4hL+eXKsPxC1la5p9c2JWc4Gl2u1pE00ep6u/VooZI0zRX6E3Pu0aWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fowqZ9G1SCoOO34OGpKBpSlQTp1c/jJgJXFblI2lpBU=;
 b=tv/quz0B4mg+tbVXsADfoGA2OkLtvIb3YJ+zEv6rOyqbk2FyKuvoMAlxBTWIbr05nP23pzLZF+WBrnG7ZFD89P9FKi4vtfo81dskB6pt6CThoFm05+e0yRh8G0QH4JmcQTndp5fPL2OkH7WAHg8v1mlrvgBiOOjD7Qg8llAeVE/wnh0TXrL45RTNNDTR5Mzhgw9zbnrEZ0jilDMoHco2fvR4I2LNj5Vqsnwcm8pRf7JOhom8mODGwSZcDlf4qeedNJENjjTlLd91oP9PoJ88G1guWi/Pgmh7BG//073JKUcsgOOclUxMK4wGGsoYsMNXgUr5ErbKNRwJM+aCt6oR9w==
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 21:49:29 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::2b) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 21:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 21:49:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:49:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:49:10 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Aug 2026 14:49:04 -0700
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
Subject: [PATCH v7 1/3] ACPI: CPPC: Add ospm_nominal_perf support
Date: Sat, 8 Aug 2026 03:18:35 +0530
Message-ID: <20260807214837.863209-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 1128d0e4-d406-4191-fffa-08def4cdc1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|921020|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b8cY/vOpYwSwCSQS7HuIsDsy1l68Vq405x5LG5tBmmaRR1AOc+6D2/Bpw+7Vov3vOrqiuGx1sv/YSJ/lUw9f6SQB7Gzivm34LzEyx8kjf0p8N/EcP1mLQMVTUl9FjTF+yf9F9UTKbpmba5QHgTdJgamA08RnxZHdZ88xfCoiegEJYCaDGnAXf24JpZ6zeKl9+amBbXIECcC7nMrIqrbjYEE3JloJMxurrYebymlICpQZXYzneEq4OCil+het/7pAK/VlHrjSi7Gva4xKLIyx1kgW8Y1vgXMYptpB6cx8PIpfGgtmn3gNtW3iXVcv9/cM9gwM8QLyDVenLRDAebKB0jk7QRwc/bqF1eflCiQngqX8Y7MQ2GG66lI7l1JyL4QNI+KShsUjsW0vXauW/gpWeeWdORya+BiSmyFIzW88DXnT8tQq2d098/WeU7PHTDsEcrDS5XJUPSZPvoiNcnqmZwQAAIY/8Mpf8zA92V+L7PDE0A5ck3m0fwuN7gJQhCo/hwG51vLvp6N/TMp3rdAS04TgfpBlI5OKN3y38LlP3l1pzkvR3ft4u0vJ57XT8+RW0uegaJkqfMjXP8hPjrCtsQiVUh7TrSee42kPyC7SeNyL7db22SB04gUcSCLkjI7L9/KdZCKQ9UcW06I1pfdGyqll13iYdvXpkpBvcx90Xqd/AKKdqtsftf4LwfrbTOY+nAeljceui1wKxYiu1DPo7SAZUHqykZ0Ck3bIHf7sRSttlzQE8PwdIBZx6vA+Mp3m
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d0jsn9EpUptwxpXSKON4cM0nzBSgDGuMEN54j6CEGxnY08xXEYtUPb/9VZ08p7vU4fMiCX4McpPl6mRphjFtbNMWnKFWA7ZYCazxuFWH63vYzYEbzWgEIBZDiCQW6wpl0Lh3LsvYiWAEGikdwuaY5QFZ0byOawnIkxv3w2Rac/e5hAQF3SbrOVn8wLYWP918LVDqTay+zxc8NdxXBM3M7vPZKhv+YblFevEuX+yS1qgoBmDzeRK/WD0/8rcmayuN53IROJpy8FbK1Vuu3RsnwNsj7OK/tSrTkKHvUq6EgPjpU9e+ZYOSyGHYtkOrJglBCfBiuu5ICpnH7+j3NuiHR9v5WVSREU3YhaVoIkLkCOtjcODw6LEeEZQ8OKLTr5n/BNBtPpOumJwngaKIT2oeM2K8eT2eyCzBJJL+BmGtpqxYWQYlaf8r/QEjEWAqvvtc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:49:28.9901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1128d0e4-d406-4191-fffa-08def4cdc1d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728

Expose the OSPM Nominal Performance register (ACPI 6.6, Section
8.4.6.1.2.6), which conveys the nominal performance level at which the
platform may run. Unlike the read-only Nominal Performance register, it
is writable, so OSPM can ask for a nominal level below the
platform-reported one, which then becomes the boundary between boosted
and throttled operation for the platform's power and thermal decisions.

Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
the value must lie in [Lowest Performance, Nominal Performance], which
the caller is responsible for validating.

Add cppc_ospm_nominal_perf_supported() to report whether the platform
implements the register as writable, since a write-only register cannot
be probed by reading it. Factor the writable-register check out of
cppc_set_reg_val() into cpc_reg_writable() and use it for both, so
support is never reported for a register that a write would reject.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/cppc_acpi.h | 10 +++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9e882b3911e6..b6bf46cb06cb 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1388,6 +1388,13 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
 	return ret;
 }
 
+/* If a register is writeable, it must be a buffer and not null */
+static bool cpc_reg_writable(const struct cpc_register_resource *reg)
+{
+	return reg->type == ACPI_TYPE_BUFFER &&
+	       !IS_NULL_REG(&reg->cpc_entry.reg);
+}
+
 static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
@@ -1400,8 +1407,7 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-	/* if a register is writeable, it must be a buffer and not null */
-	if ((reg->type != ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_entry.reg)) {
+	if (!cpc_reg_writable(reg)) {
 		pr_debug("CPC register is not supported\n");
 		return -EOPNOTSUPP;
 	}
@@ -1832,6 +1838,44 @@ int cppc_set_epp(int cpu, u64 epp_val)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
 
+/**
+ * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
+ * @cpu: CPU on which to write register.
+ * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
+ *
+ * OSPM Nominal Performance conveys the desired nominal performance level
+ * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
+ * must lie within [Lowest Performance, Nominal Performance] and may be
+ * set independently of Minimum, Maximum and Desired performance. The
+ * caller is responsible for validating the range.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
+
+/**
+ * cppc_ospm_nominal_perf_supported() - Check OSPM Nominal Performance support.
+ * @cpu: CPU to query.
+ *
+ * The OSPM Nominal Performance register is write-only, so its value
+ * cannot be read back. This only reports whether the platform implements
+ * it as a writable register.
+ *
+ * Return: true if the register is supported, false otherwise.
+ */
+bool cppc_ospm_nominal_perf_supported(int cpu)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	return cpc_desc &&
+	       cpc_reg_writable(&cpc_desc->cpc_regs[OSPM_NOMINAL_PERF]);
+}
+EXPORT_SYMBOL_GPL(cppc_ospm_nominal_perf_supported);
+
 /**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3394e1b208be..a078ad5964c2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -185,6 +185,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
+extern bool cppc_ospm_nominal_perf_supported(int cpu);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, u64 *enable);
@@ -277,6 +279,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline bool cppc_ospm_nominal_perf_supported(int cpu)
+{
+	return false;
+}
 static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

