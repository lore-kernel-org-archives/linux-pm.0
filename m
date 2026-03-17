Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22034A775
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745785; cv=none; b=OY/I8p7udj7CfBXOSZRUgmGBmp70vpcMqY/rzAmPpVL8mdG11GSUlwrL5h2TEIY1zORyffMRMDy2WVzv2cI3FsS5e54apRz4u84i15BbG1Fx/VQWOvXTgAhKz+PPmtlsC8h2iBj0dUbK36K0IF9CdfOmqI8qk1VShKbgR478q30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745785; c=relaxed/simple;
	bh=57r2PUUb7zcKOw509zsayq59a7gl7x2rdxjK+W9uTBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DGXVsD3T4QJdWTYIBpecNHRN5uTQ2jOcVBk/HzcaxJNUmo5sSwtXw9e22fUpM6Nx3u7RLF3dEWwpFyGEu/0L5gT1oucnhDb9r+yNGtykDXbqUX+DLg2OYE+FzEwMUgXsEK8esJMD/nz6ghZGE2I2497Aum0fkGkJOv1V+uhY5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5quMl/y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5quMl/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773745783; x=1805281783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=57r2PUUb7zcKOw509zsayq59a7gl7x2rdxjK+W9uTBE=;
  b=c5quMl/yWY20c3W3geQ0NGmHM7nzv1AxsWQEGyJLZinesdJMNus+sJ/K
   ciXzEMBCIiXI6q1aRBQONRAHMiK5kyu8Gjqe+AlU0+kDAq5QREZAOxQm0
   laZb4J60gl2JhhC0FXN7hdpRLf60KmxUom4ypRFyPswX2dbyuC8YZiuTu
   w6ldGXnXBpW8N5bD9sfHfMahCzzESmVzrHsk8KPSDqd1VyZ0hSrsY1cGO
   PQG3PqPmUx2XATXDFPTLuGhbaclVV3thyDmIVPY4Pxe6LraJTuT/kTjzw
   Kumr6TZ9mmWtpBb9QR7Gp8/xg5wacOAd7ltUwTghNFjaBWeYxeXwYrgDM
   w==;
X-CSE-ConnectionGUID: 9J0sHiSrRDinSf8ZXzmi7A==
X-CSE-MsgGUID: 3eOcy/xbTfOWiLrcYFoV8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78380068"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78380068"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:09:42 -0700
X-CSE-ConnectionGUID: 4u6VRF2eTQ2Hty5tJwH8HA==
X-CSE-MsgGUID: LkEx24JITnWZKSWXu6D08g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222184582"
Received: from baandr0id001.iind.intel.com ([10.49.109.195])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2026 04:09:41 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power/x86: Add SOC slider and platform profile support
Date: Tue, 17 Mar 2026 16:36:15 +0530
Message-Id: <20260317110615.651141-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading and writing SOC slider parameters and
platform profile via sysfs in x86_energy_perf_policy.

New command-line options:
  --soc-slider-balance <value>
  --soc-slider-offset <value>
  --platform-profile <name>

These options allow control of the processor thermal SOC
slider balance and offset through the
processor_thermal_soc_slider module, as well as the
platform profile class interface.

When no update flags are set, the tool now also prints
the current SOC slider and platform profile values
alongside existing MSR output.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../x86_energy_perf_policy.c                  | 132 +++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ac37132207a4..1f330c82d7c1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -92,8 +92,18 @@ unsigned int has_hwp_request_pkg;	/* IA32_HWP_REQUEST_PKG */
 
 unsigned int bdx_highest_ratio;
 
+unsigned char update_soc_slider_balance;
+unsigned char update_soc_slider_offset;
+unsigned char update_platform_profile;
+int soc_slider_balance;
+int soc_slider_offset;
+char platform_profile[64];
+
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
 #define SYSFS_PATH_MAX 255
