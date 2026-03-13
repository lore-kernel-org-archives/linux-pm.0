Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023077.outbound.protection.outlook.com [52.101.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CC5474F
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369311; cv=fail; b=lCZ3x9I24nJSzHapy7+wfvG2DMwoVwQlvEyUfQxNut1gtfdbiOIdJWPjguscyAr7GCba8xH5ykQsp/aa8r4fDOlQePY+pZPfkx367UeP3Nw14dRj934GIHFGJK7Dv0AOYVmNoxUmGpZJ60u6oHTO1C+mr7zR1lI1xGdTw3aazSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369311; c=relaxed/simple;
	bh=Mu9k58UH6eekBhS6UUU6twViks2az5FrsHU6tqAkgns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sODzN0JjaWI3Wzrt+JaaU0ceTkOXYp2Ko3XgIYIeHcflY2HLU7XGogtBOn8mzXV9SbfRuwXJbNVdkOD3ggWVLKcmy8la2JOJEsNkAtPIpbryJdJuAPpFJC6HSmotFn40JSH/Uj8K+IKDso9k0iteIeB0p+KYJepuYq0Ew2EJ7qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=iqzkKWJ3; arc=fail smtp.client-ip=52.101.127.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="iqzkKWJ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl4Wvne2RS46xVKUGFXWFLRxLMZJfElrHhLkhIZbW2E82yOIFHqmxkql7rOJS9TarK1XXEts+xj/QsU8iOPGitADdvQ2jJDpV+MHZOXYCHdARnYmfnUE4YDp4meMLRAj5dSPx0/Omx6CFubqxbgw2FeIWShVChc3kJq53Ne9Mcq3AWBwT0fgHr7DuXdLr7pTRsiRa3u5IRcxYE1SMTjaWd0jAlDRFXGW2/03W+ZBngdOS7f9WfYZCuCsilSW3ORY53C4KW8Sodk8gyBfHV45mSkn9oEtHA0PN+bPn0WaC3ROmQgLDIEQcFVz3DcDKqEGEdP1b8mfvhWLE0E4He+5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEwRWOHTViCJBWHZi9VOKMK9Z7CZJsgVtx7pH2MQnEk=;
 b=MTlH0Fg9LbDF0DAKUHLDoLN1xyjH4sOq4NsOl3HY7SAOHcl3rvnfM2Yt2D/fKEBm9pzFTj1j1oFRFXv8jago9KHNxpR7yhf4TGxDyKD/uBmPjSS0OLHfy6iJGNaX3eS5VNrUybfDFZbZM8zZSPfRCULMNpLN/u6SokARkC1Is9pzVyVI8h+WwIHYXyb8NpM/V5JExbZnn9FnTfLIGPD/RaYrKNonfb0Cx2r5gdZFTcnSOCkSTdjLr9UToWM2kZDYxhw4ScEGvJih2/B3+DnpxRkVq8OVC7Y8wFmhV8cTeWgvMr51b2FJKWKdwjGmetllOLow4Scqp7QPdwkiuwFg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEwRWOHTViCJBWHZi9VOKMK9Z7CZJsgVtx7pH2MQnEk=;
 b=iqzkKWJ3ofSAmxtAh0uPBcpUFosUCihQEpz054sfNmn6x1KYISY1sausG/er9A8IkB22tFbFe01c8Zy/WmVahfqelGp+2x5S69PWIXeYpyXK+EH6uOqP3pmnCwlcL63h0j2rOUjuSElIYrHEe3yVKCL6v70PI+qRAgWBqvu7+OyIZvltLMGi9BJHOzJziryqIfpCwXFUfamp+v8ySOQP0hE62rjt6+ogP4SLmgFNft+IVkTm3B2j7JDE858RHMpA7+uuBuXDor4MgBsn/doNw/qwyWr9mrLKLzWjxSIacKgH7Rr8JkVd1hzkPvT/qahRq+Nt+T4nyxrbE+ziP1RLWg==
Received: from OS7PR01CA0111.jpnprd01.prod.outlook.com (2603:1096:604:258::7)
 by SI2PR04MB5695.apcprd04.prod.outlook.com (2603:1096:4:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 02:35:03 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:604:258:cafe::1c) by OS7PR01CA0111.outlook.office365.com
 (2603:1096:604:258::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 02:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 02:35:03 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id 04E361B0;
	Fri, 13 Mar 2026 10:35:03 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [RFC PATCH] cpufreq: acpi-cpufreq: add DMI fallback for boost freq when _CPC is absent
Date: Fri, 13 Mar 2026 10:34:14 +0800
Message-ID: <20260313023414.364989-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|SI2PR04MB5695:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70947282-0a7f-4062-900c-08de80a921a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	za7AMFkdp/epTLTUvb/81e+tdYLfX212KqW2xsqNBTXbq4dPF1YgzPFcaIDPeTb04JHS2S1bzFAEyBEzmNqAYh1hzjnJmSNbViIFS14Dplzx7HT5ulFvH2i1lMzEht5xrIIedmwS5zgWiOginFvs67kcUuWUlHOP2vQcp9Rglv6pDVNIibh9Zg91fgBZEmt/Ikuc4mfe9fF+tjlPWPS83EFSCCzS4GtFUPEuZIAys6aOq8YWVmF5ds1DsPjTJmFCmfZF1HYGq2FvVovhXsbP7PJ8/mPYPNNpitek7axmkA655s0BM5CGau5G1YZR4DNSbNw5BlXsX6pTe/n1vxHub1iofL7fxh+TU2QuJKyIp+Oziqexv2e00dlkwKvbN80Ggfg3z0ZIs3loS2Kw6irbNF8GcUOz0Juy8hIogCIOQLQH3g/DQDL2cWnsNrGzr6uu9JzeIddLU2bvy+ScXv5IrjdU1VPsgsONo8RLV27nhcBmzefBfYjLw9PCW08xjyAsZZzegYZ/3UGzsJqZF9FNTScTCgdVbRX8AxL1VsloP0AUF03z39MXnQbUisrYqK0IgHBrHfbNn8763ymH8dP1wPreyhXj+n2e9M+Ylj11ywbFBRLwfNA0lXRj2NZ+D3l9lwlH8/YTNjjEFUa77nORmvh4GpB2KtPMwSNA1anSf0Fu+Bn084bZCBtaGVO1Za8YhAG2i4rQmOpBfVijzPRCw6E/bZfgQiJHOCfqmHZ0EW7ntpxUVilOT+ly93RzC7PSszfkcP4BPGjWpiS4O5mD+g==
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+a3Rw+Yt6xjjAQ2mecnlQpt61Fvi0vUywMGAthuaWkKO66hbzNeOh6lPUNTDy5LHfx+RhCIExOquEd1n5MZh0UmZJB0bDeMkZkL6gBb2fTMi9aTnoavY57Fxb2qh3ye7ZMNnQG4uJaJZubCpQZaUazsiSrwHRsxpRAcAxINKZdOtbwALOqj0Y300pR3UmH8gb//dJBLahQCGm/BeRbf/7SNYvM90WqyKjMHZNcEV8GhTWL6e4Jt08ya9+IVdFR31AdiSAEHgfEZS0Xlb+6bFiGRtGO3CUQt2noJ9/DQjbNHeH6YKeheHDbKv3Ey+QPO/qHzpL3C0mFMLQf6GKbbsWmyFFCTdpmA130Eds2tiil9zx8lmkT3zA/DkdIAcUeLxdIEcnEIBPeK3CPxS6d1eRk4kgcBjGNSM64NkTjD8n6SqKNR8yfs42io4A5RAQO3/
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:35:03.4025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70947282-0a7f-4062-900c-08de80a921a5
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5695

On AMD Ryzen Embedded V1780B (Family 17h / Zen 1), the BIOS does not
provide ACPI _CPC objects and the CPU does not support MSR-based CPPC
(X86_FEATURE_CPPC). The _PSS table only contains nominal P-states
(P0 = 3350 MHz).

get_max_boost_ratio() fails at cppc_get_perf_caps() and returns 0,
causing cpuinfo_max_freq to report only the base frequency instead of
the rated boost frequency (3600 MHz).

Add a fallback that reads the processor max speed from DMI Type 4 when
get_max_boost_ratio() fails. A sanity check rejects DMI values where the
boost-to-base ratio exceeds 2x, based on a survey of the AMD Ryzen
Embedded V1000 Series where the highest ratio found is 1.8x (V1404I:
2.0 GHz base / 3.6 GHz boost).

Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
This is an RFC to discuss the approach. This patch is based on 6.6.x
where testing was done. If the approach is acceptable I will submit a
patch against mainline.

== Background ==

This was observed on kernel v6.6 and v6.19 (Ubuntu)

The BIOS does not provide ACPI _CPC objects:

  [   13.051374] ACPI CPPC: No CPC descriptor for CPU:2

The _PSS table contains only nominal and below P-states (P0 = 3350 MHz).
The CPU is Zen 1 and does not have X86_FEATURE_CPPC, so MSR-based CPPC
registers (MSR_AMD_CPPC_CAP1 etc.) do not exist on this hardware. I did
not find CPPC MSRs documented in the AMD Family 17h Open-Source Register
Reference [1], but this may not be the complete reference for this CPU..

== DMI fallback ==

I noticed that cppc-cpufreq already has a DMI fallback
(cppc_get_dmi_max_khz) for reading processor frequency from SMBIOS
Type 4. Checking my V1780B, DMI "Max Speed" shows 3600 MHz which
matches the rated boost frequency. I prototyped a similar fallback in
acpi-cpufreq with a sanity check (DMI value must be above _PSS P0 and
within 2x of it), and cpuinfo_max_freq correctly reports 3600000 after
the change.

For the 2x upper bound: the highest boost-to-base ratio I found in the
AMD Ryzen Embedded V1000 Series [2] is 1.8x (V1404I: 2.0 GHz base /
3.6 GHz boost). I have only checked this product line and the threshold
should be adjusted if other AMD platforms have higher ratios.

== Questions for maintainers ==

1. Is this worth fixing in the kernel, or should it be treated
   strictly as a firmware deficiency?

2. If a DMI-based fallback is acceptable, where should the code live?

   a) Extract cppc_get_dmi_max_khz() into a shared helper so both
      cppc-cpufreq and acpi-cpufreq can use it without code
      duplication.

   b) Add a separate DMI read in acpi-cpufreq directly, accepting
      the small duplication since the usage context is different.

   c) Something else entirely.

