From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI PM: Fix initialization and kexec breakage
	for some devices
Date: Sun, 17 May 2009 20:17:06 +0200
Message-ID: <200905172017.08207.rjw__30516.4046389566$1242586012$gmane$org@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Recent PCI PM changes introduced a bug that causes some devices to be
mishandled after kexec and during early initialization.  The failure
scenario in the kexec case is the following:

* Assume a PCI device is not power-manageable by the platform and has
  PCI_PM_CTRL_NO_SOFT_RESET set in PMCSR.
* The device is put into D3 before kexec (using the native PCI PM).
* After kexec, pci_setup_device() sets the device's power state to
  PCI_UNKNOWN.
* pci_set_power_state(dev, PCI_D0) is called by the device's driver.
* __pci_start_power_transition(dev, PCI_D0) is called and since the
  device is not power-manageable by the platform, it causes
  pci_update_current_state(dev, PCI_D0) to be called.  As a result
  the device's current_state field is updated to PCI_D3, in
  accordance with the contents of its PCI PM registers.
* pci_raw_set_power_state() is called and it changes the device power
  state to D0.  *However*, it should also call pci_restore_bars() to
  reinitialize the device, but it doesn't, because the device's
  current_state field has been modified earlier.

To prevent this from happening, modify
pci_platform_power_transition() so that it doesn't use
pci_update_current_state() to update the current_state field for
devices that aren't power-manageable by the platform.  Instead, this
field should be updated directly for devices that don't support the
native PCI PM.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -557,7 +557,8 @@ static int pci_platform_power_transition
 	} else {
 		error = -ENODEV;
 		/* Fall back to PCI_D0 if native PM is not supported */
-		pci_update_current_state(dev, PCI_D0);
+		if (!dev->pm_cap)
+			dev->current_state = PCI_D0;
 	}
 
 	return error;
