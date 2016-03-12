From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Do not schedule policy update work in cpufreq_resume()
Date: Sat, 12 Mar 2016 03:05:50 +0100
Message-ID: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54084 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751873AbcCLCDy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 21:03:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

cpufreq_resume() attempts to resync the current frequency with
policy->cur for the first online CPU, but first it does that after
restarting governors for all active policies (which means that this
is racy with respect to whatever the governors do) and second it
already is too late for that when cpufreq_resume() is called (that
happens after invoking ->resume callbacks for all devices in the
system).

Also it doesn't make sense to do that for one CPU only in any case,
because the other CPUs in the system need not share the policy with
it and their policy->cur may be out of sync as well in principle.

For the above reasons, drop the part in question from cpufreq_resume().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   11 -----------
 1 file changed, 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1593,17 +1593,6 @@ void cpufreq_resume(void)
 				       __func__, policy);
 		}
 	}
-
-	/*
-	 * schedule call cpufreq_update_policy() for first-online CPU, as that
-	 * wouldn't be hotplugged-out on suspend. It will verify that the
-	 * current freq is in sync with what we believe it to be.
-	 */
-	policy = cpufreq_cpu_get_raw(cpumask_first(cpu_online_mask));
-	if (WARN_ON(!policy))
-		return;
-
-	schedule_work(&policy->update);
 }
 
 /**

