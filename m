Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D518787A;
	Mon, 16 Mar 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649178; cv=fail; b=iupTl2ly4pQsj4RaSY9I9UoX4xqVqfzhA46wU6Yz3hHDq9vz9sxMuWUPzLsLEI9xfIB1lt23gnZ/T31/Td82nKbWbS4z0CrBaTYgEv5rf24L/FAWKkVfejaqASvMTNi4rIppwq5/44SVQxLEqJz0n0Zc1fknU0xJwc9pxaZpxJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649178; c=relaxed/simple;
	bh=51S7Dqrl5vrpNM6zmwdZHWuWCgdGOWGy8eryEwqu8D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7cTrZUEIbwEW16Ew2QprOGkgXujg4l+quIZA4d6zA6ezN9aHonAc+xDtomL6D8JuTytzkJhwjlrL+DGceffpEh/IMZpUHF3KIDooT+HUq7TxfN4zOwtIyOnZGpFQfqPI6hG3zFaI3YLEoov+u4LXdnY6UhzVlVxbhl+02hQ+Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3h5Q2XPg; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3h5Q2XPg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4U+bbT8sduAPhCRXtswPL5ZOQ495rgo9t/VIx4SrSW0EYHj4MXgoHTHpDk8kKXLVuPLHgxNdqskc591LUYPXNNlUu6CQNr6q+Y7HemEphTNzSVyzbD0bmWGJ6mKo+FdV+OHcnYuVxT9sVWvHgYUyvHraT8DFr+qwEa3hmGU9WKZjTheJFEppp893ibdj4c8Q0VMlJw+svdvNufaMfuod7JjxcYoAXo6M7wcqXJ+WXVZaah8Xl3AmvteZ5N+9YrIA51zMOqgqGTC+gINIE1EDqUhOImTHpYwrQD/dhBt5i9Bk5d6rrIvIyeHtrwQi8Y4qhvT122HYanzuEGhgp854A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jtcy468dngoNlmtfB1Ai30TS9xYCuck9oPa5VF4EX78=;
 b=BGHS7Yn480OpIil8z0AaFB4SusiSrAHii8HeWaRbonnJaX6Ky8uEZewGM3oCF8mXVDNlpPjE601GTvWS59MHcGIzkD5fON8KMetaXCmAuyacXKmmJBhLSvJDUglzq1h2h7yZzqthX98L0vtBBwU0PsPyBK3SOA0whc7q3MX7L1L4YEMsLgawwgxfSFZYk/FauTvf8IUls6lHXB7TSmnj97jsJMX+wPW8QSdSZ8DyIk9BFokxtR/U8AEotyFB0R7hAf1dL2RBmrKhnf/wCzNjHIE+hlBtZRknhUQ5d4no8qgDbMFoGb9L9tqBzY84RCL0gzq2Rfeact172XOfl+/Isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jtcy468dngoNlmtfB1Ai30TS9xYCuck9oPa5VF4EX78=;
 b=3h5Q2XPg8izS/nwKpihbDBhoWC8klxk4kGi0Iv42t/+bYflGd/stsxkPmtea0Knoh3b8w+vIN+ecIBqoy7G0pglu70AiAmN3yEtn5Dp/MXntxZIwvS03IvgMRYtEr9HlE6N37OOA1xq9SHODS7626k2zoTglHbLpmuOxWfRqTqA=
