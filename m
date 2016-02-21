From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: governor: Make gov_set_update_util() static
Date: Sun, 21 Feb 2016 03:15:34 +0100
Message-ID: <1513735.63Kc3ciBeA@vostro.rjw.lan>
References: <2410542.x6e5Rli2VY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47618 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752195AbcBUCOO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2016 21:14:14 -0500
In-Reply-To: <2410542.x6e5Rli2VY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The gov_set_update_util() routine is only used internally by the
common governor code and it doesn't need to be exported, so make
it static.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -261,8 +261,8 @@ unsigned int dbs_update(struct cpufreq_p
 }
 EXPORT_SYMBOL_GPL(dbs_update);
 
-void gov_set_update_util(struct policy_dbs_info *policy_dbs,
-			 unsigned int delay_us)
+static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
+				unsigned int delay_us)
 {
 	struct cpufreq_policy *policy = policy_dbs->policy;
 	int cpu;
@@ -276,7 +276,6 @@ void gov_set_update_util(struct policy_d
 		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
 	}
 }
-EXPORT_SYMBOL_GPL(gov_set_update_util);
 
 static inline void gov_clear_update_util(struct cpufreq_policy *policy)
 {

