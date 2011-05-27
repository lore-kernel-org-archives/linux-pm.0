From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 2/3] PM / DEVFREQ: add example governors
Date: Fri, 27 May 2011 13:53:14 +0900
Message-ID: <1306471995-4048-2-git-send-email-myungjoo.ham__42236.5512968556$1306472069$gmane$org@samsung.com>
References: <1306471995-4048-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1306471995-4048-1-git-send-email-myungjoo.ham@samsung.com>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Three CPUFREQ-like governors are provided as examples.

powersave: use the lowest frequency possible. The user (device) should
set the polling_ms as 0 because polling is useless for this governor.

performance: use the highest freqeuncy possible. The user (device)
should set the polling_ms as 0 because polling is useless for this
governor.

simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.

When a user updates OPP entries (enable/disable/add), OPP framework
automatically notifies DEVFREQ to update operating frequency
accordingly. Thus, DEVFREQ users (device drivers) do not need to update
DEVFREQ manually with OPP entry updates or set polling_ms for powersave
, performance, or any other "static" governors.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/base/power/devfreq.c |   69 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h      |    5 +++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/devfreq.c b/drivers/base/power/devfreq.c
index 883d953..7648a94 100644
--- a/drivers/base/power/devfreq.c
+++ b/drivers/base/power/devfreq.c
@@ -395,3 +395,72 @@ static int __init devfreq_init(void)
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
+	.get_target_freq = devfreq_performance_func,
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
+	a = (unsigned long long) stat.busy_time * stat.current_frequency;
+	b = div_u64(a, stat.total_time);
+	b *= 100;
+	b = div_u64(b, (DFSO_UPTHRESHOLD - DFSO_DOWNDIFFERENCTIAL / 2));
+	*freq = (unsigned long) b;
+
+	return 0;
+}
+
+struct devfreq_governor devfreq_simple_ondemand = {
+	.get_target_freq = devfreq_simple_ondemand_func,
+};
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 59c8bda..1ec9a40 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -81,6 +81,11 @@ extern int devfreq_add_device(struct device *dev,
 extern int devfreq_remove_device(struct device *dev);
 extern int devfreq_update(struct device *dev);
 extern int devfreq_tickle_device(struct device *dev, unsigned long duration_ms);
+
+extern struct devfreq_governor devfreq_powersave;
+extern struct devfreq_governor devfreq_performance;
+extern struct devfreq_governor devfreq_simple_ondemand;
+
 #else /* !CONFIG_PM_DEVFREQ */
 static int devfreq_add_device(struct device *dev,
 			   struct devfreq_dev_profile *profile,
-- 
1.7.4.1
