From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Fri, 21 Mar 2008 00:53:03 -0700
Message-ID: <200803210053.04330.david-b__12597.675008192$1206087700$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<20080320230301.8EFB235F4AF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200803210122.44188.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210122.44188.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 20 March 2008, Rafael J. Wysocki wrote:
> The original code executed platform_pci_choose_state() first, if defined, and
> if that succeeded, it just returned the result.  You put
> platform_pci_choose_state() under the switch(). :-)

So the updated patch just chooses a new state when drivers are
supposed to enter a lowpowerstate:  SUSPEND and HIBERNATE.
Appended.


> In fact the entire switch() in pci_choose_state() is just confusing.

All it does is implement the rules that have been defined for
ages now:  most of the pm_message_t transitions should not
change device power states.


> I'd make 
> it return PCI_D3hot if platform_pci_choose_state() is undefined or fails

See above:  this implements the current rules, which say
that in most cases devices shoudn't change powerstates.


> > > I really don't think pci_choose_state() should take the state argument at all.
> > 
> > There is no "state" argument.  It's a pm_message_t, which does
> > not package the target state.
> 
> Correct, but the pm_message_t argument is called 'state', confusingly so.

Which was (and is!) one of the cleanups in $SUBJECT.

- Dave


======== CUT HERE
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
 drivers/pci/pci.c |   49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

--- g26.orig/drivers/pci/pci.c	2008-03-20 03:02:46.000000000 -0700
+++ g26/drivers/pci/pci.c	2008-03-21 00:51:19.000000000 -0700
@@ -523,46 +523,49 @@ pci_set_power_state(struct pci_dev *dev,
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
-
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
 	case PM_EVENT_HIBERNATE:
-		return PCI_D3hot;
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
+		/* D3hot works, but may be suboptimal */
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
-
 EXPORT_SYMBOL(pci_choose_state);
 
 static int pci_save_pcie_state(struct pci_dev *dev)
