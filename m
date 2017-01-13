From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 2/4] dmaengine: Forward slave device pointer to of_xlate
 callback
Date: Fri, 13 Jan 2017 08:26:38 +0100
Message-ID: <1484292400-29730-3-git-send-email-m.szyprowski@samsung.com>
References: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170113072652eucas1p26808878c01db8a6132978de974b12546@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add pointer to slave device to of_dma_xlate to let DMA engine driver
to know which slave device is using given DMA channel. This will be
later used to implement non-irq-safe runtime PM for DMA engine driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/amba-pl08x.c        |  2 +-
 drivers/dma/at_hdmac.c          |  4 ++--
 drivers/dma/at_xdmac.c          |  2 +-
 drivers/dma/bcm2835-dma.c       |  2 +-
 drivers/dma/coh901318.c         |  2 +-
 drivers/dma/cppi41.c            |  2 +-
 drivers/dma/dma-jz4780.c        |  2 +-
 drivers/dma/dmaengine.c         |  2 +-
 drivers/dma/dw/platform.c       |  2 +-
 drivers/dma/edma.c              |  4 ++--
 drivers/dma/fsl-edma.c          |  2 +-
 drivers/dma/img-mdc-dma.c       |  2 +-
 drivers/dma/imx-dma.c           |  2 +-
 drivers/dma/imx-sdma.c          |  2 +-
 drivers/dma/k3dma.c             |  2 +-
 drivers/dma/lpc18xx-dmamux.c    |  2 +-
 drivers/dma/mmp_pdma.c          |  2 +-
 drivers/dma/mmp_tdma.c          |  2 +-
 drivers/dma/moxart-dma.c        |  2 +-
 drivers/dma/mxs-dma.c           |  2 +-
 drivers/dma/nbpfaxi.c           |  2 +-
 drivers/dma/of-dma.c            | 20 ++++++++++++--------
 drivers/dma/pl330.c             |  3 ++-
 drivers/dma/pxa_dma.c           |  2 +-
 drivers/dma/qcom/bam_dma.c      |  2 +-
 drivers/dma/sh/rcar-dmac.c      |  2 +-
 drivers/dma/sh/shdma-of.c       |  2 +-
 drivers/dma/sh/usb-dmac.c       |  2 +-
 drivers/dma/sirf-dma.c          |  2 +-
 drivers/dma/st_fdma.c           |  2 +-
 drivers/dma/ste_dma40.c         |  2 +-
 drivers/dma/stm32-dma.c         |  2 +-
 drivers/dma/sun4i-dma.c         |  2 +-
 drivers/dma/sun6i-dma.c         |  2 +-
 drivers/dma/tegra20-apb-dma.c   |  2 +-
 drivers/dma/tegra210-adma.c     |  2 +-
 drivers/dma/xilinx/xilinx_dma.c |  2 +-
 drivers/dma/xilinx/zynqmp_dma.c |  2 +-
 drivers/dma/zx_dma.c            |  2 +-
 include/linux/of_dma.h          | 17 +++++++++--------
 40 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 0b7c6ce629a6..194089c98755 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2059,7 +2059,7 @@ static struct dma_chan *pl08x_find_chan_id(struct pl08x_driver_data *pl08x,
 }
 
 static struct dma_chan *pl08x_of_xlate(struct of_phandle_args *dma_spec,
-				       struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct pl08x_driver_data *pl08x = ofdma->of_dma_data;
 	struct dma_chan *dma_chan;
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 1baf3404a365..b228b263ac0c 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1788,7 +1788,7 @@ static bool at_dma_filter(struct dma_chan *chan, void *slave)
 }
 
 static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
-				     struct of_dma *of_dma)
+				    struct of_dma *of_dma, struct device *slave)
 {
 	struct dma_chan *chan;
 	struct at_dma_chan *atchan;
@@ -1847,7 +1847,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 }
 #else
 static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