+#define PATH_SOC_SLIDER_BALANCE "/sys/module/processor_thermal_soc_slider/parameters/slider_balance"
+#define PATH_SOC_SLIDER_OFFSET "/sys/module/processor_thermal_soc_slider/parameters/slider_offset"
+#define PATH_PLATFORM_PROFILE "/sys/class/platform-profile/platform-profile-0/profile"
 
 static int use_android_msr_path;
 
@@ -106,6 +116,7 @@ void usage(void)
 	fprintf(stderr, "scope: --cpu cpu-list [--hwp-use-pkg #] | --pkg pkg-list\n");
 	fprintf(stderr, "field: --all | --epb | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
 	fprintf(stderr, "other: --hwp-enable | --turbo-enable (0 | 1) | --help | --force\n");
+	fprintf(stderr, "soc-slider: --soc-slider-balance # | --soc-slider-offset # | --platform-profile <name>\n");
 	fprintf(stderr,
 		"value: ( # | \"normal\" | \"performance\" | \"balance-performance\" | \"balance-power\"| \"power\")\n");
 	fprintf(stderr, "--hwp-window usec\n");
@@ -518,6 +529,23 @@ void for_packages(unsigned long long pkg_set, int (func)(int))
 	}
 }
 
+static int parse_cmdline_int(const char *s, int *out)
+{
+	char *endp;
+	long val;
+
+	val = strtol(s, &endp, 0);
+	if (endp == s || errno == ERANGE)
+		return -1;
+	if (*endp != '\0')
+		return -1;
+	if (val < INT_MIN || val > INT_MAX)
+		return -1;
+
+	*out = (int)val;
+	return 0;
+}
+
 void print_version(void)
 {
 	printf("x86_energy_perf_policy 2025.11.22 Len Brown <lenb@kernel.org>\n");
@@ -546,12 +574,15 @@ void cmdline(int argc, char **argv)
 		{"hwp-use-pkg",	required_argument,	0, 'u'},
 		{"version",	no_argument,		0, 'v'},
 		{"hwp-window",	required_argument,	0, 'w'},
+		{"soc-slider-balance", required_argument, 0, 'S'},
+		{"soc-slider-offset",  required_argument, 0, 'O'},
+		{"platform-profile",   required_argument, 0, 'F'},
 		{0,		0,			0, 0 }
 	};
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw:",
+	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw::S:O:F:",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -579,12 +610,23 @@ void cmdline(int argc, char **argv)
 		case 'D':
 			req_update.hwp_desired = parse_cmdline_hwp_desired(parse_optarg_string(optarg));
 			break;
+		case 'F':
+			if (strlen(optarg) >= sizeof(platform_profile))
+				errx(1, "--platform-profile: value too long");
+			strcpy(platform_profile, optarg);
+			update_platform_profile = 1;
+			break;
 		case 'm':
 			req_update.hwp_min = parse_cmdline_hwp_min(parse_optarg_string(optarg));
 			break;
 		case 'M':
 			req_update.hwp_max = parse_cmdline_hwp_max(parse_optarg_string(optarg));
 			break;
+		case 'O':
+			if (parse_cmdline_int(optarg, &soc_slider_offset))
+				errx(1, "--soc-slider-offset: invalid value");
+			update_soc_slider_offset = 1;
+			break;
 		case 'p':
 			parse_cmdline_pkg(optarg);
 			break;
@@ -594,6 +636,11 @@ void cmdline(int argc, char **argv)
 		case 'r':
 			/* v1 used -r to specify read-only mode, now the default */
 			break;
+		case 'S':
+			if (parse_cmdline_int(optarg, &soc_slider_balance))
+				errx(1, "--soc-slider-balance: invalid value");
+			update_soc_slider_balance = 1;
+			break;
 		case 't':
 			turbo_update_value = parse_cmdline_turbo(parse_optarg_string(optarg));
 			break;
@@ -777,6 +824,31 @@ static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
 	return (unsigned int) numwritten;
 }
 
