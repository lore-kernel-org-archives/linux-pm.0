Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073751B17C;
	Thu,  1 Oct 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864644; cv=fail; b=tmAj0s1jBivAtZY6fK34lLNJ1Zk/DDl/te56gV0mVUmr8s20T+CFN0XyATXTgQpcDCvQt9ZbXysbfi154LlbmehM5LoY6R7HxR3RpTq1QZdrPkcxekvspqp3SknhTMQLyIKkJ4JOLrce/CZZqOqNC0XOMzoVYvjrd5M0aQXV5Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864644; c=relaxed/simple;
	bh=52BBO73ma4JQKfvmrCVvjJaUskgSM1Lc4Y9Ofy8RGEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9nYzbFtiq3rPWJ3qCrohnLIXF3YRvUEUfp9B6jazVT4L7EvNJGfRgInoGw6VZ3DT6fJ9zSZPa+bN8u6M+oKTBUaPmjPXAYXhpFh9z86Ztw+PrQxFZgPi/fDcU31aAX7na7Xp38t1XmMMqkqB8n1KL7E8tzUhAe5vbJIe3Qwq2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dv2jq7Uv; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dv2jq7Uv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfBroRIPRLgKaafaNGlThJptEr2CjU/lfPX/7DbdnX+GD0kyRafwoXyA0W6AI8KmYtX9BasbHrX4846AQmCmFh9drkq4jGmZsxWaoRiJTvRBe76/FdKqevhqUL5GwZR0+luLyYp0ihxIGPRG34cugehNiehqxQfp3hxp3tA3A0833xGBhdj1cupiunggjAgGIecWvYBRch/pqYCDbSvsAz8pdjOaCtGkIuhVia+B6BfxVx7p5QZcEPv0d0J11X5SECqytRM0Pf+0pGciKqzzGRLb43sgAkNPA1dz6+W21K1ixXZD09sIo/GQ25Y4oYMR71/OiWIISAebI5z5SOXnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlkUPrnClLAPS5PR+zM5O4beX1c9baHPFuwxXSU41lw=;
 b=xETxzfaiNK5BgkbREZx6ellEPGieyywtyWIIz6qj+pwUgMrZjx+RJmKi+S/XAdh9M8p6mze220ZSHLOMDbQxWHLSTUss3FM35GaFBaXIW7pCNJLm3NA08/05rk43QV9NNoIgUv4mwRjdltaEZj53YLsxNY1TdCEF0Pm9BucUJuWXa5Peo96iOmQ+vW5MDo4ig6lCv5Z7B63bq/OO90yf4vmXq0D7xUEPdQ8jP8IrZwEU4mzKBDBDbcv3HKLesZGMTyWStFHqD8TdGCuQbDbqVzUIAGTVO6FfmwiRpbfqrTGVCVfw7iUV3Gv6XVRl0k7lCY84oBPhtuTI15KYSC6WeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlkUPrnClLAPS5PR+zM5O4beX1c9baHPFuwxXSU41lw=;
 b=Dv2jq7UvDPl4Fw34ZkRTHLtpyHlrrwYRTFVvxCDwXpT3+9NNykV/CmVcbLW0KbtJ1UNtQgmbKrHfKwf43orbfv2yFYnou18uo1OVFJBtOvob6FUnaeW7JUATHHb54YH2LUSeFdDYDMfR5Cepu3Hi4XkrC7O8LzlP7VR99bW7grQ=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by SACPR12MB803698.namprd12.prod.outlook.com (2603:10b6:806:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 14:23:54 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::24) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:23:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:23:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:23:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Prateek Nayak <KPrateek.Nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v4 3/3] cpufreq/amd-pstate: Get Highest Freq for a CPU
Date: Thu, 1 Oct 2026 09:23:41 -0500
Message-ID: <20261001142341.2934582-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001142341.2934582-1-mario.limonciello@amd.com>
References: <20261001142341.2934582-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SACPR12MB803698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf5f70f-7178-4ab8-48e0-08df1fc79f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l538GPXML54tZdCeXIWUvaSwksQrXHV3uOPxfvZCxxbdytsMP6V6ZhmpK5EEPduUiUAL0nPArSnxu88PTOk1ym0JciZ52hy58k5/S1XUOz9hkmoePM/+T/wBaCB7p4sfHu7dX//DJ81/I4GqFn9w0DToRMThw9uvsfDciJUDXnbNfMIWZBRRQmsblwP8o+r2RcDoHKjjHq0AdwZZdHykDEcIsLgEXCLux1/cYVTL/bFZyA24dXYlgAB/B7MfbWCaao4nt0R0322e5cToIORq/xmR4FtuheRjVGiYGCAYEPtyug7swnMbSMvryuwFO9hTDvBgF3wh67MZi36+0uGUBs8GJYDNi8SYyAEauWWWJqD9tmPr5dHjtddRhkBN/60nV8GnoA60zAb+KlKMSD0ja8zdnniMdU4IIZ0I4gCu/JgfaATce2FEJTaJqHtw6IOqqd5wY3Invo1e1efHvBAL9Db47sAuFqsLCyu3Gty2aJgCrVY7s/iCUsRJ5LppUi+NbFrHancA/sW7E17ZkTnvG0mfVr2BwyrHjDsaunPFoTei4/CiIF2ezyfhNSfktjGt5LHW1YxmKmNcMxABbeH2B3qjz55oYgNdMzChKUBwoo+jylLXl7e1ME/PtYUCAk0fCmIo1JDeuJCwvvEQ3Fgt7Nqh1x9aUSl3GCQRBZZEjB3gKCYHV+rt9AAx1hvl+VcK0zYR1EoGIiO/2rvWkT2ChA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/feitmW5HqhaovdMw3azLJw3MapH023ljc+pGe0/UERKogGsNzSv3kfIoNgtNSmADuhrGsXOm5sp523Q4jTptt0UihWTv+uUnnP9wWAUSY60on8D2X7w77TuG5zRmLVciRzd9qNeMzsJGa65vDsYd3iSJLHm/h414nfE+bMSkGrxZXMgptw9FAo0gKMlDmWwBhN10ilJYIOEEA3eJM9q9Ukw9kwLqcmeXaqLsevPc1xBj7e4VRGby67xBhSswqm+pR8Qkh2PfomCvIjVwvflBXuI2Sbpfy30kVci5rGEGJh6ZzkxNE/3iAF8+1c5fa7ZY8T8MgIPiMU5THr99DpGPNNjDXFFeIocw4MAlxxNKXY8u6yR6B+pxN6wjG0LAGBNp+/3czDgwn9OOc49cEzugCqhMn5p3EmPgX/kscqMFtZ8dbdoHh60VFedfVlMNBDd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:23:53.6684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf5f70f-7178-4ab8-48e0-08df1fc79f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB803698

If the highest frequency is known for a CPU, use this instead of
trying to calculate by linear interpolation.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * update amd_pstate_update_min_max_limit too (Christian)
---
 drivers/cpufreq/amd-pstate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9e8ef5548894c..d8e2eec6e7250 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -778,7 +778,10 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 
-	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
+	if (policy->max >= READ_ONCE(cpudata->max_freq))
+		perf.max_limit_perf = perf.highest_perf;
+	else
+		perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
 	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
@@ -1104,8 +1107,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
-	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
+	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
+	if (!max_freq)
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.55.0

