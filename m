From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/5] cpufreq: governor: Simplify performance and powersave governors
Date: Sat, 14 May 2016 01:01:08 +0200
Message-ID: <2924709.Lf5ftEZLmT@vostro.rjw.lan>
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

The performance and powersave cpufreq governors handle the
CPUFREQ_GOV_START event in the same way as CPUFREQ_GOV_LIMITS.
However, the cpufreq core always invokes cpufreq_governor() with the
event argument equal to CPUFREQ_GOV_LIMITS right after invoking it with
event equal to CPUFREQ_GOV_START.  As a result, for both the governors
in question, __cpufreq_driver_target() is executed twice in a row
with the same arguments which is not useful.

For this reason, simplify the performance and powersave governors
to handle the CPUFREQ_GOV_LIMITS event only as that's going to be
sufficient for the governor start too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_performance.c |    4 +---
 drivers/cpufreq/cpufreq_powersave.c   |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
+++ linux-pm/drivers/cpufreq/cpufreq_performance.c
@@ -20,10 +20,8 @@ static int cpufreq_governor_performance(
 					unsigned int event)
 {
 	switch (event) {
-	case CPUFREQ_GOV_START:
 	case CPUFREQ_GOV_LIMITS:
-		pr_debug("setting to %u kHz because of event %u\n",
-						policy->max, event);
+		pr_debug("setting to %u kHz\n", policy->max);
 		__cpufreq_driver_target(policy, policy->max,
 						CPUFREQ_RELATION_H);
 		break;
Index: linux-pm/drivers/cpufreq/cpufreq_powersave.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_powersave.c
+++ linux-pm/drivers/cpufreq/cpufreq_powersave.c
@@ -20,10 +20,8 @@ static int cpufreq_governor_powersave(st
 					unsigned int event)
 {
 	switch (event) {
-	case CPUFREQ_GOV_START:
 	case CPUFREQ_GOV_LIMITS:
-		pr_debug("setting to %u kHz because of event %u\n",
-							policy->min, event);
+		pr_debug("setting to %u kHz\n", policy->min);
 		__cpufreq_driver_target(policy, policy->min,
 						CPUFREQ_RELATION_L);
 		break;
