Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972482;
	b=ldVQuJRdZL10hegNgLcwsuy6ouwUmq5e4yWHZonwWEJ0xmFyJeTxoX8lnsL73YLYWerF
	 3KCX7BbXku5X9G3IU178K9D0BogaT2G7Km9diUSCsWyEdZKGi0RAt5oUeZK0+TrHF5VuT
	 7iScHw8opz1/FP03cfqslyz+YnA6lrTYLkQiyWzbC0CfmsV9umWTv5dSbk26rs2JokTm9
	 6+JpJBdl266NhsOm/uqm3RVPYkRr73RHwgxYmiSE4SVruIkHrnwuDSLa+tG2c288YPUJC
	 WhLyVPVMvdrEn76MOqXWmq4CLO9C3MR1152QIR0qVXp/40nKd1U5xc94SkFU5BpbHwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972482;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=m2UW8H5FEMjYzB4pBbjcg4Yj2UrttMcMMRLOaGh+A64=;
	b=ILlR9pv1rush8EMgMlk6XV3jUWFkYtyrmnfmyatjV43b3C6zTPWIUVF8ek4j+7sWXiYq
	 5cSycjDzyoJv+Xeq1URezN87VgzYJL8OKx6T6sL3gyyCJAXuM7BcNsjoVmkXwQqts/Yqk
	 7bXaTVwEgZ4EgTGbndtVpqwVn+s/oZMED8eKZingE4OlSJbQHSE0XdatKdWG5gsSZjW5h
	 PiFKgt1BGcd+KN/VRbgw1Rs68p3HSKjxBJr3cbZp14FnXNpLlflxDb/6bjMT2VwxRU0VI
	 rgd7O01b267dwGFB6G+Ej7bNkYOxya+tychAQRimQz/SAi1bW69hz1HDVrKYJO/LwBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LQQvCKU2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.38
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D9606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LQQvCKU2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd/ECiUtxi0cmoRPq4CP9bQk/cFbEc5IeFowBjEz+PYOmtOxcHXQdwJQjJb86+GiD0XWnKQ+nZ2Ysl28lDn4zS1cGLViUcTPX03q1GS5QOzL60yMtjQk+FgEZ6nFqUpocV6RtkXTn4Jch+ERlhurH0jdRn9MEN6h33M/nH+U8sx32uH4jgcAsBoIGyWec+Ay1+SZ7omCdnyKCw1q+NL4N7TPsm22Pi8kLx8QkSYeEC9etvvROeclEqa0/sYb9UMdnONwa+1/KS4UVzbHrGe7vC7I73LrDZVU/rNsVsiBK61Ie2duVP7/nhqQQdMoG3GG9ceqSpLRPz3KbNybSR8+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2UW8H5FEMjYzB4pBbjcg4Yj2UrttMcMMRLOaGh+A64=;
 b=C080ZawhealwD8rxl9EF65mPSum3bVPJ7OacEvEG7ch5s7TqO5MReGubdELk/82KD0jL7/xyVix25Q1sagIHRADieMcCnj2W2ycmvF2iJkb8nKe06DGI8U3AMezbS5AXKdnvwYiBTtBDwlqq49wboyRQ8ToxQSPSbSo/uf4TY+10HEq8+3+FccFmEho+p8QmJ1ooHj/uGt7JSaGCECzn017slUV5BsFi55F7HACkco/I0w5Bs9e/JxWzoKsFg1s1xwwk75iLMu5XpX8P+HkNpcaQDqh0fOjdSe6gKewLhf6o7GrTjgbUgk3fs/qvbfhsy6WbaHExVhqTmtnALww0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2UW8H5FEMjYzB4pBbjcg4Yj2UrttMcMMRLOaGh+A64=;
 b=LQQvCKU2o2v+N91+fp//rLS1RYYdzuGAJZ3vx02OuZ6Nqzja7Os1I66IhKiqyQwh5jGo1iktJl2QiFl9MRmy6Kc1JRPDDnam/M4OuwvH4RLuubrM1U2//WAhS7QdQx4PGk5nDRqQzINlEfOj3hOMukYcQ6WLkUhQ10hE7x17SSg=
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 18 Nov
 2026 03:27:58 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::53) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 03:27:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:27:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 17 Nov 2026 21:27:48 -0600
