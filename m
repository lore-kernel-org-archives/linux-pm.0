Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AB39CCE5;
	Thu, 23 Jul 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837723; cv=fail; b=WT6ReG+N+NuUvoHEKYigcfvfC1fMzQY89+lPNbDN9fgmm4LLtv6bA7PatFmpSXCGT3cbOrbmtxzHi4Ff1u35gZq1uVRqI+6m+wcZ5LXsgWGE0sKOhcN1A+l+O8MtyliT2SXgbNokSQyYipi+2dK0uGz6DiECWXgjpQ3mS4uSUaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837723; c=relaxed/simple;
	bh=yxbasfheXPzjO7JsEqa9f7wCTXLzn4DQnKQ1Yixmt74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2FSlgG5avtk72cSNcUeD9mgcu2xx4Xx3P+WING1Iuuo3dv1050uzfGpjwUr7oS0qjj1KE7Llc8pg6stcMyULwFIZdHS3ACGUx7yPnu98ovHFaIfCqKi+wFXhP4+fnOU5lSXxx5Krz5O1e80bSAYGTPjFbXrCHGhCpGVQkJgjpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4dkWMzpT; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4dkWMzpT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuD1A9w+CH1f9Zi0wFObljJof+ZbdLxdO7rfYypKvTp7h48/gn4Dx2S/jtI//ziHDwzMAvDzpj6P8JMgPym5PKnqMtKx2tvObvy3CkyeptVdv3B4s6PsIz/U+B1vcRnhliFqMTEOTzUpZ6TqypXJSiqtxw4PUrrRlkUlbe9IWTU+Nf0LHlTCsUnQSYIzowWP6V0ILgryAusGJBdY6B21fnMh+oIJyR65hTgtWMTMAOqhsYUiqoEjteKMulW7A3mNDayCcw3MdhKqf8WRXFaedjQAQ/mknJgMSJjC0jKraHxI3g7siH2MKBUCbQQ/DcdJOr7/PM+svuh90ykCvfwCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn8GK/B6+HTnya5R3rxiymuYAg3D3IAZmKzZ+eQxOTc=;
 b=EK8SHwukDNxafNrxFhIPzUBoKRkNR9DWSmX/HX51LSQs6HEHsaGLprnF/9/v4A0UnyEvZjijQCH//hxoLPkw4WjGTMz/v7R93pkaUA7RNpYoHathkPsY9aYlcDVdWjNMq1CkV0pOK/rAfTh3EBWxU0TpfUjmzKcW5GWJWYgNEsazImLxCBnORjw8xUdy0iTz6pRoacgeB0/zGNpr5RWSCxeJ5dM8CuNDGDWmzdYcer1BRDQnxUNz3J8iNdZofHQJ9LC8sBcPCaRopv5FvVFJZrCtHfW0SLMB3f9x+cSCDgjmTjY534eOyacSg5A3HH/dP6ZNK4TBsme7BP5yXe7i4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn8GK/B6+HTnya5R3rxiymuYAg3D3IAZmKzZ+eQxOTc=;
 b=4dkWMzpTWuP4/oWhqpagDKHz61Mru7g8RVSx7huk8kaRqgXl9GJDLaDbESjiSnu+uNbFtfwHdOpCr5/+NlttRVBPhi54L+x3A246AMSZmj47M29ZlPOEzXe/ZdaLHoVtHCKYYXrFnfXmADKwfQiGD9LsB07r9MolMqb/f4Kqr4k=
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:15:00 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::2d) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:14:58 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:14:53 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/9] cpufreq/amd-pstate: Reduce the scope of exported symbols
Date: Thu, 23 Jul 2026 20:12:26 +0000
Message-ID: <20260723201228.22584-8-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f51880-3ce4-4b0d-4341-08dee8f71186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rjNjvbNX1XdSPNQZ7TcwTdvqev/r3LA7RjJGnqtbHTg7vfia8HZJs9HfPRDu79R/iRj28q53CXgYP0TFGBhBnazCDHizSsmy0AonQcqCcf/nrBzUa96CbScA3AGnRG8sjbiH3hAsLn05GnbPrBDXCuYkaBUoj92BvOWK724vxpt2usQog86RJ+KxRmp0s//WsMrPDBea2LFAu5lE8NwM9jnLsZxp2VKV3UH/Kr8DXSQaBQQpk7kUqY7Mkc/L6XyyGyzcA7WmN3duY825UksGYY3BaO2oDjt5NKu798VfhO7bqo9iG7iMRXEzlJ/K1PElL04RAgoj44aQl+UadCr0sFmROcTdAlXRaI7y21rvycFB32XjTgXVSQSVc7o5LNTscqXh8T2pGAIB8LMnSYYCvmeYLUchCg2Ycmzb/whusxVX1jwar5euKn9r0Y9f04ili5ZTtLSiqb7lJSWPOJlK9g/J4Qjzj3FGKftJR5h9lXpyhARIC6jCti3SuLrI7sCkWtDTBZ6kuZhqe5Pg6zR922W68b8puvuQ4cpuVGtRpstPrIoZjLT0oEth8ONtu+NZfzSoH9TbBl2AVzJnVJpmAOKWOSIc+9vla1QCIO3JBW0Q0zXfTEZqhTrj9nSvBR/xfQUmoFHpL4vd4j/5UhqYnEJg2E0x9scYJWmIajfEpb5Q3hpl63+TP5DUXBfMEK2r01atytmjXT18Nc8OZaxK/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dCclT3Vo3JM9KGqLFf9Igu6sw6r7RqUgOQFHbQqICzd8z1hc9Bd2KHD1QerMnB5BssTfRMN2THOv/DYfc8B59ysCx2qXd1BBtqrrNW+knEE6Nh9/Y2NRqur/kGR+Uqii61rQMyaO1c+Q2GVoj0iiwZf7EI0rpQ85h2WOvXqtTeEPkM7leS/e+iM/myCpNeEMf6LJJD9Y+lxLT3MJ+ptmbSie9Z48EFF7HMsWi3TsmVPL5ahg/O9OEsMgYbIAxkJB0/zby+2qufTGRzvurBGcLngXpH3tjMLEt7ROOIPHMOLg0YBwK9gdrTnIvoV2MPsPa/4UOOm1VhG+X+X01jZ1sF0ma5OmRIJVAVy7mfzZ1nuY1OpCMu7uUoBT5WqC3WlhXLN3tKwvo0bFcvampd6E9K4JN95QeRVkf6vKyNUt2uDSZ6bbjUmQ4JpvkIcri1Ag
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:14:58.0485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f51880-3ce4-4b0d-4341-08dee8f71186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

