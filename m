From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 01/14] cpufreq: intel_pstate: Update pid_params.sample_rate_ns in pid_param_set()
Date: Sun, 12 Mar 2017 18:12:56 +0100
Message-ID: <1870069.9aRhgp95Gh@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45630 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934680AbdCLRco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:44 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix the debugfs interface for PID tuning to actually update
pid_params.sample_rate_ns on PID parameters updates, as changing
pid_params.sample_rate_ms via debugfs has no effect now.

Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utilization update callbacks)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -983,6 +983,7 @@ static void intel_pstate_update_policies
 static int pid_param_set(void *data, u64 val)
 {
 	*(u32 *)data = val;
+	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
 	intel_pstate_reset_all_pid();
 	return 0;
 }