-				     struct of_dma *of_dma)
+				    struct of_dma *of_dma, struct device *slave)
 {
 	return NULL;
 }
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7d4e0bcda9af..9ddd868c9b59 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -508,7 +508,7 @@ static inline void at_xdmac_increment_block_count(struct dma_chan *chan,
 }
 
 static struct dma_chan *at_xdmac_xlate(struct of_phandle_args *dma_spec,
-				       struct of_dma *of_dma)
+				    struct of_dma *of_dma, struct device *slave)
 {
 	struct at_xdmac		*atxdmac = of_dma->of_dma_data;
 	struct at_xdmac_chan	*atchan;
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e18dc596cf24..e9c417ad2141 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -877,7 +877,7 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
 MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
 
 static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct bcm2835_dmadev *d = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 74794c9859f6..dbc4fb44f326 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1779,7 +1779,7 @@ static bool coh901318_filter_base_and_id(struct dma_chan *chan, void *data)
 }
 
 static struct dma_chan *coh901318_xlate(struct of_phandle_args *dma_spec,
-					struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct coh901318_filter_args args = {
 		.base = ofdma->of_dma_data,
diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index d5ba43a87a68..389a2278b6a0 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -932,7 +932,7 @@ static bool cpp41_dma_filter_fn(struct dma_chan *chan, void *param)
 };
 
 static struct dma_chan *cppi41_dma_xlate(struct of_phandle_args *dma_spec,
-		struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	int count = dma_spec->args_count;
 	struct of_dma_filter_info *info = ofdma->of_dma_data;
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7373b7a555ec..f65f71649898 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -707,7 +707,7 @@ static bool jz4780_dma_filter_fn(struct dma_chan *chan, void *param)
 }
 
 static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
-	struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct jz4780_dma_dev *jzdma = ofdma->of_dma_data;
 	dma_cap_mask_t mask = jzdma->dma_device.cap_mask;
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 24e0221fd66d..721fa0bee7f5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -708,7 +708,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 
 	/* If device-tree is present get slave info from here */
 	if (dev->of_node)
-		chan = of_dma_request_slave_channel(dev->of_node, name);
+		chan = of_dma_request_slave_channel(dev, name);
 
 	/* If device was enumerated by ACPI get slave info from here */
 	if (has_acpi_companion(dev) && !chan)
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index b1655e40cfa2..1eb8a31b6775 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -29,7 +29,7 @@
 #define DRV_NAME	"dw_dmac"
 
 static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
-					struct of_dma *ofdma)
+				 struct of_dma *ofdma, struct device *slave_dev)
 {
 	struct dw_dma *dw = ofdma->of_dma_data;
 	struct dw_dma_slave slave = {
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3879f80a4815..d2e7d893d984 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2117,7 +2117,7 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 }
 
 static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
-				      struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct edma_cc *ecc = ofdma->of_dma_data;
 	struct dma_chan *chan = NULL;
@@ -2161,7 +2161,7 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 }
 
 static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
-				      struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	return NULL;
 }
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 6775f2c74e25..915aa8182204 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -750,7 +750,7 @@ static void fsl_edma_issue_pending(struct dma_chan *chan)
 }
 
 static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
-		struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
 	struct dma_chan *chan, *_chan;
diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 54db1411ce73..9a969cbdd384 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -793,7 +793,7 @@ static irqreturn_t mdc_chan_irq(int irq, void *dev_id)
 }
 
 static struct dma_chan *mdc_of_xlate(struct of_phandle_args *dma_spec,
-				     struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct mdc_dma *mdma = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ab0fb804fb1e..b145babe366b 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1032,7 +1032,7 @@ static bool imxdma_filter_fn(struct dma_chan *chan, void *param)
 }
 
 static struct dma_chan *imxdma_xlate(struct of_phandle_args *dma_spec,
-						struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	int count = dma_spec->args_count;
 	struct imxdma_engine *imxdma = ofdma->of_dma_data;
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d1651a50c349..7c3cdb378f98 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1659,7 +1659,7 @@ static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 }
 
 static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
