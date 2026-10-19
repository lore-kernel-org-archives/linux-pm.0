Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422200;
	b=vDOszmSXoxpbbXRwqYwjSL37c+silRhxmfIInCF9bMSTvi7D87+rXfBkPg62Hpz81GNv
	 IsQlQh9C+o99rA6pshBV/j3SW6V0avdCLnIomVUD1SfsANulyfUEdkNro+mOzzuwRl6wK
	 jnXX0yiiFOBoVCg1XOCZ7X5bZSP/gUlwEXTGSTDixE1Ij4yTzYFUYgnRahSAZwmtnoGqo
	 EF+WMBojK15D5mgmFcuPeZ0i0/DdZ/fFZ6SxJbxI5igMLhhdAvYvdnqqrFNzbg52Jva/l
	 r/W+LTYSYX+Mj1vk48S8SB2lFj7LirUExtRwG36ck+bujhn7IIuNpx9LLMEEfnTXojw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422200;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=Cafey3EN3JAss/l/VMXLS5pBPlEFjOYUiJHh3pWVxP4=;
	b=v6PeDRONBXW3xN2ZrzorQdRgksw6h3yOVppBFhAdDALYEKOPkb00V1vYj7H+owvV6gIx
	 QC/Q3/bXD+jBBG8ReboJX8aDPijiFU/pZzuenDP7JRoKNUqSax+6h5uTHDWOsA5nAVjGk
	 lspabY1isGt1H7+sH6GFI4il7DRLvU+SiUS0TYWlq/r4fcf0ilfqwBudQ4zVQ34LXKPFh
	 4BEJ4P/yONA4DaEe/rTpWYWs9hAtZA3MuTyrQCO1hdL9Wy/gTPz6rddC+TqHT8YyPjfrr
	 5yU5K1r+wjjbGLLnbf/87Rsb+IqSr64O4bpkjwEIJgoh99xkvjKCyAeuRNPT/gL6pPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhyEkqeA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF18607DC40
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhyEkqeA
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DD6513C3
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422200; cv=none; b=XwDqRwa7g3/fnvcUO/rwJYz+vz6vExPpDXiWYcFdphxjhkDb7U61l1cApx5SYZQQJtRkR3YuW0gJOuGBK3P8PuTKt5hmPtphtLKMkCMJVI/5C0VSt8PVg4ctj3IlHbkMUCE+1qT+CskX6B95WM864J04zE0aMbQPpYokRrjk9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422200; c=relaxed/simple;
	bh=69+0zACsOhHqtrhhZmateWNRgAOPHX3UoKeGCSQsXUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOkJwcGfwQuiMxvFx5IpaHQIzoWXa9c/Ww1Xl5wDvl/SYD853QX+UYpp/17QDfPUEOVc4aKs7YoX07aSj+ox6/HYAAL8QerfZvqdB00U2epVqw2y9MTzghMc1fnilD5ANDzOhBsLPBceDfO7eEiO6XoJz529b8bfrlrc/P5KaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhyEkqeA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306CA1F000C5;
	Mon, 19 Oct 2026 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422199;
	bh=Cafey3EN3JAss/l/VMXLS5pBPlEFjOYUiJHh3pWVxP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=nhyEkqeAwCBhisyd5YdiFvrTqYE9tT8ytNOQWRMacZyZ6C5ItEMpWSB9FzYSsgCx4
	 oEpsLklUEY01Ht/fT6GRRm42kxvRZzxXQDkJfvwqTM5EZOm7N+QPoeGv7+Y9hBA/K8
	 KOz9fEzhCtAm3bSpia/7lwtdh2QTj0tuRk0Tz0K8EhNant6NpKdi66tMQpSFPvjQRY
	 NFSd8WN4y3DuM9E2wyLh540B6fV+q18IBuG+2Yku84Zzviy2Zl7ZQTuUhRXipFFWyh
	 O0yFSxIH0auAdaY8ECGLk5u8D+dUM9QKmEZ1DP/zSNwBuvpu2w/F8GnpHWtU279q05
	 VgamtSjiy4Jig==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 23/23] tools/power turbostat: version 2026.10.16
Date: Mon, 19 Oct 2026 10:38:56 -0400
Message-ID: <0aac88e65d482d900e4e33c71812a6ec23275207.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Since 2026.09.28:

