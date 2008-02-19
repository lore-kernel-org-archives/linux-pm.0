From: <gregkh@suse.de>
Subject: patch driver-core-pm-make-suspend_device-static.patch
	added to gregkh-2.6 tree
Date: Tue, 19 Feb 2008 11:43:11 -0800
Message-ID: <12034501912611__19688.9612278484$1203450452$gmane$org@kroah.org>
References: <200802032255.19835.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802032255.19835.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bunk@kernel.org, greg@kroah.com, gregkh@suse.de, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, pavel@ucw.cz, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: Driver core: PM: Make suspend_device() static

to my gregkh-2.6 tree.  Its filename is

     driver-core-pm-make-suspend_device-static.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rjw@sisk.pl Sun Feb  3 14:03:13 2008
From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 3 Feb 2008 22:55:18 +0100
Subject: Driver core: PM: Make suspend_device() static
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>, Adrian Bunk <bunk@kernel.org>
Message-ID: <200802032255.19835.rjw@sisk.pl>
Content-Disposition: inline


From: Adrian Bunk <bunk@kernel.org>

suspend_device() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL_GPL(device_power_down);
  *	@dev:	Device.
  *	@state:	Power state device is entering.
  */
-int suspend_device(struct device *dev, pm_message_t state)
+static int suspend_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 


Patches currently in gregkh-2.6 which might be from bunk@kernel.org are

driver/driver-core-pm-make-suspend_device-static.patch
pci/pci-if-0-pci_assign_resource_fixed.patch
usb/usb-make-usb_storage_onetouch-available-with-pm.patch
usb/usb-g_printer-fix-empty-if-statement.patch
