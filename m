Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023086.outbound.protection.outlook.com [40.107.44.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152C3DB63A;
	Tue, 24 Mar 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343475; cv=fail; b=kx88UaKO1TBh6ERRf6ZZ3d4uGLd3Uiv+SosxCHxQQngOhXmd3ffDuVl8Zm3oaUNElFLn7hZ0xQvJ2g4XqghJzp8AE2APamJ+Xpz1nbiDKYoqcWSdcYBUaX4UFJ9RjdVtSihdzRgqO+A+AdenCCtBzc2NArl7h6ng8c1BTc40u9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343475; c=relaxed/simple;
	bh=xgATc/WPXo53DbFalpCjRSrGMTJTi9rmDp2mFgv3vVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQ7ZFiwNs8c7/fPdt8TnM3gdwmVdzbSQfvufsOV1pWlw5kYhWwksgKuEzqzIYxA2kwU0dJaiu+0YFW8A3mcCmoyZHZUJvL+tuxEsO/7bLU8vGvng8Sm8tbWZJeMux+okhwTHD/63/ut+29J6j1Q4carLJPTFfNP0kx43mye+RY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=b5QnRBUJ; arc=fail smtp.client-ip=40.107.44.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="b5QnRBUJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtqz8jCd+AXyRAlRvQslDG3916Rwf3b6S7D1ZmhFFWQCxr6OoqgFs2jlLE7keu/sJhKzRomBNsWvryxhSk46GpLs1rtjb5dNVir4wdcS1a+fHWgY1kdL9u16xDmlwXQDK/2wl/snEM2x4qxxAIb9aHquJ5bfsKWumfbEHa18QU3kmFFmKdlspNs7iYFNOFHvw63PUIIEAYwQjTh3QbYumGHOvo+lQ0Ou+b5EmBbrX1tYT4XnH9VnJz0qyzXfaC8FwV5X23ouN/z9TB1EFMwcuGF1vlhFmvHCBIHvK+/mxe1w259mFeNhCfaG2SWCBZTLkfMmIeGgHLS/XSiZBaAeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDPITf1rIsNCukMW9/F0pVyuRVbxckr59pHEOxvQLbQ=;
 b=aThzFsVTJ6powcJ2PKE0ZU9VUNA+bwQuIuCc6Yk3TsFhKGtCQ433ge7ddEMobujp3Jj+yZJDXQnDaodmRhAMWrGh1IfcPK+8WVLcpLHvU2PE3IHFYxBJrLrObewzMZ7QQGE3ebnWyZ79bsJ1cU/VvzLQKtgfW9TYkkvAe71HfpIrlfEIz5CY0gDl29+BYmnaG+w156+GG/rLFjPa7k7y51nbiDNBWQYJmRbjKVb9KfJLLRAfRzWykmaOu0BX83EZsXSSIWtcuG/1/kWCskja0T82qOp6QtfMF0wkzfHWenS2s6yAZkipxZQc2hOg0t12dsOKCX9rEie5Vt87m8PpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDPITf1rIsNCukMW9/F0pVyuRVbxckr59pHEOxvQLbQ=;
 b=b5QnRBUJ7MrFxNGNtNI4e7MGSDvNppEa8gJWC7IVMpwGB+axePUQlEMvTmU6ojYwU4tPUHNC9W8Bb1aKdwjcAscW9s2O033ZArjKueqwgCKOP1CSKjDcuRfgB5jhkXdQnC7MmpiJKujEhRXMAGxxiTstb8YOjWGvt56PWEQCXoq36Mro0ZYm0oQWoLQX735wScKC/G0Bw++9E50y7Cqnxq1Rz1J2Mr7dS3yfR7ZzVfXzvl5ynKKLuLcA6f2icYi1L7GtE3wlyBlc3mHSkwurpIibZhRhE3vKpr98+1FR5vKI3u4N7iE2seRD3fdEuEWr4xbl90m8xjgJ6CIqCzOPEg==
Received: from SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) by
 SI6PR04MB8344.apcprd04.prod.outlook.com (2603:1096:4:232::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Tue, 24 Mar 2026 09:11:06 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:7c:cafe::75) by SG2PR03CA0103.outlook.office365.com
 (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 09:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 24 Mar 2026 09:11:06 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id 181EC2AD;
	Tue, 24 Mar 2026 17:11:06 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH v2] cpufreq: acpi-cpufreq: use DMI max speed when CPPC is unavailable
