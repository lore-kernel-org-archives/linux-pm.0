Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE03803FC;
	Sat, 25 Apr 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142883; cv=none; b=fWON31UlZAPNOk4mppZAaOCDPSn+a9bJfkW2T2bYyuYPdmpB3zcE1Fi0xE2jiVhux5gFv3r+ja9jvRsv3iVjm2bBC+O1YAFn7D6QagvblnbRR92RFEXY4IUWENg7IO5kZAJYy/H2HYAni0OmBIqK4jalLPjzLA0gD1t/N35y80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142883; c=relaxed/simple;
	bh=9bL5zyv7jBjNc38JojXS3aKns5Y2p3KKbcMIbG4Pcqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnThvg1BpV1IjBuyV5MtgBJwmes7OfJi38G1BRWl9/6baKpcpFzwnDMTF1DuBR1SXe9pGcouVnigF95a3fzDMbPfl0fNHCODL+yhbIbNtaaOijfvdWWX+tzAX5Fu7nsEi0KMTtphQuR8GwPVZ+DJWogIQkDLcBliW8GtpU0ETOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUvJEmnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUvJEmnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC80C2BCB3;
	Sat, 25 Apr 2026 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142880;
	bh=9bL5zyv7jBjNc38JojXS3aKns5Y2p3KKbcMIbG4Pcqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=aUvJEmnEE8NeYHUSljKcMJjB5GEKPtjCeNLqAiREm1xeGdOo8rOfSCvpX8BuY08r8
	 QFbokHmZ7Z/s4A0ySQ1NKgl9RWQBALaBFWAC2/pY9IMqySMMZIlekSLSOkexZ5FWXa
	 fGWkgjRn0JA5BinXsZAIuDLxNosaiV2+UYTlvVMGrBgYLtCrDW5fYhlFw6Fga/DN0X
	 Vlqz0SLKg06PfCfsonMXYORuS1d252CyhECW90Do0dfCUCbvljDKaTn20Mm5hDPyJO
	 78zRJ09q26+sO9+0AWGAE5N+5UxA9trxC+u5kNEyFM3gEr9rn1qca6kLFZ1VNaf9hN
	 x2AfNsE4RnyDQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] tools/power x86_energy_perf_policy: Version 2026.04.25
Date: Sat, 25 Apr 2026 14:42:16 -0400
Message-ID: <f1c35c73191b7d23ed4bbc660a7b9ed5b32614e0.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Since v2025.11.22:
	Initial SoC Slider support
	SoC Slider is an SoC-wide power/performance policy setting.
	On SoC Slider systems, EPP plays a diminished role.

Whitespace cleanup via: indent -npro -kr -i8 -ts8 -sob -l160 -ss -ncs -cp1

No functional changes

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 161 +++++++-----------
 1 file changed, 66 insertions(+), 95 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 83e5adbcda69..0dc959e30076 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -4,7 +4,7 @@
  * policy preference bias on recent X86 processors.
  */
 /*
- * Copyright (c) 2010 - 2025 Intel Corporation.
+ * Copyright (c) 2010 - 2026 Intel Corporation.
  * Len Brown <len.brown@intel.com>
  */
 
@@ -82,10 +82,10 @@ size_t cpu_setsize;
 
 char *proc_stat = "/proc/stat";
 
-unsigned int has_epb;	/* MSR_IA32_ENERGY_PERF_BIAS */
-unsigned int has_hwp;	/* IA32_PM_ENABLE, IA32_HWP_CAPABILITIES */
+unsigned int has_epb;		/* MSR_IA32_ENERGY_PERF_BIAS */
+unsigned int has_hwp;		/* IA32_PM_ENABLE, IA32_HWP_CAPABILITIES */
 			/* IA32_HWP_REQUEST, IA32_HWP_STATUS */
-unsigned int has_hwp_notify;		/* IA32_HWP_INTERRUPT */
+unsigned int has_hwp_notify;	/* IA32_HWP_INTERRUPT */
 unsigned int has_hwp_activity_window;	/* IA32_HWP_REQUEST[bits 41:32] */
 unsigned int has_hwp_epp;	/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_request_pkg;	/* IA32_HWP_REQUEST_PKG */
