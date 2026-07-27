Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28223D3314;
	Mon, 27 Jul 2026 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137011; cv=fail; b=XgdZQ19qYK4rHrgIuSR/h4oDxTeLKmRCYX4IowlboqIJ/yFw4PhtE2HrEdgmylckeKpJUGMWnQBxwvtnRYZVH5pwMr1IYobXB/HBxp4chxtVJ3eKmsQCrNI7T9jfMam0yzbdlro+bfS2t8SC6qO75Sl6ZEmzwWtTVDRXeKq+HQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137011; c=relaxed/simple;
	bh=vjIiP2+8T3QBZFp2GpVyvP9+9Th0TiROufOLh4m37hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmF3uJfrdNK+8GAaPi+iJu4DZDoPU7U4QMbb0qjfLBfsODsGgg6sKWTPTf7W9HHKWEMKSgMS8O9LqkgsvK1KgOSeyJz3pZFfvQDu2YbOFX5fqxrwOLQ4c3yNO3yS4ZLmeh2LSYJVjUeJjaPI5CKjf+2fLRe69BYZ9DJwd7/+ZAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vHZvzAli; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vHZvzAli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyTZQeB5DAHc17xsUDZ273gSsHwka7OsDdwypfDt/paKEpMH351nlp4uoBvlpymPhv01qOJMqin8ssoMoQ16+QvEM1QFb0KSKkkDLvXmA7wjvInHp6u97NXTGOykf/3fLBSMGX4uzmojkYKFC0H7ErbGdZfX76cAUgWe2+WmhPl5KusOH5EsI3XjTI8pTES1JLf/Ao0Y8A5Xo3QB4GA/V9bbUQZZ9n4S2JWNorNgl44ESFtL/b3l4h7iRti/LNur8bhQt+tmy1tx4R2etN/EU24THxwwYGTt/XVXakpyrT66Bt38CEZp4+Uzob9dgSLn+swe7+pgtTD0xaNGeHQlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3AG8eBk1QpQ+NohDOGk3m/FodoZaCDJtVIzqtCbcjE=;
 b=rvrTeZdn1/ZCgEt4yrvBpSCmC1JqfkIyA27zcYNhxgFAyQPpF3Ft1Yp6wws8zmftkVeN1iwxz8yPpSo5efabjmD4TrvmS4ZNBTYexCf/J+1P8GjudkDZWXL4Btte1z9vzOfvqnax+XCuN8GtAjc1jGKxBGN62YW1IEfhVUtGY6Kak+AdwxOqn+vnBXFL2y5PvJylPmivmODsJq20vVoIjagH39ORzKa0KwG98vXoN4UpFsWAKgKhcO2mbyUKKw/9yDl6fCm8VnyoQubUZ6LaEzCqWh/nju46ElYXBXoUzYmT/qZoIKHMkfkqgZhmQ5uMazBVvPp+Pe+TF7hHEMPo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3AG8eBk1QpQ+NohDOGk3m/FodoZaCDJtVIzqtCbcjE=;
 b=vHZvzAliDsc9s6YkTKf4HTlvpt3qIkAGFZOtlgrJZfbhXC7SltpVgDTgmaAPLXYVblV39maac5diH806j0b8SVUbbdonLzHRXQGJP6Rmrd8YY0SvO/Q3TVWH0RmK6hZ8KMHPMvuvQ85CBqO3YelXCCOezCLhL/s85ps4BNWB7Ns=
Received: from MN2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:208:1a0::34)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Mon, 27 Jul
 2026 07:23:23 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::20) by MN2PR07CA0024.outlook.office365.com
 (2603:10b6:208:1a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:23:22 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:23:18 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 7/9] cpufreq/amd-pstate: Reduce the scope of exported symbols