Date: Tue, 24 Mar 2026 17:09:48 +0800
Message-ID: <20260324090948.1667340-1-henrytseng@qnap.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SI6PR04MB8344:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4031e0b7-aa69-4f6c-0f1c-08de8985482c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	XKjHgwdURzK6waW25BNkDfYb1HgooMJ1s0cWDfLsmj1gq0glZc3r741lLge9nWM8Ee6NN+0RZuK3AwCeUlHHQHMsc0Ts6jLGDDGQ1nyNBuwMXx3l0d7PdF/xoLWJh3tMdKRU/MHWBphhcQseoGY6aZxm35mflVQm/cIOGZ2NRZPaxOYkUFe2YZNTbRELVIw54pV9h/GrVbwCVURoUZxUr+bth0ndVNKFJJ7Yr/5ZK8pAlTM+8vcNjhcdg9vAQJ8GwG5EEnzJbeMA/RHWuU/1Vqrvu1vnZ9KnVijWrzp5UqeoV7YLl7+1/8aTQC2n8fcBCUQNRIxRUPw8Do+nZ1JVD9Rz1Ujna40IImdep3qIvd7Vkfiry9qeY1zRaZ8kq/xfsenrBIXw2hA2o442CiCHF88OTyg1Z5aZDTXsnNtfV35EcfyJvG7K2u6jiiPyYa7zCROuyAMtfnUG6U+iXFNhEp89IAIJEiSYh8v9iPpVk+uPJzNEo9ISXT8uSk0ktkXilGd+oXPaef8eEytntWx0TZuFn7qg733OgrewhdBFRwstomVvGTJTYFtb8dtPE1hwhpA11/QUJ3baTVY4T2kEsqeptE/+cSTNsJifXhRxeoegPRvG8vJZqRXG2xJzfQ8bKuGnB6+4PHsWrcODMWm9JOPXRAaq60+yPJHpS01xyCUm9RGpVQjvhwhX1oQ7ukfp+LO2kePvXLdbfKID/i23SQLC2I/+JYXfcqRG/yVFJ20ThV3ZvM2pEfD2wZXupbosoofno9L7HJKamzV/D5My9Q==
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wf1xS+HiM8T0Se9z00pBbImOAZ3c9z+4Lk+be95JqxoxYFcvEWSOHlZ02fkkdwSWupggP8Gu2fvcXJa8YmAdhrdV2KtnRV00XSEaoueQKC1BaFDYEFFSOuuxd+X/zYxsCr7AuAwLgt9Wq9FC7zcI+r+J5pX18aiHO5CHrGT5aN05/BJgYewIfftaT15t48UnahnqEEZzio7OoKOFH8aUyaVYjw5fARBfbm1FxvPhrM+ClnMVAXE6BLmn8COlYc90ifBfty3qRD+onmSrUapVOgZKmhZC6XT3uh9EcEdxZMLCrvXeBXSVY0uOJytPn9cjxgBl8FYN/b3/2W0eZHqUpK6Qz1cgN+rF7o95lhMIJUEHHhkQmgLaPQHL3uxoZ0oLe1PVYFzn6acajymmTsRH8TjVgWTai+ZCq6KxFKeSFd8ilApz1HAn1M07erHP5Tu0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:11:06.6276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4031e0b7-aa69-4f6c-0f1c-08de8985482c
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8344

On AMD Ryzen Embedded V1780B (Family 17h, Zen 1), the BIOS does not
provide ACPI _CPC objects and the CPU does not support MSR-based CPPC
(X86_FEATURE_CPPC).  The _PSS table only lists nominal P-states
(P0 = 3350 MHz), so when get_max_boost_ratio() fails at
cppc_get_perf_caps(), cpuinfo_max_freq reports only the base frequency
instead of the rated boost frequency (3600 MHz).

  dmesg:
    ACPI CPPC: No CPC descriptor for CPU:0
    acpi_cpufreq: CPU0: Unable to get performance capabilities (-19)

