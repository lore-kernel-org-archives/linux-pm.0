Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329193B8BD8;
	Thu, 23 Jul 2026 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837604; cv=fail; b=BTJSycKDzHgvbsB9Hi1H7aREm95+JyWQdBw4645Py4AhoT8JlY6lwJ9lumFv2RSE2KDsToYJ+CdoOKFB0it00sNsidnB8f53uBF2xi4fj9qv5KhkAcRHeM6vQnMNnDYEuHeq8JLJ6UKAVnoV340f2BSmg/9T6zTqK20mkmD41YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837604; c=relaxed/simple;
	bh=b/a9scX1MkOskTlWaELEKKQ+9nDTPTaHg9oxW9ROGUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0lfig/0HPruejSLEOTpjqny6fUUxMqfJzbAWihVl+obuZRb4UmJeKCCSAJKde3yh4Y9HZYt40ZoqimjmNR1qYuldpK/DwYy+4q4cBwmxRaTOym+xFN3LtPrK1AhItub3UFF1ZByaUmuocxZWsEWm0db86OTVJGpmntdcbiA2zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UVwYCAiZ; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UVwYCAiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GerD3jCJHE3hrr5M5Al4OaeGuUNtV/WFZvd84djMBTbFPL8Opgs3w/+wac78FcRepiy0hyPBC9OExiTBE2rcCxXo/gL2EXCYEEKl8y6yupGAh91EhJEP/KGk6pGISv+dPuqUa6yLtWMb1Erl7N8XmCcv7LC4bq/gRgveNW12UsLgFJ0WPbxmjyzk2qjAQNUjfIeSoZzbGJPMwaXrMjOUlj+3RJQcXKywowGoBdo5flGK9aMEOnNp2vMeilA2aN9xNYmGHzORPs2ysj5T0XkKqWnc4IaVZ9kP9yguLcV7Iwds3dHmIgsaOqlBMGSExRpMCHllk7LB2/pnnU0UuoTeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aat+xqUI3ARoNPu9Z7Amz5d8FKnD2vyMsbWX70ygov4=;
 b=gN5vTh0ZdQ0+1O0Z26ZMPqkv/iy+T+iIspsZX8Hi9Vi0CJkDu6+SFZPVvdCXGM4IjMoLbfyJeJ1VnsCJLCn6EyCyeku+L+m1hEA8ZHRA2qQbVTSQg1tfHdw/+YnRQDTiXUPSZS0g16rm6AmioKvDzQKfHezL3pqNaPuWB0fLDv6r9b4ozjsTMjLxuPcW3agqbSuVhCq9wc8j/aazC3CQLT8IRy9w1rX8o2EJqDmbdOiQLa0BZfYByDJZMiW2o8KKoJKDBt3eZBpESPvs49PckqEPznqmo7lIVsjCFIPK5O7q64RtRKpADvncTLzxzHo+Pv6jdQSo4RVsG5VK2yk2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aat+xqUI3ARoNPu9Z7Amz5d8FKnD2vyMsbWX70ygov4=;
 b=UVwYCAiZA1yCNsP5LDm55z88ARw9uROrh7ycvlNOh5ZRPQlERQMQbVQsKbqlCBJPL+6P+Yg0vzAAVzh10tCPfTGURH0vJNc+zUpkYuaQD98xdW2oOMFgD62XQLyrl/XBu3SXlv3GSChMJzQX+ujmAD+Gn2ehm9Rb/jKZZsWwhSg=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:13:12 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6a) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 20:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:13:11 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:13:06 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/9] cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
Date: Thu, 23 Jul 2026 20:12:20 +0000
Message-ID: <20260723201228.22584-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f317e62-6eba-462b-b49b-08dee8f6d23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LRHPMMy0F4cpcB7SSQzY2cXJMxcscALeSZP49AD1WAgA8r8iVUQEO5ZsWlfYcW1kMF5z+LubByBtxF5sgSseY3aFbFZMJWbLErPyuvGieYXjcgFtGBbbZ/8s2UVclGtGJ0MHj55zs0PftW0naqdhWIArtWX9018VEYjFy3AGNFUzSFArApIGYVRXx3mhln6gpXjGYqPRi2v+L7Q1OopJMb3SIx/eJNSJZt3ezEHQ6/bx4Eq/9uBdls61/QsBgj714+zJnRZN4YFXwMKA0aijOABp1/i4PtFbSagYRTuEp9PdcbHT06k74tsFVPiWTTQLZQpOU/ol83j7WEmPxWg2uxuR2Gbvx4n/eYyUiPg2NHm89aVUqeTorAWDxJUniCynGIY4b7ipW/WAENZC2rwJctoQLMuPOAk/Y3cSphrqcIKvEHfLgv3bgrsvSxq22SwMAsyxhfy3NKkYaWX5qGrzg/pq58SPW4K619HCC4J+fiv0Xbe/7TweQYS3D/ejc3HfGJKGpj+2h3uYN0IlTJC4HLZjWxrAdcIqNgTHQvyq43ohh86ETO9ZXUpDn3Qa9ZG38QOQKchg8bMoyycBitW3xGdvZmPXQ739276J9XQkPuC0dRalxCYjZKfX1In6HV272FxjUqAl5tZEzsDApfYk96IKLqlRBCHhnsd1CTqwFnIjGtblctJkFyVhct4aNgi1qxtiIy5lrBDjkdsrm7Vi9Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8SHNjZZ/JY5GgbKC7UKXpCpKtZmE+mHGq/39MfX38AtYJQvjsaTeFI97f2eF66tyUr/OZj/uhsdpE7CsqOOFax9fjoZlZqZMPSYvwovyPBsXwDnzRicwVmvf5UE6uOfN9I6GZdASVO8Y0LY8tWmi5bIjjc0rwdmz/E9ZX1uEF5S/EdB4L6aq8+GZZhI2JTItsdGuP2P/ZfcDRMAuKBUnNnyNlEyP5N+urZAemqp48cSE7WnoRIXUFoSUcgVp4ivlxVuYY3QezMZ4nljVemMNqw0DIIOefWWjfyn0HIJ/5WI+mtt9ZgHtPBPLEHD4KuLzdEV3+IByxjwZRJEV6bx4HQYkfVkxU5eghJcLTlPUL4Yyamyt3M8uNzouG9XYGZkYjZvhuHci5LgFQBsd+fJnft1WJkErFECdzAK6lj7i4bg2zrnMFyVhyB9NLNPxEZSf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:13:11.8575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f317e62-6eba-462b-b49b-08dee8f6d23a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929

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
Changelog rfc v1..v2:

o Picked up tag from Mario. (Thanks a ton!)
---
 drivers/cpufreq/amd-pstate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b357189f4f8e..1157f05df10f 100644
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
@@ -709,11 +712,17 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
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

