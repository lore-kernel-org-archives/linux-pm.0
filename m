Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1D397E9A;
	Sat, 25 Apr 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142879; cv=none; b=HvaNdCRBZiY0MSisq1ssvLlSrPiLcH9kYLSAcDEu9DsvSRxdI1H7XcQcSxRG0AZyRmp3kH4JIRlY0aGCwP9shBEtZvuO0l3n0t0lg9EYsYRlXiifZGYFreSh938TIXm5tDVm/3jqxLORm/4tVlMlxhEQk8pby6vqg/7QQDtvY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142879; c=relaxed/simple;
	bh=LtULRmq97VklinAInnjiZmeXbxNuHWLIgGQ6ZuP53RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU+ixoaNt9/khbWjVdD4gDfSRyPeKUfGDn/FsOXOFLjmDNq+Vi/izChz58GbQ4mbcpMjKMJCZrhOv1FYGdUpl4JGFTNepoda0AQQjr1v1AdC0TuP0MQmtkY7ALPhmmO4QPxZq3aXUmwcGp4Nlxi0wZjN41jGKlTa7t4vq5rIYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0zpFCbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0zpFCbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6FDC2BCB0;
	Sat, 25 Apr 2026 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142878;
	bh=LtULRmq97VklinAInnjiZmeXbxNuHWLIgGQ6ZuP53RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=P0zpFCbEkKH1XGUhQ9HhtXnmn7XWCle6MAHHhLIs0tO1GOloLTjELgmKf6Rq+B70X
	 qitHfHUkGsmwRDV9ytOO6QvLxMV8N9YBiMdJB6H2Sxm9rR0Jc35760zCvQEFUNJpdv
	 tyXBCQ1rK/xxIK+LYpKD/Gae4N7tic/FQFcUoND8CC1wzE9RRTgYsw7bgEh6SMiswS
	 kgBnRL4clLWv1d0zJ2iXIPP4urE+QPR86Ly6ytFMgD2kWP8xhpnGY9c6esXztw/NfH
	 hOrWftZlWb9v17lqUatmTjYPfr1CZZXJEkVhXzTQMmE7f7VnHfvFM7wZbchRTnhK8C
	 CrHbx9flTXzMw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] tools/power x86_energy_perf_policy: Enhances SoC Slider related checks
Date: Sat, 25 Apr 2026 14:42:14 -0400
Message-ID: <25ff5848c05bc660739089cf9c6de4a166bd7932.1777141988.git.len.brown@intel.com>
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

When processor_thermal_soc_slider is loaded, its slider
and offset modparams are visible.  Check that the driver
actually registered the profile named "SoC Slider" before
reading or writing these modparams.

n.b. This utility allows writing the Slider and Offset modparams
even if the driver policy is not "balanced".  Currently the
processor_thermal_soc_slider consults those modparams
only in "balanced" mode.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 142 +++++++++++++-----
 1 file changed, 104 insertions(+), 38 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 1f330c82d7c1..83e5adbcda69 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -104,9 +104,14 @@ char platform_profile[64];
 #define PATH_SOC_SLIDER_BALANCE "/sys/module/processor_thermal_soc_slider/parameters/slider_balance"
 #define PATH_SOC_SLIDER_OFFSET "/sys/module/processor_thermal_soc_slider/parameters/slider_offset"
 #define PATH_PLATFORM_PROFILE "/sys/class/platform-profile/platform-profile-0/profile"
+#define PATH_PLATFORM_PROFILE_NAME "/sys/class/platform-profile/platform-profile-0/name"
+#define POWER_SLIDER_NAME "SoC Power Slider"
 
 static int use_android_msr_path;
 
+static unsigned int read_sysfs(const char *, char *, size_t);
+static int sysfs_read_string(const char *, char *, size_t);
+
 /*
  * maintain compatibility with original implementation, but don't document it:
  */
@@ -551,39 +556,91 @@ void print_version(void)
 	printf("x86_energy_perf_policy 2025.11.22 Len Brown <lenb@kernel.org>\n");
 }
 