-				   struct of_dma *ofdma)
+				   struct of_dma *ofdma, struct device *slave)
 {
 	struct sdma_engine *sdma = ofdma->of_dma_data;
 	dma_cap_mask_t mask = sdma->dma_device.cap_mask;
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 01e25c68dd5a..dd0e7fe9e54a 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -786,7 +786,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
 MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
 
 static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
-						struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct k3_dma_dev *d = ofdma->of_dma_data;
 	unsigned int request = dma_spec->args[0];
diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index 761f32687055..e730bcc8d92e 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -53,7 +53,7 @@ static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
 }
 
 static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
-				    struct of_dma *ofdma)
+				    struct of_dma *ofdma, struct device *slave)
 {
 	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
 	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index eb3a1f42ab06..569ec8f1ccee 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -993,7 +993,7 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
 
 static struct dma_chan *mmp_pdma_dma_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct mmp_pdma_device *d = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 13c68b6434ce..ca56e73797c9 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -591,7 +591,7 @@ static bool mmp_tdma_filter_fn(struct dma_chan *chan, void *fn_param)
 }
 
 static struct dma_chan *mmp_tdma_xlate(struct of_phandle_args *dma_spec,
-			       struct of_dma *ofdma)
+			       struct of_dma *ofdma, struct device *slave)
 {
 	struct mmp_tdma_device *tdev = ofdma->of_dma_data;
 	dma_cap_mask_t mask = tdev->device.cap_mask;
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index e1a5c2242f6f..d7c32a3c1bac 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -330,7 +330,7 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
 }
 
 static struct dma_chan *moxart_of_xlate(struct of_phandle_args *dma_spec,
-					struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct moxart_dmadev *mdc = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index e217268c7098..3cc0e6b99f13 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -747,7 +747,7 @@ static bool mxs_dma_filter_fn(struct dma_chan *chan, void *fn_param)
 }
 
 static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
