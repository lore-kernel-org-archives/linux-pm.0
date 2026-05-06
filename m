Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023092.outbound.protection.outlook.com [52.101.127.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B013431EF
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061213; cv=fail; b=XCCnAnHN4l7z7e3h7FMDzVgrA9Wi3Gt0qmdRFyn+RORWBOFLwhLFaSzL+/mj7WbZnYZn8Kvl9YYrs6PjY+wsbnmDoip2TODrRohQaDlsevGY6mh954Fqfs/vyCh9YjVQWtheT/9UpFATio4/3I1eus8NTcgyeEIc/w9+XQihjb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061213; c=relaxed/simple;
	bh=uSTVe5G+6OjwImO11/cdvBwzaMv5xUDT/t59CTGu3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNhdpZlFri4Gc50QJffIgIkkUEHicruJ0273BVGtW9An1dWXkkKkPKWS9Bo4Zif14RCg3yTx5jLeajdhHUvdgAkLY+DBeqbgx1N6zVONafWZZv10vv0JPrwkKQB7ayBJx/um7hXPOrlziyDE4PqbJzB+WrzIE/bipiMrVo9ZSpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=lGod/fT0; arc=fail smtp.client-ip=52.101.127.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="lGod/fT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYQq/seu0vc5a9ReVcOyE8frpXsvSNgUJn2QlaVTGSOAXBEPf8/2QhsADI4Z4om2Y/+M/3WISs77VwDclyeCKVP1naUC7LSBDtXedHc2TINxFClLMEpJErJ+adtwRElwlaE4athH1O0BjgP2DOPIriVLwBbagDI8aZNa94k0wldSyVN6hTEov03Tlg9Anyo0o1WZB9G2TOLasJj4GMwwEiy2kUVdOMQ//OuXMKLdZDDyXW4LOvQ4ISU6JNJ0IWGj0h92+tsHoyaCX14v0VskbRPgJmqe7vsVyhOKB/QqsCq618LUkRP/19IhEoQ/FNyrjcywY6aZR+0UaIIfqA9cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sgxsYDXSSSc0Q0Rm+yG1b1RC4CwBMyliF66JSCeBa8=;
 b=r+00uC8Q8b4uevo4MMTyEs77MUYOTEPFAQ6xh2nEVCRIxnb20Cq5LjYv268xut4YE10YIEHLL4suCh0kPDpVkVmNFW0FMci6nOBXrwJag/r1tZ5cIFJU4v/BrnoHgw0ZJrjesuQl+NGliQj8YkqK9Ys6yQu4qBQziI/nc767r+9D61172X10TzTIiaBBm0tHic/yFJZwphT7zRJD2xGbYgNR7vSoVhjRKCVy8G5n3x9M8Sja8Av6tHqMT4WqDZEuSn8y8I2NJjWsfOkJkl2HmbRc9Ao+L0YHLGBglOZOn4MlmWkpHKHTmFoo50a71cI49Oyv5xUUsMB0c/ctyg0IyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sgxsYDXSSSc0Q0Rm+yG1b1RC4CwBMyliF66JSCeBa8=;
 b=lGod/fT03/LqSC+IxQ6ZppUNTYaqRaEt5WBp5z9eUJoNWTXdKweSa/PuGNRCicr7Lmz/bg16ZdD/7kdjd4XCKGaTP1C0WhryzetEdCJ8p+fLJ1xUxPG9mOSYyaesdMP5gEggBorjOSuk983mU8b4zqJkHgV8yWTJ7BjnWjEBv9D7b5qE+nDCP0fjVB4Y1uS0fe/EzvvqA8CaqgR+nXu7/9EOfIQZmi7NUiKdEKznBsWSFVMDqlLixEb7mYvqPdqEy3O8kk57l18+rOH5jxmnrTXJtqZ7ieR5fozoBYyqPVPLbtCsGucF9lpO7SbWLddAR97u043kM2zfRouZKe0d0A==
Received: from SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8) by
 KL1PR04MB6980.apcprd04.prod.outlook.com (2603:1096:820:d6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 09:53:24 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:c6:cafe::53) by SG2P153CA0039.outlook.office365.com
 (2603:1096:4:c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Wed, 6
 May 2026 09:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Wed, 6 May 2026 09:53:24 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id 5D9BE2732;
	Wed,  6 May 2026 17:53:23 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH] cpufreq: intel_pstate: Use CPPC to get scaling factor for Bartlett Lake