Remove hard-coded 8192-CPU limit.
Decode Uncore Frequency Agent Types.
Dump RDT (Resource Director Technology) config.
Dump RP (Resource Priority) config.
Misc cleanups and fixes.

This patch:

Format with: lindent -npro -kr -i8 -ts8 -sob -l190 -ss -ncs -cp1
This allows lines as wide as my terminal.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 110 +++++++++-----------------
 1 file changed, 36 insertions(+), 74 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 89a71f44431b..fb268463aedc 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2501,8 +2501,7 @@ int has_allowed_lower_ht_sibling(int cpu)
 	return 0;
 }
 
-int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pkg_data *),
-		 struct thread_data *thread_base, struct core_data *core_base, struct pkg_data *pkg_base)
+int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pkg_data *), struct thread_data *thread_base, struct core_data *core_base, struct pkg_data *pkg_base)
 {
 	int cpu, retval;
 
@@ -2587,8 +2586,7 @@ int get_msr_fd(int cpu)
 	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r %s, "
-		    "or run with --no-msr, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
+		err(-1, "%s open failed, try chown or chmod +r %s, " "or run with --no-msr, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
 	fd_percpu[cpu] = fd;
 
 	return fd;
@@ -2795,8 +2793,7 @@ void help(void)
 		"  -T, --TCC temperature\n"
 		"		sets the Thermal Control Circuit temperature in\n"
 		"		  degrees Celsius\n"
-		"  -h, --help\n"
-		"		print this help message\n  -v, --version\n\t\tprint version information\n\nFor more help, run \"man turbostat\"\n");
+		"  -h, --help\n" "		print this help message\n  -v, --version\n\t\tprint version information\n\nFor more help, run \"man turbostat\"\n");
 }
 
 /*
@@ -4011,8 +4008,7 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 
 	/* check for TSC < 1 Mcycles over interval */
 	if (old->tsc < (1000 * 1000))
-		errx(-3, "Insanely slow TSC rate, TSC stops in idle?\n"
-		     "You can disable all c-states by booting with \"idle=poll\"\nor just the deep ones with \"processor.max_cstate=1\"");
+		errx(-3, "Insanely slow TSC rate, TSC stops in idle?\n" "You can disable all c-states by booting with \"idle=poll\"\nor just the deep ones with \"processor.max_cstate=1\"");
 
 	old->c1 = new->c1 - old->c1;
 
@@ -4905,8 +4901,7 @@ int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct
 			assert(rci->fd_perf != -1);
 
 			if (debug >= 2)
-				fprintf(stderr, "Reading rapl counter via perf at %u (%llu %e %lf)\n",
-					i, perf_data[pi], rci->scale[i], perf_data[pi] * rci->scale[i]);
+				fprintf(stderr, "Reading rapl counter via perf at %u (%llu %e %lf)\n", i, perf_data[pi], rci->scale[i], perf_data[pi] * rci->scale[i]);
 
 			rci->data[i] = perf_data[pi];
 
@@ -5730,8 +5725,7 @@ static void dump_cst_cfg(void)
 		(msr & SNB_C3_AUTO_UNDEMOTE) ? "UNdemote-C3, " : "",
 		(msr & SNB_C1_AUTO_UNDEMOTE) ? "UNdemote-C1, " : "",
 		(msr & NHM_C3_AUTO_DEMOTE) ? "demote-C3, " : "",
-		(msr & NHM_C1_AUTO_DEMOTE) ? "demote-C1, " : "",
-		(msr & (1 << 15)) ? "" : "UN", (unsigned int)msr & 0xF, pkg_cstate_limit_strings[pkg_cstate_limit]);
+		(msr & NHM_C1_AUTO_DEMOTE) ? "demote-C1, " : "", (msr & (1 << 15)) ? "" : "UN", (unsigned int)msr & 0xF, pkg_cstate_limit_strings[pkg_cstate_limit]);
 
 #define AUTOMATIC_CSTATE_CONVERSION		(1UL << 16)
 	if (platform->has_cst_auto_convension) {
@@ -6228,8 +6222,7 @@ static int parse_cpu_str(char *cpu_str, cpu_set_t *cpu_set, int cpu_set_size)
 int for_all_cpus_2(int (func) (struct thread_data *, struct core_data *,
 			       struct pkg_data *, struct thread_data *, struct core_data *,
 			       struct pkg_data *), struct thread_data *thread_base,
-		   struct core_data *core_base, struct pkg_data *pkg_base,
-		   struct thread_data *thread_base2, struct core_data *core_base2, struct pkg_data *pkg_base2)
+		   struct core_data *core_base, struct pkg_data *pkg_base, struct thread_data *thread_base2, struct core_data *core_base2, struct pkg_data *pkg_base2)
 {
 	int cpu, retval;
 
@@ -7019,8 +7012,7 @@ void check_msr_permission(void)
 	}
 
 	if (failed) {
-		warnx("Failed to access %s. Some of the counters may not be available\n"
-		      "\tRun as root to enable them or use %s to disable the access explicitly", pathname, "--no-msr");
+		warnx("Failed to access %s. Some of the counters may not be available\n" "\tRun as root to enable them or use %s to disable the access explicitly", pathname, "--no-msr");
 		no_msr = 1;
 	}
 }
