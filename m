Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6241A903;
	Mon, 14 Sep 2026 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386950; cv=none; b=bMVEGw9AaNR5Ggam+6tTyzlE/Rdiz6cmricufzUrdhJnfDNF7daDyoE+se7K5a8fpmipkC45VUvid5vtHhWHUivQgqMhJpGTsq3u51Voan15rDia2l4TyZic+sGZq9jod+ZlO7boKweQ9gGPINC2Fxq0vyNOqbdwxQiZzWXym8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386950; c=relaxed/simple;
	bh=87NVO0dyOxSQBIH99oQToAZ7Pj0PpU9MhHdTXF2+X44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/A6CZbMi0FBi2xAWYFIcHwlDGj/x3OHj7Cf3qX78YQyzGKv2I4AfytYPR8tPBqz4Palj2x7EstjRf9WqtCjfFHRHMBwOueGKY06YOfNZnVQMAor/EdsuO93QjTn+1nY8YQgOkw8WAgFezqyvZrO0GSudlZq0/hnvxVVObLyIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6A2CgF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6A2CgF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754911F000FF;
	Mon, 14 Sep 2026 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386948;
	bh=3PNs48/hw6gOs+rnx8SOZCN8AN4K92Hm86xbJ3bLbk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M6A2CgF5LeVspIkbMUzyMNRTzo3zI5acgJNPp6J8qHbkjnFodyAozM0TBm6bDebt/
	 bnQHMhwq8gT5xIeQl5BvXABoHeCoQWGbDMBZcIEYvcEhaLKbF6fr+MeZS/EBRQVLvc
	 TEkxlcxLaCyzX5RciK3LhCX9pBRk6xRZdfm27nJDMAwVn1mfr1jMlG/CcgxZqYNUPl
	 R3+LQXrc6vjYJAQzf1amSpkM7E8obbmPc7TTto6Z8i2B/M/uY5d1x4q3OXqms8SMcC
	 OpEyZojv1bKj15/NRCS7GZF5bBNs25nIlPrtXnOE106fN13Dkk6JvSOVHNcWST4skC
	 UIwTqRJIzYJJA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:45 +0200
Subject: [PATCH v2 17/20] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-17-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Frank Li <Frank.li@oss.nxp.com>
X-Mailer: b4 0.14.3

Replace the LCLA ESRAM regulator with runtime PM.

Use the SRAM device that owns the ESRAM34 power domain.

Hold that domain while DMA transfers are active. The DMA controller is
runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM references
from the descriptor preparation path instead of relying on a runtime PM
device link from the atomic transfer path.

Add a stateless device link so system PM keeps the DMA controller ordered
after the LCLA SRAM supplier.

Suggested-by: Frank Li <Frank.li@oss.nxp.com>
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/dma/ste_dma40.c | 130 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index eda3f91741ed..2841af5b160b 100644
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
@@ -383,6 +383,7 @@ struct d40_lli_pool {
  * @node: List entry.
  * @is_in_client_list: true if the client owns this descriptor.
  * @cyclic: true if this is a cyclic job
+ * @lcla_pm_active: LCLA SRAM power domain is held for this descriptor.
  *
  * This descriptor is used for both logical and physical transfers.
  */
@@ -402,6 +403,7 @@ struct d40_desc {
 
 	bool				 is_in_client_list;
 	bool				 cyclic;
+	bool				 lcla_pm_active;
 };
 
 /**
@@ -571,7 +573,8 @@ struct d40_gen_dmac {
  * to phy_chans entries.
  * @plat_data: Pointer to provided platform_data which is the driver
  * configuration.
- * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
+ * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
+ * @lcla_link: Device link to keep system PM ordered against LCLA.
  * @phy_res: Vector containing all physical channels.
  * @lcla_pool: lcla pool settings and data.
  * @lcpa_base: The virtual mapped address of LCPA.
@@ -606,7 +609,8 @@ struct d40_base {
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
 	struct stedma40_platform_data	 *plat_data;
-	struct regulator		 *lcpa_regulator;
+	struct device			 *lcla_dev;
+	struct device_link		 *lcla_link;
 	/* Physical half channels */
 	struct d40_phy_res		 *phy_res;
 	struct d40_lcla_pool		  lcla_pool;
@@ -628,6 +632,36 @@ static struct device *chan2dev(struct d40_chan *d40c)
 	return &d40c->chan.dev->device;
 }
 
+static void d40_transfer_runtime_get(struct d40_base *base)
+{
+	pm_runtime_get_sync(base->dev);
+}
+
+static int d40_lcla_runtime_get(struct d40_base *base)
+{
+	if (!base->lcla_dev)
+		return 0;
+
+	return pm_runtime_resume_and_get(base->lcla_dev);
+}
+
+static void d40_desc_lcla_runtime_put(struct d40_chan *d40c,
+				      struct d40_desc *d40d)
+{
+	struct d40_base *base = d40c->base;
+
+	if (!d40d->lcla_pm_active)
+		return;
+
+	d40d->lcla_pm_active = false;
+	pm_runtime_put(base->lcla_dev);
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
@@ -818,6 +852,7 @@ static void d40_desc_free(struct d40_chan *d40c, struct d40_desc *d40d)
 
 	d40_pool_lli_free(d40c, d40d);
 	d40_lcla_free_all(d40c, d40d);
+	d40_desc_lcla_runtime_put(d40c, d40d);
 	kmem_cache_free(d40c->base->desc_slab, d40d);
 }
 
@@ -1516,7 +1551,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
 	if (d40d != NULL) {
 		if (!d40c->busy) {
 			d40c->busy = true;
-			pm_runtime_get_sync(d40c->base->dev);
+			d40_transfer_runtime_get(d40c->base);
 		}
 
 		/* Remove from queue */
@@ -1535,6 +1570,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
 			d40_desc_remove(d40d);
 			d40_desc_free(d40c, d40d);
 			d40c->busy = false;
+			d40_transfer_runtime_put(d40c->base);
 			return ERR_PTR(err);
 		}
 	}
@@ -1583,7 +1619,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
 		if (d40_queue_start(d40c) == NULL) {
 			d40c->busy = false;
 
-			pm_runtime_put_autosuspend(d40c->base->dev);
+			d40_transfer_runtime_put(d40c->base);
 		}
 
 		d40_desc_remove(d40d);
@@ -1637,6 +1673,7 @@ static void dma_tasklet(struct tasklet_struct *t)
 		} else if (!d40d->is_in_client_list) {
 			d40_desc_remove(d40d);
 			d40_lcla_free_all(d40c, d40d);
+			d40_desc_lcla_runtime_put(d40c, d40d);
 			list_add_tail(&d40d->node, &d40c->client);
 			d40d->is_in_client_list = true;
 		}
@@ -2067,7 +2104,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 		d40c->base->lookup_phy_chans[phy->num] = NULL;
 
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 
 	d40c->busy = false;
 	d40c->phy_chan = NULL;
@@ -2246,6 +2283,7 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	dma_addr_t dst_dev_addr;
 	struct d40_desc *desc;
 	unsigned long flags;
+	bool got_lcla_pm = false;
 	int ret;
 
 	if (!chan->phy_chan) {
@@ -2255,11 +2293,20 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 
 	d40_set_runtime_config_write(dchan, &chan->slave_config, direction);
 
+	ret = d40_lcla_runtime_get(chan->base);
+	if (ret) {
+		chan_err(chan, "Failed to enable LCLA power domain\n");
+		return NULL;
+	}
+	got_lcla_pm = !!chan->base->lcla_dev;
+
 	spin_lock_irqsave(&chan->lock, flags);
 
 	desc = d40_prep_desc(chan, sg_src, sg_len, dma_flags);
 	if (desc == NULL)
 		goto unlock;
+	desc->lcla_pm_active = got_lcla_pm;
+	got_lcla_pm = false;
 
 	if (sg_next(&sg_src[sg_len - 1]) == sg_src)
 		desc->cyclic = true;
@@ -2297,6 +2344,8 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	d40_desc_free(chan, desc);
  unlock:
 	spin_unlock_irqrestore(&chan->lock, flags);
+	if (got_lcla_pm)
+		pm_runtime_put(chan->base->lcla_dev);
 	return NULL;
 }
 
@@ -2628,7 +2677,7 @@ static int d40_terminate_all(struct dma_chan *chan)
 	d40_term_all(d40c);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 	d40c->busy = false;
 
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -2931,29 +2980,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
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
@@ -3509,7 +3540,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
+	struct device_node *np_lcla;
+	struct device_node *np_lcla_parent;
 	struct d40_base *base;
+	struct platform_device *lcla_pdev;
 	struct resource *res;
 	struct resource res_lcpa;
 	int num_reserved_chans;
@@ -3610,21 +3644,32 @@ static int __init d40_probe(struct platform_device *pdev)
 	irq_requested = true;
 
 	if (base->plat_data->use_esram_lcla) {
+		np_lcla = of_parse_phandle(np, "sram", 1);
+		if (!np_lcla) {
+			dev_err(dev, "no LCLA SRAM node\n");
+			ret = -EINVAL;
+			goto destroy_cache;
+		}
 
-		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
-		if (IS_ERR(base->lcpa_regulator)) {
-			d40_err(dev, "Failed to get lcpa_regulator\n");
-			ret = PTR_ERR(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
+		np_lcla_parent = of_get_parent(np_lcla);
+		of_node_put(np_lcla);
+		if (!np_lcla_parent) {
+			dev_err(dev, "no LCLA SRAM parent node\n");
+			ret = -EINVAL;
 			goto destroy_cache;
 		}
 
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret) {
-			d40_err(dev,
-				"Failed to enable lcpa_regulator\n");
-			regulator_put(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
+		lcla_pdev = of_find_device_by_node(np_lcla_parent);
+		of_node_put(np_lcla_parent);
+		if (!lcla_pdev) {
+			ret = -EPROBE_DEFER;
+			goto destroy_cache;
+		}
+		base->lcla_dev = &lcla_pdev->dev;
+		base->lcla_link = device_link_add(dev, base->lcla_dev,
+						  DL_FLAG_STATELESS);
+		if (!base->lcla_link) {
+			ret = -ENODEV;
 			goto destroy_cache;
 		}
 	}
@@ -3663,16 +3708,17 @@ static int __init d40_probe(struct platform_device *pdev)
 				 SZ_1K * base->num_phy_chans,
 				 DMA_TO_DEVICE);
 
-	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
+	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base &&
+	    base->lcla_pool.pages)
 		free_pages((unsigned long)base->lcla_pool.base,
 			   base->lcla_pool.pages);
 
 	kfree(base->lcla_pool.base_unaligned);
 
-	if (base->lcpa_regulator) {
-		regulator_disable(base->lcpa_regulator);
-		regulator_put(base->lcpa_regulator);
-	}
+	if (base->lcla_link)
+		device_link_del(base->lcla_link);
+	if (base->lcla_dev)
+		put_device(base->lcla_dev);
 	if (irq_requested)
 		free_irq(base->irq, base);
 	if (runtime_pm_enabled)

-- 
2.55.0

