From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Simplify switch () in cpufreq_cpu_callback()
Date: Thu, 07 Apr 2016 03:30:40 +0200
Message-ID: <4473117.ktOSeKFDYJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62606 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752024AbcDGB2J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 21:28:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Merge two switch entries that do the same thing in
cpufreq_cpu_callback().

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2312,16 +2312,13 @@ static int cpufreq_cpu_callback(struct n
 
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
 		cpufreq_online(cpu);
 		break;
 
 	case CPU_DOWN_PREPARE:
 		cpufreq_offline(cpu);
 		break;
-
-	case CPU_DOWN_FAILED:
-		cpufreq_online(cpu);
-		break;
 	}
 	return NOTIFY_OK;
 }

