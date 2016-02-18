From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/12] cpufreq: governor: Close dbs_data update race condition
Date: Thu, 18 Feb 2016 02:19 +0100
Message-ID: <1592265.QLnTJA45ZD@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is possible for a dbs_data object to be updated after its
usage counter has become 0.  That may happen if governor_store()
runs (via a govenor tunable sysfs attribute write) in parallel
with cpufreq_governor_exit() called for the last cpufreq policy
associated with the dbs_data in question.  In that case, if
governor_store() acquires dbs_data->mutex right after
cpufreq_governor_exit() has released it, the ->store() callback
invoked by it may operate on dbs_data with no users.  Although
sysfs will cause the kobject_put() in cpufreq_governor_exit() to
block until governor_store() has returned, that situation may
lead to some unexpected results, depending on the implementation
of the ->store callback, and therefore it should be avoided.

To that end, modify governor_store() to check the dbs_data's
usage count before invoking the ->store() callback and return
an error if it is 0 at that point.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -112,7 +112,7 @@ static ssize_t governor_store(struct kob
 
 	mutex_lock(&dbs_data->mutex);
 
-	if (gattr->store)
+	if (dbs_data->usage_count && gattr->store)
 		ret = gattr->store(dbs_data, buf, count);
 
 	mutex_unlock(&dbs_data->mutex);
