From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH] pm: provide stubs for PM VT console switch routines
Date: Fri, 15 Feb 2013 08:17:58 -0800
Message-ID: <1360945078-27865-1-git-send-email-jbarnes@virtuousgeek.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:52941 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935920Ab3BOQRX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Feb 2013 11:17:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org

If PM_SLEEP is disabled, we need stub versions of these functions.

v2: fix up struct device forward decl.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 include/linux/pm.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 98310eb..e5da2f3 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -36,8 +36,17 @@ extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
 struct device; /* we have a circular dep with device.h */
+#ifdef CONFIG_VT_CONSOLE_SLEEP
 extern void pm_vt_switch_required(struct device *dev, bool required);
 extern void pm_vt_switch_unregister(struct device *dev);
+#else
+static inline void pm_vt_switch_required(struct device *dev, bool required)
+{
+}
+static inline void pm_vt_switch_unregister(struct device *dev)
+{
+}
+#endif /* CONFIG_VT_CONSOLE_SLEEP */
 
 /*
  * Device power management
-- 
1.7.9.5

