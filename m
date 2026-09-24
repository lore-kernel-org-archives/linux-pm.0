Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290E46A5FD;
	Thu, 24 Sep 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245460; cv=none; b=tcF1t3PzVuVpHD5urkHD/Elz4KTC399N9TrY2RqlfMjDCAIDld3V5olE8YfJXIx3jq12IllvNFdWaEoBLUXgjjJPo/KOtKLprqwtN13aHziklDBKd20sWuvSvXXo8DPehOn+vcxUQgFhKSMLbJAGxet0TEpoLERteJJRnEBoEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245460; c=relaxed/simple;
	bh=ZhcgD6UaiVIGn35+GHo9CxZ46fxROjNrljwsbMfwCnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEHQKOwBaSKj7UA0HLOxtuOYuQWKg07rDkfyQEDblmRT1Egk61ijHrenxZdZdi0JA1nNL5ahNVY90z/2JoenNCGKjPtSqiVjHpEhXMIXO6swGfCThavmKLKnkamWWtU3iVS1D6ztbrjKi0KPQQchdsupQlKjdzQ1bAKL3XkWdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=HN0rfTJ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJMsRNYU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="HN0rfTJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJMsRNYU"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC1547A0097;
	Thu, 24 Sep 2026 06:24:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 06:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245456; x=
	1790331856; bh=pfYAW0w82lUL7tvd6Gd/1JdfDEXmZoXCwPME0P14c7w=; b=H
	N0rfTJ+oNZ89n3s0O+qgINDn44MCAVp57y1JPkTSp8OlhiJM+Sy4N90F9OXD6H7J
	/Kg4LUV1oWxjQIlcLmHGJlbMqf8Z9CNHFRshIBkuse5drcKoTbgF/b3pue+eyS4W
	ZvtfjQQ5JtEKbqhx/YTZcSQrfY1mEuKYvDraE/6Ah24jiWAtRKEotnJsXy72iunO
	PnrNx5TwjkW+4/Iho5V7rJq5eAKn11Nqxp44m4nmbXjos8TZWm2eGwuzDB6YEvEH
	LC0jEtVa9badgRXGp2NNMgTEIFWl94x3wM7FnQwmLqN/SKSqwYeQUr6kWW9CQmEU
	vDvGktfb1ylk3P9Gaejlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245456; x=1790331856; bh=p
	fYAW0w82lUL7tvd6Gd/1JdfDEXmZoXCwPME0P14c7w=; b=ZJMsRNYUvW8dihHeP
	Dj7kXNCKFnTQDFVAZ/vPomI9I3JVsNZKcWuGI0TYUM1gcjXDeodWHwBRogCAMe38
	c6jEBzNJS5bKvj207ZcpF9bef28UJjUwAc7ondxDVw4fOBe1etF+ANY1rtEsr0DJ
	kXxjeu0PFcoEpPiXStc8qld7UjYyGO1xaoO655MGWwevPcn28sBOMVj0fDJ79ozj
	zLqK2GQ8bUXeOIw1z1eVbHrnu+EBy33UWG0pbUkZu6VqBuroYHZ/u3/1hq1bLlPQ
	pDZIno26JDG81494yBwJn67RVZlXvXJhKnBnRwXh2shA5gYykcZvnJNWPgx4tMxy
	N28GQ==
X-ME-Sender: <xms:UPq0aqFBIziTwRESYvL5rim1Wf5zUWAFFyP2g6vBtxz4iymq1rDVAw>
    <xme:UPq0asH1O61UCoiU_wSBX11LkuM7jEj35dNxNxFc5rrlEbob4333rrVuPKN2faDoW
    LwqL5jRuwil54g8qUhYITiw-il5CMns1D4Gk50FfgpW3p9QOiV1CDI>
