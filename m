Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795627265;
	b=SCKnPxHpZb2m9EsaQkt2oLndVkQ2OerRsSxckPvagCs6oS7Sqg8pv2q9qH7VND8ghl0x
	 3K3xu+0oHjT3zXwT6sTJ1n3+sKNDRw5THbYfDnSGac2fePm+eA2umT80th7Fx5/Nz0KsT
	 a9EnOohXdu35YSmJ2NSnbtJ2VO7+v8HhWndmcurdQCIHuf4JEbh6Jj6w0enp30nEs8zJY
	 Gy+qtOe76AUqceekdlJ95CWxY+dpX1mDR0fjGD+uVlwJTtEw5GDQ8Tq236iSazGDaWGqk
	 ZLtG7HNZFlXjoT63B0FEPlggHkRQES6+lwcnwooPjAMgYGBcZIpQH+fKGGLLhDa1X2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627265;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6beaJUzXygzvCsFi+Urqbn1lhKhydyCKeD7v9haE7UI=;
	b=qf7Mis8BrQu7ZHKvJTUFa4LNRz4WW8PwRjmuTPf/zmmIYbH6P/DaPkoDzAgcdLBw+FI5
	 QD8Ex5k6Fh4o04tFk+GgwKcCt1hZZWRRKYbLU9KZx/g82h+mjmqFC1e++1UJEFVXJMf+d
	 ynoOoXBtt+LPbbiDRQw8SAxCqWWe1dR3gog3fdWq1fM1C2JXYMbmEusqSqqt8+vVqv7VV
	 MRTxeutOqgNOQ6lCHnICF0d+T6YEpPd2dMBhtsT+5a2Qj7KN7TUZrd03f27DEQ/PnszkH
	 wvZZz/h0ILkpoUTsNRlPs+eqc5GLurw8JcKQdu2AV2hXT+BdFnIBMCTUbv66usvOklg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=og1TfZFl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1F606A684;
	Wed, 25 Nov 2026 17:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E1F606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=og1TfZFl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWR3YEOiAJkF+NrIiv3BsY0ck8mAfMz772di3AKt/4DVvWU6bUtc5XjM6SmFTo5TUCyLIMUs7C52Fna1Bp+kM89cRAGB1bYyNK0SrcvFSAV2CjROBFzyqWUktuR/Q2ktz3Rubg6+tmrCn/IgvLRHW2J+Q5fmLMqADBP6eVMEb13mwxD2ztXlaxSrB7V2O3aTtcCVx1XzoXdMu259+uNcdR0BqV95w5cJcn0aFdmDht80AS1ggPKUwdtUWWjNqCl172o8sfFnwSsWpSlVD6/fxmQtFEkNOu2Czqkk5S8/LPu4gc2QJ2+UDiwgZBt9EvrqEtMpDNor6HK0PR9I4PwvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6beaJUzXygzvCsFi+Urqbn1lhKhydyCKeD7v9haE7UI=;
 b=fWLZyuSwFJWXXtQ2vQtW2BxAk6dnOq5Bzle4A+hZc1U1ryOtWYBTt04gUowmlsnYXCI+tYNCWDRvHt3C1eXmUEy9aOo9bgH3Ps41m3au4Hc3RONQLlCH1/CsVE14zC6bqwWFinWf/CLtFrlkSfEs0D1ngfd3SoHFY/tbWlKVOKwNYNju1NzRQn8veSxamx6dcm7om4401ZML3kqoWHDUcn5vJQT10WY3M60B4iFC5XHlD0VHaerWH2OKfnYglhDOpf58yZMhDVvBtuW3NaKrUXzIZlPLsn8+PCrzz6s2wo4i1wQnhZfCqwsDDz+052jSO0Huc5T13oy9cjwAB+JG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6beaJUzXygzvCsFi+Urqbn1lhKhydyCKeD7v9haE7UI=;
 b=og1TfZFlCrbo9ovR+C5MF2PeF99C4eXhEDBvGqM0z+pVSzpmXnrmwCm0/K09/tXK3ZqsawTxI4acqaTZhnH8Z5OlDq3rr/HZMjdi8T69SH8QFgi1B6I95rxZe3BZAjfQuUG9UO1GdIHlh9M8XbpxXOSP3R7RN212wTHBHHK1Ovc=
Received: from CY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:930:10::31)
 by LV1PR12MB999280.namprd12.prod.outlook.com (2603:10b6:408:3f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:20:59 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::6a) by CY5PR16CA0001.outlook.office365.com
 (2603:10b6:930:10::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:20:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:20:58 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:20:53 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 2/3] cpufreq: amd-pstate: Set asymmetric CPU capacity on hybrid platforms
