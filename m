Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E8502D49;
	Mon, 21 Sep 2026 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017381; cv=fail; b=tWIgqfF4WhN7RkSbGdZP7280OHue+Mx0OH3OVAe8TULZPOLl72Xj/x6iCOls6+xwOS9Itx/q/NFBInBMGfBTz5EfDQut9KfKdee4akAIsJty7SP0Gv8/p9g+CofTkeyyocb/YOgIG0Hd8MSbHUqQprqqyLKs0RoHbiUh+y3Fz/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017381; c=relaxed/simple;
	bh=7xNZyIXXvAXU6gXd3FesDh1h1FukGwvTX/OHTd8cXkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6H13Kmd2QRmXuiKnpbCyB7uXJ+WynDvlFlCA16naKlQHM6v7CBmjP5TEN7t43WjlfbYiqjFk9HiBTFZ1Gnv+877nkIE6wu6NBiXc/jesOa1+gD3ymuvY9Y1ade2aYnetTWwh4XW/e6Bsmg6+vTv7RKjK6RMYeFMzIfdp3qP5uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0L4qADmq; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0L4qADmq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9ID7Pl7eSeN90GiPn+oVbQG9iGwLVwf1KBEjZS2qUPkRCgcieOefBzhprymVrgsnyuAuTYiX7PLzu+vPM7b5+bKmYJtAsjix4CODUfjVHjwQ8HQq8hzNQ/DGi/l2FsnCBfBaB/zpta6YFd3oY4/coy4Xu8S5huBeaptfr3eDQQZUyQ4gPUOr7aTo0qQZI+d5kkCbR2Ua3ljcFoPTcbi81jKuUe3aMi2ZcRWEyTKMIDF9FXrCOukRE1jhBDlV/m7ZbQNqCNDPRe1Ezr+GvBny0x438PXSIDhGh3m5JI+NGpu2BcXKHiiSHg8tREgT9NGZCiQAdmwSPW5SWrXMqsUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISE1jO3R7j1AMtgEFEqCA9S3wcMQbo+b2GUHhZE6tVI=;
 b=GEl+Dy1Ji3E1rp6yyb2XJ/wXUVud0AebEXbDfd1ikkUYqab8uNMcoaFF1L3TQO1NnwJoVJfFwUpCKUQzf7GbEntATJDE60LF/nqGzB7wMp7NtyvQMAUg2FhqM5Y9lyNKdljM3vtnhMI/DPienWICd0+5WTQR7602hrn2Xsk4LUWxpgIIth+mDAXUwQ+T6OIaCJ/K/BMcRdXf9h3oBYnMH+XdnjheVJ3UhNjcZFddtPI49SPHMxIGkdQP4UK/2VRJOroGXcgeC3yS+uNJCGLh7DHdv68+89MeAKAt8+ENr8Ak4c933SPqZ1UXsZqLXTPD/Erpyc7LaLufVCAOIhF0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISE1jO3R7j1AMtgEFEqCA9S3wcMQbo+b2GUHhZE6tVI=;
 b=0L4qADmqnbm/j8XV1g1XuxvqMWTI1OumwDmeXuwp8lI2bkgv5Y6Vr0QOU2bk+Ff+mcpX3dB4jJqQ7HgcZinZZQaQLqOzrYLxARb9DBrxx8OWTtEX/KrpKRSjLss/kY3MNbHsBWfbxn56Up0B/394UmXGbggOzbcu4jDetOsE01U=
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:02:45 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::13) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 19:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:02:45 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:02:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 2/4] cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode change
Date: Mon, 21 Sep 2026 14:02:33 -0500
Message-ID: <20260921190235.3651688-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921190235.3651688-1-mario.limonciello@amd.com>
References: <20260921190235.3651688-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: b229a9da-0ae2-45ea-49f5-08df1812ebf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|13003099007|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yAzaCkfBjARheCtmeuBEmxYgU0Z5ugBE25auweR/FBeDav5cbsW3u1zzsW/EfrXfSo4RsR9sO1ff/8/IVbh8DSPwIpfLZUx54vy4ND9ii0NVkuTtTNPKNp1RQcHuIFVa+1WLg37MqBSeJ9lVqHwUEIuRSamnfT4OFFrPK4MhHwtVBUT05O9MsOrTykgBKh6SLFA3xGDq4wKrseNOsjFhYiM2bf/MyYgeYFXbhNMr9bh2a+uzHLDO1mH3schualbBbpIuuqNCzmQBYhVP/bsDZr18n0QVSgIcGpRCaba/dmbFths9svIenLjs4TKHCQXio7JL9I+oM27jwjqlQHLetCeUt72SZmhp6c8lVRHksybFDZ7B0/wjS1maeDB5N8xzmkVj0L7qkwUKKM2ZnYa+4E0ztAJCKr9ECkhBJKRRUSFsLPjfzJO3aSyIx3Sp8WbUJwuc+84lPCvYPcT5R9fQipq4Y/qqKHxswRdkTo+qK0FMuDKEzc0Kno93nhCRHbZhSwEz7kPsgWc5OV8dYaRiNSRLp98hA6ZAVjAscgM91fY2d4AAVF5xwqMSfCsI0F5D/B7Hp9uAITpVKcXL5n/JHbEzpfQ/k/ZG1mzFMTTYMIbYCfL2V2zSmznuuzRhyKaBewQUYVIthU9hQ9/7+NuggQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(13003099007)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lcw/VAcFf1ddBwqfLNvyNNgHwXICeSGbZU8Atc26CuQqNDW8CJO2Uj4MkC/n+igd8NXmd7IsFQJVwyKO5j7hPaZ+Wd8IdSf1+K+OMHd3GmzkeaSkj3woRiFD28sGK7fo33w3CQALh5YQ8CmCXHZQufgvKp2NOzNR+VwTAUvh73u7WY7eW6wpYmKOG5Zr4suzzUa3JO3lo9kIY1bsnCmi7ax8QjqBUydxS5sOa7DjdZNyY4jUzZy6bMzBSnyxCsM1bhokW1M7IxUlRX6s+ObGjHiBPL+NQHEbt89YrtKOBdVNOnndlVXzyVprXg2OFfsneN0vL/JAWHYDmWWvl2igVEQHPYhlqsdq7FFCMKrp7eRC02uRGvh8wN7E6erBNkLEeOjIZM1GEOsRzn7XgCUZqEdUZBD+Z6AbjChbc2so/0OzTBgJfdf0GGa2ZRYu7qUe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:02:45.6341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b229a9da-0ae2-45ea-49f5-08df1812ebf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

amd_pstate_change_mode_without_dvr_change() iterates over the online CPUs
and calls cppc_set_auto_sel() to enable or disable hardware autonomous
selection, but discards its return value and unconditionally returns 0.

If the firmware rejects the request, the failure is hidden: the cpufreq
core records the mode transition as successful while the hardware stays in
its previous autonomous-selection state.  The software mode and the actual
hardware behaviour then disagree, breaking the expected frequency scaling.

Check the return value of cppc_set_auto_sel() and propagate the first
error to the caller so the sysfs write reports the failure.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d114a94a-655b-43a6-91b1-9484889726c9
Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f633a8e349255..7a2174b5911e4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1818,6 +1818,7 @@ static int amd_pstate_unregister_driver(int dummy)
 static int amd_pstate_change_mode_without_dvr_change(int mode)
 {
 	int cpu = 0;
+	int ret;
 
 	cppc_state = mode;
 
@@ -1825,7 +1826,9 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 		return 0;
 
 	for_each_online_cpu(cpu) {
-		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+		ret = cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.43.0

