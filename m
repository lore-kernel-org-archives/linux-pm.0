Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EE3C5DC8;
	Fri, 20 Mar 2026 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017844; cv=fail; b=XWg1ope0WsJ9Umq9t3DnrcjVIJK2ZNLCI9iWSNdda3osDYi/1bvst+o3QikOzO817UNzcUPS5LSJIJ0R310FQ5W5IBSNNZeFqf+GURqBAb/rJrWrcYN3fcOI51pdZjT2kr7KgvLyFTyLi3IjkZyVCKMRZfdfYkrYtdHG3JH8AtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017844; c=relaxed/simple;
	bh=R6ZuV4jrEKcQNjbjHUezoDQWiFlyQC0UibLnXPKVwq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpD9zA4YahFwXdy2y06yhSqMz+IXyO7xv1exFLXn43OEENRDfjHUTYnInJO0hL/G7AZdLskQg7iQEF2+2xjkr70/76uLrb7Km+SMIMsnBhxbeg2OTpGZvFCDTjJdXNkNgucXGb7h09Icbw5RZZwuJ4bCfPGorMHUhEaUb7Eh6fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZrmC4yD; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZrmC4yD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzkdWUQGn3uoFxeAeQlfQb/St5wTRghsE3H0UXlwOWkopHpo2l9Iu0usKnR4g4tDUhs02Ix3CUuwcLLjmqTOoDjsMovCFHNDu8HTT9cj1zbLFrFg+ImxHP/BONJaMJTEpbLnoPdkl5/KWxyNzIeUmFyV4H9DF+2kl8mPdx9ZGzRPckRx5PNa1sYqkTpzh/BvhQzNztIi7R7Cwb4A/JrC8WTy1Zle+lM8LZttZowA05wm32iznWzknQS/MZmi7Sdaw0FIiUw3jeJfCnfZOpMvbxatU9ZphlIQ6MnOJrMSn9zHmI0Rqc7pEh6inieanUHGAsypb9duxQFe28HbRcnlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiGWPpgOD513OMJ1BaaBkh/WCPSknvpsaOxutrhB8/0=;
 b=yqwgNK7pSKOQuUAYY1yl/UpstkqBSh0Y06berMB8saggCdnjVn9133otcxjAo1llJdRkQKJK8pQGGXWdEo8oPb/2UhvcYaDQh1EYeLR9AxE5iDgUU9yPW/NV4Eh/3ixdv15DgEdXh83ptjbVLl/b+PqyAc3zTVLu+QzGlFLWTidQ5ZXxDc0UxFzgMX9sW0PxZR/lyhQ+mp56OLEVJ0niNgq/MHRawEIaDV1WTNQm9s6FNv2frJbgp45jwQqYGvhOxoFC77PKpuvMd9clYF+P3JxDY3dDypa93rALkzXmIxOw6uqxHVPW6I4+sDTZSyn2dZ0VoibCt9aiZtN7t+MciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiGWPpgOD513OMJ1BaaBkh/WCPSknvpsaOxutrhB8/0=;
 b=dZrmC4yDkSUhWQdQbcNapaNBdS8l5BdybndwhuPzDqGQ9vP1KNkjoiiMMRZl0yCxDC6GNvlwD3Cfqt/30ccVHhfLB+I1p18KvocgRtyyO1lqRJ/1Y6VmwHJJOK98I0dyk3hkCf/j2oEfEqCbu4CIlo/osF0GCgFMS+28BlSqLkw=
Received: from BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::15)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 14:43:58 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::5) by BL1P221CA0040.outlook.office365.com
 (2603:10b6:208:5b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.24 via Frontend Transport; Fri,
 20 Mar 2026 14:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:43:57 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:43:54 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 01/12] amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
Date: Fri, 20 Mar 2026 20:13:10 +0530
Message-ID: <20260320144321.18543-2-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d6792a-f5ab-43f1-38c6-08de868f1df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AUZaOIDmj7v96iQiEI5ASnotSb/NpI05E3EULaXu3iYh8g7sGnM4+a5tkulI8qeYfTcjT17th0d6ERYju+3qN6MMx2uiCY6RyTzkh9LXiHUuaYR/Y6m5SnF1TwDmsMCkiVQrN3/kqWCD5iUHPeGP1iq8ZaWAsu0sCkXk1R79wEWsasMRDTh2rG3XkVT7dIgAq/rd0TWOCLGXj1AXtjAuvaSPSKuq8emF8v0z0+r1zYswybPqfHG0AOG7YPxPwkqUG6DzUDspiCIky2wSOHg+jhh40FnKT6EI0KRofocrnmUCRyA3l+IXZwQOSKwy5DbfoFf2Z/T0HzN2OpJRJbFbo9p8UAYLtuS7t6M1YwTVuWg/IU4rvDXHlgdvLQy3ZK9o0jIYAa7mHFgXqW6mbXjgxXC4vD3P1LLiGNcoWhJwTXaqxo2Acrf/kTScF7wlawH27Hqrea9joxgjxiOyKlCXxYezXQnr59fyJ33uUyhzXiKzzt5rAJYPnAfjpfXxvaPjPAWzaL7qB+PIUUtHYQFqoY8/WK1eajhHQ7ZajUNS1b+IkhHARvUC39k/Hp8xzn1hFpmekKbh7NVC0tMctyrXz6WO+As2jPwsl606NNKTYQ7B7bbX9w4IsyRfSLZpQuQ9had8naOjHsqWQvnH+cghthEkccfalNShVg/fz0I1IL9MmHvdBMZbG+b57LvYopHqbLVvbw57OeOZ1pfz9dwgBRjScKt4hBGqebJQLpmaMQY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D9aPs9MtGCvvaFmS2yyAiTo4DSXMoKJQJM2MSFKfNBoMwlROfzFvt5kbvyUU+ym6TuouX5YXgXWP4WFHhIzJdiidEz3qf/nXvLcXDhtEeyqHhHknLdhVvXuv0eyarAO0AvkZeErO3X+WGKP8xsXAAe8DbFhsGS85wvRiwUtkuxpX4t+2RxBYpNYwgQ9hJOxr7sc0KG2gST1B8os3nCvEid/GZM1aY8EAGJaTGByy3hvVJZv+UO5VGR3MtmSjR+lGoTi+CA6URMI6EaI09uVYmdVQJe6XI2ic4QVAOy2+xAh2t8qH4326u8zVMmZdL4k0k7uuRJymK97hzisjz+60Dqria7w9qoa05Gw5aTT6XZo/YcY9Rna5YPHFe/uYm4zz3NncRdiprzuYuKwNiUbUCzhEswaAjod+2W9UOsSQtzNbECNubOdMExddfJgPcO/k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:43:57.3624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d6792a-f5ab-43f1-38c6-08de868f1df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

On failure to set the epp, the function amd_pstate_epp_cpu_init()
returns with an error code without freeing the cpudata object that was
allocated at the beginning of the function.

Ensure that the cpudata object is freed before returning from the
function.

This memory leak was discovered by Claude Opus 4.6 with the aid of
Chris Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Fixes: f9a378ff6443 ("cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf5..d57969c72c9d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1533,7 +1533,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
-		return ret;
+		goto free_cpudata1;
 
 	current_pstate_driver->adjust_perf = NULL;
 
-- 
2.34.1