@@ -7597,9 +7589,7 @@ int print_hwp(PER_THREAD_PARAMS)
 	get_msr(cpu, MSR_HWP_CAPABILITIES, &msr);
 	fprintf(outf, "cpu%d: MSR_HWP_CAPABILITIES: 0x%08llx "
 		"(high %d guar %d eff %d low %d)\n",
-		cpu, msr,
-		(unsigned int)HWP_HIGHEST_PERF(msr),
-		(unsigned int)HWP_GUARANTEED_PERF(msr), (unsigned int)HWP_MOSTEFFICIENT_PERF(msr), (unsigned int)HWP_LOWEST_PERF(msr));
+		cpu, msr, (unsigned int)HWP_HIGHEST_PERF(msr), (unsigned int)HWP_GUARANTEED_PERF(msr), (unsigned int)HWP_MOSTEFFICIENT_PERF(msr), (unsigned int)HWP_LOWEST_PERF(msr));
 
 	get_msr(cpu, MSR_HWP_REQUEST, &msr);
 	fprintf(outf, "cpu%d: MSR_HWP_REQUEST: 0x%08llx "
@@ -7607,8 +7597,7 @@ int print_hwp(PER_THREAD_PARAMS)
 		cpu, msr,
 		(unsigned int)(((msr) >> 0) & 0xff),
 		(unsigned int)(((msr) >> 8) & 0xff),
-		(unsigned int)(((msr) >> 16) & 0xff),
-		(unsigned int)(((msr) >> 24) & 0xff), (unsigned int)(((msr) >> 32) & 0xff3), (unsigned int)(((msr) >> 42) & 0x1));
+		(unsigned int)(((msr) >> 16) & 0xff), (unsigned int)(((msr) >> 24) & 0xff), (unsigned int)(((msr) >> 32) & 0xff3), (unsigned int)(((msr) >> 42) & 0x1));
 
 	if (has_hwp_pkg) {
 		get_msr(cpu, MSR_HWP_REQUEST_PKG, &msr);
@@ -7616,17 +7605,14 @@ int print_hwp(PER_THREAD_PARAMS)
 			"(min %d max %d des %d epp 0x%x window 0x%x)\n",
 			cpu, msr,
 			(unsigned int)(((msr) >> 0) & 0xff),
-			(unsigned int)(((msr) >> 8) & 0xff),
-			(unsigned int)(((msr) >> 16) & 0xff), (unsigned int)(((msr) >> 24) & 0xff), (unsigned int)(((msr) >> 32) & 0xff3));
+			(unsigned int)(((msr) >> 8) & 0xff), (unsigned int)(((msr) >> 16) & 0xff), (unsigned int)(((msr) >> 24) & 0xff), (unsigned int)(((msr) >> 32) & 0xff3));
 	}
 	if (has_hwp_notify) {
 		get_msr(cpu, MSR_HWP_INTERRUPT, &msr);
-		fprintf(outf, "cpu%d: MSR_HWP_INTERRUPT: 0x%08llx "
-			"(%s_Guaranteed_Perf_Change, %s_Excursion_Min)\n", cpu, msr, ((msr) & 0x1) ? "EN" : "Dis", ((msr) & 0x2) ? "EN" : "Dis");
+		fprintf(outf, "cpu%d: MSR_HWP_INTERRUPT: 0x%08llx " "(%s_Guaranteed_Perf_Change, %s_Excursion_Min)\n", cpu, msr, ((msr) & 0x1) ? "EN" : "Dis", ((msr) & 0x2) ? "EN" : "Dis");
 	}
 	get_msr(cpu, MSR_HWP_STATUS, &msr);
