Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229004E66A2;
	Wed,  9 Sep 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949638; cv=fail; b=YM1V5wdRNG+0kraFD12aRa9UBQ7IEOlfXMBLzV++9fL5/tp/6qYftDkcTcqNiZjE8WGto0reAncaYmBHw/UO20RsrWT6K9c9UgIEXTp07QJG3o/DnOuChllpOGzKKlVTREYUD+Yslz32MCoA+huxnr1R56txIq+e3G2UtUXTPdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949638; c=relaxed/simple;
	bh=jlOR3HitH4mT3e51Kho37qXP5UHUz2FZSnQziFIffL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t7S+0NDsn9U9QPImhPIq+h/L3Ukzs/d1H7jMQcf4fOOgu0ECRXv8pYOmUs/KqgyvxwOLaK9Mv0wGdVHXaZRjkPGxzaoybYT1efbriVnwazsHryR2zO9AazRRToqbnmWdBBzaQ51ZIDpwcI7viFMHgq4/QjhMGuQ4Z62Uz5OH6TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X+jaYb3r; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X+jaYb3r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXhtb5rVX1+XfWaQF2jhv2VZp/XJEGX2FzOvCJRHQSTKoGGfQWMUfZyx5CCsdXr8vbk3oAAewVIiw+Uo0dwh7wFaZ/nNj4ev0eQw9+w8m2pYiDGtQ3AjLqUOjWO5iM8iNYGFVhIbHZlP29q4rCVPEbTYnUJ6FGV3oVQE9yv2q4deOqUbMYdAlSPoH/VyWeWR6fPy18nWVyGYgh/Ucj6RQgIzXDJlFw9RRG4wsSrM9iw2yQzUTm3I2kbEqrTQ6+U6IV5/87yttkQp10tzuqw2KVKrdjOz38p5WwGud1cgNefnHCDd+bqyS0WK8EWfNx49+aqpeQuAs5kPZnT9R7YdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVjPYUO0/HgVU0EGuXJlR5ZLmUAC/X1/vgYv8i8dMG0=;
 b=tR3FSG9+fXLTdgEJFmO+QXxCgJL8pxsRN9L4TOv2VflNJSA7UPik6cNj11XuGcImfoPOPTKpulwB7Q1kznXkq/PTJ6/5eLa95fk9QQWPAhadXqQ9H/lX3s1kG2RYBfBQ10/soWrNj5yJh/voFx602fXBcwyA5zwepZPjT7bLZGc5xy6hSI1mcuG3ECoLvHArp7k0Gxi1ILtJP2bVsK5ZX8sfDlRg9q/wYM+yzeC2LJFs3fpZhLNSwIn4jm2HwDCjUST3i2VA96dFHpwwUQIjLzyqKOnrnxOJxIN0BzHFG5PQIwBcN6xm9jTLTYIPrOCV5SakCYNm7SsUFJB+36GNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVjPYUO0/HgVU0EGuXJlR5ZLmUAC/X1/vgYv8i8dMG0=;
 b=X+jaYb3rn3m6qdhD4cD/K0Ajs9HWtOozYypwY9msFIowtAGNZybEli1/2/O+dcIgs1k43fi9p2OENz1HPNhKsI8Uof9vpswx6tA8S4r8i8yrxvFFK9g/k4Eqnw029vsEt6uiVyvDwLtJwjifeuOet/CofxG6wOa+bqkwvMikdFc=
Received: from SJ2P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::6)
 by LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:27:11 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:5db:cafe::2a) by SJ2P221CA0006.outlook.office365.com
 (2603:10b6:a03:5db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 10:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 10:27:10 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 05:27:06 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH] cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq failure with 'Requested CPU Min frequency' BIOS option
