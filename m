From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 06/14] cpufreq: intel_pstate: Set HWP sampling interval once
Date: Sun, 12 Mar 2017 18:17:51 +0100
Message-ID: <4713581.9NNTr8VI7R@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58695 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934661AbdCLRcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:41 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the HWP enabled case pid_params.sample_rate_ns only needs to be
updated once, because it is global, so do that when setting hwp_active
instead of doing it during the initialization of every CPU.

Moreover, pid_params.sample_rate_ms is never used if HWP is enabled,
so do not update it at all then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1974,8 +1974,6 @@ static int intel_pstate_init_cpu(unsigne
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
-		pid_params.sample_rate_ms = 50;
-		pid_params.sample_rate_ns = 50 * NSEC_PER_MSEC;
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
@@ -2650,6 +2648,7 @@ static int __init intel_pstate_init(void
 		copy_cpu_funcs(&core_params.funcs);
 		hwp_active++;
 		intel_pstate.attr = hwp_cpufreq_attrs;
+		pid_params.sample_rate_ns = 50 * NSEC_PER_MSEC;
 		goto hwp_cpu_matched;
 	}
 