X-ME-Received: <xmr:UPq0an9INCGAbcyTbgLxv5xb0rBD_Mcy7htfY4r1DE52PNiJ4gf_WjanoomTCZO_INIOOzk8Ng>
X-ME-Proxy-Cause: dmFkZTE/QIwB5hMaZGabcoDJbFvLt9A2eA9CIjQyvwImr4j621UDYsePWIjY7kkwVe+3ha
    YkC/pQh1DgZsF91gnx96IU4AJfUAliZz4PtVkwqdgFou6r0AvlSbZ6qgmOiPj6Tun7Po+s
    ziupQ0holf1ANfJc7zf78psVJQ4bya+dgZnUvag4wUyy3hLpTE7pqgcAMte80MyecYci0I
    FlR50R22k6CcDqOD62b+AQhcr231YN/ZkoanY+/FPbUmhfHGnTMxOCrwlQMMecULh17h3l
    8ckpJrB4lb4HzuhIeHttsf3MObzJeItP2z0RECr7Rlmd/GtQ3eUkFZv7TfIHgAtYxEgrVM
    R8bow08rRyQpxBQw/UKJly4WQnSQxY+xDUml443eV0UFSjSPc8wwzcMgdavBeanwQDN75G
    GBo5KDP9R/OsBYFwUyI2HMXuCM9Bho82AKc/ncKAR93O67IRi4c7mygjKfJ3Ekw1Q4/Zt6
    xbzS/3nJiJIWpb6vtMDdnp5mA4jELSQbvO1NxR+NgQcEwRODJjTaauBW7Eco3CCdO4r+iX
    eP6Rc2dL0aiFEo+SLtEeKR0mrP0huP/6xhGUPjUOXn5hd8nPvdb2M2H8FwzUuFbN+VK3Gm
    mcqawtzb7PQpDmAej/xHQvFdtO4yz0g2YqPmsK/RzfHFw74uYE8Ms3GNSS7g
X-ME-Proxy: <xmx:UPq0alqmkm3Y1Vggi5z6_Dqvt8NFgeQfCy27dO50a4srZz_UJ2WJ4w>
    <xmx:UPq0avajY3_O2Z2q8XDPUzouHVuo2eDBrBXbU3XXSuJNlGk-bacWHg>
    <xmx:UPq0agz69SDNo_sKF0f4q2QZh0iMyCH2l1tV7HQ-TO5Thd-AA9MCRw>
    <xmx:UPq0arNABezGYZlxAiv9CCBY48VfwQ5KD9IcCN-Nnu1MCH5Lw86M7Q>
    <xmx:UPq0atmc9tJPttyVZjmWCYyqfF3m8QyUx2P6f2YkBVLBCIMGWgFAkpbI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:24:08 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v14 12/15] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu, 24 Sep 2026 22:21:32 +1200
Message-ID: <20260924102135.92217-13-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 has two cores of the RKNN block, with six clocks per core (the
CBUF has its own), one reset instead of two, two power domains attached
explicitly, and a PC_TASK_CON that packs the task number into sixteen bits
instead of twelve. Chaoyi Chen of Rockchip confirmed that layout:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

Count the cores from the driver's own match table, now in rocket_drv.h, so
the count and the array it sizes cannot disagree.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   | 20 ++++++++++++++
 drivers/accel/rocket/rocket_core.h   |  8 +++---
 drivers/accel/rocket/rocket_device.c |  7 ++++-
 drivers/accel/rocket/rocket_drv.c    | 16 +++++++++---
 drivers/accel/rocket/rocket_drv.h    |  2 ++
 drivers/accel/rocket/rocket_job.c    | 39 +++++++++++++++++++++++++---
 6 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b202d1581..91f690176 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -21,6 +22,7 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	/* RK3576 has no per-core hclk reset, so it takes srst_a alone. */
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
@@ -32,6 +34,9 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
+	/* RK3576 clocks the CBUF separately; the compute path stalls without these. */
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
 	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
@@ -60,6 +65,21 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return err;
 