-	fprintf(outf, "cpu%d: MSR_HWP_STATUS: 0x%08llx "
-		"(%sGuaranteed_Perf_Change, %sExcursion_Min)\n", cpu, msr, ((msr) & 0x1) ? "" : "No-", ((msr) & 0x4) ? "" : "No-");
+	fprintf(outf, "cpu%d: MSR_HWP_STATUS: 0x%08llx " "(%sGuaranteed_Perf_Change, %sExcursion_Min)\n", cpu, msr, ((msr) & 0x1) ? "" : "No-", ((msr) & 0x4) ? "" : "No-");
 
 	return 0;
 }
@@ -7670,8 +7656,7 @@ int print_perf_limit(PER_THREAD_PARAMS)
 			(msr & 1 << 8) ? "Amps, " : "",
 			(msr & 1 << 6) ? "VR-Therm, " : "",
 			(msr & 1 << 5) ? "Auto-HWP, " : "",
-			(msr & 1 << 4) ? "Graphics, " : "",
-			(msr & 1 << 2) ? "bit2, " : "", (msr & 1 << 1) ? "ThermStatus, " : "", (msr & 1 << 0) ? "PROCHOT, " : "");
+			(msr & 1 << 4) ? "Graphics, " : "", (msr & 1 << 2) ? "bit2, " : "", (msr & 1 << 1) ? "ThermStatus, " : "", (msr & 1 << 0) ? "PROCHOT, " : "");
 		fprintf(outf, " (Logged: %s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
 			(msr & 1 << 31) ? "bit31, " : "",
 			(msr & 1 << 30) ? "bit30, " : "",
@@ -7683,8 +7668,7 @@ int print_perf_limit(PER_THREAD_PARAMS)
 			(msr & 1 << 24) ? "Amps, " : "",
 			(msr & 1 << 22) ? "VR-Therm, " : "",
 			(msr & 1 << 21) ? "Auto-HWP, " : "",
-			(msr & 1 << 20) ? "Graphics, " : "",
-			(msr & 1 << 18) ? "bit18, " : "", (msr & 1 << 17) ? "ThermStatus, " : "", (msr & 1 << 16) ? "PROCHOT, " : "");
+			(msr & 1 << 20) ? "Graphics, " : "", (msr & 1 << 18) ? "bit18, " : "", (msr & 1 << 17) ? "ThermStatus, " : "", (msr & 1 << 16) ? "PROCHOT, " : "");
 
 	}
 	if (platform->plr_msrs & PLR_GFX) {
@@ -7695,15 +7679,13 @@ int print_perf_limit(PER_THREAD_PARAMS)
 			(msr & 1 << 1) ? "ThermStatus, " : "",
 			(msr & 1 << 4) ? "Graphics, " : "",
 			(msr & 1 << 6) ? "VR-Therm, " : "",
-			(msr & 1 << 8) ? "Amps, " : "",
-			(msr & 1 << 9) ? "GFXPwr, " : "", (msr & 1 << 10) ? "PkgPwrL1, " : "", (msr & 1 << 11) ? "PkgPwrL2, " : "");
+			(msr & 1 << 8) ? "Amps, " : "", (msr & 1 << 9) ? "GFXPwr, " : "", (msr & 1 << 10) ? "PkgPwrL1, " : "", (msr & 1 << 11) ? "PkgPwrL2, " : "");
 		fprintf(outf, " (Logged: %s%s%s%s%s%s%s%s)\n",
 			(msr & 1 << 16) ? "PROCHOT, " : "",
 			(msr & 1 << 17) ? "ThermStatus, " : "",
 			(msr & 1 << 20) ? "Graphics, " : "",
 			(msr & 1 << 22) ? "VR-Therm, " : "",
-			(msr & 1 << 24) ? "Amps, " : "",
-			(msr & 1 << 25) ? "GFXPwr, " : "", (msr & 1 << 26) ? "PkgPwrL1, " : "", (msr & 1 << 27) ? "PkgPwrL2, " : "");
+			(msr & 1 << 24) ? "Amps, " : "", (msr & 1 << 25) ? "GFXPwr, " : "", (msr & 1 << 26) ? "PkgPwrL1, " : "", (msr & 1 << 27) ? "PkgPwrL2, " : "");
 	}
 	if (platform->plr_msrs & PLR_RING) {
 		get_msr(cpu, MSR_RING_PERF_LIMIT_REASONS, &msr);
@@ -7711,13 +7693,11 @@ int print_perf_limit(PER_THREAD_PARAMS)
 		fprintf(outf, " (Active: %s%s%s%s%s%s)",
 			(msr & 1 << 0) ? "PROCHOT, " : "",
 			(msr & 1 << 1) ? "ThermStatus, " : "",
-			(msr & 1 << 6) ? "VR-Therm, " : "",
-			(msr & 1 << 8) ? "Amps, " : "", (msr & 1 << 10) ? "PkgPwrL1, " : "", (msr & 1 << 11) ? "PkgPwrL2, " : "");
+			(msr & 1 << 6) ? "VR-Therm, " : "", (msr & 1 << 8) ? "Amps, " : "", (msr & 1 << 10) ? "PkgPwrL1, " : "", (msr & 1 << 11) ? "PkgPwrL2, " : "");
 		fprintf(outf, " (Logged: %s%s%s%s%s%s)\n",
 			(msr & 1 << 16) ? "PROCHOT, " : "",
 			(msr & 1 << 17) ? "ThermStatus, " : "",
-			(msr & 1 << 22) ? "VR-Therm, " : "",
-			(msr & 1 << 24) ? "Amps, " : "", (msr & 1 << 26) ? "PkgPwrL1, " : "", (msr & 1 << 27) ? "PkgPwrL2, " : "");
+			(msr & 1 << 22) ? "VR-Therm, " : "", (msr & 1 << 24) ? "Amps, " : "", (msr & 1 << 26) ? "PkgPwrL1, " : "", (msr & 1 << 27) ? "PkgPwrL2, " : "");
 	}
 	return 0;
 }
