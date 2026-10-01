Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941A51C060;
	Thu,  1 Oct 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864644; cv=fail; b=Ai/Jn0aM200VhktG6vwrjZLxhjVzPfTLrklKPv21UbRTljbZzYJt3TSy1rX5FmdqqwpV8YsV5qKwpzLfOCrAGerIVh0e+eDX9A9HEgW715czcDfmwJYl5ckCUmdtl0Jz2UTuAAHCdgKeBel53+v8S23PbjHeB4tGeNUP/GMk9tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864644; c=relaxed/simple;
	bh=xnPrLbCB8lD10v/+FV3QVbad2fYTLRJDJT5jvBNk7ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q7jLhu+qDnFc+msJGKYy9Zdm8omgekxA4XMKo3YfRoqizungKCHIrIQtG2IpZcBI9ZnJznRPi6z7iYQePOJJq6N9Ycq8y1vyUcShQPwkiuv6YYSXsT4DJ1rT0wKgJQVVFUbJeqFZEuNEF66hsExoOSRR+8clsz6qZ3OKxs2BW8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5lkAB/mS; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5lkAB/mS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytDgSRtu2rooxrqLGrh8iR+u42/KBT//TawIX6RFStZQMgiczDkGVC6Ux84hr4gjtnD9MNXkvyvN5HMOZgvuVgN3kQaxLogjA2XtmX93Lt575afOy2QYiWzyT6F93rUzx7oFuZxkZjLGneKVl9oNoUQoiu3m+njhJDW38Wu81qlGSVsCKnL6gEx45ua3YbHzeUXRnAmEiD2OsKEMJcn3bQDijKNVPUlk18qNvlu/j2ZXg19IsmSqxGUrpMiz+UG7tpMhpFdue52iB/qa+o01/HnSlQX1lJwPMhSOghU7+g6AAFtxhkTq8PAjzDkQhi/9/7HqRiymVJ8osp7AbuPQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlu77OI9aYeVrqXOxw712A7NxN70ci4LcXdqz4rZANw=;
 b=QsxoZUxJuGrq+b6iUwPCFbfbtPA3a5c5UljkarsxZw3VlQ/uiOhkYBjOtbmQGlapmvK0u8C7ZtyaAA3nh+aA7lku3gm1J3x0ayf1eemnOSfcvZFU3FKi1TTbGx2t5LTHnMqQ1m9z9bDqHSrlKhaiufNTj8aD0534uTpoNVcL4TZbWhbeUX9VtD0DsfqMP0nkc5BCF2aNfBJtLmsjqNW12vEK5l+5t/kx/ro0wsMw3CuQLekZN0P3XaVs+Fq0rc1iGKhF5s+1VLli5t/E1K+VcbDYyKWEi8arrxnCq/4pP6YKLiy5y18IXsEPYbjw75PX76vKFGq6QLZQ0SOaMg4xSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlu77OI9aYeVrqXOxw712A7NxN70ci4LcXdqz4rZANw=;
 b=5lkAB/mSeNi7p24gocPcsTK0mYoVymuxWNyTJjnbo90+cldLU0HeybfyC2DQ1JKMTdDwT53/CFPT3MJkwAKTKTldQ5KZG5vBTzuHeqLihHb4gmvBLorPrnQ6cHQkpJAUpiFIRHggnio89DfEZzwUpGvegpq/CE9vrNoRo8RSU2Q=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:23:52 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::28) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:23:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:23:51 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:23:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Prateek Nayak <KPrateek.Nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v4 0/3] Zen6 client CPPC
Date: Thu, 1 Oct 2026 09:23:38 -0500
Message-ID: <20261001142341.2934582-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 2722d8ac-23fe-4b58-1c5e-08df1fc79dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	I8qxF9nXHJHYYB1SUPmBlnB+I9s/ZLxHdBsHdaurUdWcsLH8tdW9SMRF+347trCLRsZ81KVY3dH6w1HsU2eUa06p9VD17OOZYuSLTLQRIk25IjOTJl3g6GGN7VbWZ6nYWZ3Mrb8O6S2cZIGgx+HWDIM2BWII+RPsAiXzS+4Wxe6RIBj+b/RctD7zr4c/J/BgGygSKSivbUrqX+qRinPh82t66nW518hFN825pyN+0OtXud5LrLjmVR+mIWfoGXyK+M5erQ4fYOvT8SXHS9/hjHMkmF6gTG0ulnO4kF+/IzVZWPxXI1FcbsqeQSIBiUorwaFQn0BaTeqRAdXz/9BNcJ+08ZXF35mreOE2WSd3yd8vOH+/QTQtVg5PLGH4VLne4DYYKvw5pm6lBde5fMtH89xC9rDnLu60DYx9P7fKufB8AuF6u4UfMuhxotAnyJK9iztQR9kvyngc6r/TW5QYlDNix1Lfi8Iwk1Zw0yy07f5kt6yAwsJiFT+r5ss6ERoJwSofeLKD0zQUWXcLw4DOSKsEM5/7MnYzBxMrxyhyZMJmKv8w2QnAcx+dFbED2kA2iD2o0W9kJPzveVNn/bjV7hp7MxEXRy+8u9jEeyIC0ClYHc8AweVlIxsLnQrymbJoUDDl/HGJzsitmHYCcyn0hMMe1ZuJ6ZJCxQ/xlLe1Oq6KKIPICySqYWps70MCSV+QarRymE5vV6KrIsi6JVfVaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dMSIJKHGQfOXI09TGAJemJ/4njvKKE8FGm9+ydnD72LGESpo6gMPBVtsaJskPO4NgQzMPAXSGuN4wwQMXiE5rCtXKbCNE9nN7g6ecdk25x25kH6vKOc8Cb7EADjDK8mvetnzHQl2k2IMre/xAjDtC8yrBJMuZu6QTG4IC7jK6q6fJhNeU1hVtmdjebtZJv4J/UsgOxXVx1U5wsf9mMj90as/g9trJcw/10y7/M4/1B6KGnbJaK7DZQT6twDVEcpTSEhbZb0J4UAzfKBujGe3RuwF8Uqj+R2YZvjp15ffOCLBQ53qgDG3DJm9GqsUcJVv/rQMEK2+pbXxkdWIQ4jjjgplY3NhSo7mzu8p6DrRDYrhOq3KCvClLu8eonkzqLgrjKGPH9+VCj3ETZaKbFBYAbqVBSaa7HJ38qHguuoRxhLmxX8fhfLfQg6SVx48Vw4n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:23:51.8174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2722d8ac-23fe-4b58-1c5e-08df1fc79dfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6

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

 arch/x86/kernel/acpi/cppc.c    | 166 ++++++++++++++++++++++-----------
 drivers/cpufreq/acpi-cpufreq.c |  17 ++--
 drivers/cpufreq/amd-pstate.c   |  25 +++--
 include/acpi/cppc_acpi.h       |  14 ++-
 4 files changed, 147 insertions(+), 75 deletions(-)

-- 
2.55.0

