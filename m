Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE624A2E0E;
	Wed, 15 Jul 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137419; cv=fail; b=WGB0RmAaaAh3XJIipFpCtbacN4Ckd2FY1XgaiGkt/sVWX9F9qmYXfhxVGvqmZ2VtHlHnmCHSYE23GRErrqPYXFUz46tat58SCfDgA4poDtihFHgxUezm68UtE1JGtxJqET8Gg4gIKEAru/BaFWSLxHQH3aE00OO3UyJwOnQMujc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137419; c=relaxed/simple;
	bh=+rYkYCZ09A+5Wq/Pe4X3lJHMJh4D+WUUwUujJkv4kDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rYmtvz/fknFcABZIiLkpZPSfAtxGtgaojIaqgkT8P4Lwo5oQ0xQRYYvmZrsgcASninYp0X7aDRtrKi34YNcAgm7JFcmHYomUi+7UJ8w7W7tA1oID9JerX8nRBL7jUGjWCGfzydrFcyybkz3WwVuvlU+TLifw7wrbofDPIJ/4dAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZY1vFiCh; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZY1vFiCh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRO2EeFQo3yj55TTzfZ1CeRfq1jbiaoQuliX+juYNB/+7CMEERdTdt5q+pTtmJc1mZ/0N2Wx1gUhUJMC3YA8wT2BRZTt7s/XoZTKSaCmaCFHEmZ4NlFeTK9jxv/BhiMp7wsAMkSx5ZuuWwmq2KsINZ9vQZ3vm4fERsPhyLxSXCZ1yqyyaSnt1uGdvnePMzKWWpYEkeM6hUXLGvoaQxM0jEm1pIJCgpiTNxE4G74RZR1UWQdCJXYgQzLjdcS5dXLK75PhNe77riVqh0ixupP90X4L+n7scOvKwkFYQMgI2h+ZhBfyHRha99PHgU/1rr5/ew6b+LKZ9HWiDXCfHJzOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCNrsDhrpi+KmELNPJfnhEzrCIVKawpcWnV6TanINWs=;
 b=M9+Iifo8hroYSMpzS6zZsTvAPeeZJORQrewUl+cBq25j0DfUO+zfMRMImk41rSyu6s3dHfSEzz1tsCQtdGj1uAg8M2XEzoQTrsJ18yHj2YiXPca0tGgiFC/CxUTyXE0p6b7JRC9olO3RJ1KM+yNWyKJKOQAI/LQICRNAvtmoa2Z32Fe+b5v2rAJEDaC7W1CbkNwjmX/w9PoWR0uJEIWNQgf7CznCVURm8zEXkpBe8Lh7Dc/P4z3YpvPo4yB1cBLvd25Wtqd+LsujBFAfQH1shyI4fcewndmGg5+mvLaE1K+8HLhS4nsCaUazJaj7OmBKekC5PHBO11kriBQffd26sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCNrsDhrpi+KmELNPJfnhEzrCIVKawpcWnV6TanINWs=;
 b=ZY1vFiCh04B58Xu2Ui8ZYTqRm/TycHbiyxKZmoJEeqzeBdd93tnD0YKlW7tGy7aCCj3AlghiWjn1Hjr3KRo9Pb9IJJHcjaNNP1jZXKeSTVg9hOip399xCq8wjHp7powfHQ6jkdDNQnn+i/akajNj5HfZR0uiJ3t9dY5EFVStDwk=
Received: from CH2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:59::17)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 17:43:34 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:59:cafe::60) by CH2PR03CA0007.outlook.office365.com
 (2603:10b6:610:59::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend
 Transport; Wed, 15 Jul 2026 17:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 17:43:33 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 12:43:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Loosen requirement on lowest nonlinear frequency != min freq
Date: Wed, 15 Jul 2026 12:43:18 -0500
Message-ID: <20260715174318.18235-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3bf28c-5d85-4bd6-1892-08dee29897a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WOaJIQOZ/ez9IrPFq0V9k55PllY6h8WaUO3ZYiokJsMJwdGP8BPItBvsoUjzCMBdve8mtYtSwJfem+JDbXc14vlLqIvbWAyMUS/+PHOrN4jm3AMRi+Zhtn+76wyHuFKjylsMwafD5StuSqzv8I5OOLP+96evcKmo81+Bonz1tYaPJeWljH+Vjseu9a9KvMN4/fir/JH5qi4Fw8dMupYPktSA+4ZWgB+D6DBqlI+Zy45TvRZlaHQWkuPdodR8IYDiz2Fdp5wutw671q2/aoc3cZp0WX+fcWYvNOL3kqQjYH60SnmxJ6/bajFeYffCQuMyfOJIS8/DuiUHSLdERwfFVGTzCvL5bpg2ehAjlZ/jXgDs1z/kIeM6imJUUyH35vp8dG3XxzSoiiOq/sxiy1qot8pOHIgpsTWLVfwHv6NlGJZJ5STnA/jh+nWUXO2yfHkYDsc5ex7XrAwmewdAbB9tFXKtmtWdQxG9WHwH3HzY5aUsM6o23YLXOZULDB+UqpqQd86vVh5v6erBbofLG9yArdtBJb0nExnBq076LWyGjwxJs6oUiBf1zOzDsI5JY48YVapQpklVZRsz0YcRMNRfwE58CjMnyF1+a0WoMsV3ayL/n2iTMnclbnqSqi+tpOdQMTafxN3cI6koMndIt/RkdrRnd8K0IwLYwv8m8wjMAMwvX26k1wACLdYbIJCdyzLH9ZDXAApcx69t6SpUPAXZqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SASwT9iARNV4S4WVE6Ert7klDixXlySXeMRbErXYgmQTKmnGoe3UTD0pCw+SeN3WGwp5gH/zWnO2xqq8FKBa7k0HBEp7MdAhlfVq8XXxlWvFvlnsRyvoRlDwRi/qGlvKkhbiXRxA9t2vrHFdf3CCwccCbHYM/9xYVL5Mag2kRmxbfRzz4TbS9kQksaGhfGC413tGjVD35D50vN4slVMZKPRHuaMa39NnCFHSZW/qegqRM9N/R1ocbQQaQfrHtJ5HcGQVejlg1D/uooTrCgS9XdyEHHxzBaQiVe8LFZV3hSglL4cJDx9mqJfKaGjsjRXeSgr2dnwMcMv/AqS1Tsv/p+3eayC22ja1wvY8wQ0fFVPE1bN/psV27zmUAlQlEjI8eFk5e7tQg652xmY3uhI0ZrNkccYhskPJLHH2rPYvFjdu85msw/HitIdl7vZbGH0R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:43:33.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3bf28c-5d85-4bd6-1892-08dee29897a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

This requirement was introduced by commit 8f8b42c1fcc93 ("cpufreq:
amd-pstate: optimize the initial frequency values verification")
specifically to aid in debugging BIOS issues with invalid _CPC tables
on some older systems.

This requirement is too tight for new systems though as some systems
actually have lowest nonlinear frequency identical to minimum
frequency.  Allow that combo to work.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a74a4cf99d22e..3d72337a33369 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1031,7 +1031,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 		return -EINVAL;
 	}
 
-	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
+	if (lowest_nonlinear_freq < min_freq || lowest_nonlinear_freq > nominal_freq) {
 		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
 			lowest_nonlinear_freq, min_freq, nominal_freq);
 		return -EINVAL;
-- 
2.43.0