Received: from CH5P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::29)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:19:33 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::9e) by CH5P221CA0005.outlook.office365.com
 (2603:10b6:610:1f2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 08:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 08:19:32 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 03:19:28 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
Date: Mon, 16 Mar 2026 08:18:48 +0000
Message-ID: <20260316081849.19368-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316081849.19368-1-kprateek.nayak@amd.com>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 42185ed4-ce1e-4a5d-94e1-08de8334c0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8sDDziQdMpAQK5nhEkCJbpL/mft7NBEMKmTPFpjXzpR54J3qZJgadPzF/kmFBc9xTay20U0Bi8eHf5xzTig7pAZrcesMe1NlkIHUo7u6//9xWD1B2iKEesC5cSXBksOS/8+pUEB2zb7xYreE6jN46AQ4/g0u4YRI6SyDWJRXTTFAAozdiGdfIR1RLIMGBz6t0lGPiluTsE4Cf2m81Lxa7CWU1yZrnyiSklp64O/ce9kEqQz1hwEvmdGmSEDMO7YdgD9irsbOYA8GVd55oXP+x5Pm+2GY93gbQvl9Lvx4VO9QXFnCRUFRGQL0fC0edH8X34e9ioKP6G1fwT6R223PNfcZtXciSmG+MxOKaGV1Sb6UT2hpClcyCiWpSsQ2HU/rpDJQIBTCg6tHRamI+dU7ZPGPEZo3UxpETIGxh7T67LVxSzLjj1eR9Naqs7khm3GNEeow1eujJGRpYAym4xjLJx1TlU+wBtKx55tJzV9pgxg9MM+wF7Ll1YeWgCWJ2FmHNFQcIHAUujCXu5NBHBLMaeb69Is8Qm89nmko8q8ySWmNuvZIHgVnRd2lcad6f3IX3zwSecwzHxRkLSKzChTF0Kw6HEK0Cw6A+5THK/csoTR3I64WlxdLw8L+pDZstpVeXx7tUqlQjU89F6ck84jc9RRl3r9Lr9LM2yEOgL6U2wtto70IShT2jU1mOUGN8iEuiR/NXGG4J5gnFN3ztn+3W5+0w6WJ8CRW5EnLXYB3gK1FOeqWPk6dzPv9D1gXKo2m2iaGUFzfscz+fMHi1h1ODQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hWacUxCD3Hb5MnuGA80xnGXplm8UIjlzlTUSTvhEBAY5fRcArMODv/13l9rdduytrTgy/NoBh5IaidQebkZTXFhYlVeW1h3WXZ5QKTFjC4ZYLkrx+u7hkY2ukvKSFc7IRT0u+lGz4epH/g5UDoNmteqXSsGwQMKWhXsbHbkCHyB69sXcdyxdKeA2Bk+YLwwLqpjSV2um/+hAlANYyCLElSRywDbWizCpCcChfhgyXbWpOlLNdg5X9ov7LzQEA/EH4jWCekRQQTd/gMX9Fch2Z4FkPdt1PIgVO8QREml9z4XwWj9i6vTvyGmlhtre6QpGAyJTsAi7INvlmW0OUPemaIa4uoQoj6koBQqhsEQlQ9pBvLOOe8kPdBNUQaoQasw0+Xk/lv35PRwNbwIwmPbRhmhy+AmL4wcI+BhFmKf5j7lAJ+9OSqN6yEbZnW/33626
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:19:32.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42185ed4-ce1e-4a5d-94e1-08de8334c0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

All callers of amd_pstate_update() already have a reference to the
cpufreq_policy object.

Pass the entire policy object and grab the cpudata using
"policy->driver_data" instead of passing the cpudata and unnecessarily
grabbing another read-side reference to the cpufreq policy object when
it is already available in the caller.

No functional changes intended.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o No changes.
---
 drivers/cpufreq/amd-pstate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf5..5faccb3d6b14 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -565,15 +565,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	return true;
 }
 
-static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
+static void amd_pstate_update(struct cpufreq_policy *policy, u8 min_perf,
 			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 
-	if (!policy)
-		return;
-
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
 		max_perf = min_t(u8, perf.nominal_perf, max_perf);
@@ -688,7 +685,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!fast_switch)
 		cpufreq_freq_transition_begin(policy, &freqs);
 
-	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
+	amd_pstate_update(policy, perf.min_limit_perf, des_perf,
 			  perf.max_limit_perf, fast_switch,
 			  policy->governor->flags);
 
@@ -750,7 +747,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+	amd_pstate_update(policy, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
 }
 
-- 
2.34.1