@@ -7842,8 +7822,7 @@ void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
 	fprintf(outf, "cpu%d: %s: %sabled (%0.3f Watts, %f sec, clamp %sabled)\n",
 		cpu, label,
 		((msr >> 15) & 1) ? "EN" : "DIS",
-		((msr >> 0) & 0x7FFF) * rapl_power_units,
-		(1.0 + (((msr >> 22) & 0x3) / 4.0)) * (1 << ((msr >> 17) & 0x1F)) * rapl_time_units, (((msr >> 16) & 1) ? "EN" : "DIS"));
+		((msr >> 0) & 0x7FFF) * rapl_power_units, (1.0 + (((msr >> 22) & 0x3) / 4.0)) * (1 << ((msr >> 17) & 0x1F)) * rapl_time_units, (((msr >> 16) & 1) ? "EN" : "DIS"));
 
 	return;
 }
@@ -8051,8 +8030,7 @@ int print_rapl(PER_THREAD_PARAMS)
 		fprintf(outf, "cpu%d: PKG Limit #2: %sabled (%0.3f Watts, %f* sec, clamp %sabled)\n",
 			cpu,
 			((msr >> 47) & 1) ? "EN" : "DIS",
-			((msr >> 32) & 0x7FFF) * rapl_power_units,
-			(1.0 + (((msr >> 54) & 0x3) / 4.0)) * (1 << ((msr >> 49) & 0x1F)) * rapl_time_units, ((msr >> 48) & 1) ? "EN" : "DIS");
+			((msr >> 32) & 0x7FFF) * rapl_power_units, (1.0 + (((msr >> 54) & 0x3) / 4.0)) * (1 << ((msr >> 49) & 0x1F)) * rapl_time_units, ((msr >> 48) & 1) ? "EN" : "DIS");
 
 		get_msr(cpu, MSR_VR_CURRENT_CONFIG, &msr);
 		fprintf(outf, "cpu%d: MSR_VR_CURRENT_CONFIG: 0x%08llx\n", cpu, msr);
@@ -8208,8 +8186,7 @@ int set_temperature_target(PER_THREAD_PARAMS)
 
 		if (bits && enabled) {
 			tcc_offset = (msr >> 24) & GENMASK(bits - 1, 0);
-			fprintf(outf, "cpu%d: MSR_IA32_TEMPERATURE_TARGET: 0x%08llx (%d C) (%d default - %d offset)\n",
-				cpu, msr, tcc_default - tcc_offset, tcc_default, tcc_offset);
+			fprintf(outf, "cpu%d: MSR_IA32_TEMPERATURE_TARGET: 0x%08llx (%d C) (%d default - %d offset)\n", cpu, msr, tcc_default - tcc_offset, tcc_default, tcc_offset);
 		} else {
 			fprintf(outf, "cpu%d: MSR_IA32_TEMPERATURE_TARGET: 0x%08llx (%d C)\n", cpu, msr, tcc_default);
 		}
