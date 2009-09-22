From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI PM: Read device power state from register
	after updating it (rev. 3)
Date: Tue, 22 Sep 2009 22:58:25 +0200
Message-ID: <200909222258.25904.rjw__26553.2656842426$1253653091$gmane$org@sisk.pl>
References: <200909212337.01812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909212337.01812.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>, pm list <linux-pm@lists.linux-foundation.org>, kevin granade <kevin.granade@gmail.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After attempting to change the power state of a PCI device
pci_raw_set_power_state() doesn't check if the value it wrote into
the device's PCI_PM_CTRL register has been stored in there, but
unconditionally modifies the device's current_state field to reflect
the change.  This may cause problems to happen if the power state of
the device hasn't been changed in fact, because it will make the PCI
PM core think that the device is in a power state it really is not
in.

To prevent such situations from happening modify
pci_raw_set_power_state() so that it reads the device's PCI_PM_CTRL
register after writing into it and uses the value read from the
register to update the device's current_state field.  Also make it
print a message saying that the device refused to change its power
state as requested (returning an error code in such cases would cause
suspend regressions to appear on some systems, where device drivers'
suspend routines return error codes if pci_set_power_state() fails).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
Respin to fix issues pointed out by the reviewers.

Thanks,
Rafael
---
 drivers/pci/pci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -513,7 +513,11 @@ static int pci_raw_set_power_state(struc
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
-	dev->current_state = state;
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	if (dev->current_state != state && printk_ratelimit())
+		dev_info(&dev->dev, "Refused to change power state, "
+			"currently in D%d\n", dev->current_state);
 
 	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
 	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
