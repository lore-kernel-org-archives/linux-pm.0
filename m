From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Sun, 20 May 2007 15:50:49 +0200 (CEST)
Message-ID: <tkrat.a98b66b055229e9d__25358.4760510877$1179669178$gmane$org@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>
	<20070518082821.230dd4c5.akpm@linux-foundation.org>
	<464DDB85.7080203@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464DDB85.7080203@s5r6.in-berlin.de>
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

>> On Fri, 18 May 2007 12:07:40 +0200 Marcus Better <marcus@better.se> wrote:
>>> the fw-ohci driver breaks suspend to RAM on my Thinkpad R60, Intel Core 2 Duo, 
>>> kernel 2.6.22-rc1 (x86_64, SMP). It does suspend but hangs on resume if the 
>>> fw-ohci module is loaded.

Could you test the following patch?  I don't have a machine to test it
myself at the moment but may have one tonight or tomorrow.


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: firewire: simple support for suspend/resume

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/fw-ohci.c |   37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

Index: linux/drivers/firewire/fw-ohci.c
===================================================================
--- linux.orig/drivers/firewire/fw-ohci.c
+++ linux/drivers/firewire/fw-ohci.c
@@ -1716,8 +1716,11 @@ static int software_reset(struct fw_ohci
 	return -EBUSY;
 }
 
-static int __devinit
-pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
+static int
+#ifndef CONFIG_PM
+__devinit
+#endif
+pci_probe_or_resume(struct pci_dev *dev)
 {
 	struct fw_ohci *ohci;
 	u32 bus_options, max_receive, link_speed;
@@ -1879,6 +1882,12 @@ pci_probe(struct pci_dev *dev, const str
 	return err;
 }
 
+static int __devinit
+pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
+{
+	return pci_probe_or_resume(dev);
+}
+
 static void pci_remove(struct pci_dev *dev)
 {
 	struct fw_ohci *ohci;
@@ -1907,6 +1916,26 @@ static void pci_remove(struct pci_dev *d
 	fw_notify("Removed fw-ohci device.\n");
 }
 
+#ifdef CONFIG_PM
+/*
+ * FIXME: Implement it as transparent to upper layers as possible.  To those
+ * drivers without special requirements, a suspend--resume cycle should merely
+ * look like a prolonged bus reset phase.  For example, fw-sbp2 should just
+ * re-login after resume.
+ */
+static int pci_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	pci_remove(dev);
+	return 0;
+}
+
+static int pci_resume(struct pci_dev *dev)
+{
+	pci_probe_or_resume(dev);
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_device_id pci_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_FIREWIRE_OHCI, ~0) },
 	{ }
@@ -1919,6 +1948,10 @@ static struct pci_driver fw_ohci_pci_dri
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
-=====-=-=== -=-= =-=--
http://arcgraph.de/sr/