@@ -8331,8 +8308,7 @@ void decode_feature_control_msr(void)
 		return;
 
 	get_msr(master_cpu, MSR_IA32_FEAT_CTL, &msr);
-	fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
-		master_cpu, msr, msr & FEAT_CTL_LOCKED ? "" : "UN-", msr & (1 << 18) ? "SGX" : "");
+	fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n", master_cpu, msr, msr & FEAT_CTL_LOCKED ? "" : "UN-", msr & (1 << 18) ? "SGX" : "");
 }
 
 void decode_misc_enable_msr(void)
@@ -8350,8 +8326,7 @@ void decode_misc_enable_msr(void)
 		master_cpu, msr,
 		msr & MSR_IA32_MISC_ENABLE_TM1 ? "" : "No-",
 		msr & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP ? "" : "No-",
-		msr & MSR_IA32_MISC_ENABLE_MWAIT ? "" : "No-",
-		msr & MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE ? "No-" : "", msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ? "No-" : "");
+		msr & MSR_IA32_MISC_ENABLE_MWAIT ? "" : "No-", msr & MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE ? "No-" : "", msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ? "No-" : "");
 }
 
 void decode_misc_feature_control(void)
@@ -8453,8 +8428,7 @@ static int has_perf_instr_count_access(void)
 
 	if (fd == -1)
 		warnx("Failed to access %s. Some of the counters may not be available\n"
-		      "\tRun as root to enable them or use %s to disable the access explicitly", "perf instructions retired counter",
-		      "'--hide IPC' or '--no-perf'");
+		      "\tRun as root to enable them or use %s to disable the access explicitly", "perf instructions retired counter", "'--hide IPC' or '--no-perf'");
 
 	return (fd != -1);
 }
@@ -8500,8 +8474,7 @@ int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct
 	return ret;
 }
 
-int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, const char *sysfs_path,
-				  const char *sysfs_file)
+int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, const char *sysfs_path, const char *sysfs_file)
 {
 	FILE *fp;
 	char *cpuset_buf = NULL;
@@ -9127,8 +9100,7 @@ void dump_rdt_a_leaf(int leaf)
 		has_rp_thread = eax & (1 << 0);
 		has_rp_package = eax & (1 << 1);
 
-		fprintf(outf, "cpu%d: CPUID(0x%x).%d: %sRP_THREAD, %sRP_PKG",
-			cpu, leaf, RDT_RP_INDEX, has_rp_thread ? "" : "No-", has_rp_package ? "" : "No-");
+		fprintf(outf, "cpu%d: CPUID(0x%x).%d: %sRP_THREAD, %sRP_PKG", cpu, leaf, RDT_RP_INDEX, has_rp_thread ? "" : "No-", has_rp_package ? "" : "No-");
 		if (has_rp_thread) {
 			unsigned long long msr;
 
@@ -9222,8 +9194,7 @@ void process_cpuid()
 			ecx_flags & (1 << 8) ? "" : "No-",
 			cpuid_has_hv ? "" : "No-",
 			edx_flags & (1 << 4) ? "" : "No-",
-			edx_flags & (1 << 5) ? "" : "No-",
-			edx_flags & (1 << 22) ? "" : "No-", edx_flags & (1 << 28) ? "" : "No-", edx_flags & (1 << 29) ? "" : "No-");
+			edx_flags & (1 << 5) ? "" : "No-", edx_flags & (1 << 22) ? "" : "No-", edx_flags & (1 << 28) ? "" : "No-", edx_flags & (1 << 29) ? "" : "No-");
 	}
 	if (!quiet && cpuid_has_hv)
 		dump_cpuid_hypervisor();
@@ -9272,9 +9243,7 @@ void process_cpuid()
 			has_turbo ? "" : "No-",
 			do_dts ? "" : "No-",
 			do_ptm ? "" : "No-",
