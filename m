Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D54367F25;
	Tue, 23 Jun 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208471; cv=fail; b=YBOjcJpGmIuMgk32qPMp0o+O6yryBxU1utC2yaMsJoaADa95ZSLQTm8Kh/uLHfInZ1zYjejb090jxnHAM1aRzAXaHOtf0OmJ2lk51VV7oPVI9iKS77N48OFmTETjO3PmfZ7V3v3iSj2E0F+A7e3rVIEAdDmZf19GHRA3vSAxOzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208471; c=relaxed/simple;
	bh=wW58o7zEsyJy9DGbynKTTKavUhOYEK6cLD/tpgVXPok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngQtXFRvmWGwaVB5eNBD7kzNFEujDlICIOCwqgmtlSoXFQ2mx44+WIkeuwu6a3yRWcrG6KE1SRSA8V4KvWSMMoSF/LGnZa3SBe6TXh+gVasKqxE2PjgnAV7B8krDvQrhM6IcZ3oRe+HjiloaOuWLX6CpvFBSeixvv/oNztxR/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXlpRS45; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXlpRS45"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrAyhG9pqDGGMIa2uGNVR1xn+ggPoh6hZ8WbZJyFB47xl2Ds6ZKqV0Cft6fUPMwYiXqtjFsHq3GzCPUrkhD7pk8wT8z7d79KzXvJ0H0GYttMOiiUhahiM+ZD6dM/nSYDNuJFP6JIG34XFO6ExY8lCAsh6YtJCCZ4oXeLGzSh0jBd07Cr74d7EdolQPktlAP+EhRtCP8jqY/kH3npdVkNiUDJEjEqq2XHfeM7mFYtIwwpKSvNTITqBdpIblRm8QDFUZ/cCj6HRpcyE29DkUhcJ5svYgwjGV+gbSf7UnWr3VOzpXjb1UNRhJRz+E2rlhd5uK9HcgcQxSAbSuia95OFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFCRGzauroMbOT3jYcUFL/yss9QweqaggDrH+LgalfA=;
 b=LZZT2mW7DFtX/dY6vvN7zXGu3G9ixV+E0/0Lj/7BQwy3LejJgklX89Fzu7VMGDQL3uRQSGiMD56qHqKZC+iJsXLR9GxiVFzIIfwJ0KwcFNAIoAtln8+mBXzgcRg3cxzo8pLH4XLW/K6iR1b4EjKALN0e0py/5ynwgDe/3Opy4TnNr3t0VdKEBWwDgOGRtnSxHDN096UPC/CZXk5uQzqyCQmMxZ/MNrP0Jfi44r27a90uxlSTt6G0Aouy9ywiuw+tcmX/Pc4Nc8ejnafj+6EbzSvoBBZidShBx/vQihYXRo5nTWwKiKtH8y9QGc1KJ1ugFSJcCrGsb4cNI1o5dBS9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFCRGzauroMbOT3jYcUFL/yss9QweqaggDrH+LgalfA=;
 b=FXlpRS45Se9MB8uCcR3R4yoMH7y4DAXYIaZjv/C67zZ5wZeQuUUxzgj/m7wO3JFxxWUl5T9AC0QPZNqbK68HwKpzeLIXdu0X00Pr2+0Xc4Sj4ntPfn10xOrODhRBGwyNPcB3Yl3kCv+CAOgUdj6MuS/w3MPl7MnuVO4Y5XTU7yY0QMs/7ujNAFWux+MGy+7ZsNJD4ko7PIG9BVrrchlXd6lzlWhb7k9rT6zXfcidbxIkVJAaaFXuKXSToSm/I5+/DJS8c+NPLZ06Y4uxn2EO8p9Jwy5LQzKYowqrnkhE6cV+MkvZXGSZG0nIU1RdEWYXMJeae0qR/Kqf9rGa1qkoPA==
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:54:24 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::4f) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 23 Jun 2026 09:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 23 Jun 2026 09:54:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 02:54:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Jun 2026 02:54:14 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Jun 2026 02:54:09 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Tue, 23 Jun 2026 15:24:03 +0530
Message-ID: <20260623095403.3407436-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 23635bd5-331a-4ee8-195d-08ded10d675e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|13003099007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Fr0Zoc9DjbH65K7cVznfMprIOy3opiGKjGqI9qxfc79rd8zX50pQysbPUeikRC7UsBoxqn1AKePNGqGlinY7HzbooTTeQmvms365RF17xnK6xiyXHoXEWesIuRBD7A5OGAZtKxKonz12kzlKnYB5M4/BwtXStZBkak5TtF8blEfLzYP/ZatTHDwWRvohYDipgLBJkcinXGbgV8ysgAaX4et8Ve03WcqdEiGDDbF8ks4KY75ezfXq13vtRQqknVLY6XwdYjsxdGNk3rXAQuJ9GARRuwlvxxyP+e0Ekzq9ltiYj2o6debn7IblvM0Zx60XBdPuPhrZwkIwlMfrpnBb08ErILXTHpHEmgkFeggjBpvidcxjEwVybDuNAjX+qhWW5rJ+0rR77Bl8DKWqX0yQf7KiiNP5j9bgLS+OF9pKOCb9gYlZIlff22rQB2pZJ02d7OSNQWQTmc/wW/TSKlI4GeIXN7XZw5+aamK1NylZY37nOMvgyPA4emR9ubiFoFSprWblWfIlcH+bqaXbP704+QyFjcEo5puHrR0rIjMlbkIbM/aIbFFe5W8ORT2xzUhBcv/lVPUz0X5r6V9QhC9l7Y+3MnKlQWxhg0+G1P/iwkUJFFvZiwakFmE0vcrykLiqYSi7BjvQfldtggISzP6ANRkWtqtoUM3sYmTKtuE4F5dFDm/q+dX6pIjHNOYfFeSDhfB8UUspT2rdTZd115oxlw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(13003099007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lrhqngoUl4GrZHMDMlfEVWkDPCUGEpMUPv6655jKzKPjpvl20yYTubhFwW6g/me3WqfezKiuNLw8lrWpnN7C8IoiYN6TKXT/iB6FsjLJxdEn2/STwFSs1UzLW4ehKHrsgwCWW3e6OWawXaxHBEN8RDZijFMs17DTW7UzFts/mRIiD5+VgneOIcX58kNybzkdD8BjfoEoCP50Ob8ByR0Gsgmdf3TNHS4b0Q48R/bwgDQPaXblADrF1If8u3rxhISQGb4TCzIsPTF/eCtkOAUSJuvG3UTf80v2SwEPqEBZQVMRSlEEszF8CiFrfhQ5oBUTAXfuwR5yDbiPQdmwLxL9BrsD6rTWD3Kbdr/ZBV7Y8V03psMizje339fc75DF1PyNvGphbCWWUa473m+7X+s76+zV9n0Ry/oiHnngqADmi181q+CKXCGNCDhkqxmNQQ3m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:54:23.1897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23635bd5-331a-4ee8-195d-08ded10d675e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

Values written to OSPM-set CPPC registers (via sysfs or the autonomous
boot parameter) can be lost in two ways:

  - Across CPU hotplug: the platform may reset a CPU's registers when it
    is offlined.
  - On driver unload: the value the driver wrote is left in the register
    instead of returning to its pre-driver state.

Add a small table-driven mechanism that handles both:

  - Capture each register's firmware value when a CPU is first seen and
    restore it on driver unload.
  - Record the last value the driver set and reapply it from ->init()
    when the policy is reactivated after CPU hotplug.

The firmware value is captured on a CPU's first activation rather than
once at module load, so CPUs offline at boot or hot-added later are
covered.

Reapply is only needed on a full policy teardown and bring-up, which goes
through ->init(). In a SHARED_TYPE_ANY policy, offlining a single CPU
leaves the shared register untouched, so nothing is lost there.

Cover the OSPM Nominal Performance, Autonomous Selection
(auto_sel) and Energy Performance Preference (EPP) registers. For
auto_sel it replaces the previous unconditional
cppc_set_auto_sel(cpu, false) on unload with a restore of the firmware
value captured at the CPU's first init.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---

This applies on top of (not yet merged):
 [1] ACPI: CPPC: Add ospm_nominal_perf support
     https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
 [2] cpufreq: CPPC: add autonomous mode boot parameter support
     https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/

 drivers/cpufreq/cppc_cpufreq.c | 194 +++++++++++++++++++++++++++++++--
 1 file changed, 186 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a3fabfb07fbe..d6ea2cbde187 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,174 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
+ * the autonomous boot parameter is reapplied across CPU hotplug, and the
+ * firmware value is restored on driver unload.
+ */
+enum cppc_saved_reg_id {
+	CPPC_SAVED_OSPM_NOMINAL_PERF,
+	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_EPP,
+	CPPC_NR_SAVED_REGS,
+};
+
+struct cppc_saved_reg {
+	int (*get)(int cpu, u64 *val);
+	int (*set)(int cpu, u64 val);
+};
+
+/* u64 wrappers so the bool auto_sel register fits the table signatures. */
+static int cppc_get_auto_sel_u64(int cpu, u64 *val)
+{
+	bool enable;
+	int ret;
+
+	ret = cppc_get_auto_sel(cpu, &enable);
+	if (ret)
+		return ret;
+
+	*val = enable;
+	return 0;
+}
+
+static int cppc_set_auto_sel_u64(int cpu, u64 val)
+{
+	return cppc_set_auto_sel(cpu, !!val);
+}
+
+static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
+		cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
+	},
+	[CPPC_SAVED_AUTO_SEL] = {
+		cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
+	},
+	[CPPC_SAVED_EPP] = {
+		cppc_get_epp_perf, cppc_set_epp,
+	},
+};
+
+/*
+ * Per-CPU saved state for each register in cppc_saved_regs[]:
+ *   firmware_val      - register value before the driver touched it, restored
+ *                       on unload
+ *   requested_val     - last value the driver set (sysfs or boot parameter),
+ *                       reapplied on policy reactivation
+ *   firmware_captured - whether firmware_val has been read, so a not-yet-seen
+ *                       CPU isn't mistaken for one whose firmware value is 0
+ */
+struct cppc_saved_state {
+	u64 firmware_val;
+	u64 requested_val;
+	bool firmware_captured;
+};
+
+/*
+ * Per-CPU and not tied to a policy, so the saved values survive policy
+ * teardown/bring-up across CPU hotplug. cpu_data->perf_ctrls is per-policy
+ * and freed on policy ->exit.
+ */
+static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_saved_state);
+
+static void cppc_cache_perf_ctrls(struct cppc_cpudata *cpu_data,
+				  enum cppc_saved_reg_id reg, u64 val)
+{
+	switch (reg) {
+	case CPPC_SAVED_AUTO_SEL:
+		cpu_data->perf_ctrls.auto_sel = val;
+		break;
+	case CPPC_SAVED_EPP:
+		cpu_data->perf_ctrls.energy_perf = val;
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * Save the requested value for the given register and CPU, to be reapplied when
+ * the policy is reactivated after CPU hotplug. Also update the per-policy
+ * perf_ctrls copy so the saved and current values stay in sync.
+ */
+static void cppc_save_requested(struct cppc_cpudata *cpu_data, unsigned int cpu,
+				enum cppc_saved_reg_id reg, u64 val)
+{
+	per_cpu(cppc_saved_state, cpu)[reg].requested_val = val;
+	cppc_cache_perf_ctrls(cpu_data, reg, val);
+}
+
+/*
+ * Reapply each register's last requested value from ->init(), so a value set
+ * via sysfs or the boot parameter survives a policy teardown and bring-up
+ * across CPU hotplug. Also keep perf_ctrls in sync with it.
+ */
+static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu, i;
+	u64 val;
+
+	for_each_cpu(cpu, policy->cpus) {
+		for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+			val = per_cpu(cppc_saved_state, cpu)[i].requested_val;
+			if (val == U64_MAX)
+				continue;
+
+			cppc_saved_regs[i].set(cpu, val);
+
+			/* Keep perf_ctrls in sync via the policy's CPU. */
+			if (cpu == policy->cpu)
+				cppc_cache_perf_ctrls(cpu_data, i, val);
+		}
+	}
+}
+
+/*
+ * On a CPU's first ->init(), capture each register's firmware value to be
+ * restored on driver unload. Later calls for the same CPU are a no-op. Capturing
+ * from ->init() rather than module load covers CPUs that appear later. Also seed
+ * requested_val to U64_MAX so its zeroed default is not taken as a request for 0.
+ */
+static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
+{
+	unsigned int cpu, i;
+	u64 val;
+
+	for_each_cpu(cpu, policy->cpus) {
+		for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+			struct cppc_saved_state *s =
+				&per_cpu(cppc_saved_state, cpu)[i];
+
+			/* Capture once per CPU; skip if already recorded. */
+			if (s->firmware_captured)
+				continue;
+
+			if (cppc_saved_regs[i].get(cpu, &val))
+				val = U64_MAX;
+			s->firmware_val = val;
+			s->requested_val = U64_MAX;
+			s->firmware_captured = true;
+		}
+	}
+}
+
+/* On driver unload, restore each captured CPU's firmware value. */
+static void cppc_cpufreq_restore_firmware_regs(void)
+{
+	unsigned int cpu, i;
+
+	for_each_present_cpu(cpu) {
+		for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+			struct cppc_saved_state *s =
+				&per_cpu(cppc_saved_state, cpu)[i];
+
+			if (s->firmware_captured && s->firmware_val != U64_MAX)
+				cppc_saved_regs[i].set(cpu, s->firmware_val);
+		}
+	}
+}
+
 /* Autonomous Selection boot parameter modes */
 enum {
 	AUTO_SEL_DISABLED = 0,
@@ -766,6 +934,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
+	/* Capture a CPU's firmware values on its first init, before any driver write. */
+	cppc_cpufreq_save_firmware_regs(policy);
+
 	/*
 	 * Enable autonomous mode on first init if boot param is set.
 	 * Check last_governor to detect first init and skip if auto_sel
@@ -812,7 +983,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			if (ret && ret != -EOPNOTSUPP)
 				pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
 			else if (!ret)
-				cpu_data->perf_ctrls.energy_perf = epp;
+				cppc_save_requested(cpu_data, cpu, CPPC_SAVED_EPP, epp);
 		}
 
 		/* Program min/max/desired into CPPC regs (non-fatal on failure). */
@@ -826,7 +997,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
 				cpu, ret);
 		else if (!ret)
