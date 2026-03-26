Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527843F54C6;
	Thu, 26 Mar 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525720; cv=fail; b=C9POx3IhGG7E8Y/EFLmM0f+5UlBn9kp96lSm2T8/+9ywveCvrgIhF06A4rnQkBCeywk/k1j5tuHXX7MTxL0W7ZMi0Tg7u/pwO8RwxOxOC1T2F7b55EeK/SWg5rwA7SNuzHuscLufs+GAFEFhvb6tGIEXrzyuRqjBjHLyd4dMFHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525720; c=relaxed/simple;
	bh=Puhlw1m5w9QwWB263ylXsdZH5hPaUPFPMuxxsX0VqQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iq08OaoY2DPxjRUoeAEmgyV5vBohmFp8p2hMzlTlSr8tbjEXWD5ZmIW4bxUlb/oiLf6jAY9PA1WjV1euFFYdoiIFaTT3XJ3RZJxZUY00QE6WQ7u2VtaUXAf70d3aiFHWXXs9/JU+d+x4+zHi5y3tpEJya/800NGuB9SP4zjlCdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiGvlowE; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiGvlowE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf4KH4J5ejoR/XerwqdJRaCDRyP2DAq7jgoxsaN9+roTmByVzVd9Kpc3XgW3RjMvbkhxQnwpIuxuWj3uZUYA1ia7j+Qxj8eA5uJu+VEVN1uXHI/FoegowHFy8x+uUqcDMU4rltxgnrMLt7lx0TRwQi4pNUmTUzle1BKw6AdUMxLe6PgYxGQKQFMYPtJdHzGG4sjDQW82SjEIPgLHllEY60lkDn6wxNmDSznjCgmQi64RyExxP0mwMyq9fOc3j4I6/ZXHiZjwwmJgO5J+kWZFVHTU9ETPctT3JBZpizUrD7fNECOjeDduog9MI82edwaK+kqUuyT6RQDE1sfU6nk1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zcnPgwa39yIOpIcqT96AhqtoIAFDUxEa2gpIrzJ5Ls=;
 b=dYxTPMWHh8jD3vl8DVwJoJbqk/0hDnveSS90CJiW4voxjwY+6WYNi+ug0P2mHbiYBIYzTxbSwsUDnsqWMYGpa134ogv9gIXgT3PJRUwFBeet3aB631J1d7sO8X4dWKcZs5+PKPzyeRBTZQcQrR4uu58eALneY9hBaaQWXS423IdOApY813C14MSnp+Z+QuJHgU4ezRVKZXnCK1omxHgt+Ie285mdaHMiAMzTvj/XFGp2z0HKUlBKHohJBzdX+jfyreWXJ3Bz7PlO9yh5D4YpT7LJMkT/518ASW47TUtBnSAa/hCYIkiu9faVRnASiP/OAwPEZlsSdZSGIqE2U+T83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zcnPgwa39yIOpIcqT96AhqtoIAFDUxEa2gpIrzJ5Ls=;
 b=JiGvlowE8YvKJM+eeiB0vtxKjlEtkiG6KWrcQvpfpL3Niu9BefVTYYvrDWszJpE7kMWHInzog0iMvyaqBA/y5LEKcSKLZoSBD5/AwNIsauG293+WD84nIQ4eqAa+g8YyAi3WLGR6p1bWdMfo2BwyX36+RvpxDC86REgxeo92m08=
