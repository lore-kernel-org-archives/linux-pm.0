From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 1/8] PM / devfreq: Set min/max_freq when adding the
 devfreq device
Date: Fri, 13 Oct 2017 16:48:17 +0900
Message-ID: <1507880904-31956-2-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171013074831epcas2p2d9120a18f746f2831057a1da1977394a@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Prior to that, the min/max_freq of the devfreq device are always zero
before the user changes the min/max_freq through sysfs entries.
It might make the confusion for the min/max_freq.

This patch initializes the available min/max_freq by using the OPP
during adding the devfreq device.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a1c4ee818614..6a6f88bccdee 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -69,6 +69,34 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+static unsigned long find_available_min_freq(struct devfreq *devfreq)
+{
+	struct dev_pm_opp *opp;
+	unsigned long min_freq = 0;
+
+	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
+	if (IS_ERR(opp))
+		min_freq = 0;
+	else
+		dev_pm_opp_put(opp);
+
+	return min_freq;
+}
+
+static unsigned long find_available_max_freq(struct devfreq *devfreq)
+{
+	struct dev_pm_opp *opp;
+	unsigned long max_freq = ULONG_MAX;
+
+	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
+	if (IS_ERR(opp))
+		max_freq = 0;
+	else
+		dev_pm_opp_put(opp);
+
+	return max_freq;
+}
+
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
@@ -559,6 +587,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
+	devfreq->min_freq = find_available_min_freq(devfreq);
+	if (!devfreq->min_freq) {
+		mutex_unlock(&devfreq->lock);
+		err = -EINVAL;
+		goto err_dev;
+	}
+
+	devfreq->max_freq = find_available_max_freq(devfreq);
+	if (!devfreq->max_freq) {
+		mutex_unlock(&devfreq->lock);
+		err = -EINVAL;
+		goto err_dev;
+	}
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
-- 
1.9.1
