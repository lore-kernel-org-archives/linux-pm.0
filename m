Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972485;
	b=UwQAZ00mKh22TvUqWQrdISgVndOm3pu3x4VC5MGO0Qzibpf9aSBWpOzR8/jTred+ABi5
	 D+TMMtMigUH4rDVI6XsR/FKr8eTYLDHMOCwGh48btbXs8A7ejYKNhGLLHs4vhY6o1l8MQ
	 /d/qgAam5qH2FPGFMFkfDTJWf2QlYK2k7rMUNu6f36zFh9sI7V51NbUsFvYvAA4Symfgd
	 AZHKqsRikgVmqMNGawWIkCXCBRhnz00EHC8xRQ60vV1eApuCaVbKCL7GjhM/kJDmMuxcj
	 QZvALCXZRP4hHgC72Cc3GJAlefYi5Bw9MllhJaHRUmJ+6k66Pks3hS2i0T36rIDVtlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972485;
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
	b=UGqJrQIDUctGC+gNAzXWQa2/30e0L5bf1K4bDBOUg6Os3fpC2OfFpqJOYYXnUpGXcMb/
	 8ExWF3tGG9igeXzg/iJHbJ22NMkZ8RqAiJEaU0KkzP3wNfr6EwOU/falhhhCQZlIDXD07
	 4BLfVFOjDhBBBDvwfH9deVgwBJIgEYaevtHawgxIYXkq/ylTXcz/QRINhR5LGbWgScDQC
	 mahvB0fHBTLeI2FOWy09vS4139VycyDfsxPp9hhlgL5EEay+uksuuxl9dFW2M6HgU0U/v
	 /qb84VynVRlO6SZ0JwUdDtIvJcQxGYDWfySL58CNzydclVmJ9e6rkCyKuG8RjbrifkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ANw+PegI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4444606A888
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4444606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ANw+PegI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWL1kIrX4S3uBkRDzl11jNQkuf4rwhutQ4XSWiDaEyRGv8wDLhvh7+L9wDM77sJgARdR4YtVMUML7mrUyNlgOuLh9tZzrmy/1Q76T0R0TKikohDemolmKXJtoP1W2UH92dJpmBpkwE4VnR45uTC70m0kYHZkLplrngcD7Dl2lwzEVs9lSG7LuvJmkTmlXs4gsdB0FsVq8HW5TdwI+YyzicIcfYj+VfTueExrZ9mHiUWzZ54IYVnKEOI+vugKSp/SMdwnz9VpWKNS5C1lCnJ6j9tmUxpbdAjSgPVSvN+/MVPPCzfBLlIOGmdhuCWo4/K9wAs3z39fG5n++EHBRT1JsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvP7rKSXrRSyE4p0cI/cccoQVGFbod20yKz44jjOprk=;
 b=rQ6JxVUbT153cxQoZT9R0aCFnzgDqfHAP3BMgadX5+Zr8zJcCTvsn+DVD/4DZRQtOWRKKrEul7f3ro3+Ii2UZCSpXrB871Ph4dM3SXzcVc+jKKRbI4GOAEOqhj4pTsZKRYRTSZ50e08mzuih+B5QBsGZPdgTSTxKIO6xf4gqsSmrhrYhuQ0GqrbevS8tlPHt3yeI4/bwJUiDhYser3upZIpd9myTdQQvurCeAwcW66WPEAWceCggcXYxsmx6GXSoETdijhdpxBjo8kiUt1/qtyF1e9iGcqmsxXR1Ia5TvKeo66MRx9lq843Wqa18/SB3HnI7Ps5k9YOVXFf/XkRd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvP7rKSXrRSyE4p0cI/cccoQVGFbod20yKz44jjOprk=;
 b=ANw+PegIpnh/p4DISe+jbYFuvsJh8n93unfVKTf2aftfbDWnSJkTdWrqpC6yXvAnjJzjzA5o8gOeAMmZBKM7BHIWUZXOK3Wk2TX9ogl+F6t0WfmZSmhG3ZNbRyiUpPdoZV17Ue3wFH6179ceyV98+wBoIV1uSiKmbSvQkJjS6O4=
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 03:28:00 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a8) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 03:28:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:28:00 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 17 Nov 2026 21:27:52 -0600
Subject: [PATCH v2 6/7] cpufreq/amd-pstate: Snapshot policy limits in
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
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-6-2a0048f563c7@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 16280803-45cd-4f18-dcfa-08df4523f258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|13003099007|11063799006|56012099006|261022075727099003|10067099003|261021121427099003|261009221227099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	HcNjeCTnp4psRyGHdnqApLW0NqGCwgxi2Il+unKXjfTbKbBC7CD2rpL8zkVRYKfMUE5J8InDt5xHhURbaH/pJ9vzfqTZXi5gQof8omy8C+KVt/zQQ3jbqzxqFtgKT0cvnhC+p7TjQHunKHZlO5BPx4ifBYQNDaZd/PXRsadrPGGlGrHDfpsXCGtc0N669MdNkN4anzDhI+Yubkmem6yafcF3CO4ziO18WdtJ/Iur/DlbupNbiJNDjLkJVOEk9oTyZuKPY5sh4VrkMD2KIamdOo9Fdey4U6KlI4rpfEMn+Ered91/xAFxD/kGX1APTYVydKtNP7EbvutT7VQzMHjlmud3Hoer+uLo9T9dzdAjjeFypQhkRbgiGLBvIaukDTXdcXavZGWRLa2GfTf76C7aGbsGiXBB7oZds9vFGbnfqxo20ZAzwyXxRt3zC/EeJ5hy+bSaDQr+Pp9Gxz576JrK4DnVZnwOwI9WK2046Qhvckj4n7UGcu1U/S5bzAIDgXPRtPPz8d6YBNy1/M+WgmcEOj4Ti7UE9N15NPVWLvjsWSwtMTN0MHBJn2giq7jxVMUPqbxvvKRCiOkfZEkrV4z/t394U7AeO4rwJ9JVuA43TTNEtJR/dVtZPx+aQF1rdNkoD3USNO6qxYrd94GcrUI+dQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006)(261022075727099003)(10067099003)(261021121427099003)(261009221227099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kWhfu61EnDDYmmT8bAjwScmyGT3oo8xjJPLqmKdQo0nzKg4dK3X0aAaWURuteiSgSEbcP9lbHJnfeEse0MaC7BN5/sJNdxX+FhxJpPCZd/jjRE3N1puJoa2LwatB+UGHBqqRa4k/du5JnlEmK5FLr6+06GV+lfEeIhvKiJ26NdM2gHVfriesIrnm88DeWHJIbTKVfC5E7SmjS++buFOSzQn9TmMHbCIuzhWz0xMUxC2q42CsfMwat/PDr3sCbC5L8wzbMfKTL0T+bphixOKo0FoFv12TH/Ompt7EP7dE2KablriUUJFqwijOyWfsDVhwGkIiOKTfAduNBtzjoFonu14FBSu72VtHaSKH4e+hADwsjbBH/GiCc07q/P7t429JOB9A7kTZP0dipd2q06hmn6s7DP35Kusmf2vfodCxfV86LSuekphEAeatdGQ7Ir1y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:28:00.1561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16280803-45cd-4f18-dcfa-08df4523f258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555

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

