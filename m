From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] remove kernel/power/pm.c:pm_unregister_all()
Date: Fri, 23 Jun 2006 12:55:43 +0200
Message-ID: <20060623105543.GO9111@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933012AbWFWK4P@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch removes the deprecated and no longer used pm_unregister_all().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/pm_legacy.h |    7 -------
 kernel/power/pm.c         |   37 -------------------------------------
 2 files changed, 44 deletions(-)

--- linux-2.6.17-mm1-full/include/linux/pm_legacy.h.old	2006-06-22 17:55:29.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/pm_legacy.h	2006-06-22 17:55:40.000000000 +0200
@@ -15,11 +15,6 @@
 pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
- * Unregister all devices with matching callback
- */
-void __deprecated pm_unregister_all(pm_callback callback);
-
-/*
  * Send a request to all devices
  */
 int __deprecated pm_send_all(pm_request_t rqst, void *data);
@@ -35,8 +30,6 @@
 	return NULL;
 }
 
-static inline void pm_unregister_all(pm_callback callback) {}
-
 static inline int pm_send_all(pm_request_t rqst, void *data)
 {
 	return 0;
--- linux-2.6.17-mm1-full/kernel/power/pm.c.old	2006-06-22 17:56:18.000000000 +0200
+++ linux-2.6.17-mm1-full/kernel/power/pm.c	2006-06-22 18:10:14.000000000 +0200
@@ -75,42 +75,6 @@
 	return dev;
 }
 
-static void __pm_unregister(struct pm_dev *dev)
-{
-	if (dev) {
-		list_del(&dev->entry);
-		kfree(dev);
-	}
-}
-
-/**
- *	pm_unregister_all - unregister all devices with matching callback
- *	@callback: callback function pointer
- *
- *	Unregister every device that would call the callback passed. This
- *	is primarily meant as a helper function for loadable modules. It
- *	enables a module to give up all its managed devices without keeping
- *	its own private list.
- */
- 
-void pm_unregister_all(pm_callback callback)
-{
-	struct list_head *entry;
-
-	if (!callback)
-		return;
-
-	mutex_lock(&pm_devs_lock);
-	entry = pm_devs.next;
-	while (entry != &pm_devs) {
-		struct pm_dev *dev = list_entry(entry, struct pm_dev, entry);
-		entry = entry->next;
-		if (dev->callback == callback)
-			__pm_unregister(dev);
-	}
-	mutex_unlock(&pm_devs_lock);
-}
-
 /**
  *	pm_send - send request to a single device
  *	@dev: device to send to
@@ -239,7 +203,6 @@
 }
 
 EXPORT_SYMBOL(pm_register);
-EXPORT_SYMBOL(pm_unregister_all);
 EXPORT_SYMBOL(pm_send_all);
 EXPORT_SYMBOL(pm_active);
 
