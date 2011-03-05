From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH v2] PCI / PM: Add kerneldoc description of
	pci_pm_reset()
Date: Sat, 5 Mar 2011 21:48:44 +0100
Message-ID: <201103052148.44413.rjw__38087.6753632494$1299358190$gmane$org@sisk.pl>
References: <201103051324.27461.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103051324.27461.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The pci_pm_reset() function is not a very nice interface due to its
limitations and conditional behavior (e.g. it doesn't affect devices
in low-power states), but it cannot be simply dropped, because
existing device drivers may depend on it.  However, its behavior and
limitations should be well documented, so add an appropriate
kerneldoc comment to it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi,

I corrected some spelling and similar stuff.

Thanks,
Rafael

---
 drivers/pci/pci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -2473,6 +2473,21 @@ clear:
 	return 0;
 }
 
+/**
+ * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
+ * @dev: Device to reset.
+ * @probe: If set, only check if the device can be reset this way.
+ *
+ * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
+ * unset, it will be reinitialized internally when going from PCI_D3hot to
+ * PCI_D0.  If that's the case and the device is not in a low-power state
+ * already, force it into PCI_D3hot and back to PCI_D0, causing it to be reset.
+ *
+ * NOTE: This causes the caller to sleep for twice the device power transition
+ * cooldown period, which for the D0->D3hot and D3hot->D0 transitions is 10 ms
+ * by devault (i.e. unless the @dev's d3_delay field has a different value).
+ * Moreover, only devices in D0 can be reset by this function.
+ */
 static int pci_pm_reset(struct pci_dev *dev, int probe)
 {
 	u16 csr;
