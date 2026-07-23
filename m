Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D345D19B;
	Thu, 23 Jul 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837745; cv=fail; b=S68qTyvnoQlP5TwlaHi4xllEx/oeBWhWrSC+Iqf1DSON0E4UBL2aP3TzHFUma7DJqEai4GDVqOOAayWsyvG2maNpP0VFH9ULLKOP3rrhlSMjfvvT91jB99kSPquNBFhZppDg6Z2N1GsG7rV+tfhpbIbUfBHUQ9dBKcr+Oh7j4Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837745; c=relaxed/simple;
	bh=MvZ9QQdrpvYAPEsw3DvvS2uYqVRSnx0HVu/Ul79W02g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg75vJ+UvpoDAA+rVuEq6oppPt/YyHfvIAZbOQgbIQBOY/IPMJpsys4i3s7EBhgf6RjBRIQw5Tc2nbAKctUH7oZuZyaQGwZk1phGWTK/IUEhSvS3U9xmwLZIcXJ4tlBnRVJ8HMGMchi+V7uEhG1FNXJY2lS364yzaEoXqg+rji8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=joY1PjCr; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="joY1PjCr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANAAABhwaOatmLHIhdOK1k7qhoHI2eo/RvXvNjeDejlSjNND2SCqWUYzHrxObE4K141xeqidsxOyAiy5qIs9r0gP31VjCOcLUgAlXmoJmeGayLGFDhzwzIFDcydcuez9yB70PzFP1N6DtF4d/bnxXgj5NlVBskQNUK2R43rXH4IhGrK738QGrptsXd4K/tJ6XodeXbZvmKUACiVHzHpvR0aQuVM9V0H8KtPB+1/zPCG/uNeqDDnROx8BlUhb4Tl69Lj3wRdH5ZZ4Vq72nAbtrYOBm14xGZiGPkd8N+SfcUctx4SmRT1xHlJml7AiGhkaheIKEe7iThTH1MvM/wgzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXJKrRuMVmyjc1IWYkg6BFYLov1A4RhLWwkAFnNjDfc=;
 b=ikSVvmJIBSiCUyUy+6pzQ0VM6HR2+xQexg5x7zyj6G/dNYEawzZFuw3U0nmxdRo07WjKF5iVKeSVV5JP26iY2rNmSfqfJnqY+2Qdr/4MRA9t5AsSa9EmgEid1SuIaSNRYOFY+LifZ+0riQcd2U5kYsK89kPjUKgh+B+n1w9rg4VjQZ73F1QcwkRbUMZXq8oibH5SB++hys/I2vP7CBaZtEdC7/QcYf1JgoeXQmciNQXTfOa8p+1D30BnPIyt2qfzXYAS9agoIR5JmRMB/50LoAQ3Msxda0LHrwvQv8+qbd0BLG6ZuTl1L3DDojVqwTMYaPpt/H8F4Cjg3PYc/lhHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJKrRuMVmyjc1IWYkg6BFYLov1A4RhLWwkAFnNjDfc=;
 b=joY1PjCrmfrLjWA1wc3g9nLin8p05paOHdwOQoQdi22V7ugY53uVet7ULGGDP+2pSAZ8Z1NRj8YjHCGxnpyFk2nQEChMGbO8i8vkfEXPpaljpU+bwLcfc+fKinqWRi+t+XCpAwETWALnUWwjVVADluBoWc0K4YoGWkC44QsbvxY=
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:15:17 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::98) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 20:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:15:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:15:11 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 8/9] cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
Date: Thu, 23 Jul 2026 20:12:27 +0000
Message-ID: <20260723201228.22584-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a3f268-33f3-4f0b-9d1e-08dee8f71bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/l6zry1oaiKvFvyMi3pXCO37z5By0dp1YOFRx+r3UsZ5CgZiW8F6MFDwpV7OP7/9R/I4O2uSwPqv1jEto3ETQw/+3Dxt8QHa9jNAnTholJ0t0SY3TzJZb+yhZKxy0F6FnBdjsHwdD3piZP8shE++LNa5Xes7FqEbK/RUsPGLZiiWsZuM7NPeAIF9vyF2tPHtZlx0UjhKzQq2sQOjlOsDafn+s+CvSMtgKyN1p65xbC+G4lfUOF4TgKtxMk8qe4tirxgEEElToXza80LIduWdJMimABZKkICFPhQC0qElhnwDbMoCAAyzBiX2hCARKMGP/pT/22I4PMqhAe7F61tEvioK1v2W4uOt8+zA3D8Y/80lK38CbpQVeCvY0mDXpXlPYw3gCLnftTXzFdCNgGwMJRjO3AetOXJiWKCVc9ioZQdmyXs/eXUeWL8ZYZ1SrPGi9tRzrc7rkR/PZjD94d3VT1lhx9LZO/iBWlXliYFKFEDI5JzbCYJ3f1cAJvscHeCOY2ZaEHa+1pWHkSBeOZQUtJoxr0rwgsZSc6WpyOz7g4PkalZrIl3xsDr9EqS2YhjhJT1L3aG3KHqykGSzDD+CCavJ0FcZvUL/G0eOv/W3Cl0ZcIZDGaVSXpPFeKr0t16X6A8FlkNQUW3cSc2eRpglV45/Wk7L2+L9tEJek43dr/jwpVbv3ykh3DUdZAQ57Pk+ByNAHpMNMKuloTWlqSRosQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6kB/Bbm/I3zD4Uunc60wTSFwQlYSIug22yRgQz3Pyru9phLAm5qxNOBfgDHHZvVLJLPQG2DAAGt0TGaksDhQrsWSNakt0u0aTKfT8MKZpE9EeldqkoBw59Eb7HrwuYiDHIsPc+ggiWV7lX5LvAjb0xoOCC6m9G6OYDCSjymmUZKAujRBrNK0ebvUJKjTpqTSyEmuaYUsRZVSsTesMi4RDi4hBB7jZEpIiM3yHzuXpdNnPm9cOYeY5uzpci0g3vYHZqL9q3FcLdjbvqFlrLIQ+e1cL8qQmMOgyIoEbcAQfGYQzFcnOW0HRtUKC45A/rqxP32aNwmv5WopBxcFoMdxxCm4iEZbrPOwGMz7NcLqUyjfw8DvPMeuvLBjFPMEJGLFHQr25jz64SY7xEbfyndp7nIYo7bkpQdDZKC0+wnodTwdx3xvVl90cTI1Ep9Vkyf2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:15:15.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a3f268-33f3-4f0b-9d1e-08dee8f71bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

Extend the EPP unit test to cover the "dynamic" epp mode. Since
"dynamic_epp" is no longer a system-wide toggle, remove the legacy
"dynamic_epp" bits from the unit test.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Simplified some aspect of test now that dynamic_epp global knob is
  removed.
---
 drivers/cpufreq/amd-pstate-ut.c | 45 ++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 2142838ad6cc..d1f730e3502b 100644
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
+		 * If the driver had enabled dynamic_epp to brgin with,
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

