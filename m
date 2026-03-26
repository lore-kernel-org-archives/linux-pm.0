Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AC3F786B;
	Thu, 26 Mar 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525711; cv=fail; b=W+hRMjrbteOT5C9rMqphZm9Ycs6FL/mPRW2cyRsRvY6sBGoLzqlCJpgfJ7IIzZwm4rCBCXg70T6XJhRx/LGyIFlZBcDabBGvGB8e8InTLqMs10UWqUyAXxjGfhaZhvK3fdLYAQlTZZ+/CTGxEkcl82vU8uRi3g1CzNEbJnlQo1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525711; c=relaxed/simple;
	bh=ib21pnJqnvr4fNN8vtSNmCTlO2dcGMy7YSXo1/zshcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+T1K/KDLod+Uc3/oUMa28ZbMWDBiaXGNdirVPr5SAO3ktxCdxVBIBwP9RmlmJI/H6UG9/aqqjnZJux5pY1YLBkkAFFv6J068lr+97Da+jDrcFpfT83/qMs68e0z9469loM31nyx8bk4+d7QW+rBuK7+aGAKJGRR+QgrejT24jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rybk9d1U; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rybk9d1U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUqBusFwwF3hgvS74ldGe4gdGXdT+5K9XK0lyS4dRgm7khJYDAvsJ6ahDC2BnhRgCSUJfVaWm9Q5z6/xohCsQxdjeXSp78ok1MLX4hFuqEGjWlADRYipyag+hcV5J3rCYJCi7PRGLhd/P0LBAwBnKGlBVHnhGuaFDKvTu3rl1PepA/QDs0gee72AWsAFoGMNeq1cLvP2KL0/wEarX0C70W7aECK8Yxj9+UexuzOTgxRfBanYm8Bgxz2IEBblh50PyCYoRW3xMY8LTK3snc6dWpFOXCgEGsHxtxZYaUC+ol0nh2eSdSv6iaIcEAfJBSHlXc9NfTCGMy2Q9BHjNdNPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277Jq2NRJTzZb1b3TUupKpl4PLQjWNP03zSA4NRO6A0=;
 b=EfFLYVtkjLmWq9T/8apJ3dVN4n8NH7nOv/TX71wOw9Gkk0PTqWUHEWJ+iEUdFfvmENxG1PaY167rOBxV80EdCrLGJIfp3kGCa1fxKYKROOT0+wUtBLiBKBiV7VSxKBPGnSZttOXzMouI552axsDwIvSUbTyi76KKa5mOPIcw47o4UOzIP44iUIQe2mUawkKmM9fCe++3KmcOASNHBxiJm8mj+CbN8DfMipeES3SbaaEXeSdUue0oFJl+uDk7y64esInXuIhkVTTvP8DuxTYq2eh1/XMV4UFgt4S8WjfrjSvcoP2qRWoTM0XR2SckMQlmWVqKGnRmg2SDQldbypRs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277Jq2NRJTzZb1b3TUupKpl4PLQjWNP03zSA4NRO6A0=;
 b=rybk9d1UErxludflRpBIjINyZpBZPdG6fcEbL2WojdLaOvwtOek0vhDNqUS1KLhT3NxT62Wr7oTLx7N3uMM9CCuz9oqoIqxQPhg181BnfAB6eAoleo/otczBHnppQmnvksyzFj0m/UDcbNvUcjig3TVG/ZM+hlkreSPOUskxDGY=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Thu, 26 Mar 2026 11:48:23 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::4f) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:22 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:20 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 02/12] amd-pstate: Update cppc_req_cached in fast_switch case
Date: Thu, 26 Mar 2026 17:17:46 +0530
Message-ID: <20260326114756.20374-3-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b00948a-afad-4cbe-08f9-08de8b2d9574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	q6E1dwaAiqouqBcK67gJ7N2OK6RFMChVBWnynvx4TjuV1Nb9GMgst06e/JkJXEaN3kFDGcpXx2MBhDt0yjsoNNebc9C4s62nWOMAiH6tGRu9iqEj5x9mcWtx4Nl10k5Cij8fzqenYMx+ycRVSp7JUoEC1B4RKSlkcJSUJ6KmJsfU0biPgNZn39XTZQMKt1E790pmsCvhSmPoV1Ac2dp9nVnCMa6M9ym/faKbFduPP3/+Cj8R/Sj67GqA0nkumYihne2Vqu3g/dBquL6IGieyVgoHR1dAT8xj9xRh+iW5D+r11X17x06ygXRiiuBaCAtU47xqYu+2m6PT8KI3/X9SysFMaiBfOvipTFUl0eZTwppA5ak8BZOkBFgo9/6C/uqvx0a0py7dH/+V5FzdFSk96AQKSPRCavCUoVbr29FZC8yUedbzSq6bFJS5rL4fIJX/BNNRowkJM/Iynan95F9ZiOyYdJRdOoq3hJP+mAeXaG0FY7av1/r6oD3seHF5dhj4x9fhtDfZHDnqXUWUUGI2Zcv96LdKQ58G2+FZZ27n10Yyphx+JpFe5phsOHEUv9tquQlByQiQ8fmjt4h/Wzu+VZK3D8YGqIXMLii/mao7Z8HyjPorOxH12/tQb4hlUmuPVUqYvUKDy6LmFn8GVvctgTOTQupDOdE6xA9NrejfJNqdABDhavEeHkbPpljafMX3osuv85EVXt1Fuhs+8DQ21oiCz5Zq1ZnCAMgb0aRLRiSLQ77aEv9HuKdUfdzJ9naCleza6r0FJGsqz+eLy8CdbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nqMc7zMwIVOkmJt1vHlGnOVYLo/FlnOzNrhdAkkv33EcWyZ5R+wbAwbi+3Uk/lqgWw7gO9PGy3XJ4jmN7wbcJ0DgbNeW9TYKbNZDNgA4+ukecrLyLPXfLbOLpdkmA88Kcuzgn6Eeyp88Stc9ZJ1ZEe9kOq84/Wb3XepI66nJVkh2eV+GW2FerkiDL5zlBW8vtVIClLFUKfuwHbRiA4jakITHUM2JcA7uO6VC1O0OKfAWoEbjSAhkDBpLwHpyw4z8nPAbz+zlp1GpjmJtNuvYPOjOutyvQsbCk+rSJ/Qofl99YcNSxGEgTL+n/8Zv/T4I/2/j5K5wvCR1JH1uIVpEu7jmd+6oZLIFvy6c/tWW3flkPgLyoyF3kTFs9DMJSxYim5LY3tP2KRfCeFYAEywrOL0t2YpXaIoaZhYzjPYBBnpwQtV2p7YcvWQD9bekIiX8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:22.9817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b00948a-afad-4cbe-08f9-08de8b2d9574
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977

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

