Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AED3CB91C;
	Mon, 27 Jul 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136904; cv=fail; b=BSrYV3lthtfRcqpqFjkNzz29l7LjxZ6E/3xGeutXMNwHQ0osxlsIa+RW5WVJTOislxVQqdwfqf7JgjPmUsEw7TYWU0uL8vNYFFZOAMxVGm3ozPGpG3MtmqzIZ4Xxsru5plKCEO/UYou/dypjTcn1J9i7eaAQY7c1r7JR86vh1Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136904; c=relaxed/simple;
	bh=6pbB5AVhBKTCkKKd2MMFF1SzN9mfIRZxOxg78xqaZAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+3QhDd3dcM/glCJsPR7O6aAAY3+GO3n+ZwFr4dQxnXqcYEa3uk69y5b7fFFmnxMIP5wJuRAmp6P7wh31ca2QswsOP7QSj02uNn5b+k5tfgWwxu154PWYkgWGtZVvRHsPnbo1IVdLGph3oRyVnf7O3ToSYrRH4pLKpwOL2SP/us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0Oi6Oha; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0Oi6Oha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsA2ixQb2q2V+5Gx7A5IHx/lZ9JWesMi3ohxLOroDrr3UnxYk6w3+/izhAwc76SLLZRXL+j2R6pfQrGz2TsHD1a6sqNJFHMxUjWduudCnrPpZGTJkEA46xBa9yfASpeCN63QlZa7TzAXDtvd6HlcDAxQjh1iN16RUPY+ymBw405d2HjU0pn7HF49qs2yan/MFezHX+XJodFL74j2tqx4OpjSwFD7v26uUPs0l59ZwCJBLhFdzfHghkCTcaTmNVAntaRjcupTQs3c5qL+AGyQ/+BrgR/TLS/0/0maBZpreVSKq1xRD1EHCmkqo4MXOPmJilQHmP0L1VCfEm/uZN5gDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcgZQTTqofybIMw/sYRSP5ioJJqx1c2wF5cJ2PTjXmM=;
 b=u1T52tvZgoaKrifKpo0ykF8WN0vSGnBTsJI6A869tTtEi91nSYvNsjp8Q4wvHbZjUxrgycwyEIUmjw/26Rr0ClU8nP6X1J9QGvO2cYrrK0gkZuOF9eSC7hVbcP3ZuskkdKaF2ohn7FpoxKdK/CZTv6OBFZqmsDoRPbcX+Y45KGFPrrrn/rMCI6xYZ9dPGwD4djO7490EeAoctTyaTaMW+69pZrs6vb+NdIgUkqSs43hzKbOJoJH54miOsi04WYL9NUWtpmet2LMBvi10RnJOmsxvNZpPp/J8mRg6F7cJdZvbL52OjhBG53IjKF85Ku+Wq3tiXwIwVB8iinJ39KaK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcgZQTTqofybIMw/sYRSP5ioJJqx1c2wF5cJ2PTjXmM=;
 b=f0Oi6OhaRf91IlOfNIiobfY0wORnK1efTfnK20QEsRb+Brx4UibNhI4vEDBiB9VrAWfohKets7n3xLgmwHPIYBjPIf0JXxkFX1nhANRgatsnJfmsFF5QizKBLW26vg4ChO1Oa5go6WHUmu7WDuprrJDZ1C7Y0+CRlE1ge5YXYN8=
Received: from MN2PR11CA0018.namprd11.prod.outlook.com (2603:10b6:208:23b::23)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:21:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::70) by MN2PR11CA0018.outlook.office365.com
 (2603:10b6:208:23b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:21:36 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:21:32 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 1/9] cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
