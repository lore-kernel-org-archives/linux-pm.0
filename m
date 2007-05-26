From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Sat, 26 May 2007 14:14:00 +0200 (CEST)
Message-ID: <tkrat.522e284271bb5d02__49250.5319104113$1180181714$gmane$org@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>
	<464DDB85.7080203@s5r6.in-berlin.de>
	<tkrat.a98b66b055229e9d@s5r6.in-berlin.de>
	<200705210725.55299.marcus@better.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705210725.55299.marcus@better.se>
Content-Disposition: INLINE
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Marcus Better wrote:
> Now it hangs on the second suspend to RAM (at suspend, not resume).

Unless Kristian implements something better before release, we might go
with the following patch.  Does it abort s2ram as I intend?

(It does not abort APM suspend, but on the APM notebook I tested with
2.6.20 and the new firewire drivers, I could unload and reload fw-ohci
after APM resume without problem.  I still have no machine which
supports s2ram, and the APM machine is too slow to do driver development
on it.  I might try to install suspend2 for hibernate-to-swapfile on a
reasonable machine, but not earlier than in two weeks.  Therefore don't
expect anything better than the below from me anytime soon.)

 
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: firewire: suspend/resume is unimplemented

2.6.22-rc1 reportedly hangs in resume if fw-ohci is loaded.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/fw-ohci.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux/drivers/firewire/fw-ohci.c
===================================================================
--- linux.orig/drivers/firewire/fw-ohci.c
+++ linux/drivers/firewire/fw-ohci.c
@@ -1908,6 +1908,19 @@ static void pci_remove(struct pci_dev *d
 	fw_notify("Removed fw-ohci device.\n");
 }
 
+#ifdef CONFIG_PM
+static int pci_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	fw_notify("ERROR: Unload this driver before hibernate or suspend\n");
+	return -ENOSYS;
+}
+
+static int pci_resume(struct pci_dev *dev)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_device_id pci_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_FIREWIRE_OHCI, ~0) },
 	{ }
@@ -1920,6 +1933,10 @@ static struct pci_driver fw_ohci_pci_dri
 	.id_table	= pci_table,
 	.probe		= pci_probe,
 	.remove		= pci_remove,
+#ifdef CONFIG_PM
+	.suspend	= pci_suspend,
+	.resume		= pci_resume,
+#endif
 };
 
 MODULE_AUTHOR("Kristian Hoegsberg <krh@bitplanet.net>");


-- 
Stefan Richter
-=====-=-=== -=-= ==-=-
http://arcgraph.de/sr/
