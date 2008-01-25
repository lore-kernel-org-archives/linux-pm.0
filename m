From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 2/5] Misc: Add possibility to remove misc
	devices during suspend/resume
Date: Fri, 25 Jan 2008 01:31:49 +0100
Message-ID: <200801250131.50924.rjw@sisk.pl>
References: <200801250127.21966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801250127.21966.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Buesch <mb@bu3sch.de>, LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to unregister a misc device object in a safe way
during a suspend/resume cycle.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/char/misc.c        |   13 +++++++++----
 include/linux/miscdevice.h |   10 +++++++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

Index: linux-2.6.24-rc8-mm1/include/linux/miscdevice.h
===================================================================
--- linux-2.6.24-rc8-mm1.orig/include/linux/miscdevice.h
+++ linux-2.6.24-rc8-mm1/include/linux/miscdevice.h
@@ -43,7 +43,15 @@ struct miscdevice  {
 };
 
 extern int misc_register(struct miscdevice * misc);
-extern int misc_deregister(struct miscdevice * misc);
+extern int __misc_deregister(struct miscdevice *misc, bool suspended);
+static inline int misc_deregister(struct miscdevice *misc)
+{
+	return __misc_deregister(misc, false);
+}
+static inline int misc_deregister_suspended(struct miscdevice *misc)
+{
+	return __misc_deregister(misc, true);
+}
 
 #define MODULE_ALIAS_MISCDEV(minor)				\
 	MODULE_ALIAS("char-major-" __stringify(MISC_MAJOR)	\
Index: linux-2.6.24-rc8-mm1/drivers/char/misc.c
===================================================================
--- linux-2.6.24-rc8-mm1.orig/drivers/char/misc.c
+++ linux-2.6.24-rc8-mm1/drivers/char/misc.c
@@ -232,8 +232,9 @@ int misc_register(struct miscdevice * mi
 }
 
 /**
- *	misc_deregister - unregister a miscellaneous device
+ *	__misc_deregister - unregister a miscellaneous device
  *	@misc: device to unregister
+ *	@suspended: to be set if the function is used during suspend/resume
  *
  *	Unregister a miscellaneous device that was previously
  *	successfully registered with misc_register(). Success
@@ -241,7 +242,7 @@ int misc_register(struct miscdevice * mi
  *	indicates an error.
  */
 
-int misc_deregister(struct miscdevice * misc)
+int __misc_deregister(struct miscdevice *misc, bool suspended)
 {
 	int i = misc->minor;
 
@@ -250,7 +251,11 @@ int misc_deregister(struct miscdevice * 
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
-	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
+	if (suspended)
+		destroy_suspended_device(misc_class,
+					MKDEV(MISC_MAJOR, misc->minor));
+	else
+		device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
 	}
@@ -259,7 +264,7 @@ int misc_deregister(struct miscdevice * 
 }
 
 EXPORT_SYMBOL(misc_register);
-EXPORT_SYMBOL(misc_deregister);
+EXPORT_SYMBOL(__misc_deregister);
 
 static int __init misc_init(void)
 {
