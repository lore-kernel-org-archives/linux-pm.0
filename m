From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH v4] PM / devfreq: Add possible_frequencies device attribute
Date: Fri, 18 Jul 2014 17:15:58 -0700
Message-ID: <1405728958-619-1-git-send-email-skannan@codeaurora.org>
References: <725805840.101171405558256488.JavaMail.weblogic@epmlwas01c>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <725805840.101171405558256488.JavaMail.weblogic@epmlwas01c>
Sender: linux-arm-msm-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Some devices use freq_table instead of OPP. For those devices, the
available_frequencies sysfs file shows up empty. So, add a
possible_frequencies attribute/syfs file that list all the possible
frequencies.

For devices that use OPP, the output of this file will match
available_frequencies. It may change in the future to show all OPP
frequencies -- even the disabled ones.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 15 +++++++++++++++
 drivers/devfreq/devfreq.c                     | 26 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index ee39aca..a461e67 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -72,6 +72,21 @@ Description:
 		This is a snapshot of available frequencies and not limited
 		by the min/max frequency restrictions.
 
+What:		/sys/class/devfreq/.../possible_frequencies
+Date:		July 2014
+Contact:	Saravana Kannan <skannan@codeaurora.org>
+Description:
+		The /sys/class/devfreq/.../possible_frequencies shows
+		the possible frequencies of the corresponding devfreq object.
+		This is a snapshot of possible frequencies and not limited by
+		the min/max frequency restrictions. Unlike
+		available_frequencies, this is also does not require the
+		devfreq device to use OPP for listing its possible
+		frequencies. When OPP is used, this behaves the same way as
+		available_frequencies. It maybe improved in the future to
+		list all possible OPP frequencies even if some of them are
+		disabled at run-time.
+
 What:		/sys/class/devfreq/.../available_governors
 Date:		October 2012
 Contact:	Nishanth Menon <nm@ti.com>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9f90369..65eed38 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -994,6 +994,31 @@ static ssize_t available_frequencies_show(struct device *d,
 }
 static DEVICE_ATTR_RO(available_frequencies);
 
+static ssize_t possible_frequencies_show(struct device *d,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct devfreq *df = to_devfreq(d);
+	unsigned int i = 0;
+	ssize_t count = 0;
+
+	if (!df->profile->freq_table)
+		return available_frequencies_show(d, attr, buf);
+
+	for (i = 0; i < df->profile->max_state; i++)
+		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
+				   "%u ", df->profile->freq_table[i]);
+
+	/* Truncate the trailing space */
+	if (count)
+		count--;
+
+	count += sprintf(&buf[count], "\n");
+
+	return count;
+}
+static DEVICE_ATTR_RO(possible_frequencies);
+
 static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -1041,6 +1066,7 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_available_governors.attr,
 	&dev_attr_cur_freq.attr,
 	&dev_attr_available_frequencies.attr,
+	&dev_attr_possible_frequencies.attr,
 	&dev_attr_target_freq.attr,
 	&dev_attr_polling_interval.attr,
 	&dev_attr_min_freq.attr,
-- 
1.8.2.1

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