-			has_hwp ? "" : "No-",
-			has_hwp_notify ? "" : "No-",
-			has_hwp_activity_window ? "" : "No-", has_hwp_epp ? "" : "No-", has_hwp_pkg ? "" : "No-", has_epb ? "" : "No-");
+			has_hwp ? "" : "No-", has_hwp_notify ? "" : "No-", has_hwp_activity_window ? "" : "No-", has_hwp_epp ? "" : "No-", has_hwp_pkg ? "" : "No-", has_epb ? "" : "No-");
 
 	if (!quiet)
 		decode_misc_enable_msr();
@@ -9299,8 +9268,7 @@ void process_cpuid()
 			has_ardt_a = ecx & (1 << 1);
 
 			fprintf(outf, "CPUID(7): %sSGX %sRDT_M %sRDT_A %sARDT_M %sARDT_A %sHybrid\n",
-				has_sgx ? "" : "No-", has_rdt_m ? "" : "No-", has_rdt_a ? "" : "No-", has_ardt_m ? "" : "No-", has_ardt_a ? "" : "No-",
-				is_hybrid ? "" : "No-");
+				has_sgx ? "" : "No-", has_rdt_m ? "" : "No-", has_rdt_a ? "" : "No-", has_ardt_m ? "" : "No-", has_ardt_a ? "" : "No-", is_hybrid ? "" : "No-");
 
 			if (has_sgx)
 				decode_feature_control_msr();
@@ -9842,8 +9810,7 @@ void topology_probe(bool startup)
 			continue;
 		fprintf(outf,
 			"cpu %d pkg %d die %d l3 %d node %d lnode %d module 0x%x core %d ht_id %d",
-			i, cpus[i].package_id, cpus[i].die_id, cpus[i].l3_id,
-			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].module_id, cpus[i].core_id, cpus[i].ht_id);
+			i, cpus[i].package_id, cpus[i].die_id, cpus[i].l3_id, cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].module_id, cpus[i].core_id, cpus[i].ht_id);
 		fprintf(outf, " siblings");
 		for (ht_id = 0; ht_id <= MAX_HT_ID; ++ht_id)
 			fprintf(outf, " %d", cpus[i].ht_sibling_cpu_id[ht_id]);
@@ -10449,8 +10416,7 @@ void pmt_counter_add_domain(struct pmt_counter *pcounter, unsigned long *pmmio,
 }
 
 int pmt_add_counter(unsigned int guid, unsigned int seq, const char *name, enum pmt_datatype type,
-		    unsigned int lsb, unsigned int msb, unsigned int offset, enum counter_scope scope,
-		    enum counter_format format, unsigned int domain_id, enum pmt_open_mode mode)
+		    unsigned int lsb, unsigned int msb, unsigned int offset, enum counter_scope scope, enum counter_format format, unsigned int domain_id, enum pmt_open_mode mode)
 {
 	struct pmt_mmio *mmio;
 	struct pmt_counter *pcounter;
@@ -10710,7 +10676,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2026.09.28 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2026.10.16 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
@@ -10749,8 +10715,7 @@ struct msr_counter *find_msrp_by_name(struct msr_counter *head, const char *name
 	return NULL;
 }
 
-int add_counter(unsigned int msr_num, const char *path, const char *name,
-		unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format, int flags, int id)
+int add_counter(unsigned int msr_num, const char *path, const char *name, unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format, int flags, int id)
 {
 	struct msr_counter *msrp;
 
@@ -10758,8 +10723,7 @@ int add_counter(unsigned int msr_num, const char *path, const char *name,
 		errx(1, "Requested MSR counter 0x%x, but in --no-msr mode", msr_num);
 
 	if (debug)
-		fprintf(stderr, "%s(msr%d, %s, %s, width%d, scope%d, type%d, format%d, flags%x, id%d)\n",
-			__func__, msr_num, path, name, width, scope, type, format, flags, id);
+		fprintf(stderr, "%s(msr%d, %s, %s, width%d, scope%d, type%d, format%d, flags%x, id%d)\n", __func__, msr_num, path, name, width, scope, type, format, flags, id);
 
 	switch (scope) {
 
@@ -10858,9 +10822,7 @@ int add_counter(unsigned int msr_num, const char *path, const char *name,
  * easily call re_initialize().
  */
 struct perf_counter_info *make_perf_counter_info(const char *perf_device,
-						 const char *perf_event,
-						 const char *name,
-						 unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format)
+						 const char *perf_event, const char *name, unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format)
 {
 	struct perf_counter_info *pinfo;
 
-- 
2.45.2

