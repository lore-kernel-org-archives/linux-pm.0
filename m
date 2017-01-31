From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/3] PM / devfreq: Fix available_governor sysfs
Date: Tue, 31 Jan 2017 15:38:16 +0900
Message-ID: <1485844699-24582-2-git-send-email-cw00.choi@samsung.com>
References: <1485844699-24582-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170131063825epcas1p4e55c3911b0a57df5c17a2fcf4b5819ef@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1485844699-24582-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devfreq using passive governor is not able to change the governor.
So, the user can not change the governor through 'available_governor' sysfs
entry. Also, the devfreq which don't use the passive governor is not able to
change to 'passive' governor on the fly.

Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")
Cc: stable@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c          | 31 +++++++++++++++++++++++++++----
 drivers/devfreq/governor_passive.c |  1 +
 include/linux/devfreq.h            |  3 +++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8e5938c9c7d6..ade279d29f1e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -940,6 +940,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
+	} else if (df->governor->immutable || governor->immutable) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (df->governor) {
@@ -969,13 +972,33 @@ static ssize_t available_governors_show(struct device *d,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct devfreq_governor *tmp_governor;
+	struct devfreq *df = to_devfreq(d);
 	ssize_t count = 0;
 
 	mutex_lock(&devfreq_list_lock);
-	list_for_each_entry(tmp_governor, &devfreq_governor_list, node)
-		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
-				   "%s ", tmp_governor->name);
+
+	/*
+	 * The devfreq with immutable governor (e.g., passive) shows
+	 * only own governor.
+	 */
+	if (df->governor->immutable) {
+		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
+				   "%s ", df->governor_name);
+	/*
+	 * The devfreq device shows the registered governor except for
+	 * immutable governors such as passive governor .
+	 */
+	} else {
+		struct devfreq_governor *governor;
+
+		list_for_each_entry(governor, &devfreq_governor_list, node) {
+			if (governor->immutable)
+				continue;
+			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
+					   "%s ", governor->name);
+		}
+	}
+
 	mutex_unlock(&devfreq_list_lock);
 
 	/* Truncate the trailing space */
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 9ef46e2592c4..93795b32dc09 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -179,6 +179,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = "passive",
+	.immutable = 1,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
 };
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2de4e2eea180..e0acb0e5243b 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -104,6 +104,8 @@ struct devfreq_dev_profile {
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
+ * @immutable:		Immutable flag for governor. If the value is 1,
+ *			this govenror is never changeable to other governor.
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -121,6 +123,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
+	const unsigned int immutable;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
-- 
1.9.1
