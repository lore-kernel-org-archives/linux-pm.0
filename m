Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794668683;
	b=cSjgWF4+cdRZessd2LMUEH7zYy1MCZdBuRWGvHwbFi6pbCt6dior1rnGYORISu5/rpMj
	 E6yLuI3b7DpAL6hQjKKY0XRpTw0QpHy7R4mob9GsJbmFQ8CJDhHxAWjopQCRWyfzyCKId
	 qSQ7Ja8nBRQKyW+7oL9yUvcea7m3OzXW9pd+H88GZrUVIOqrhtBllfGjTW0IKjOIiFx2P
	 w6yu1MGYv7/48wgoHnfiY/YKxsz2DdeWh8lI+XLA9x+o8C1GD85m1xRxst07ArcYKphfU
	 B/7R5O2Ou/hXnf6ZSFF5xXIBUzth0CA8IbDAffSdEbaUK2nr+t6kudtKBh6cb/C2/3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668683;
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
	bh=6UC3xwe/SV/whrXZ66wfS1Rt4zW6Ry+myesv3WMgStM=;
	b=O+DVspa2ucybn4anPakpPBXn0scWWYM2a6qgaaBRy02MpF0G7LoSffkfKRNzlcLL25/8
	 f0D23MwMwu3+L8NwyvbpWh3gBneaKrsU7ysKaqV+G87C19f/fxp9RGEXKpTjx90AboRyC
	 td/e1q5Q7o17LPASH1asJTNpilfItPUsARhMRvutvklGH+lDOk8K2LozBAgAG3mDYs0/4
	 WI2hp5/lU4luV4b/05XEhO/sbSAL5+/9cAsN+nGB6qD0uuvdMUmQT8JJfnbQRJuTjfAg/
	 D4HbPng69Ms6rpeWziiJwon+HiukPezIBP6ua+Hvywda+VXkxrZjMyxmAVLNfitXgWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K92hklkq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.38
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D26606A32D;
	Sat, 14 Nov 2026 15:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D26606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K92hklkq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQfpCDBt6kShMX+Rrvhva262dNDzm9w8Hfz+Sf6bXulHsJ26JgGFJByQTksJ+calhQRTDomsO6EYBcTEIa9q+Fkkig7W5dx59Zl/ITR0zshbJVB7isvVTae18nWRIOYJGQ7hYkgIbETEO5fUo9UQIGo6VV+iICtgfGKV16BMGiCpZW6LPpn7DO11Lnr3xuAdbYvCID+OfyEIEtmI/tlgqHeQFgoHbFJD/1vU3doWyrtv47tIcKTjGNNTAzX5cgKe9Mw8fhv+zoU9dbk4Mz+vIwRHvLH+5+5cj29trzHUI2tmAyZ4ehyvHSBATqqrQ4DrtRpU4dv6Tw03C7aPx/Pwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UC3xwe/SV/whrXZ66wfS1Rt4zW6Ry+myesv3WMgStM=;
 b=w/6djst206PFeSOKNnrYRJ7z/iGav1IR3pY0LB41T7rvNIqD4C0zCZt7o7IywtOP8dHjIl4PB7xFmiDFv7NcFenADGES2L/o+Yj06S6kZI2q7X7BkW063MptHBhziMFT9xgGFA7GG033dXzaM9w9EDd94zGqU27xaw/LZP0pwPSY7kNIFMx5YOBgYEa52qasqBZv+/j8I1/oOJtgA7tb7Yh+aiYD/tEUkSoWDvUWN5acC75Cp59xYYVxm+sQOPkeIBKh2gxvUPyFwUbOm8eq2O58m5/kpJBlS4ZsU7QBuxcd3tb+hLDLabISBb1gVXifvc9RUw47xy9vN0C4p9kCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UC3xwe/SV/whrXZ66wfS1Rt4zW6Ry+myesv3WMgStM=;
 b=K92hklkqtIHWWq4k87D+J168MDa9vEx33ekzR22d+RUzthJ2dFPCybWdYibcPi4jTBVft5QlHkYYTMMs2U4W4LrAH/wgPCjAmlstSv8a6ifqqaBJtLRLHoPYP0IKfjF3ldootECApQzY+de6wplcP2WE+fgK9aTY8zpASCrfwVc=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by PH8PR12MB999272.namprd12.prod.outlook.com (2603:10b6:510:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Sat, 14 Nov
 2026 15:03:37 +0000
Received: from SJ1PEPF000037A6.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sat,
 14 Nov 2026 15:03:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A6.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 15:03:37 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 14 Nov
 2026 09:03:33 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH 1/2] cpufreq: amd-pstate: Set asymmetric CPU capacity on hybrid platforms
