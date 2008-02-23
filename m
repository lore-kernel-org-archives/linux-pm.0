From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc2-git] acpi_pci_set_power_state()
	cleanups
Date: Fri, 22 Feb 2008 21:41:51 -0800
Message-ID: <200802222141.51699.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-acpi@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Minor cleanups to acpi_pci_set_power_state():  use the ACPI and PCI
state symbols to make clear that a mapping is being done between PCI
and ACPI states, instead of using magic numbers.  For paranoia's sake,
report any errors.  Save five bytes (x86_64) too.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Extracted from the "teach ACPI how to use driver model wakeup flags"
patch series ... who knows, maybe that could be merged someday.

 drivers/pci/pci-acpi.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- g26.orig/drivers/pci/pci-acpi.c	2008-02-22 19:26:58.000000000 -0800
+++ g26/drivers/pci/pci-acpi.c	2008-02-22 20:37:14.000000000 -0800
@@ -272,21 +272,29 @@ static int acpi_pci_set_power_state(stru
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
 	acpi_handle tmp;
-	static int state_conv[] = {
-		[0] = 0,
-		[1] = 1,
-		[2] = 2,
-		[3] = 3,
-		[4] = 3
+	static const u8 state_conv[] = {
+		[PCI_D0] = ACPI_STATE_D0,
+		[PCI_D1] = ACPI_STATE_D1,
+		[PCI_D2] = ACPI_STATE_D2,
+		[PCI_D3hot] = ACPI_STATE_D3,
+		[PCI_D3cold] = ACPI_STATE_D3
 	};
-	int acpi_state = state_conv[(int __force) state];
 
 	if (!handle)
 		return -ENODEV;
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
 		return 0;
-	return acpi_bus_set_power(handle, acpi_state);
+
+	switch (state) {
+	case PCI_D0:
+	case PCI_D1:
+	case PCI_D2:
+	case PCI_D3hot:
+	case PCI_D3cold:
+		return acpi_bus_set_power(handle, state_conv[state]);
+	}
+	return -EINVAL;
 }
 
 
