Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886672;
	b=WPHrd2JW9fWkbreyAyRC3+Ia+zAJH4N+vEUH6LUGwkOtXllC/m3t9VWQS7uJ2ZRjUqLx
	 a7GV/gUkeSCpNcpsNBvMpnlNkkCui68e1SFJlV8E5RLjJf/0K9b4lObpcvBG9yKcli+xR
	 8nayhenMGTAFwjYTefNIZAZOrZu7fE85Pz8gtf5My4BG16kofoE9ar9YhqJHkIVTDNsYH
	 hIs8CKyMgpk0HgbQIaGVVnkmgcdS81viD6NjgJi3KiQU8KMBi1b4h5PHw+UBXFJm8UGg9
	 4YAULiuQ7CfCPKyWBLLDgvijNyOBUrMaDZTwTps2NGOgp0zbH/qhZKKY8AXbvqdUE4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886672;
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
	bh=AvP7rKSXrRSyE4p0cI/cccoQVGFbod20yKz44jjOprk=;
	b=UMkeNIU+ZJN1FnKKAmEVJSwbwqOIirYcC0zQGDEO58wpsNeL4YPGleONgfKVqpUzBWwv
	 tEO+lcPPCxKt+p1uA8477fGiBZIqICbKQp5N+pG5TYCRin0lBkM6Mlyv29evvSghG/Dzi
	 /WAJEvgCHC1XeZtq4CQEq8Dti7iOdHn0BH27hMEz1bPEywvIfV5N7bdRHKnA4MixVUc/U
	 FUhVCK6AyLXXWlsWNYZas9BuGJZHtpOofG1KUaislcv4lVBLNkDtD+v/hXF9TMJrftPWD
	 E/kLiiwwHPdepAJ2ky28SWxHTObR4bIXehYyZjcIX+puEC/r1N1P9x+NRu2hn8iY8nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F+gioBw6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.26
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE048606A333
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE048606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F+gioBw6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvF0+bvtRziEIySWbTR97+MHiIqOTg0wKj6iZMMoL8QC+GeGUggaLN2WgVohuPTrNX2va2xFxRcVdKLbbfh7QIQI5hFYoKCsMDOoktyKRyzs7Atqt5UucBG5NimfjngDI4cVpWAYHkLJT3z9nVWJLeZRYtTaTLSpBQrqwHQpqhlPpSw68bvlGh2D7dXyBWnJb1PKhMPESRuhlIrjC2JsEi2hOVUPSGB0bJL0XzDChra57d88M9Sr2UcBwidDgzUtIr0fo6+Fm4gnzUTNBjEWFQJxkVNS//s3JO5Qa52zwykOMh06TkOupDpyvkM94YnlfBB05ZJU6eYtIvY7sUkREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvP7rKSXrRSyE4p0cI/cccoQVGFbod20yKz44jjOprk=;
 b=GWOWb7/dQwSVhAMelshmA5K2KNunPeXy8h03h/KORIVTiOR4HtzKFtuoTUwZC/JmYKYu+wRMtizrBZgprl2entW3YZZc764EvjHTiFqneBFzuZEIequQyM7CZLabCiCHOGUNltU75YTnFwwr5BLq/4h/LMSYQ6M34W07/M4RP+K8/+O+OjujMY5Qz25+l6yxj6y8EfDDjgdumtK55VmJ4dbU9w9q/qdd+xUJI00ThWQoVYXwy2uwXxxygsdxKYQQBC5reYHb0/+mGDdWr6TxdYsfeGjhF2XJ3GTKbFqJkH+/EMvSpcMAZe9ihZ92X1oDW32pewxermtD0WeXFdvBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvP7rKSXrRSyE4p0cI/cccoQVGFbod20yKz44jjOprk=;
 b=F+gioBw6pm+YDtd8S57tHgaZaeyPQ5grekBLM0ovNuEd3ZtYxWz8HQBVh+l/090QvHwaFIuIy70wchvhlYcGdvossSadgKljM2M8LuW/ARAa1Uvopz+RCYQr19ykrQuaLE7l5vJ5Ea7UCr1mYSJXz6aUxbXkzfMQ1DE6HKGBW0s=
