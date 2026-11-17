Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886669;
	b=4H1IJx2QH6o/feWTZpTsQ1fGnvlvMjFaO6hUZJ4vRRw2Nkq2SnOAR3Pj/T5z9Ip/h9ZD
	 B8iuinpoZp68jLi8VSE4sZF5/QbTTGHXmmNS4Cz/78r101vWTmT0Qh1RWTaAtfKudSaOt
	 IVL7lcN75DQnsgZ1zGZENfP/DNjaqBB+I1fEWWfJuAgq0ew7T8MiuzRFh+5VIkTFowWQk
	 idPCj0APOW3+tnhvwQSPfB1LtdQXA4vFphJDtvAC4uKQhR7O86x5HFvQTeyJGIZcooD/k
	 qpFcoHrp5cYcr8qj3hBdUp6UtPwn73wUGMwj2TUaJJEKRs27e/Lk0vxkVsiYIYllKAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886669;
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
	b=yTTAoJPsi5JtYOfM7OM7bwUeWwzFnXJjjZFdrX4/33hPlKDeTwmV+3BH4MufYhzYTwik
	 XU7Le4+3nAtz6OTXAsksu3Hr7ATOxLjppzKCa5FFFKgL464cd0th2hwUkUR4hGHBacPkg
	 5UdkdNWKi4b+/I7tymzPPQYlDmDLjtoQE9tdChsOPKhu4PpnYG9R/q8GHR35YHCUNUt7u
	 VSCmlR45ARHFeSmrWQAl6wjtFaBMRaFz9B4AgpsNVER9N6hmlrq+9poPl2ssPSZ9sx8xw
	 MSyh8cspx0CWyqkVn5MtiL9sKZcwoyjcsXzCH07fL9BnM8X2OX6tSdEcJqRuWUNaxyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UFOtgulS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.31
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A149606A323
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A149606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UFOtgulS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDHuHMJ4ufrm7qDUW3dPjJ2H67qHdHmZl+Gu4RRJI0XL+AYpfl8VEZY1fFdiNQ/pZ+L6K895h7hk33cgvE1GqFpUW/iAONUVosR5YEWG22oSv++7Z5ssyyZuhcBnOi/K19chGTt/laRBQ7kq/pT0SZzIKHz8+UqV6nrqccfaRw/S3Uolhg8nit2lVOnd3LnT4wGiCkotlR2JnxRJjWgvdVfruvDb5x0rvQUD/P9v9ANffCqvmdUtnmNCcY9Fz42alQ3wrAe/TxCVkmBSidse+3ZBY9i+12PUeSYU5gK6jHjv8lkLkd0O8BF3q0ueyhUxj0XihLEfD4u/QeeCSJIKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2UW8H5FEMjYzB4pBbjcg4Yj2UrttMcMMRLOaGh+A64=;
 b=PsRhHLGs0qhGrjtx3w+LWcnZFoABpVlSI1GORUBmEAocarK4RnEIeOGiQIUYXlaUc7qBHpJWwC1FH8/D0nGLEmDrfa55L/71eXUfM1kMzDm0FRdJWQzu2HDOmMNmgdeEiE9R/J3AWRo23zPOPfcD6g+4jkJufLfatHY0aDuLE/gOAKZIWDJGvnP2w8a8HRNwmGw6WgOVYGoUzuKdM873r3ilXGA1lfnf3NYJyVeNfeyd+5+aKnqu3zR1c9SuGh/N/Bkv6LD8QoSxNokGQeu4/UsS+p3cVNTu8459Cc08EuupJn3z3qrjK4oPiGozGJy30jCGLv1yLDB/7/jfLshW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2UW8H5FEMjYzB4pBbjcg4Yj2UrttMcMMRLOaGh+A64=;
 b=UFOtgulS2Huuj5Iwmal6XDAWFKtDG7ADsHW7yfi66ZdQPZfAc8DMxNiKGkbmq587pB8EhSeXW1kvwJvw+chZVVFaJ2SscCntQioJ0VV0LmZx+awZl01BPyQPmle6VkHck5xbYGdTzuqHu34dvWh+L0c1J55TK/fygekwAVRKYxo=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 17 Nov
 2026 03:37:44 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 21:37:35 -0600
Subject: [PATCH 2/6] cpufreq/amd-pstate: Fix EPP extraction in
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
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-2-682aefd4fed6@amd.com>
References: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
In-Reply-To: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 487a5848-3849-4efe-5231-08df445c2435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|13003099007|56012099006|261009223027099003|261009221227099003|261102123227099003|261021123027099003|261021121427099003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GzX6wR+F9M/NlsHazwoV71reSfNCc2FA7DOz3SyFYlEdwnIeXHMW+8rvpOwhGjsD0PmxpKGLYfv8kzLuRHxGrb5X3RHqBnyu+8muKhRxVo7z+WtnOY8m+AAPT34/gq+n9eA03zqcma8fq8CYMBNUCDKnybkpuwymlo6/5gG63oaPxD3mBCYhlOqd8q1DDl1RmKGvVIskBYWX2S92Ax8jLeh3bBLsMOenlgVjRDuEUGSA1MpmR9aI1hYxfUpSZOSWrVwUUTczPEStvYrt6qMIvarFtDx844OML0mEATV1ZT6idWSvY3/j3R+cBxsVoYKUQsrszH1rucQ6Rl/WfvxPEGI2CLiiuBPcvSKyYcFoBR+y/sQuvllBd4IJqGRpPv0K19PdJz1BgSjELBxDjNAhOpEpelZNK8Fu+hzYY7kRikneGPrznXQbuUMoRQBCQqiM8pfNZOKVOwaMSm51/VKwYTVe3/sI0vY35SEy71yrLnD4Mbj3EnyEyGBgUBUcQFLWtQdN0ld1LZ0DOaPT3ECCWL8KXBe3gmSBkAUeCHof+k8lEVhQO6i4924P0t76QEodklLBwPEttzT+OgG7NUFeYUx2PO5T0SVLyQA/82WUtR65L3uHHPWmJ7ZJZkAKIaHwtY/KcFDWIN8cNY+hnKuKkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(13003099007)(56012099006)(261009223027099003)(261009221227099003)(261102123227099003)(261021123027099003)(261021121427099003)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2u+9v0DKBh/ZkTt4tIa9020BiibvuEah8TLohAo+ttmyBU9c07y66sYmtzVCuX31awlIYc7X2cuEY2XIsUjd+wYnglCGqCw2fLGtThEkWz3vqlRkSEZrPiV04+WmDjKMBfZ0A3XKoJNdkTV5pmWZEwtC3ypXw7QCMnxhpT6p/jELbeg05hFhduBeJhmG2FdMrarQT7d7Gg7kAPO6E3WRLIU/oKPzZ4h4k9nqJH9T4mTEkHkztmQg2BEwgZy84aswJtM/GC01kxH/qRmziCGGCn12iHLygVZHluaDurEB60D7XBsbsUjz74lLNhQ4EF6wiHwApPPqrVOab/RWKeZz3535yFv4FSYUJ/luXxR4r+yxQT1xRojb3HAwqyRMFcoi6ej1jzhsmzFmTXoj+DvnoVk3fUgwNycKrUrGKVyjRxZwy24lBC1A/ZjKAy0nywkl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:44.4257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a5848-3849-4efe-5231-08df445c2435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

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