Date: Mon, 27 Jul 2026 07:20:48 +0000
Message-ID: <20260727072056.1248-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e4459b-cb6d-4860-0d31-08deebafb1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	apMudh3rfZlk0yMMxLGbzLhp4c0SHmD+GbGha4p5xYCTccrk8Nhx2sfeDooIGxtWI1bzPisxGixgvx9Qz0qCF/J/IZHFPRXSqynLX6CbkV5qGnB77UOFsG6OqBYuOkce++9AI6/uXbctBRkAkTVwqg1+D2sHMpx0jLgxFXF6nCQtRQP3vs9InPNms8I5oW3X47JlfWoV+FHIq3T+HZktt5d+sRwxZRyDf5qgjCuKo7AGupqWSNERvueUvH+4XuK+9cHvW79bGYyt7uG0KUT0T1hH/Eksn8JN+aGni4I5gdcSG19UP+sEFhfnqPUsHbxbHTIoxVZ+Ls76SMKZI5Rdzp9uYWbMN8XTpIOZ1Zf4l4IRQNUk8Gn4lhPZZcfF7AvdgljbetquWXWageXi31u6xrTaGgxd0/t3L+bqLOOs4a+sO1pgNlI3z+6pmwi/01wCnq28C31Ud3gX8zT82Otl3suVFgnAqApYrJ+FQzBttcnAreGCUTcTisBYai0zLILWusJ82U/tkTmgSSXqAtdc6ZblmrSo8V+RYXDETI85OEZ8uSoHb/SCwaTkAnX1LVPnja2qtZ+iL0nsJtC7kbURRn2vr0wBER9Z6MhdQUSlT1sKqwRdb6sMRNjVneEOBUCEwS5D/Q5I3zk7tUliJnTcA55zJIE0G9IWGUzhK6IPTOfi3y/7Zmvvw76MtNyG7fy0x63H5GD0Wy+Sc2lstMC2NQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n50XrOWsQ+tkJ92uKjFiHM7zIywgssP43y4RAOv+VrChXZEvVrfgn8K/v6mG7LC3N5RUKiwsrqTz3u1qOKQU1LpFLBzpCkxWg++Xu4U+q/kKE/+vyScsxpY7G900fwTBkLQCrdhdpYqVkhpF0jyMniJvsX2NbJosrTt7grTrg9EkEUd/hJzcBaHgcC3O+YZyTzlJZHqH9hrJ4CP1Bqa+33ObFnGVImkWNYDCNfY3E5QjkbbPFDw5hKL67MqypbLTRESIIwVDz4YsJ+jf1IfRd+DrFPGa2G04JzU9nlDLGCZ/PbN1HyP1HF2XpP9akPtPT2bmyA/emrrzfsC/NfhQajP25eglX0S2DaC+K/rST9D8gRJw01LRCEsbffECUfB4haZkcX/ZXyBLfp7kEg+BYrlcR5ZfbpfaOQGGkpGTVEX1V1EkODqI8gld9t9wvLpj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:21:36.7647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e4459b-cb6d-4860-0d31-08deebafb1cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

amd_pstate_update_min_max_limit() sets the min_limit_perf to the
nominal_perf to avoid frequency throttling when the system is idling.

This was found to be an ideal default but is suboptimal for users who
have profiled their workload at different operating frequencies and have
configured the optimal idling frequency via bios_min_perf.

Use the bios_min_perf (if configured) as the min_limit_perf when running
with performance governor. In absence of bios_min_perf, continue using
nominal_perf as the default min_limit_perf to avoid throttling.

Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Re-introduced capping of min_limit_perf to be less than or equal to
  max_limit_perf. (Sashiko)
---
 drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b357189f4f8e..25a179b89a74 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -699,9 +699,12 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
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
@@ -709,11 +712,18 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
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
+		min_limit_perf = min(min_limit_perf, perf.max_limit_perf);
+		min_limit_freq = perf_to_freq(perf, cpudata->nominal_freq, min_limit_perf);
+		perf.min_limit_perf = min_limit_perf;
+
+		WRITE_ONCE(cpudata->min_limit_freq, min(min_limit_freq, cpudata->max_limit_freq));
 	} else {
 		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
 		WRITE_ONCE(cpudata->min_limit_freq, policy->min);
-- 
2.34.1