Date: Sat, 14 Nov 2026 20:33:09 +0530
Message-ID: <20261114150310.1377654-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114150310.1377654-1-Vishal.Badole@amd.com>
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A6:EE_|PH8PR12MB999272:EE_
X-MS-Office365-Filtering-Correlation-Id: 99964e15-6d17-4788-ae2a-08df4260761d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|22082099003|18002099003|6133799003|261022105027099003|921020|11063799006|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|56012099006|261026121527099003|261026140227099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FIH3KHdVIUpeVqYg8rs6VGapyfErX69BM5tvayP0uJT37yhCjLQPYN2H8fid948eqh+EH5CfjIZN2yiHU5RWEywyn8kNCtJ2NBjSHKWiIcSjOB17g+f2cE6POmwX5KJJ4ylpWeQIXZG4dA/AVqA6dkUo7iFtr109hWYarynuQgUUatSS9O/JRUQuNYO3pLn+hR7yh8mZ4a4VJDcjj0uYvmYepKTowuY3XYANhZHWIS/LDpP3ggMsD1WjRRi0y9but+9u4QY9WNSZ8sXFiklyV84qmPYImAh/UMBdqbwhUqexuJp9d7U55FVYL2/SqHxqxFskeerTb/e9qzdvWa9jC0yxaMcIRPUSVCX+aW7fmvBqlWwIjK5AO6n9UAIDdJRvyMqdeQkjkqz/WN2i6sDIAvyQxTwgUTXE4w2aYzztYvQp1sJ09tl4/cpzkMPXQoiDk2tj78PONuFU++jq8t95ULR+s4PMH/oubfmTEmB5sXIUveypfk2Jmb4pG6MrRYOBTPDnna3Cg5WMv8EP5n2UJRotp+dFwSJeD7XMw2TdDLQib2v5A0tzcTdnHUojGB99VMUkiOJnVEak0A18MaETfTU4ojDkk5XHxb4PtSzzj8bWMGQs/YV0zZlQAhagjTkRump3vASesI1yWQ/t2XtOqsKBMmczDKiTtHM0CLi3sI370da6DEElXj+J59DHYJk2S3DgZk+x+9MbyDnQAYucijLKyujcG3QNJTffluufplii8ku5Yb83ZLR9goITJyT4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(261022105027099003)(921020)(11063799006)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(56012099006)(261026121527099003)(261026140227099003)(261009221227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wre3L7hwzpgLwtkLJ7egg6IlbkyE2enp4V7qMRELM79sOuH+qQUASEYP9H2N0iTWNrSc+ZtbiZHpfsveR1HOW5OU3yAUEZO5blKgYvwvdJ26EOiYYS1egm1+lWU5F10W3qhrA+/Y44TUXReOArTuvyYfs+93vt0I0sb+G342QLgZSwrAeI3ZE1uefBY5WbDcgfD6deg5fMoCkMcq6zYdCQZcax2M85khwnFkM2Yz6Uu6VeMXO2TouhqR4gqd2zVP2EbdKg96jzMBEzBC7yn/6nfN+8pTB5rx4yBrcbHcnqW38EQvWnJ2uE1H/GIw9hANOKNBd3JmMYduSNZ7jgxR4WuQkes9K6ijZilVEHdq2LrIokivd2VRB44GAfSIgpCN35NT35hiKkoxQRbTxx62+lS4OORNxZNo5hsgIK6pfcqv8TwcUUFOWfqXoVltzAg+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 15:03:37.4588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99964e15-6d17-4788-ae2a-08df4260761d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999272

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

Enable capacity aware scheduling on AMD heterogeneous-core processors.
Use CPU 0 as the capacity reference, assuming it is a highest-performance
CPU on the supported platforms. Cache its maximum frequency in kHz and
effective highest performance once before driver registration, treating
these reference capabilities as fixed for the lifetime of the system.
During per-CPU initialization, compute each CPU's capacity relative to the
cached reference and publish it:

 - When maximum-frequency data is available for both CPUs, scale by
	 frequency via arch_set_cpu_capacity().
 - Otherwise, fall back to performance-register based scaling using the
   effective highest_perf values.

Record frequency availability before applying the per-CPU fallback. Keep
frequency and performance references separate instead of interpreting a
boost-ratio numerator in performance units as MHz. The fallback base
frequency still depends on each CPU's nominal frequency and performance,
so calculate that conversion per CPU. Disable CAS if reference setup fails
without preventing normal CPUFreq registration.

Capacity aware scheduling is enabled by default on supported hardware and
can be turned off with the "amd_cas=disable" boot parameter. Its effective
state is exposed through the "cas" sysfs attribute, and also exported via
amd_pstate_cas_active() so amd-hfi can stand down when capacity aware
scheduling owns the heterogeneous cores.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 MAINTAINERS                  |   1 +
 drivers/cpufreq/amd-pstate.c | 102 ++++++++++++++++++++++++++++++++++-
 include/linux/amd-pstate.h   |  14 +++++
 3 files changed, 115 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..26217272be95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1324,6 +1324,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
 F:	drivers/cpufreq/amd-pstate*
+F:	include/linux/amd-pstate.h
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
 AMD PTDMA DRIVER
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b6..59eb2c4c7867 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -29,6 +29,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
+#include <linux/sched/smt.h>
 #include <linux/compiler.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
@@ -39,6 +40,8 @@
 #include <linux/power_supply.h>
 #include <linux/static_call.h>
 #include <linux/topology.h>
+#include <linux/cpuset.h>
+#include <linux/amd-pstate.h>
 
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -86,6 +89,10 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
+static bool amd_pstate_cas = true;
+static bool amd_pstate_cas_initialized;
+static u32 amd_pstate_ref_freq_khz;
+static u32 amd_pstate_ref_highest_perf;
 static struct quirk_entry *quirks;
 
 /*
@@ -957,8 +964,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 		return;
 
 	/* should use amd-hfi instead */
-	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
-	    IS_ENABLED(CONFIG_AMD_HFI)) {
+	if ((cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	     IS_ENABLED(CONFIG_AMD_HFI)) || amd_pstate_cas) {
 		amd_pstate_prefcore = false;
 		return;
 	}
@@ -969,6 +976,64 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
 }
 
