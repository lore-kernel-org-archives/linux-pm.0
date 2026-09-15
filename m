Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E69488232;
	Tue, 15 Sep 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469166; cv=none; b=gZT0wwphSasLXZS47R473gCkBRfXekLJD6jaRBEnAG7SjwifBbqM2Jdk2i//NQhwID3a+PAd9H1dopy3WG6z87n0n5Hz8/kk+r+QFaEY9bfeKa1flWPcL1rfJHQ92eM+MA1Iwm97knU3k32/50R8rCZSvBZ/4e+jEHE+0zWnmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469166; c=relaxed/simple;
	bh=ZUgjix6KuhmcgRLEHDMNrkOpuWTJXcIFB15xJ/dQR5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDmYXsa0K1zAFezJ/5lM9YTdY4URnXbhf321Lb1Ej4Q/VVKbusUn/lrCon8ItaVt/nZ1q1/5eg82uCag8WStskgJqyn1gwKzpt2qQgGt6qc1g3S9+C33vzXI8YqCSR1vECy6qFWvEBYAzBE64LsKFPb44vImX8DApZwmRRx5pC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=FK7zKJSA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1GfD4dG; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FK7zKJSA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1GfD4dG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 49AB3130050E;
	Tue, 15 Sep 2026 06:46:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Sep 2026 06:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469162; x=
	1789476362; bh=Xf0AIYtJ/K+4XytoHu51Tg+JXdKoXOAcW1Dw8eFawmY=; b=F
	K7zKJSAiRWZGOrxhRnrUIigJhtKny+A8RNuj1pCuOiM4f+6Mqt2rvHIq7MeHk6TE
	KRY0FQb8ZPbpHahFh28Mx1QEbQcaRztFy7KFcfL6F+XXSVpmgXuLNAbWH73xplQn
	p+0R9PP7ukG5Pn3LAQ8NNsyhy86RPn2+gw3q5MrtBaFP2k77aj0D/CVQmCXGqBNZ
	EIa2qlYvib9KVEdh9LLYkKCL2QyiSmBBiJDAMovMNgQC51ipSUM60dQ+qrCmg/94
	Xq4+HvaW8UIvaEjx3NFZAFL6dASVrx6V7xWnysEoiIKpo4enEGaBjWmQ9Nrpd2rJ
	7ZllBxnPHGdZEHYiwuV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469162; x=1789476362; bh=X
	f0AIYtJ/K+4XytoHu51Tg+JXdKoXOAcW1Dw8eFawmY=; b=F1GfD4dG8LW1btkcf
	IKqwPAzPDvbs9vn9APljTXY3kwIMBsdbnIh0GvhhhfsbIZtEyhBw2Xz4sN210r8x
	s68Au3RKrkEEYj4ma+cdhlL0r46Iy78iVfrqap60PRQXf3pv3E9KVuZ1Kdsc9XZi
	JnCCQ+ky8tKv1Y413kZDHmfcKHEDftm0WYeHV74AqKMwUaAfnQg+8p7jAED0wH58
	421BJcG4PMjJUY9XOO7yC8Pm33x6sf7XFXtR3smWqMyA9Lga9LM2Rt0kvLDMBWNW
	T2cs1S6CBoYgvDyv+JDffT6BIZnwSW8+OdudJ6s8g3g9hVhFt6DTu+LuRRO3Nij1
	H+LbA==
X-ME-Sender: <xms:6iGpajzAOZSZWO6iDrxk4V13zr4gqB_OcqL4xe4Pv9I-b8rfO8r43A>
    <xme:6iGpasAfczlaaUBZRX1PS526tBLpScORHUm83XWpGNj8TNZ_ZUwyTS9KNkOneeDsg
    mojNxIcTMkZFzEJAlDC5fb5oBNoK9BmNLbYMECkExQIXB1W97Q5i5w>
