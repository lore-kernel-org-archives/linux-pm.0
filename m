Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352D364029;
	Wed, 11 Mar 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237709; cv=fail; b=KtEFbGbnipzX0L4/Lv7kRnbycI2iQVLqB05L9Hk4knhGIzZHTrBtgKiKHYpn1LTMvQWfrgO+ok8reEqwWYVYRdCSRhNl0hp8oyUdH00pYFsO/AfFlki+HgB9bK5QApXT4puJiv96tanD7cdraKkPU9vnTMXAACuQA6b3a0y/QL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237709; c=relaxed/simple;
	bh=XuTIV0n+oRXw9VTDjTtp3eqDdIbXA6Y5/lckxC4Rr58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiECjX+uO1UwUu/MpPtvAFlcSFXHmpE+B2BdMYHxuFI2GH3DVMr+x8OX7bb2f+EKESidSPKfI+7ncQTGwwQ7x/LY7Gxd6hNCygeywUGpI+0IvSQofp7gbgHmzf1xcm1SajUSVV+9vRSiPW8qUu0/2hGAx8qIJppzTwd5cPpRrA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ny4RFLgj; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ny4RFLgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cny99ioOVMGldLSuUMd+WNvA+oZWW/7TwCsyLFgT8FwX6qNvNJFM+HjKbW8l5zSwLLExkoRJeQamrDdaLEQVojFTrsDjw7YemmGHPh9LE54UaCZvueSScuxjNlqmEMrTH+WS3y3hpxzDYrFdMZR/qh2zSIem+O5IA46/3r9gWn0U4I0xYPRenZBCKwzCooPd60uGnvES6tO3pv8TgO9oUpJU+KG7uS4+ops8ybXbIZPXQhUOjBu/iifiFpb+rjMwtPQbCxZCFgkv76LW4cAhT9AHVKuDA3QIjaIO0NJgy73b6WBN12PINyvam1Vaos5wTUeb3zV/p7+UW2Ys+O/IbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFOf6e8Ya+iEhlhvsOYlnIG5vNdJ9JjF27Lv0KmAHUU=;
 b=RxBPnKjddB57YlmuqzArwnsbsU5g60romfJu6OXYUvb5/HE40NYvR5uKM9hjL3P7x/lnNVs8yNvsJvvP7hqWjZo3/Ro0xh4hEORx6UffZcEvleLItAsDUNFxiMLM2f1a54ftpf3u2kP7oY14d6uCgpa2TUDdZPHe3HNX4/8Obo85EyBYcR9sLlFktonjRlX+7uRWnZ+hDhiDBjCw9WUpTV70fGarf8SlG+bT5rptIIFfRpODAv1kLam0aZ5MgoW/S6jy1Nr93sMGvUfjNEwi/HdotaeKEns2GD8nJ//4ydJlzmcUiDnlKyBynPLzqL8sIzghepsNP+4YA4rp9yE+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFOf6e8Ya+iEhlhvsOYlnIG5vNdJ9JjF27Lv0KmAHUU=;
 b=Ny4RFLgjZn1txw7gPkHEGR61giTnCSqGiXyHiM8kPYrzNBjyfI220byt/Cc5wDSbQyh5G0BL4S4dxiVko2UeGNE1LKp1uxGYMTR6LhlZMju8jHT4xvbRbn+/g/kn8XBPC4gLESPPT9DfM7LuRO0kL3cPNmQfV3DjfGA89SApvpA=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 14:01:44 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::65) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 14:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:43 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:40 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 1/9] amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
Date: Wed, 11 Mar 2026 19:31:08 +0530
Message-ID: <20260311140116.19604-2-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf1d5f8-9ba1-435b-5892-08de7f76b9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CyF0xrvaKBAw8s2qBcGJE3A4g4SyXaS1yJE3UnO3goLdvGxuRkEhHWsxDsIEDZHm745yj5+x/2cxFkbvBrDsuc+zhuiE7Du5C2E37D4sIRv1RET8GxsDeq2yWflmh/L92R/PvaVxtjnYEsAJpfVYJTmlRWbj/DBGrw0UftsTORGHfkfhnB5ZLBaiGKPjCV4poaBKwxFJA29sTzyrwU2+n+lSXYuUoo7XWz6FgKCmcDhyNmEHP3ezgrHYiq0IyRjg16M+atSMcXsxbCgjlPOOAP/NNPgC7nLeKhfp61G0UXCBR+wUbVgYpOQ3KbPzeVkh9t1IIRnE2ztjPJj3PRZH+mXX8Vs9LrJEkgEOL5jldjMzYchiBou0b3yC4bmdEMXTLPvYFwhih2g7A6X1sS8DGiIoX4if5Ef1f32FoYQ/Rajo/99e6VmZVq5SpkT8o4w4A2rgeOPBgG/1OPFfE/UhMeRyHCjeh/XDRFLH18TUyLhWJpqIwf/aMosaYFGrlOh/PhTRt2zU8WTY92zKW4a9yryMu+7aQk2IA8NKcRJjifwWQ6vkcBy8z82BXqlKXjy30N7qAOcUMmGwhxGuelw2jLJP3MW9QRuijf2xEk9H/DYGdgNh1suQibZAvaKFhXT83fMuH/r9p1bdJ8vQIEiVXV8upevfLhfY27K9kggZzvwgxs2jaonOqD3clV1cHF/ITcHMEzOmVdlDccJAkIuzY49ndnTAM5usXs8QJdIgaRQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ya20P+Q8Roq6vRmsF3/8vnx5LtroWcGIUsH9YlQtEB2YEzVFSszwk9wnpyt0LAzvcHkW6Zu/smiAdiooPdYdHs3reJzwW9CFRY7Z5gWJUcLzoHOKmtHjM40D+BeATuKWgsoed6h1k9QjdiDB9AbohZoeJVm9t6WmUaZiOX4rt4TSQcbfUjWiNo0MDbHghXksd4LH3soOsWpPOwXOQDWSC9Aais0Y/MAmDw0qtp0skJE8bGMY970I3v6H+48WS6mdXdlzwneJ+gZALO8VwOF8OZKR5vnYfNcfzZnLKzbu7VFcMKFrkGRJv9R5OKU+8dkOeKsq612wDhXVcD4lkV9wokFn/sC1K/pvznOpwAdSV9qz11pcO8RLzrHxwocoxq1RFjxqNoDGyVYKXnrvNSGERfuBJujR12HIj0RHQLZMqn3d5beK3lxxlJCb8nZ2EzQG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:43.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf1d5f8-9ba1-435b-5892-08de7f76b9b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

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
index 5aa9fcd80cf51..d57969c72c9dc 100644
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