Date: Mon, 27 Jul 2026 07:20:54 +0000
Message-ID: <20260727072056.1248-8-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 97616451-5b7b-468d-ca09-08deebaff10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|56012099006|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NVrsUO45oQOGr5gaZ03COY2JC/zmG1AcYPC0ghGb+hydFfScYoCNTP3hWYSzQkDsvwuHluOkCBZEQGA2jnyZQ7Uw0TaeBynUqimVP5JSWYmSy32vG9jqXEOgjpkg8NbttBfxewsmL2lQEMC7pDscHJZLwmphoCl+AIZKTTg4Gef9DDUoMGR3H8HAUqfg3NwKA+jdkdKkQ89FKi3QlVdpXJ46h+lUNi+8gtW02SerNfRdZiK0qaP1gUPJyxFcEzA2ClXsghZGAnzMPlLq1qlDxi3Y14h+9YIWCxamcntMMdmosBnQquMsEgbIcE4Divw7NWFp6nxszOpyPKXnh8MocNVeJuCihDToQi4qBv02VWphWDnXiuD7650yPWT55MjoRAI3r9icPApjO4FgMp4xjlzUEk/UwJpHCClk36dAKcIuS9oH9EHGY5FQJE25KlreuyIhRQrH5jAXiuG5ca0+vVYC819rAPWICsP0ZN2g0VeIMEHaeZHYv+8yKAh7gdTo4/AqBR4ePb1NqwFSLiVQX/rlmSbLKj+Y+YKEOShwSjMi6PNCMuesA0uFJ1ZgtJTMW1KPRAGqZ20xLW+Ciqras6DbAfcA98Y14TEszr5fEuZHjHwNz7xBla+6UNSf9EoJyFPbs/HwvPwyGAV6ZdUzCRvL+77GS5UPOXVZlZdDp2epapKLOisaiPxgbW54eoetJTuwjK8twKWAXiSx2YJjHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mq1W+GmsOtBehio0aolDL70uSPj5bT9PMw+kIFX0PA2KLrHHXFfJbFp4aF5lOPxUYGD9TQOpTXM2N1kYm4Ge6KmJOmzc13iny1tcdGS/kb/Qj4uxNU5or/Xre3Pftm7gC61afUYMAg2Si4+9cZcTxf5klppwNKFwj6v/FyQ/qUxIaEZjgK4V/uTnqq81E+yKJZYk6h9L9oVW589Q6hPvGA+ANJg4vaLWzo89t98H3EbfxtUHaYa41NyJlpXcomrNmWKgBUQTxp/16AnAeqwvnsIV2sMsf3OMEA3MekOar0Scpuubfh+8tCvdYYYGUAVa4XB0cFYKqgYsKJTPJCWxeZG1OUax7dj4CJQpkVkAPrP+v2j1qAcImi/4WHIotG5pGCXJEHMqoDK5LipXpdIOsWoXyoGVrLMv7yRmBLt7etw/pmsuYzAb6HLHGH0tOD5s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:23:22.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97616451-5b7b-468d-ca09-08deebaff10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

Symbols exported by amd-pstate.c are ever only needed for amd-pstate-ut.
Introduce EXPORT_SYMBOL_FOR_PSTATE_UT() to export these symbols
selectively to "amd-pstate-ut" namespace as opposed to all GPL modules.

No functional changes intended.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o No changes.
---
 drivers/cpufreq/amd-pstate.c | 14 +++++++-------
 drivers/cpufreq/amd-pstate.h |  7 +++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a380c665461f..93d275da12c6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -75,7 +75,7 @@ const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
 		mode = AMD_PSTATE_UNDEFINED;
 	return amd_pstate_mode_string[mode];
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_mode_string);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_mode_string);
 
 struct quirk_entry {
 	u32 nominal_freq;
@@ -1272,7 +1272,7 @@ void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 	kfree(cpudata->profile_name);
 	cpudata->dynamic_epp = false;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_clear_dynamic_epp);
 
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
@@ -1469,7 +1469,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 
 	return count;
 }
-EXPORT_SYMBOL_GPL(store_energy_performance_preference);
+EXPORT_SYMBOL_FOR_PSTATE_UT(store_energy_performance_preference);
 
 ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
@@ -1503,7 +1503,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
-EXPORT_SYMBOL_GPL(show_energy_performance_preference);
+EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
 static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
 					   const char *buf, size_t count)
@@ -1603,7 +1603,7 @@ struct freq_attr **amd_pstate_get_current_attrs(void)
 		return NULL;
 	return current_pstate_driver->attr;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_current_attrs);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_current_attrs);
 
 static struct freq_attr **get_freq_attrs(void)
 {
@@ -1788,7 +1788,7 @@ int amd_pstate_get_status(void)
 {
 	return cppc_state;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_status);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_status);
 
 int amd_pstate_update_status(const char *buf, size_t size)
 {
@@ -1808,7 +1808,7 @@ int amd_pstate_update_status(const char *buf, size_t size)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_update_status);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_update_status);
 
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 23e8baa05849..edd697a5e29f 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -11,6 +11,13 @@
 #include <linux/pm_qos.h>
 #include <linux/platform_profile.h>
 
+#if IS_MODULE(CONFIG_X86_AMD_PSTATE_UT)
+#define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol) \
+	EXPORT_SYMBOL_FOR_MODULES(symbol, "amd-pstate-ut")
+#else
+#define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol)
+#endif
+
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
  *********************************************************************/
-- 
2.34.1

