From: <gregkh@suse.de>
Subject: patch
	pm-platform_bus-and-late_suspend-early_resume.patch added to
	gregkh-2.6 tree
Date: Wed, 06 Sep 2006 14:55:28 -0700
Message-ID: <20060906215525.C60628B2FBF@imap.suse.de>
References: <200609031316.45905.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200609031316.45905.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david-b@pacbell.net, dbrownell@users.sourceforge.net, greg@kroah.com, gregkh@suse.de, linux-pm@lists.osdl.org, torvalds@osdl.org
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PM: platform_bus and late_suspend/early_resume

to my gregkh-2.6 tree.  Its filename is

     pm-platform_bus-and-late_suspend-early_resume.patch

This tree can be found at =

    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From david-b@pacbell.net Sun Sep  3 13:17:24 2006
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: PM: platform_bus and late_suspend/early_resume
Date: Sun, 3 Sep 2006 13:16:45 -0700
Cc: "Linux-pm mailing list" <linux-pm@lists.osdl.org>, Linus Torvalds <torv=
alds@osdl.org>
Content-Disposition: inline
Message-Id: <200609031316.45905.david-b@pacbell.net>

Teach platform_bus about the new suspend_late/resume_early PM calls,
issued with IRQs off.  Do we really need sysdev and friends any more,
or can janitors start switching its users over to platform_device so
we can do a minor code-ectomy?

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/platform.c         |   30 ++++++++++++++++++++++++++++--
 include/linux/platform_device.h |    2 ++
 2 files changed, 30 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/base/platform.c
+++ gregkh-2.6/drivers/base/platform.c
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
+	.suspend_late	=3D platform_suspend_late,
+	.resume_early	=3D platform_resume_early,
 	.resume		=3D platform_resume,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
--- gregkh-2.6.orig/include/linux/platform_device.h
+++ gregkh-2.6/include/linux/platform_device.h
@@ -49,6 +49,8 @@ struct platform_driver {
 	int (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
+	int (*suspend_late)(struct platform_device *, pm_message_t state);
+	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 };


Patches currently in gregkh-2.6 which might be from david-b@pacbell.net are

driver/pm-define-pm_event_prethaw.patch
driver/suspend-infrastructure-cleanup-and-extension.patch
driver/suspend-pci.patch
driver/pm-issue-pm_event_prethaw.patch
driver/pm-pci-and-ide-handle-pm_event_prethaw.patch
driver/pm-usb-hcds-use-pm_event_prethaw.patch
driver/pm-video-drivers-and-pm_event_prethaw.patch
driver/updated-documentation-power-devices.txt.patch
driver/make-suspend-quieter.patch
driver/fix-broken-dubious-driver-suspend-methods.patch
driver/pm-add-kconfig-option-for-deprecated-...-power-state-files.patch
driver/pm-no-suspend_prepare-phase.patch
driver/pm-schedule-sys-devices-...-power-state-for-removal.patch
driver/pm-update-docs-for-writing-...-power-state.patch
driver/pm-platform_bus-and-late_suspend-early_resume.patch
i2c/i2c-algos-constify-i2c_algorithm.patch
i2c/i2c-busses-constify-i2c_algorithm.patch
i2c/i2c-constify-i2c_algorithm.patch
usb/usb-ohci-avoids-root-hub-timer-polling.patch
usb/usb-asix-add-ax88178-support-and-many-other-changes.patch
usb/usb-usbnet-add-unlink_rx_urbs-call-to-allow-for-jumbo-frames.patch
usb/usb-allow-compile-in-g_ether-fix-typo.patch
usb/usbcore-make-hcd_endpoint_disable-wait-for-queue-to-drain.patch
usb/usb-move-linux-usb_otg.h-to-linux-usb-otg.h.patch
usb/usb-ohci-controller-support-for-pnx4008.patch
usb/usb-pxa2xx_udc-understands-gpio-based-vbus-sensing.patch
usb/usb-ehci-whitespace-fixes.patch
usb/usb-build-fixes-ohci-omap.patch
usb/usb-correct-locking-in-gadgetfs_disconnect.patch
usb/usb-fix-ep_config-to-return-correct-value.patch
usb/usb-gadgetfs-protect-ep_release-with-lock.patch
usb/usb-gmidi-new-usb-midi-gadget-class-driver.patch
usb/usb-add-poll-to-gadgetfs-s-endpoint-zero.patch
usb/usb-gadget-gadgetfs-dont-try-to-lock-before-free.patch
usb/usb-net1080-inherent-pad-length.patch
usb/usb-properly-unregister-reboot-notifier-in-case-of-failure-in-ehci-hcd.=
patch
usb/wusb-hub-recognizes-wusb-ports.patch
usb/wusb-handle-wusb-device-ep0-speed-settings.patch
usb/wusb-pretty-print-new-devices.patch
usb/usb-deal-with-broken-config-descriptors.patch
usb/usb-fix-signedness-issue-in-drivers-usb-gadget-ether.c.patch
usb/usb-ethernet-gadget-avoids-zlps-for-musb_hdrc.patch
usb/gadgetfs-patch-for-ep0out.patch
usb/usb-ohci-at91-two-one-liners.patch
usb/usb-net2280-update-dma-buffer-allocation.patch
usb/usb-usb-serial-gadget-smp-related-bug.patch