-			cpu_data->perf_ctrls.auto_sel = true;
+			cppc_save_requested(cpu_data, cpu, CPPC_SAVED_AUTO_SEL, true);
 	}
 
 	if (cpu_data->perf_ctrls.auto_sel) {
@@ -850,6 +1021,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
+
+	/* Reapply any saved values lost across a full policy teardown. */
+	cppc_cpufreq_reapply_requested_regs(policy);
+
 	return 0;
 
 out:
@@ -1039,6 +1214,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 		}
 	}
 
+	cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_AUTO_SEL, val);
+
 	return count;
 }
 
@@ -1111,7 +1288,7 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	cpu_data->perf_ctrls.energy_perf = val;
+	cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_EPP, val);
 
 	return count;
 }
@@ -1193,6 +1370,9 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
 		}
 	}
 
+	for_each_cpu(sib, policy->cpus)
+		cppc_save_requested(cpu_data, sib, CPPC_SAVED_OSPM_NOMINAL_PERF, perf);
+
 	return count;
 
 rollback:
@@ -1258,13 +1438,11 @@ static int __init cppc_cpufreq_init(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	unsigned int cpu;
-
-	for_each_present_cpu(cpu)
-		cppc_set_auto_sel(cpu, false);
-
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
+
+	/* Restore auto_sel and the other saved registers to their firmware value. */
+	cppc_cpufreq_restore_firmware_regs();
 }
 
 module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
-- 
2.34.1

