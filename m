From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] cpufreq: Clean up cpufreq_parse_governor()
Date: Thu, 23 Nov 2017 01:23:16 +0100
Message-ID: <1657366.eeJssZH0Uk@aspire.rjw.lan>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50126 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751594AbdKWAbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 19:31:17 -0500
In-Reply-To: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop an unnecessary local variable from cpufreq_parse_governor()
and rearrange the code in there to make it easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -604,16 +604,15 @@ static struct cpufreq_governor *find_gov
 static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 				struct cpufreq_governor **governor)
 {
-	int err = -EINVAL;
-
 	if (cpufreq_driver->setpolicy) {
 		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_PERFORMANCE;
-			err = 0;
-		} else if (!strncasecmp(str_governor, "powersave",
-						CPUFREQ_NAME_LEN)) {
+			return 0;
+		}
+
+		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_POWERSAVE;
-			err = 0;
+			return 0;
 		}
 	} else {
 		struct cpufreq_governor *t;
@@ -621,26 +620,29 @@ static int cpufreq_parse_governor(char *
 		mutex_lock(&cpufreq_governor_mutex);
 
 		t = find_governor(str_governor);
-
-		if (t == NULL) {
+		if (!t) {
 			int ret;
 
 			mutex_unlock(&cpufreq_governor_mutex);
+
 			ret = request_module("cpufreq_%s", str_governor);
+			if (ret)
+				return -EINVAL;
+
 			mutex_lock(&cpufreq_governor_mutex);
 
-			if (ret == 0)
-				t = find_governor(str_governor);
+			t = find_governor(str_governor);
 		}
 
-		if (t != NULL) {
+		mutex_unlock(&cpufreq_governor_mutex);
+
+		if (t) {
 			*governor = t;
-			err = 0;
+			return 0;
 		}
-
-		mutex_unlock(&cpufreq_governor_mutex);
 	}
-	return err;
+
+	return -EINVAL;
 }
 
 /**
