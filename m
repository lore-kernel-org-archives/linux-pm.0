Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2E4D0CF3;
	Mon, 28 Sep 2026 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627754; cv=fail; b=TFauJz8uN98lkqad+/cpnAiW3IA817xtQo7+TI8IMa0exeefsJaaQUGK1QNeeBed2n3HxPbaRk2jpDvRzcdOBYCacPy1Rq+P8IqTlkWEp4y9/6sxsJ/apQ0Fyd8NhWhdQu5CtwCxl9czOkZHenYRTt1jnB27sNto/C+KvMjHP38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627754; c=relaxed/simple;
	bh=ilec+sdtP3+YCCVZi7wtkLs1/hQ0dRfaIRF4Btc3pfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REYZEFa5cxnZQy3m+o+YiSE1F6zjZ18xZMZWrnumgKSHNiG/mc2oakCWEHXpmbZiv0FO57mDldCldVyJ9LPE72Noj0AWFevW4qxffIkkIcvqvW/4S8J3AeR32bPtUdXgkJDES92Mfcl7picPmtTIWcsr8fU2amjqfA4KXqqX8f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XiwlmcT7; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XiwlmcT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3EUVeV8DTMP4/TJTM9t2HAgIHexd+Y9RiweLoy2DXX1WhUntIXcK1xubzujPYXOSgED8GInkadll7dViiSoqVklxmYMMj11/8suJEQhfA9DmniFXsljzNdzLutFyHI5MURLPBcjc9Kkho6Kz3VxEqUMAl24HRIMtPqVkQZib0ZzlYRw1O29YRWFy05/7gJTz3trugSMhAQpUN4vT3163heMYtUrEvSowVMfq4xUM+xyeINeEE7pgD2j0q2DSAxc2I0XYA6lR6QVasMF8kynPE1U+5IaHH6iQKmJclyHwzX94uBg2zgYj4Y75H1hfw2hgwlAE1fBt7Cdbi11z/SJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN/mfUfsmiLCQUdNy5CbADPi2FdN/NJIHM+9YSsO/4E=;
 b=R2QozACV77jAB4EB25SlLnxZox7nvrus7iqkLjJomGtwgZFefILyo+7aumZB/9VW0Uo1+onY6SxYNMFp9J7qbM9S1+E1K7CdYyyfytqDq2LSGPZoFq2JKmis8BjG4FrFZ3gBjhdDpbGdecMwK9aft50OoR7MhpqLuGjIWT2Ridv3m4Ge0Kbidx70NhOTZAdZ0/cHemrXxRhZm6pI0ay3WZTGks7LEkLB1YfEQpaEteVUBM/WBLmK2n1OxpqqzTe0YMpoWUH+XvS6EHjqv5TXudmhSSawQgo+LHqBxweuRRoK2nqdnI3cgeb5FsA7KJscb08FokYr2xLG9NbmGMpEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN/mfUfsmiLCQUdNy5CbADPi2FdN/NJIHM+9YSsO/4E=;
 b=XiwlmcT7HH9TcNTPn+fb2w3BjtIfSDrdtaJ8p4Lfi/Vz7UdwiZxBGUPpmoyQS662UPMM3HaG/q1dh04Sb0W4SuELRmDXmilZjChn/ATR4x3dd9qTnAvH/ztesnmpSwjN2JMepgHNnrlfhU3XFw60WMu+JldbV+XjJKxKgq/sbDY=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by FT1PR12MB689230.namprd12.prod.outlook.com (2603:10b6:170:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 20:35:49 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::38) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 20:35:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 20:35:48 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 15:35:44 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<Mario.Limonciello@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Update Zen6 client EPP tuning values
