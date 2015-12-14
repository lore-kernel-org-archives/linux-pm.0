From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 07/20] PM / devfreq: Show the related information according
 to governor type
Date: Mon, 14 Dec 2015 15:38:11 +0900
Message-ID: <1450075104-13705-8-git-send-email-cw00.choi@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch modifies the following sysfs entry of DEVFREQ framework
because the devfreq device using passive governor don't need the same
information of the devfreq device using rest governor.
- polling_interval    : passive gov don't use the sampling rate.
- available_governors : passive gov don't be changed on runtime in this version.
- trans_stat          : passive governor don't support trans_stat in this version.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
[linux.amoon: Tested on Odroid U3]
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/devfreq/devfreq.c                 | 31 +++++++++++++++++++++++++------
 drivers/devfreq/governor.h                |  7 +++++++
 drivers/devfreq/governor_passive.c        |  1 +
 drivers/devfreq/governor_performance.c    |  1 +
 drivers/devfreq/governor_powersave.c      |  1 +
 drivers/devfreq/governor_simpleondemand.c |  1 +
 drivers/devfreq/governor_userspace.c      |  1 +
 include/linux/devfreq.h                   |  2 ++
 8 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 78ea4cdaa82c..18ad956fec93 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -597,7 +597,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
-	if (!strncmp(devfreq->governor_name, "passive", 7)) {
+	if (devfreq->governor->type == DEVFREQ_GOV_PASSIVE) {
 		struct devfreq *parent_devfreq =
 			((struct devfreq_passive_data *)data)->parent;
 
@@ -963,13 +963,23 @@ static ssize_t available_governors_show(struct device *d,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct devfreq_governor *tmp_governor;
+	struct devfreq *devfreq = to_devfreq(d);
 	ssize_t count = 0;
 
 	mutex_lock(&devfreq_list_lock);
-	list_for_each_entry(tmp_governor, &devfreq_governor_list, node)
+	if (devfreq->governor->type == DEVFREQ_GOV_PASSIVE) {
 		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
-				   "%s ", tmp_governor->name);
+					   "%s ", devfreq->governor->name);
+	} else {
+		struct devfreq_governor *tmp_governor;
+
+		list_for_each_entry(tmp_governor, &devfreq_governor_list, node) {
+			if (tmp_governor->type == DEVFREQ_GOV_PASSIVE)
+				continue;
+			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
+					   "%s ", tmp_governor->name);
+		}
+	}
 	mutex_unlock(&devfreq_list_lock);
 
 	/* Truncate the trailing space */
@@ -1006,6 +1016,11 @@ static DEVICE_ATTR_RO(target_freq);
 static ssize_t polling_interval_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
+	struct devfreq *df = to_devfreq(dev);
+
+	if (df->governor->type == DEVFREQ_GOV_PASSIVE)
+		return sprintf(buf, "Not Supported.\n");
+
 	return sprintf(buf, "%d\n", to_devfreq(dev)->profile->polling_ms);
 }
 
@@ -1020,6 +1035,9 @@ static ssize_t polling_interval_store(struct device *dev,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (df->governor->type == DEVFREQ_GOV_PASSIVE)
+		return -EINVAL;
+
 	ret = sscanf(buf, "%u", &value);
 	if (ret != 1)
 		return -EINVAL;
@@ -1137,11 +1155,12 @@ static ssize_t trans_stat_show(struct device *dev,
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
+	if (max_state == 0 || devfreq->governor->type == DEVFREQ_GOV_PASSIVE)
+		return sprintf(buf, "Not Supported.\n");
+
 	if (!devfreq->stop_polling &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
 		return 0;
-	if (max_state == 0)
-		return sprintf(buf, "Not Supported.\n");
 
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index fad7d6321978..43513a58f5bf 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -18,6 +18,13 @@
 
 #define to_devfreq(DEV)	container_of((DEV), struct devfreq, dev)
 
+/* Devfreq governor type */
+#define DEVFREQ_GOV_ONDEMAND			0x1
+#define DEVFREQ_GOV_PERFORMANCE			0x2
+#define DEVFREQ_GOV_POWERSAVE			0x3
+#define DEVFREQ_GOV_USERSPACE			0x4
+#define DEVFREQ_GOV_PASSIVE			0x4
+
 /* Devfreq events */
 #define DEVFREQ_GOV_START			0x1
 #define DEVFREQ_GOV_STOP			0x2
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 7443ae4b92f9..adfdee9a9cd1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -81,6 +81,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = "passive",
+	.type = DEVFREQ_GOV_PASSIVE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
 };
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index c72f942f30a8..594d8ecb13fb 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -43,6 +43,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_performance = {
 	.name = "performance",
+	.type = DEVFREQ_GOV_PERFORMANCE,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 0c6bed567e6d..e2817e1f2a31 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -40,6 +40,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_powersave = {
 	.name = "powersave",
+	.type = DEVFREQ_GOV_POWERSAVE,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5e78df..b905a535d486 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -126,6 +126,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = "simple_ondemand",
+	.type = DEVFREQ_GOV_ONDEMAND,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 35de6e83c1fe..c78ab78a5220 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -138,6 +138,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_userspace = {
 	.name = "userspace",
+	.type = DEVFREQ_GOV_USERSPACE,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index cf972befca2b..64a9a0fe3d7e 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -97,6 +97,7 @@ struct devfreq_dev_profile {
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
+ * @type:		Governor's type
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -114,6 +115,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
+	const int type;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
-- 
1.9.1
