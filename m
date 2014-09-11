From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] add helper for translation of runtime PM errors
Date: Thu, 11 Sep 2014 15:28:49 +0200
Message-ID: <1410442129-21130-1-git-send-email-oneukum@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35719 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbaIKN2y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Sep 2014 09:28:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net, stern@rowland.harvard.edu
Cc: Oliver Neukum <oneukum@suse.de>

pm_runtime_get() returns specialised error codes. They are not
fit to be returned to user space. This patch adds a helper
for translation.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 include/linux/pm_runtime.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 367f49b..67d078f 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -128,6 +128,27 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
 	ACCESS_ONCE(dev->power.last_busy) = jiffies;
 }
 
+static inline int pm_runtime_translate_errors(int error)
+{
+	int rv;
+
+	switch (error) {
+	case 0:
+	case -ENOMEM:
+	case -EBUSY:
+		rv = error;
+		break;
+	case -EINPROGRESS:
+		rv = -EAGAIN;
+		break;
+	default:
+		rv = error > 0 ? error : -EIO;
+		break;
+	}
+
+	return rv;
+}
+
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
@@ -178,6 +199,10 @@ static inline unsigned long pm_runtime_autosuspend_expiration(
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline int pm_runtime_translate_errors(int error)
+{
+	return error;
+}
 
 #endif /* !CONFIG_PM_RUNTIME */
 
-- 
1.8.4.5

