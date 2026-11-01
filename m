Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793509224;
	b=SkTnumfgZXoTlZLMQe2q/mnkUtFP7vI9whP48Tkz2bveEH/oh84RkmmQp3gFj1teUHjb
	 1SZXAVwT3q4T9w/9KlcomknhpBK/kLk7Ceq9xt8Y3nf9iYAffsqBO0tngwW4UHiBN6z5Z
	 WFxEijTItcyBvHZ8s+a/I24YXqXncQrW6JEW7p7mNcdZEKgqMzuA9Q2JZzxX2/WVl0xET
	 v32AUFSwUqvoPYUDHrqMkE/IukfhahEpInXtzDRzkJAOpjVLFr8xM5RBrD17Xq7LB7gvj
	 92/obFjIxzGEMskn6X6vU1rWtDUlYIpHyDAwLKfRpKOyFCiZnih7FkY0+lJ18oitGxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793509224;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rACujdPmXShfVJjSCnZniYFGS+/T5IJ7cKbJqEND+wQ=;
	b=vPNlytuQeJv0+HnRK8D6Gr4kNcTDsaby1zonQtb0kEs2UHqgOwoIM06JWT4Zg6zN+tH+
	 whz0L/Y6L/grssEKjKfCFUR93WM8K/TBHN54hahYsIJpbBx4i1+UdByUTNPz8JdU+Y+DH
	 cUuZ5KAZYb7opvXc2dtyoYEDgLMfg51Apd4zDfEtUzUhPgpMI69uc+P6RPGQMXIpSh5S1
	 MpnaDvEV4Vwnn0ZYonZthDYVuvEojBCtae+bQCFZXontK47t59G/1w7ASOAFfnvwzY1qS
	 ZIWbwCUjLAMBL6k+F+CNPJPYbbNOTXUinxcSidzwGD6bVBy44p9AZFslm+kdL6xiRxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uz4fxj7S;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB1606A326
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 05:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EB1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uz4fxj7S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793509223; x=1825045223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TyD0HZT7zilNt5loQibJJZh5HSjVxAq9Dx29AMpj1Tg=;
  b=Uz4fxj7S7B30fbz7gUX1h9ZUQPflnGOB3dl8C9qVUuFZPI/1fggvf7YV
   mQbLKkQbPP0pRRtSBrRBso/RbXt4eWsHm1tc5+3PoerARBhCENN5x4i5h
   M413h21cjYa194EVQg4BO3i8Wj3k6HIj1bPEYBqp4oeXD23T2ZvcGbLrn
   Sv/0cvROCGk2WOfPxeZo9zG/1qiymmc79AaQwRqPrlRWT/WFQQgs+zB6C
   GCJRLarxr7fkVEPdaHEDpsDLzQdKpjSjKW23gT0j/BysQ7rfnPR2n/BoN
   Z4awJHaNj56/DRnzGP4vJRWXXUXIc/9lKZc+KG2C1BYuuCCi2EmJh7m4v
   Q==;
X-CSE-ConnectionGUID: CBSPJPtoS4iUTzskp9X/fA==
X-CSE-MsgGUID: W7SbIPPTTByLbfLYvfHduw==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2257519"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2257519"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 22:00:22 -0700
X-CSE-ConnectionGUID: Fmjg7WfpS5WsVV0BUN8OiA==
X-CSE-MsgGUID: 3rduh9tHQMSHY4nxW7VUXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="7608908"
Received: from baandr0id001.iind.intel.com ([10.49.109.195])
  by fmviesa013.fm.intel.com with ESMTP; 31 Oct 2026 22:00:20 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: len.brown@intel.com
Cc: dawid.osuchowski@linux.intel.com,
	linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: Add NPU power monitoring via Intel PMT
Date: Sun,  1 Nov 2026 10:26:10 +0530
Message-Id: <20261101045610.981310-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
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

Read the NPU_ENERGY counter (U32.18.14 format) from the Intel PMT
sysfs interface and expose a new column:

  NPUWatt  - average NPU power over the measurement interval (W)

The GUID and offset values for each supported platform
are taken from the Intel PMT XML definitions:
https://github.com/intel/Intel-PMT

Platform   GUID	        Offset
MTL	0x130670b2	0x628
ARL	0x1306a0b3	0x628
ARL_H	0x1306a0b2	0x628
ARL_S	0x1306a0b4	0x628
PTL	0x3086000	0x670
WCL	0x308d000	0x670
LNL	0x3072005	0x5d0
NVL	0x13000001	0x5e8

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Tested-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |   2 +
 tools/power/x86/turbostat/turbostat.c | 136 +++++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index c905198d0501..0a499ee3e98c 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -219,6 +219,8 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBSysWatt\fP Watts consumed by the whole platform (RAPL PSYS).
 .PP
