Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D593CA4AE;
	Fri, 20 Mar 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017861; cv=fail; b=m2pd4NwnwL5HzKPkwCP/oElcO2LAynrgBQx5l1v8epE+BuH2oYWaUTJqn3FnfdG5Zy2nN7TlFWe1bNaDm48409rKx8MESPtTn4A8Lbzn/PF0huwktVo7Mk0xGoAAC5BcUEV5YG8r9ITDV7XMisjhXCJcyzv6Ev7B0IzqLpwPFhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017861; c=relaxed/simple;
	bh=G+2Sp8WObcb5ar3R7D+/3J5mXp0iR7DauHYYExZ+9Lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEatVZ5v6Kh0U91TPbzPjELtFon/S7kO9zIgiaoKsLIKJK4t8EF0CLRDPTFoLSu0jY3aXEqC2KqwX47ujTF3RrLYa2z5ZYvXGEgYyyQzF7DNndnjHnE75U0vOKLyVQqV/2aFf4eSXsfts2LjizTZpAxiVTDB0Xhs95i93CTezAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v7qlunxy; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v7qlunxy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5yXY5vU/8ct6ptkDD3fflhzyyTzZx7TdSrFgR95vg6dUfGlnol4mJ5LrYRWcoCfEn6rCNL5JornybAU3yN57OoE0OM20UiWb3VuHz4Dmn1dA2zEpqHRXCoP2dedy8CwgKcSrmFHfC95xwhsNKVtEQDxxxMvZc3YmODzdA6nD8PFZvk8W6LkC3KYl644VFtxfSZ1YPZ4CwY1+NEN07XmR9MfGDitVnfN6Z1MTXbtTPG6z+dT+kGTJGYJAg80Dld27o7Chn4Lv+AIE/KtGYl1n/U8IH9qGJNAG7YnMnHBoKxJAQhbwBYJ5AUV08Exy/ADNKz2Tot93eXmm52w48QeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH0jD2iYPWBP9d/fzhPBnYagkMp3Mp1gjTdGMhLMRv4=;
 b=DXatqD9ce2mYc+hUOxR8xKNhwwiBR0pHBJ3pHt5nJqLia3/fj30kWmaFwoeBiop02A+rTRUM0dCz8FWuZnJMgibcpDEJ8qmxMFGEK3gFg7rk2/4MEw3a3T7KJjRPlzOCNSA17TPlg5aPlceba5mtfwsoaI34Vlh6HpBkOLBE66xtOcwNbDFIoVHXwJA+8MRDmPGmiKsRiJz+HWsTWgSvAb8iG8wEwFqWqBeJ2e/+T66TNP+lz6ErY5MqXiXOxMVly9fwdUpuIBYDa7u63ZAQM6o9ppl/h8NJb3e6M64ZI14Gt6j6KkP2crEliTfAkAJwogyMY7PuuJ3tyEDtubFhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH0jD2iYPWBP9d/fzhPBnYagkMp3Mp1gjTdGMhLMRv4=;
 b=v7qlunxyk0AoodSUqrNdcqx7KHjEnbJEkCbrjnNejgGREfWQ7H06oZj72hJol76APN1R/ZmKy59IUWmI5pWnAneOarBwhuVYGmzZ9y+tLvP1kIWoh5T95tVWXyn9wvlrwkhhmrQkhkg2OuRsAIBYAmXCTSHCSuIiNmir6OJQrW4=
