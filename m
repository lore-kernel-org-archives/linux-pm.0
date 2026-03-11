Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3936492D;
	Wed, 11 Mar 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238310; cv=fail; b=rtviDu8XPidSSJo4qZMQrLP47Dczc/OUv4oz6jEN8mvFfFscNWdP1OjbfauKBpgf1LNIBNF0P+9k9uipEkh7mBOkTDLA9AZKEkAS4dd8eWslMR4q5TwDPJ1yrXd8OzgW/QoiztxHZcYG+Ns5X4A8SEkQ4+HNhGkHOhfY2/OlbIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238310; c=relaxed/simple;
	bh=TolGaAjP+hdGIKlApaDjQYDyC7YRz09x4VAJmANDTWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1vpN3Y7lApu5snY2gqvhl7xaSLd/O1IfWLrTW32oSvOZihe1vWEQWrhUgnvA3hweALzzxwj4WVRMipydDSmVeCSRjcjq1JPkGmT8C8x81i0YVgZrF3b0Y9TcdTm6LgKzeiiAiOPvXdaFcbJI5n7QQX6ngQI86ToH9II6sx80QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Yf4OWzb; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Yf4OWzb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYI0EKW47dy5VP7MPdP/IH74mdydKpgL40qwnLES/MCkPI1DSpYyAu2GlAu2Wo7R6Bs7mz6Db2sgrm3UgTsVh0zVHcyxZ2T74xUcuopqy8F4T4H1U6CHc47FPNNEZCelLVH8DvrCILmmMObCL4oaIUBU6vZo8I5yHazbAosdhwx9RO137CIG9Hf1mOg7dJgqpW66cZYQGbkWaBD302Cp49BuG5iHQpdVAoaLr9r38n/SnhxPoL46M6kHA1in8qjjcHQJlxdJ4lJULJ465SUxqnPta06dpiiuzM1UYURX7iPXO4mZ34ZNNknZxu30Lf97sdP6o13d9mpHe5XgPBTqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pzlpzA8yGLtPHZ5le54owSJpjZDHrFVUWKfr3ILc4U=;
 b=VD9L5GEt082VhkA5UdBt5FI4BupxrG44XNbloQWinUD7aTpAJwjrLRpD79gUE3NhyChXyY/l4W+Kj9IPKkC3MGaJims19wgHoCKavkQaSnBPTT8HD+rXDHO2+p3y2qMAbstlRvKeRiqppAnkGNojKVrztQa31k811+fLUVbBoxmLpktE24WWK+rNAj3zHyccn56UzhRtEkUyVAYBhDe5BypMkggdjT0SKIfzt6dtahRc+LURUHnexIglDs76U46w/pg3PmBq/wRtnKk79P2iSoPnEHQkS66iO2M6RJ/0Ckb5W3dtp0uelMV2lXEPSv4py4wCX6ctgJfU7n5cmWB8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pzlpzA8yGLtPHZ5le54owSJpjZDHrFVUWKfr3ILc4U=;
 b=0Yf4OWzbIGXXIyjsOAJfOCLBJF/aHMrYYb8U0Aug3j+rEH/QJFQvU8g1nFevNRB6UoGroiV7TSUW5E2TBz4TLIaNrJOZbdq/bSoUg+FH+Xp6fXnhjfUVRHd62g/jQiMuo+C7sgsB/G3kdauUy68qGYiILFOaFxcbrYDE1UnJY3g=
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 14:11:46 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::50) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 14:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:11:46 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:43 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 2/9] amd-pstate: Update cppc_req_cached in fast_switch case
Date: Wed, 11 Mar 2026 19:31:09 +0530
Message-ID: <20260311140116.19604-3-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311140116.19604-1-gautham.shenoy@amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e424499-e16d-46da-ec38-08de7f78215d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2eIRjRSk9x3GMfulsxQcUPqZkkxuBOoCseTvjqmS0/qxWnEgrF4g5GLMJXFazvVfjdgUu5ma/VQexK+4ytYG/9pyj+PnicNTOeImnFxiOfoLz4dZRik4rRDbhQTJwb2SeIo0actT/fJVU1tYWC+zVR98cnhO0ZJfq3R3V0WmztalQnfj+YmcPdrJub9AwR1j0QbF4js0SYS1TaEAidHAA8Zx7+cdIKBFEWmrf4ERR+JCZXE3Jeug+2SrxEnWbTTpEB5b+2P9r/5Wguq2dI2GKudg13qGLwk4y6a0A2SY6Tndtzr8YY6bSutqsJPpI/Pkxj5VjjKx6jNjDPsS1ZUYWT7HIxnu21FtnipBsNICADsBqL7zMisd2QaGzN31H5H87lrUPDxECodF5mtbaYg6cfiBEQrEubjoQGFy0D7Nj7oVJkNPmWF89e9co4UfPXKt5ujZVnsIbVIu+niwE3PO99iKuUqzbi+JKXPbsOrSW1R0LCZIkWnWO0oGPolIWXDoze/2hcCoz2hjswePkVrCy0/Bjjo55dmOhjgW7lLbHsLwRCbTM+RjpJ8HbFD6X4a/Ss8uxoIg9ItwU3LTTetiWgyBwyTEFfLQfnxkwOs7MkeFWKKuU+UYazflTxibcxRESjWqMdv/epzIxkMXE5O1Fl3BqRDuetgUeiBJThZN0mNPVwX++N5rnX8vbs33UEhqyAX/0ZWa6iAyQ5cIeimerxkn+rJReJcHhFxyyiLiJv4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mfo+Jf2sQnnoQSJMo0UueGDJYnxfAU/agfMwWUoLEdNxgORiajcdvxNeCV8st0/ZPr4e0sDmzVIZ8MIsILEyncYbohrtKS+rWf2Mvg1wQzTJFGSe1vzX11rzEJbA0ps0/oKRO4TcTA70qZpCW8i+b1Oudy4R+V6Vb2CKR8aT91ZMpsaOlrYhBP3zw9PMhPSOiftOzDDJ5wLTG6FUD+txl/jjwSnwO4fBixzD4JCLr6ObpPharRB2HEPhIu5v/MZ6LXjigWNNIUwQGDpuu2NnKy/XW3+vxMPR69sN3fKCeiAU33BUwYhmni6SybKpNTBVFP1k//phtqrHRMY7rXwOEO/LFB6rVeCEnho2TvdApTmGsyNA3zv6K84w8utJOuI+4AjaqZzcBks3THJkaTm6YU7SyCFkV21Wuef0MFbsYLEf4rX3PQdqeM16hxb0kruc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:11:46.5359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e424499-e16d-46da-ec38-08de7f78215d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

The function msr_update_perf() does not cache the new value that is
written to MSR_AMD_CPPC_REQ into the variable cpudata->cppc_req_cached
when the update is happening from the fast path.

Fix that by caching the value everytime the MSR_AMD_CPPC_REQ gets
updated.

This issue was discovered by Claude Opus 4.6 with the aid of Chris
Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Fixes: fff395796917 ("cpufreq/amd-pstate: Always write EPP value when updating perf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d57969c72c9dc..24cdeffbcd40e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -261,7 +261,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 
 	if (fast_switch) {
 		wrmsrq(MSR_AMD_CPPC_REQ, value);
-		return 0;
 	} else {
 		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 
-- 
2.34.1

