From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: sysdev suspend/resume
Date: Thu, 28 Jul 2005 11:10:59 +0800
Message-ID: <1122520259.2925.7.camel@linux-hp.sh.intel.com>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
	<20050726101409.GA1950@openzaurus.ucw.cz>
	<1122454220.7414.3.camel@linux-hp.sh.intel.com>
	<20050727090748.GB4270@elf.ucw.cz>
	<1122456610.3000.5.camel@linux-hp.sh.intel.com>
	<Pine.LNX.4.50.0507271035590.17623-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3810976690444503=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0507271035590.17623-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============3810976690444503==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
On Wed, 2005-07-27 at 10:43 -0700, Patrick Mochel wrote:
> > +static void inline do_sysdev_resume(struct sysdev_class *cls,
> > +	struct sys_device *dev, struct sysdev_driver *drv)
> > +{
> 
> 
> * It does not need to be inlined.
> 
> * Internal helpers are prefix'd with "__" instead of "do_", so this would
>   be '__sysdev_resume()'.
> 
> * drv is a temporary variable
> 
> * cls can be ascertained from the sys_device
> 
> 
> So, the first few lines should be
> 
> static void __sysdev_resume(struct sys_device * dev)
> {
> 	struct sysdev_class * cls = dev->cls;
> 	struct sysdev_driver * dev;
> 	...
Thanks. A updated one.


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-rc3-root/drivers/base/sys.c |  110 +++++++++++++++++++++++--------
 1 files changed, 85 insertions(+), 25 deletions(-)

diff -puN drivers/base/sys.c~sysdev drivers/base/sys.c
--- linux-2.6.13-rc3/drivers/base/sys.c~sysdev	2005-07-27 10:49:52.000000000 +0800
+++ linux-2.6.13-rc3-root/drivers/base/sys.c	2005-07-28 10:56:10.373347264 +0800
@@ -288,6 +288,27 @@ void sysdev_shutdown(void)
 	up(&sysdev_drivers_lock);
 }
 
+static void __sysdev_resume(struct sys_device *dev)
+{
+	struct sysdev_class *cls = dev->cls;
+	struct sysdev_driver *drv;
+
+	/* First, call the class-specific one */
+	if (cls->resume)
+		cls->resume(dev);
+
+	/* Call auxillary drivers next. */
+	list_for_each_entry(drv, &cls->drivers, entry) {
+		if (drv->resume)
+			drv->resume(dev);
+	}
+
+	/* Call global drivers. */
+	list_for_each_entry(drv, &sysdev_drivers, entry) {
+		if (drv->resume)
+			drv->resume(dev);
+	}
+}
 
 /**
  *	sysdev_suspend - Suspend all system devices.
@@ -305,38 +326,93 @@ void sysdev_shutdown(void)
 int sysdev_suspend(pm_message_t state)
 {
 	struct sysdev_class * cls;
+	struct sys_device *sysdev, *err_dev;
+	struct sysdev_driver *drv, *err_drv;
+	int ret;
 
 	pr_debug("Suspending System Devices\n");
 
 	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
-		struct sys_device * sysdev;
 
 		pr_debug("Suspending type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
 			list_for_each_entry(drv, &sysdev_drivers, entry) {
-				if (drv->suspend)
-					drv->suspend(sysdev, state);
+				if (drv->suspend) {
+					ret = drv->suspend(sysdev, state);
+					if (ret)
+						goto gbl_driver;
+				}
 			}
 
 			/* Call auxillary drivers next. */
 			list_for_each_entry(drv, &cls->drivers, entry) {
-				if (drv->suspend)
-					drv->suspend(sysdev, state);
+				if (drv->suspend) {
+					ret = drv->suspend(sysdev, state);
+					if (ret)
+						goto aux_driver;
+				}
 			}
 
 			/* Now call the generic one */
-			if (cls->suspend)
-				cls->suspend(sysdev, state);
+			if (cls->suspend) {
+				ret = cls->suspend(sysdev, state);
+				if (ret)
+					goto cls_driver;
+			}
 		}
 	}
 	return 0;
+	/* resume current sysdev */
+cls_driver:
+	drv = NULL;
+	printk(KERN_ERR "Class suspend failed for %s\n",
+		kobject_name(&sysdev->kobj));
+
+aux_driver:
+	if (drv)
+		printk(KERN_ERR "Class driver suspend failed for %s\n",
+				kobject_name(&sysdev->kobj));
+	list_for_each_entry(err_drv, &cls->drivers, entry) {
+		if (err_drv == drv)
+			break;
+		if (err_drv->resume)
+			err_drv->resume(sysdev);
+	}
+	drv = NULL;
+
+gbl_driver:
+	if (drv)
+		printk(KERN_ERR "sysdev driver suspend failed for %s\n",
+				kobject_name(&sysdev->kobj));
+	list_for_each_entry(err_drv, &sysdev_drivers, entry) {
+		if (err_drv == drv)
+			break;
+		if (err_drv->resume)
+			err_drv->resume(sysdev);
+	}
+	/* resume other sysdevs in current class */
+	list_for_each_entry(err_dev, &cls->kset.list, kobj.entry) {
+		if (err_dev == sysdev)
+			break;
+		pr_debug(" %s\n", kobject_name(&err_dev->kobj));
+		__sysdev_resume(err_dev);
+	}
+
+	/* resume other classes */
+	list_for_each_entry_continue(cls, &system_subsys.kset.list,
+					kset.kobj.entry) {
+		list_for_each_entry(err_dev, &cls->kset.list, kobj.entry) {
+			pr_debug(" %s\n", kobject_name(&err_dev->kobj));
+			__sysdev_resume(err_dev);
+		}
+	}
+	return ret;
 }
 
 
@@ -362,25 +438,9 @@ int sysdev_resume(void)
 			 kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
-			/* First, call the class-specific one */
-			if (cls->resume)
-				cls->resume(sysdev);
-
-			/* Call auxillary drivers next. */
-			list_for_each_entry(drv, &cls->drivers, entry) {
-				if (drv->resume)
-					drv->resume(sysdev);
-			}
-
-			/* Call global drivers. */
-			list_for_each_entry(drv, &sysdev_drivers, entry) {
-				if (drv->resume)
-					drv->resume(sysdev);
-			}
-
+			__sysdev_resume(sysdev);
 		}
 	}
 	return 0;
_



--===============3810976690444503==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============3810976690444503==--
