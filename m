From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/5] cpufreq: governor: Check transition latecy at init time only
Date: Sat, 14 May 2016 01:00:28 +0200
Message-ID: <8685194.VWxfunzal1@vostro.rjw.lan>
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

It is not necessary to check the governor's max_transition_latency
attribute every time cpufreq_governor() runs, so check it only if
the event argument is CPUFREQ_GOV_POLICY_INIT.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2011,23 +2011,24 @@ static int cpufreq_governor(struct cpufr
 	if (!policy->governor)
 		return -EINVAL;
 
-	if (policy->governor->max_transition_latency &&
-	    policy->cpuinfo.transition_latency >
-	    policy->governor->max_transition_latency) {
-		struct cpufreq_governor *gov = cpufreq_fallback_governor();
+	if (event == CPUFREQ_GOV_POLICY_INIT) {
+		if (policy->governor->max_transition_latency &&
+		    policy->cpuinfo.transition_latency >
+		    policy->governor->max_transition_latency) {
+			struct cpufreq_governor *gov = cpufreq_fallback_governor();
 
-		if (gov) {
-			pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
-				policy->governor->name, gov->name);
-			policy->governor = gov;
-		} else {
-			return -EINVAL;
+			if (gov) {
+				pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
+					policy->governor->name, gov->name);
+				policy->governor = gov;
+			} else {
+				return -EINVAL;
+			}
 		}
-	}
 
-	if (event == CPUFREQ_GOV_POLICY_INIT)
 		if (!try_module_get(policy->governor->owner))
 			return -EINVAL;
+	}
 
 	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