@@ -122,8 +122,7 @@ void usage(void)
 	fprintf(stderr, "field: --all | --epb | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
 	fprintf(stderr, "other: --hwp-enable | --turbo-enable (0 | 1) | --help | --force\n");
 	fprintf(stderr, "soc-slider: --soc-slider-balance # | --soc-slider-offset # | --platform-profile <name>\n");
-	fprintf(stderr,
-		"value: ( # | \"normal\" | \"performance\" | \"balance-performance\" | \"balance-power\"| \"power\")\n");
+	fprintf(stderr, "value: ( # | \"normal\" | \"performance\" | \"balance-performance\" | \"balance-power\"| \"power\")\n");
 	fprintf(stderr, "--hwp-window usec\n");
 
 	fprintf(stderr, "Specify only Energy Performance BIAS (legacy usage):\n");
@@ -151,6 +150,7 @@ int ratio_2_msr_perf(int ratio)
 
 	return msr_perf;
 }
+
 int msr_perf_2_ratio(int msr_perf)
 {
 	int ratio;
@@ -159,8 +159,8 @@ int msr_perf_2_ratio(int msr_perf)
 	if (!bdx_highest_ratio)
 		return msr_perf;
 
-	d = (double)msr_perf * (double) bdx_highest_ratio / 255.0;
-	d = d + 0.5;	/* round */
+	d = (double)msr_perf * (double)bdx_highest_ratio / 255.0;
+	d = d + 0.5;		/* round */
 	ratio = (int)d;
 
 	if (debug)
@@ -168,6 +168,7 @@ int msr_perf_2_ratio(int msr_perf)
 
 	return ratio;
 }
+
 int parse_cmdline_epb(int i)
 {
 	if (!has_epb)
@@ -214,6 +215,7 @@ int parse_cmdline_hwp_min(int i)
 	}
 	return i;
 }