3. For the sanity check upper bound (currently 2x of _PSS P0
   frequency), is this reasonable? The highest ratio I found in the
   V1000 series is 1.8x. I do not know if other AMD product lines
   have higher ratios.

Tested on AMD Ryzen Embedded V1780B, kernel v6.6:

[~] # dmidecode -t 4
# dmidecode 3.5
Getting SMBIOS data from sysfs.
SMBIOS 3.2.0 present.

Handle 0x000F, DMI type 4, 48 bytes
Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 10 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 17, Stepping 0
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                MMX (MMX technology supported)
                FXSR (FXSAVE and FXSTOR instructions supported)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                HTT (Multi-threading)
        Version: AMD Ryzen Embedded V1780B
        Voltage: 1.3 V
        External Clock: 100 MHz
        Max Speed: 3600 MHz
        Current Speed: 3350 MHz
        Status: Populated, Enabled
        Upgrade: None
        L1 Cache Handle: 0x000C
        L2 Cache Handle: 0x000D
        L3 Cache Handle: 0x000E
        Serial Number: Unknown
        Asset Tag: Unknown
        Part Number: Unknown
        Core Count: 4
        Core Enabled: 4
        Thread Count: 8
        Characteristics:
                64-bit capable
                Multi-Core
                Hardware Thread
                Execute Protection
                Enhanced Virtualization
                Power/Performance Control
