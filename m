Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A523F54BD;
	Tue, 30 Jun 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846236; cv=fail; b=NVc0OKnWzinFrMpvd7d771tja3gZDu8BmPLLffjXHKSsku1d2P4AWAR5jrLDIuhcrMT1p6R9o6Lq+pb8MobsRfzkaJSkHsm64x5qgxJ2FL8LkFuUSDiPAXob4D30THSKlHHPUmZgDPhfV16OafOs15Y7z7h1QdC+6A0+VyVBFAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846236; c=relaxed/simple;
	bh=fEqope7vYxBWJCa+h3oIDVgiUE1dOECTuYU6y0uO0E0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b70rYt0Q3CCVi5aR9JawgwK+eKzOfDtdSHlt02KP17tR4u3QoxTLpOZkAtevloEfjv5dXEY6N6KBG48r5XJ1y4I4M7tteMyo9GrcEAlmvbNgb66RdDZL74yiTZWzjdsFqK9DynJZQCUpZXOLpai6UcUynB9PH90UW6yh9/qnDvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvEKvo5T; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvEKvo5T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utHGBgmkLpemEyAfRkVb6kJ6cmCAAGTJp++Ldz4LkKLlMjA3wfTOmlQEB5MwTCipLPVVlg9dwm0QhUGJEsLvpaYsRgGpnidUQM1mBWnLkDPv3sv2h2V4un4TdAA+GpcgXylAWetpbkjGZXdcSqUJjvlF6aOoJj+IL6toiyfPFDFGtUl51ce6dBd3VVQjrQMcAfWZtcdSPXEtZaGDnvnvfvKEUaaaeuFOBxzK/eQ7eiIAIxfwdcIPgbOQMEp/29CVnUWQYSBgCDrP7M4Vi8vMv28jSnmAJqWqgpfDp0ijyd93uKsKAt6uP9QXWszLhNdT7nkaBX7kFKeStNPS1soTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPZE7RfUDivJcGGL53GLaJCzKgl6/jTGYeung5UgNg4=;
 b=JrKxt53y9aM6P7wQEDOPVNeBMUi9912KHvpITdYAjhneT1dK3K+RKSbc5LO9KwGqUhg9/SsM28Q8u9k62JfKvdyOkXU/CFoWPIwWeRXGgGTGkF9GnlTyABMv4cymvCDGJWxWZp2e50+TZbMLrLzJXp7UfbUvFSmzWw5I8R3LMmSrV/RtJO7MJLntqar2tW5Iw1mGtOYzsHTK5cmldd5ZWTNDMH5Dll+IgMUS+wYa/1ApYWyuDh616xRblg4QvPPMGofxZEx0h2DsPhs+7rKxow2NytDODngqtdpuj7256RBSM2fhM9BXstVvWOzayWuFimDSpp+fwYhe5c40Rm485Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPZE7RfUDivJcGGL53GLaJCzKgl6/jTGYeung5UgNg4=;
 b=jvEKvo5TLlN7f0sur8+Tgnpy1rtDl2CKyxZZ2uTcs2h718oPWXCxlaKk4E18Svdq887XD2cdO/wK2CnebK+z8fpoKO6bmwflcOFRzU3kVRcCgHjO8PBemC6o6y+kYMaBusZe9++Af0Hah95PXxPF017QaMJVkpRbB52y/YYK8Bg=
Received: from BN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:e4::10)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 19:03:41 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::16) by BN0PR02CA0005.outlook.office365.com
 (2603:10b6:408:e4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 19:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:03:32 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 14:03:29 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 5/6] cpufreq/amd-pstate: Reduce the scope of exported symbols
