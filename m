From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PCI PM: Follow PCI_PM_CTRL_NO_SOFT_RESET
	during transitions from D3
Date: Mon, 18 May 2009 22:51:12 +0200
Message-ID: <200905182251.13197.rjw__24036.5406884395$1242682036$gmane$org@sisk.pl>
References: <200905182246.41129.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905182246.41129.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

According to the PCI PM specification (PCI Bus Power Management
Interface Specification, Rev. 1.2, Section 5.4.1) we are supposed to
reinitialize devices that have PCI_PM_CTRL_NO_SOFT_RESET clear during
all transitions from PCI_D3hot to PCI_D0, but we only do it if the
device's current_state field is equal to PCI_UNKNOWN.

This may lead to problems if a device with PCI_PM_CTRL_NO_SOFT_RESET
unset is put into PCI_D3hot at run time by its driver and
pci_set_power_state() is used to put it back into PCI_D0, because in
that case the device will remain uninitialized after
pci_set_power_state() has returned.  Prevent that from happening by
modifying pci_raw_set_power_state() to reinitialize devices with
PCI_PM_CTRL_NO_SOFT_RESET unset during all transitions from D3 to D0.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -480,6 +480,8 @@ static int pci_raw_set_power_state(struc
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
 		break;
+	case PCI_D3hot:
+	case PCI_D3cold:
 	case PCI_UNKNOWN: /* Boot-up */
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
