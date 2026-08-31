Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B33FFD;
	Mon, 31 Aug 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205525; cv=fail; b=DZAIQhTSgl2ol0hx881jXgi3SwywpsEgvsUfvgzqAu43KS7BX3vPNXDAFn080SzwZp9qIX1yfUjCbyEc5IGkL8LZeKDBRw1eGjKO+/F5/y2MTMxbDR4ts9cJ2P+l235Pk6OG1mvPYVFGn8zgygSTK0DMCEoIm94beG+6D+o3AYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205525; c=relaxed/simple;
	bh=jaf2OZrz6goSaXYh9O7m7a41gzvNHur/SKLKuIvqRAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAvDqQ+FisqH/jd6TiCFFvJXX4BDDsmcrfqRhiaNf1L0s47wHEofc6Rf79WHSGjbEK9YJlbtEgUz3qcx0ABnNKfjv2CEgEiul8DR6wAXNy4F1nR/Sk754QXUztoqE2ClhT0pE0CPAR/7A8QH3v3HnZsaoDOp+ZNSXUBSCxkF1DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+pgStqt; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+pgStqt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiHnLJTi1U6Z9enuLr0eb7X+hkmX4b7NELYXWVurnjBGd+4Wy6Zp8AU57yNyAsb51/C63aAS1+zI828zgPkdC04AhWsC6F7IwA00zkozPyYcStFfx+aI6aWHbmwME/XUk+F2ApeRiPrd6KlCd3vguFOZdNfhh53irIVE5LfSJdvNvMOGOFSRAw2FxHs+/HWGUgFQk/zqumnKk3g/4AYrkm4ZMw/S1GNugIISDh6QAJfR+pItcSx2dH7xCotax7amf3Jmh+xy1fu8ToOqpkQ7PonsRk98MrknYgkSrfpV/jQ9XH9lpVSoh8+jNw7XF5l93fucOzheYKHI25KxQBflJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/170WNqvzSQxQ9u4vl2fD+LLwjr2RfDr0kuTJ3hlnAw=;
 b=NuRN5HKaN3f7fyTS4H4BZXiC02ZPGAyvGzSJxC6ye1r1DIrGjNq0PAymziv6dYXOBDfx3FgiKpGItDAIRxJxbLZEArRVf0EMwyUI7BxjYm9cY8+8Cbcl7ofoa6C9FdoSyE1vGy37hUDVCrtPvNv4OKeMRBpvNSrJONJvWaN4hYWaUXQKEc5KHpt9F8d3H3Wgsdyuhaxr8gF7oB6PhWdc17C79NtYBKbLr9JDcAa8gSPP/eNoEC8VMJe8kocaWn6S3cbNO57HxQYtz3dSzRLaLVBF5yZrzOqHShFehK0l1f48JVkoHs0IWqvxLD0GoppxX12kIuDqhqzQPF1KqTRbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/170WNqvzSQxQ9u4vl2fD+LLwjr2RfDr0kuTJ3hlnAw=;
 b=G+pgStqtDMrptKZ/Ex61MaB6X8tz2vJgyZSwZt4bT0PCYUjGpPzQFFXs8khAiwOsBeyHqEAqIWGAVy+lMHXB03XRhnf38BQuaHUaEcBbvRZ9UwcY0A/IyccTIfoIiu8faBeZgYxVHaXBgYgNGFYmZh/Rg3eGG/TzwdNlWzQLlRc=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by LV2PR12MB541025.namprd12.prod.outlook.com (2603:10b6:408:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 19:45:20 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::1c) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 19:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 19:45:20 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:45:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 2/3] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Mon, 31 Aug 2026 14:44:27 -0500