Symbols exported by amd-pstate.c are ever only needed for amd-pstate-ut.
Introduce EXPORT_SYMBOL_FOR_PSTATE_UT() to export these symbols
selectively to "amd-pstate-ut" namespace as opposed to all GPL modules.

No functional changes intended.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Collected tag from Mario. (Thanks a ton!)
---
 drivers/cpufreq/amd-pstate.c | 14 +++++++-------
 drivers/cpufreq/amd-pstate.h |  7 +++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 92da8937df04..b875e92103e1 100644
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
@@ -1271,7 +1271,7 @@ void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 	kfree(cpudata->profile_name);
 	cpudata->dynamic_epp = false;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_clear_dynamic_epp);
 
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
@@ -1466,7 +1466,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 
 	return count;
 }
-EXPORT_SYMBOL_GPL(store_energy_performance_preference);
+EXPORT_SYMBOL_FOR_PSTATE_UT(store_energy_performance_preference);
 
 ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
@@ -1500,7 +1500,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
-EXPORT_SYMBOL_GPL(show_energy_performance_preference);
+EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
 static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
 					   const char *buf, size_t count)
@@ -1600,7 +1600,7 @@ struct freq_attr **amd_pstate_get_current_attrs(void)
 		return NULL;
 	return current_pstate_driver->attr;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_current_attrs);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_current_attrs);
 
 static struct freq_attr **get_freq_attrs(void)
 {
@@ -1785,7 +1785,7 @@ int amd_pstate_get_status(void)
 {
 	return cppc_state;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_status);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_status);
 
 int amd_pstate_update_status(const char *buf, size_t size)
 {
@@ -1805,7 +1805,7 @@ int amd_pstate_update_status(const char *buf, size_t size)
 
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

