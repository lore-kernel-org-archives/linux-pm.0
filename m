From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup and
	fixes
Date: Thu, 20 Mar 2008 14:12:43 -0700
Message-ID: <200803201412.44181.david-b__43278.5760880963$1206049014$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201408.33466.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Clean up pci_choose_state():

 - pci_choose_state() should only return PCI_D0, unless the system is
   entering a suspend (or hibernate) system state.

 - Only use platform_pci_choose_state() when entering a suspend
   state ... and avoid PCI_D1 and PCI_D2 when appropriate.

 - Corrrect kerneldoc.

Note that for now only ACPI provides platform_pci_choose_state(), so
this could be a minor change in behavior on some non-PC systems:  it
avoids D3 except in the final stage of hibernation.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/pci/pci.c |   47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

--- g26.orig/drivers/pci/pci.c	2008-02-24 00:18:16.000000000 -0800
+++ g26/drivers/pci/pci.c	2008-02-24 00:41:18.000000000 -0800
@@ -523,44 +523,49 @@ pci_set_power_state(struct pci_dev *dev,
 }
 
 pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
- 
+
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system. This is the value
- *	that is passed to suspend() function.
+ * @mesg: value passed to suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
- * message.
+ * power state transition.
  */
 
-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t mesg)
 {
 	pci_power_t ret;
 
+	/* PCI legacy PM? */
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
-	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
-		if (ret != PCI_POWER_ERROR)
-			return ret;
-	}
-
-	switch (state.event) {
-	case PM_EVENT_ON:
-		return PCI_D0;
-	case PM_EVENT_FREEZE:
-	case PM_EVENT_PRETHAW:
-		/* REVISIT both freeze and pre-thaw "should" use D0 */
+	switch (mesg.event) {
 	case PM_EVENT_SUSPEND:
+		/* NOTE:  platform_pci_choose_state() should only return
+		 * states where wakeup won't work if
+		 *   - !device_may_wakeup(&dev->dev), or
+		 *   - dev can't wake from the target system state
+		 */
+		if (platform_pci_choose_state) {
+			ret = platform_pci_choose_state(dev, mesg);
+			if (ret == PCI_POWER_ERROR)
+				ret = PCI_D3hot;
+			else if ((ret == PCI_D1 || ret == PCI_D2)
+					&& pci_no_d1d2(dev))
+				ret = PCI_D3hot;
+			break;
+		}
+		/* FALLTHROUGH ... D3hot works, but may be suboptimal */
 	case PM_EVENT_HIBERNATE:
-		return PCI_D3hot;
+		ret = PCI_D3hot;
+		break;
 	default:
-		printk("Unrecognized suspend event %d\n", state.event);
-		BUG();
+		ret = PCI_D0;
+		break;
 	}
-	return PCI_D0;
+	return ret;
 }
 
 EXPORT_SYMBOL(pci_choose_state);
