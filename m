From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC] [PATCH 1/4] thermal: Use thermal zone device id in
	netlink messages
Date: Tue, 12 Jun 2012 16:25:16 +0300
Message-ID: <1339507519-14434-2-git-send-email-eduardo.valentin@ti.com>
References: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rui.zhang@intel.com, durgadoss.r@intel.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This patch changes the function thermal_generate_netlink_event
to receive a thermal zone device instead of a originator id.

This way, the messages will always be bound to a thermal zone.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 Documentation/thermal/sysfs-api.txt |    5 +++--
 drivers/thermal/thermal_sys.c       |    8 ++++++--
 include/linux/thermal.h             |    6 ++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 1733ab9..670644a 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -285,8 +285,9 @@ The framework includes a simple notification mechanism, in the form of a
 netlink event. Netlink socket initialization is done during the _init_
 of the framework. Drivers which intend to use the notification mechanism
 just need to call thermal_generate_netlink_event() with two arguments viz
-(originator, event). Typically the originator will be an integer assigned
-to a thermal_zone_device when it registers itself with the framework. The
+(originator, event). The originator is a pointer to struct thermal_zone_device
+from where the event has been originated. An integer which represents the
+thermal zone device will be used in the message to identify the zone. The
 event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
 THERMAL_DEV_FAULT}. Notification can be sent when the current temperature
 crosses any of the configured thresholds.
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 022bacb..650cefb 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1287,7 +1287,8 @@ static struct genl_multicast_group thermal_event_mcgrp = {
 	.name = THERMAL_GENL_MCAST_GROUP_NAME,
 };
 
-int thermal_generate_netlink_event(u32 orig, enum events event)
+int thermal_generate_netlink_event(struct thermal_zone_device *tz,
+					enum events event)
 {
 	struct sk_buff *skb;
 	struct nlattr *attr;
@@ -1297,6 +1298,9 @@ int thermal_generate_netlink_event(u32 orig, enum events event)
 	int result;
 	static unsigned int thermal_event_seqnum;
 
+	if (!tz)
+		return -EINVAL;
+
 	/* allocate memory */
 	size = nla_total_size(sizeof(struct thermal_genl_event)) +
 	       nla_total_size(0);
@@ -1331,7 +1335,7 @@ int thermal_generate_netlink_event(u32 orig, enum events event)
 
 	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
 
-	thermal_event->orig = orig;
+	thermal_event->orig = tz->id;
 	thermal_event->event = event;
 
 	/* send multicast genetlink message */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 796f1ff..b754203 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -152,9 +152,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 
 #ifdef CONFIG_NET
-extern int thermal_generate_netlink_event(u32 orig, enum events event);
+extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
+						enum events event);
 #else
-static inline int thermal_generate_netlink_event(u32 orig, enum events event)
+static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
+						enum events event)
 {
 	return 0;
 }
-- 
1.7.7.1.488.ge8e1c
