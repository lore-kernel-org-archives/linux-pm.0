Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA535175A60;
	Mon, 27 Jul 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137025; cv=fail; b=TqQ2KawTEDrvAC6PtRPWFj51eO7fGpR5TJQ4gQeU1ZEthvF7M3iJlWmNskCBG7Pupi5t5rnR32N6IKCSmw38GHEBKoPsF3oY9B0XPb2zTzJH+337lMSWrzgrCOutYJ8LeicBxAWgWfmiRVUaNNMP+4uoX2kKuMPSL73bsnw9gU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137025; c=relaxed/simple;
	bh=xn5n0tfh3lisTHedkMLq1uSlr1nFWKRh/TR1P42WR9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsncwoffmC1pJwl1RY24VSocHicZ2rHVYl8BmCxBQpMaW95bXRdOLqT1t9i1tniESZ6IxAst9gu4TsbUSOjjizm5gJ/Gy3txKi6LU33vhT/Owz/EJsedUHEZ1TKv1hGyXlfvlXmFf93ARmqguld6N8V+WPla4DEkXo3uiqEwAEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NOFN9VF4; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NOFN9VF4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE+fnw+wsGt2bLdfLYiJS59cIbj5WzO5Kv1S16CIrbmTaf5R1QI9pH4QnGZp0XW+Nbyto9D9fNtoaAoj7yrIPEpmKY136YvNPMz/A6moR3n/lYD8lPsaJOWLluSZcQVnTE+y3RV4F36VCJol4lgUoNRgQNnlZquq49fq2rWo6LQ4tfTNSCFI9DS7WF8C1waLpJ5yXK8gludv5gUQodwiUKQWPhEYyi37VXPWu0wiGqGrW5Nl4FJP9tS70SW00bDvJbwFhsPvPtLfCPR6g+6LgQLU0lnIZS3SSDmOTzb4svJ3VF9/3jvKgCnyi7KX7MY80IEuFi2nSRkgMV+2bPbs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2p1nOiqoUIR717PBFuMpj9H6JZW0ZHzKzxK2lscUIw=;
 b=jTDprRqvOOyIEp6NMnoFEWaKMxQlV7AqIYjBXTpE/1ygzUSha4UF+PEo6OzWAUF2GV4O8t4MduEk2jgC5+ILj2MVBk44Dgqrtd5eIaEY+MfPF+Iy+oj9cUzgG6NZ9L9ZVa1zKKdNh7zWnuLU+GqMCo39bHlsKI8Tp4mzdzB+M3ehL9PD8nP8XVO8HLUN4xJl/dvUvClxfUQWcQQ7vM0gVXSqcOMEckbfTVUeiqo48YuxXEKjRTj/ywZH9lOmMEpxhxauOr+nw/beeLosTt8kygqXaWj9WH644djiJTik4HEeW8P5yjpwYCxtY4N+2wP2WKGhUduith6JJxYaQDSPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2p1nOiqoUIR717PBFuMpj9H6JZW0ZHzKzxK2lscUIw=;
 b=NOFN9VF4xrQSH5AIYA1KC/LoeI//mINXqR+kNPkj6Kgeh/tIa1KvvRe3u7GNlvBRuZfTeSyGrm9t3el9hwxoQDxdeg1Bxpui5pToBkAYt7v6wxZudTUFHDza2vM7cf6opLqvnOLt9pSEBft+GaML/fU6tYZK+x3sOoz90eSONn8=
Received: from BL1PR13CA0378.namprd13.prod.outlook.com (2603:10b6:208:2c0::23)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:23:40 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::4) by BL1PR13CA0378.outlook.office365.com
 (2603:10b6:208:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.7 via Frontend Transport; Mon, 27
 Jul 2026 07:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:23:40 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:23:36 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 8/9] cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
