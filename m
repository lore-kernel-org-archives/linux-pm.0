From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] cpufreq: Always update current frequency before startig governor
Date: Mon, 21 Mar 2016 15:47:48 +0100
Message-ID: <1847835.ROHO9MEN8J@vostro.rjw.lan>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47769 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755911AbcCUOqK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 10:46:10 -0400
In-Reply-To: <1780622.pJaGsuQWcI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make policy->cur match the current frequency returned by the driver's
->get() callback before starting the governor in case they went out of
sync in the meantime and drop the piece of code attempting to
resync policy->cur with the real frequency of the boot CPU from
cpufreq_resume() as it serves no purpose any more (and it's racy and
super-ugly anyway).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1680,17 +1680,6 @@ void cpufreq_resume(void)
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
@@ -2062,6 +2051,9 @@ static int cpufreq_start_governor(struct
 {
 	int ret;
 
+	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
+		cpufreq_update_current_freq(policy);
+
 	ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
 	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 }