Date: Wed, 9 Sep 2026 10:26:50 +0000
Message-ID: <20260909102650.4582-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: cbddba2d-918d-4f53-ae80-08df0e5ce812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ojq4FJ04LXIzYKulCApCPE229MiQ/pZUGTpkCVTMlN+hQWTcc2hC/49C2ZmxwFUC/yMgbFoAC33OOTaj7iCDiyh+55Vc59z+iCFszkDlwdcOGuoYOmtjy9gVd1vroyecfCP7MwTz4D2CX/2CEknslhjYa3R7ezGgkgq6DasOm/1BTqsz+rOuuw4kan5in8P0A6bfD8u4/h3mTE2aPKd1ThHzvh30SIXfXFoiGmyrFKjmATijc+KnrWsrI6qE2Ank3vxm2Z3oDBuKV/25nmGUN3HkORj6ED8iTvtqQ9GONJs8fRpBNGri/v8m+E/mLZ9IWYytuhFD7T8VaL46xFKhlMTDTjfQw8yL7yXtPIXf5BFiMkeYNy/zk92xjnme9wmp+GI/VK8aW1L/NWEc1ckWxw7dpFcnXhvYT0PkQpXPYTW01fF2YuJa7bkl9BKXlUrGSqhQQMurFQYYZkHD5+y5LLjsP/TrglizHMpE0Rvpnj/oDqJJP21vmiB+rATargZCHREiPIvdTUZgxZa3O3aV/JgfqS/oQt9Cf+dIxOa1mfr8TZH3elIDCkzgjZKkS7ewGhPcpzRVAk7uKUrVBvf08Y1SH1CXk6KwDoBsC6+DPPcMKyMllSGvY2PXXszrj8hWV+l1D2v2g1ijvDYMrz8amQzrisuH1S63OU9/qCrEp2YXqP6G5eIj0mj7yS4MgW1rOZ5sHF+0KIqGZ/pK+z21iA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	59sWAXyVDOGVIcjLbvF4QQjffqbOS7Cea4jfrBEIEWYME5Db9rTNc8/VY/xytZHfHWudQ1zj2Y0EcePjUQ1MY+22x52ADehOnWv7rUS5900vY9sXQU5WGRlqUwJ4kxvnP3N7cWV1An3QATlniYF3ddRRqfC1o4jSQVOf0B71FTiPxw/cULvEnhjtH8b8l8eNZ27l/eSFQ2CLybG1XaZP7BIJMFb2r4BoQQ170cx+rDplENXuqbB6YNVGxneWbbu3WPl9MfofjyKa4THOyQ2gnyrARoyHKWcrDpAPGeoQbqtNl0M/cebPH3S0KmtjRfgko6NodgzXy1i1Jgv1sDtmbJybgiqpmPvmpHfEUNMRdxiHi+G1KlIkbWvhQaetQCFSEWU1N9bVepZFgBYVXzy1u/Eu5Xx+G76hbgQjuNZ/5vbXZNZ90J1s3jJqj36uDpAU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:27:10.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbddba2d-918d-4f53-ae80-08df0e5ce812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196

Since commit 608a76b65288 ("cpufreq/amd-pstate: Add support for the
"Requested CPU Min frequency" BIOS option"), amd-pstate driver sets
policy->min to frequency corresponding to bios_min_perf if a valid BIOS
programmed min frequency value is detected.

amd_pstate_ut_check_freq expects policy->min to always match
lowest_nonlinear_freq which does not hold true on platforms with user
configured BIOS min freq.

Update the test case to compare policy->min to bios_min_freq on
platforms that set it. Final comparison is adjusted to account for
insane values by clamping the result within the supported frequency
range.

While at it, move freq_to_perf() and perf_to_freq() helpers to internal
header to allow their use from amd-pstate-ut.

Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 23 ++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.c    | 13 -------------
 drivers/cpufreq/amd-pstate.h    | 14 ++++++++++++++
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index e23773680e05..c2c1a166b3a9 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,11 +226,14 @@ static int amd_pstate_ut_check_freq(u32 index)
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
 		struct amd_cpudata *cpudata;
+		union perf_cached perf;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			continue;
+
 		cpudata = policy->driver_data;
+		perf = READ_ONCE(cpudata->perf);
 
 		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
@@ -242,7 +245,25 @@ static int amd_pstate_ut_check_freq(u32 index)
 			return -EINVAL;
 		}
 
-		if (cpudata->lowest_nonlinear_freq != policy->min) {
+		if (perf.bios_min_perf) {
+			u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq,
+							 perf.bios_min_perf);
+
+			/*
+			 * User set bios_min_freq cannot be trusted to
+			 * be within the driver limits. Clamp it similar
+			 * to cpufreq_verify_within_cpu_limits().
+			 */
+			bios_min_freq = clamp_t(u32, bios_min_freq,
+						     policy->cpuinfo.min_freq,
+						     policy->cpuinfo.max_freq);
+
+			if (bios_min_freq != policy->min) {
+				pr_err("%s cpu%d bios_min_freq=%d policy_min=%d, they should be equal!\n",
+					__func__, cpu, bios_min_freq, policy->min);
+				return -EINVAL;
+			}
+		} else if (cpudata->lowest_nonlinear_freq != policy->min) {
 			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
 				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
 			return -EINVAL;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ea6cc072121f..a5daabc2edcd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -145,19 +145,6 @@ static struct quirk_entry quirk_amd_7k62 = {
 	.lowest_freq = 550,
 };
 
-static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
-{
-	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
-
-	return (u8)clamp(perf_val, perf.lowest_perf, perf.highest_perf);
-}
-
-static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
-{
-	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
-				perf.nominal_perf);
-}
-
 static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 {
 	/**
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 9f5a81976eae..578465187b7a 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -159,6 +159,20 @@ enum amd_pstate_mode {
 	AMD_PSTATE_GUIDED,
 	AMD_PSTATE_MAX,
 };
+
+static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
+{
+	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
+
+	return (u8)clamp(perf_val, perf.lowest_perf, perf.highest_perf);
+}
+
+static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
+{
+	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
+				perf.nominal_perf);
+}
+
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
 int amd_pstate_get_status(void);
 int amd_pstate_update_status(const char *buf, size_t size);

base-commit: d06c75c22d5c95ee27e01fedcaa07231c9bd5c88
-- 
2.34.1

