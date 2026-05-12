Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF239DBC5;
	Tue, 12 May 2026 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624424; cv=fail; b=ScPVpqkDn08WGyWuGJhy9Ai6x23OV0VG96Fcf9n1PKrnYW4pU4sU9HtlOVD2MAgB4+MbuYeqNJ6m5ZeojMXl5CFoyU79XBMZL37XGgXeblMCTeZDmTJREl4pioexXNRKmw2Is3Xarn2N8HqjsZ22HCLZaH3Q0MG+VrmcMnxD50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624424; c=relaxed/simple;
	bh=3BC8Ei890QEmTTGuDrBgI32UNsWKsnr/8ZMW3dIuw9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IB+QTdVUiCmnkja37RJ/bVhiq4LdPaenR0V3FBIfgvqRlLREkL5wn6+4CCPROhzjDGjdHyqFn4OsaamLdRHaInMs6v307QctWx08d+BTw7IeT7OKjf+u2EcQXCjtKFB3qmAjYWrgu9pV5ZBL2e8gq1QK1F+l96a8azRlN/A6SnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uXxhY1n2; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uXxhY1n2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovyC1k3TqXAX5fjPWvY2gwLnOuoJgGc2v7OlhjFY6Y/Su/cdSO43p+S21hURljqOqlA9xkD41pif1NWcnEgrsQszRzGkzq2vkcEb6Y9oa7dO5iH6ByUUDYUK0d1waefByRqLhf0PorUtNw/V/YhDjIPfiUTTlxl8ALw1ivWmCndelFnQLmiy4xrOIOSCplwM7diX4pMrXKHbXoA8HjSbGKUfAk7NKrq0BJJptJMrllllTrhLtXBocXrYf9PkQ4IShZAPO2SAYjafpPwfGYYji5UvmVRZMjulLa5xZiV5xE0s3a0HryN0t18JEd/ai1Axf02g4ElEyC+0fQLz7PTUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D69cQFQpFr7odzkb9fJy3s7FskIkMBqAytKh6Z844I=;
 b=DmfIzF/i9Ek332DOwZtFXWHIGrR2RuMA7Jz1eH1gOMpFK8u0b8a8pt0CeMSt6VYk32iiKnRPWdl1IPECtWyAVWo/bu+ChtjuDkusGkPEKIKerpSVvbTxAZa9o1q0oClnMkOuMpbnOAUdW8NgVWbVyGV2dPqO0o6t/KjrI5xjNZlI5E6G+QeawAJNrzjLUrAfYKDEtJl1jY0bSaYpb/GtlSDAVbVbs0TqGuU/l7ptAFNlPu6+scQSBJQoYZJaYXU3QhAXiMgWdJ/Z0Z1Sm/DtaTnD1g7tiLNJBUYxgL6fJm/FDTqV0JgvKb2hcHJnEjICb+lH2k5RuSotxQ7sbK80nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D69cQFQpFr7odzkb9fJy3s7FskIkMBqAytKh6Z844I=;
 b=uXxhY1n2fhXaUJFMCEKYDpg2NbjpC6cmwktYiVM1Q/meGLXt025MkBuEPIjjncDnazTdB/aWo1EJNC99JdjF9yT4eat/aBHPtkCBTsES+yjU5cNyGd8fejDvC1OHgHFv3L+C5FRkhvwIxTTQINa70UEtoR8vW//yy2bpJKavwiU=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:20:06 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::17) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Tue, 12
 May 2026 22:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Tue, 12 May 2026 22:20:03 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:20:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Stuart Meckle <stuartmeckle@gmail.com>
