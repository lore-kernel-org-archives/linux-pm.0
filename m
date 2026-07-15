Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB635F180;
	Wed, 15 Jul 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101747; cv=fail; b=BszqN7WcqueMM8dQ9DzX17r0M/jHQxRr4dImc1nF4uVUKOpGs8/yFe4sI3e+R3tTXxGw/Uc9CB/xc2GaABP0VbWNRiQdUlcpzB9MNo28vLWrx7luOxzM6x5dzClAEDenDbJNIjG64qLq3C0zGl9NdJASJ/LeTsFY7l8S7j6ljuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101747; c=relaxed/simple;
	bh=P7MnYR0VJ+UNiB3tlHtLmAeikUYzF8BjisehzUW4hrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUfSJIOjZcfmu008qacTZWJ9rMtI3Q1hvBT8lBWiFRSksqpO5Zr08tTXMk5YHwulz+k7ltYJ1nthkSgU0Qc3JTnxxxioTl6s+/Wvdf3LbRLqFZTX1PvDWrwbcCy8AVnZp9bFmxUhMqDP5LwC/EnzaB72W9bw+UvDIGX6JObSc6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJsyQZqQ; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJsyQZqQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJQoJdS6Cv32RR0RcJfKQVTfdS584jywyj4n1AFCG0A2848+bAD/oyadmnVb84i5aQ/91NxSVpkA7Vkm8GjZf/j+JhAd/9MliFpmQ8+DqPFu/Vcybvz+w3ZidGLK6aJerIzncC1XI+yy2SWdkQnKDYY4nNvrC/0sIhfKV4xpixZy8kPIEcUZrUoQiScIZSZPpupjl0USsMbUfKpJN4ahIMBh9ARX1uCB65gDVtv+z7rfK5PvAy+Dj0n+ESM8LmjFwpicTh1nmkNpq6jrbbgJjxfQzXH0LjgVeYdyvvsQ4QfWQ7oJwRN100r9nYwssNHPCwxfIds+me+d+UdCrlwW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9jceY6TXzyA0w0+vpdPyAytXdvVpL+l8KOiZ4EvqII=;
 b=fO7WgCsUF1fH4nzMc7xmSQctmWpKHA0R4lBJlgp+xJOxYXsuYXqs5/IoDGvx1boojvoyHc8Di49Uyd3eAcbHBJVfaZmQMjs4hkHMT81YqTlz2+tF2uw4lRLtRjVGvSDWVZHF+9fwDhyCgztkPhhn2zcE5FRNk4P6+hQFCtapD5IlLUqcKbEEExBUG4i2PUxNRqf0ptsfohz416DpAYZ0De85tQC9WxfFg1pCi1ch1oHQqSneShn9Rm2UXfm8S6AEU5kHjcpPOxA6dc9h6G32PNjU+9Djctt5Budtu+6qmvHv7bvKlAyiPzsunzLpKvahQBh3+te9pQba0KcDj0e6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9jceY6TXzyA0w0+vpdPyAytXdvVpL+l8KOiZ4EvqII=;
 b=GJsyQZqQywXMJbjENl89IoK1agjwFChpwEHhsGXQaIrB0acFF6Z7bI0+4HGn2JuyLbRCYWszJlfqC8ZqzRiohNrkx4ydnoKDj1wzw0oNnrxUJhEq+iacn/Cz48YDyyuVB/8J5Y5+PatvQn/htsElH8cQOnBIyolx27kBV0v+Qaw=
Received: from BN0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:408:142::12)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 07:49:01 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::6b) by BN0PR08CA0019.outlook.office365.com
 (2603:10b6:408:142::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:49:01 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:48:56 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/2] cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
