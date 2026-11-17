Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886669;
	b=B7G2gOg/uJltJhImYT5RRnCNBkACheThY2L6PRCz+HN5eYFJmV6ZUCo5JfAEcoKqzSg1
	 KDOBldK5oAe1qVwAL4Kzo+oyxVYZb9qVvzo9bG3TQ5jkj/kq/fc8ZavWsvhrvwpwiFNIV
	 df02oU0Tydji0BmiznAW7sA8ZJbbCDFWG0l2z6WD/2TivwAALKpEbgDQYhAPuwsAWZNFR
	 xz/HeL/lElkOIrKEGS+u+IdVxjZc6eO51vLjFgTjKF/WfEEf6pfmz4IXtgwCMkm+x26X7
	 QHavhmYWFO6nAKVweDxt+2QuDqP+em35K0b5/xvC3bwQ1tQBu6sdH3R9lnyUwBPVOow==
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
	bh=QPuMb/TxoDoq/S41JSzC0YSippmho6jDslMBTEVsupw=;
	b=t8b68PvlLMfq6xa0qxrsZMDlgFal8riU7xwxJ22LCk2Ia1+bAXOZokbMRC24jedLwb7k
	 nPYDoQD2MqQe8d8/87RMgXCLWeVhJ4qBxQ225VjIDHxhojokmKAhq0awNPW3vxROSEXHS
	 P0m8vvXRWaOEjl0O/AIzsAISptosa8qR8Kw1YEn7INqEtVk3ZAOdx1SPpdgTfq3lMqbuE
	 KcTEy4Sn4rzdAlHj8ZjFs+eNTej25Eu3f0NnCnASpCqbyp4F6nrflwFfgvLZ8n1fM+Lyh
	 35tpB8i16zniw0ZxXMQY4HCvguZjh51nGAllixXTqfYgI3OzYUjCfBRiIz7YjoMwyYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5P9c7XUZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.50
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C1606A330
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 247C1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5P9c7XUZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CARbzAhXiehahM1omWJrLxhvSbQUe1SzUrbEZcdYHfnu3wNBoWZMA70sAwmmLMSdRUZbvSOfLabibQuzeJIT19u003IKhWu2fWv5aY+5o5KL5NI8yqYGgGtmXUuBflzMXza8G499f+svaTLE7loi2R7qKM/srOihCm7f1OGhoBJ7CcylCv+xVp2DvmxosR2cPNHOO3a9dUOQbZv61aVAVUN/sudSSzm+5KjOyZaSsLwFCGxZnAgUhflMDQu4gcBMeeBQq7+XRrpuE2uWYajGibdfUsiVhueVCfRAkRQJ36c3uxRrq/bt4c3pl+2sAm3huc1q1mPx7veSTD0UVHKHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPuMb/TxoDoq/S41JSzC0YSippmho6jDslMBTEVsupw=;
 b=PVfRDm8HRf56EBfyW8MtqYURMrqxYRRFcqPr5NdAZ+21QNXCMuJ5MpjpyDHmN40PgiWDxUmspoeAfeBD8SgnEHfNEe/WUEVF8YGlyvkCL2u0K3FxCHudB+KMrRf5yryCvWBf98ve8gubDTFMCSvBbI/4CcwFHs3g/N4YNBC7PVwnJ6mPiSL7QnzoKlusNJnWJob4BtRmM7oPZjSli1MqFFADs6hAXsjEziroA+4y6oVQlpj2R8AU7OeXOxFOMjxfnLFKX/PDZ9lY98hWSVuN/Z4qPHe/WP6v4lp258g6gYJ3dnuDWcxt237FbZWPcQv8bpGF/iO5etWi2mK1/u1/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPuMb/TxoDoq/S41JSzC0YSippmho6jDslMBTEVsupw=;
 b=5P9c7XUZmYJV794Mu+T/8rjlsRfODO3McXndGIMpFFdWOUBpcFC1JG2Lq+cvSpaSLsWaMg7ZkDSK9CndPVLpQz43LzgtV4IoICit+VZldDYtmVay9ApqTAXVYIMiBpsrZfY8Um1rXioRs1OQo6I8QhsDkCacv1/EPzj/T/JCNec=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 03:37:45 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7c) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 21:37:36 -0600
