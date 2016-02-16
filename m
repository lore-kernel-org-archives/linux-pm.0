From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: ondemand: Simplify od_update() slightly
Date: Tue, 16 Feb 2016 21:00:58 +0100
Message-ID: <4864381.Sc603abrG6@vostro.rjw.lan>
References: <76641630.CimCW8476L@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56117 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752206AbcBPUAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 15:00:23 -0500
In-Reply-To: <76641630.CimCW8476L@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop some lines of code from od_update() by arranging the statements
in there in a more logical way.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -175,14 +175,11 @@ static void od_update(struct cpufreq_pol
 		/* No longer fully busy, reset rate_mult */
 		policy_dbs->rate_mult = 1;
 
-		if (!od_tuners->powersave_bias) {
-			__cpufreq_driver_target(policy, freq_next,
-					CPUFREQ_RELATION_C);
-			return;
-		}
+		if (od_tuners->powersave_bias)
+			freq_next = od_ops.powersave_bias_target(policy,
+								 freq_next,
+								 CPUFREQ_RELATION_L);
 
-		freq_next = od_ops.powersave_bias_target(policy, freq_next,
-					CPUFREQ_RELATION_L);
 		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_C);
 	}
 }