+bool amd_pstate_cas_active(void)
+{
+	return READ_ONCE(amd_pstate_cas_initialized);
+}
+EXPORT_SYMBOL_GPL(amd_pstate_cas_active);
+
+static bool __init amd_pstate_init_cas(void)
+{
+	int highest_perf, max_freq;
+
+	highest_perf = amd_get_effective_highest_perf(0);
+	if (highest_perf <= 0) {
+		pr_warn("Invalid reference highest performance (%d)\n", highest_perf);
+		return false;
+	}
+
+	max_freq = amd_get_max_frequency(0);
+	if (max_freq < 0 || (u32)max_freq > U32_MAX / 1000) {
+		pr_warn("Invalid reference maximum frequency (%d)\n", max_freq);
+		return false;
+	}
+
+	amd_pstate_ref_highest_perf = highest_perf;
+	amd_pstate_ref_freq_khz = max_freq * 1000U;
+
+	return arch_enable_hybrid_capacity_scale();
+}
+
+static void amd_pstate_set_cpu_capacity(struct amd_cpudata *cpudata,
+					bool highest_freq_available)
+{
+	unsigned long capacity, max_capacity, capacity_freq, base_freq;
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		return;
+
+	if (highest_freq_available && amd_pstate_ref_freq_khz) {
+		capacity = cpudata->max_freq;
+		max_capacity = amd_pstate_ref_freq_khz;
+		capacity_freq = capacity;
+		base_freq = max_capacity;
+	} else {
+		union perf_cached perf = READ_ONCE(cpudata->perf);
+
+		capacity = perf.highest_perf;
+		max_capacity = amd_pstate_ref_highest_perf;
+		capacity_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
+		base_freq = perf_to_freq(perf, cpudata->nominal_freq, max_capacity);
+	}
+
+	guard(mutex)(&sched_domains_mutex);
+	arch_set_cpu_capacity(cpudata->cpu, capacity, max_capacity,
+			      capacity_freq, base_freq);
+	topology_set_cpu_scale(cpudata->cpu, arch_scale_cpu_capacity(cpudata->cpu));
+	x86_topology_update = true;
+	WRITE_ONCE(amd_pstate_cas_initialized, true);
+}
+
 static void amd_pstate_update_limits(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata;
@@ -1043,6 +1108,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf;
+	bool highest_freq_available;
 	int ret;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -1069,6 +1135,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
 	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
+	highest_freq_available = !!max_freq;
 	if (!max_freq)
 		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
@@ -1100,6 +1167,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 			 bios_min_freq, cpudata->cpu);
 	}
 
+	if (amd_pstate_cas)
+		amd_pstate_set_cpu_capacity(cpudata, highest_freq_available);
+
 	return 0;
 }
 
@@ -1923,12 +1993,20 @@ static ssize_t prefcore_show(struct device *dev,
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
 
@@ -2438,12 +2516,23 @@ static int __init amd_pstate_init(void)
 			return ret;
 	}
 
+	amd_pstate_cas = amd_pstate_cas && IS_ENABLED(CONFIG_SMP) &&
+			cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES);
+
+	/* Enable CAS for processors with heterogeneous cores. */
+	if (amd_pstate_cas)
+		amd_pstate_cas = amd_pstate_init_cas();
+
 	ret = amd_pstate_register_driver(cppc_state);
 	if (ret) {
 		pr_err("failed to register with return %d\n", ret);
 		return ret;
 	}
 
+	/* Per-CPU capacities are set during registration; rebuild domains once. */
+	if (amd_pstate_cas)
+		rebuild_sched_domains();
+
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
 		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
@@ -2484,8 +2573,17 @@ static int __init amd_prefcore_param(char *str)
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
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
new file mode 100644
index 000000000000..eb750abd20f7
--- /dev/null
+++ b/include/linux/amd-pstate.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Public interface for the AMD P-state driver.
+ */
+#ifndef __LINUX_AMD_PSTATE_H__
+#define __LINUX_AMD_PSTATE_H__
+
+#if IS_ENABLED(CONFIG_X86_AMD_PSTATE)
+bool amd_pstate_cas_active(void);
+#else
+static inline bool amd_pstate_cas_active(void) { return false; }
+#endif
+
+#endif /* __LINUX_AMD_PSTATE_H__ */
-- 
2.34.1