-			       struct of_dma *ofdma)
+			       struct of_dma *ofdma, struct device *slave)
 {
 	struct mxs_dma_engine *mxs_dma = ofdma->of_dma_data;
 	dma_cap_mask_t mask = mxs_dma->dma_device.cap_mask;
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 3f45b9bdf201..cb6a981beacd 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1096,7 +1096,7 @@ static void nbpf_free_chan_resources(struct dma_chan *dchan)
 }
 
 static struct dma_chan *nbpf_of_xlate(struct of_phandle_args *dma_spec,
-				      struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct nbpf_device *nbpf = ofdma->of_dma_data;
 	struct dma_chan *dchan;
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index faae0bfe1109..b6fd9e10758c 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -54,7 +54,8 @@ static struct of_dma *of_dma_find_controller(struct of_phandle_args *dma_spec)
  * to request channel from the real DMA controller.
  */
 static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
-					    struct of_dma *ofdma)
+					    struct of_dma *ofdma,
+					    struct device *slave)
 {
 	struct dma_chan		*chan;
 	struct of_dma		*ofdma_target;
@@ -71,7 +72,8 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
 	if (!ofdma_target)
 		return NULL;
 
-	chan = ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target);
+	chan = ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target,
+					  slave);
 	if (chan) {
 		chan->router = ofdma->dma_router;
 		chan->route_data = route_data;
@@ -103,7 +105,8 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
  */
 int of_dma_controller_register(struct device_node *np,
 				struct dma_chan *(*of_dma_xlate)
-				(struct of_phandle_args *, struct of_dma *),
+				(struct of_phandle_args *, struct of_dma *,
+				 struct device *),
 				void *data)
 {
 	struct of_dma	*ofdma;
@@ -229,14 +232,15 @@ static int of_dma_match_channel(struct device_node *np, const char *name,
 
 /**
  * of_dma_request_slave_channel - Get the DMA slave channel
- * @np:		device node to get DMA request from
+ * @slave:		device to get DMA request from
  * @name:	name of desired channel
  *
  * Returns pointer to appropriate DMA channel on success or an error pointer.
  */
-struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
+struct dma_chan *of_dma_request_slave_channel(struct device *slave,
 					      const char *name)
 {
+	struct device_node	*np = slave->of_node;
 	struct of_phandle_args	dma_spec;
 	struct of_dma		*ofdma;
 	struct dma_chan		*chan;
@@ -275,7 +279,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		ofdma = of_dma_find_controller(&dma_spec);
 
 		if (ofdma) {
-			chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
+			chan = ofdma->of_dma_xlate(&dma_spec, ofdma, slave);
 		} else {
 			ret_no_channel = -EPROBE_DEFER;
 			chan = NULL;
@@ -305,7 +309,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
  * pointer to appropriate dma channel on success or NULL on error.
  */
 struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
-						struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	int count = dma_spec->args_count;
 	struct of_dma_filter_info *info = ofdma->of_dma_data;
@@ -335,7 +339,7 @@ struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
  * Returns pointer to appropriate dma channel on success or NULL on error.
  */
 struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
-					 struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct dma_device *dev = ofdma->of_dma_data;
 	struct dma_chan *chan, *candidate = NULL;
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 78be12b45a45..b6b2cc912380 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2076,7 +2076,8 @@ static void pl330_tasklet(unsigned long data)
 }
 
 static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
-						struct of_dma *ofdma)
+					   struct of_dma *ofdma,
+					   struct device *slave)
 {
 	int count = dma_spec->args_count;
 	struct pl330_dmac *pl330 = ofdma->of_dma_data;
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index b53fb618bbf6..434764b43d68 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1336,7 +1336,7 @@ static int pxad_init_phys(struct platform_device *op,
 MODULE_DEVICE_TABLE(of, pxad_dt_ids);
 
 static struct dma_chan *pxad_dma_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct pxad_device *d = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 03c4eb3fd314..7ff3075c0702 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1049,7 +1049,7 @@ static void bam_dma_free_desc(struct virt_dma_desc *vd)
 }
 
 static struct dma_chan *bam_dma_xlate(struct of_phandle_args *dma_spec,
-		struct of_dma *of)
+				      struct of_dma *of, struct device *slave)
 {
 	struct bam_device *bdev = container_of(of->of_dma_data,
 					struct bam_device, common);
diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 2e441d0ccd79..7cecf036bf25 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1552,7 +1552,7 @@ static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
 }
 
 static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct rcar_dmac_chan *rchan;
 	struct dma_chan *chan;
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index f999f9b0d314..9953be99627b 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -20,7 +20,7 @@
 #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
 
 static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
-				       struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	u32 id = dma_spec->args[0];
 	dma_cap_mask_t mask;
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 72c649713ace..0f06a9468df9 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -650,7 +650,7 @@ static bool usb_dmac_chan_filter(struct dma_chan *chan, void *arg)
 }
 
 static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
-					  struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index a0733ac3edb1..ed6f07b0d758 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -826,7 +826,7 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
 	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
 
 static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
-	struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct sirfsoc_dma *sdma = ofdma->of_dma_data;
 	unsigned int request = dma_spec->args[0];
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index bfb79bd0c6de..6a92a6505419 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -167,7 +167,7 @@ static irqreturn_t st_fdma_irq_handler(int irq, void *dev_id)
 }
 
 static struct dma_chan *st_fdma_of_xlate(struct of_phandle_args *dma_spec,
-					 struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct st_fdma_dev *fdev = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 8684d11b29bb..d7b06623b251 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2334,7 +2334,7 @@ static void d40_set_prio_realtime(struct d40_chan *d40c)
 #define D40_DT_FLAGS_HIGH_PRIO(flags)  ((flags >> 4) & 0x1)
 
 static struct dma_chan *d40_xlate(struct of_phandle_args *dma_spec,
-				  struct of_dma *ofdma)
+				  struct of_dma *ofdma, struct device *slave)
 {
 	struct stedma40_chan_cfg cfg;
 	dma_cap_mask_t cap;
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 49f86cabcfec..495a4f5c5c26 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -980,7 +980,7 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct stm32_dma_device *dmadev = ofdma->of_dma_data;
 	struct device *dev = dmadev->ddev.dev;
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 57aa227bfadb..c1a076334abf 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -909,7 +909,7 @@ static int sun4i_dma_config(struct dma_chan *chan,
 }
 
 static struct dma_chan *sun4i_dma_of_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct sun4i_dma_dev *priv = ofdma->of_dma_data;
 	struct sun4i_dma_vchan *vchan;
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a2358780ab2c..240e4a95913a 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -930,7 +930,7 @@ static void sun6i_dma_free_chan_resources(struct dma_chan *chan)
 }
 
 static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct sun6i_dma_dev *sdev = ofdma->of_dma_data;
 	struct sun6i_vchan *vchan;
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 3722b9d8d9fe..e0eb5813fcf5 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1239,7 +1239,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 }
 
 static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct tegra_dma *tdma = ofdma->of_dma_data;
 	struct dma_chan *chan;
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b10cbaa82ff5..525af32132ac 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -605,7 +605,7 @@ static void tegra_adma_free_chan_resources(struct dma_chan *dc)
 }
 
 static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
