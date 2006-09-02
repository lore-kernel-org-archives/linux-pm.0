From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-rc-mm] PM: platform_bus and
 late_suspend/early_resume
Date: Fri, 01 Sep 2006 20:51:14 -0700
Message-ID: <20060902035114.4C154195C8B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: greg@kroah.com
Cc: torvalds@osdl.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Teach platform_bus about the new suspend_late/resume_early PM calls,
issued with IRQs off.  Do we really need sysdev and friends any more,
or can janitors start switching its users over to platform_device so
we can do a minor code-ectomy?

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/base/platform.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/drivers/base/platform.c	2006-06-28 22:02:04.000000000 -0700
+++ g26/drivers/base/platform.c	2006-08-31 19:36:07.000000000 -0700
@@ -505,12 +505,36 @@ static int platform_match(struct device =

 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) =3D=3D 0);
 }
 =

-static int platform_suspend(struct device * dev, pm_message_t state)
+static int platform_suspend(struct device *dev, pm_message_t mesg)
 {
 	int ret =3D 0;
 =

 	if (dev->driver && dev->driver->suspend)
-		ret =3D dev->driver->suspend(dev, state);
+		ret =3D dev->driver->suspend(dev, mesg);
+
+	return ret;
+}
+
+static int platform_suspend_late(struct device *dev, pm_message_t mesg)
+{
+	struct platform_driver *drv =3D to_platform_driver(dev->driver);
+	struct platform_device *pdev =3D container_of(dev, struct platform_device=
, dev);
+	int ret =3D 0;
+
+	if (dev->driver && drv->suspend_late)
+		ret =3D drv->suspend_late(pdev, mesg);
+
+	return ret;
+}
+
+static int platform_resume_early(struct device *dev)
+{
+	struct platform_driver *drv =3D to_platform_driver(dev->driver);
+	struct platform_device *pdev =3D container_of(dev, struct platform_device=
, dev);
+	int ret =3D 0;
+
+	if (dev->driver && drv->resume_early)
+		ret =3D drv->resume_early(pdev);
 =

 	return ret;
 }
@@ -531,6 +555,8 @@ struct bus_type platform_bus_type =3D {
 	.match		=3D platform_match,
 	.uevent		=3D platform_uevent,
 	.suspend	=3D platform_suspend,
+	.suspend	=3D platform_suspend_late,
+	.resume		=3D platform_resume_early,
 	.resume		=3D platform_resume,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
Index: g26/include/linux/platform_device.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/include/linux/platform_device.h	2006-08-31 19:30:33.000000000 =
-0700
+++ g26/include/linux/platform_device.h	2006-08-31 19:30:46.000000000 -0700
@@ -49,6 +49,8 @@ struct platform_driver {
 	int (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
+	int (*suspend_late)(struct platform_device *, pm_message_t state);
+	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 };