Date: Wed, 25 Nov 2026 22:50:30 +0530
Message-ID: <20261125172031.741740-3-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125172031.741740-1-Vishal.Badole@amd.com>
References: <20261125172031.741740-1-Vishal.Badole@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|LV1PR12MB999280:EE_
X-MS-Office365-Filtering-Correlation-Id: c6571c7b-861e-4b3d-fad9-08df4b18788a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|22082099003|921020|56012099006|11063799006|261021121427099003|261021123027099003|261102130727099003|261028144727099003|261009221227099003|261022075727099003|261022105027099003|261102123227099003|261026140227099003|261009223027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fCrr7WqJ5RYA7gSTQvYgkAfPe8Cm1GFPsOaKu5OzRv2VZSWIws3GFVpl96N5ZH0ZQIb7T60PCwLak6JXr0K8pb2U4TTI1e2/5uv4IvhEy0cwz2IhTMfvEejnZMq2w3TwDvWa+fA0P+3LJEMxnv4ncZpUmK++i9iympbMNCLSZQcXn8SqhDewU0nq/a65h4KHh7gegN5LnR7n5OYNvJF6HXEw6lcBfF32W46ngjZiJ/CQMYDnVi+J7rAtqGZKSHSsfqcTq0mmqOCZYWCxFogZXTxQxCHRA3ZkE4o7izF35cDIEF83u6Muo2TA/He59FJ7owi6j3YrVNhDS8SzVcXS+nuWt4u9qDYVs2SLrWiBIIcTrFzj8duKOXDG+lJ/N+yS9JdL3i37ESC8qsFLkUhCoGa+//B63e4M28cj7i4Lt9rnmDa6qawRQI1FgmmlchLN0k0CZv6DrfO8TXHUgpqGo/EI/JjI+YBt6ui1AuBhHxhyiDbdOgBRccR/HnEyLJ2vxuq+3jvvWvF6kv2a7CgHTHzm/sueTXr6bZJRaGhX2WlG3pu8xYVNIYc3SF0rFJQUkHngToMLL3IevEi0Xywmxi4F4xk4+Ywle6Ny3t7U1jdjBSghwW1JMETsbh4qP8dT9MWGWvOhowlUU8u7TmUI8u1bTollNlVJmmK7ujlwIyOMmaRoBKIJOBnF2T0kLGs4PtlkzSRJeWMnpnSvw2HuWc+QtzpPmzelZB79Ya48eTGzEyz2sd0MMtbWbOyODNmo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261102130727099003)(261028144727099003)(261009221227099003)(261022075727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261009223027099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oZOMxTn3TQ3sbyp4G9FH32uirbGRMcSgGGYDfix/43fAIAZw604b/sCQ+hTbqnSgRmfvKEzJrzp2aLcCBQNBkD8laoP9ibyRZ/f2aDkZx22rF0vy6r1fcfBGnUlGStT9OKNIdkZh3VYObt1tx1C7OZNyD39F0J3xZ58RtJNX8hBCpCm0PnYNd024EcfEbSSvEWASs5BheIkBQnww8I+4e6jAElli6kLvnSVhCaOUWWBzzaTU70odEoAV7c5asjMzsYHvHjfceT2j/WR5+PvzZDoMjPNuOxDEcDSw1dki2BlA3Aq58UavYTkMYPbxOchqFnxPVU/TvoXdctV5LidKgnIjrUSp+cvrdwMWi2axs2cYfHZg1frIrUxZsMekcUTfaAKVzQUsFUpzQqKDsvoaow7RZH2kmBTjOO+hwwpwVcqTSSjTQC5LohKt97AJ/asC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:20:58.2544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6571c7b-861e-4b3d-fad9-08df4b18788a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999280

AMD heterogeneous processors combine multiple core types (e.g.
performance and efficiency cores) whose maximum sustained performance
and frequency differ. On such platforms the Linux scheduler relies on
per-CPU capacity values to place and balance tasks across cores.

Today amd-pstate does not export any per-CPU capacity information. As a
result the scheduler sees every CPU as having identical capacity and
treats performance and efficiency cores as interchangeable. Tasks are
therefore placed and balanced without regard to core strength, which
hurts both throughput and energy efficiency on hybrid systems.

This happens because the scheduler defaults to a uniform
SCHED_CAPACITY_SCALE when no arch- or driver-supplied capacity exists,
and amd-pstate never feeds the asymmetry it knows (via CPPC highest
frequency or the effective highest performance register) into the arch
hybrid capacity scaling interface.

