From: Daniel Drake <dsd@gentoo.org>
Subject: Re: usb_id segfaulting on 2.6.23
Date: Tue, 06 Nov 2007 17:51:22 +0000
Message-ID: <4730A99A.3010809__27904.9167912037$1194371805$gmane$org@gentoo.org>
References: <Pine.LNX.4.44L0.0711061108220.3883-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000504080007010803020301"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711061108220.3883-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-hotplug-devel@lists.sourceforge.net, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504080007010803020301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Stern wrote:
> Ah, okay.  This is a known problem, a configuration-related issue.  
> The PM core doesn't create a device's /sys/.../power subdirectory
> unless CONFIG_PM_SLEEP is set.  In fact it should be created whenever
> CONFIG_PM is set.
> 
> I haven't had time to write a patch for this yet.  Do you want to try?

OK. Any comments on this before I sent it to the proper channels?

Thanks,
Daniel

--------------000504080007010803020301
Content-Type: text/plain;
 name="power-sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="power-sysfs.patch"


From: Daniel Drake <dsd@gentoo.org>

Index: linux-2.6.24-rc1-git14/drivers/base/core.c
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/core.c
+++ linux-2.6.24-rc1-git14/drivers/base/core.c
@@ -770,6 +770,9 @@ int device_add(struct device *dev)
 	error = device_add_attrs(dev);
 	if (error)
 		goto AttrsError;
+	error = dpm_sysfs_add(dev);
+	if (error)
+		goto PMsysfsError;
 	error = device_pm_add(dev);
 	if (error)
 		goto PMError;
@@ -797,11 +800,13 @@ int device_add(struct device *dev)
 	return error;
  BusError:
 	device_pm_remove(dev);
- PMError:
+ PMsysfsError:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
 	device_remove_attrs(dev);
+ PMError:
+	dpm_sysfs_remove(dev);
  AttrsError:
 	device_remove_class_symlinks(dev);
  SymlinkError:
Index: linux-2.6.24-rc1-git14/drivers/base/power/Makefile
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/power/Makefile
+++ linux-2.6.24-rc1-git14/drivers/base/power/Makefile
@@ -1,5 +1,6 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM_SLEEP)	+= main.o sysfs.o
+obj-$(CONFIG_PM)	+= sysfs.o
+obj-$(CONFIG_PM_SLEEP)	+= main.o
 obj-$(CONFIG_PM_TRACE)	+= trace.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
Index: linux-2.6.24-rc1-git14/drivers/base/power/power.h
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/power/power.h
+++ linux-2.6.24-rc1-git14/drivers/base/power/power.h
@@ -21,6 +21,22 @@ static inline struct device * to_device(
 extern int device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 
+#else /* CONFIG_PM_SLEEP */
+
+
+static inline int device_pm_add(struct device * dev)
+{
+	return 0;
+}
+static inline void device_pm_remove(struct device * dev)
+{
+
+}
+
+#endif
+
+#ifdef CONFIG_PM
+
 /*
  * sysfs.c
  */
@@ -28,16 +44,16 @@ extern void device_pm_remove(struct devi
 extern int dpm_sysfs_add(struct device *);
 extern void dpm_sysfs_remove(struct device *);
 
-#else /* CONFIG_PM_SLEEP */
-
+#else /* CONFIG_PM */
 
-static inline int device_pm_add(struct device * dev)
+static inline int dpm_sysfs_add(struct device * dev)
 {
 	return 0;
 }
-static inline void device_pm_remove(struct device * dev)
+static inline void dpm_sysfs_remove(struct device * dev)
 {
 
 }
 
-#endif
+#endif /* CONFIG_PM */
+

--------------000504080007010803020301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000504080007010803020301--