Subject: [PATCH 3/6] cpufreq/amd-pstate: Fix unit mismatch in
 amd_pstate_init_freq()
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
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-3-682aefd4fed6@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: d0905eaf-72e8-4a77-56bb-08df445c249f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003|261026121527099003|261021123027099003|261009221227099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	xaNLbrgqhE9ApPcLWEfPcyGFz79sGlJc7phYC/mTnRhr7mJ+9/76SJVPh8e5NQCxwnm0V9xzbFNvj/3n82GO67H/suwZQz/VMDOvOPO6DdvPLfFVdmXIM2dQVOhyDXYvi1KI7iei07n40ol3bFPOUXH+OzoIT68g5/+V5f1BhplFNthJShd6Vds7414WlXApQDqvJ4Ntuw5AXbMiRHS90yoIotOtZjvpyLkcfDOt0j4x8WU6bgiUmvqBNbBXrkngScROUjp5qviQKTSXKbzeRciJfXaE3ff/kmFfTFfD2vBesHNS2f/SN48h1W7y42zxBDU6b0xjTgF2rjhiKx84FnBtc5dI9ieYz5GhxCC8r1qMRZ0xLS3f23GJZgbio1yo1r+N3F3HbDxNqIkEghEMRXjd1XldpdiAjBQ+1mdkFX94+I4Vx6a1mH30ndx38CGXR3qp/YPDxKMW0sv1AXfHocLIGeuK+8jlhlpoDgpVPvKZN7WBshQeMXMWHxN+A6HHZUEnztJMZm7IUcI73a473Pev/fV7lE8eoqGnbNggy/GvhLHIXj6Hr3KbCG7zJkDsq62Nzg6rFS2588n5xt0z/rALyZprun4L7Mb9hMyUFnVeieRJRXjFiKIiKo7nTGU4ckqNAH/kCjGTsI5yfwKuEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(261026121527099003)(261021123027099003)(261009221227099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XO/49z96lhgD7g7ygedN/ZNNG5jXJW/HBNyFWOfS7tDzZQWs4zqk1g1qnW2ou/OqO3QJN/KPDxzP+QNDgvJFo3Ay6fKvUT1fhYTD+exuDW5rabtbCBKT28gzZLI0/vSWGZOX9ADeuPlOQ4Cd/6C9+OmhPC2NdkYsn/Fy5tnhVW8gznrXG2auGCVP7mPWKzS8h/WOb6RRDTCaRGZgJJiJqECxSdwLYEVL5wsuOysBk54vR809cWCAb/MgVdboKhQsOB5OgFOpjusuk9UkSafQrsmwf1qCjJtV5kwUUuAXEHitA1jFDmOchVdbc2lCbZNwE42WEkDJB8669vTfJOectZMO8gCwAH75IqV8FjQTn7Fyx5/TxuDLRmM3P38rt2jCFP9u41L4KCcTFBJI8X6/pu1J22EhxvwqwOx4KVM5bdG2F33TP8a3LpAL6TUfSFJf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:45.1177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0905eaf-72e8-4a77-56bb-08df445c249f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

When cpufreq quirks are present, amd_pstate_init_freq() loads
quirks->lowest_freq in MHz and passes it to freq_to_perf() together with
nominal_freq, which has already been converted to kHz. The conversion of
min_freq to kHz only happens after the call.

freq_to_perf() divides the requested frequency by nominal_freq, so the
off-by-1000 mismatch yields a near-zero value that gets clamped up to 1
and overwrites perf.lowest_perf. This defeats the purpose of the lowest
frequency quirk and exposes an invalid minimum to the cpufreq core.

Convert min_freq to kHz before calling freq_to_perf() in the quirk path,
and do the same for the non-quirk path so both end up in kHz.

Fixes: 009d1c29a451 ("cpufreq/amd-pstate: Move perf values into a union")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-515ed05d-eed1-45b5-82cd-41b86ca2ee88
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6136437562545..e73f30b6fb30f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1057,13 +1057,11 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	nominal_freq *= 1000;
 
 	if (quirks && quirks->lowest_freq) {
-		min_freq = quirks->lowest_freq;
+		min_freq = quirks->lowest_freq * 1000;
 		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
 		WRITE_ONCE(cpudata->perf, perf);
 	} else
-		min_freq = cppc_perf.lowest_freq;
-
-	min_freq *= 1000;
+		min_freq = cppc_perf.lowest_freq * 1000;
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 

-- 
2.43.0