+static int platform_profile_access(int mode)
+{
+	if (access(PATH_PLATFORM_PROFILE, mode)) {
+		if (debug)
+			fprintf(stderr, "Can not access %s\n", PATH_PLATFORM_PROFILE);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int platform_profile_name_is(char *name)
+{
+	char buf[64];
+
+	if (sysfs_read_string(PATH_PLATFORM_PROFILE_NAME, buf, sizeof(buf)) != 0) {
+		if (debug)
+			fprintf(stderr, "Can not read %s\n", PATH_PLATFORM_PROFILE_NAME);
+		return 0;
+	}
+
+	if (strncmp(buf, name, 16)) {
+		if (debug)
+			fprintf(stderr, "%s does not match '%s'\n", PATH_PLATFORM_PROFILE_NAME, name);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int soc_slider_access(int mode)
+{
+	if (!platform_profile_access(R_OK))
+		return 0;
+
+	if (!platform_profile_name_is(POWER_SLIDER_NAME))
+		return 0;
+
+	if (access(PATH_SOC_SLIDER_BALANCE, mode)) {
+		if (debug)
+			fprintf(stderr, "Can not access %s\n", PATH_SOC_SLIDER_BALANCE);
+		return 0;
+	}
+
+	if (access(PATH_SOC_SLIDER_OFFSET, mode)) {
+		if (debug)
+			fprintf(stderr, "Can not access %s\n", PATH_SOC_SLIDER_OFFSET);
+		return 0;
+	}
+
+	return 1;
+}
+
 void cmdline(int argc, char **argv)
 {
 	int opt;
 	int option_index = 0;
 
 	static struct option long_options[] = {
-		{"all",		required_argument,	0, 'a'},
-		{"cpu",		required_argument,	0, 'c'},
-		{"pkg",		required_argument,	0, 'p'},
-		{"debug",	no_argument,		0, 'd'},
-		{"hwp-desired",	required_argument,	0, 'D'},
-		{"epb",	required_argument,	0, 'B'},
-		{"force",	no_argument,	0, 'f'},
-		{"hwp-enable",	no_argument,	0, 'e'},
-		{"help",	no_argument,	0, 'h'},
-		{"hwp-epp",	required_argument,	0, 'P'},
-		{"hwp-min",	required_argument,	0, 'm'},
-		{"hwp-max",	required_argument,	0, 'M'},
-		{"read",	no_argument,		0, 'r'},
-		{"turbo-enable",	required_argument,	0, 't'},
-		{"hwp-use-pkg",	required_argument,	0, 'u'},
-		{"version",	no_argument,		0, 'v'},
-		{"hwp-window",	required_argument,	0, 'w'},
-		{"soc-slider-balance", required_argument, 0, 'S'},
-		{"soc-slider-offset",  required_argument, 0, 'O'},
-		{"platform-profile",   required_argument, 0, 'F'},
-		{0,		0,			0, 0 }
+		{ "all", required_argument, 0, 'a' },
+		{ "cpu", required_argument, 0, 'c' },
+		{ "pkg", required_argument, 0, 'p' },
+		{ "debug", no_argument, 0, 'd' },
+		{ "hwp-desired", required_argument, 0, 'D' },
+		{ "epb", required_argument, 0, 'B' },
+		{ "force", no_argument, 0, 'f' },
+		{ "hwp-enable", no_argument, 0, 'e' },
+		{ "help", no_argument, 0, 'h' },
+		{ "hwp-epp", required_argument, 0, 'P' },
+		{ "hwp-min", required_argument, 0, 'm' },
+		{ "hwp-max", required_argument, 0, 'M' },
+		{ "read", no_argument, 0, 'r' },
+		{ "turbo-enable", required_argument, 0, 't' },
+		{ "hwp-use-pkg", required_argument, 0, 'u' },
+		{ "version", no_argument, 0, 'v' },
+		{ "hwp-window", required_argument, 0, 'w' },
+		{ "soc-slider-balance", required_argument, 0, 'S' },
+		{ "soc-slider-offset", required_argument, 0, 'O' },
+		{ "platform-profile", required_argument, 0, 'F' },
+		{ 0, 0, 0, 0 }
 	};
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw::S:O:F:",
-				long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw::S:O:F:", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
 			parse_cmdline_all(optarg);
@@ -613,6 +670,8 @@ void cmdline(int argc, char **argv)
 		case 'F':
 			if (strlen(optarg) >= sizeof(platform_profile))
 				errx(1, "--platform-profile: value too long");
+			if (!platform_profile_access(W_OK))
+				errx(1, "Can not update platform-profile in '%s'", PATH_PLATFORM_PROFILE);
 			strcpy(platform_profile, optarg);
 			update_platform_profile = 1;
 			break;
@@ -625,6 +684,8 @@ void cmdline(int argc, char **argv)
 		case 'O':
 			if (parse_cmdline_int(optarg, &soc_slider_offset))
 				errx(1, "--soc-slider-offset: invalid value");
+			if (!soc_slider_access(W_OK))
+				errx(1, "Unable to write SOC Slider Offset");
 			update_soc_slider_offset = 1;
 			break;
 		case 'p':
@@ -639,6 +700,8 @@ void cmdline(int argc, char **argv)
 		case 'S':
 			if (parse_cmdline_int(optarg, &soc_slider_balance))
 				errx(1, "--soc-slider-balance: invalid value");
+			if (!soc_slider_access(W_OK))
+				errx(1, "Unable to write SOC Slider-Balance in '%s'", PATH_SOC_SLIDER_BALANCE);
 			update_soc_slider_balance = 1;
 			break;
 		case 't':
@@ -814,7 +877,8 @@ static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
 
 	numwritten = write(fd, buf, buflen - 1);
 	if (numwritten < 1) {
-		perror("write failed\n");
+		buf[strcspn(buf, "\n")] = '\0';
+		warn("Write '%s' to '%s' failed", buf, path);
 		close(fd);
 		return -1;
 	}
@@ -972,27 +1036,30 @@ static int set_epb_sysfs(int cpu, int val)
 	return (int)val;
 }
 
-static int soc_slider_available(void)
-{
-	if (access(PATH_SOC_SLIDER_BALANCE, R_OK) &&
-			access(PATH_SOC_SLIDER_OFFSET, R_OK) &&
-			access(PATH_PLATFORM_PROFILE, R_OK))
-		return 0;
-
-	return 1;
-}
-
 static void print_soc_slider(void)
 {
 	char buf[64];
 
-	if (!soc_slider_available())
+	if (!soc_slider_access(R_OK))
 		return;
 
 	if (sysfs_read_string(PATH_SOC_SLIDER_BALANCE, buf, sizeof(buf)) == 0)
 		printf("soc-slider-balance: %s\n", buf);
+
 	if (sysfs_read_string(PATH_SOC_SLIDER_OFFSET, buf, sizeof(buf)) == 0)
 		printf("soc-slider-offset: %s\n", buf);
+}
+
+static void print_platform_profile(void)
+{
+	char buf[64];
+
+	if (!platform_profile_access(R_OK))
+		return;
+
+	if (sysfs_read_string(PATH_PLATFORM_PROFILE_NAME, buf, sizeof(buf)) == 0)
+		printf("platform-profile-name: %s\n", buf);
+
 	if (sysfs_read_string(PATH_PLATFORM_PROFILE, buf, sizeof(buf)) == 0)
 		printf("platform-profile: %s\n", buf);
 }
@@ -1725,13 +1792,12 @@ int main(int argc, char **argv)
 		return -EINVAL;
 
 	/* display information only, no updates to settings */
-	if (!update_epb && !update_turbo && !hwp_update_enabled() &&
-	    !update_soc_slider_balance && !update_soc_slider_offset &&
-	    !update_platform_profile) {
+	if (!update_epb && !update_turbo && !hwp_update_enabled() && !update_soc_slider_balance && !update_soc_slider_offset && !update_platform_profile) {
 		if (cpu_selected_set)
 			for_all_cpus_in_set(cpu_setsize, cpu_selected_set, print_cpu_msrs);
 
 		print_soc_slider();
+		print_platform_profile();
 
 		if (has_hwp_request_pkg) {
 			if (pkg_selected_set == 0)
-- 
2.45.2

