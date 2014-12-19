From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH RESEND v2 10/10] power: charger-manager: Support to change
 polling rate in runtime.
Date: Fri, 19 Dec 2014 11:47:30 +0900
Message-ID: <1418957250-6542-11-git-send-email-jonghwa3.lee@samsung.com>
References: <1418957250-6542-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418957250-6542-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add 'polling_ms' sysfs node to change charger-manager's monitoring rate
in runtime. It can set only bigger than 2 jiffies (for 200 HZ system it
is 10 msecs.) as it's allowed for minimum poling rate in previous.
It resets poller and re-configure polling rate based on new input if next
polling time is far enough. Otherwise, it just waits expiration of timer
and new polling rate will affects the next scheduling.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 0a0834f..7a007f4 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1054,6 +1054,63 @@ static ssize_t charger_externally_control_store(struct device *dev,
 	return count;
 }
 
+static ssize_t show_polling_ms(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct charger_manager *cm;
+	ssize_t len;
+
+	list_for_each_entry(cm, &cm_list, entry)
+		if (cm->charger_psy.dev == dev)
+			break;
+
+	if (cm->charger_psy.dev != dev)
+		return -EINVAL;
+
+	len = sprintf(buf, "%d\n", cm->desc->polling_interval_ms);
+
+	return len;
+}
+
+static ssize_t store_polling_ms(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct charger_manager *cm;
+	int polling_ms;
+	int ret;
+
+	ret = sscanf(buf, "%d", &polling_ms);
+	if (ret < 0 )
+		return -EINVAL;
+
+	if (polling_ms < CM_JIFFIES_SMALL * MSEC_PER_SEC / HZ)
+		return -EINVAL;
+
+	list_for_each_entry(cm, &cm_list, entry)
+		if (cm->charger_psy.dev == dev)
+			break;
+
+	if (cm->charger_psy.dev != dev)
+		return -ENODEV;
+
+	cm->desc->polling_interval_ms = polling_ms;
+
+	pr_info("Polling interval's changed to %u ms.\n",
+		cm->desc->polling_interval_ms);
+
+	if (next_polling - jiffies >
+		msecs_to_jiffies(cm->desc->polling_interval_ms)) {
+		pr_info("Reset poller now... \n");
+		cancel_delayed_work(&cm_monitor_work);
+		schedule_work(&setup_polling);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(polling_ms, 0644, show_polling_ms, store_polling_ms);
+
 /**
  * charger_manager_register_sysfs - Register sysfs entry for each charger
  * @cm: the Charger Manager representing the battery.
@@ -1077,6 +1134,11 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	int ret = 0;
 	int i;
 
+	/* Create polling_ms sysfs node */
+	ret = device_create_file(cm->charger_psy.dev, &dev_attr_polling_ms);
+	if (ret)
+		pr_err("Failed to create poling_ms sysfs node (%d)\n", ret);
+
 	/* Create sysfs entry to control charger(regulator) */
 	for (i = 0; i < desc->num_charger_regulators; i++) {
 		charger = &desc->charger_regulators[i];
-- 
1.7.9.5
