From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] ACPI / Button: Avoid disabling wakeup
	unnecessarily on remove
Date: Sun, 6 Feb 2011 14:21:18 +0100
Message-ID: <201102061421.18978.rjw__17542.8469935015$1296998601$gmane$org@sisk.pl>
References: <201102061418.56202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102061418.56202.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ferenc =?utf-8?q?W=C3=A1gner?= <wferi@niif.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If a button device had already been enabled to wake up the system
from sleep states before the button driver saw it, the driver
shouldn't disable the device's wakeup capability when being detached
from the device.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/button.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -98,6 +98,7 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	bool wakeup_enabled;
 };
 
 static const struct file_operations acpi_button_info_fops = {
@@ -430,7 +431,10 @@ static int acpi_button_add(struct acpi_d
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device_set_wakeup_enable(&device->dev, true);
+		if (!device_may_wakeup(&device->dev)) {
+			device_set_wakeup_enable(&device->dev, true);
+			button->wakeup_enabled = true;
+		}
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
@@ -452,7 +456,8 @@ static int acpi_button_remove(struct acp
 	if (device->wakeup.flags.valid) {
 		acpi_disable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device_set_wakeup_enable(&device->dev, false);
+		if (button->wakeup_enabled)
+			device_set_wakeup_enable(&device->dev, false);
 	}
 
 	acpi_button_remove_fs(device);