Enable capacity aware scheduling by scaling each CPU's capacity relative
to a reference CPU. Use the maximum attainable frequencies when available
for both CPUs, or their effective highest performance values otherwise.
If reference setup fails, keep CAS disabled and continue normal CPUFreq
registration.

Capacity aware scheduling is enabled by default on supported hardware and
can be turned off with the "amd_cas=disable" boot parameter. Its effective
state is exposed through the "cas" sysfs attribute, and also exported via
amd_pstate_cas_active() so amd-hfi can stand down when capacity aware
scheduling owns the heterogeneous cores.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 MAINTAINERS                           |   1 +
 arch/x86/include/asm/amd/amd-pstate.h |  16 +++
 arch/x86/kernel/acpi/cppc.c           |   4 +-
 drivers/cpufreq/amd-pstate.c          | 150 +++++++++++++++++++++++++-
 4 files changed, 167 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/asm/amd/amd-pstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b80..300dce181c1c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1322,6 +1322,7 @@ R:	K Prateek Nayak <kprateek.nayak@amd.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
+F:	arch/x86/include/asm/amd/amd-pstate.h
 F:	drivers/cpufreq/amd-pstate*
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
diff --git a/arch/x86/include/asm/amd/amd-pstate.h b/arch/x86/include/asm/amd/amd-pstate.h
new file mode 100644
index 0000000000000..1c0eb56c8f867
--- /dev/null
+++ b/arch/x86/include/asm/amd/amd-pstate.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Public interface for the AMD P-state driver.
+ */
+#ifndef _ASM_X86_AMD_PSTATE_H_
+#define _ASM_X86_AMD_PSTATE_H_
+
+#include <linux/types.h>
+
+#if IS_ENABLED(CONFIG_X86_AMD_PSTATE)
+bool amd_pstate_cas_active(void);
+#else
+static inline bool amd_pstate_cas_active(void) { return false; }
+#endif
+
+#endif /* _ASM_X86_AMD_PSTATE_H_ */
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 1c6bf56c3215b..15590e9da2dca 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -248,8 +248,8 @@ int amd_get_effective_highest_perf(unsigned int cpu)
 	if (ret < 0)
 		return ret;
 