+
 /*
  * "power" changes hwp_max to cap.lowest
  * All others leave it at cap.highest
@@ -233,6 +235,7 @@ int parse_cmdline_hwp_max(int i)
 	}
 	return i;
 }
+
 /*
  * for --hwp-des, all strings leave it in autonomous mode
  * If you want to change it, you need to explicitly pick a value
@@ -270,7 +273,7 @@ int parse_cmdline_hwp_window(int i)
 		fprintf(stderr, "--hwp-window: 0 for auto; 1 - 1270000000 usec for window duration\n");
 		usage();
 	}
-	for (exponent = 0; ; ++exponent) {
+	for (exponent = 0;; ++exponent) {
 		if (debug)
 			printf("%d 10^%d\n", i, exponent);
 
@@ -284,6 +287,7 @@ int parse_cmdline_hwp_window(int i)
 
 	return (exponent << 7) | i;
 }
+
 int parse_cmdline_hwp_epp(int i)
 {
 	update_hwp_epp = 1;
@@ -305,6 +309,7 @@ int parse_cmdline_hwp_epp(int i)
 	}
 	return i;
 }
+
 int parse_cmdline_turbo(int i)
 {
 	update_turbo = 1;
@@ -524,7 +529,7 @@ void parse_cmdline_pkg(char *s)
 	}
 }
 
-void for_packages(unsigned long long pkg_set, int (func)(int))
+void for_packages(unsigned long long pkg_set, int (func) (int))
 {
 	int pkg_num;
 
@@ -553,7 +558,7 @@ static int parse_cmdline_int(const char *s, int *out)
 
 void print_version(void)
 {
-	printf("x86_energy_perf_policy 2025.11.22 Len Brown <lenb@kernel.org>\n");
+	printf("x86_energy_perf_policy 2026.04.25 Len Brown <lenb@kernel.org>\n");
 }
 
 static int platform_profile_access(int mode)
@@ -791,8 +796,7 @@ void err_on_hypervisor(void)
 	free(buffer);
 
 	if (hypervisor)
-		err(-1,
-		    "not supported on this virtual machine");
+		err(-1, "not supported on this virtual machine");
 }
 
 int get_msr(int cpu, int offset, unsigned long long *msr)
@@ -804,9 +808,7 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
 	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r %s, or run as root",
-		   pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
-
+		err(-1, "%s open failed, try chown or chmod +r %s, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
 
 	retval = pread(fd, msr, sizeof(*msr), offset);
 	if (retval != sizeof(*msr)) {
@@ -830,8 +832,7 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDWR);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r %s, or run as root",
-		   pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
+		err(-1, "%s open failed, try chown or chmod +r %s, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
 
 	retval = pwrite(fd, &new_msr, sizeof(new_msr), offset);
 	if (retval != sizeof(new_msr))
@@ -863,7 +864,7 @@ static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
 	buf[numread] = '\0';
 	close(fd);
 
-	return (unsigned int) numread;
+	return (unsigned int)numread;
 }
 
 static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
@@ -885,7 +886,7 @@ static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
 
 	close(fd);
 
-	return (unsigned int) numwritten;
+	return (unsigned int)numwritten;
 }
 
 static int sysfs_read_string(const char *path, char *buf, size_t buflen)
@@ -918,9 +919,9 @@ void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
 	if (cpu != -1)
 		printf("cpu%d: ", cpu);
 
-	printf("HWP_CAP: low %d eff %d guar %d high %d\n",
-		cap->lowest, cap->efficient, cap->guaranteed, cap->highest);
+	printf("HWP_CAP: low %d eff %d guar %d high %d\n", cap->lowest, cap->efficient, cap->guaranteed, cap->highest);
 }
+
 void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
 {
 	unsigned long long msr;
@@ -942,9 +943,9 @@ void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
 		printf("%s", str);
 
 	printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
-		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
-		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
+	       h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp, h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
 }
+
 void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 {
 	printf("pkg%d: ", pkg);
@@ -953,9 +954,9 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 		printf("%s", str);
 
 	printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
-		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
-		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	       h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp, h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
 }
+
 void read_hwp_request_msr(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
 {
 	unsigned long long msr;
@@ -976,9 +977,7 @@ void write_hwp_request_msr(int cpu, struct msr_hwp_request *hwp_req, unsigned in
 
 	if (debug > 1)
 		printf("cpu%d: requesting min %d max %d des %d epp %d window 0x%0x use_pkg %d\n",
-			cpu, hwp_req->hwp_min, hwp_req->hwp_max,
-			hwp_req->hwp_desired, hwp_req->hwp_epp,
-			hwp_req->hwp_window, hwp_req->hwp_use_pkg);
+		       cpu, hwp_req->hwp_min, hwp_req->hwp_max, hwp_req->hwp_desired, hwp_req->hwp_epp, hwp_req->hwp_window, hwp_req->hwp_use_pkg);
 
 	msr |= HWP_MIN_PERF(ratio_2_msr_perf(hwp_req->hwp_min));
 	msr |= HWP_MAX_PERF(ratio_2_msr_perf(hwp_req->hwp_max));
@@ -1096,7 +1095,7 @@ int print_cpu_msrs(int cpu)
 
 	epb = get_epb_sysfs(cpu);
 	if (epb >= 0)
-		printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
+		printf("cpu%d: EPB %u\n", cpu, (unsigned int)epb);
 
 	if (!has_hwp)
 		return 0;
@@ -1124,17 +1123,13 @@ int print_pkg_msrs(int pkg)
 	if (has_hwp_notify) {
 		get_msr(first_cpu_in_pkg[pkg], MSR_HWP_INTERRUPT, &msr);
 		fprintf(stderr,
-		"pkg%d: MSR_HWP_INTERRUPT: 0x%08llx (Excursion_Min-%sabled, Guaranteed_Perf_Change-%sabled)\n",
-		pkg, msr,
-		((msr) & 0x2) ? "EN" : "Dis",
-		((msr) & 0x1) ? "EN" : "Dis");
+			"pkg%d: MSR_HWP_INTERRUPT: 0x%08llx (Excursion_Min-%sabled, Guaranteed_Perf_Change-%sabled)\n",
+			pkg, msr, ((msr) & 0x2) ? "EN" : "Dis", ((msr) & 0x1) ? "EN" : "Dis");
 	}
 	get_msr(first_cpu_in_pkg[pkg], MSR_HWP_STATUS, &msr);
 	fprintf(stderr,
 		"pkg%d: MSR_HWP_STATUS: 0x%08llx (%sExcursion_Min, %sGuaranteed_Perf_Change)\n",
-		pkg, msr,
-		((msr) & 0x4) ? "" : "No-",
-		((msr) & 0x1) ? "" : "No-");
+		pkg, msr, ((msr) & 0x4) ? "" : "No-", ((msr) & 0x1) ? "" : "No-");
 
 	return 0;
 }
@@ -1148,6 +1143,7 @@ int ratio_2_sysfs_khz(int ratio)
 
 	return ratio * bclk_khz;
 }
+
 /*
  * If HWP is enabled and cpufreq sysfs attribtes are present,
  * then update via sysfs. The intel_pstate driver may modify (clip)
@@ -1164,8 +1160,7 @@ void update_cpufreq_scaling_freq(int is_max, int cpu, unsigned int ratio)
 	int retval;
 	int khz;
 
-	sprintf(pathname, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_%s_freq",
-		cpu, is_max ? "max" : "min");
+	sprintf(pathname, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_%s_freq", cpu, is_max ? "max" : "min");
 
 	fp = fopen(pathname, "w");
 	if (!fp) {
@@ -1217,19 +1212,16 @@ int verify_hwp_req_self_consistency(int cpu, struct msr_hwp_request *req)
 {
 	/* fail if min > max requested */
 	if (req->hwp_min > req->hwp_max) {
-		errx(1, "cpu%d: requested hwp-min %d > hwp_max %d",
-			cpu, req->hwp_min, req->hwp_max);
+		errx(1, "cpu%d: requested hwp-min %d > hwp_max %d", cpu, req->hwp_min, req->hwp_max);
 	}
 
 	/* fail if desired > max requestd */
 	if (req->hwp_desired && (req->hwp_desired > req->hwp_max)) {
-		errx(1, "cpu%d: requested hwp-desired %d > hwp_max %d",
-			cpu, req->hwp_desired, req->hwp_max);
+		errx(1, "cpu%d: requested hwp-desired %d > hwp_max %d", cpu, req->hwp_desired, req->hwp_max);
 	}
 	/* fail if desired < min requestd */
 	if (req->hwp_desired && (req->hwp_desired < req->hwp_min)) {
-		errx(1, "cpu%d: requested hwp-desired %d < requested hwp_min %d",
-			cpu, req->hwp_desired, req->hwp_min);
+		errx(1, "cpu%d: requested hwp-desired %d < requested hwp_min %d", cpu, req->hwp_desired, req->hwp_min);
 	}
 
 	return 0;