Date: Wed, 15 Jul 2026 07:48:21 +0000
Message-ID: <20260715074822.16324-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715074822.16324-1-kprateek.nayak@amd.com>
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d0d63e-9b67-4cfa-7339-08dee24588f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	t2nc3oIj2iXwGBSlbopxlIh73o/VhaYmz1tbfIASXJ6OTfHSi8p2tDlpqBOpZmhwm6blg8VVbVP8Kuy1Mkm2cKNJtVVlB0bjq75LfajTrL3kdSw9tizbwTXO9uJu5NQpEgCwAmYXTA29zceteSntz/F6RyeP+Q7T+/Gdl9pfFp4KImD7stGj1+9lkH6NTQpWyKFYOS0aqXJGWTolW5Rvi1Vt3mfy01+1IHSh1p4RHbEY7+VI96A50y3ytfToPgMB+JM7daXZZQeWtwt00+NW+chX+qyzZFCK+AZ43BWuySJHJR62wjgdR77Q5M3uMBGyojZhgXNO2FbNCEFUo5FQFikwSNzLjwtudIe0Xm5HGV8Sa7Us/TzZ6FpwNM+GZjbM+jq46eTUuIyICOZC1fowvuphqj1RV12gfuYnLKPSerDkbUSORMArjcBBNcJxA/SqQVobOJMt41uu33c3SVjZ5y8kpWYvPyv+1I1T5fPJIH7+A0qFnvzf9FmKPYvxQc5D7gaHPPg4DiEck081ANeB6uutxSR8YdV6YOrcd1q1j5YCwxmkWIF9SBvR6e/Qq0icu1/o6l/Zmp0wdilRHzsfIhoibAXMzos0UIfC7Ee1sV0aZWr477q1hmzqw0AY24FRNsWL9ePsYyxm85axWrUC+7a+n5gtVYLetIFqF5rhJeHr7bX1rR+SENYY107CBh1SrAAtdX18DICr58dZIDSOgw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HoTF4ymNQDJlt8iPSKo0G0Wxf487POt9vtoQHJA+fqZ6B0FCYq6subpozza686kWyPjg2mw9p+I4QMcVzuKWjvm7EZGLAvFzTd38NgFVBg1o5dXs/3oiCt8S9d3ntBAq8dJyvjxyarbkjIEc/tLksBasNtRrolBnrQtEpBqkH54axHUQXh+WqQv5PgrXeTqxK9PyulpoQpTCdsAyBAWgtF7vPzMce0Y2uRwYrT1V5ExwSdzivhcGhRuGFC9BtmEyrMITIOFO2QNdr2COTBQWTfiEhM7skr+e8ig6NdnEqwXToRLdkaOMCcbnGhMPsQXrBkm4IrUiBRkVtZ73+PwQh76NIv4el8wDJgZXkk1Nr3REnaOg4gzmtBqVogRj/2GxDjdm1CMC4Ez6iJ54624Mb41gwBpeh/UA+tlrXbUJEApJws+aoH/+hR3nv3RgIC3j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:49:01.1096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d0d63e-9b67-4cfa-7339-08dee24588f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840

amd_pstate_update_min_max_limit() sets the min_limit_perf to the
nominal_perf to avoid frequency throttling when the system is idling.

This was found to be an ideal default but is suboptimal for users who
have profiled their workload at different operating frequencies and have
configured the optimal idling frequency via bios_min_perf.

Use the bios_min_perf (if configured) as the min_limit_perf when running
with performance governor. In absence of bios_min_perf, continue using
nominal_perf as the default min_limit_perf to avoid throttling.

Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f8d8288d644f8..a6e43db6efefe 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -702,9 +702,12 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		u8 min_limit_perf = perf.bios_min_perf ?: perf.nominal_perf;
+		u32 min_limit_freq;
+
 		/*
-		 * For performance policy, set MinPerf to nominal_perf rather than
-		 * highest_perf or lowest_nonlinear_perf.
+		 * For performance policy, set MinPerf to nominal_perf / bios_min_perf
+		 * rather than highest_perf or lowest_nonlinear_perf.
 		 *
 		 * Per commit 0c411b39e4f4c, using highest_perf was observed
 		 * to cause frequency throttling on power-limited platforms, leading to
@@ -712,11 +715,17 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 		 * performance too much for HPC workloads requiring high frequency
 		 * operation and minimal wakeup latency from idle states.
 		 *
-		 * nominal_perf therefore provides a balance by avoiding throttling
-		 * while still maintaining enough performance for HPC workloads.
+		 * nominal_perf therefore provides a balanced default by avoiding
+		 * throttling while still maintaining enough performance for HPC
+		 * workloads when bios_min_perf is not available.
+		 *
+		 * When bios_min_perf is available, users have profiled their workloads
+		 * to understand the best idling frequency. Use that instead.
 		 */
-		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
-		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
+		min_limit_freq = perf_to_freq(perf, cpudata->nominal_freq, min_limit_perf);
+		perf.min_limit_perf = min_limit_perf;
+
+		WRITE_ONCE(cpudata->min_limit_freq, min(min_limit_freq, cpudata->max_limit_freq));
 	} else {
 		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
 		WRITE_ONCE(cpudata->min_limit_freq, policy->min);
-- 
2.34.1

