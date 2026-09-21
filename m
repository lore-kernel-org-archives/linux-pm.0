Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180545012AA;
	Mon, 21 Sep 2026 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017369; cv=fail; b=qS28VKQLneh4knGTZg27h6id223cY+wK/OL27cucZSZuzbi7+AbZGr350cGhWxvu/xhkPcTlGoRpKqZFYRSMVJyE6hZ5YNYGY2/BkFOSGhlPLZuva9WYnREfAGDD4hfUy/Q3GbJoIUrGM7zBJE7ZZ1ARIA0lwBXTHTDnghY0sgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017369; c=relaxed/simple;
	bh=QtR5UYKYee9GoiKdDdHm2qjWX2H1K6VxdGDNDH0OV8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVs0u546535DxZWFM4OSwU0lOw6iogZvDBeqsjN+nUIGfBUZrGMI4rlRQn0bCOGWlZTaZnLisEgFIu+hj0NsBeHblI14PD7zNKS+QTIPI49VXh2zRtbWq6PyOhQIdixZlNj5Foc5RmzY9YK5+ao/333bjyUD51/WroamqIgdA1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GqNartzY; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GqNartzY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrFaFLFgwd8H/hWEdzAzt3ZtjS7HVt6K0nkAc5BkclUiCuxm2V25zD3dHqakrvj8MrbEfNImzxbYvSHYyrtXYql0IhlzirzVmtcROhKbfJGjeNRB4oD9Sa8MZp9JmYIninlL9mi3MxGFYXvb8XwHVOP6F0GV2rmUFk9i6P5lLRR5n7SiFd2NhKdT0hOM5MPC7nHNULGT06Pvk00Oa4QkfJdshlCKj5174UIMdv38pk+yXfbjJ6V/pvz8UW/FYI74wWseL8riwx64nety41B8Bp3QKFjenP8lTMdcLBRNJzMBpZg+7yqH3nLU+EjwP3WiXG+FqZdleKTvQtFTw64EIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBKcd/rkU6RsTUkrw1pfPypjswwvJKoiX304qgAekuc=;
 b=POGwqZXinn6w1sPtbY89WgrD7MgDY+8fq8vj/Iy1m7WthKmfxZf8nzeS323hvcE5KzPeKNY9fsHG0W8X+4bMAvmdJrYfrO/0Q6jyZrO8u86sWyRQeKYhwmV0UG3g+KsRgEjEOkoyZK6IddM+zGpJXcbkrtnWejfd7ia89NjTi0GBezm+HA/DwsWdtsEI0STxtUIDFMicq65x1Z9FWryu0IFYY7wv50WfiuDV57UItkRDYLSltjl36/hQw0o64rN3WnYCO6gU7wvZl2VRicdbos/90Cz8RsOAGPWQvqaeRPqlk7L911wQuPT/bAWYBIVD3+bItLJERrjW5pF+XsgV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBKcd/rkU6RsTUkrw1pfPypjswwvJKoiX304qgAekuc=;
 b=GqNartzYWbAVZRz9jM+0DkESgBGWxL6gnaXGwPq9SPZyVHgdKTyjtV9tqDOI/FCOCzuNCMPoNgUtYzmGmj/o7rVny8QXl4t40cJ17w3zHGAiB1ucbm1Tt3EGX3QpSZCNmQLSYd6Rz9uY4lVi5D3xB35eQPQIuBlUX+wkH/8Et3w=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by IA3PR12MB718185.namprd12.prod.outlook.com (2603:10b6:208:61d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:02:46 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::a5) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 19:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:02:46 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:02:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 3/4] cpufreq: amd-pstate-ut: Tolerate aliased EPP preferences in the EPP test