-					   struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct tegra_adma *tdma = ofdma->of_dma_data;
 	struct tegra_adma_chan *tdc;
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8288fe4d17c3..69cdfc39edb2 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2461,7 +2461,7 @@ static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
  * Return: DMA channel pointer on success and NULL on error
  */
 static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
-						struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct xilinx_dma_device *xdev = ofdma->of_dma_data;
 	int chan_id = dma_spec->args[0];
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 6d221e5c72ee..6aa133c514f1 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1040,7 +1040,7 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
  * Return: DMA channel pointer on success and NULL on error
  */
 static struct dma_chan *of_zynqmp_dma_xlate(struct of_phandle_args *dma_spec,
-					    struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct zynqmp_dma_device *zdev = ofdma->of_dma_data;
 
diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 42ff3e66c1e1..6e050dbe5f26 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -732,7 +732,7 @@ static void zx_dma_free_desc(struct virt_dma_desc *vd)
 MODULE_DEVICE_TABLE(of, zx6702_dma_dt_ids);
 
 static struct dma_chan *zx_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
-					       struct of_dma *ofdma)
+				     struct of_dma *ofdma, struct device *slave)
 {
 	struct zx_dma_dev *d = ofdma->of_dma_data;
 	unsigned int request = dma_spec->args[0];
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index b90d8ec57c1f..a0a6c8c17669 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -22,7 +22,8 @@ struct of_dma {
 	struct list_head	of_dma_controllers;
 	struct device_node	*of_node;
 	struct dma_chan		*(*of_dma_xlate)
-				(struct of_phandle_args *, struct of_dma *);
+				(struct of_phandle_args *, struct of_dma *,
+				 struct device *);
 	void			*(*of_dma_route_allocate)
 				(struct of_phandle_args *, struct of_dma *);
 	struct dma_router	*dma_router;
@@ -37,7 +38,7 @@ struct of_dma_filter_info {
 #ifdef CONFIG_DMA_OF
 extern int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
-		(struct of_phandle_args *, struct of_dma *),
+		(struct of_phandle_args *, struct of_dma *, struct device *),
 		void *data);
 extern void of_dma_controller_free(struct device_node *np);
 
@@ -47,17 +48,17 @@ extern int of_dma_router_register(struct device_node *np,
 		struct dma_router *dma_router);
 #define of_dma_router_free of_dma_controller_free
 
-extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
+extern struct dma_chan *of_dma_request_slave_channel(struct device *slave,
 						     const char *name);
 extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
-		struct of_dma *ofdma);
+		struct of_dma *ofdma, struct device *slave);
 extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
-		struct of_dma *ofdma);
+		struct of_dma *ofdma, struct device *slave);
 
 #else
 static inline int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
-		(struct of_phandle_args *, struct of_dma *),
+		(struct of_phandle_args *, struct of_dma *, struct device *),
 		void *data)
 {
 	return -ENODEV;
@@ -77,14 +78,14 @@ static inline int of_dma_router_register(struct device_node *np,
 
 #define of_dma_router_free of_dma_controller_free
 
-static inline struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
+static inline struct dma_chan *of_dma_request_slave_channel(struct device *slave,
 						     const char *name)
 {
 	return ERR_PTR(-ENODEV);
 }
 
 static inline struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
-		struct of_dma *ofdma)
+		struct of_dma *ofdma, struct device *slave)
 {
 	return NULL;
 }
-- 
1.9.1
