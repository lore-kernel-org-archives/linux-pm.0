From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/9] cpufreq: governor: Reset sample delay in store_sampling_rate()
Date: Mon, 15 Feb 2016 02:20:11 +0100
Message-ID: <2770889.gQMC67V8WG@vostro.rjw.lan>
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

If store_sampling_rate() updates the sample delay when the ondemand
governor is in the middle of its high/low dance (OD_SUB_SAMPLE sample
type is set), the governor will still do the bottom half of the
previous sample which may take too much time.

To prevent that from happening, change store_sampling_rate() to always
reset the sample delay to 0 which also is consistent with the new
behavior of cpufreq_governor_limits().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -38,10 +38,6 @@ EXPORT_SYMBOL_GPL(dbs_data_mutex);
  * reducing the sampling rate, we need to make the new value effective
  * immediately.
  *
- * On the other hand, if new rate is larger than the old, then we may evaluate
- * the load too soon, and it might we worth updating sample_delay_ns then as
- * well.
- *
  * This must be called with dbs_data->mutex held, otherwise traversing
  * policy_dbs_list isn't safe.
  */
@@ -69,18 +65,14 @@ ssize_t store_sampling_rate(struct dbs_d
 		 * really doesn't matter.  If the read returns a value that's
 		 * too big, the sample will be skipped, but the next invocation
 		 * of dbs_update_util_handler() (when the update has been
-		 * completed) will take a sample.  If the returned value is too
-		 * small, the sample will be taken immediately, but that isn't a
-		 * problem, as we want the new rate to take effect immediately
-		 * anyway.
+		 * completed) will take a sample.
 		 *
 		 * If this runs in parallel with dbs_work_handler(), we may end
 		 * up overwriting the sample_delay_ns value that it has just
-		 * written, but the difference should not be too big and it will
-		 * be corrected next time a sample is taken, so it shouldn't be
-		 * significant.
+		 * written, but it will be corrected next time a sample is
+		 * taken, so it shouldn't be significant.
 		 */
-		gov_update_sample_delay(policy_dbs, dbs_data->sampling_rate);
+		gov_update_sample_delay(policy_dbs, 0);
 		mutex_unlock(&policy_dbs->timer_mutex);
 	}
 