Message-ID: <20260831194428.2287055-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831194428.2287055-1-mario.limonciello@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|LV2PR12MB541025:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ff54a-c7b1-4a23-d95a-08df079863fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	kXSHlDhcgKN9xqHhiia14EzGVkZKpD7cKpFt4MY8OL18UlFPJrw8VeXoxdhLTYAXPAwwahbCTSJp5Xg8ydwyaCgYA2ikt2TdY/TlnFmjpJE22Z+BE2USXQEE4cDTQb/1kAbtdcrn1jCwXKkG50lVL2li5ajMbucnFRQRQrmc+klzNj9CWD/eE1KJjCpBebSJw1orICgDh9fNkg8kGYTcN1REtGUrjcu4IJ5DSfdNsyNrMGs1nhj6gbLqV5Vo84Q0tIJjb69rShBl6LLOuINpNVEcihwNHRymSo7c3kwG6b5g8l03YqmxJ8Vdk6JxkwNQn0A1HgUCiP7Z83WgJ/McMFd+nBJv1dghj2ZlRRn9MEmH8Z3UPjOVBVbxSstkbSBVwJ8NlwKL0qSQVYBjmESGHVkL/9PWl/s0UxFLlV/PrFo5I/CgdhZgPfhAkeo2yBhK7jUcdtCka3WMlfsK82aJsIg3seu4w7CS81mGcDuHsxs+H/xv7aKrd0Ub3dV3JALEhAYFyOuMYw6JNPcPXVzkbF+3l9bLkDhDFecWCXBQEKltxLN9fWc+rWlGQ5q4tOFM3692evF+Ge2eqQD8KF11v06qVkBFGhnN2QrkTWuH3tKP1AVznb7y4xu6JrUZbtn46VKz1RLa4OrRV1Tbo4DC06w2/XUhZFw0hKaLnicED2qFeDbxbIYQoTR6w2ygnO29LpBam4wZ5elhv8+Mjc91iA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	REzdPUAEBEyxUgjNPQgGtfnSVrrwYEKtrRUDEJp7hwiFN4tUFmGhxehABi4HKyQcmA4xZYYLkRRawQSsU9cwN1pIZghzMEgvXjF5j7G+dzsR00ejCOTybihUtGW6Jc5zGTZf+DxLU3yEYxseizvE2E9ju4mZEYvbUKvuGrkns0yQVbARo71C3rOOTvAS1Hz5/d8cewMgF3IiNz41OkETgGSNHDzYE1WNkwHGueUEll1btep4TQR6YBGdZmJ5AMidxSN/ro0Rnro/WukYF0QvEOiu7vy6Hy8/gfZ3M/4enIhWXuHPGEOVaiLbtv+JNfpC/57axgxf5J/OySKMs7oB815XzwXqGo7efHg1sBA18i3f7oskHEwfFA32/KvuRZLKJ6j1Bv6lNxslVRtyuCLC2stgHJzP4X/no7L59vs7p7Qa1Izqy4slGQSRyeOt9feg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:45:20.2551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ff54a-c7b1-4a23-d95a-08df079863fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB541025

Update get_max_boost_ratio() to use the new amd_get_boost_ratio()
helper function instead of calling amd_get_effective_highest_perf()
directly.

This ensures the boost ratio is calculated correctly on systems where
frequency values should be used instead of performance values.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 523ee1a06ef8a..2e74a000cdc74 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -626,7 +626,7 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 {
 	struct cppc_perf_caps perf_caps;
-	u64 highest_perf, nominal_perf;
+	u64 numerator, denominator;
 	int ret;
 
 	if (acpi_pstate_strict)
@@ -640,33 +640,31 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	}
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		ret = amd_get_effective_highest_perf(cpu);
-		if (ret < 0) {
-			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
+		ret = amd_get_boost_ratio(cpu, &numerator, &denominator);
+		if (ret) {
+			pr_debug("CPU%d: Unable to get boost ratio (%d)\n",
 				 cpu, ret);
 			return 0;
 		}
-		highest_perf = ret;
 	} else {
-		highest_perf = perf_caps.highest_perf;
+		numerator = perf_caps.highest_perf;
+		denominator = perf_caps.nominal_perf;
 	}
 
-	nominal_perf = perf_caps.nominal_perf;
-
 	if (nominal_freq)
 		*nominal_freq = perf_caps.nominal_freq * 1000;
 
-	if (!highest_perf || !nominal_perf) {
+	if (!numerator || !denominator) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
 		return 0;
 	}
 
-	if (highest_perf < nominal_perf) {
+	if (numerator < denominator) {
 		pr_debug("CPU%d: nominal performance above highest\n", cpu);
 		return 0;
 	}
 
-	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+	return div_u64(numerator << SCHED_CAPACITY_SHIFT, denominator);
 }
 
 #else
-- 
2.43.0

