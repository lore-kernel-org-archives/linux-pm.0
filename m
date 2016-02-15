From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/9] cpufreq: governor: Simplify gov_cancel_work() slightly
Date: Mon, 15 Feb 2016 02:12:56 +0100
Message-ID: <1696919.WxyrSFSFde@vostro.rjw.lan>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3329748.lhJgppdTt9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The atomic work counter incrementation in gov_cancel_work() is not
necessary any more, because work items won't be queued up after
gov_clear_update_util() anyway, so drop it along with the comment
about how it may be missed by the gov_clear_update_util().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new version of https://patchwork.kernel.org/patch/8291021/ .

Changes from the previous version:
- Rebase.

---
 drivers/cpufreq/cpufreq_governor.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -300,13 +300,6 @@ static void gov_cancel_work(struct cpufr
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
-	/* Tell dbs_update_util_handler() to skip queuing up work items. */
-	atomic_inc(&policy_dbs->work_count);
-	/*
-	 * If dbs_update_util_handler() is already running, it may not notice
-	 * the incremented work_count, so wait for it to complete to prevent its
-	 * work item from being queued up after the cancel_work_sync() below.
-	 */
 	gov_clear_update_util(policy_dbs->policy);
 	irq_work_sync(&policy_dbs->irq_work);
 	cancel_work_sync(&policy_dbs->work);
@@ -369,7 +362,6 @@ static void dbs_update_util_handler(stru
 	 * The work may not be allowed to be queued up right now.
 	 * Possible reasons:
 	 * - Work has already been queued up or is in progress.
-	 * - The governor is being stopped.
 	 * - It is too early (too little time from the previous sample).
 	 */
 	if (atomic_inc_return(&policy_dbs->work_count) == 1) {
