From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] cpufreq: Fix two debug messages in cpufreq_set_policy()
Date: Wed, 20 Feb 2019 00:25:18 +0100
Message-ID: <2486777.RhoGZOM3Wg@aspire.rjw.lan>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Remove the redundant "cpufreq:" prefix from two debug messages in
cpufreq_set_policy().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2290,7 +2290,7 @@ static int cpufreq_set_policy(struct cpu
 	}
 
 	if (new_policy->governor == policy->governor) {
-		pr_debug("cpufreq: governor limits update\n");
+		pr_debug("governor limits update\n");
 		cpufreq_governor_limits(policy);
 		return 0;
 	}
@@ -2311,7 +2311,7 @@ static int cpufreq_set_policy(struct cpu
 	if (!ret) {
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
-			pr_debug("cpufreq: governor change\n");
+			pr_debug("governor change\n");
 			sched_cpufreq_governor_change(policy, old_gov);
 			return 0;
 		}
