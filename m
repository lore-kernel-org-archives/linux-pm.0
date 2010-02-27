From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI / PM / Runtime: Make runtime PM of PCI
	devices inactive by default
Date: Sat, 27 Feb 2010 21:37:37 +0100
Message-ID: <201002272137.37349.rjw__41076.3754895472$1267302952$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

Make the run-time power management of PCI devices be inactive by
default by calling pm_runtime_forbid() for each PCI device during its
initialization.  This setting may be overriden by the user space with
the help of the /sys/devices/.../power/control interface.

That's necessary to avoid breakage on systems where ACPI-based
wake-up is known to fail for some devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1540,8 +1540,10 @@ void pci_pm_init(struct pci_dev *dev)
 	int pm;
 	u16 pmc;
 
+	pm_runtime_forbid(&dev->dev);
 	device_enable_async_suspend(&dev->dev);
 	dev->wakeup_prepared = false;
+
 	dev->pm_cap = 0;
 
 	/* find PCI PM capability in list */
