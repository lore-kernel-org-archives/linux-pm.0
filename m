From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT][PATCH 2/4] PCI / PM: Make platform choose target low-power states of more devices
Date: Sat, 26 May 2012 23:20:25 +0200
Message-ID: <201205262320.25191.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain> <201205262227.47442.rjw@sisk.pl> <201205262316.30096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201205262316.30096.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It turns out that there are devices whose power states cannot be set
by ACPI (the _PRn and _PSn methods are not available for them), but
it still is necessary to use ACPI for setting up those devices to
wake up the system from sleep states.  Then, according to the ACPI
specification (ACPI 5.0 and earlier), if there are _SxD and/or _SxW
methods defined for those devices, the results returned by them
should be taken into consideration.  Moreover, some hardware vendors
seem to use this requirement to work around hardware and/or firmware
bugs, so it's better to follow it (which we don't do at the moment)
to avoid some nasty suspend/resume issues that are quite difficult to
debug.

This change is based on a patch from Oleksij Rempel.

References: https://bugzilla.kernel.org/show_bug.cgi?id=42728
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux/drivers/pci/pci.c
===================================================================
--- linux.orig/drivers/pci/pci.c
+++ linux/drivers/pci/pci.c
@@ -1691,10 +1691,16 @@ pci_power_t pci_target_state(struct pci_
 {
 	pci_power_t target_state = PCI_D3hot;
 
-	if (platform_pci_power_manageable(dev)) {
+	/*
+	 * It turns out that there are devices whose power states cannot be set
+	 * by the platform, although their wakeup capabilities depend on it.
+	 * The platform should be called to choose the target low-power states
+	 * of those devices too.
+	 */
+	if (platform_pci_power_manageable(dev)
+	    || (device_may_wakeup(&dev->dev) && platform_pci_can_wakeup(dev))) {
 		/*
-		 * Call the platform to choose the target state of the device
-		 * and enable wake-up from this state if supported.
+		 * Call the platform to choose the target state of the device.
 		 */
 		pci_power_t state = platform_pci_choose_state(dev);
 

