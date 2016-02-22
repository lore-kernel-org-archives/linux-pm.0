From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/2] cpufreq: governor: Fix race in dbs_update_util_handler()
Date: Mon, 22 Feb 2016 14:14:34 +0100
Message-ID: <5317526.c8CQkS0X5t@vostro.rjw.lan>
References: <2410542.x6e5Rli2VY@vostro.rjw.lan> <2648721.JQxjFin8bu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50010 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751797AbcBVNNF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 08:13:05 -0500
In-Reply-To: <2648721.JQxjFin8bu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a scenario that may lead to undesired results in
dbs_update_util_handler().  Namely, if two CPUs sharing a policy
enter the funtion at the same time, pass the sample delay check
and then one of them is stalled until dbs_work_handler() (queued
up by the other CPU) clears the work counter, it may update the
work counter and queue up another work item prematurely.

To prevent that from happening, use the observation that the CPU
queuing up a work item in dbs_update_util_handler() updates the
last sample time.  This means that if another CPU was stalling after
passing the sample delay check and now successfully updated the work
counter as a result of the race described above, it will see the new
value of the last sample time which is different from what it used in
the sample delay check before.  If that happens, the sample delay
check passed previously is not valid any more, so the CPU should not
continue.

Fixes: f17cbb53783c (cpufreq: governor: Avoid atomic operations in hot paths)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v1:
- Typo in the changelog fixed.
- READ_ONCE() used instead of ACCESS_ONCE().
- If the race is detected, return instead of looping.

---
 drivers/cpufreq/cpufreq_governor.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -341,7 +341,7 @@ static void dbs_update_util_handler(stru
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
-	u64 delta_ns;
+	u64 delta_ns, lst;
 
 	/*
 	 * The work may not be allowed to be queued up right now.
@@ -357,7 +357,8 @@ static void dbs_update_util_handler(stru
 	 * of sample_delay_ns used in the computation may be stale.
 	 */
 	smp_rmb();
-	delta_ns = time - policy_dbs->last_sample_time;
+	lst = READ_ONCE(policy_dbs->last_sample_time);
+	delta_ns = time - lst;
 	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
 		return;
 
@@ -366,9 +367,19 @@ static void dbs_update_util_handler(stru
 	 * at this point.  Otherwise, we need to ensure that only one of the
 	 * CPUs sharing the policy will do that.
 	 */
-	if (policy_dbs->is_shared &&
-	    !atomic_add_unless(&policy_dbs->work_count, 1, 1))
-		return;
+	if (policy_dbs->is_shared) {
+		if (!atomic_add_unless(&policy_dbs->work_count, 1, 1))
+			return;
+
+		/*
+		 * If another CPU updated last_sample_time in the meantime, we
+		 * shouldn't be here, so clear the work counter and bail out.
+		 */
+		if (unlikely(lst != READ_ONCE(policy_dbs->last_sample_time))) {
+			atomic_set(&policy_dbs->work_count, 0);
+			return;
+		}
+	}
 
 	policy_dbs->last_sample_time = time;
 	policy_dbs->work_in_progress = true;