Received: from CH5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:1f1::25)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 03:37:47 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::33) by CH5PR03CA0007.outlook.office365.com
 (2603:10b6:610:1f1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:45 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 21:37:39 -0600
Subject: [PATCH 6/6] cpufreq/amd-pstate: Snapshot policy limits in
 amd_pstate_update_min_max_limit()
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
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-6-682aefd4fed6@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a13a6b-c880-4a3c-72fe-08df445c2575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261021121427099003|261009221227099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hc9ky9YkaXqxy1f4304/rt6XE7pIbqEw7d1C1XZaSmaNm4aPQGlopiV99peZiQXbYrmKvlBUfplhxNK3+r3Q1QvUJywAF5w3AbJBBoIZcDeUYnbTzs5Ap5tWUzJ4S9vGOpdHnkI0u0qoG9JtHEQ8Dm8a5kNGTkwi/vja86Q4eNt/xiFGZyBUM98MwZyUgLL0V9QDO1l9vUCWJQyyDwl2p72GxrkPJz14GIoQ1P5PzSWmmm4EJt99XadzCSNUWiemRN1VNg57yGUlhLmQY+hM4LiKJY3Rp40Iqjat0wc3r954zRcg2x90yPwPPV5+l0dR5gKZ8XvRqLeQGvxv5dniUm/2LhV0T9EeVS792mhyspoLnC0pQsi3eNSTnWQ6NF9B2bVLBiq+lOAd4jFAjIpmSBoFFJZT4qX33/S2mlJTeZ0W+ZLOV3Rc7rWHZprsnR9DrL7BAduGMfT7Is2ohLsVtHOnzUGeunNhfNW9SmvSJuIDIjaojrccywcp7DlQRuNdpY7OiaUzo3Sb7Bc5ORt8EHmKX7UYSpUhZBDmXHU8jaF4++p6mcVcyIqckhuvC41/FsOpqY5VFfrgDuZCccnXbVnmM8c5ycxf14eruA8vDTr1uZ96g8bmYezoWknehZQ57/6G18jzJt7cLehndckYng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009221227099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j8h5fOQmXaY9/V5PswGmn0yxAtU7J/Oep8iEc26H/jEZTPiOZYt+jFo6AYN6SxUyzJUEU/1iruqZARo9kx+vXBJu1FTTmGM4+jU/U9kgolVjqeLjBzmXWRpCta4mwgN/4NJveR/eCHPeE3HKdmvyRHy7mR9ym1NC9cTmBYaqo5tDb6qzWPpvIhe1mXldfF80u13zBvDTjwDxOROycGYISAhRxN1e6vGCbF89FwcJHM+xMrHzDqsmll9Xo0PnUYYP8vkukQqBsdd6RiYMZB/0YepseNZmUgp3zpn3SwUzAPmY7jT3KxQN5gXV4eUCPL1CnV3Nl1EX7y3WIZYG+E2pPT2qhhCCh8Ylx/gCpM5n9QEONTDm4R1yKQrdwD/yu96ppa9IUeWvVKiK6o33lWejt148dWLkBrpdTe2gyqlbX6t7sxKcOaUUHq+FGGG1g/Jg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:46.5239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a13a6b-c880-4a3c-72fe-08df445c2575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194

amd_pstate_update_min_max_limit() reads policy->max and policy->min
several times. It can run from the scheduler fast path without
policy->rwsem held, so cpufreq_set_policy() can update the limits midway
through the function.

The perf limits can then be computed from the old policy->max while
cpudata->max_limit_freq caches the new one. The cached value then matches
the policy, so later limit updates are skipped even though the perf
values programmed are stale, decoupling the hardware state from the user
policy.

Read policy->min and policy->max once into locals with READ_ONCE() and
use them for all computations and cached values, including the
min_limit_freq cap.

Fixes: 009d1c29a451 ("cpufreq/amd-pstate: Move perf values into a union")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-f43c6bc5-cbcc-4959-af2b-f4e5afa1e3a3
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 574dfffc18f05..0acb545a5f4fa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -738,12 +738,18 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
+	/*
+	 * This can run without policy->rwsem held; snapshot the limits so
+	 * the programmed perf values and the cached frequencies agree.
+	 */
+	unsigned int policy_max = READ_ONCE(policy->max);
+	unsigned int policy_min = READ_ONCE(policy->min);
 
-	if (policy->max >= READ_ONCE(cpudata->max_freq))
+	if (policy_max >= READ_ONCE(cpudata->max_freq))
 		perf.max_limit_perf = perf.highest_perf;
 	else
-		perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
-	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
+		perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy_max);
+	WRITE_ONCE(cpudata->max_limit_freq, policy_max);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		u8 min_limit_perf = perf.bios_min_perf ?: perf.nominal_perf;
@@ -770,10 +776,10 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 		min_limit_freq = perf_to_freq(perf, cpudata->nominal_freq, min_limit_perf);
 		perf.min_limit_perf = min_limit_perf;
 
-		WRITE_ONCE(cpudata->min_limit_freq, min(min_limit_freq, cpudata->max_limit_freq));
+		WRITE_ONCE(cpudata->min_limit_freq, min(min_limit_freq, policy_max));
 	} else {
-		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
-		WRITE_ONCE(cpudata->min_limit_freq, policy->min);
+		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy_min);
+		WRITE_ONCE(cpudata->min_limit_freq, policy_min);
 	}
 
 	WRITE_ONCE(cpudata->perf, perf);

-- 
2.43.0

