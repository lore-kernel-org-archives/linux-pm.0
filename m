From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 0/5] Functional dependencies between devices
Date: Mon, 3 Oct 2016 01:13:13 +0200
Message-ID: <20161002231313.GA710@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <10860219.QqH5akBVoh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:52115 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbcJBXNW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Oct 2016 19:13:22 -0400
Content-Disposition: inline
In-Reply-To: <10860219.QqH5akBVoh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Andreas Noever <andreas.noever@gmail.com>

[+cc Andreas Noever]

On Thu, Sep 29, 2016 at 02:24:58AM +0200, Rafael J. Wysocki wrote:
> On Thursday, September 08, 2016 11:25:44 PM Rafael J. Wysocki wrote:
> > > This is a refresh of the functional dependencies series that I posted
> > > last year and which has been picked up by Marek quite recently.

I've cooked up a patch to replace quirk_apple_wait_for_thunderbolt()
in drivers/pci/quirks.c with the "device links" functionality added by
Rafael's series quoted above.

The patch is included below.  I've also pushed a branch to GitHub which
comprises Rafael's series plus the patch on top:
https://github.com/l1k/linux/commits/device_links

One issue that cropped up is that the API does not provide public
functions to lock a device's link lists for traversal.  Thus when
iterating over the links and deleting them in the thunderbolt driver's
->remove hook, the list is completely unprotected.  It's not an issue
for this particular use case as noone else but this driver adds or
deletes links to the NHI, it just *looks* a bit fishy and there may
be other use cases where locking matters.  Maybe patch [2/5] should
export device_links_read_lock() / device_links_read_unlock()?

Apart from that, everything seems to work as it should:

On driver load:
[   13.829752] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[...]
[   13.853747] pcieport 0000:06:03.0: Linked as a consumer to 0000:07:00.0
[   13.853749] pcieport 0000:06:04.0: Linked as a consumer to 0000:07:00.0
[   13.853751] pcieport 0000:06:05.0: Linked as a consumer to 0000:07:00.0
[   13.853753] pcieport 0000:06:06.0: Linked as a consumer to 0000:07:00.0

Those are the four hotplug ports on the controller.

On driver unload:
[   89.378691] pcieport 0000:06:03.0: Dropping the link to 0000:07:00.0
[   89.383346] pcieport 0000:06:04.0: Dropping the link to 0000:07:00.0
[   89.387977] pcieport 0000:06:05.0: Dropping the link to 0000:07:00.0
[   89.392589] pcieport 0000:06:06.0: Dropping the link to 0000:07:00.0
[...]
[   89.424511] thunderbolt 0000:07:00.0: shutdown

On resume from system sleep:
[  282.537470] ACPI: Waking up from system sleep state S3
[...]
[  282.625378] pcieport 0000:06:04.0: start waiting for 0000:07:00.0
[  282.625380] pcieport 0000:06:03.0: start waiting for 0000:07:00.0
[  282.625382] pcieport 0000:06:05.0: start waiting for 0000:07:00.0
[  282.625383] pcieport 0000:06:06.0: start waiting for 0000:07:00.0
[  282.656789] thunderbolt 0000:07:00.0: resuming...
[...]
[  283.500660] thunderbolt 0000:07:00.0: resume finished
[  283.500672] pcieport 0000:06:04.0:  done waiting for 0000:07:00.0
[  283.500673] pcieport 0000:06:03.0:  done waiting for 0000:07:00.0
[  283.500675] pcieport 0000:06:05.0:  done waiting for 0000:07:00.0
[  283.500677] pcieport 0000:06:06.0:  done waiting for 0000:07:00.0
[  283.564849] PM: noirq resume of devices complete after 971.845 msecs
[  283.564868] pciehp 0000:06:04.0:pcie204: Slot(4-1): Card present
[  283.564873] pciehp 0000:06:04.0:pcie204: Slot(4-1): Link Up

The "start waiting for" and "done waiting for" messages are debug
printk's that I had put in there.  I've also rebased and tested this
on my Thunderbolt runpm series and the only difference is that the
dpm_wait() is only executed for port 0000:06:04.0 (the one which
actually has a device connected), the three other hotplug ports use
direct_complete.

So Rafael's series is now also

Tested-by: Lukas Wunner <lukas@wunner.de>

though it should be noted that my patch does not make use of the optional
DEVICE_LINK_PM_RUNTIME flag introduced with patch [4/5].  (But I believe
Marek has tested that feature.)

Thanks,

Lukas

-- >8 --
Subject: [PATCH] thunderbolt: Use device links instead of PCI quirk

When resuming from system sleep, attached Thunderbolt devices are
inaccessible until the NHI has re-established PCI tunnels to them.  As a
consequence, the Thunderbolt controller's hotplug bridges (below which
the attached devices appear) must delay resuming until the NHI has
finished.  That requirement is not enforced by the PM core automatically
as it only guarantees correct resume ordering between parent and child,
and the NHI is not a parent of the hotplug bridges, but rather a niece.

So far we've open coded this requirement in a PCI quirk, which has the
following disadvantages:

- The code for the NHI resides in drivers/thunderbolt/, whereas the code
  for the hotplug bridges resides in drivers/pci/quirks.c, which may be
  surprising and non-obvious in particular for new contributors.