Subject: [PATCH] cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP
Date: Tue, 12 May 2026 17:19:47 -0500
Message-ID: <20260512221947.1652988-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 075283d3-8b2d-46af-27c3-08deb0749d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	XqwUzP9OfdbdaeiedAIg/N0ThHis3yq0FwCN7Fy3QmU6MwnH3BjHNaGhYVy3qEtGT5fbDulTeM2sNiWHcH1U0D/dVmf3gGAmJjFwmpKa5p2YCnM4Mdnzt7/U28GJHZNzYbO+lJRIcOSgC0o9KtmA++HcjQIYgP8OD7hj878uiQgB6MM7vjlMsedK97GW5zobj3joZcg3aXJtOHtcmNR1SZLRFDDCZV3vtQUovLXbLGWV0bHSHRcAOKr2MfU/A38uXC3fi2cXwn7LhWmxlXtKZqxTLbh2tH7za/9AmBXv8QDXeBql8HmuyCcHQx2SnCjb9xNRkVrVEJ1XQrBUn++CSeKd3bTqjNwPOhASqiur2o4BdE/QT9XzP8YJVCFMcBDjJNG+qBxrs93NRrJ524Q6rZtZSskxNg8pZx60UD7/fDUebsHA/9EyC3lUIm0eYp8vnqNAN3Pl6HW7cGJzCo9fuPqOjgUVhLQJQ9zblEwt6CxPPliXDNtbY9PVQec0iHkcnBy1zrafdGIzuwR9ZYrIfcKQUcezN3s0wJzFyBiWb9gVqXRRhU4DNtVKc/Llw0uW36n61waJTV0+889Q6T1+I6zhFZ22qMcnA3ZgrJXkXCeA2SPIx1uzdIHF8j3mTriRxiSWbFi9+F5PHCrdENpa+z1lcwB02yRyp3i439Uk1F31K3CYBqbgB07DUXsE3drZ8p61Go4S8AN5NRD9L5Y20/IBPftku09Y6nGvgDTK2z8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pq+MapC/anyfdFdr7HaIQZTmxhSBzn6LjUp3WXsQh60b/dc5eWRyXqSrfbHgShXBXiq3vsfSaJKLyrdObHLlvqzPELWT9yqagYCa8FW0hdShap+dRSfUEpeSNwc44q+wQnNbZ58Uo1r55wCWqhZjnfv6pV3TnQZNIDlejpFjZd5wtEQbDtjImX+le7gVCO6sciIPWcPLjZ8ta/dUey1LAwlgochprDNxC35sS8cym7iCx2BV3FwPo5U6u7UxWLoU6oHdU6s1hpbDeYMDGcJgyf0UUEfVWeCoYd1TrQe4sv07KQujBHE2Fcn5yHr7Ag+SwhfQMtVxvZxfRh7He6UC/bhvhc1fPIQEtEy0rZGu+pIiFahzcPi7/KBzg1nT5odHV0Vm+qUusGFftRZy9mRr+PlvMhEph9HSe45ZN/PVkkcwXBPrH8A1lHOokG6o/QQa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:20:03.6870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075283d3-8b2d-46af-27c3-08deb0749d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

There are some performance issues being identified by dynamic EPP
and we don't want to have distributions turning it on by default
exposing them to users at this time.

Drop the kconfig option, and require an explicit opt in from kernel
command line or runtime sysfs option to turn it on.

Reported-by: Viktor Jägersküpper" <viktor_jaegerskuepper@freenet.de>
Closes: https://lore.kernel.org/linux-pm/14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de/
Reported-by: Stuart Meckle <stuartmeckle@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst |  9 ++++-----
 drivers/cpufreq/Kconfig.x86                 | 12 ------------
 drivers/cpufreq/amd-pstate.c                |  4 ----
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index f8e7050fc7623..b53c752d58ca0 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -358,8 +358,8 @@ Dynamic energy performance profile
 The amd-pstate driver supports dynamically selecting the energy performance
 profile based on whether the machine is running on AC or DC power.
 
-Whether this behavior is enabled by default depends on the kernel
-config option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
+Whether this behavior is enabled by default depends on the kernel command line option
+``amd_dynamic_epp`` is set. This behavior can also be overridden
 at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
 
 When set to enabled, the driver will select a different energy performance
@@ -485,9 +485,8 @@ kernel parameter ``amd_prefcore=disable``.
 ``amd_dynamic_epp``
 
 When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
-autonomously changes the EPP mode. The default is configured by
-``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
-``amd_dynamic_epp=enable`` or disabled with ``amd_dynamic_epp=disable``.
+autonomously changes the EPP mode. The default is disabled. It can be enabled
+with the kernel parameter ``amd_dynamic_epp=enable``.
 
 User Space Interface in ``sysfs`` - General
 ===========================================
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 027e6ea2e0384..a9093cd5e5d1b 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -70,18 +70,6 @@ config X86_AMD_PSTATE_DEFAULT_MODE
 	  For details, take a look at:
 	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
 
-config X86_AMD_PSTATE_DYNAMIC_EPP
-	bool "AMD Processor P-State dynamic EPP support"
-	depends on X86_AMD_PSTATE
-	default n
-	help
-	  Allow the kernel to dynamically change the energy performance
-	  value from events like ACPI platform profile and AC adapter plug
-	  events.
-
-	  This feature can also be changed at runtime, this configuration
-	  option only sets the kernel default value behavior.
-
 config X86_AMD_PSTATE_UT
 	tristate "selftest for AMD Processor P-State driver"
 	depends on X86 && ACPI_PROCESSOR
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2234044c328ba..3f06e33f47120 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -87,11 +87,7 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
-#ifdef CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP
-static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
-#else
 static bool dynamic_epp;
-#endif
 static struct quirk_entry *quirks;
 
 /*
-- 
2.43.0