+	/*
+	 * RK3576 spans two power domains, and a multi-domain device is skipped
+	 * by the driver-core single-domain auto-attach, so attach the list here.
+	 * This goes before the first thing that would have to be unwound, so a
+	 * failure can simply return.
+	 */
+	if (core->soc->multi_power_domain) {
+		struct dev_pm_domain_list *pd_list;
+
+		err = devm_pm_domain_attach_list(dev, NULL, &pd_list);
+		if (err < 0)
+			return dev_err_probe(dev, err,
+					     "failed to attach NPU power domains\n");
+	}
+
 	core->iommu_group = iommu_group_get(dev);
 
 	err = rocket_job_init(core);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index ba74c5339..8c8d1f453 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -29,8 +29,10 @@
 
 /* Per-SoC differences, selected by the of_device_id match data. */
 struct rocket_soc_data {
-	unsigned int num_clks;		/* clk_bulk count */
-	unsigned int num_resets;	/* reset_bulk count */
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool task_con_16bit;		/* PC_TASK_CON uses the 16-bit task number */
 };
 
 struct rocket_core {
@@ -43,7 +45,7 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[6];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e7..923add5bd 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 
 #include "rocket_device.h"
+#include "rocket_drv.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver)
@@ -27,7 +28,11 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
+	/*
+	 * Count over the same match table the platform driver binds with, so
+	 * that a core added there is counted here without a second edit.
+	 */
+	for_each_matching_node(core_node, rocket_dt_match)
 		if (of_device_is_available(core_node))
 			num_cores++;
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 7ed64c131..f387b4656 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -231,13 +231,23 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.multi_power_domain = false,
+	.task_con_16bit = false,
 };
 
-static const struct of_device_id dt_match[] = {
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
+	.multi_power_domain = true,
+	.task_con_16bit = true,
+};
+
+const struct of_device_id rocket_dt_match[] = {
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = &rk3576_soc_data },
 	{}
 };
-MODULE_DEVICE_TABLE(of, dt_match);
+MODULE_DEVICE_TABLE(of, rocket_dt_match);
 
 static int find_core_for_dev(struct device *dev)
 {
@@ -296,7 +306,7 @@ static struct platform_driver rocket_driver = {
 	.driver	 = {
 		.name = "rocket",
 		.pm = pm_ptr(&rocket_pm_ops),
-		.of_match_table = dt_match,
+		.of_match_table = rocket_dt_match,
 	},
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99..0cd692a66 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -6,10 +6,12 @@
 
 #include <drm/drm_mm.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/device-id/of.h>
 
 #include "rocket_device.h"
 
 extern const struct dev_pm_ops rocket_pm_ops;
+extern const struct of_device_id rocket_dt_match[];
 
 struct rocket_iommu_domain {
 	struct iommu_domain *domain;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e6e41d517..c5491994f 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -21,6 +21,30 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * PC_TASK_CON packs the task number with control bits above it, and neither
+ * the width of the number nor the count of the controls is the same on every
+ * SoC. rocket_registers.h is generated from the RK3588 description, where the
+ * task number is twelve bits and there are two:
+ *
+ *   RK3588   BIT[11:0] task_number, BIT[12] pp_en, BIT[13] count_clear
+ *   RK3576   BIT[15:0] task_number, BIT[16] pp_en, BIT[17] count_clear,
+ *            BIT[18] last_layer_clear
+ *
+ * The RK3576 layout was confirmed by Chaoyi Chen of Rockchip:
+ * https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/
+ *
+ * Writing the RK3588 layout to an RK3576 therefore asks for task_number
+ * 0x7001, that is 28673 tasks: the count clear at BIT(13) lands inside the
+ * sixteen-bit task number and inflates the count instead of clearing it.
+ * The task counter is then only ever cleared by a reset, so the block runs
+ * one task per reset.
+ */
+#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
+#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
+#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
+#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -142,10 +166,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
 
-	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
-					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
-					 PC_TASK_CON_TASK_NUMBER(1) |
-					 PC_TASK_CON_TASK_PP_EN(1));
+	if (core->soc->task_con_16bit)
+		rocket_pc_writel(core, TASK_CON,
+				 RK3576_PC_TASK_CON_LAST_LAYER_CLEAR |
+				 RK3576_PC_TASK_CON_COUNT_CLEAR |
+				 RK3576_PC_TASK_CON_PP_EN |
+				 RK3576_PC_TASK_CON_TASK_NUMBER(1));
+	else
+		rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
+						 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
+						 PC_TASK_CON_TASK_NUMBER(1) |
+						 PC_TASK_CON_TASK_PP_EN(1));
 
 	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR(0x0));
 
-- 
2.43.0

