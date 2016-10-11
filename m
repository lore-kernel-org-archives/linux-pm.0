From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix struct pstate_adjust_policy kerneldoc
Date: Tue, 11 Oct 2016 23:13:59 +0200
Message-ID: <369062367.B9mLYn3C9F@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44574 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752916AbcJKVJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2016 17:09:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It looks like the name of struct pstate_adjust_policy was updated
without updating its kerneldoc comment accordingly, so fix that
mistake.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -225,7 +225,7 @@ struct cpudata {
 static struct cpudata **all_cpu_data;
 
 /**
- * struct pid_adjust_policy - Stores static PID configuration data
+ * struct pstate_adjust_policy - Stores static PID configuration data
  * @sample_rate_ms:	PID calculation sample rate in ms
  * @sample_rate_ns:	Sample rate calculation in ns
  * @deadband:		PID deadband