[~] # dmesg | grep CPPC
[   13.027604] ACPI CPPC: No CPC descriptor for CPU:0
[   13.039499] ACPI CPPC: No CPC descriptor for CPU:1
[   13.051374] ACPI CPPC: No CPC descriptor for CPU:2
[   13.063244] ACPI CPPC: No CPC descriptor for CPU:3
[   13.075326] ACPI CPPC: No CPC descriptor for CPU:4
[   13.093111] ACPI CPPC: No CPC descriptor for CPU:5
[   13.104874] ACPI CPPC: No CPC descriptor for CPU:6
[   13.131102] ACPI CPPC: No CPC descriptor for CPU:7
[~] # dmesg | grep acpi_cpufreq
[   13.021943] acpi_cpufreq: overriding BIOS provided _PSD data
[   13.032393] acpi_cpufreq: CPU0: Unable to get performance capabilities (-19)
[   13.044289] acpi_cpufreq: CPU1: Unable to get performance capabilities (-19)
[   13.056163] acpi_cpufreq: CPU2: Unable to get performance capabilities (-19)
[   13.068035] acpi_cpufreq: CPU3: Unable to get performance capabilities (-19)
[   13.086044] acpi_cpufreq: CPU4: Unable to get performance capabilities (-19)
[   13.093111] acpi_cpufreq: CPU5: Unable to get performance capabilities (-19)
[   13.123799] acpi_cpufreq: CPU6: Unable to get performance capabilities (-19)
[   13.142418] acpi_cpufreq: CPU7: Unable to get performance capabilities (-19)
[~] # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
3350000 2300000 1600000
[~] # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq
3600000

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/56255_OSRR.pdf
[2] https://www.amd.com/en/products/embedded/ryzen/ryzen-v1000-series.html#specifications

 drivers/cpufreq/acpi-cpufreq.c | 53 ++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..99b82b014ea4 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -34,6 +34,7 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+#include <asm/unaligned.h>
 
 MODULE_AUTHOR("Paul Diefenbaugh, Dominik Brodowski");
 MODULE_DESCRIPTION("ACPI Processor P-States Driver");
