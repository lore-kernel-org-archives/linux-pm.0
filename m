Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DB37FF75;
	Mon, 31 Aug 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205537; cv=fail; b=D/0OWEGTWo4AFDGjHLQlinhb9x2AhJ9YIuY9pPa/gG76i9fl9UOZeT3jFU2ptm3vUKeNriSA45q8RNzwXb8ZyC3FFR4WIkXZqOYiXOkCbSLy9hS5W3kD/8UBU0A+lVsNeT39Xeh4NGxgXxvuhB5A/nS3L6YGGsZV+/SZ0AkHNqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205537; c=relaxed/simple;
	bh=vJO/zftZgf7oNP6u9kjDmJa/WP7MqRI/HEwMX6mkg9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAY3hBQPA5wrmGfQYs7s5+Kvhz6p6NnE4RwPmFCiX/7KSgxQ+eNjQSwQ5KvbiAUtMg8SOeB9gpz39KSF+aoAG0SA0f/Rhou1VOYIP+rAQrPOLoIuXm4k6bj+CeVvjeZHGdL61iZsphfy8mDn58Hk66FZ3jagRIXkT4kKSoVK67E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zux8DxTS; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zux8DxTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUkN3zZ4s9OkhUtVay0NmruXi8ooMUUvU6sFFzNe7Ugze2c2EmOb1J9D31tz4uTSgikpO3J4sqfoNvfQRnIJPf6S1oYaPM0RZroyRgbOUIppgHTjcGuvE61dkErS7oo+H7kKaf+oVVQhlzLTD4xVZLAUo5pgGTduckzY5YVAqYiOdHKG2UvlZQscKzXSDvDwC/022oHuvDH1jNg2sf/B0rGYtu7fiqEZSnDMvU0/WgHPV961T1VdIw0XaPSaWtKL17u0n2O5l4W+6hHEv7wzEzQ678YOyQeb/MSJRj0axMDuK7wcm19pereuhzDNWXtnswIHbTC/r1UCkhgfw0T6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyEbVI8HfK57V6dyt1+EXs+JiM4mL+r2N2mdPeJPSUI=;
 b=OHGMdASiNJH+VZQaz8aqBoDC3pCxTon9uYLa3MY8JVk0oxV9xv+ZPAjP1FTa4OHuOuzaJCM3Bd1AKzcXklVRDZ8unJmEu6ZFZLOIcRqy74GStEBIW8GN3a6LixKFbVIHDFTWg7lT43051bMPum9gB3AiBxh+il9DjCWFV8htiDhzf0SUts3PNz/hJBOLlSISqk36B+DrDuNmNosbH/QvZSl32JQhPVaE4hmMf1RVInk7UZeo7jejxE5+k8zjSx+tSn79tte8YRbzE1AvXgjHEM08bjXBU/KZFZaD9CFWIOEnfLU3888EKQGkk20iG+bf4l6+krSa73GmnepxvrV3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyEbVI8HfK57V6dyt1+EXs+JiM4mL+r2N2mdPeJPSUI=;
 b=zux8DxTSAUFRc0jXzgUpJIkGA86hPVwfUx8Ec5UW5HmAtuBHVY0BJ18AC/71sBhOA742qihZK2IYh3DXFO8iWfKr6MFeP3edd7pdhfDNnI3RW56zQS0dmYErVcjMNlnykLYo4qe/p+iYTlvhJ9jX8k9SqTwoPEup/lEVn+g+ISY=
Received: from BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 31 Aug
 2026 19:45:24 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::30) by BY3PR05CA0008.outlook.office365.com
 (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 19:45:21 +0000
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
 15.2.2562.46; Mon, 31 Aug 2026 14:45:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 3/3] cpufreq/amd-pstate: Get Highest Freq for a CPU
Date: Mon, 31 Aug 2026 14:44:28 -0500
Message-ID: <20260831194428.2287055-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5f9019-8946-4d7d-4378-08df0798646e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vOJK2GrYKnlueNmUsLl03EYGJiqeQeBjoh54K94YaWIJFinNbmayOyfprZ54fXCVofiizFPIr/EcZCPZS8AcRNUJJw5bdgxwP1u0babitoJZBvJyJQck9frOepRV6A7Q1pKhizBWWv+2ivyX27cz9arlrslNAhJHiwYZZ/queBmmwiO43Q//CaJroqNf0jvjuh/wqRmVS3PsUnf/0Y4s5IKwW7N4mAMollZN1EznijMoCIInQSydYC8TQBUw0+I7YwOuaRNl7vqYjIwSY5mNftPh2BGgtlCrpNJUmZGsWwQB35y6b2DzfTCUOOWZqJ+rOrxY29iXq7xfEzsLAPh/ZtfIG3AzUTBZY3aE6BkgXiUK2LOKF8jN5QVtB3OqYKzJyqOqBbsEUM7gnolrR4NQHUgePCYK7DJu3WzWPH7TZEwx8Q15JEGZVERTsppuxnboLuvkCiYO+kclw2Ev7c53UKQFGKy0pXJKgEs4unWQC9NQlg8I6Dt458iMj33ezIrE2PirfLKP8pKoS8xiuLFS9r96SUy4GfxURGHX99VPFHlFC5On5Rg0QMUoiZI9AQpo6CyMdG04PKPih77NQqohX7RRiR0LxlEzVEBmoBX08MAr0j/jSsDAhpGHeUSZpBFdHl+Sp7k45NnSYDR5I8SOi6X/waUElC2uEhVKmGrzpQV/PVbIcjft1M1lvbEzGyXmL1h0BCLBTmFYuhNV6FsnMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SC8ef+YbrX1qHsq3mjxxxBcffVQGk5WiyDtbdhAwgVtextBXSOoPbXq66QOh+6qowlNGPGRNAQ1svwYpvAaxB5Y1xJb/L1Vw/7kJAEYIRmELfZ8noHbjEkAdP9IvvrNiYNyw3aZt8FH1frSSFzyuJg/apAcWcS6byGEo2tu8xpIOmJAIH2tGn5gQWW/aTFKAYDzJ/h1edPYptlV/oKeGh+MDgNQ13OeX4L0dsWmpOPL2OQNWgjJ8/pBwUFz5o1Mp0YQCHgjeOmIOsns8URe/Fg0WgCucw1krMg07btz+HghxXYG9ZOhZqPkGKYEILG2xMh9pqr24FjABz4/Miod+X/EdHGc9VcFXRb0+FXdYjK+IehKoGvebN0JElQMK72WmmjQIUmFHgqW/a8l7nuFMXfYra5vq/GouhKXkqrHg1suMAQ3nJjE6WNyzo2R1rWp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:45:20.9998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5f9019-8946-4d7d-4378-08df0798646e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

If the highest frequency is known for a CPU, use this instead of
trying to calculate by linear interpolation.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9fb1d7150c356..a71f82c93c345 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1107,6 +1107,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf;
+	int max_frequency;
 	int ret;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -1131,8 +1132,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
+	/* max freq came from BIOS or quirk */
+	max_frequency = amd_get_max_frequency(cpudata->cpu);
+	if (max_frequency > 0)
+		max_freq = max_frequency * 1000;
 	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	else
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.43.0

