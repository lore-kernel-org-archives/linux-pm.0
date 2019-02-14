From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Date: Wed, 13 Feb 2019 17:30:41 -0800
Message-ID: <20190214013042.254790-4-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The following pattern is repeated multiple times:

- call governor event handler with DEVFREQ_GOV_START/STOP
- check return value
- in case of error log a message

Add devfreq_governor_start/stop() helper functions with this code
and call them instead.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 96 +++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7fab6c4cf719b..eb86461648d74 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -580,6 +580,53 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	return ret;
 }
 
+/**
+ * devfreq_governor_start() - Start the devfreq governor of the device.
+ * @devfreq:	the devfreq instance
+ */
+static int devfreq_governor_start(struct devfreq *devfreq)
+{
+	struct device *dev = devfreq->dev.parent;
+	int err;
+
+	if (WARN(mutex_is_locked(&devfreq->lock),
+		 "mutex must *not* be held by the caller\n"))
+		return -EINVAL;
+
+	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
+					       NULL);
+	if (err) {
+		dev_err(dev, "Governor %s not started: %d\n",
+			devfreq->governor->name, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * devfreq_governor_stop() - Stop the devfreq governor of the device.
+ * @devfreq:	the devfreq instance
+ */
+static int devfreq_governor_stop(struct devfreq *devfreq)
+{
+	struct device *dev = devfreq->dev.parent;
+	int err;
+
+	if (WARN(mutex_is_locked(&devfreq->lock),
+		 "mutex must *not* be held by the caller\n"))
+		return -EINVAL;
+
+	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STOP, NULL);
+	if (err) {
+		dev_warn(dev, "%s: Governor %s not stopped: %d\n",
+			 devfreq->governor->name, err);
+		return err;
+	}
+
+	return 0;
+}
+
 /**
  * devfreq_dev_release() - Callback for struct device to release the device.
  * @dev:	the devfreq device
@@ -720,13 +767,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->governor = governor;
-	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
-						NULL);
-	if (err) {
-		dev_err(dev, "%s: Unable to start governor for the device\n",
-			__func__);
+	err = devfreq_governor_start(devfreq);
+	if (err)
 		goto err_init;
-	}
 
 	list_add(&devfreq->node, &devfreq_list);
 
@@ -1029,24 +1072,13 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 				dev_warn(dev,
 					 "%s: Governor %s already present\n",
 					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
-							DEVFREQ_GOV_STOP, NULL);
-				if (ret) {
-					dev_warn(dev,
-						 "%s: Governor %s stop = %d\n",
-						 __func__,
-						 devfreq->governor->name, ret);
-				}
+				ret = devfreq_governor_stop(devfreq);
+
 				/* Fall through */
 			}
+
 			devfreq->governor = governor;
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_START, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s start=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
+			devfreq_governor_start(devfreq);
 		}
 	}
 
@@ -1081,7 +1113,6 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		goto err_out;
 	}
 	list_for_each_entry(devfreq, &devfreq_list, node) {
-		int ret;
 		struct device *dev = devfreq->dev.parent;
 
 		if (!strncmp(devfreq->governor_name, governor->name,
@@ -1093,13 +1124,8 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 				continue;
 				/* Fall through */
 			}
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_STOP, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s stop=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
+
+			devfreq_governor_stop(devfreq);
 			devfreq->governor = NULL;
 		}
 	}
@@ -1149,19 +1175,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (df->governor) {
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
-		if (ret) {
-			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-				 __func__, df->governor->name, ret);
+		ret = devfreq_governor_stop(df);
+		if (ret)
 			goto out;
-		}
 	}
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret)
-		dev_warn(dev, "%s: Governor %s not started(%d)\n",
-			 __func__, df->governor->name, ret);
+	ret = devfreq_governor_start(df);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
2.20.1.791.gb4d0f1c61a-goog