@@ -1239,39 +1231,30 @@ int check_hwp_request_v_hwp_capabilities(int cpu, struct msr_hwp_request *req, s
 {
 	if (update_hwp_max) {
 		if (req->hwp_max > cap->highest)
-			errx(1, "cpu%d: requested max %d > capabilities highest %d, use --force?",
-				cpu, req->hwp_max, cap->highest);
+			errx(1, "cpu%d: requested max %d > capabilities highest %d, use --force?", cpu, req->hwp_max, cap->highest);
 		if (req->hwp_max < cap->lowest)
-			errx(1, "cpu%d: requested max %d < capabilities lowest %d, use --force?",
-				cpu, req->hwp_max, cap->lowest);
+			errx(1, "cpu%d: requested max %d < capabilities lowest %d, use --force?", cpu, req->hwp_max, cap->lowest);
 	}
 
 	if (update_hwp_min) {
 		if (req->hwp_min > cap->highest)
-			errx(1, "cpu%d: requested min %d > capabilities highest %d, use --force?",
-				cpu, req->hwp_min, cap->highest);
+			errx(1, "cpu%d: requested min %d > capabilities highest %d, use --force?", cpu, req->hwp_min, cap->highest);
 		if (req->hwp_min < cap->lowest)
-			errx(1, "cpu%d: requested min %d < capabilities lowest %d, use --force?",
-				cpu, req->hwp_min, cap->lowest);
+			errx(1, "cpu%d: requested min %d < capabilities lowest %d, use --force?", cpu, req->hwp_min, cap->lowest);
 	}
 
 	if (update_hwp_min && update_hwp_max && (req->hwp_min > req->hwp_max))
-		errx(1, "cpu%d: requested min %d > requested max %d",
-			cpu, req->hwp_min, req->hwp_max);
+		errx(1, "cpu%d: requested min %d > requested max %d", cpu, req->hwp_min, req->hwp_max);
 
 	if (update_hwp_desired && req->hwp_desired) {
 		if (req->hwp_desired > req->hwp_max)
-			errx(1, "cpu%d: requested desired %d > requested max %d, use --force?",
-				cpu, req->hwp_desired, req->hwp_max);
+			errx(1, "cpu%d: requested desired %d > requested max %d, use --force?", cpu, req->hwp_desired, req->hwp_max);
 		if (req->hwp_desired < req->hwp_min)
-			errx(1, "cpu%d: requested desired %d < requested min %d, use --force?",
-				cpu, req->hwp_desired, req->hwp_min);
+			errx(1, "cpu%d: requested desired %d < requested min %d, use --force?", cpu, req->hwp_desired, req->hwp_min);
 		if (req->hwp_desired < cap->lowest)
-			errx(1, "cpu%d: requested desired %d < capabilities lowest %d, use --force?",
-				cpu, req->hwp_desired, cap->lowest);
+			errx(1, "cpu%d: requested desired %d < capabilities lowest %d, use --force?", cpu, req->hwp_desired, cap->lowest);
 		if (req->hwp_desired > cap->highest)
-			errx(1, "cpu%d: requested desired %d > capabilities highest %d, use --force?",
-				cpu, req->hwp_desired, cap->highest);
+			errx(1, "cpu%d: requested desired %d > capabilities highest %d, use --force?", cpu, req->hwp_desired, cap->highest);
 	}
 
 	return 0;
@@ -1322,6 +1305,7 @@ int update_hwp_request_msr(int cpu)
 	}
 	return 0;
 }
