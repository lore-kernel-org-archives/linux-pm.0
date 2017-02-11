From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA configuration
Date: Sat, 11 Feb 2017 09:27:17 +0800
Message-ID: <1486776443-2280-7-git-send-email-peter.chen@nxp.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: mark.rutland@arm.com, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, gary.bisson@boundarydevices.com, Vivek Gautam <vivek.gautam@codeaurora.org>, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, Baolin Wang <baolin.wang@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, jun.li@nxp.com
List-Id: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

For xhci-hcd platform device, all the DMA parameters are not
configured properly, notably dma ops for dwc3 devices. So, set
the dma for xhci from sysdev. sysdev is pointing to device that
is known to the system firmware or hardware.

Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
---
Hi, Baolin, Vivek and Alexander,
I removed your tested-by tag due to add one change that adding sysdev
for shared hcd too, if your test shows this change works for you or
has no effect for you, please consider adding tested-by tag again,
thanks.

 drivers/usb/host/xhci-mem.c  | 12 ++++++------
 drivers/usb/host/xhci-plat.c | 35 +++++++++++++++++++++++++++--------
 drivers/usb/host/xhci.c      | 15 +++++++++++----
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index ba1853f4..032a702 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -586,7 +586,7 @@ static void xhci_free_stream_ctx(struct xhci_hcd *xhci,
 		unsigned int num_stream_ctxs,
 		struct xhci_stream_ctx *stream_ctx, dma_addr_t dma)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	size_t size = sizeof(struct xhci_stream_ctx) * num_stream_ctxs;
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
@@ -614,7 +614,7 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 		unsigned int num_stream_ctxs, dma_addr_t *dma,
 		gfp_t mem_flags)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	size_t size = sizeof(struct xhci_stream_ctx) * num_stream_ctxs;
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
@@ -1686,7 +1686,7 @@ void xhci_slot_copy(struct xhci_hcd *xhci,
 static int scratchpad_alloc(struct xhci_hcd *xhci, gfp_t flags)
 {
 	int i;
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	int num_sp = HCS_MAX_SCRATCHPAD(xhci->hcs_params2);
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
@@ -1758,7 +1758,7 @@ static void scratchpad_free(struct xhci_hcd *xhci)
 {
 	int num_sp;
 	int i;
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	if (!xhci->scratchpad)
 		return;
@@ -1831,7 +1831,7 @@ void xhci_free_command(struct xhci_hcd *xhci,
 
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
-	struct device	*dev = xhci_to_hcd(xhci)->self.controller;
+	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
 	int size;
 	int i, j, num_ports;
 
@@ -2373,7 +2373,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 {
 	dma_addr_t	dma;
-	struct device	*dev = xhci_to_hcd(xhci)->self.controller;
+	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int	val, val2;
 	u64		val_64;
 	struct xhci_segment	*seg;
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6d33b42..4ecb3fd 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/usb/phy.h>
@@ -148,6 +149,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	const struct hc_driver	*driver;
+	struct device		*sysdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -164,22 +166,39 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
+	/*
+	 * sysdev must point to a device that is known to the system firmware
+	 * or PCI hardware. We handle these three cases here:
+	 * 1. xhci_plat comes from firmware
+	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
+	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
+	 */
+	sysdev = &pdev->dev;
+	if (sysdev->parent && !sysdev->of_node && sysdev->parent->of_node)
+		sysdev = sysdev->parent;
+#ifdef CONFIG_PCI
+	else if (sysdev->parent && sysdev->parent->parent &&
+		 sysdev->parent->parent->bus == &pci_bus_type)
+		sysdev = sysdev->parent->parent;
+#endif
+
 	/* Try to set 64-bit DMA first */
-	if (!pdev->dev.dma_mask)
+	if (WARN_ON(!sysdev->dma_mask))
 		/* Platform did not initialize dma_mask */
-		ret = dma_coerce_mask_and_coherent(&pdev->dev,
+		ret = dma_coerce_mask_and_coherent(sysdev,
 						   DMA_BIT_MASK(64));
 	else
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
 
 	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
 	if (ret) {
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
 		if (ret)
 			return ret;
 	}
 
-	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
+			       dev_name(&pdev->dev), NULL);
 	if (!hcd)
 		return -ENOMEM;
 
@@ -222,20 +241,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	xhci->clk = clk;
 	xhci->main_hcd = hcd;
-	xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
+	xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
 			dev_name(&pdev->dev), hcd);
 	if (!xhci->shared_hcd) {
 		ret = -ENOMEM;
 		goto disable_clk;
 	}
 
-	if (device_property_read_bool(&pdev->dev, "usb3-lpm-capable"))
+	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 
 	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
 		xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
-	hcd->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
+	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
 		if (ret == -EPROBE_DEFER)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6d6c460..ab0839c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -237,6 +237,9 @@ static int xhci_free_msi(struct xhci_hcd *xhci)
 static int xhci_setup_msi(struct xhci_hcd *xhci)
 {
 	int ret;
+	/*
+	 * TODO:Check with MSI Soc for sysdev
+	 */
 	struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
 
 	ret = pci_enable_msi(pdev);
@@ -263,7 +266,7 @@ static int xhci_setup_msi(struct xhci_hcd *xhci)
  */
 static void xhci_free_irq(struct xhci_hcd *xhci)
 {
-	struct pci_dev *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
+	struct pci_dev *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
 	int ret;
 
 	/* return if using legacy interrupt */
@@ -748,7 +751,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 
 	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
-		usb_disable_xhci_ports(to_pci_dev(hcd->self.controller));
+		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
 
 	spin_lock_irq(&xhci->lock);
 	xhci_halt(xhci);
@@ -765,7 +768,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
 
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(to_pci_dev(hcd->self.controller), PCI_D3hot);
+		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
 }
 
 #ifdef CONFIG_PM
@@ -4801,7 +4804,11 @@ int xhci_get_frame(struct usb_hcd *hcd)
 int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 {
 	struct xhci_hcd		*xhci;
-	struct device		*dev = hcd->self.controller;
+	/*
+	 * TODO: Check with DWC3 clients for sysdev according to
+	 * quirks
+	 */
+	struct device		*dev = hcd->self.sysdev;
 	int			retval;
 
 	/* Accept arbitrarily long scatter-gather lists */
-- 
2.7.4