Received: from MN2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:208:178::40)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.12; Fri, 20 Mar 2026 14:44:16 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::93) by MN2PR19CA0027.outlook.office365.com
 (2603:10b6:208:178::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:16 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:13 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single testcase
Date: Fri, 20 Mar 2026 20:13:17 +0530
Message-ID: <20260320144321.18543-9-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d9cb6f-e2b3-45db-6120-08de868f290d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MYf24Dbf8/2NFWQxiuPoEtB8CwU1QM/lJ+FunaATXRPfa30dmNKRwlCGYDHUAA+okKMt7w35t6uc2iEtSfJjeJfcMx7VKX1SnyeMtvRzJMkORyog9SlUzWqzKytgWQKNADjLsOVxNIZ08Ad1LTv7KInSXmz6z7UYOqQkAmTlRTU8uoVikA5CtF8HxXPRO1Z9p0sAeUGK+1Alaw19krqQXAXktCNX75v0ruJv1QfZ+dFtEcl3p8Lom7oW8Kl5Nf8bJsXD5S2OCnZGiH2IZa2zdhOfQ/3W9IoVEQPj28a05mJDyrsOjieWedyF+aLUShTztniy3byPoni5ExOsk5ifh+wKx1JBVS/7dPa8cfRorMnevSanr7bnFQwVQAiJVIl3s6wfjpfDLx0tBCFN0joqlIGnnSwSI9GhJo0k9VRs56ohUpbtqasyYXdt00AW99LVX48rzrwwR2yS0q0otuMKLanTLqKSVPcA8bGwcc+/rxhnvgUTZTO7GOfFwkbcCB8gR89OhKeFreF8ymjuV778CmhUZWI9t35Oll7nUiQXYLCesmifUQu5DzVfIcpe3r0hrsDarfokcA25jlGNKQgUzroAjbmKMiuGclo5DGx/lyr9FD/LDU1BvXQY1oxV6XbtwCI0/LhrW1ghUU+PztKLlGCesNNsVekxvuvgi2TeevSxNf4d8KqpBIHhjxMem3If40WvzLGbTPifrQxcAsMyqNA0W0sGh2GCIifGDnrgoqXEsADRo+GN409sGJtXCaSKh7iyoQT5fVLcZOhsARy4mw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pJa3jxZkddNsrx68OnOQC3P6db0CeFXZEu2U+MbS3PV2DtCO9Amdcm9JS82qQ9F4tnwyMW7aPES7hr1iiHhaHD2HD71lig1sQILYKxT4edSIm7sgE6rjJOYHS5gIpKU7z1XC/iisWwj3sOgazAmFHW352w1SLCl5kzDYKlR56gsY0MUVtENE7T+eyjCsqbY4daSrzIEXUcrXkURGmrj+BhBzgcnUZ75YeZdtUJnUGaV2QB1uW1BN1pTjYNSX5R3h4Vp8zreiYzuP6izOWdwK27W/Znoy/5b7fTAKjB1yFjOgzVNewdourdx6fgZ4FR+EZokqPK+ms2CH5JBpWbrtJz2tiKBgon5adY89hqeXsec4Upgp1ygdzM7j/F75RTlrJaB0YiCbkXN9F8jUGyKOHe53VrZUHLBYBi/Eh6ARz1AKU6TR2f19918m6MidctqW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:16.0018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d9cb6f-e2b3-45db-6120-08de868f290d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303

Currently when amd-pstate-ut test module is loaded, it runs all the
tests from amd_pstate_ut_cases[] array.

Add a module parameter named "run_only" that allows users to run a
single test from the array by specifying the test name string.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 447b9aa5ce40..35e453a49c0f 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -35,6 +35,10 @@
 
 #include "amd-pstate.h"
 
+static char *run_only;
+module_param(run_only, charp, 0444);
+MODULE_PARM_DESC(run_only,
+	"Run only the named test case (default: run all)");
 
 struct amd_pstate_ut_struct {
 	const char *name;
@@ -275,7 +279,12 @@ static int __init amd_pstate_ut_init(void)
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
 
 	for (i = 0; i < arr_size; i++) {
-		int ret = amd_pstate_ut_cases[i].func(i);
+		int ret;
+
+		if (run_only && strcmp(run_only, amd_pstate_ut_cases[i].name))
+			continue;
+
+		ret = amd_pstate_ut_cases[i].func(i);
 
 		if (ret)
 			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);
-- 
2.34.1