- Whenever support for an additional Thunderbolt controller is added,
  its PCI device ID needs to be amended in both places, which invites
  mistakes.  E.g. commit a42fb351ca1f ("thunderbolt: Allow loading of
  module on recent Apple MacBooks with thunderbolt 2 controller")
  relaxed the subvendor and subdevice ID in the NHI code but forgot to
  also change the hotplug bridge code.

- Since the PCI quirk cannot keep any state, it has to search for the
  NHI over and over again on every resume.

The PM core has just gained the ability to declare "device links", i.e.
dependencies between devices beyond the mere parent/child relationship.

Replace the PCI quirk with device links from the hotplug bridges to the
NHI.  The device links are set up when loading the thunderbolt driver
and torn down when it is removed.  The PM core takes care of everything
else.  As a bonus, the amount of code is reduced considerably.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/quirks.c      | 56 -----------------------------------------------
 drivers/thunderbolt/nhi.c | 28 ++++++++++++++++++++++--
 drivers/thunderbolt/tb.h  |  1 +
 3 files changed, 27 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44e0ff3..9b78a03 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3293,62 +3293,6 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
-
-/*
- * Apple: Wait for the thunderbolt controller to reestablish pci tunnels.
- *
- * During suspend the thunderbolt controller is reset and all pci
- * tunnels are lost. The NHI driver will try to reestablish all tunnels
- * during resume. We have to manually wait for the NHI since there is
- * no parent child relationship between the NHI and the tunneled
- * bridges.
- */
-static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
-{
-	struct pci_dev *sibling = NULL;
-	struct pci_dev *nhi = NULL;
-
-	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
-		return;
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
-		return;
-	/*
-	 * Find the NHI and confirm that we are a bridge on the tb host
-	 * controller and not on a tb endpoint.
-	 */
-	sibling = pci_get_slot(dev->bus, 0x0);
-	if (sibling == dev)
-		goto out; /* we are the downstream bridge to the NHI */
-	if (!sibling || !sibling->subordinate)
-		goto out;
-	nhi = pci_get_slot(sibling->subordinate, 0x0);
-	if (!nhi)
-		goto out;
-	if (nhi->vendor != PCI_VENDOR_ID_INTEL
-		    || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
-			nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
-			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI &&
-			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
-		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
-		goto out;
-	dev_info(&dev->dev, "quirk: waiting for thunderbolt to reestablish PCI tunnels...\n");
-	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
-out:
-	pci_dev_put(nhi);
-	pci_dev_put(sibling);
-}
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
-			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
-			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
-			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
-			       quirk_apple_wait_for_thunderbolt);
 #endif
 
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index a8c2041..e57f2e4 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -533,6 +533,21 @@ static void nhi_shutdown(struct tb_nhi *nhi)
 	mutex_destroy(&nhi->lock);
 }
 
+static int nhi_device_link_add_cb(struct pci_dev *pdev, void *ptr)
+{
+	struct tb *tb = ptr;
+
+	/*
+	 * Let all downstream bridges of the switch depend on the NHI, except
+	 * for the NHI's parent bridge.  This forces them to dpm_wait() in the
+	 * ->resume_noirq phase until the NHI has re-established the tunnels.
+	 */
+	if (pdev->bus == tb->downstream0->bus && pdev != tb->downstream0)
+		device_link_add(&pdev->dev, &tb->nhi->pdev->dev,
+				DEVICE_LINK_NO_STATE, DEVICE_LINK_STATELESS);
+	return 0;
+}
+
 static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct tb_nhi *nhi;
@@ -605,6 +620,10 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	pci_set_drvdata(pdev, tb);
 
+	tb->downstream0 = pci_upstream_bridge(pdev);
+	if (tb->downstream0)
+		pci_walk_bus(tb->downstream0->bus, nhi_device_link_add_cb, tb);
+
 	return 0;
 }
 
@@ -612,14 +631,19 @@ static void nhi_remove(struct pci_dev *pdev)
 {
 	struct tb *tb = pci_get_drvdata(pdev);
 	struct tb_nhi *nhi = tb->nhi;
+	struct device_link *link, *ln;
+
+	list_for_each_entry_safe(link, ln, &pdev->dev.links_to_consumers, s_node)
+		device_link_del(link);
+
 	thunderbolt_shutdown_and_free(tb);
 	nhi_shutdown(nhi);
 }
 
 /*
  * The tunneled pci bridges are siblings of us. Use resume_noirq to reenable
- * the tunnels asap. A corresponding pci quirk blocks the downstream bridges
- * resume_noirq until we are done.
+ * the tunnels asap. Device links block the downstream bridges' resume_noirq
+ * until we are done.
  */
 static const struct dev_pm_ops nhi_pm_ops = {
 	.suspend_noirq = nhi_suspend_noirq,
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 61d57ba..f9c45d5 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -106,6 +106,7 @@ struct tb {
 	struct workqueue_struct *wq; /* ordered workqueue for plug events */
 	struct tb_switch *root_switch;
 	struct list_head tunnel_list; /* list of active PCIe tunnels */
+	struct pci_dev *downstream0; /* downstream bridge to the NHI */
 	bool hotplug_active; /*
 			      * tb_handle_hotplug will stop progressing plug
 			      * events and exit if this is not set (it needs to
-- 
2.9.3