+\fBNPUWatt\fP Watts consumed by the Neural Processing Unit (NPU), available on platforms with a loaded Intel NPU (intel_vpu) driver.
+.PP
 \fBPKG_%\fP percent of the interval that RAPL throttling was active on the Package.  Note that the system summary is the sum of the package throttling time, and thus may be higher than 100% on a multi-package system.  Note that the meaning of this field is model specific.  For example, some hardware increments this counter when RAPL responds to thermal limits, but does not increment this counter when RAPL responds to power limits.  Comparing PkgWatt and PkgTmp to system limits is necessary.
 .PP
 \fBRAM_%\fP percent of the interval that RAPL throttling was active on DRAM.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 83a3bd4c55b8..51c7e9065793 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -215,6 +215,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "LLC%hit", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "L2MRPS", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "L2%hit", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "NPUWatt", NULL, 0, 0, 0, NULL, 0 },
 };
 
 /* n.b. bic_names must match the order in bic[], above */
@@ -289,6 +290,7 @@ enum bic_names {
 	BIC_LLC_HIT,
 	BIC_L2_MRPS,
 	BIC_L2_HIT,
+	BIC_NPUWatt,
 	MAX_BIC
 };
 
@@ -407,6 +409,7 @@ static void bic_groups_init(void)
 	SET_BIC(BIC_PKG__, &bic_group_thermal_pwr);
 	SET_BIC(BIC_RAM__, &bic_group_thermal_pwr);
 	SET_BIC(BIC_SysWatt, &bic_group_thermal_pwr);
+	SET_BIC(BIC_NPUWatt, &bic_group_thermal_pwr);
 
 	BIC_INIT(&bic_group_frequency);
 	SET_BIC(BIC_Avg_MHz, &bic_group_frequency);
@@ -1935,12 +1938,14 @@ static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 #define SYSFS_TELEM_PATH "/sys/class/intel_pmt"
 #endif
 
+#define INTEL_NPU_DRIVER_PATH   "/sys/bus/pci/drivers/intel_vpu/"
 #define PMT_COUNTER_MTL_DC6_OFFSET 120
 #define PMT_COUNTER_MTL_DC6_LSB    0
 #define PMT_COUNTER_MTL_DC6_MSB    63
 #define PMT_MTL_DC6_GUID           0x1a067102
 #define PMT_MTL_DC6_SEQ            0
 
+#define PMT_COUNTER_NPU_LSB        0
 #define PMT_COUNTER_CWF_MC1E_OFFSET_BASE          20936
 #define PMT_COUNTER_CWF_MC1E_OFFSET_INCREMENT     24
 #define PMT_COUNTER_CWF_MC1E_NUM_MODULES_PER_FILE 12
