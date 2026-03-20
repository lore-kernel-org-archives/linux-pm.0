Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFB3C870F;
	Fri, 20 Mar 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017855; cv=fail; b=qInjNdChjKvekKDO0esKzWTN8CF14sVjtPGUQ82oav++oeli5reK7uIrd/qCZe/AC+o/pXSZivQw6d99xgt3Y4yrEZkKKzqYlS83VF+Dwy/WEang/27CAAI3QDliNgIicSAyHkQfBXZDuH6yig7Vxj2rLDvjLSJ/xjvQ+4UhhwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017855; c=relaxed/simple;
	bh=Puhlw1m5w9QwWB263ylXsdZH5hPaUPFPMuxxsX0VqQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNNaCSgYDSwk7DWUp4KrxhuYJSN4EaPhTRQqSwYsLMi32fbczOZlmPXscDm0L8p9RpBj62Vq/8ebu4T8qi2b/T8uhVXUJIMoEJrOglQb4R3ycdVDhGZ2dDXo76VCpurbZ1d+Tv1O1TtcV9kfWKhfAiiILnVpNhlsrwMBUDb5sLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rckks89f; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rckks89f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxtmBO3wesxH245z9F4nXPxGn4BvegtrqqXvsY/m0jbje0iyLJeakwINeLmRFj+3hX78qlnjWsVwxlgJxYQl0W0igjwmDVEzRaU6nsABq5SBpSVh8uoCtFH1wJE6/rycJ83W83iM2ZyoSX/bujr0f58+xmChQruRgjDyfbhMqfdqPXZStX8gJ/tdIRJqNBdCIMTheLGkd6WNTwVBLA1hZSFNjP9VHCygz7i1od89qFRg/km1nr0YjJ/JWsl2XzxanJjRcwOYiKD5Gjs9uqMgeeL8IZdYFzXCI9PvSB+Xbx8ASXOsCh3yVWNxNZgVRIUBi8lg2nOUwzeQYTM8sWFaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zcnPgwa39yIOpIcqT96AhqtoIAFDUxEa2gpIrzJ5Ls=;
 b=E5ChLVj5Rs3VzIIiqaVwXtJ55etQamTkNhYj4p/tJSXwifxUC8ZRCPeTFmkGPhpoYDMPgV0biTq7IMVQhGVvTqGU9ypzT1AZuCvGvpOZkQA+TU31Yq4YxtARpLY8houRsd/NY8FysPODEs7e+IRJ2jdRKbyLafEwFz6kisNrlGHiz121TgPiSH53FcdHGe2VOsRiYKv9XqhbqvaZUm8xM9PL7V4HRfnKhVamD+VCyvmgDd+WqHdUn/q2s+LlWn/sMaWBNixUOxRbIvXCo6APLR9zhQSg0Va1YXFl+gUVB/VK8uQ2u6oyQjf8GIEwp7RPmpj4TZZZM7YoTCtLAEUXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zcnPgwa39yIOpIcqT96AhqtoIAFDUxEa2gpIrzJ5Ls=;
 b=rckks89flr2BWhP0QeklsZ1pnUcM8Q/OLJkcucM9PGdm6bHFetz1R/CoGs73UaFce/PQjQdenOSdZnrGwDP+UWcYGSb2MC8IpJv8UgfDK/Fj9KQ0SUBXfws2Fv7pShDHPwdbg+eSS1NNWzh3/C4Yw6ZIDfyWGnESqYGysbegRDo=
Received: from MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:44:06 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::9) by MN2PR03CA0006.outlook.office365.com
 (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 14:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:06 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:02 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
Subject: [PATCH v3 04/12] x86/cpufeatures: Add AMD CPPC Performance Priority feature.
Date: Fri, 20 Mar 2026 20:13:13 +0530
Message-ID: <20260320144321.18543-5-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 558629dd-fa00-4eb1-c339-08de868f2336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YrQep11dXZnTou8xYjHtIMc8CB/qDUL8RBVFXh91KuwG0HdymYH8PlfmxDWvf0VF4/gzepk3IOVo45l0I3qb4ABvYFW8+MGPIkoIeu8Hnb2VjFSdurH5lq/P7D1I5wWgL2gfsEITAFSBr3n8shCzI4LLWY6SgJ7+5JnaSJFdKw94dW3ODM5RFHQOVd9yWyTr2WYwiWYL5qOmcEdFP1GfdOjj2xphLeSxrtmqUM0AFr61zlpLMAw/TlahovbmE1cleWJmjBWbvKSQN5jv7o0sLXSAzqRhojoLVTmiwV9FUZAer0uOmNUTxwz4c1eNOMOdWwLijud/ygw65QWJDE2Rr3C4UlUqaYWVxdQ5e5lgtN85AVlEnYOeD1UyJ0R/OgAo3Rs4VZahAaEAX1dQe9PYQ/M9ooMOph+6tpJvrJUhZFLimFZWeaXOWM5nMvOHb+MLu4y3XpeAGbgJSGPAboNoZw9X/fxyvhWJAKE4KPZ9woFYa3Ok2b8m24RdCwlnn65Y24ljELa4Hg3LRGSVdI5Iu5tyGEk6LzkLmLwcrWPbTZk10TZYDGwuVSpkbwfw3SaWC2mdkeEYA3zoNvHNsqR8EF9lAphUf38gLsFebpbovuY2Nf2CY0oziiAdGoO64BwwXHCC8AYE2dhGoZOfpCy1TAHoFLN6HBPsDl6xo8QHDZLEHJLIeykt6Atjl2jBlrC2O9swu07kzqnNwcdw9YK6W6q4pKVk1ATJKaYrV0BRK2IyohgNEoIeft1fLNfcCK5G9N+nEjtvpdl5W0xORTOkBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	regzhvaOM13v/nwOzN/625gxpYw7q2YAQt1C9s9GZJKKcOBdt5q9X4x81N2iCxzAZ1QQtYbUpXrLudZsuV9XEdvEySuS8n4ZORNCuk8R7tXpzEaJ6gSDLJfrmISzRWvEOSRT2JqvO+NYAnsdl1xFyDiXGsV8McLSkzpoF5A4MfBf/HRKJe4aEJLGk5SrzU3iwpoYVCC76VIu1acudpKZWfv0LbotNE4uuJ1p5J77ixwQ16I4ewOyFie7vFpg6j645of82eNiAbuPFP/31pWuhU4NTETcC99QltgcaAAhDXap8MgWNurmzkC0MlYR0iyt9eNyIegaE+240/Rdkcw+zovs1vU3vdlbUY/SzA3lZ0LB/rbIpO2t8C4qfCKb45DDTRE8W0F+AiVk9g4cTNwPatvGFeIMVLPCn8zePGj0ZsdwdZ+Gy7DPE6I+UDIRjpjD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:06.2054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558629dd-fa00-4eb1-c339-08de868f2336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576

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