Date: Mon, 21 Sep 2026 14:02:34 -0500
Message-ID: <20260921190235.3651688-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921190235.3651688-1-mario.limonciello@amd.com>
References: <20260921190235.3651688-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|IA3PR12MB718185:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f4a25d-34b8-454e-e24e-08df1812ec59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jg4VqUqRL3d5MqXz3tNkfruG4H9eOWfF185Db/HhtezePGnZjVrzupupNeS1QCEfrGN8tKrPRsQ0lUpVwO1iqPrn/AklXX8gm8TzwN1hkK95nO+jePtLCI0ffyEpUqny8r6sgBtRUS+6Nxmz42SMRjyeZAcHVOntiOA7CiCn8TGgoBEL2X7tq9iFE9I0qnZSEKdV1h6N+3JNEBv7020jsahVHLbmIKIWM6UOkqXaTFvShsRYJseFvHAcBN4Tn5x6WJlvH0qio0wKYXojQju7grZBMuqCn+3GFdpIjWzsHI7XHsPv6Kssz4Je7r6b7oQ6l5FfJTVjJFQm5QntZTPpY/iNwUzc9q5N51tDDL7QkAP7hVDQ20DyZrsS4Ic5fN+SJY27ng+nGjKuDWg4otTZNZS5NMtda0jTp8M9tJnrjQtoWouz+ObORFSqwBWCQ/pCpIMERSSfKx89TC9uL3er4/T/OYGIulosiQoYzGWMx9F1gPicQTLHZzIBZmRUiVBgqiHqvyN7YAQ5LQpc7c6vaztausXyiGq6YkqQ6EN1XziCRPixXcmXMPubXjgue6ChbKWv5jEooRncElY6mHc7LgFeQm8g/nQx/UHeR6sPG3c7b82le6svuxCpssvOjMcP7fTZ8T8MSsBE8ysTsMGwhjV5UY15v6I8xfK7BjpzeYjWOj5lpso24DEVAiaaUYgWX5T9bMybWBNOkvTTu8v6/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wKy3wMsfqA7dM40NaYnZ4fCXFYC5nyTrZVgtcG1VP+EzDe16xXy0OwhHFNuYKBtWaBWXYe8DQFcdH4PFmPXOkEaVePShY8mcImviYYuqqKuzZgNzmoZW9etp774q2gGrgaB9oIW9LrH2REtIlJ6CQxTgOpDZt++5N1+JkH4Rogtxfj6aYqnKc/hsbNjgQU4OiqXVb3n117DkFvBT+juktEIY5+8hEG43UIwZ28M0Y3oVGVRz9dS0E5LJBjWlF0xwOBpj2svApMfWZJYwsgqbe+eSmX87KzgfBCMTmuX4zDp7S93uhcPlFlFObdG9guDq4JqG9IXrSpcPzJDzOS2o+16i8gCkVJZ9pl+QdiuFXlFP+jLWlWA8wDm5b/ZsIZBSldcC9bgVJW9xiYnK1Q24rGhOVkABqJueQ3i0Sf1+rVusRNo056DkoigA/eyyW4c2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:02:46.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f4a25d-34b8-454e-e24e-08df1812ec59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB718185

amd_pstate_ut_epp() writes each named EPP preference and requires it to
read back as the same string.  That assumes a one-to-one mapping between
named preferences and raw EPP values, which does not hold on all
platforms.  Zen6 client, for example, programs the same raw EPP value for
more than one named preference (power and balance_power are both 64 on
performance cores), so show_energy_performance_preference() reports the
first name matching that value and the string comparison fails:

  amd_pstate_ut: String EPP value mismatch: balance_power != power
  amd_pstate_ut: 5    amd_pstate_ut_epp     fail: -22!

Instead of comparing the strings, record the raw EPP value programmed by
the written preference, then re-write whatever name show() reported and
confirm it programs the same raw EPP value.  This tolerates several
preferences aliasing to one value while still catching a genuinely
inconsistent show()/store() mapping.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index c2c1a166b3a9e..f5888beb767a8 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -372,11 +372,14 @@ static int amd_pstate_ut_epp(u32 index)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(epp_strings); i++) {
+		u8 want_epp, got_epp;
+
 		memset(buf, 0, PAGE_SIZE);
 		snprintf(buf, PAGE_SIZE, "%s", epp_strings[i]);
 		ret = store_energy_performance_preference(policy, buf, strlen(buf));
 		if (ret < 0)
 			goto out;
+		want_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 		memset(buf, 0, PAGE_SIZE);
 		ret = show_energy_performance_preference(policy, buf);
@@ -385,12 +388,27 @@ static int amd_pstate_ut_epp(u32 index)
 		strreplace(buf, '\n', '\0');
 		/*
 		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
-		 * Trim at "(" and just compare tie the epp string.
+		 * Trim at "(" and just keep the preference name.
 		 */
 		strreplace(buf, '(', '\0');
 
-		if (strcmp(buf, epp_strings[i])) {
-			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
+		/*
+		 * The preference read back may legitimately differ from the one
+		 * written: some platforms (e.g. Zen6) program the same raw EPP
+		 * value for more than one named preference, so show() reports the
+		 * first name that matches that value. Rather than compare the
+		 * strings, re-write whatever name was reported and confirm it
+		 * programs the same raw EPP value. This verifies the show()/store()
+		 * mapping stays consistent while tolerating such aliasing.
+		 */
+		ret = store_energy_performance_preference(policy, buf, strlen(buf));
+		if (ret < 0)
+			goto out;
+		got_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
+
+		if (want_epp != got_epp) {
+			pr_err("EPP mapping inconsistent: %s programmed %u but %s programmed %u\n",
+			       epp_strings[i], want_epp, buf, got_epp);
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.43.0