+static int sysfs_read_string(const char *path, char *buf, size_t buflen)
+{
+	unsigned int len;
+	size_t n;
+
+	len = read_sysfs(path, buf, buflen);
+	if (!len)
+		return -1;
+
+	n = strcspn(buf, "\n");
+	buf[n] = '\0';
+	return 0;
+}
+
+static int sysfs_write_string(const char *path, const char *buf)
+{
+	char tmp[128];
+	int len;
+
+	len = snprintf(tmp, sizeof(tmp), "%s\n", buf);
+	if (len < 0 || len >= (int)sizeof(tmp))
+		return -1;
+	return write_sysfs(path, tmp, (size_t)len + 1) ? 0 : -1;
+}
+
 void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
 {
 	if (cpu != -1)
@@ -900,6 +972,55 @@ static int set_epb_sysfs(int cpu, int val)
 	return (int)val;
 }
 
+static int soc_slider_available(void)
+{
+	if (access(PATH_SOC_SLIDER_BALANCE, R_OK) &&
+			access(PATH_SOC_SLIDER_OFFSET, R_OK) &&
+			access(PATH_PLATFORM_PROFILE, R_OK))
+		return 0;
+
+	return 1;
+}
+
+static void print_soc_slider(void)
+{
+	char buf[64];
+
+	if (!soc_slider_available())
+		return;
+
+	if (sysfs_read_string(PATH_SOC_SLIDER_BALANCE, buf, sizeof(buf)) == 0)
+		printf("soc-slider-balance: %s\n", buf);
+	if (sysfs_read_string(PATH_SOC_SLIDER_OFFSET, buf, sizeof(buf)) == 0)
+		printf("soc-slider-offset: %s\n", buf);
+	if (sysfs_read_string(PATH_PLATFORM_PROFILE, buf, sizeof(buf)) == 0)
+		printf("platform-profile: %s\n", buf);
+}
+
+static int update_soc_slider(void)
+{
+	char tmp[32];
+
+	if (update_soc_slider_balance) {
+		snprintf(tmp, sizeof(tmp), "%d", soc_slider_balance);
+		if (sysfs_write_string(PATH_SOC_SLIDER_BALANCE, tmp))
+			err(1, "soc-slider-balance write failed");
+	}
+
+	if (update_soc_slider_offset) {
+		snprintf(tmp, sizeof(tmp), "%d", soc_slider_offset);
+		if (sysfs_write_string(PATH_SOC_SLIDER_OFFSET, tmp))
+			err(1, "soc-slider-offset write failed");
+	}
+
+	if (update_platform_profile) {
+		if (sysfs_write_string(PATH_PLATFORM_PROFILE, platform_profile))
+			err(1, "platform-profile write failed");
+	}
+
+	return 0;
+}
+
 int print_cpu_msrs(int cpu)
 {
 	struct msr_hwp_request req;
@@ -1604,10 +1725,14 @@ int main(int argc, char **argv)
 		return -EINVAL;
 
 	/* display information only, no updates to settings */
-	if (!update_epb && !update_turbo && !hwp_update_enabled()) {
+	if (!update_epb && !update_turbo && !hwp_update_enabled() &&
+	    !update_soc_slider_balance && !update_soc_slider_offset &&
+	    !update_platform_profile) {
 		if (cpu_selected_set)
 			for_all_cpus_in_set(cpu_setsize, cpu_selected_set, print_cpu_msrs);
 
+		print_soc_slider();
+
 		if (has_hwp_request_pkg) {
 			if (pkg_selected_set == 0)
 				pkg_selected_set = pkg_present_set;
@@ -1628,5 +1753,8 @@ int main(int argc, char **argv)
 	} else if (pkg_selected_set)
 		for_packages(pkg_selected_set, update_hwp_request_pkg_msr);
 
+	if (update_soc_slider_balance || update_soc_slider_offset || update_platform_profile)
+		update_soc_slider();
+
 	return 0;
 }
-- 
2.34.1