Date: Wed,  6 May 2026 17:51:56 +0800
Message-ID: <20260506095157.1591221-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR04MB6980:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c9e3a65d-44fa-48f2-454f-08deab555060
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	yKY1Y0t6OQvR7x3SyPHUF5jV/TdM7q8ARDrkCQqLT80dIgpkPUbUEyv7f9YyVuwYuORN23lr5RC//1+x2K3FE+m5ZXQZ6NSnLKggGpD33EOtildlrPK+60RAj8aiiy8wGqeNZQ36NakPPoyoroxPBhErnlOcBb1FOCoGuJrDCZNIiqW+U+9tr83qZHPjIQJqfWb1IkpIIifeZX/QxfTuhVjtqksFzCtZJptA4/rYygrPB/Jrr8Rms9jeyeuNBwk69dAY8HUZb67eLwO4ZUo39E6ug3MN0PgihQ3aL2RybaTyS9/DD9diZ4fl6tYk+1G4Mhr7WWS/qOVrCmdzcSoAdlAlGCi18dSawVtbgEiQbKtHwGWOcAwlQlJVoU5OIWx5aWVj+A39jJJqt4bAN8WsUmMz3zSNjd595YXfO9zE66AVTdg1jCa2gdLzJNeAyzm+LSYft3O970J7P3vTO9UG9k5rasoiBq1NzFDFZnVliQtG5F5Fp7MydsJQliI768kWrkTnzZN4BQY1zn8qja5QXRoh0JtdTMGuE50rc8p/2xshMJ/kpMX2W+0y4khox5+12uZwqeJwz/fjOVhisVfszQc+Ehk83or1KIUAE8kgug/myh4jbgNrW2C6uzv9oCK/Brr6VWrUsHgjc+rvQA8v+h6oRDLwRaTQUGTja3vsJtwVVLsdpNEbhWEPhdkHrm3mMC5OiVldtl3Or1FZWtxNK28URMEiU4OtEAaX+8ojzSg=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E6G3iHSh6UvOXB1/FRtGM7gJTQtqG9TsI9GwRqnyELgfEW/3V+1DT6SlcfyCBzsUTkCYs2JcInEBa3/BxZshHlrt0Jf2Ms0HLd0HS0ci/9A34saw4ku+53j634+Fz37sBq6VXrKMfj7sbfr587zJvGmD27UEwQexblUwWIbcy5zC1xi6C55ebanyD0t9tvqpva90L1fhkC6i4Ei006si82+DiRuudp3C+kKCJ5ZpEe5YAYjvgDMlJL2byEuithJnUyj4DD4ngvQ+cvLlHgI/lTmZNfF6SLebNRp9SEKbKH5lK5yOBQWj6btV5NIrhaCHeYQx2ZSCEen94DonqIXGRfzpUIshFMPEoj2dxq3L90ZjD7lecYofu8aWLpaRTrT5n9k4wUhgL34cDFyrNb9BGh0l7mS0N+z1hmFuluFplzUhIUx5jOWH7w8imaUdtWhe
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:53:24.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e3a65d-44fa-48f2-454f-08deab555060
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6980

Previously, hwp_get_cpu_scaling() returned INTEL_PSTATE_CORE_SCALING
(100000) as the scaling factor for non-hybrid CPUs.  However, this
value is too large for Bartlett Lake processors, where HWP
performance levels do not map 1:1 to PERF_CTL P-state ratios.

Per the Intel datasheet [1], the Intel Core 9 273PE specifies:

  Performance-cores:                                 12
  Efficient-cores:                                   0
  Max Turbo Frequency:                               5.7 GHz
  Intel Thermal Velocity Boost Frequency:            5.7 GHz
  Intel Turbo Boost Max Technology 3.0 Frequency:    5.6 GHz
  Performance-core Max Turbo Frequency:              5.4 GHz
  Performance-core Base Frequency:                   2.3 GHz

Because this CPU has no E-cores and does not report
X86_FEATURE_HYBRID_CPU, hwp_get_cpu_scaling() returns 100000.  In
intel_pstate_get_cpu_pstates(), the condition
cpu->pstate.scaling == perf_ctl_scaling then takes the early path
that simply multiplies HWP performance levels by 100000, producing
cpuinfo_max_freq values that exceed the documented maximum turbo
frequency:

  intel_pstate: CPU0: PERF_CTL turbo = 57
  intel_pstate: CPU0: HWP_CAP guaranteed = 30
  intel_pstate: CPU0: HWP_CAP highest = 70
  intel_pstate: CPU0: HWP-to-frequency scaling factor: 100000
  intel_pstate: set_policy cpuinfo.max 7000000 policy->max 7000000
  ...
  intel_pstate: CPU12: HWP_CAP highest = 73
  intel_pstate: CPU12: HWP-to-frequency scaling factor: 100000
  intel_pstate: set_policy cpuinfo.max 7300000 policy->max 7300000

To avoid impacting traditional non-hybrid CPUs, introduce a new
intel_cppc_scaling_ids[] table that lists non-hybrid CPU models
requiring dynamic scaling factor computation via CPPC.  CPUs in
this list call intel_pstate_cppc_get_scaling() instead of
core_get_scaling().