+
 int update_hwp_request_pkg_msr(int pkg)
 {
 	struct msr_hwp_request req;
@@ -1393,8 +1377,7 @@ int update_cpu_epb_sysfs(int cpu)
 	set_epb_sysfs(cpu, new_epb);
 
 	if (verbose)
-		printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n",
-			cpu, epb, (unsigned int) new_epb);
+		printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n", cpu, epb, (unsigned int)new_epb);
 
 	return 0;
 }
@@ -1410,7 +1393,7 @@ int update_cpu_msrs(int cpu)
 
 		turbo_is_present_and_disabled = ((msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE) != 0);
 
-		if (turbo_update_value == 1)	{
+		if (turbo_update_value == 1) {
 			if (turbo_is_present_and_disabled) {
 				msr &= ~MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 				put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
@@ -1479,6 +1462,7 @@ int set_max_cpu_pkg_num(int cpu)
 
 	return 0;
 }
+
 int mark_cpu_present(int cpu)
 {
 	CPU_SET_S(cpu, cpu_setsize, cpu_present_set);
@@ -1489,7 +1473,7 @@ int mark_cpu_present(int cpu)
  * run func(cpu) on every cpu in /proc/stat
  * return max_cpu number
  */
-int for_all_proc_cpus(int (func)(int))
+int for_all_proc_cpus(int (func) (int))
 {
 	FILE *fp;
 	int cpu_num;
@@ -1516,7 +1500,7 @@ int for_all_proc_cpus(int (func)(int))
 	return 0;
 }
 
-void for_all_cpus_in_set(size_t set_size, cpu_set_t *cpu_set, int (func)(int))
+void for_all_cpus_in_set(size_t set_size, cpu_set_t *cpu_set, int (func) (int))
 {
 	int cpu_num;
 
@@ -1524,7 +1508,8 @@ void for_all_cpus_in_set(size_t set_size, cpu_set_t *cpu_set, int (func)(int))
 		if (CPU_ISSET_S(cpu_num, set_size, cpu_set))
 			func(cpu_num);
 }
-int for_all_cpus_in_set_and(size_t set_size, cpu_set_t *cpu_set, int (func)(int))
+
+int for_all_cpus_in_set_and(size_t set_size, cpu_set_t *cpu_set, int (func) (int))
 {
 	int cpu_num;
 	int retval = 1;
@@ -1573,7 +1558,7 @@ void verify_hwp_is_enabled(void)
 {
 	int retval;
 
-	if (!has_hwp)	/* set in early_cpuid() */
+	if (!has_hwp)		/* set in early_cpuid() */
 		return;
 
 	retval = for_all_cpus_in_set_and(cpu_setsize, cpu_selected_set, is_hwp_enabled_on_cpu);
@@ -1590,21 +1575,18 @@ int req_update_bounds_check(void)
 		return 0;
 
 	/* fail if min > max requested */
-	if ((update_hwp_max && update_hwp_min) &&
-	    (req_update.hwp_min > req_update.hwp_max)) {
+	if ((update_hwp_max && update_hwp_min) && (req_update.hwp_min > req_update.hwp_max)) {
 		printf("hwp-min %d > hwp_max %d\n", req_update.hwp_min, req_update.hwp_max);
 		return -EINVAL;
 	}
 
 	/* fail if desired > max requestd */
-	if (req_update.hwp_desired && update_hwp_max &&
-	    (req_update.hwp_desired > req_update.hwp_max)) {
+	if (req_update.hwp_desired && update_hwp_max && (req_update.hwp_desired > req_update.hwp_max)) {
 		printf("hwp-desired cannot be greater than hwp_max\n");
 		return -EINVAL;
 	}
 	/* fail if desired < min requestd */
-	if (req_update.hwp_desired && update_hwp_min &&
-	    (req_update.hwp_desired < req_update.hwp_min)) {
+	if (req_update.hwp_desired && update_hwp_min && (req_update.hwp_desired < req_update.hwp_min)) {
 		printf("hwp-desired cannot be less than hwp_min\n");
 		return -EINVAL;
 	}
@@ -1647,9 +1629,7 @@ void probe_dev_msr(void)
 	}
 }
 
-static void get_cpuid_or_exit(unsigned int leaf,
-			     unsigned int *eax, unsigned int *ebx,
-			     unsigned int *ecx, unsigned int *edx)
+static void get_cpuid_or_exit(unsigned int leaf, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
 {
 	if (!__get_cpuid(leaf, eax, ebx, ecx, edx))
 		errx(1, "Processor not supported\n");
@@ -1703,8 +1683,7 @@ void parse_cpuid(void)
 		genuine_intel = 1;
 
 	if (debug)
-		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ",
-			(char *)&ebx, (char *)&edx, (char *)&ecx);
+		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ", (char *)&ebx, (char *)&edx, (char *)&ecx);
 
 	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
 	family = (fms >> 8) & 0xf;
@@ -1714,23 +1693,18 @@ void parse_cpuid(void)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (debug) {
-		fprintf(stderr, "%d CPUID levels; family:model:stepping 0x%x:%x:%x (%d:%d:%d)\n",
-			max_level, family, model, stepping, family, model, stepping);
+		fprintf(stderr, "%d CPUID levels; family:model:stepping 0x%x:%x:%x (%d:%d:%d)\n", max_level, family, model, stepping, family, model, stepping);
 		fprintf(stderr, "CPUID(1): %s %s %s %s %s %s %s %s\n",
 			ecx & (1 << 0) ? "SSE3" : "-",
 			ecx & (1 << 3) ? "MONITOR" : "-",
 			ecx & (1 << 7) ? "EIST" : "-",
 			ecx & (1 << 8) ? "TM2" : "-",
-			edx & (1 << 4) ? "TSC" : "-",
-			edx & (1 << 5) ? "MSR" : "-",
-			edx & (1 << 22) ? "ACPI-TM" : "-",
-			edx & (1 << 29) ? "TM" : "-");
+			edx & (1 << 4) ? "TSC" : "-", edx & (1 << 5) ? "MSR" : "-", edx & (1 << 22) ? "ACPI-TM" : "-", edx & (1 << 29) ? "TM" : "-");
 	}
 
 	if (!(edx & (1 << 5)))
 		errx(1, "CPUID: no MSR");
 
-
 	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
 	/* turbo_is_enabled already set */
 	/* has_hwp already set */
@@ -1750,12 +1724,9 @@ void parse_cpuid(void)
 			turbo_is_enabled ? "" : "No-",
 			has_hwp ? "" : "No-",
 			has_hwp_notify ? "" : "No-",
-			has_hwp_activity_window ? "" : "No-",
-			has_hwp_epp ? "" : "No-",
-			has_hwp_request_pkg ? "" : "No-",
-			has_epb ? "" : "No-");
+			has_hwp_activity_window ? "" : "No-", has_hwp_epp ? "" : "No-", has_hwp_request_pkg ? "" : "No-", has_epb ? "" : "No-");
 
-	return;	/* success */
+	return;			/* success */
 }
 
 int main(int argc, char **argv)
@@ -1765,7 +1736,7 @@ int main(int argc, char **argv)
 	probe_dev_msr();
 	init_data_structures();
 
-	early_cpuid();	/* initial cpuid parse before cmdline */
+	early_cpuid();		/* initial cpuid parse before cmdline */
 
 	cmdline(argc, argv);
 
@@ -1774,7 +1745,7 @@ int main(int argc, char **argv)
 
 	parse_cpuid();
 
-	 /* If CPU-set and PKG-set are not initialized, default to all CPUs */
+	/* If CPU-set and PKG-set are not initialized, default to all CPUs */
 	if ((cpu_selected_set == 0) && (pkg_selected_set == 0))
 		cpu_selected_set = cpu_present_set;
 
-- 
2.45.2