cppc-cpufreq already has a DMI fallback (cppc_get_dmi_max_khz()) that
reads the processor max speed from SMBIOS Type 4.  Export it and reuse
it in acpi-cpufreq as a last-resort source for the boost frequency.

A sanity check ensures the DMI value is above the _PSS P0 frequency
and within 2x of it; values outside that range are ignored and the
existing arch_set_max_freq_ratio() path is taken instead.  The 2x
upper bound is based on a survey of the AMD Ryzen Embedded V1000
series, where the highest boost-to-base ratio is 1.8x (V1404I:
2.0 GHz base / 3.6 GHz boost).

The DMI lookup and sanity check are wrapped in a helper,
acpi_cpufreq_resolve_max_freq(), which falls through to
arch_set_max_freq_ratio() if the DMI value is absent or
out of range.

Tested on AMD Ryzen Embedded V1780B with v7.0-rc4:

  Before: cpuinfo_max_freq = 3350000 (base only)
  After:  cpuinfo_max_freq = 3600000 (includes boost)

Link: https://www.amd.com/en/products/embedded/ryzen/ryzen-v1000-series.html#specifications
Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
v2:
  - Extract else block into acpi_cpufreq_resolve_max_freq()
    to avoid #ifdef in the main init path (Rafael)
v1:
  - https://lore.kernel.org/linux-pm/20260320095648.3598007-1-henrytseng@qnap.com/

 drivers/acpi/cppc_acpi.c       |  3 ++-
 drivers/cpufreq/acpi-cpufreq.c | 31 ++++++++++++++++++++++++-------
 include/acpi/cppc_acpi.h       |  1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f0e513e9ed5d..f53de414acf2 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1944,7 +1944,7 @@ static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 }
 
 /* Look up the max frequency in DMI */
-static u64 cppc_get_dmi_max_khz(void)
+u64 cppc_get_dmi_max_khz(void)
 {
 	u16 mhz = 0;
 
@@ -1958,6 +1958,7 @@ static u64 cppc_get_dmi_max_khz(void)
 
 	return KHZ_PER_MHZ * mhz;
 }
+EXPORT_SYMBOL_GPL(cppc_get_dmi_max_khz);
 
 /*
  * If CPPC lowest_freq and nominal_freq registers are exposed then we can
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e7eff6c2f092..21639d9ac753 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -675,6 +675,29 @@ static inline u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 }
 #endif
 
+static void acpi_cpufreq_resolve_max_freq(struct cpufreq_policy *policy,
+					  unsigned int pss_max_freq)
+{
+#ifdef CONFIG_ACPI_CPPC_LIB
+	u64 max_speed = cppc_get_dmi_max_khz();
+	/*
+	 * Use DMI "Max Speed" if it looks plausible: must be
+	 * above _PSS P0 frequency and within 2x of it.
+	 */
+	if (max_speed > pss_max_freq && max_speed < pss_max_freq * 2) {
+		policy->cpuinfo.max_freq = max_speed;
+		return;
+	}
+#endif
+	/*
+	 * If the maximum "boost" frequency is unknown, ask the arch
+	 * scale-invariance code to use the "nominal" performance for
+	 * CPU utilization scaling so as to prevent the schedutil
+	 * governor from selecting inadequate CPU frequencies.
+	 */
+	arch_set_max_freq_ratio(true);
+}
+
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
@@ -849,13 +872,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
 	} else {
-		/*
-		 * If the maximum "boost" frequency is unknown, ask the arch
-		 * scale-invariance code to use the "nominal" performance for
-		 * CPU utilization scaling so as to prevent the schedutil
-		 * governor from selecting inadequate CPU frequencies.
-		 */
-		arch_set_max_freq_ratio(true);
+		acpi_cpufreq_resolve_max_freq(policy, freq_table[0].frequency);
 	}
 
 	policy->freq_table = freq_table;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4d644f03098e..e6c5ef3173c5 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -156,6 +156,7 @@ extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu);
 extern bool cppc_perf_ctrs_in_pcc(void);
+extern u64 cppc_get_dmi_max_khz(void);
 extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
 extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
-- 
2.43.0