Subject: [PATCH v2 2/7] cpufreq/amd-pstate: Fix EPP extraction in
 shmem_get_epp()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-2-2a0048f563c7@amd.com>
References: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
In-Reply-To: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 5105ea9e-9779-4388-bc02-08df4523f0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|261021123027099003|261009221227099003|13003099007|261009223027099003|261021121427099003|261102123227099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PccPQUnsIw86ns5KM85ZHOpDqDqbDwujKqwW8uFHoEPuu3QbkNXdgjyQABpbAjjNsvpamg/lqsMpjHJptcfOES5LOy4+dAZjQNvr0TDbwXoqXSmsLgXx8jcypFGrN9ZYYPtRc80sx/NpYF7wH1O7ZxNfby6mr2OOFWvkEM7V0k+3wl4V2QuMZn8Dc+4YaOtx9H8sFkYq0rGYikVIBj8O1j+qKXbENuqqUh4R4KarMesFufBrOp1hTvk43lKYhvj1YvOQJmhwpcvWMpCZz7PLvoMLm9NxTWn+g08Tb3qTPRgLOgexSxqKMAArgn+pSD2fe5IV4g7l/g3uIfloEWZBkPmsKXF8mr58jrUkkScxcclGa7z+4S9/LNhAM80YbDmEs/2tk1jfPlrFXn6jZ9P9nCFF09X5nYmVrSgENBXc4BqUtoKGc+WRTYcphZEApsI/xg0dITxj/c65Y/wB4UQx2VGexlo68qtRx3oQcsAa3VVEFUc+Y3mRVsGqHPBH4dSGLtsuHBfZKRnh3LMjAZjpfaeYBykSOlCePQZXvkTL2cDJg8v3wjDgp0nGQAtMkxS2leJOLUG4fnGU5pOxNynleiPS4i7vppAc2hHCk1d6MYPgXfUkE8OFV61zDx1h/T/Wb2GIAMrNCt5H7cHNZyQQLg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(261021123027099003)(261009221227099003)(13003099007)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7TX8zTsFT5WdI+aZrO8s8Quyg5InfH9GkzZfaOSTAfF+inhe+n0V72m1JLn+sEcsyjqe35YRYCegZQG2eq2qyW4nzO/rI1cFJCO9Mfb+JSVyJiH7EjUIQ75lSSYC1izwZh1CUJG+mVMMsqkhhq6yeaP91wCK7ceYWj45jIaSyLgdCwB5xpjKR0LfUg3LjiqibXTJut48EgLYpyLgfY6y2ayUulhqjyyuABfY8POy2HK7mOGE4b1nOhR17qhFqbfX2nwvTIlyGBuNRqmcsn51K9xLqsSKngquTdfpmQg43nlVcLvM59917Z0PHW3a2YFMIoVcNhIA1flQL9Ot4/7ORsbUe/YtQRiFan5JGIOiRJd6chlEatfxtb97EXFDNlDJpvJTy2xr1bT3tBSRxk6BEUncgTs0uCq6/UTnoxgcznbxiPd3ODLpse9wqAo950Gy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:27:57.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5105ea9e-9779-4388-bc02-08df4523f0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4

On shared-memory CPPC systems, cppc_get_epp_perf() returns the EPP value
unshifted in bits 7:0. shmem_get_epp() applies
FIELD_GET(AMD_CPPC_EPP_PERF_MASK, ...), which extracts bits 31:24, so it
always returns 0.

If firmware initializes the ENERGY_PERF register to a non-zero value,
amd_pstate_epp_cpu_init() then caches 0 in cpudata->cppc_req_cached. A
later shmem_set_epp() call with EPP 0 (performance) sees
epp == epp_cached, skips the write, and leaves the hardware at the
firmware-programmed EPP.

Return the 8-bit register value directly.

Fixes: 555bbe67a622 ("cpufreq/amd-pstate: Convert all perf values to u8")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-bfeec24a-9e2b-4c78-bad6-a4f5dc0273ab
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index eedc5fcd9c542..6136437562545 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -278,7 +278,7 @@ static int shmem_get_epp(struct amd_cpudata *cpudata)
 		return ret;
 	}
 
-	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
+	return (u8)epp;
 }
 
 static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,

-- 
2.43.0

