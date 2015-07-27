From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/7] cpufreq: Drop unnecessary label from cpufreq_add_dev()
Date: Mon, 27 Jul 2015 16:04:36 +0200
Message-ID: <1899761.i7upQxTcKo@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <3874727.Jpay9zgokc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60894 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753464AbbG0Nm7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 09:42:59 -0400
In-Reply-To: <3874727.Jpay9zgokc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The leftover out_release_rwsem label in cpufreq_add_dev() is not
necessary any more and confusing, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1237,7 +1237,7 @@ static int cpufreq_add_dev(struct device
 		recover_policy = false;
 		policy = cpufreq_policy_alloc(dev);
 		if (!policy)
-			goto out_release_rwsem;
+			return -ENOMEM;
 	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
@@ -1372,7 +1372,6 @@ out_exit_policy:
 		cpufreq_driver->exit(policy);
 out_free_policy:
 	cpufreq_policy_free(policy, recover_policy);
-out_release_rwsem:
 	return ret;
 }
 