-	/* without preferred cores, return the highest perf register value */
-	if (!prefcore)
+	/* Reuse the cached value for homogeneous CPUs without preferred cores. */
+	if (!prefcore && !cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
 		return boost_numerator;
 
 	/*
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3e0308f644778..415553109fc26 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -39,10 +39,12 @@
 #include <linux/power_supply.h>
 #include <linux/static_call.h>
 #include <linux/topology.h>
+#include <linux/cpuset.h>
 
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
 
+#include <asm/amd/amd-pstate.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
@@ -86,6 +88,10 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
+static bool amd_pstate_cas = IS_ENABLED(CONFIG_SMP);
+static bool amd_pstate_cas_initialized;
+static u32 amd_pstate_ref_freq_khz;
+static u32 amd_pstate_ref_highest_perf;
 static struct quirk_entry *quirks;
 
 /*
@@ -962,6 +968,117 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
 }
 
+bool amd_pstate_cas_active(void)
+{
+	return READ_ONCE(amd_pstate_cas_initialized);
+}
+EXPORT_SYMBOL_GPL(amd_pstate_cas_active);
+
+static void __init amd_pstate_init_cas(void)
+{
+	int ref_highest_perf = 0, ref_max_freq = 0;
+	int cpu, highest_perf, max_freq;
+
+	if (!amd_pstate_cas)
+		return;
+
+	amd_pstate_cas = false;
+	if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+		return;
+
+	for_each_online_cpu(cpu) {
+		highest_perf = amd_get_effective_highest_perf(cpu);
+		if (highest_perf <= 0) {
+			pr_warn("Invalid highest performance (%d) on CPU%d\n",
+				highest_perf, cpu);
+			return;
+		}
+
+		max_freq = amd_get_max_frequency(cpu);
+		if (max_freq < 0 || (u32)max_freq > U32_MAX / 1000) {
+			pr_warn("Invalid maximum frequency (%d) on CPU%d\n",
+				max_freq, cpu);
+			return;
+		}
+
+		if (highest_perf < ref_highest_perf ||
+		    (highest_perf == ref_highest_perf && max_freq <= ref_max_freq))
+			continue;
+
+		ref_highest_perf = highest_perf;
+		ref_max_freq = max_freq;
+	}
+
+	if (!ref_highest_perf) {
+		pr_warn("No reference CPU available for capacity scaling\n");
+		return;
+	}
+
+	amd_pstate_ref_highest_perf = ref_highest_perf;
+	amd_pstate_ref_freq_khz = ref_max_freq * 1000U;
+
+	amd_pstate_cas = arch_enable_hybrid_capacity_scale();
+}
+
+static void amd_pstate_update_cpu_capacity(struct amd_cpudata *data,
+					   bool highest_freq_available)
+{
+	unsigned long capacity, max_capacity, capacity_freq, base_freq;
+	int cpu = data->cpu;
+
+	lockdep_assert_held(&sched_domains_mutex);
+
+	if (highest_freq_available && amd_pstate_ref_freq_khz) {
+		capacity = data->max_freq;
+		max_capacity = amd_pstate_ref_freq_khz;
+		capacity_freq = capacity;
+		base_freq = max_capacity;
+	} else {
+		union perf_cached perf = READ_ONCE(data->perf);
+
+		capacity = perf.highest_perf;
+		max_capacity = amd_pstate_ref_highest_perf;
+		capacity_freq = perf_to_freq(perf, data->nominal_freq, perf.highest_perf);
+		base_freq = perf_to_freq(perf, data->nominal_freq, max_capacity);
+	}
+
+	arch_set_cpu_capacity(cpu, capacity, max_capacity, capacity_freq, base_freq);
+	topology_set_cpu_scale(cpu, arch_scale_cpu_capacity(cpu));
+}
+
+static void amd_pstate_set_cpu_capacity(struct amd_cpudata *cpudata,
+					bool highest_freq_available)
+{
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	int cpu;
+
+	lockdep_assert_cpus_held();
+
+	guard(mutex)(&sched_domains_mutex);
+
+	if (perf.highest_perf > amd_pstate_ref_highest_perf) {
+		amd_pstate_ref_highest_perf = perf.highest_perf;
+		amd_pstate_ref_freq_khz = highest_freq_available ? cpudata->max_freq : 0;
+
+		for_each_possible_cpu(cpu) {
+			struct cpufreq_policy *policy;
+
+			if (cpu == cpudata->cpu)
+				continue;
+
+			policy = cpufreq_cpu_policy(cpu);
+			if (policy && policy->driver_data)
+				amd_pstate_update_cpu_capacity(policy->driver_data,
+							       amd_pstate_ref_freq_khz &&
+							       amd_get_max_frequency(cpu) > 0);
+		}
+	}
+
+	amd_pstate_update_cpu_capacity(cpudata, highest_freq_available);
+	x86_topology_update = true;
+	WRITE_ONCE(amd_pstate_cas_initialized, true);
+}
+
 static void amd_pstate_update_limits(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata;
@@ -1036,6 +1153,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf;
+	bool highest_freq_available;
 	int ret;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -1062,6 +1180,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
 	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
+	highest_freq_available = !!max_freq;
 	if (!max_freq)
 		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
@@ -1093,6 +1212,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 			 bios_min_freq, cpudata->cpu);
 	}
 
+	if (IS_ENABLED(CONFIG_SMP) && amd_pstate_cas)
+		amd_pstate_set_cpu_capacity(cpudata, highest_freq_available);
+
 	return 0;
 }
 
@@ -1203,6 +1325,7 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	freq_qos_remove_request(&cpudata->req[0]);
 	policy->fast_switch_possible = false;
 	kfree(cpudata);
+	policy->driver_data = NULL;
 }
 
 static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
@@ -1916,12 +2039,20 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static ssize_t cas_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_cas_active()));
+}
+
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RO(cas);
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cas.attr,
 	NULL
 };
 
@@ -2431,8 +2562,10 @@ static int __init amd_pstate_init(void)
 			return ret;
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
-	    IS_ENABLED(CONFIG_AMD_HFI))
+	amd_pstate_init_cas();
+
+	if ((cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	     IS_ENABLED(CONFIG_AMD_HFI)) || amd_pstate_cas)
 		amd_pstate_prefcore = false;
 
 	ret = amd_pstate_register_driver(cppc_state);
@@ -2441,6 +2574,10 @@ static int __init amd_pstate_init(void)
 		return ret;
 	}
 
+	/* Per-CPU capacities are set during registration; rebuild domains once. */
+	if (amd_pstate_cas)
+		rebuild_sched_domains();
+
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
 		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
@@ -2481,8 +2618,17 @@ static int __init amd_prefcore_param(char *str)
 	return 0;
 }
 
+static int __init amd_cas_param(char *str)
+{
+	if (!strcmp(str, "disable"))
+		amd_pstate_cas = false;
+
+	return 0;
+}
+
 early_param("amd_pstate", amd_pstate_param);
 early_param("amd_prefcore", amd_prefcore_param);
+early_param("amd_cas", amd_cas_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.34.1

