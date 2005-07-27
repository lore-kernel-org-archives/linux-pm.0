From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: sysdev suspend/resume
Date: Wed, 27 Jul 2005 16:50:20 +0800
Message-ID: <1122454220.7414.3.camel@linux-hp.sh.intel.com>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
	<20050726101409.GA1950@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65349947562330213=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050726101409.GA1950@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============65349947562330213==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-07-26 at 12:14 +0200, Pavel Machek wrote:
> Hi!
> 
> > The return value of sysdev's suspend/resume methods is ignored, is this
> > intended (it should not fail?) or just a bug? I'd like to abort the
> > suspend process if one device fails.
> 
> I guess patch would be accepted... but please make sure you test those
> error paths, and printk name of failing driver.
It's a challenge to me, so many loops :). Below patch is a little ugly,
but should cover all error paths.

> Hmmm, I wonder how you are going to handle resume failure? AFAICS, there's
> no sane way to handle that.
We can't refuse to resume :).

Thanks,
Shaohua

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-rc3-root/drivers/base/sys.c |  104 +++++++++++++++++++++++--------
 1 files changed, 80 insertions(+), 24 deletions(-)

diff -puN drivers/base/sys.c~sysdev drivers/base/sys.c
--- linux-2.6.13-rc3/drivers/base/sys.c~sysdev	2005-07-27 10:49:52.831538832 +0800
+++ linux-2.6.13-rc3-root/drivers/base/sys.c	2005-07-27 16:25:49.154312008 +0800
@@ -288,6 +288,22 @@ void sysdev_shutdown(void)
 	up(&sysdev_drivers_lock);
 }
 
+#define SYSDEV_RESUME(cls, dev, drv)			\
+	/* First, call the class-specific one */ 	\
+	if (cls->resume)				\
+		cls->resume(dev);			\
+							\
+	/* Call auxillary drivers next. */ 		\
+	list_for_each_entry(drv, &cls->drivers, entry) {\
+		if (drv->resume) 			\
+			drv->resume(dev); 		\
+	}						\
+							\
+	/* Call global drivers. */			\
+	list_for_each_entry(drv, &sysdev_drivers, entry) {\
+		if (drv->resume)			\
+			drv->resume(dev);		\
+	}
 
 /**
  *	sysdev_suspend - Suspend all system devices.
@@ -305,38 +321,93 @@ void sysdev_shutdown(void)
 int sysdev_suspend(pm_message_t state)
 {
 	struct sysdev_class * cls;
+	struct sys_device *sysdev, *err_dev;
+	struct sysdev_driver *drv, *err_drv;
+	int	ret;
 
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
+	printk(KERN_ERR "Clss suspend failed for %s\n",
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
+		SYSDEV_RESUME(cls, err_dev, err_drv);
+	}
+
+	/* resume other classes */
+	list_for_each_entry_continue(cls, &system_subsys.kset.list,
+					kset.kobj.entry) {
+		list_for_each_entry(err_dev, &cls->kset.list, kobj.entry) {
+			pr_debug(" %s\n", kobject_name(&err_dev->kobj));
+			SYSDEV_RESUME(cls, err_dev, err_drv);
+		}
+	}
+	return ret;
 }
 
 
@@ -365,22 +436,7 @@ int sysdev_resume(void)
 			struct sysdev_driver * drv;
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
+			SYSDEV_RESUME(cls, sysdev, drv);
 		}
 	}
 	return 0;
_



--===============65349947562330213==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65349947562330213==--
