From: "Henroid, Andrew D" <andrew.d.henroid@intel.com>
Subject: Re: [PATCH] i7300_idle: allow testing on i5000-series
 hardware w/o re-compile
Date: Thu, 28 May 2009 00:34:47 -0600
Message-ID: <72D8A09E39A89147BE9CFBB6F0C73C30606664E1F3@rrsmsx501.amr.corp.intel.com>
References: <alpine.LFD.2.00.0905280024310.25587@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0905280024310.25587@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Acked-by: Andrew Henroid <andrew.d.henroid@intel.com> 

-----Original Message-----
From: Len Brown [mailto:lenb@kernel.org] 
Sent: Wednesday, May 27, 2009 10:25 PM
To: Henroid, Andrew D; Pallipadi, Venkatesh
Cc: linux-pm@lists.linux-foundation.org
Subject: [PATCH] i7300_idle: allow testing on i5000-series hardware w/o re-compile

From: Len Brown <len.brown@intel.com>

Testing the i7300_idle driver on i5000-series hardware required
an edit to i7300_idle.h to "#define SUPPORT_I5000 1" and a re-build.

Replace that build-time scheme with a load-time module parameter:
"7300_idle.forceload=1" to make it easier to test the driver
on hardware that is not officially supported.

The default is unchanged -- without this parameter,
the driver will continue to load only on the i7300-series.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/i7300_idle.c  |    3 +++
 include/linux/i7300_idle.h |   15 +++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index bf74039..98b82c7 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -41,6 +41,9 @@ static int debug;
 module_param_named(debug, debug, uint, 0644);
 MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
 
+module_param_named(forceload, forceload, uint, 0644);
+MODULE_PARM_DESC(debug, "Enable driver testing on unsupported i5000");
+
 #define dprintk(fmt, arg...) \
 	do { if (debug) printk(KERN_INFO I7300_PRINT fmt, ##arg); } while (0)
 
diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
index 05a80c4..46bae33 100644
--- a/include/linux/i7300_idle.h
+++ b/include/linux/i7300_idle.h
@@ -16,6 +16,7 @@
 struct fbd_ioat {
 	unsigned int vendor;
 	unsigned int ioat_dev;
+	unsigned int enabled;
 };
 
 /*
@@ -23,22 +24,18 @@ struct fbd_ioat {
  * but support is disabled by default because this driver
  * has not been validated on that platform.
  */
-#define SUPPORT_I5000 0
+static unsigned int forceload;
 
-static const struct fbd_ioat fbd_ioat_list[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB},
-#if SUPPORT_I5000
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT},
-#endif
+static struct fbd_ioat fbd_ioat_list[] = {
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB, 1},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT, 0},
 	{0, 0}
 };
 
 /* table of devices that work with this driver */
 static const struct pci_device_id pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_FBD_CNB) },
-#if SUPPORT_I5000
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
-#endif
 	{ } /* Terminating entry */
 };
 
@@ -69,6 +66,8 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
 	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
 		if (dmadev->vendor == fbd_ioat_list[i].vendor &&
 		    dmadev->device == fbd_ioat_list[i].ioat_dev) {
+			if (!(fbd_ioat_list[i].enabled || forceload))
+				continue;
 			if (fbd_dev)
 				*fbd_dev = memdev;
 			if (ioat_dev)
-- 
1.6.3.1.169.g33fd
