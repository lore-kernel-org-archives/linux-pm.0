Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077113C73F0;
	Fri, 20 Mar 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017848; cv=fail; b=ZLeg7XfLGh3egGjMW9Sk/GTFRLribsXgkkPPApWAYzV/BgBWoLlRFBPn140t+MPxQcBPIdDSHkqy+GvBuzFjfMzPE0x6yGCQCZgKGPPa2KnqxZNJ1hLUWUSVsm4oyyAxt+mxhjXmBL7AB2dCywRfElyrjdB+fzQ2+F4bxQOtET8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017848; c=relaxed/simple;
	bh=ib21pnJqnvr4fNN8vtSNmCTlO2dcGMy7YSXo1/zshcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZX00vKwZPF+MSUHoOdXeqoQSN73OyAGat7u87uzrsklkiSi/A8/LjxrfqXlVi0rOmjNLSRQ0Xk7myGu/0dkjYs8yO2IEjLmKOwPLVznpbP1eNDKK5udNIsS+dDiAHLu/1KWYUvWhwpnz65G37rZ5Y9jFbENgHOkTjDsun4gQbOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UeLi2PF9; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UeLi2PF9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKB7WBsiWhtpRz8K/QKXXtEufzROrz/gQuRLWvGB8mu3pbE29ieI889G45FjeukrIYu9OiUmX3xKkSSoVJCXyqQmTH+CVhvccO1YwPdxJcsnS9yQm8ZmXDcpJ8MDQn2FHgIb9iMBdrgIVgfcMj6IeaAqxbPpMK6xKUvGaioDj4GYMt/YQVc00ZQGsOoJi/gzziiYfY8vVLEr+yHA5uktceHzOq8CB/SVpdjWKruzBlAfLkrcaX8x3vcCrbto7KIsNyd56uz4ujJR+aXZwKpiypD7IFKYnuwtvt7Oxvlqc+D2V0HIGT2p7tPObdtgskdVeWS8VnbSLNRysuUzdJv2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277Jq2NRJTzZb1b3TUupKpl4PLQjWNP03zSA4NRO6A0=;
 b=d/Uozabn3kxNLl7MM+kIn5xRLUazG0OG4p37pXU7vWOOb8pLtam3zRVX3hVekcklBnn79UpuJDFx8WNpZ1XDTY8uujgKOlpZ8FprHoHqOXMPAGQQVvzhu/JRAQMi53CQsTWx4BWazkaFgKnLgAKcMgPn4r1a9hjRCSfamplY5tI07RsZm8elx0PUkGNMtHJunCobKO6OTvqsz090n/mKs0eEAOk2/PANln8G2jS8gPD24or+kuI0sQ0cQaLc++MUcOzlkN2y9mbNQ2lxjs3woZcPrA4+ngiSvRA7iz2Gki75wobCfFDkoNKtjJVYzAoN/IMoijWw+X5jtVRZd41Tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277Jq2NRJTzZb1b3TUupKpl4PLQjWNP03zSA4NRO6A0=;
 b=UeLi2PF9QMS0yYYvJAojuRLYkCv2cpG+GzPjJzMZe+uhc8zItNrRJ6kpek1uSeOX5L+EFIIvXqUHqdq5NJ7Bbit4CwGeOGQDGQ5R1V9bj5ZXbr4yEW9SOzydwrrC+LVjOYIgaEET4lMIuu0vi3/iwhl+5ED/4Eod7cqZiQfJ9Tk=
Received: from MN2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:23a::6)
 by IA1PR12MB9530.namprd12.prod.outlook.com (2603:10b6:208:593::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:44:00 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::48) by MN2PR03CA0001.outlook.office365.com
 (2603:10b6:208:23a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:00 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:43:57 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 02/12] amd-pstate: Update cppc_req_cached in fast_switch case
Date: Fri, 20 Mar 2026 20:13:11 +0530
Message-ID: <20260320144321.18543-3-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|IA1PR12MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5417dd-5562-4a30-a64b-08de868f1fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	f01wTp9PrD7vjo6WobpA5m25xZC9XPUvGxYxo0Sr9HhkSghdAmsUcJHEEsJyRhOhovigJlujhWXATifkdkwxaieN80GLxnUTX16E/si5qi96Vkl/gQ3HUKtecsuBQC/CsS/2+qQaRRSeqYznncZ8ptAEblorFwA0wPZcvC2fx5OskKnYQKUY3iXMpRPOkwm94f7cjF2tU38WMsRcNsZtCzdFnpfs810xtrDv5vstZiUyFI+4DhgBR2ggP8jiGQtnUIJaZPHRQHzkkgtEOoaoWwtyaKkLTqszQ9cSwik786HPag2MAWPT9ZjmbOcmVL+Dlz8smKwSTJtUGBhCjgFRzMAPbVTynLbzXuynTTmNcnt2Y2x4Gb0AA4QbaogIlEqBvL/XnyCjZUy/413VvXRVEhafqECFdAO5wGuwNrrhwoBcKdswlZMIWY5NBiYmCL5tDZLPmtMYA/u3idRkKBF6Mr10a/h5f8xX4tIvNiPktNiqlGm4oMsbIkgj8q/FNm06GNIX/x7KFj6rff/7aAkiA7peZh+0sknQsuUWZR5szZGmaq4AXAFyrmt0MOt6vhngRoky9O3hdFzQYPoK1rTlnIaFVmXc2JH0H8bomTvb36JUmVEE5xl42UBP+Yv1IZ4wTgdhtU4QZpmqE68H2QKoyuEDvCo0qgd8EVnIomWNrYYJ3SGb9+K7aOTglGLrhJYgmewY1srUUhVO1PH9/On1gVOfiTEtnR1PUSBfqu5Qmp0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IoZrh7/0vMuwc3rZmjT8a7XgPKLgNOPRVXc7EWOeF1Yx0+4enI7EIlQed3rDsys8ci1QN4eZbNqs1PHZu1MdbeoleSDdOjZtFKF/Cx4YVF0RDobG7j+Fd+9SUh4AqcBjjbiigxcmq456b5zji68XmrUoUAnoycyOCTYGvosyGjwNkOmUPq+rP37dFA0KhjXQpq8vvTtRw8E0j3bojPOkSxWSKKeYgJ1HGVDp7ILLH+As3kCx1u24aF1TVD3+BOck7Yxd8Zf3zcZZRCGWVgX078jucEtO66U+2SQfsKfLHikmSJmXCI6trKAs0uPAAkbiAFDZuPVl4Ac+hr6CD4ugqRGEJiMB3Yn8zN+0ebfTqiU4+VoukCMrKbzopRDJEPsiPpx1GYhzB02J0yOAQI8RBwqFeGhn3iQ4SL02mIVWsIq3Yzg91qer9leqOBZXgm4S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:00.3527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5417dd-5562-4a30-a64b-08de868f1fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9530

The function msr_update_perf() does not cache the new value that is
written to MSR_AMD_CPPC_REQ into the variable cpudata->cppc_req_cached
when the update is happening from the fast path.

Fix that by caching the value everytime the MSR_AMD_CPPC_REQ gets
updated.

This issue was discovered by Claude Opus 4.6 with the aid of Chris
Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Fixes: fff395796917 ("cpufreq/amd-pstate: Always write EPP value when updating perf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d57969c72c9d..24cdeffbcd40 100644
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

