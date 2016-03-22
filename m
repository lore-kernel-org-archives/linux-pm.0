From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Always schedule work on the CPU running update
Date: Tue, 22 Mar 2016 01:17:43 +0100
Message-ID: <3454445.v5QdUCRORG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41600 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750934AbcCVAPe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 20:15:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify dbs_irq_work() to always schedule the process-context work
on the current CPU which also ran the dbs_update_util_handler()
that the irq_work being handled came from.

This causes the entire frequency update handling (involving the
"ondemand" or "conservative" governors) to be carried out by the
CPU whose frequency is to be updated and reduces the overall amount
of inter-CPU noise related to cpufreq.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -245,7 +245,7 @@ static void dbs_irq_work(struct irq_work
 	struct policy_dbs_info *policy_dbs;
 
 	policy_dbs = container_of(irq_work, struct policy_dbs_info, irq_work);
-	schedule_work(&policy_dbs->work);
+	schedule_work_on(smp_processor_id(), &policy_dbs->work);
 }
 
 static void dbs_update_util_handler(struct update_util_data *data, u64 time,

