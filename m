Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970563F7A9D;
	Thu, 26 Mar 2026 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525730; cv=fail; b=Bo+EHSUr/rEHzSJOBXsx56yoWj18LCdzC9UtiCfyHZFxemceOofw9x7wiKMbgvuZ1Zt9mzmkcAoMtCXaAq0ik8i7WOfiNVEOsSRTyXt/nYPoEWUKR1SCLsKp0ibfqqVzLm2eXF6ruEAjDqixsKPb0WRVhBudiHh6Kr/QpmadDJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525730; c=relaxed/simple;
	bh=AdPC5EhGn4G92Oah0tIxPN846OETHYb0CqppcAJyX+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjYR3JNjtTSVNGIJcxKODf1befZdrZtmjYN3xG8Z5qpu3RgROXY+3JNdfrdKEBJJd8HbK7zLaJuofHMriXAGOchUCDRjgB2cILwd173S9bOXugwuA1DhMxpFYmXypvbpIUWCrp/eksC3KEX4ZgXL61I5a4zw2sj3X5WzTRuwVdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QVBVJ/Sy; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QVBVJ/Sy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daiLuGT6RXH4tfwEXfPmZ6Gzj8tfU0Ppe3fKwpm8TJnhZIrHKSdcG62MF/zfaFuTBis3uHmR1CRGEPGLmndKat96QhDV3Kqrx7HYa8gwK+N0Im3Z3MEeiGH8IBTy4VttH39ke343iDDQPU/0z+zUGWf4AST1HnOUduyNOPEWNVqq5xdM+biUYyrqasEXvTdhKYDWsDjDtCMosLHST9+wwNeCLY61OpQcMo3sh3z4/LLs/a9q1XysORYPVv0nCpy8+EGlGN4m7fMLWxIO+s7TKHm5kfjudbuGBAoln2J+sAjqbM98/qOP20yF/PzOfZOjcezZXbrf2cqdgdeOVfnUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh7yQfrmvkhSXOB3q2W7WQIyeXl+kQEcbg7yFLJ3xgw=;
 b=mTsW0b+tTm+9VtHsgJXzqXhMNTdvPjHQJGS2S84hkdTJb4BgPECm2DuNswUyItujmTnjuukvTRH5c2IrVpGn6sLU/RJBbZz0HXlqE7KkIgPjFdAO+VitCMEKlGl2mnR75Ta5PzFaUnC6a0qM6+x0ImIQOcpNRqTJVY6FSmMQ2l6niv1u/I3NZfXhC+PHAhdYtNiVrHAzCju0DB70dInZ7jrbx+MGfsvgNs5rcn/8oLNLOPb2PUfZESpCPg+fkRkuVRAHLr22e2BvvTwgKhFNMVnYzQaFx8SOf7+Vp6NmFnI+b6qAST+ylpcbV06cHjrlHYYygNdOgmYwHZzTCFFnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh7yQfrmvkhSXOB3q2W7WQIyeXl+kQEcbg7yFLJ3xgw=;
 b=QVBVJ/SyOj1tYHtDC27Ay3T/JOZrrd2WmwHTpgj21ApaYnCDWvBZMXMi3zOy5MQPmEm0/XzubdixlE+jvCtQTBC7Rmhe+JRzIiaeNkmw9IbEGJE9MM1klRb4meQaZOEikwhDqlcjsb9ZdYS/7BxmBs54/WD1wkwYKcxuja6BSsE=
Received: from DSSP221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::19) by
 CH1PPF6D0742E7B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::613) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 26 Mar
 2026 11:48:39 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:3d5:cafe::74) by DSSP221CA0002.outlook.office365.com
 (2603:10b6:8:3d5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:39 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:36 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v4 08/12] amd-pstate-ut: Add module parameter to select testcases
