From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] cpufreq: Avoid double kobject_put() for the same kobject in error code path
Date: Thu, 01 Aug 2013 23:31:05 +0200
Message-ID: <2204970.DYsqYi7YjZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:51122 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab3HAVUx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Aug 2013 17:20:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only case triggering a jump to the err_out_unregister label in
__cpufreq_add_dev() is when cpufreq_add_dev_interface() fails.
However, if cpufreq_add_dev_interface() fails, it calls kobject_put()
for the policy kobject in its error code path and since that causes
the kobject's refcount to become 0, the additional kobject_put() for
the same kobject under err_out_unregister and the
wait_for_completion() following it are pointless, so drop them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1109,9 +1109,6 @@ err_out_unregister:
 	}
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	kobject_put(&policy->kobj);
-	wait_for_completion(&policy->kobj_unregister);
-
 err_set_policy_cpu:
 	per_cpu(cpufreq_policy_cpu, cpu) = -1;
 	cpufreq_policy_free(policy);

