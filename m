Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0633C183;
	Fri,  8 May 2026 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217590; cv=fail; b=OkHreki5cpxikLVe05e3k8Kqzy/IQ9XI9yghz0RPxbzLUrMDNtt8zF0g9yuFzwF6QYXpBiArCKJWhVCNIqr+QXvOjVLgZrF0menUqerhPaBTR+prM5zx2HF24Xh2DpEbdB9M7jbl6VnoEAripd1tlFfNnhTAhdsO/dKHxKydosw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217590; c=relaxed/simple;
	bh=dJIqznGqM+gnMXuVyyzrX7QS0qb+/J4ly8x3ec1JWKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbmeBDyqPbhv8ej2Ke7MBJd3ZvgVhUzWFG3jBq/ZdWyJJAVMNt25WwfJSWi4apnn7x/zD2hSA6Lm5eOzr600Sj1ZTSelPppgvJoNLQaQ7Cx5CmrgiyZiBoEV7sD88mlz7a4+5T+o9vDXmCeDIqx+rid5oOE8DAMdvVJDxXbhZ2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRXgB++K; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRXgB++K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM0qR5p1BuSmreT75iVn+V+BPERucpvak6JC2xldnkCxWoHQczyiNlVKeMUydw8WBLIJQwfzOpJqwKj/aO8HL+b9wd5L2QHR301ZkSUoXiHzPi7H2/PhzD8vV8CWPn0XrWoxfZAsOqjt2UoSRSCT30jTqs8aLwy0eVhh0M2GtD8zMOlio7E7WmRLq4//GShPJ+jt+0ybWk9QpDbGooTBVHfZPYR20Je6nBKsjJBE2AqvUc/DeBL+T9n8jBP+UxxvGKv6ygEU8hwNpt+Bavn63W60x00PhHW9ISz3oomBDpKME2zNqiar6k9KPKjBGizPhoCaODSIcWjnj/ZQa7SVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DNirSYPs3x1/vkTRnXBI7ucNRIpJXmG4BdUNqHklds=;
 b=qc6G4SCziBtR7EaPchrDeHglHN0IlPf7fQRxhBJLDP4v6ydMHvMozz1l73SKXM5lc6079m0ZI1Oz5G49gGaDE2xBpKcslCeLzWoQLgX2WCdOTdENxoa09A0Dm9GlIrTWyFcma4yvXQ/FW97J8PFVuh3uCaz8CWKrs7t9wAt6wCgEkEu/mWFgM3yhdwGvG2dcjZZYveSn6IXYKyg1CJk0sI50jVL/7/YxlEtF9ujUGZFPo2Xt5/hEGigBLqK1etpuYKaRIrgyecwIXubTSqG0KbcmBoP6snZh1nh9uB5kN0dj7zB1kHLNROLepog9ENruF0zYExtzmg2QZIHHV4Dxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DNirSYPs3x1/vkTRnXBI7ucNRIpJXmG4BdUNqHklds=;
 b=JRXgB++K6UFGAeC2nlFsfvY5Y6UUnrc6enHg5/v2YEFlYAYXcmdJ/FzI3pBLP609+Xpbv+ZPBDkqsxjuAlNJGfCCrLjuX8e9vVq1gDkfTZU+EGnDwK8IxSy505gJMxLCGwPaHxK2z6D3aJrKI5qVYKc/Cdp1Il9HYkK/dN9RSd4=
