From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/9] PCI ACPI: Remove acpi_platform_enable_wakeup
Date: Wed, 2 Jul 2008 00:00:11 +0200
Message-ID: <200807020000.12964.rjw__47244.0327903771$1214950839$gmane$org@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807012356.26669.rjw@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tobias Diedrich <ranma@tdiedrich.de>, Jeff Garzik <jeff@garzik.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhao Yakui <yakui.zhao@intel.com>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCI ACPI: Remove acpi_platform_enable_wakeup

This patch removes "Fix forcedeth hibernate/wake-on-lan problems",
commit f5ccbcfacaae57e3312e623432a79d5f1f079cf5 in linux-next,
which is incorrect, because it directly manipulates the
wakeup.state.enabled flags of ACPI devices while these flags are
supposed to be used by the user space to control wake-up.  Moreover,
it affects not only the device it is supposed to fix (forcedeth), but
also every PCI device that happens to call
device_init_wakeup(dev, 1).

Apart from this, it has been pushed as a network driver fix, while it should
have gone through either ACPI or PCI tree.  Also, the other patches in this
series are intended to fix the issue it was supposed to fix, but in a more
complete way.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   20 --------------------
 1 file changed, 20 deletions(-)

Index: linux-next/drivers/pci/pci-acpi.c
===================================================================
--- linux-next.orig/drivers/pci/pci-acpi.c
+++ linux-next/drivers/pci/pci-acpi.c
@@ -259,25 +259,6 @@ static pci_power_t acpi_pci_choose_state
 	}
 	return PCI_POWER_ERROR;
 }
-
-static int acpi_platform_enable_wakeup(struct device *dev, int is_on)
-{
-	struct acpi_device	*adev;
-	int			status;
-
-	if (!device_can_wakeup(dev))
-		return -EINVAL;
-
-	if (is_on && !device_may_wakeup(dev))
-		return -EINVAL;
-
-	status = acpi_bus_get_device(DEVICE_ACPI_HANDLE(dev), &adev);
-	if (status < 0)
-		return status;
-
-	adev->wakeup.state.enabled = !!is_on;
-	return 0;
-}
 #endif
 
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
@@ -362,7 +343,6 @@ static int __init acpi_pci_init(void)
 		return 0;
 #ifdef	CONFIG_ACPI_SLEEP
 	platform_pci_choose_state = acpi_pci_choose_state;
-	platform_enable_wakeup = acpi_platform_enable_wakeup;
 #endif
 	platform_pci_set_power_state = acpi_pci_set_power_state;
 	return 0;
