From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] PM / devfreq: Add new name attribute for sysfs
Date: Wed, 29 Aug 2018 16:34:06 +0900
Message-ID: <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
sysfs") changed the node name to devfreq(x). After this commit, it is not
possible to get the device name through /sys/class/devfreq/devfreq(X)/*.

Add new name attribute in order to get device name.

Cc: stable@vger.kernel.org
Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 11 +++++++++++
 include/linux/devfreq.h   |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1330b5..2145563d5ee5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;

+	devfreq->name = dev_name(devfreq->dev.parent);
+	if (IS_ERR_OR_NULL(devfreq->name))
+		return -EINVAL;
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -1261,6 +1264,13 @@ static ssize_t trans_stat_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(trans_stat);

+static ssize_t name_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_devfreq(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_governor.attr,
 	&dev_attr_available_governors.attr,
@@ -1271,6 +1281,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
+	&dev_attr_name.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3aae5b3af87c..f79b5a666102 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -111,6 +111,7 @@ struct devfreq_dev_profile {

 /**
  * struct devfreq - Device devfreq structure
+ * @name:	name of the device
  * @node:	list node - contains the devices with devfreq that have been
  *		registered.
  * @lock:	a mutex to protect accessing devfreq.
@@ -146,6 +147,8 @@ struct devfreq_dev_profile {
  * to protect its own private data in void *data as well.
  */
 struct devfreq {
+	const char *name;
+
 	struct list_head node;

 	struct mutex lock;
