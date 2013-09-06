From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 4/5] cpufreq: Remove temporary fix for race between CPU
 hotplug and sysfs-writes
Date: Sat, 07 Sep 2013 01:23:55 +0530
Message-ID: <20130906195353.26919.76123.stgit@srivatsabhat.in.ibm.com>
References: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:46714 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab3IFT54 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 15:57:56 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 6 Sep 2013 15:57:56 -0400
In-Reply-To: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, sboyd@codeaurora.org, viresh.kumar@linaro.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Commit "cpufreq: serialize calls to __cpufreq_governor()" had been a temporary
and partial solution to the race condition between writing to a cpufreq sysfs
file and taking a CPU offline. Now that we have a proper and complete solution
to that problem, remove the temporary fix.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/cpufreq.c |    7 +------
 include/linux/cpufreq.h   |    1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c2eb413..9909789 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1783,15 +1783,13 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 						policy->cpu, event);
 
 	mutex_lock(&cpufreq_governor_lock);
-	if (policy->governor_busy
-	    || (policy->governor_enabled && event == CPUFREQ_GOV_START)
+	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
 	    || (!policy->governor_enabled
 	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
 		mutex_unlock(&cpufreq_governor_lock);
 		return -EBUSY;
 	}
 
-	policy->governor_busy = true;
 	if (event == CPUFREQ_GOV_STOP)
 		policy->governor_enabled = false;
 	else if (event == CPUFREQ_GOV_START)
@@ -1820,9 +1818,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
 		module_put(policy->governor->owner);
 
-	mutex_lock(&cpufreq_governor_lock);
-	policy->governor_busy = false;
-	mutex_unlock(&cpufreq_governor_lock);
 	return ret;
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cca885d..d568f39 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -76,7 +76,6 @@ struct cpufreq_policy {
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
 	bool			governor_enabled; /* governor start/stop flag */
-	bool			governor_busy;
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */

