Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795392122;
	b=xmjLeP+t/K4EM+HbujxT4IgvCc+Aw6JCIkw8IURv4R7gpQ0PjiaScLxXfCveDf6XZngt
	 oPwQmd4DjByzzDIkiyiL5dJJO/ZZfnJMB+qXlBQzuRa1IMaAvHEIZTpRfh1eXgBBrBVrx
	 xEOCYebdTrhbbmFCDRXCOOXSzxukK7y4CnuGYldQYTnXBQA3gqskyrJl/d132zGzYysg4
	 C6QbVdOtisXqId1DlG3PxcVoBAF3lj7K3l+hAmFo4c3v8o+dRqdrbtjG3ug6xhXuwKHfS
	 lhZ+I3kS8qwob89zgyYgKxCSjQwlnrLNpfMtrcD8/wmijBCrIZiB0DbiWVLlvJ9Be8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795392122;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=sG5Qi9dXOWhftpPO+sBenJdV81nP+cvMKbc0g/NH5rQ=;
	b=H/vGVuR0j3bvI1SCKNKYQ/A1EKQbBB9gfKkMBOmcdP6GAum0bGbe9DOgcZXvUa2WeJ0P
	 C1ufcr8vLTAxZQO9v+3bV0n08wQsnzRdZvUKCHlWs2wbnXyykCZPe11vyTRSsbvqR06uV
	 Dm6gUEDLyUNgqvA1mosfOGLjiJdsCbQtndmoLE8+agLJCs/hvExSRCz2y0nh8TUkmm2DV
	 MXRWCgvm5sBKKQzlts/B/LIiMqDRzBdQwXb7Nhx0hILRhOOV4WfYZ3q61ZNAgD2QDJQ6G
	 koEsQP28ldA0zpJEe2A8SY7bWC0bg4FF9wKtK/6bzMoQ1gc5ewz+R1NYUCNxCBuswHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b5XBr/6D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CA606A31A;
	Mon, 23 Nov 2026 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5XBr/6D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464CD1F000CA;
	Mon, 23 Nov 2026 00:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795392122;
	bh=sG5Qi9dXOWhftpPO+sBenJdV81nP+cvMKbc0g/NH5rQ=;
	h=From:Date:Subject:To:Cc;
	b=b5XBr/6DAg444uLQVeEdTC3BtLAc6IPb69bVk+H9PRKNwu0siv61yLGuvg1JN06bo
	 K3z6cMlN4LAXzPsluC+yZNQiG3eV+ZZmN8zam4gHTzrKBqjC2Uc0jSfbzKT3cJOMAG
	 +JUhcGnJ/eWD0i/oUEmYIItlwLt279H0okXS7fgw+q5AWeG86ewhdJyymM4LhJ+IxO
	 W3EWNaQ6uzF7VvtXD8tL8nHDjfjE/StgVqHOLVGNBWLY3RAz255wDrwjelr2Iv+FpI
	 Frjev43kJa+isAAMNx3yu0o7Avn1eJvI6bytpZLvwR1bhdb16hkHZxiP5E2gdrJZuP
	 3Co8i7/NOBlyA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Nov 2026 01:01:58 +0100
Subject: [PATCH v3] dmaengine: ste_dma40: Use power domain for LCLA SRAM
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ux500-dma40-powerdomain-v3-1-823bd3879d2c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XNsQ6CMBCA4VdpbuZMr9hCmHwP41DoAY1CSVHEE
 N7dwKSDcf2H719g5Oh5hEIsEHnyow89FCJNBFSt7RtG76AQoKQyRKTxMWsp0XX2KHEIT44udNb
 3SKm22phSpnUNiYAhcu3nXT5fEgGtH+8hvvbRRFv9b06EhM7mpWGyMs3M6cqx59shxAY2dFIfk
 FK/IYWEuZVc1lWmy1x+Qeu6vgGFDmjYCAEAAA==
X-Change-ID: 20261115-ux500-dma40-powerdomain-135a566b03ff
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Frank Li <Frank.li@oss.nxp.com>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Replace the LCLA ESRAM regulator with runtime PM of the SRAM device
owning the ESRAM34 power domain.

Use the existing LCLA SRAM phandle instead of the never-set
use_esram_lcla flag and the obsolete named memory resource.
The bool indicating if we use LCLA SRAM seems pointless, let's just
check if it's NULL or not. Simpler.

The old use_esram_lcla path was not used by any device tree, so removing
it does not break compatibility with existing DTBs.

Acquire the SRAM runtime PM reference when allocating a DMA channel,
before taking its spinlock, and release it when the channel is freed.
Descriptor preparation can run under a client's spinlock, so it cannot
synchronously resume the SRAM.

Acquiring a handle to the SRAM can fail and then we defer probe.

Since we can defer probe(), probe() and friends can't be tagged as
__init anymore, and it's better like this anyway.

Keep a stateless device link for system-sleep ordering without adding
a runtime PM dependency to the IRQ-safe DMA controller.

Suggested-by: Frank Li <Frank.li@oss.nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
The Ux500 genpd prerequisites have been merged into the powerdomain tree.
Probably the fix sent earlier should be merged first:
"dmaengine: ste_dma40: Keep prepared descriptors across termination"

The SRAM driver will be patched separately.
---
Changes in v3:
- Preserve deferred-probe reasons and avoid duplicate error messages.
- Link to v2: https://patch.msgid.link/20261122-ux500-dma40-powerdomain-v2-1-8a0ebfc75b80@kernel.org

Changes in v2:
- Clarify that removing the unused legacy LCLA SRAM path does not break
  compatibility with existing DTBs.
- Link to v1: https://patch.msgid.link/20261115-ux500-dma40-powerdomain-v1-1-da8b6e1a0376@kernel.org
---
 drivers/dma/ste_dma40.c | 253 +++++++++++++++++++++++++++---------------------
 1 file changed, 142 insertions(+), 111 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f1cbc719c4f0..20803432eb0f 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -21,8 +21,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
+#include <linux/of_platform.h>
 #include <linux/amba/bus.h>
-#include <linux/regulator/consumer.h>
 
 #include "dmaengine.h"
 #include "ste_dma40.h"
@@ -41,7 +41,6 @@
  * certain use cases.
  * @num_of_soft_lli_chans: The number of channels that needs to be configured
  * to use SoftLLI.
- * @use_esram_lcla: flag for mapping the lcla into esram region
  * @num_of_memcpy_chans: The number of channels reserved for memcpy.
  * @memcpy_channels: The event lines used for memcpy.
  * @num_of_phy_chans: The number of physical channels implemented in HW.
@@ -52,7 +51,6 @@ struct stedma40_platform_data {
 	int				 disabled_channels[STEDMA40_MAX_PHYS];
 	int				*soft_lli_chans;
 	int				 num_of_soft_lli_chans;
-	bool				 use_esram_lcla;
 	int				 num_of_memcpy_chans;
 	u32				 memcpy_channels[D40_MEMCPY_MAX_CHANS];
 	int				 num_of_phy_chans;
@@ -301,7 +299,7 @@ struct d40_reg_val {
 	unsigned int val;
 };
 
-static __initdata struct d40_reg_val dma_init_reg_v4a[] = {
+static struct d40_reg_val dma_init_reg_v4a[] = {
 	/* Clock every part of the DMA block from start */
 	{ .reg = D40_DREG_GCC,    .val = D40_DREG_GCC_ENABLE_ALL},
 
@@ -319,7 +317,8 @@ static __initdata struct d40_reg_val dma_init_reg_v4a[] = {
 	{ .reg = D40_DREG_LCTIS2, .val = 0xFFFFFFFF},
 	{ .reg = D40_DREG_LCTIS3, .val = 0xFFFFFFFF}
 };
-static __initdata struct d40_reg_val dma_init_reg_v4b[] = {
+
+static struct d40_reg_val dma_init_reg_v4b[] = {
 	/* Clock every part of the DMA block from start */
 	{ .reg = D40_DREG_GCC,    .val = D40_DREG_GCC_ENABLE_ALL},
 
@@ -413,6 +412,7 @@ struct d40_desc {
  * struct d40_lcla_pool - LCLA pool settings and data.
  *
  * @base: The virtual address of LCLA. 18 bit aligned.
+ * @esram: I/O mapping when LCLA resides in SRAM instead of system memory.
  * @dma_addr: DMA address, if mapped
  * @base_unaligned: The original kmalloc pointer, if kmalloc is used.
  * This pointer is only there for clean-up on error.
@@ -423,6 +423,7 @@ struct d40_desc {
  */
 struct d40_lcla_pool {
 	void		*base;
+	void __iomem	*esram;
 	dma_addr_t	dma_addr;
 	void		*base_unaligned;
 	unsigned int	 alloc_order;
@@ -578,7 +579,8 @@ struct d40_gen_dmac {
  * to phy_chans entries.
  * @plat_data: Pointer to provided platform_data which is the driver
  * configuration.
- * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
+ * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
+ * @lcla_link: Device link to keep system PM ordered against LCLA.
  * @phy_res: Vector containing all physical channels.
  * @lcla_pool: lcla pool settings and data.
  * @lcpa_base: The virtual mapped address of LCPA.
@@ -613,7 +615,8 @@ struct d40_base {
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
 	struct stedma40_platform_data	 *plat_data;
-	struct regulator		 *lcpa_regulator;
+	struct device			 *lcla_dev;
+	struct device_link		 *lcla_link;
 	/* Physical half channels */
 	struct d40_phy_res		 *phy_res;
 	struct d40_lcla_pool		  lcla_pool;
@@ -630,6 +633,25 @@ struct d40_base {
 	struct d40_chan			 phy_chans[];
 };
 
+static int d40_lcla_runtime_get(struct d40_base *base)
+{
+	if (!base->lcla_dev)
+		return 0;
+
+	return pm_runtime_resume_and_get(base->lcla_dev);
+}
+
+static void d40_lcla_runtime_put(struct d40_base *base)
+{
+	if (base->lcla_dev)
+		pm_runtime_put(base->lcla_dev);
+}
+
+static void d40_transfer_runtime_put(struct d40_base *base)
+{
+	pm_runtime_put_autosuspend(base->dev);
+}
+
 static bool chan_is_physical(struct d40_chan *chan)
 {
 	return chan->log_num == D40_PHY_CHAN;
@@ -859,7 +881,6 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
 	bool cyclic = desc->cyclic;
 	int curr_lcla = -EINVAL;
 	int first_lcla = 0;
-	bool use_esram_lcla = chan->base->plat_data->use_esram_lcla;
 	bool linkback;
 
 	/*
@@ -912,7 +933,6 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
 	for (; lli_current < lli_len; lli_current++) {
 		unsigned int lcla_offset = chan->phy_chan->num * 1024 +
 					   8 * curr_lcla * 2;
-		struct d40_log_lli *lcla = pool->base + lcla_offset;
 		unsigned int flags = 0;
 		int next_lcla;
 
@@ -936,16 +956,17 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
 		 * One unused LCLA in the cyclic case if the very first
 		 * next_lcla fails...
 		 */
-		d40_log_lli_lcla_write(lcla,
-				       &lli->dst[lli_current],
-				       &lli->src[lli_current],
-				       next_lcla, flags);
-
-		/*
-		 * Cache maintenance is not needed if lcla is
-		 * mapped in esram
-		 */
-		if (!use_esram_lcla) {
+		if (pool->esram) {
+			/* LCPA and LCLA use the same four-word SRAM layout. */
+			d40_log_lli_lcpa_write(pool->esram + lcla_offset,
+					       &lli->dst[lli_current],
+					       &lli->src[lli_current],
+					       next_lcla, flags);
+		} else {
+			d40_log_lli_lcla_write(pool->base + lcla_offset,
+					       &lli->dst[lli_current],
+					       &lli->src[lli_current],
+					       next_lcla, flags);
 			dma_sync_single_range_for_device(chan->base->dev,
 						pool->dma_addr, lcla_offset,
 						2 * sizeof(struct d40_log_lli),
@@ -1661,7 +1682,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
 			d40_desc_done(d40c, d40d);
 			d40c->pending_tx++;
 			d40c->busy = false;
-			pm_runtime_put_autosuspend(d40c->base->dev);
+			d40_transfer_runtime_put(d40c->base);
 			tasklet_schedule(&d40c->tasklet);
 			return ERR_PTR(err);
 		}
@@ -1717,7 +1738,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
 		if (d40_queue_start(d40c) == NULL) {
 			d40c->busy = false;
 
-			pm_runtime_put_autosuspend(d40c->base->dev);
+			d40_transfer_runtime_put(d40c->base);
 		}
 	}
 
@@ -2270,7 +2291,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 		d40c->base->lookup_phy_chans[phy->num] = NULL;
 
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 
 	d40c->busy = false;
 	d40c->phy_chan = NULL;
@@ -2646,6 +2667,12 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	struct d40_chan *d40c =
 		container_of(chan, struct d40_chan, chan);
 	bool is_free_phy;
+
+	/* Preparation and submission may run with the client's spinlock held. */
+	err = d40_lcla_runtime_get(d40c->base);
+	if (err < 0)
+		return err;
+
 	spin_lock_irqsave(&d40c->lock, flags);
 
 	dma_cookie_init(chan);
@@ -2703,6 +2730,8 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	pm_runtime_put_autosuspend(d40c->base->dev);
  unlock:
 	spin_unlock_irqrestore(&d40c->lock, flags);
+	if (err < 0)
+		d40_lcla_runtime_put(d40c->base);
 	return err;
 }
 
@@ -2725,6 +2754,10 @@ static void d40_free_chan_resources(struct dma_chan *chan)
 	if (err)
 		chan_err(d40c, "Failed to free channel\n");
 	spin_unlock_irqrestore(&d40c->lock, flags);
+
+	/* Keep SRAM powered if stopping the channel failed. */
+	if (!d40c->phy_chan)
+		d40_lcla_runtime_put(d40c->base);
 }
 
 static struct dma_async_tx_descriptor *d40_prep_memcpy(struct dma_chan *chan,
@@ -2877,7 +2910,7 @@ static int d40_terminate_all(struct dma_chan *chan)
 	 */
 	d40_term_all(d40c);
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 	d40c->busy = false;
 
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -3047,9 +3080,9 @@ static int d40_set_runtime_config_write(struct dma_chan *chan,
 
 /* Initialization functions */
 
-static void __init d40_chan_init(struct d40_base *base, struct dma_device *dma,
-				 struct d40_chan *chans, int offset,
-				 int num_chans)
+static void d40_chan_init(struct d40_base *base, struct dma_device *dma,
+			  struct d40_chan *chans, int offset,
+			  int num_chans)
 {
 	int i = 0;
 	struct d40_chan *d40c;
@@ -3123,8 +3156,8 @@ static void d40_ops_init(struct d40_base *base, struct dma_device *dev)
 	dev->dev = base->dev;
 }
 
-static int __init d40_dmaengine_init(struct d40_base *base,
-				     int num_reserved_chans)
+static int d40_dmaengine_init(struct d40_base *base,
+			      int num_reserved_chans)
 {
 	int err ;
 
@@ -3201,29 +3234,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 #ifdef CONFIG_PM_SLEEP
 static int dma40_suspend(struct device *dev)
 {
-	struct d40_base *base = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_force_suspend(dev);
-	if (ret)
-		return ret;
-
-	if (base->lcpa_regulator)
-		ret = regulator_disable(base->lcpa_regulator);
-	return ret;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int dma40_resume(struct device *dev)
 {
-	struct d40_base *base = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (base->lcpa_regulator) {
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret)
-			return ret;
-	}
-
 	return pm_runtime_force_resume(dev);
 }
 #endif
@@ -3313,7 +3328,7 @@ static const struct dev_pm_ops dma40_pm_ops = {
 
 /* Initialization functions. */
 
-static int __init d40_phy_res_init(struct d40_base *base)
+static int d40_phy_res_init(struct d40_base *base)
 {
 	int i;
 	int num_phy_chans_avail = 0;
@@ -3405,8 +3420,8 @@ static void d40_drop_kmem_cache_action(void *d)
 	kmem_cache_destroy(desc_slab);
 }
 
-static int __init d40_hw_detect_init(struct platform_device *pdev,
-				     struct d40_base **retbase)
+static int d40_hw_detect_init(struct platform_device *pdev,
+			      struct d40_base **retbase)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
@@ -3425,7 +3440,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to enable DMA clock\n");
 
 	/* Get IO for DMAC base address */
 	virtbase = devm_platform_ioremap_resource_byname(pdev, "base");
@@ -3592,7 +3607,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void __init d40_hw_init(struct d40_base *base)
+static void d40_hw_init(struct d40_base *base)
 {
 
 	int i;
@@ -3640,13 +3655,9 @@ static void __init d40_hw_init(struct d40_base *base)
 
 	/* Write which interrupt to clear */
 	writel(pcicr, base->virtbase + base->gen_dmac.interrupt_clear);
-
-	/* These are __initdata and cannot be accessed after init */
-	base->gen_dmac.init_reg = NULL;
-	base->gen_dmac.init_reg_size = 0;
 }
 
-static int __init d40_lcla_allocate(struct d40_base *base)
+static int d40_lcla_allocate(struct d40_base *base)
 {
 	struct d40_lcla_pool *pool = &base->lcla_pool;
 	size_t lcla_size = SZ_1K * base->num_phy_chans;
@@ -3728,8 +3739,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	return ret;
 }
 
-static int __init d40_of_probe(struct device *dev,
-			       struct device_node *np)
+static int d40_of_probe(struct device *dev, struct device_node *np)
 {
 	struct stedma40_platform_data *pdata;
 	int num_phy = 0, num_memcpy = 0, num_disabled = 0;
@@ -3781,13 +3791,70 @@ static int __init d40_of_probe(struct device *dev,
 	return 0;
 }
 
-static int __init d40_probe(struct platform_device *pdev)
+static int d40_lcla_sram_setup(struct d40_base *base)
+{
+	struct device *dev = base->dev;
+	struct device_node *np, *parent;
+	struct platform_device *sram;
+	struct resource res;
+	bool ready;
+	int ret;
+
+	np = of_parse_phandle(dev->of_node, "sram", 1);
+	if (!np)
+		return 0;
+
+	ret = of_address_to_resource(np, 0, &res);
+	parent = of_get_parent(np);
+	of_node_put(np);
+	if (ret) {
+		of_node_put(parent);
+		return ret;
+	}
+	if (!parent)
+		return -EINVAL;
+
+	if (!IS_ALIGNED(res.start, LCLA_ALIGNMENT) ||
+	    resource_size(&res) < SZ_1K * base->num_phy_chans ||
+	    res.end > U32_MAX) {
+		of_node_put(parent);
+		return -EINVAL;
+	}
+
+	sram = of_find_device_by_node(parent);
+	of_node_put(parent);
+	if (!sram)
+		return -EPROBE_DEFER;
+	base->lcla_dev = &sram->dev;
+
+	device_lock(base->lcla_dev);
+	ready = device_is_bound(base->lcla_dev);
+	device_unlock(base->lcla_dev);
+	if (!ready)
+		return -EPROBE_DEFER;
+
+	base->lcla_link = device_link_add(dev, base->lcla_dev,
+					  DL_FLAG_STATELESS);
+	if (!base->lcla_link)
+		return -ENOMEM;
+
+	/* The SRAM driver owns the containing region. */
+	base->lcla_pool.esram = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!base->lcla_pool.esram)
+		return -ENOMEM;
+
+	writel(res.start, base->virtbase + D40_DREG_LCLA);
+	dev_info(dev, "using LCLA SRAM at %pa\n", &res.start);
+
+	return 0;
+}
+
+static int d40_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
 	struct d40_base *base;
-	struct resource *res;
 	struct resource res_lcpa;
 	void *dmaenginem_reg_group;
 	int num_reserved_chans;
@@ -3844,26 +3911,12 @@ static int __init d40_probe(struct platform_device *pdev)
 		d40_err(dev, "Failed to ioremap LCPA region\n");
 		goto report_failure;
 	}
-	/* If lcla has to be located in ESRAM we don't need to allocate */
-	if (base->plat_data->use_esram_lcla) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-							"lcla_esram");
-		if (!res) {
-			ret = -ENOENT;
-			d40_err(dev,
-				"No \"lcla_esram\" memory resource\n");
-			goto report_failure;
-		}
-		base->lcla_pool.base = devm_ioremap(dev, res->start,
-						    resource_size(res));
-		if (!base->lcla_pool.base) {
-			ret = -ENOMEM;
-			d40_err(dev, "Failed to ioremap LCLA region\n");
-			goto report_failure;
-		}
-		writel(res->start, base->virtbase + D40_DREG_LCLA);
-
-	} else {
+	ret = d40_lcla_sram_setup(base);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to set up LCLA SRAM\n");
+		goto destroy_cache;
+	}
+	if (!base->lcla_pool.esram) {
 		ret = d40_lcla_allocate(base);
 		if (ret) {
 			d40_err(dev, "Failed to allocate LCLA area\n");
@@ -3879,26 +3932,6 @@ static int __init d40_probe(struct platform_device *pdev)
 		goto destroy_cache;
 	}
 
-	if (base->plat_data->use_esram_lcla) {
-
-		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
-		if (IS_ERR(base->lcpa_regulator)) {
-			d40_err(dev, "Failed to get lcpa_regulator\n");
-			ret = PTR_ERR(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
-			goto destroy_cache;
-		}
-
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret) {
-			d40_err(dev,
-				"Failed to enable lcpa_regulator\n");
-			regulator_put(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
-			goto destroy_cache;
-		}
-	}
-
 	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
 
 	pm_runtime_irq_safe(base->dev);
@@ -3954,21 +3987,17 @@ static int __init d40_probe(struct platform_device *pdev)
 		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
 				 SZ_1K * base->num_phy_chans,
 				 DMA_TO_DEVICE);
-
-	if (!base->plat_data->use_esram_lcla &&
-	    !base->lcla_pool.base_unaligned && base->lcla_pool.base)
+	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
 		free_pages((unsigned long)base->lcla_pool.base,
 			   base->lcla_pool.alloc_order);
 
 	kfree(base->lcla_pool.base_unaligned);
-
-	if (base->lcpa_regulator) {
-		regulator_disable(base->lcpa_regulator);
-		regulator_put(base->lcpa_regulator);
-	}
+	if (base->lcla_link)
+		device_link_del(base->lcla_link);
+	if (base->lcla_dev)
+		put_device(base->lcla_dev);
 
  report_failure:
-	d40_err(dev, "probe failed\n");
 	return ret;
 }
 
@@ -3978,15 +4007,17 @@ static const struct of_device_id d40_match[] = {
 };
 
 static struct platform_driver d40_driver = {
+	.probe = d40_probe,
 	.driver = {
 		.name  = D40_NAME,
 		.pm = &dma40_pm_ops,
 		.of_match_table = d40_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
 static int __init stedma40_init(void)
 {
-	return platform_driver_probe(&d40_driver, d40_probe);
+	return platform_driver_register(&d40_driver);
 }
 subsys_initcall(stedma40_init);

---
base-commit: becfc375b0ee95818c531ed43ecda26c90f7617a
change-id: 20261115-ux500-dma40-powerdomain-135a566b03ff

Best regards,
--  
Linus Walleij <linusw@kernel.org>

