Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDF37E5CB;
	Mon, 31 Aug 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205525; cv=fail; b=QKYtOnu09XAL2xbmFEUvc/YT1DOhdqAEp/5ty4BAv3EdaA/xBM+t/zSfgrywvkiwX0D8Ne/CTTYzl3u/t60B/VyvSNc6It8g0AjCdZPE04A8elqYFqLkdkxhZbS2l4Tzsq927PUwDZdFZTkc0xFVkErda+dziRPhVzXZNl9RgAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205525; c=relaxed/simple;
	bh=TvvGP1i4uvFmiDFZmcOA0pGhvdBED5za42ENrSwKFyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o+WTOx1iJBIKeWgZx7AZvctSwdGSQrJqstqb8uAU17q+XerIe+6ImAo1ZxiNi1M9hXvrA5HJho2bIZFs8+QQ9R/uCfp2Jd8T+sFqbz79bBX6AeIy5+ejjSL+w+jPG9jIj3hrXqzfQqdiRBlY38b3TIV1/t1oPrWrISq0eFYcJq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WZ01fM1t; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WZ01fM1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q49RmoB++JQDYZuUoWotCPOkZ/9pltelreD0W1hGF8/QVQOxsNUMpVAaQDcVVpGZ6FmWvx94BQq8LAar/RkP4unJ+1++jn8ZcGbgMggNrovWeXSoaVteHy78jYFaOyerePmv/uHmRdKo6X7qPftDxivXxpCHipme9aJTJMI98SLbUq5zVqPpErZJnyM9JhgB05J0TWXR4kNaXFyEom6lrOC4212xHFtzxdqG7XLc69aoSZot8hNcCdtm5AXn0YiyIJrGfwa/a9iuopsjWNr2A9DMStubGM75/aougFFvihtDTvTYh1wGRHBJlbLr+hc79I1aPzzhnZFG/bFYdszGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX3xnQCsFyFo0RwM5myE1UZe1xPqi8a/IhkYwN5lIN0=;
 b=r7MAPxarSr4rfbUvqFfFMMoUd3jqDDEiB9LMFd6PFaYkLkpf8mllT0AX1hHWTTedtl70iIWe9X+uqdbuoHIr/RgAeqri6jzsDcgvM8U37ltGupcD6nC5rIKxz0qi0FkhmfAyn2dtflnnsjPecsT/9mlrkbXLmto74qK0QzPxO/0rFpzvLP1PAFfI3elz8GwhnLx0C8VwFJ6HMHiVA5XmLW6eIUsUB4XAwZ4HO5LMtLRjFLrKOvIf06mAWbSSrRRDIDhVKVJv1BE0FTACXfMCbcXNrgwXfSplj382NQs+XcurM8gOaKnIF6JxF70raX1ZWjT5Ia44CE7DIrqvlNEtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX3xnQCsFyFo0RwM5myE1UZe1xPqi8a/IhkYwN5lIN0=;
 b=WZ01fM1tfs6utTxu7OaRcytKa+qX5tzIknw6c+E5fAM43RiMeSVAqK6hl3/JxrJsPAsWrs2uMl2KpOQOY0EvKQcxkmbPqYI2dPqf7a6tP/br58QEu6BuUbFfUgodzXIPzfiU3Oxh061d0hHKzJ5pCUxueetK30q8D4DKtcYEFgQ=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 19:45:16 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::4b) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 19:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 19:45:16 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:45:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 0/3] Zen6 client CPPC
Date: Mon, 31 Aug 2026 14:44:25 -0500
Message-ID: <20260831194428.2287055-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 92dd9ba2-776b-4f40-e5fc-08df079861b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|18002099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	AYhxaUNKoCZxi3KjpFCanQCLxY7sebFteSEJq7WFw/Qe8OWFCtojTj1gQeZqaNFI7OQYybJ2qmVq16+MSAE/5xXrm1zQCjrGexCx/UCykJYKbbyEM5kZV8THDKy+rzKiYOKprOir+M7QeYJ3Y8aFgXiJM6WexM8gBFjlUHt5ypedKXrdGz1yT5Uo5mJebrxC8iSgsTDwo6iAZcIuEOQUk9Ek3lxBwkrQwWE103J8LR4v3a5/vAlQ9a3BZZtX5QtR9jtSf1PNQeX+s4TpXpStcH87QdoPS4pcgsHh5gqLsGWcKcfs+7qiI3lbN9dD24JyEZZFYsMymtLKihC9EuLY61FQ26tw13NT/XaSCjGaGKmWOHa4Onx++MBn4WZNDnBnqCKn8ZhpAwRLMMebZG6k6dzxl+dq9hkprL213g1WumO6vSQI4eaOn5E9/yYQ7wGm7u7Q7Pw8wpd4vCUI2BsKjOb7CwRIfUQKzFtkBaY8KPCkue+IlSa8tlLbUtqtx+iZveyh/a6MZQ0G6EgFAZfBUqwEh2sIPfwBmIPTWqe/vk5QAGl/pl+qfCMTFtEnRb87XAc08d3ty+QIBShemtfP4mKQaMcrmmElH0rfAlCh2GbZtLYp+v1S7cnlFg1kOHgzEPQm1Yd7TaxVu+Fxp6XYv98UCGz+m/FdzEeFDZmr9InVeNfTPGnxbx+E3OPJhHff+m7vIO0LueSe1wjoI0ubxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(18002099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	emOuLWY1krN1g4N4ZT/65ISDhG8D5tGMi2fyvy2xffoe1Xa8Pu+BSysPSw/AS5xkYRyLV5ouofAMN5B2zdGMvpHVFdQhNfHqTSkDkipLElnB+B37ayoJmw6OsWPPtOfx7PyZNfEDzfy6JMuHsfQJww2WGF8T7GurHZj/RdtkYZ+JFYsZvxs9mUFkv3VQwhZg6Sif9wY3LDOglYCd2o82qPwZ+Wf17qgmpPNEoTlBJ+OEVaspq3tLGTHU3h8zZBJb5ORxotQWXJdPv3hLSrgb26zJJ98ZztZwpjOBQa30cHNarvYsUtzLuMJYgmiSHhmPRMf4rP3z70shUzf4X/J7dgqFOOKAvGu4mqJZ27gdFCrDLr3AeiVlMdwKS8d/ZJwVgoGke3mKO9t2EXqoJGRW8WVvQmAAzwAsjVcCVNMQv85qv36tK756nJ6eaP6YYuFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:45:16.4504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dd9ba2-776b-4f40-e5fc-08df079861b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

Zen6 client platforms use CPPC differently than previous platforms
and knowing maximum frequency for a core type is needed for capacity
calculations.

Newer versions of the ACPI will introduce a proper interface
for getting this information, but for now hardcode values so that
these systems perform as intended and to unblock future scheduler
work while we continue to wait.

Mario Limonciello (3):
  ACPI: CPPC: Refactor boost ratio handling
  cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
  cpufreq/amd-pstate: Get Highest Freq for a CPU

 arch/x86/kernel/acpi/cppc.c    | 174 ++++++++++++++++++++++-----------
 drivers/cpufreq/acpi-cpufreq.c |  17 ++--
 drivers/cpufreq/amd-pstate.c   |  22 +++--
 include/acpi/cppc_acpi.h       |  14 ++-
 4 files changed, 154 insertions(+), 73 deletions(-)

-- 
2.43.0

