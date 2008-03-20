From: <gregkh@suse.de>
Subject: patch
	pm-fix-misuse-of-wakeup-flag-accessors-in-serial-core.patch
	added to gregkh-2.6 tree
Date: Thu, 20 Mar 2008 16:23:48 -0700
Message-ID: <120605542858__4252.49233744598$1206055578$gmane$org@kroah.org>
References: <200803192235.14645.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803192235.14645.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu, akpm@linux-foundation.org, greg@kroah.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PM: Fix misuse of wakeup flag accessors in serial core

to my gregkh-2.6 tree.  Its filename is

     pm-fix-misuse-of-wakeup-flag-accessors-in-serial-core.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rjw@sisk.pl  Thu Mar 20 16:20:16 2008
From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 19 Mar 2008 22:35:13 +0100
Subject: PM: Fix misuse of wakeup flag accessors in serial core
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, lenb@kernel.org
Message-ID: <200803192235.14645.rjw@sisk.pl>
Content-Disposition: inline


From: Alan Stern <stern@rowland.harvard.edu>

This patch (as1059) fixes a mistake in the way the serial core
initializes a device's wakeup settings.  It should use the accessor
routine instead of relying on a macro producing an lvalue.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2356,7 +2356,7 @@ int uart_add_one_port(struct uart_driver
 	 */
 	tty_dev = tty_register_device(drv->tty_driver, port->line, port->dev);
 	if (likely(!IS_ERR(tty_dev))) {
-		device_can_wakeup(tty_dev) = 1;
+		device_init_wakeup(tty_dev, 1);
 		device_set_wakeup_enable(tty_dev, 0);
 	} else
 		printk(KERN_ERR "Cannot register tty device on line %d\n",


Patches currently in gregkh-2.6 which might be from stern@rowland.harvard.edu are

usb/usb-convert-usb.h-struct-usb_device-to-kernel-doc.patch
usb/usb-make-usb_storage_onetouch-available-with-pm.patch
usb/usb-usb-ohci-sm501-driver-use-the-conventional-convention-for-suspend-and-resume.patch
usb/usb-reorganize-code-in-hub.c.patch
usb/usb-ehci-carry-out-port-handover-during-each-root-hub-resume.patch
usb/usb-new-quirk-flag-to-avoid-set-interface.patch
usb/drivers-usb-core-devio.c-suppress-warning-with-64k-page_size.patch
usb/usb-make-usb-persist-work-after-every-system-sleep.patch
usb/usb-remove-config_usb_persist-setting.patch
usb/usb-check-serial-number-string-after-device-reset.patch
usb/usb-enable-usb-persist-by-default.patch
usb/usb-remove-dev-power.power_state.patch
usb/usb-isd200-fix-memory-leak-in-isd200_get_inquiry_data.patch
usb/usb-remove-experimental-tags-from-some-usb-gadget-kconfig-entries.patch
driver-core/pm-handle-device-registrations-during-suspend-resume.patch
driver-core/pm-convert-wakeup-flag-accessors-to-inline-functions.patch
driver-core/driver-core-call-device_pm_add-after-bus_add_device-in-device_add.patch
driver-core/pm-fix-misuse-of-wakeup-flag-accessors-in-serial-core.patch
driver-core/pm-make-wakeup-flags-available-whenever-config_pm-is-set.patch