Received: from CH2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610::19) by
 CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.18; Fri, 8 May 2026 05:19:44 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::aa) by CH2PR05CA0006.outlook.office365.com
 (2603:10b6:610::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Fri, 8
 May 2026 05:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:19:44 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:19:40 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Kalpana Shetty <kalpana.shetty@amd.com>
Subject: [PATCH 6/6] cpufreq/amd-pstate-ut: Drop policy reference before driver switch
Date: Fri, 8 May 2026 05:17:48 +0000
Message-ID: <20260508051748.10484-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 503d21f9-59e4-4f98-1fda-08deacc16a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	q5u40o56zzNH3shddhYASpfRUr6cMvhWCABx0es3l7yz5ku8vf+NPiIH3JQ1C0oAcUvGDuib9AyxeqvY6yWBxQSmApiPlfIQCrCNPrS9qe5rXCgMM9+GssvolWAtelw82ZkUcY2aYDQNNMIX7Djcnr+soM6LHws4m+7RmI9OTZTpDNaU+WsDSX1ldc3TiNBKjHz/L8D7jTskTxMd0VUr2GmIMvb7FomFoPwecuY3rVZl57mR0skZWXEjqFB5Gl/PbTNbCKTGR7/v5h62M9lZ206OfQCoKW9R/bDghFRfy6PVVErA9q55l0qKYgCOa7nde0TYrg6JmaM9sKBZe+tEKkTxw9YdkMWSw8fm8hYMczIg0b88RVduT66WcQ0qL6bECTwxdngcQ9vXNX3wNmaJc3G6I5cHPpBJRxzpDk/n9u8Qp3fOQznmpdgafbz6WrsuvHVu7RMBdz56VM2G1c/mAtZDxlhzQwLwq5BZ79avWN+CLImFsOhONCZ8E5wbHXoxUWw1ikqv6z+f6ctRu0QH1dR5DTcuPd/yNi/8kG3OpB2zhIE9SiYLQ3HqktnESEi1elPIUgdwtKkzDYUWz5IcCdU7TjaCffa5bbJwbSu2apOwhY1ce3jakyju0QxCTJtfMr+fkD92HvWi7BdaxobH1HPfpg6JaZ8EEgXEjIamCYG9WfbjFg6WMA/yNEXzwyeo+TWp6hIUS5XvTt5y2apMxSnUAFT82w5KE2f7F7iqX4g=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3tQ++UxKrTPIJOtO9J5S/E9SF1HVz7tcZt8cAyqvJfjgpwdPUI+2yruLO9enEdYs53zOfBFRS4EMWnE4fjcVDF0Ci8JnQFXLIPleDutsnc10yZIIlMICsoP75OH/7RntlG8mx/3YIkYiz2qsUVjlMUgmBf6ZqBnO+BzX/P36Rnc2fFYHjTQa/6kZo+EBpVd6QjZmtQsyOEOTW0tadP+hBEJ/DkBydJIuevHTaY070LxScrLDDw/L3SfL0dkcyYBCevDQot2lYYMqv3KGalnHPOoH3XvQH+fUwCRJMfQpqRfAC7Ic8eMnQ6mNUoiTx7GqLaYskSAsO75rR7IXATiRGbBZP9dQZoC+IDyKuefMRKA+qO1aKHkG3IBnqrkDIvAAyA8/m7rQ6Q67JogPgfvQQzBMuj8RL11il5fEPCugBZH+w8fSJmGRZkFLKiGwlFZR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:19:44.0300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503d21f9-59e4-4f98-1fda-08deacc16a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585

Recent changes to the EPP unit test tries to perform a driver switch
with a cpufreq_policy reference held when the driver is loaded into
anything but the active mode which leads to a circular dependency and
the unit test hanging indefinitely.

Drop the reference before driver switch and grab it back once the driver
mode is stabilized for the test.

The EPP writes are only possible with CPUFREQ_POLICY_POWERSAVE policy.
Temporarily switch the cpudata->policy (while holding the write end of
the policy->rwsem) to CPUFREQ_POLICY_POWERSAVE and restore the original
policy once tests are done. To ensure the final EPP is correct in case
the driver started with CPUFREQ_POLICY_PERFORMANCE, EPP performance is
tested last.

The __free() based cleanup for cpufreq_policy is lost in the process.

Reported-by: Kalpana Shetty <kalpana.shetty@amd.com>
Fixes: 7e173bc310d2b ("cpufreq/amd-pstate-ut: Add a unit test for raw EPP")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 36 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index aa8a464fab47a..13a23dac477d1 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -274,20 +274,21 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 
 static int amd_pstate_ut_epp(u32 index)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
-	char *buf __free(cleanup_page) = NULL;
 	static const char * const epp_strings[] = {
-		"performance",
-		"balance_performance",
-		"balance_power",
 		"power",
+		"balance_power",
+		"balance_performance",
+		"performance",
 	};
-	struct amd_cpudata *cpudata;
+	char *buf __free(cleanup_page) = NULL;
+	struct cpufreq_policy *policy = NULL;
 	enum amd_pstate_mode orig_mode;
+	struct amd_cpudata *cpudata;
+	unsigned long orig_policy;
 	bool orig_dynamic_epp;
 	int ret, cpu = 0;
-	int i;
 	u16 epp;
+	int i;
 
 	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
@@ -297,6 +298,10 @@ static int amd_pstate_ut_epp(u32 index)
 	orig_mode = amd_pstate_get_status();
 	orig_dynamic_epp = cpudata->dynamic_epp;
 
+	/* Drop reference before potential driver change. */
+	cpufreq_cpu_put(policy);
+	policy = NULL;
+
 	/* disable dynamic EPP before running test */
 	if (cpudata->dynamic_epp) {
 		pr_debug("Dynamic EPP is enabled, disabling it\n");
@@ -311,6 +316,17 @@ static int amd_pstate_ut_epp(u32 index)
 	if (ret)
 		goto out;
 
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	down_write(&policy->rwsem);
+	cpudata = policy->driver_data;
+	orig_policy = cpudata->policy;
+	cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
+
 	for (epp = 0; epp <= U8_MAX; epp++) {
 		u8 val;
 
@@ -358,6 +374,12 @@ static int amd_pstate_ut_epp(u32 index)
 	ret = 0;
 
 out:
+	if (policy) {
+		cpudata->policy = orig_policy;
+		up_write(&policy->rwsem);
+		cpufreq_cpu_put(policy);
+	}
+
 	if (orig_dynamic_epp) {
 		int ret2;
 
-- 
2.34.1