Date: Mon, 27 Jul 2026 07:20:55 +0000
Message-ID: <20260727072056.1248-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: b57347e2-b137-46ae-88f4-08deebaffb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hl0mLMI4EozB2efUj9K/y24xVO5XM5XBE+XjhFdjRhfPSdY111w1GHO3e6L++Zbl3BV+Avc9l0Cy5pDo/AcPbAMwi7kdCQTbtMeWsBRUCZjrzZmABogcqFl5yB6DsIjBVF5nUyo6xPzqmwxTqJHeJx9cE87Utv5Zzp+V5pWmTTY55vVBIYGsN44VUOfYg9H0G32P0rk/3XWCYpQ169tmNExQci45YWqAO34VHxnor5Z3uigtnyonpSqewgNPzE1HKbRh3gihJsOvmyFO1crvJUSMQLT5UIxKOKwO6wrWx37qAM2EzHDPaJ4mAlPp6kj32kTnIO556iVQc3z5J6oW2Z9LxHNrNksWCmGFi5hUzjGIlTXZSp8PR9ZHSLrroBGOacQnsvAqZXxsc/nCiHsi5SjDpPtZWyoYKfI6IVCmWO10eXSYWmjC7gOMG9OCxgKFgu8+H+VQshafvQBS9WLi70+PuURchjF21FP7OBjbqlv0j9rlP/qtjW7RQwU3kiyC705v5q5UAfDOWe9KrgWLk3jC5qhhrEf7FCc3+LWt/M3Si1ARfcEyp793XhFE0/ANcPhWmTBYRwM3q/7RyOuUyRxpBpesM3z/Q/V2hM8Fjk9e2HqXeW+lZJMgVdrLEgqT+ARD2rZ2u0Lqx1RDQEdwcg4uU+uRxlqJwVv+5SBMRk0eB92LO+0xPldmFoOJYybQ1ogLlzbB5sfZYk1NaedEjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fbdJLO+3KrtonKkY34xOa1mQEIucA3poSHxLbBDYSVDvkW+tHx3tOSCjvPBWaSt/T6lLIIC4TDQm1BumgTV8ia2//AqonHmpF93tAKcWmXFQIZ+3nbMPb3H0nkpCyP7TtO948xlX95i85vhdilNfBwpWamFzvg5lT5PkTrqQNNnyO4WGKPrybGFiVj4HhpnQ8byLuf7ygA5G2P2lLKWhBjdL7rKx6IITdu1n0AdjqTycopIEWWpTtaS96lZco8flyETLcDg//CKCyH47OVgEMttvLouxWNUNcy47keIfcZ4jYVudj8WoiQuZy5xh6LttpyZT1B/GhqKIS37/1q0scfX/xelPMKw0hqMb5ig8asZYOlWF3UF8Nm2NTGhzTTEsovbQNu9HRgP7bK6UhKCt77DZufBl9QiXbnHFGe/LqX9enORFWtxp56qWSafYVx6i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:23:40.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57347e2-b137-46ae-88f4-08deebaffb44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

Extend the EPP unit test to cover the "dynamic" epp mode. Since
"dynamic_epp" is no longer a system-wide toggle, remove the legacy
"dynamic_epp" bits from the unit test.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Collected tag from Mario. (Thanks a ton!)

o Fixed a typo in comment. (Mario)
---
 drivers/cpufreq/amd-pstate-ut.c | 45 ++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 2142838ad6cc..b432eae1dd52 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -275,6 +275,7 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 static int amd_pstate_ut_epp(u32 index)
 {
 	static const char * const epp_strings[] = {
+		"dynamic",
 		"power",
 		"balance_power",
 		"balance_performance",
@@ -282,10 +283,10 @@ static int amd_pstate_ut_epp(u32 index)
 	};
 	char *buf __free(cleanup_page) = NULL;
 	struct cpufreq_policy *policy = NULL;
+	unsigned long orig_dynamic_epp = 0;
 	enum amd_pstate_mode orig_mode;
 	struct amd_cpudata *cpudata;
 	unsigned long orig_policy;
-	bool orig_dynamic_epp;
 	int ret, cpu = 0;
 	u16 epp;
 	int i;
@@ -294,9 +295,11 @@ static int amd_pstate_ut_epp(u32 index)
 	if (!policy)
 		return -ENODEV;
 
-	cpudata = policy->driver_data;
 	orig_mode = amd_pstate_get_status();
-	orig_dynamic_epp = cpudata->dynamic_epp;
+	if (policy->driver_data) {
+		cpudata = policy->driver_data;
+		orig_dynamic_epp = cpudata->dynamic_epp;
+	}
 
 	/* Drop reference before potential driver change. */
 	cpufreq_cpu_put(policy);
@@ -321,16 +324,6 @@ static int amd_pstate_ut_epp(u32 index)
 	orig_policy = cpudata->policy;
 	cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	/*
-	 * Disable dynamic EPP before running test. If "orig_dynamic_epp" is
-	 * true, the  driver will do a redundant switch at the end and there
-	 * is no need for enabling it again at the end of the test.
-	 */
-	if (cpudata->dynamic_epp) {
-		pr_debug("Dynamic EPP is enabled, disabling it\n");
-		amd_pstate_clear_dynamic_epp(policy);
-	}
-
 	for (epp = 0; epp <= U8_MAX; epp++) {
 		u8 val;
 
@@ -367,6 +360,11 @@ static int amd_pstate_ut_epp(u32 index)
 		if (ret < 0)
 			goto out;
 		strreplace(buf, '\n', '\0');
+		/*
+		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
+		 * Trim at "(" and just compare tie the epp string.
+		 */
+		strreplace(buf, '(', '\0');
 
 		if (strcmp(buf, epp_strings[i])) {
 			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
@@ -380,18 +378,23 @@ static int amd_pstate_ut_epp(u32 index)
 out:
 	if (policy) {
 		cpudata->policy = orig_policy;
+		/*
+		 * If the driver had enabled dynamic_epp to begin with,
+		 * restore it here before dropping policy reference.
+		 */
+		if (orig_dynamic_epp) {
+			int ret2;
+
+			ret2 = store_energy_performance_preference(policy,
+								  epp_strings[0],
+								  strlen(epp_strings[0]));
+			if (!ret && (ret2 < 0))
+				ret = ret2;
+		}
 		up_write(&policy->rwsem);
 		cpufreq_cpu_put(policy);
 	}
 
-	if (orig_dynamic_epp) {
-		int ret2;
-
-		ret2 = amd_pstate_set_mode(AMD_PSTATE_DISABLE);
-		if (!ret && ret2)
-			ret = ret2;
-	}
-
 	if (orig_mode != amd_pstate_get_status()) {
 		int ret2;
 
-- 
2.34.1