X-ME-Received: <xmr:6iGpahJEgD3Eq5T8EG3JlEPQb9V9jZLumb_rCu4DNOAJFWdsmXEzD5vytlpyVj7VC-heIvPgHg>
X-ME-Proxy-Cause: dmFkZTFc/f+iTQ6Xfq8OwsHzZalkNFS5P1a6mZ7+SKzJ+aIlWQZ9LIu8SZaXig2kry8E4l
    fqsKlj3MQKO04+Ry1s2dzksMu8//PfpznkMcS7S0FTNR02UB+H90E0R50vg1i9QArKyNlm
    gX8Ab8omn0B6sAhsguvaDuBppxzYAQwY06yjONgTFYdDGGfRGS/a9g4hE7Ar4SFi/MRz61
    2uJP5RE1b7aIo73DUWiBj4be9ejQ2H5+el8KS4AzHHeG1WdfgJuy1tS41N487ll4GlcDe5
    ou0gTnVo40xv1I79htHXpLrcsmhzpMHZEV2IyCxqzqtgB8RdVggG44bhnSZOFuyLoMpNWW
    dP7hbzFa4tVYG9RSdC6OS+8nsNt7SsBKsUuikCv1pGIYBr0cotRMh/ZtFxLeFUihTNL8U8
    mDPRA4rgIn2aNkqyygtrFXOg1hhCf3gPY37A7R4YxLucVh7qZeMsZH05asCMOVar4kKiZ/
    QD6fWwST2GE757bACSNj/nlS1v+Wc/Q1alo4Sm9QtkFqCS34p9Zc5NqaViT16f6MezT23k
    YVpK7cIQ5xBGf+dL+ucm4BCPRzH00voqKa7nNKvKBVNzSOZT35RbrYbrEDkZFN6PvpLgg/
    0FF7yK+bNauUUWSOMpdZP2RXXE9SG7DU8FB38qVPtovZ5/T1TgMnHGAOl8vQ
X-ME-Proxy: <xmx:6iGpavHVdiMhQ0YzVruj00Xj43k1lIVpnjprulNQ8-VrMNT_MBv87Q>
    <xmx:6iGpakGRgcVb1PFyVrCIlA1yeX0-bq_uckAU96rqdTwFiIAc5jVgDQ>
    <xmx:6iGpavtkCaoeyscvl6rgSrw6a3UekIOrnv5ii3N4o_-SSpKloaVgLg>
    <xmx:6iGpanaCsJFooP5kwiRuYLISUqemKPq6yjKJogPx3iNMAmn5MNhRNw>
    <xmx:6iGparlW1S1jTQ7t76nEh_oqKCLNkeVOUJuqnuHVz8ZXMIIvboU3Xdlj>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:45:53 -0400 (EDT)
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
Subject: [PATCH v13 12/14] accel/rocket: add RK3576 NPU (RKNN) support
Date: Tue, 15 Sep 2026 22:43:26 +1200
Message-ID: <20260915104328.45901-13-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 has two cores of the same RKNN block and a few platform
differences:

 - the CBUF (convolution buffer) has its own clock domain, so the core
   needs six clocks rather than four;
 - there is no per-core hclk reset. The CRU has SRST_A_RKNN0 and
   SRST_A_RKNN1 but no SRST_H_RKNN0 or SRST_H_RKNN1, so a core takes one
   reset where RK3588 takes two;
 - the NPU spans two power domains, and a device with more than one is
   skipped by the driver-core single-domain auto-attach, so the list has
   to be attached explicitly;
 - PC_TASK_CON packs the task number with sixteen bits rather than
   twelve, moving the two controls above it up by four and adding a third.

That last one is the reason this series has been reporting, since v3, that
the block accepts exactly one task per reset. rocket_registers.h is
generated from the RK3588 description, so writing it unchanged to an RK3576
asks for task_number 0x7001, which is 28673 tasks, and puts
TASK_COUNT_CLEAR inside the sixteen-bit task number, where it inflates the
count rather than clearing it. The counter is then only ever cleared by a
reset.

The layout was confirmed by Chaoyi Chen of Rockchip, including the third
control at BIT(18), task_last_layer_clear, which belongs on every submit
alongside the count clear:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

With that written correctly a job of several tasks runs to completion, the
completion interrupt arrives, and /proc/interrupts counts up. A convolution
submitted three times with three different inputs is byte exact against the
CPU reference each time, with no reset in between and with nothing retiring
the job but the interrupt.

Counting the cores now walks the driver's own match table instead of a
second, hand-kept list of compatibles. The array sized from that count is
indexed by every core that goes on to probe, so the two lists cannot be
allowed to disagree.

All of it hangs off the soc_data added earlier, so the RK3588 path keeps
its existing counts and behaviour.

The match table moves to rocket_drv.h so rocket_device.c can walk it with
for_each_matching_node() rather than repeating a for_each_compatible_node()
loop per SoC, which also keeps num_cores in step with the table that sizes
the array it counts into. The declaration needs struct of_device_id, taken
from <linux/device-id/of.h> rather than <linux/mod_devicetable.h>, which
carries every subsystem's tables with it.

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
index 54f9c299d..c862f8bc7 100644
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
+ * 0x7001, that is 28673 tasks, and lands the count clear on a bit that does
+ * nothing. The task counter is then only ever cleared by a reset, which is
+ * exactly the "one task per reset" behaviour this series has been reporting
+ * since v3.
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