@@ -628,6 +629,36 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
+/* Minimum struct length needed for the DMI processor entry we want */
+#define DMI_ENTRY_PROCESSOR_MIN_LENGTH  48
+
+/* Offset in the DMI processor structure for the max frequency */
+#define DMI_PROCESSOR_MAX_SPEED         0x14
+
+/* Callback function used to retrieve the max frequency from DMI */
+static void find_dmi_mhz(const struct dmi_header *dm, void *private)
+{
+	const u8 *dmi_data = (const u8 *)dm;
+	u16 *mhz = (u16 *)private;
+
+	if (dm->type == DMI_ENTRY_PROCESSOR &&
+	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
+		u16 val = (u16)get_unaligned((const u16 *)
+				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
+		*mhz = val > *mhz ? val : *mhz;
+	}
+}
+
+/* Look up the max frequency in DMI */
+static u64 get_dmi_max_khz(void)
+{
+	u16 mhz = 0;
+
+	dmi_walk(find_dmi_mhz, &mhz);
+
+	return (1000 * mhz);
+}
+
 static u64 get_max_boost_ratio(unsigned int cpu)
 {
 	struct cppc_perf_caps perf_caps;
@@ -838,13 +869,25 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		 */
 		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
 	} else {
+#ifdef CONFIG_ACPI_CPPC_LIB
+		u64 max_speed = get_dmi_max_khz();
+		unsigned int freq = freq_table[0].frequency;
+
 		/*
-		 * If the maximum "boost" frequency is unknown, ask the arch
-		 * scale-invariance code to use the "nominal" performance for
-		 * CPU utilization scaling so as to prevent the schedutil
-		 * governor from selecting inadequate CPU frequencies.
+		 * Use DMI "Max Speed" if it looks plausible: must be
+		 * above _PSS P0 frequency and within 2x of it.
 		 */
-		arch_set_max_freq_ratio(true);
+		if (max_speed > freq && max_speed < freq * 2)
+			policy->cpuinfo.max_freq = max_speed;
+		else
+#endif
+			/*
+			 * If the maximum "boost" frequency is unknown, ask the arch
+			 * scale-invariance code to use the "nominal" performance for
+			 * CPU utilization scaling so as to prevent the schedutil
+			 * governor from selecting inadequate CPU frequencies.
+			 */
+			arch_set_max_freq_ratio(true);
 	}
 
 	policy->freq_table = freq_table;
-- 
2.43.0

