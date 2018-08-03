From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 1/3] PM / devfreq: Fix handling of min/max_freq == 0
Date: Fri,  3 Aug 2018 13:05:09 -0700
Message-ID: <20180803200511.189664-2-mka@chromium.org>
References: <20180803200511.189664-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803200511.189664-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
devfreq device") initializes df->min/max_freq with the min/max OPP when
the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
available min/max frequency") adds df->scaling_min/max_freq and the
following to the frequency adjustment code:

  max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);

With the current handling of min/max_freq this is incorrect:

Even though df->max_freq is now initialized to a value != 0 user space
can still set it to 0, in this case max_freq would be 0 instead of
df->scaling_max_freq as intended. In consequence the frequency adjustment
is not performed:

  if (max_freq && freq > max_freq) {
	freq = max_freq;

To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
when the user passes a value of 0. This also prevents df->max_freq from
being set below the min OPP when df->min_freq is 0, and similar for
min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
checks for this case can be removed.

Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes in v6:
- min/max_freq_store(): updated comment about sorting order of
  frequency table
- min/max_freq_store(): moved declaration of 'freq_table' into the
  block that uses it
- added 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>' tag

Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- handle freq tables sorted in ascending and descending order in
  min/max_freq_store()
- use same order for conditional statements in min/max_freq_store()
---
 drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1330b5..772e8aab1627 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
 	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
 	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
 
-	if (min_freq && freq < min_freq) {
+	if (freq < min_freq) {
 		freq = min_freq;
 		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
 	}
-	if (max_freq && freq > max_freq) {
+	if (freq > max_freq) {
 		freq = max_freq;
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
@@ -1126,17 +1126,26 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long value;
 	int ret;
-	unsigned long max;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
-	max = df->max_freq;
-	if (value && max && value > max) {
-		ret = -EINVAL;
-		goto unlock;
+
+	if (value) {
+		if (value > df->max_freq) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	} else {
+		unsigned long *freq_table = df->profile->freq_table;
+
+		/* Get minimum frequency according to sorting order */
+		if (freq_table[0] < freq_table[df->profile->max_state - 1])
+			value = freq_table[0];
+		else
+			value = freq_table[df->profile->max_state - 1];
 	}
 
 	df->min_freq = value;
@@ -1161,17 +1170,26 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long value;
 	int ret;
-	unsigned long min;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
-	min = df->min_freq;
-	if (value && min && value < min) {
-		ret = -EINVAL;
-		goto unlock;
+
+	if (value) {
+		if (value < df->min_freq) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	} else {
+		unsigned long *freq_table = df->profile->freq_table;
+
+		/* Get maximum frequency according to sorting order */
+		if (freq_table[0] < freq_table[df->profile->max_state - 1])
+			value = freq_table[df->profile->max_state - 1];
+		else
+			value = freq_table[0];
 	}
 
 	df->max_freq = value;
-- 
2.18.0.597.ga71716f1ad-goog