Because the scaling factor is now obtained from CPPC,
intel_pstate_hybrid_hwp_adjust() no longer takes the early return
on these CPUs.  To prevent hwp_is_hybrid from being set incorrectly
on non-hybrid systems (which would enable asymmetric capacity
scaling and disable ITMT), guard the assignment with
X86_FEATURE_HYBRID_CPU.

Since intel_pstate_hybrid_hwp_adjust() now also handles non-hybrid
processors, rename it to intel_pstate_hwp_adjust() and update the
kerneldoc and inline comments accordingly.

After this patch (Intel Core 9 273PE):

  intel_pstate: CPU0: PERF_CTL turbo = 57
  intel_pstate: CPU0: HWP_CAP guaranteed = 30
  intel_pstate: CPU0: HWP_CAP highest = 70
  intel_pstate: CPU0: HWP-to-frequency scaling factor: 79310
  intel_pstate: set_policy cpuinfo.max 5500000 policy->max 5500000
  ...
  intel_pstate: CPU12: HWP_CAP highest = 73
  intel_pstate: CPU12: HWP-to-frequency scaling factor: 79310
  intel_pstate: set_policy cpuinfo.max 5700000 policy->max 5700000

The scaling factor 79310 is computed from CPPC
nominal_freq=2300 MHz and nominal_perf=29.

The resulting sysfs values are:

  $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_max_freq
  5500000  (20 CPUs with HWP_CAP highest = 70)
  5700000  ( 4 CPUs with HWP_CAP highest = 73)
  $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
  5500000
  5700000

The reported maximum turbo frequency now matches the datasheet's
Max Turbo Frequency of 5.7 GHz.

[1] https://www.intel.com/content/www/us/en/products/sku/245717/intel-core-9-processor-273pe-36m-cache-up-to-5-70-ghz/specifications.html

Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
 drivers/cpufreq/intel_pstate.c | 37 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..4d3dbea19eb7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -557,17 +557,17 @@ static int intel_pstate_freq_to_hwp(struct cpudata *cpu, int freq)
 }
 
 /**
- * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
+ * intel_pstate_hwp_adjust - Calibrate HWP performance levels.
  * @cpu: Target CPU.
  *
- * On hybrid processors, HWP may expose more performance levels than there are
+ * On some processors, HWP may expose more performance levels than there are
  * P-states accessible through the PERF_CTL interface.  If that happens, the
  * scaling factor between HWP performance levels and CPU frequency will be less
  * than the scaling factor between P-state values and CPU frequency.
  *
  * In that case, adjust the CPU parameters used in computations accordingly.
  */
-static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
+static void intel_pstate_hwp_adjust(struct cpudata *cpu)
 {
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
@@ -585,7 +585,8 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	if (scaling == perf_ctl_scaling)
 		return;
 
-	hwp_is_hybrid = true;
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		hwp_is_hybrid = true;
 
 	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
 					   perf_ctl_scaling);
@@ -1815,6 +1816,7 @@ static const struct attribute_group intel_pstate_attr_group = {
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
+static const struct x86_cpu_id intel_cppc_scaling_ids[];
 
 static struct kobject *intel_pstate_kobject;
 
@@ -2285,15 +2287,16 @@ static int hwp_get_cpu_scaling(int cpu)
 		return core_get_scaling();
 	}
 
-	/* Use core scaling on non-hybrid systems. */
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return core_get_scaling();
-
 	/*
-	 * The system is hybrid, but the hybrid scaling factor is not known or
-	 * the CPU type is not one of the above, so use CPPC to compute the
-	 * scaling factor for this CPU.
+	 * Use core scaling on non-hybrid systems, except for those whose
+	 * perf-to-frequency scaling factor differs from the default
+	 * (e.g. Bartlett Lake) and must be computed via CPPC.
 	 */
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) &&
+	    !x86_match_cpu(intel_cppc_scaling_ids))
+		return core_get_scaling();
+
+	/* Compute the scaling factor via CPPC. */
 	return intel_pstate_cppc_get_scaling(cpu);
 }
 
@@ -2328,7 +2331,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
-			intel_pstate_hybrid_hwp_adjust(cpu);
+			intel_pstate_hwp_adjust(cpu);
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
@@ -3739,6 +3742,16 @@ static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	{}
 };
 
+/*
+ * Non-hybrid CPUs whose perf-to-frequency scaling factor differs from
+ * INTEL_PSTATE_CORE_SCALING. For these, compute the scaling factor
+ * dynamically via CPPC.
+ */
+static const struct x86_cpu_id intel_cppc_scaling_ids[] = {
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE, NULL),
+	{}
+};
+
 static bool hwp_check_epp(void)
 {
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
-- 
2.43.0

