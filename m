From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v5 2/3] PM / DEVFREQ: add basic governors
Date: Mon, 08 Aug 2011 18:03:07 +0900
Message-ID: <1312794188-9823-3-git-send-email-myungjoo.ham@samsung.com>
References: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Four CPUFREQ-like governors are provided as examples.

powersave: use the lowest frequency possible. The user (device) should
set the polling_ms as 0 because polling is useless for this governor.

performance: use the highest freqeuncy possible. The user (device)
should set the polling_ms as 0 because polling is useless for this
governor.

userspace: use the user specified frequency stored at
devfreq.user_set_freq. With sysfs support in the following patch, a user
may set the value with the sysfs interface.

simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.

When a user updates OPP entries (enable/disable/add), OPP framework
automatically notifies DEVFREQ to update operating frequency
accordingly. Thus, DEVFREQ users (device drivers) do not need to update
DEVFREQ manually with OPP entry updates or set polling_ms for powersave
, performance, userspace, or any other "static" governors.

Note that these are given only as basic examples for governors and any
devices with DEVFREQ may implement their own governors with the drivers
and use them.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
Changes from v4:
- Added userspace governor

Changes from v3:
- Bugfixes on simple-ondemand governor (divide by zero / overflow)
- Style fixes
- Give names to governors
---
 drivers/base/power/devfreq.c |  100 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h      |    8 +++
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/devfreq.c b/drivers/base/power/devfreq.c
index 6f4bd3a..c53bca9 100644
--- a/drivers/base/power/devfreq.c
+++ b/drivers/base/power/devfreq.c
@@ -301,3 +301,103 @@ static int __init devfreq_init(void)
 	return 0;
 }
 late_initcall(devfreq_init);
+
+static int devfreq_powersave_func(struct devfreq *df,
+				  unsigned long *freq)
+{
+	*freq = 0; /* devfreq_do will run "ceiling" to 0 */
+	return 0;
+}
+
+struct devfreq_governor devfreq_powersave = {
+	.name = "powersave",
+	.get_target_freq = devfreq_powersave_func,
+};
+
+static int devfreq_performance_func(struct devfreq *df,
+				    unsigned long *freq)
+{
+	*freq = UINT_MAX; /* devfreq_do will run "floor" */
+	return 0;
+}
+
+struct devfreq_governor devfreq_performance = {
+	.name = "performance",
+	.get_target_freq = devfreq_performance_func,
+};
+
+static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
+{
+	if (df->user_set_freq == 0)
+		*freq = df->previous_freq; /* No user freq specified yet */
+	else
+		*freq = df->user_set_freq;
+
+	return 0;
+}
+
+struct devfreq_governor devfreq_userspace = {
+	.name = "userspace",
+	.get_target_freq = devfreq_userspace_func,
+};
+
+/* Constants for DevFreq-Simple-Ondemand (DFSO) */
+#define DFSO_UPTHRESHOLD	(90)
+#define DFSO_DOWNDIFFERENCTIAL	(5)
+static int devfreq_simple_ondemand_func(struct devfreq *df,
+					unsigned long *freq)
+{
+	struct devfreq_dev_status stat;
+	int err = df->profile->get_dev_status(df->dev, &stat);
+	unsigned long long a, b;
+
+	if (err)
+		return err;
+
+	/* Assume MAX if it is going to be divided by zero */
+	if (stat.total_time == 0) {
+		*freq = UINT_MAX;
+		return 0;
+	}
+
+	/* Prevent overflow */
+	if (stat.busy_time >= (1 << 24) || stat.total_time >= (1 << 24)) {
+		stat.busy_time >>= 7;
+		stat.total_time >>= 7;
+	}
+
+	/* Set MAX if it's busy enough */
+	if (stat.busy_time * 100 >
+	    stat.total_time * DFSO_UPTHRESHOLD) {
+		*freq = UINT_MAX;
+		return 0;
+	}
+
+	/* Set MAX if we do not know the initial frequency */
+	if (stat.current_frequency == 0) {
+		*freq = UINT_MAX;
+		return 0;
+	}
+
+	/* Keep the current frequency */
+	if (stat.busy_time * 100 >
+	    stat.total_time * (DFSO_UPTHRESHOLD - DFSO_DOWNDIFFERENCTIAL)) {
+		*freq = stat.current_frequency;
+		return 0;
+	}
+
+	/* Set the desired frequency based on the load */
+	a = stat.busy_time;
+	a *= stat.current_frequency;
+	b = div_u64(a, stat.total_time);
+	b *= 100;
+	b = div_u64(b, (DFSO_UPTHRESHOLD - DFSO_DOWNDIFFERENCTIAL / 2));
+	*freq = (unsigned long) b;
+
+	return 0;
+}
+
+struct devfreq_governor devfreq_simple_ondemand = {
+	.name = "simple_ondemand",
+	.get_target_freq = devfreq_simple_ondemand_func,
+};
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 6ec630b..7131d2a 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -57,6 +57,8 @@ struct devfreq_governor {
  * @next_polling	the number of remaining "devfreq_monitor" executions to
  *			reevaluate frequency/voltage of the device. Set by
  *			profile's polling_ms interval.
+ * @user_set_freq	User specified adequete frequency value (thru sysfs
+ *		interface). Governors may and may not use this value.
  * @data	Private data of the governor. The devfreq framework does not
  *		touch this.
  *
@@ -72,6 +74,7 @@ struct devfreq {
 	unsigned long previous_freq;
 	unsigned int next_polling;
 
+	unsigned long user_set_freq; /* governors may ignore this. */
 	void *data; /* private data for governors */
 };
 
@@ -81,6 +84,11 @@ extern int devfreq_add_device(struct device *dev,
 			   struct devfreq_governor *governor);
 extern int devfreq_remove_device(struct device *dev);
 extern int devfreq_update(struct device *dev);
+
+extern struct devfreq_governor devfreq_powersave;
+extern struct devfreq_governor devfreq_performance;
+extern struct devfreq_governor devfreq_userspace;
+extern struct devfreq_governor devfreq_simple_ondemand;
 #else /* !CONFIG_PM_DEVFREQ */
 static int devfreq_add_device(struct device *dev,
 			   struct devfreq_dev_profile *profile,
-- 
1.7.4.1
