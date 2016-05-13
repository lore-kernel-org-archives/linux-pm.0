From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/5] cpufreq: governor: CPUFREQ_GOV_LIMITS never fails
Date: Sat, 14 May 2016 00:59:27 +0200
Message-ID: <4856300.OoAS5drrzx@vostro.rjw.lan>
References: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

None of the cpufreq governors currently in the tree will ever fail
an invocation of the ->governor() callback with the event argument
equal to CPUFREQ_GOV_LIMITS (unless invoked with incorrect arguments
which doesn't matter anyway) and had it ever failed, the result of
it wouldn't have been very clean.

For this reason, rearrange the code in the core to ignore the return
value of cpufreq_governor() when called with event equal to
CPUFREQ_GOV_LIMITS.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2054,7 +2054,11 @@ static int cpufreq_start_governor(struct
 		cpufreq_update_current_freq(policy);
 
 	ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
-	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+	if (ret)
+		return ret;
+
+	cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+	return 0;
 }
 
 int cpufreq_register_governor(struct cpufreq_governor *governor)
@@ -2195,7 +2199,8 @@ static int cpufreq_set_policy(struct cpu
 
 	if (new_policy->governor == policy->governor) {
 		pr_debug("cpufreq: governor limits update\n");
-		return cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+		cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+		return 0;
 	}
 
 	pr_debug("governor switch\n");
