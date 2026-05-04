Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD8391822;
	Mon,  4 May 2026 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935722; cv=fail; b=tWbMzLgMWxo2tCQrhVuD43LOIFZ2y37tqZTz3Wu5lCw7oHKlTqhKpPXTdf2PQ5zU7WrdomOe66s+qI4StKjCZlU8/XOIxH6QAvnJSorn15xCKO/8FCXbUA/4jjbFa3WGLGHrX4LQloER6qmLPR7ifdtnjTnxufC8gVYSFqfYFp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935722; c=relaxed/simple;
	bh=qUWH8iEvvQDkeVaNdjWkgfq+hZh6K4dxYy/g8QYHF2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDIczj/mYdTnGaV3sYun6mtUVBDXF/+gN5xBUmtWFG7yu7o7clcEgfx2xW5vs3n5V+PbwKfaGR1Wn0VauhchV/v+DmebgfhtGGHjuLFZtFat/v9medAxGn5iRs4Vlpgk0wDHQ1l0NtMe+mUaT6muQtMlohLsFGZyYbW0HjiUc8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sMgERIiZ; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sMgERIiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHcEE1ar3kFrp4q+cqUh+W7yawCMC5mP7ra0MT5qAnTix+SgoQ1ufGg39SCrzpk3Mv5dda/dLMeYMOvN1xFXdD1Nnlkd0PocYiAPFnPpyoC77p0mZsJFoFGGXr1li/qx2dbLskJc3xHBLIhmFK6u7RnVOhGbvxTzv/66RoCFTl9py2nsHJ1q85NJFFBK8A28NsG0llNdvCbsLyP4g4aEGOWv0QxVwiYkBEraXhGwMlggZSvT3WeE6hrmEDj2swE1OcJwmqQ2AKPS9xAIJhLPi5H6pTdcyo2WIUbpD/QYVXqo9+xfccsus/T/6LPnX8mBhyVwVx+UmFIhFvFX61J5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebogru3M5s3gWGQV9Jd4N+OmTep0IHAkGzzU/9d72Kk=;
 b=AA2+kUzKN2MGIKV0Kz5yfFW9CEqOyPoHv9StyQGbIMd7OdV+40eqAIUn0rMn/esxx0mbT7mMuxlyJViFxaqIA8ivy3Vj+1dVZ2DyqlsZJDyOiyvQxzcYJeYZwgLre0u5tgMwvGA3BRvSH4t1Bc+57p0Q8CgXvcHMUo/mHfApRemlECxYGKqnu6RO9y3+XN5mt/TlMa5HH2ITwFQu9zoP63Cgm7hesO+TA0rlUuwSFm/fbhYp5x66GSOd9dx9byNcFwpujV8z+PP0V3tzE5VrHgw1gtSSBu5TXQQiGypqV0mqINCHcle2hugGF3tCuk2zRwm3maEWR9X101X/IoxtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebogru3M5s3gWGQV9Jd4N+OmTep0IHAkGzzU/9d72Kk=;
 b=sMgERIiZuUDhEPeT2wzxxCAaLAaGZYibVR2+3AqWNuLCmv+u6HbLX4gNqT/2Apt9THcyHK/msSnmIMRSoPdUhCTdsgh9O2qmthIkTO+2kyCEWXACzrH9mIimKgXmQETv1tdJIZ8tvgHMOlJ/zGL91wcbMZA57BDKMHN2bvvGqgo=
Received: from MN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:52f::10)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 23:01:54 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::f) by MN0PR03CA0004.outlook.office365.com
 (2603:10b6:208:52f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 23:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:01:54 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 18:01:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 5/5] cpufreq/amd-pstate: Get highest freq from CPPC if available
Date: Mon, 4 May 2026 18:01:41 -0500
Message-ID: <20260504230141.484743-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504230141.484743-1-mario.limonciello@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: e27cd62b-4609-4397-640d-08deaa3122a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8W+9qoH+xnhIO+X7NJkQMAqF0uyYWj+zRsxSWwJ/FkCnZpCtb3dpdnch4wGDP88n7kdSIG114V8+b7xQAjZCvhZkE7TOHY1opr5uX5jRrWVftWnEw8dgPoFMfKwRqsGNycI4una3nyEVEiPEvHwBl9DPcfYZTPYNC/unAKaQDrw2plxTqSTcsg5AMv/3f6zlIzxJgbmnxOESfVZPpv0OMawaOIkLb2jcac6hI/O99R5X08xNtVqhj1nhjUIGAb3fW6w5fCjkEhmJWytOT0bN3iCcJn9IciVBUaI9i0Ur05j1CV7RsmNif+r2BetAUIZhZeEhd1fHa+YwGxZjsxZVIPOlOPTf6kEKtgzMh4r2CC27czyVO4lPMF10A65Bthtbk6JNLPhOefKkbHtojZXmCmTSoiHgM8tv+OxLnTQiBzIwE+Rrwp3v3+OJHhH1xWDka3oQ+rpbLOhRExtcO5gZggheXlETe5T+MKo9A1YQOPjL6fYXxaLfvYePFRDsNR/W/JntFX/ANAiGZuJPr32jqsVjetMAqDW6eAD/11rRPgQfnwdpLBhDRQTDj7Uoqvt2hN6DsI2cn2I6RVuf1eIAhYwGWsD22AWLhdXl0dEGrtIScQTgH6cHQ32iaggaRLRzSbMoabWsPZFk3nM6gRvNo5cM20Z3+699FHmdZW4gQLGKXk6ashbYi2guk6CrBS2lkQuvYbVSuHc8JaxB5LcP4pdQ5+NRKN7xuRX4OE8VKHs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S/gSpOSSOmMl/u9VsuTmI7NIel+xvW/mxWe7WZog4Y+1fOQOf7yTNyhvKOxXQ63YdFfapJteLrPGWEKb2T7UYyRzjVUR4N6eCIY3jsQu8FYpIenk3YaAVmfmRBkXMgZa7AeyU8cmAhWH6u+ROp3i8R1ce2xO0HpAefQ/21BFJTj9Ff20yueEQSPOP48ppWqflD5HJXM8n3W0FygLJjuITi1GUWUTs8QAh670S5yxg2iU/2MWxKfd6YWzYJamMhO8yJTXIApfWvsYdhENvueknMI+LARBDTIO4cPeKsCIMcHJFGAY8vpIbDc50dHePD7JkVrFNo0SjyQUq+cvWMc+hsc4C5soSj1RYCkcVcIIu6DG+htX/RrZQrTjZ50RdrMCRFfN2+VeujPMeJqLJAf5n+WSpXtkIBrSaKzfjIogoUDBRd3GUaK7jjO1psLl/qy6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:01:54.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27cd62b-4609-4397-640d-08deaa3122a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

If the _CPC object advertises the highest frequency for a CPU,
use this instead of trying to calculate by linear interpolation.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f5c7cc05220c4..9703b54ee4820 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1026,8 +1026,12 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
+	/* max freq came from _CPC */
+	if (cppc_perf.highest_freq)
+		max_freq = cppc_perf.highest_freq * 1000;
 	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	else
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.43.0

