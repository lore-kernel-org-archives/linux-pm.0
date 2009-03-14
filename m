From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/11] PCI PM: Make pci_set_power_state() handle
	devices with no PM support
Date: Sat, 14 Mar 2009 12:33:55 +0100
Message-ID: <200903141233.56694.rjw__695.015586870973$1237031377$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903141224.29591.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903141224.29591.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is a problem with PCI devices without any PM support (either
native or through the platform) that pci_set_power_state() always
returns error code for them, even if they are being put into D0.
However, such devices are always in D0, so pci_set_power_state()
should return success when attempting to put such a device into D0.
It also should update the current_state field for these devices as
appropriate.  This modification is necessary so that the standard
configuration registers of these devices are successfully restored by
pci_restore_standard_config() during the "early" phase of resume.

In addition, pci_set_power_state() should check the value of
current_state before calling the platform to change the power state
of the device to avoid doing that unnecessarily.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -439,6 +439,10 @@ static int pci_raw_set_power_state(struc
 	u16 pmcsr;
 	bool need_restore = false;
 
+	/* Check if we're already there */
+	if (dev->current_state == state)
+		return 0;
+
 	if (!dev->pm_cap)
 		return -EIO;
 
@@ -449,10 +453,7 @@ static int pci_raw_set_power_state(struc
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
-	if (dev->current_state == state) {
-		/* we're already there */
-		return 0;
-	} else if (state != PCI_D0 && dev->current_state <= PCI_D3cold
+	if (state != PCI_D0 && dev->current_state <= PCI_D3cold
 	    && dev->current_state > state) {
 		dev_err(&dev->dev, "invalid power transition "
 			"(from state %d to %d)\n", dev->current_state, state);
@@ -570,12 +571,17 @@ int pci_set_power_state(struct pci_dev *
 		 */
 		return 0;
 
-	if (state == PCI_D0 && platform_pci_power_manageable(dev)) {
+	/* Check if we're already there */
+	if (dev->current_state == state)
+		return 0;
+
+	if (state == PCI_D0) {
 		/*
 		 * Allow the platform to change the state, for example via ACPI
 		 * _PR0, _PS0 and some such, but do not trust it.
 		 */
-		int ret = platform_pci_set_power_state(dev, PCI_D0);
+		int ret = platform_pci_power_manageable(dev) ?
+			platform_pci_set_power_state(dev, PCI_D0) : 0;
 		if (!ret)
 			pci_update_current_state(dev, PCI_D0);
 	}