@@ -1974,6 +1979,7 @@ enum pmt_datatype {
 	PMT_TYPE_RAW,
 	PMT_TYPE_XTAL_TIME,
 	PMT_TYPE_TCORE_CLOCK,
+	PMT_TYPE_UQ18_14,
 };
 
 struct pmt_domain_info {
@@ -2920,6 +2926,12 @@ static inline int print_decimal_value(int width, int *printed, char *delim, unsi
 	return sprintf(outp, "%s%lld", sep, value);
 }
 
+static inline double npu_energy_to_watts(unsigned long long raw, double interval)
+{
+	/* data format is U32.18.14 */
+	return (double)(raw & 0xFFFFFFFFull) / (1 << 14) / interval;
+}
+
 static inline int print_float_value(int *printed, char *delim, double value)
 {
 	char *sep = (*printed)++ ? delim : "";
@@ -3006,6 +3018,7 @@ void print_header(char *delim)
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
+		case PMT_TYPE_UQ18_14:
 			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 
@@ -3054,8 +3067,8 @@ void print_header(char *delim)
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
+		case PMT_TYPE_UQ18_14:
 			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
-
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
@@ -3157,6 +3170,7 @@ void print_header(char *delim)
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
+		case PMT_TYPE_UQ18_14:
 			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 
@@ -3560,6 +3574,11 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(pmt_counter_get_width(ppmt), &printed, delim, t->pmt_counter[i]);
 			break;
 
+		case PMT_TYPE_UQ18_14:
+			value_converted = npu_energy_to_watts(value_raw, interval_float);
+			outp += print_float_value(&printed, delim, value_converted);
+			break;
+
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = pct(value_raw / crystal_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
@@ -3626,6 +3645,11 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(pmt_counter_get_width(ppmt), &printed, delim, c->pmt_counter[i]);
 			break;
 
+		case PMT_TYPE_UQ18_14:
+			value_converted = npu_energy_to_watts(value_raw, interval_float);
+			outp += print_float_value(&printed, delim, value_converted);
+			break;
+
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = pct(value_raw / crystal_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
@@ -3782,6 +3806,11 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(pmt_counter_get_width(ppmt), &printed, delim, p->pmt_counter[i]);
 			break;
 
+		case PMT_TYPE_UQ18_14:
+			value_converted = npu_energy_to_watts(value_raw, interval_float);
+			outp += print_float_value(&printed, delim, value_converted);
+			break;
+
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = pct(value_raw / crystal_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
@@ -7817,6 +7846,89 @@ void rapl_probe_amd(void)
 		fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.0f Watts\n", rapl_joule_counter_range, tdp);
 }
 
+struct npu_energy_guid_entry {
+	uint32_t guid;		/* PMT energy GUID - uniquely identifies platform */
+	uint32_t offset;	/* NPU energy register offset */
+	const char *name;	/* platform name for debug output */
+};
+
+static const struct npu_energy_guid_entry npu_energy_guid_table[] = {
+	{ 0x130670b2, 0x628u, "MTL"   },
+	{ 0x1306a0b3, 0x628u, "ARL"   },
+	{ 0x1306a0b2, 0x628u, "ARL_H" },
+	{ 0x1306a0b4, 0x628u, "ARL_S" },
+	{ 0x3086000,  0x670u, "PTL"   },
+	{ 0x308d000,  0x670u, "WCL"   },
+	{ 0x3072005,  0x5d0u, "LNL"   },
+	{ 0x13000001, 0x5e8u, "NVL"   },
+	{ 0, 0, NULL }
+};
+
+static void probe_npu_device(void)
+{
+	DIR *dir, *accel_dir;
+	struct dirent *entry, *accel_entry;
+	char path[PATH_MAX];
+	bool found = false;
+
+	if (access("/sys/class/intel_pmt", F_OK) != 0)
+		return;
+
+	/*
+	 * Assume NPUWatt is not interesting if no driver is loaded.
+	 * Check specifically for intel NPU (intel_vpu) driver.
+	 */
+	dir = opendir(INTEL_NPU_DRIVER_PATH);
+	if (!dir) {
+		if (debug)
+			fprintf(stderr, "%s: Failed to open NPU driver path: %s\n", __func__, INTEL_NPU_DRIVER_PATH);
+		return;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strncmp(entry->d_name, "0000:", strlen("0000:")) != 0)
+			continue;
+
+		snprintf(path, sizeof(path), "%s%s/accel", INTEL_NPU_DRIVER_PATH, entry->d_name);
+
+		accel_dir = opendir(path);
+		if (!accel_dir)
+			continue;
+
+		while ((accel_entry = readdir(accel_dir)) != NULL) {
+			if (accel_entry->d_name[0] == '.')
+				continue;
+
+			/* Check Linux path first */
+			snprintf(path, sizeof(path), "/dev/accel/%s", accel_entry->d_name);
+
+			if (access(path, F_OK) != 0) {
+				/* Try Android path */
+				snprintf(path, sizeof(path), "/dev/%s",	accel_entry->d_name);
+			}
+
+			if (access(path, F_OK) == 0) {
+				found = true;
+				break;
+			}
+		}
+		closedir(accel_dir);
+
+		if (found)
+			break;
+	}
+
+	closedir(dir);
+
+	if (!found) {
+		if (debug)
+			fprintf(stderr, "%s: No NPU device found\n", __func__);
+		return;
+	}
+
+	BIC_PRESENT(BIC_NPUWatt);
+}
+
 void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
 {
 	fprintf(outf, "cpu%d: %s: %sabled (%0.3f Watts, %f sec, clamp %sabled)\n",
@@ -10495,12 +10607,33 @@ void pmt_init(void)
 {
 	int cpu_num;
 	unsigned long seq, offset, mod_num;
+	const struct npu_energy_guid_entry *entry;
 
 	if (BIC_IS_ENABLED(BIC_Diec6)) {
 		pmt_add_counter(PMT_MTL_DC6_GUID, PMT_MTL_DC6_SEQ, "Die%c6", PMT_TYPE_XTAL_TIME,
 				PMT_COUNTER_MTL_DC6_LSB, PMT_COUNTER_MTL_DC6_MSB, PMT_COUNTER_MTL_DC6_OFFSET, SCOPE_PACKAGE, FORMAT_DELTA, 0, PMT_OPEN_TRY);
 	}
 
+	if (DO_BIC(BIC_NPUWatt)) {
+		/*
+		 * SCOPE_PACKAGE is used here because no multi-package systems have NPUs today.
+		 * If that were to change, SCOPE_SYSTEM would be needed instead.
+		 */
+		for (entry = npu_energy_guid_table; entry->guid != 0; entry++) {
+			if (!pmt_add_counter(entry->guid, 0, "NPUWatt", PMT_TYPE_UQ18_14,
+					     PMT_COUNTER_NPU_LSB, 31, entry->offset, SCOPE_PACKAGE, FORMAT_DELTA, 0, PMT_OPEN_TRY)) {
+				if (debug)
+					fprintf(stderr, "%s: NPU energy counter found (%s)\n", __func__, entry->name);
+				break;
+			}
+		}
+		if (!entry->guid) {
+			BIC_NOT_PRESENT(BIC_NPUWatt);
+			if (debug)
+				fprintf(stderr, "%s: NPU present but no known PMT NPU energy GUID\n", __func__);
+		}
+	}
+
 	if (BIC_IS_ENABLED(BIC_CPU_c1e)) {
 		seq = 0;
 		offset = PMT_COUNTER_CWF_MC1E_OFFSET_BASE;
@@ -10561,6 +10694,7 @@ void turbostat_init()
 	setup_all_buffers(true);
 	set_master_cpu();
 	check_msr_access();
+	probe_npu_device();
 	check_perf_access();
 	process_cpuid();
 	counter_info_init();
-- 
2.34.1