Date: Tue, 29 Sep 2026 02:05:23 +0530
Message-ID: <20260928203523.1290623-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|FT1PR12MB689230:EE_
X-MS-Office365-Filtering-Correlation-Id: af601de6-3f2a-4b53-f5bc-08df1da01444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ODW0if0TeUD2lk4qI+GGDcSRZLl4Oit2XuKi3W1iP1Gp61D+ZML9GlaxeQHhbPhgPbSv2wwqLkR8BJHRmC/RS6LoOb929xBRUqMRiPbfU+/GZOaCwqY/Rx32hKjiWpF3KhMKicsVBnKLA56Mzd2Q6VptI2seiOpVy7BIJf5YXwWRprxmsmNPLxgmFVTQO6tVZlK5zRUdSlG8WWTtyx0JsQN9pnD5EhOVwNfNBSkM1Cx/pymuC7bXuID6yeApIaMehJivXx3DbQdEnSLCb/jWRe9/WizvlJVzRr1TeHGatktR0lNkbt2HCjJ2Hlt5drbVXLT4T18lKfQLmDKr9fMK1+Ra1+XcfKRk2bsJFlMKyF2mvlDFtSpsQyoLCv65IZWsxyl3pLAbzqQCFAtOcUtQv2pCeJJsbrJYel7HNKxP23r02ux8xio79VERB+t/YFUs9yX9SPln9rqN2uNZX6jAtxftEyMFL1rT01MAAtky5bCn/lT0/ePEui3wKbIXN0W9lBNak/8Y4x31aodAieuMMJ7vqOD5kXg5u4gZpnw9lUtdnLF+C0jcsDh+qnBgOJU5fPkmGozOd48rxannxaLDRLr98pOjxh4EMkJGX/Jk1YAMgNAeHFvzXC1yFKyVYkBUQgEPkSxalSSg0aqkiX8FZ219H7ReDbHpB9bdKilS1PfH2RgxlcIH0AdJMtlHxbnh1/2eER4sy5v0SYtmC5LY8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iUtzpgRpP9uWRL6jhbLcTEC7fcQmBluGB9R2WDO2kQbJZCCNA41gv9bIVrxoEMdYWKVUawEWRABy50U23TTiw5iotRXpeclle8/+pCnnHQK1U8/c3ai5UST4oAlpNdxZAa0yNBP7fs7j+fdWBWPwxcdix/RR2P31lyCGr4GkPjhMVVxAzzE0O4fbkio7Z6q2lvzKOva9wsheR88xHrgtZartH4MMmJH3fThSkPCrbTcEjLzcM9Rg452YsPk8aIfkJx3388ihemSUhrgS/BByyTc5/I28Hl4EsRMScvBwJNgo/tS4usu6y5WKOK1z4U5pxiRpB3ieRWXTgfiQCyox0xRLhe879iR0Oxb9DiejeevCm31sYfixU27ekF4/B2RfEsHgyZzFb5mWX8tNzgQ/MocdXdfkHbNtLeRH8tpwuktZSnKf3/fGKrdUsc60SxfV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:35:48.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af601de6-3f2a-4b53-f5bc-08df1da01444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB689230

The per-CPU-type EPP values for the Zen6 client platform are further
tuned based on platform characterization. Adjust the performance and
low-power core entries so each core type uses its intended EPP settings.

Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
This patch is based on Mario Limonciello's:
  "cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms"
  https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?id=114a157e8d30601d024b53564a0fe54202f6567f

 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 83960a6336b9..2529cee9a6cc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -211,7 +211,7 @@ static const struct amd_pstate_epp_soc epp_soc_zen6_client __initconst = {
 		.performance		= 25,
 		.balance_performance	= 51,
 		.balance_power		= 64,
-		.power			= 64,
+		.power			= 115,
 	},
 	.efficiency_core = {
 		.performance		= 25,
@@ -221,9 +221,9 @@ static const struct amd_pstate_epp_soc epp_soc_zen6_client __initconst = {
 	},
 	.low_power_core = {
 		.performance		= 25,
-		.balance_performance	= 51,
+		.balance_performance	= 64,
 		.balance_power		= 64,
-		.power			= 115,
+		.power			= 64,
 	},
 };
 
-- 
2.34.1