Date: Thu, 26 Mar 2026 17:17:52 +0530
Message-ID: <20260326114756.20374-9-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2657e7-bb84-4c10-c83f-08de8b2d9f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uopywrABx47LpRP8tSLEL3SpC29ncU4rJcdCtpdSTopCW1w5YGonaMH/SfOcGXp2NChPIZDrj0/xKWLwA7Dt9X9w5/SadwuMmQB6wY1QYzHjsQhTl9NKHJKbl3rRdlDKsKhVypvkZyQLvQFpW/SLjuNAO35ougwIwD4XmJXwcOZwH+m+PxgKC2DeoTQZOf+ZLIM5MI9qKg2EZwhZk7YFGszbFqb1Ll2r7HTiMNmQcP/NUL4VdtBb9t39YP0lwBDCWjRBYYSc2Is19PAPTWSqhO6oD2mHtcnqGf3nRWcTEphZSXI4oRrQvrpH+8KipB7qikgfiOiyZxFc+GmYG+64i/GGhKnHglgf+WTxldVsrOUM5IldEG37gT/pUMQtGLpuyjvNmUmAmoe1tDqFreA2Q7sRiUSxPIf3abNV2CRcAW/IC+a8AMyKzVgfEIBVL1IbDlcQc9ADzDlntUAwe9I1kwFeoibGQcSTSfzOEmsP3CZhxNTMyJhnSAmrDWkb6YjLBWFybhDgdI+sbwTjhEX4TEzlUeQMKpsSh0L+uLQ+MFbQhJr/ZXwpbdOKmBQGP4MCDc5+0VmcU2dLNgt3O0E+UALW82UiJ49rsy3CJyA+XRwVxUELtImtQZgv8war0HimDqde11kZnwxmwwzH6zqH0mtL4AGkSEX8NuanVDswpTTfyJPlftpDH/bIyhYlbKDyBIr/WUY7MQNqnVxqyXDNufIm8dpKTcQJC3QRSRqLK9oey3hWuXU0b9KOHCdWqw1BuudEtQ8o32yVSucEXWcIgw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hyVh03tmZfPD+96UrfUNUgZ23fM1+qVfRFlAGHiobO3G9b0lGcjOrjBAdZFScVNUCj6taLzWpK6dQmcPADb65OrVvFKC+lyGDLQXSZomEzk8Nn4CcIWWD9w3mUMaz6r3N0MaGMMBHUbnk31uKUhDqQB55qvsN2ddHkuhHsflq8eHDpabCJ3InjEWd/dm/z2ZMjx+EXGsN55H4lHPufzWNJ3OiiHSLTs0HVI62yh8imBEnimVYqq1kY1hd7bLeJTkTki5Q4EYP2yGuveaCI0ozg+20pSQbn/VdlSFJXORfrCaSNcO1fC1nzCuoZhvlb2korRq4DKdhOJZJDt3YpsqoeVqkthtBvWNX1+FG92t8zv+dXR4qxX+C523hXZ7sjBlbhz6EohvxfOn5sKqpiOcQJtQtKQK2P6S+zX88y8lQNIq0WGn6QNL81DqVwNoMkCH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:39.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2657e7-bb84-4c10-c83f-08de8b2d9f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

Currently when amd-pstate-ut test module is loaded, it runs all the
tests from amd_pstate_ut_cases[] array.

Add a module parameter named "test_list" that accepts a
comma-delimited list of test names, allowing users to run a
selected subset of tests. When the parameter is omitted or empty, all
tests are run as before.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 447b9aa5ce40..3dcdf56883a6 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -35,6 +35,10 @@
 
 #include "amd-pstate.h"
 
+static char *test_list;
+module_param(test_list, charp, 0444);
+MODULE_PARM_DESC(test_list,
+	"Comma-delimited list of tests to run (empty means run all tests)");
 
 struct amd_pstate_ut_struct {
 	const char *name;
@@ -58,6 +62,25 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
 };
 
+static bool test_in_list(const char *list, const char *name)
+{
+	size_t name_len = strlen(name);
+	const char *p = list;
+
+	while (*p) {
+		const char *sep = strchr(p, ',');
+		size_t token_len = sep ? sep - p : strlen(p);
+
+		if (token_len == name_len && !strncmp(p, name, token_len))
+			return true;
+		if (!sep)
+			break;
+		p = sep + 1;
+	}
+
+	return false;
+}
+
 static bool get_shared_mem(void)
 {
 	bool result = false;
@@ -275,7 +298,13 @@ static int __init amd_pstate_ut_init(void)
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
 
 	for (i = 0; i < arr_size; i++) {
-		int ret = amd_pstate_ut_cases[i].func(i);
+		int ret;
+
+		if (test_list && *test_list &&
+		    !test_in_list(test_list, amd_pstate_ut_cases[i].name))
+			continue;
+
+		ret = amd_pstate_ut_cases[i].func(i);
 
 		if (ret)
 			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);
-- 
2.34.1