Received: from DM6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:5:1e0::27)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 11:48:29 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::91) by DM6PR08CA0053.outlook.office365.com
 (2603:10b6:5:1e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:29 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:25 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
Subject: [PATCH v4 04/12] x86/cpufeatures: Add AMD CPPC Performance Priority feature.
Date: Thu, 26 Mar 2026 17:17:48 +0530
Message-ID: <20260326114756.20374-5-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: ab437a3f-e219-4ab4-0fb5-08de8b2d994a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UbFUYXdQB3Q5TOFFq7fhZlbmaxaLDTap5wfo39+DPlFf5Q98rAo9heIFKbwZIJ35/OTeMrdQy0T6wYKcK1tN/OC4tFGcwW5G0bQnis8GK3kng5OIc6sjGuKXGyy04XUeQVyRbLPinZFqpovT3oirigW4i5pgAGTmztbO3E7InFw2wfahq0BJN97ulb08NiNzbwNQo9n3WGlcChqhJHXRTZ7hkcSFcJnsTWIPNKHa2hOvUIpruUU5fI0cVsX4/so4agsChNnuR5iaK2FQt16EfMjyN/pwLVMKtJlZwvJ8Xve61m8nOwLzyFWBBEanhqOYGVLe4Klgy5NQuuXYTfFl8HXDWUxYIWNODyycksGbIM4+6QkA65DC/2AvWFvE3ZfNIpcdEB6cUQW7rLLa3gx0nmNPcXRqjkbZT3CTFxtk4217/vfiCoTSxCJxhG3i8Cnpn1/yNAidTvcetdVnwljSeiAk8QWTIbH9OuB1v9SMWA6wwL8XKN9HFuzsEFIYOSU7x9jApKYYOcUZWH5sG5k9SmC73OeuYYDEgED6CKJEtI8TpHTbSIA0wDWt8RpbYqV3Ccnaw2JEU8QGka5EwQOJYlej7hDRM6pxPgvs+J93VAWjr7LifD8id9lateYD6YGH+xZYtC3MPvs6zIPT6zTrNbvCxoBKXyKEIcaM3iXSz1LV5b9W0ALZ15t6FwIe+IFEsOSsvk+h35Sr4McWrO/jfKSzZuGKfuQAwpNmBXhmI0vm6x5Mmh0LAhaZshcZo2fv8YNmS9BIpurA8d5ps7xAHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5YorAMkpfBQG/sY6lJzjAjoXiHcrAdd8x58tmPUxyjO+YH1SKVehHJceR6STviEEnfpbkhYWZGuHy++USjzVI0CDRmN3McRlm+qEAgCx4nFA4oPFpehAW+OmOyqE1pQhMC8HY/yd4FDkLyMPyvgdAtP6JpnfWttUONtOxrW/yWlWfash6wETN/W13AW0Cd0ATkdNU2BR1wyiYAxLnkDp9W6KZPmuuFLQZKOWCpcJfZhGYl0jUuSODu+TGoCY2mwCaPmDR1jduYvnkJr77iWe0J/XQpgQ6kRWOQHpuMuqGz85akm/fYbDwf8ZqFVjUi/kU1tHfzfgDtSwfOhZrMAAc96kwsFwLNg5AF5+O2k6FIdjfJLX30E6cqRoPWgvO8xvt6BwCYA+TIR5Jub4XRcPKIqOmfCiPj2nO6dt46SsGMnKZDLfhlzgdaF3Ly054ZrE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:29.3997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab437a3f-e219-4ab4-0fb5-08de8b2d994a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

Some future AMD processors have feature named "CPPC Performance
Priority" which lets userspace specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints. The presence of this feature is
indicated by bit 16 of the EDX register for CPUID leaf
0x80000007. More details can be found in AMD Publication titled "AMD64
Collaborative Processor Performance Control (CPPC) Performance
Priority" Revision 1.10.

Define a new feature bit named X86_FEATURE_CPPC_PERF_PRIO to map to
CPUID 0x80000007.EDX[16].

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..86d17b195e79 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -415,7 +415,7 @@
  */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
-
+#define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 42c7eac0c387..837d6a4b0c28 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
+	{ X86_FEATURE_CPPC_PERF_PRIO,		CPUID_EDX, 16, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..86d17b195e79 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -415,7 +415,7 @@
  */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
-
+#define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
-- 
2.34.1

