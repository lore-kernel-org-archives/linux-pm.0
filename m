From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/10] thermal: Rename generate_netlink_event
Date: Mon, 23 Jan 2012 20:30:06 -0500
Message-ID: <2d58d7ea9164da59d0ea82fdf80e3ababe52d58c.1327368464.git.len.brown@intel.com>
References: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1327368609-28409-1-git-send-email-lenb@kernel.org>
In-reply-to: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
References: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

It doesn't seem right for the thermal subsystem to export a symbol
named generate_netlink_event. This function is thermal-specific and
its name should reflect that fact. Rename it to
thermal_generate_netlink_event.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: R.Durgadoss <durgadoss.r@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |    2 +-
 drivers/thermal/thermal_sys.c       |    4 ++--
 include/linux/thermal.h             |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index b61e46f..1733ab9 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -284,7 +284,7 @@ method, the sys I/F structure will be built like this:
 The framework includes a simple notification mechanism, in the form of a
 netlink event. Netlink socket initialization is done during the _init_
 of the framework. Drivers which intend to use the notification mechanism
-just need to call generate_netlink_event() with two arguments viz
+just need to call thermal_generate_netlink_event() with two arguments viz
 (originator, event). Typically the originator will be an integer assigned
 to a thermal_zone_device when it registers itself with the framework. The
 event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index dd9a574..220ce7e 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1304,7 +1304,7 @@ static struct genl_multicast_group thermal_event_mcgrp = {
 	.name = THERMAL_GENL_MCAST_GROUP_NAME,
 };
 
-int generate_netlink_event(u32 orig, enum events event)
+int thermal_generate_netlink_event(u32 orig, enum events event)
 {
 	struct sk_buff *skb;
 	struct nlattr *attr;
@@ -1363,7 +1363,7 @@ int generate_netlink_event(u32 orig, enum events event)
 
 	return result;
 }
-EXPORT_SYMBOL(generate_netlink_event);
+EXPORT_SYMBOL(thermal_generate_netlink_event);
 
 static int genetlink_init(void)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 47b4a27..796f1ff 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -152,9 +152,9 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 
 #ifdef CONFIG_NET
-extern int generate_netlink_event(u32 orig, enum events event);
+extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-static inline int generate_netlink_event(u32 orig, enum events event)
+static inline int thermal_generate_netlink_event(u32 orig, enum events event)
 {
 	return 0;
 }
-- 
1.7.9.rc2

