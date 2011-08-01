From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] mrst_pmu: driver for Intel Moorestown Power
	Management Unit
Date: Mon, 01 Aug 2011 11:24:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108011116160.23581__48793.0192066871$1312212346$gmane$org@x980>
References: <alpine.LFD.2.02.1107122328180.4502@x980>
	<20110713105105.63e2fbcb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110713105105.63e2fbcb@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> > +	BUG_ON(pci_dev_num != mrst_devs[index].pci_dev_num);
> 
> That strikes me as needlessly unfriendly, you could warn/return NULL and
> propogate a WARN_ONCE back to the user.

If a fit of friendlyness, I wrote the patch below.
Let me know if it is not what you had in mind.

thanks
-Len

>From 0f72ff0114695d48ecdd7270998148d61236341d Mon Sep 17 00:00:00 2001
From: Len Brown <len.brown@intel.com>
Date: Mon, 1 Aug 2011 11:13:37 -0400
Subject: [PATCH] msrt_pmu: add friendly firmware debugging code

MRST firmware has already been debugged, but this patch
makes the kernel fail more gently should somebody break
it in the future by inventing a device that is not in the SOC.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/platform/mrst/pmu.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/mrst/pmu.c b/arch/x86/platform/mrst/pmu.c
index f8c6d8f..ee3afb1 100644
--- a/arch/x86/platform/mrst/pmu.c
+++ b/arch/x86/platform/mrst/pmu.c
@@ -96,7 +96,7 @@ static u32 pmu_set_power_state_send_cmd;
 
 static struct mrst_device *pci_id_2_mrst_dev(u16 pci_dev_num)
 {
-	int index;
+	int index = 0;
 
 	if ((pci_dev_num >= 0x0800) && (pci_dev_num <= 0x815))
 		index = pci_dev_num - 0x800;
@@ -106,10 +106,11 @@ static struct mrst_device *pci_id_2_mrst_dev(u16 pci_dev_num)
 		index = 23;
 	else if (pci_dev_num == 0x4110)
 		index = 24;
-	else
-		BUG();
 
-	BUG_ON(pci_dev_num != mrst_devs[index].pci_dev_num);
+	if (pci_dev_num != mrst_devs[index].pci_dev_num) {
+		WARN_ONCE(1, FW_BUG "Unknown PCI device 0x%04X\n", pci_dev_num);
+		return 0;
+	}
 
 	return &mrst_devs[index];
 }
@@ -356,7 +357,13 @@ static u16 pmu_min_lss_pci_req(u16 *ids, u16 pci_state)
 	int i;
 
 	for (i = 0; ids[i]; ++i) {
-		existing_request = pci_id_2_mrst_dev(ids[i])->latest_request;
+		struct mrst_device *mrst_dev;
+
+		mrst_dev = pci_id_2_mrst_dev(ids[i]);
+		if (unlikely(!mrst_dev))
+			continue;
+
+		existing_request = mrst_dev->latest_request;
 		if (existing_request < pci_state)
 			pci_state = existing_request;
 	}
@@ -380,6 +387,9 @@ int pmu_pci_set_power_state(struct pci_dev *pdev, pci_power_t pci_state)
 	BUG_ON(pci_state < PCI_D0 || pci_state > PCI_D3cold);
 
 	mrst_dev = pci_id_2_mrst_dev(pdev->device);
+	if (unlikely(!mrst_dev))
+		return -ENODEV;
+
 	mrst_dev->pci_state_counts[pci_state]++;	/* count invocations */
 
 	/* PMU driver calls self as part of PCI initialization, ignore */
@@ -499,6 +509,10 @@ static int debug_mrst_pmu_show(struct seq_file *s, void *unused)
 			pdev->vendor, pdev->device,
 			dev_driver_string(&pdev->dev));
 
+		if (unlikely (!mrst_dev)) {
+			seq_printf(s, " UNKNOWN\n");
+			continue;
+		}
 
 		if (mrst_dev->lss)
 			seq_printf(s, "LSS %2d %-4s ", mrst_dev->lss,
@@ -598,6 +612,12 @@ static void pmu_scu_firmware_debug(void)
 		int pos;
 
 		mrst_dev = pci_id_2_mrst_dev(pdev->device);
+		if (unlikely(!mrst_dev)) {
+			printk(KERN_ERR FW_BUG "pmu: Unknown "
+				"PCI device 0x%04X\n", pdev->device);
+			continue;
+		}
+
 		if (mrst_dev->lss == 0)
 			continue;	 /* no LSS in our table */
 
-- 
1.7.4.4