Date: Tue, 30 Jun 2026 19:03:03 +0000
Message-ID: <20260630190304.5671-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630185904.5602-1-kprateek.nayak@amd.com>
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: e1438abe-dc65-4d3b-a761-08ded6da479f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V5Sa2X+KFAA3EpWfhW2+MwxJXLopmiiPhma5UYXwV7vl2T3oRg+N1OjIMJu4DP0AicllL+QJrd1d5n0ajd2/5/yAy5Bp5JISnfoulKJFQ60m8Md5+SDCQmWi5HkQwW7ZMwFgYCC5XLHJWeNb4UTYlGZD8fRkLLXhLf/gJ3OVT1X6X1d8C6EYCgHAPuIhPCdFYvrDAGu7QovxTZS8I/xuQm9lT82+JhrnQ5yRXPF0ZaUtmlkoCE1jyVG0EmR9+cUIGuDLs32FPtF5ZGh3ZK9eWAtqLV6pEsM1V1VqZ0UtnAQuWITGfLRE86dPRcN9YmvKXpu8OoIfZq3IPRyDbChE5Dqed+lTM2lbHB1DMlVZboA8figfmPjWX0DVf8OvzKJJTdYRJrtE3CFXYQCAagPzPhkzbnnPDfQgrpjmjPZmm1Jt3t1gAcOzDTcbj+p2Nl8OSaf143Kb1+lWlL9hAcT4RmWVGtNbbqNQkFh6vLqH/2yZJW3ku8iw46uSD52kGlArT8bqPjH2u8zQTtyufBeCKc0jO/3W2pvhqx7CbJfeMukZ9yyChq7Qlg6o6bHH7W6nhxuqC0vV8DcjdwOoRkpICE9X5KWxPaR8hf6jYf3JSZCWjAeSeD7iDQeMQ3u7i6PzDWmFyR/y2JHlULPsZQDYixxLDH4bL8gFRMrY9Y+FOSncCP9JqECwlluOYyzK8MPeaASguHrRMRMyqvvGX9BdXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jRbjwQ+I5yQPjNfo7NHyjEzDmSCn+9KqXyKXREHPS/cXdHhgBRi2SXU+Tj4mPE8fVUwtVYW8LwCZ+KVct7tPvJsOBT+yDHl8sU4zkKphCD6bOC57W1u+lgVjjeAQawzdO0twBCDAiGZdNm3WafxXeyI+QTiGS3paxwnlolYxb7IXfeTo80x3cTnDe2GnkHfstEYkd0zfgGCFYSoLCsMw+d+iVgDC/jNdzd5zGPrgW7+xlHsvkcSbz/66yqtkIduKRXjdclaSPocVwz0W4uwt/MTwuSwyiiSm7EoAyjgEQSjimY+6B1cfYg8PEHOm3FhZAhuElN59MrP/y3XlpUifaR1dxnW9shiI7vcJcVzUHFfGtl5Jk7690DVvI2MJtbxTYID7tKmR+pmhDWCgXSsqSeHRazwHLbmV/gbQa5E2UURtISHLvoB2OEPGi3QAnG5H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:03:32.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1438abe-dc65-4d3b-a761-08ded6da479f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

Symbols exported by amd-pstate.c are ever only needed for amd-pstate-ut.
Introduce EXPORT_SYMBOL_FOR_PSTATE_UT() to export these symbols
selectively to "amd-pstate-ut" namespace as opposed to all GPL modules.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 14 +++++++-------
 drivers/cpufreq/amd-pstate.h |  7 +++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 61f30820d95a..44c03b0be219 100644
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
@@ -1266,7 +1266,7 @@ void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 	kfree(cpudata->profile_name);
 	cpudata->dynamic_epp = false;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_clear_dynamic_epp);
 
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
@@ -1472,7 +1472,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 
 	return count;
 }
-EXPORT_SYMBOL_GPL(store_energy_performance_preference);
+EXPORT_SYMBOL_FOR_PSTATE_UT(store_energy_performance_preference);
 
 ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
@@ -1506,7 +1506,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
-EXPORT_SYMBOL_GPL(show_energy_performance_preference);
+EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
 static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
 					   const char *buf, size_t count)
@@ -1606,7 +1606,7 @@ struct freq_attr **amd_pstate_get_current_attrs(void)
 		return NULL;
 	return current_pstate_driver->attr;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_current_attrs);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_current_attrs);
 
 static struct freq_attr **get_freq_attrs(void)
 {
@@ -1791,7 +1791,7 @@ int amd_pstate_get_status(void)
 {
 	return cppc_state;
 }
-EXPORT_SYMBOL_GPL(amd_pstate_get_status);
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_status);
 
 int amd_pstate_update_status(const char *buf, size_t size)
 {
@@ -1811,7 +1811,7 @@ int amd_pstate_update_status(const char *buf, size_t size)
 
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

