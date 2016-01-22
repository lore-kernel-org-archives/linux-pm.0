From: Thomas Renninger <trenn@suse.de>
Subject: Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Fri, 22 Jan 2016 13:09:15 +0100
Message-ID: <27955112.HtLWzIlZCK@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40653 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbcAVMJR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Jan 2016 07:09:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Bahling <sbahling@suse.com>

The assumption that BIOSes never want to have this register being set to
full performance (zero) is wrong.

While wrongly overruling this BIOS setting and set it to from performance
to normal did not hurt that much, because nobody really knew the effects inside
Intel processors.

But with Broadwell-EP processor (E5-2687W v4) the CPU will not enter turbo modes
if this value is not set to performance.

So switch logic to tell the user in a friendly way (info) that the CPU is in
performance mode and how to switch via userspace if this is not intended.

But otherwise trust that the BIOS has set the correct value here and do not
blindly overrule.

How this has been found: SLE11 had this patch, SLE12 it slipped through.
It took quite some time to nail down that this patch missing is the reason
for not entering turbo modes with this specific processor.

Signed-off-by: Thomas Renninger <trenn@suse.com>

--- arch/x86/kernel/cpu/intel.c.orig	2016-01-22 12:49:03.347906007 +0100
+++ arch/x86/kernel/cpu/intel.c	2016-01-22 12:53:33.043234963 +0100
@@ -377,8 +377,14 @@
 	u64 epb;
 
 	/*
-	 * Initialize MSR_IA32_ENERGY_PERF_BIAS if not already initialized.
-	 * (x86_energy_perf_policy(8) is available to change it at run-time.)
+	 * On server platforms energy bias typically is set to
+	 * performance on purpose.
+	 * On other platforms it may happen that MSR_IA32_ENERGY_PERF_BIAS
+	 * did not get initialized properly by BIOS.
+	 * An additional check could be to look at pm_profile and check whether
+	 * this is a performance oriented platform.
+	 * But best is to to keep BIOS settings and give the user a hint whether
+	 * to change it via cpupower-set(8) userspace tool at runtime.
 	 */
 	if (!cpu_has(c, X86_FEATURE_EPB))
 		return;
@@ -387,10 +393,8 @@
 	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
 		return;
 
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
-	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
-	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
+	pr_info_once("ENERGY_PERF_BIAS is set to 'performance'\n");
+	pr_info_once("ENERGY_PERF_BIAS: Update with cpupower-set(8)\n");
 }
 
 static void intel_bsp_resume(struct cpuinfo_x86 *c)

