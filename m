From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 5/7] PM / devfreq: Show the all available frequencies
Date: Mon, 23 Oct 2017 10:32:10 +0900
Message-ID: <1508722332-10628-6-git-send-email-cw00.choi@samsung.com>
References: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171023013215epcas2p1abdf1f948cc704f113d741e08d42a15b@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The commit a76caf55e5b35 ("thermal: Add devfreq cooling") allows
the devfreq device to use the cooling device. When the cooling down
are required, the devfreq_cooling.c disables the OPP entry with
the dev_pm_opp_disable(). In result, 'available_frequencies'[1]
sysfs node never came to show the all available frequencies.
[1] /sys/class/devfreq/.../available_frequencies

So, this patch uses the 'freq_table' in the 'struct devfreq_dev_profile'
in order to show the all available frequencies.
- If 'freq_table' is NULL, devfreq core initializes them by using OPP values.
- If 'freq_table' is initialized, devfreq core just uses the 'freq_table'.

And this patch adds some comment about the sort way of 'freq_table'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c | 16 +++++-----------
 include/linux/devfreq.h   |  5 +++--
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b2920cd2b78e..381f92e5e794 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1194,22 +1194,16 @@ static ssize_t available_frequencies_show(struct device *d,
 					  char *buf)
 {
 	struct devfreq *df = to_devfreq(d);
-	struct device *dev = df->dev.parent;
-	struct dev_pm_opp *opp;
 	ssize_t count = 0;
-	unsigned long freq = 0;
+	int i;
 
-	do {
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp))
-			break;
+	mutex_lock(&df->lock);
 
-		dev_pm_opp_put(opp);
+	for (i = 0; i < df->profile->max_state; i++)
 		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
-				   "%lu ", freq);
-		freq++;
-	} while (1);
+				"%lu ", df->profile->freq_table[i]);
 
+	mutex_unlock(&df->lock);
 	/* Truncate the trailing space */
 	if (count)
 		count--;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 997a9eb34191..19520625ea94 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -84,8 +84,9 @@ struct devfreq_dev_status {
  *			from devfreq_remove_device() call. If the user
  *			has registered devfreq->nb at a notifier-head,
  *			this is the time to unregister it.
- * @freq_table:	Optional list of frequencies to support statistics.
- * @max_state:	The size of freq_table.
+ * @freq_table:		Optional list of frequencies to support statistics
+ *			and freq_table must be generated in ascending order.
+ * @max_state:		The size of freq_table.
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
-- 
1.9.1
