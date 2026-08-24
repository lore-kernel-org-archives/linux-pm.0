Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535543F8238;
	Mon, 24 Aug 2026 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569876; cv=none; b=OOi6BfLZYi6M2sW99P6DnJ6z8ufq6kZ6Lu2LQreVM+WOMDPAGcY2N9fO9PJn7odVvwj72k76jMi7Yf+M+0cZk+8MsFXVT5UF7O2RyJZWV86/h1lnY5Bjx3e8GbLyeHfpoonoUQLZiyK9lHWEuHuQLeDTQ7l6rFFUlwzsFy8I4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569876; c=relaxed/simple;
	bh=1NTOzrYCVQWlt3cQYFhqB4RGbz/RE/1+VAbNqd34s5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL1tjlUSz35E6L4ELZzoguoeEuVZ9nvf60EIES1jQPNZClNm6WaY4CIEjCaxrdD3X6TCjEBMKMKr0oECSLFP2aQXghzPWodtKlzTMVKW7OiCuE/yLFbTehpQdvD1/D4lsRfoj43re3gerSippg48neg6noekuQNKcX3UnCkg4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=iki1SdkE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxebnI+7; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="iki1SdkE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxebnI+7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 0B6141300137;
	Mon, 24 Aug 2026 07:11:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Aug 2026 07:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569871; x=
	1787573471; bh=dkrqqZhM7WlyaP2wiDCA1VTmGxSMLxzEHskNyNB2USg=; b=i
	ki1SdkE45pCyQ5sCILVj766vfAfsRGbZW+VK3tXfqIsO+AV63suYY45T0AUaYJts
	SjyIjU926K4BqgOj5KFQY410nYveHfDNIYJ93Ar3mmOdzP9JRAJtqGemGuZiJp8F
	nQvnlslzzwjGIq9VFNo/ladA7OOUTykw8Y4GLkmHo/nzKRwgskCVtNu+SSV+KUsN
	LhdLds2GOF8rBdmG9P6f51Y2hmYb/rjtbt5RBlaaovmLXVQtyhrrTTn0VTSZPnRf
	DYCM29e/Z84ewcIq7fmAV/X56ZvDtbaKNqDyPxH2uPJzVJ5pqWhL/OFjirsgQPzN
	vF0+2mmImibvh/Q06p8+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569871; x=1787573471; bh=d
	krqqZhM7WlyaP2wiDCA1VTmGxSMLxzEHskNyNB2USg=; b=PxebnI+7djJ+1Pqxk
	27F8GH4lwhgfHK6fm+SYCFi1OfVxt3dn2AfxuaNXn6eo2iFwB2Z5gRpvVsXbmR43
	xyL3P4qX+41FNJhtdgm3aEYUbIV1j1YgW4FZOiV5VAw6UBiwsINtvfQdGHbdeOx0
	Peg9lMbh4mp4XfwQZqdme57cpWAqZ3gH+IdEzIYfX3n7pDLDmJRY+fJydweR3BUY
	pUw1qrhSKITM248z6E56mXJcgUz/BHvC7/Ayhtq1kNK8DHmowEaFl+zM9+NS9UQm
	ioOVMdbJXQ9ZJ7+XkuCoAwQA9oNZixZLPOro5BW7wBuhjDZDvx0XiykXNQVIyWqi
	uJzsQ==
X-ME-Sender: <xms:zyaManFkWug0pt2Ol_a9U0YE7r4oE0vnrZxs3y0c4ZFyQGtxO8mBbw>
    <xme:zyaMakPJyNtdvx8awVgkGqxi-xIag_j4Ekwe27SlZ3LvDEskXHYlC-4B6BjRTUmlN
    8Wp_uuHwoaFvT24o9gxwWpSpLpsblXajlG8kGHFyLMUIWI54DNfuXGs>
X-ME-Received: <xmr:zyaMamfq6_PG215L9iXx27bhGUvgtCQf3U3yQFvkH-4aOQ1FI5nhDcbeXXMeFgbs-w3xDRttGw>
X-ME-Proxy-Cause: dmFkZTFHvuFGkDxhms1zS09LiuNFkizgKkaMtHqPklwZMc313AhgPT8Pr4WXVikeXz8UBL
    3+nZMblObrc5rJ20We1emX/E1RtPyQP9cIK75ExCjU94LJCr+UgFU/udttZ1WvoGUl6Oj3
    QAEq2fRm8DpJc5ZqNY9zhfzfKG00mj9hRgayzVmL0AH4UkAi/nndqtGXHiQ7FBi8OTFSBn
    f8Hb0vMbxHDU0/sH0apugvmLbvGsPfDJVkLkOjirwU0gnhvj0CNl2U5s3+reL2jv9u24BL
    iVWvwokpbUCqYjSXhg5ghJQCci6/l456hRte6hMOojcUIfLDSiWKSfNER/K9QYMeLYP0jv
    ZEAOB/7FA4rCyRRUv4I+4Kev1v3h+0AIwXquPclgWFMvifN3wU5CfB1uqgdRFews1pI2r3
    AyvyzxCb3wFpvccaVzW36C9AO4Q6OTG8kuC8vOY5CAlv7CboWfEnnwWnAkcjVOOVl1hV5T
    YTqjfjVF5XFnovUAdyi9ev/3tkXmeVqa5ultRXZvA3FJYepIkNAnPRBeY0IgZ9m33ManDJ
    7QHa310wlEzeubTVShXk5RfXsQLiCyvV64aMh8hP9YoeGNu6Oh05e4PiSmxskRXq7OcHQO
    EfCEdliJPi26k/nr6+43YGMGx/Fi+WsQL9R7HvBPjg7noXKkGoTakTZBOHmw
X-ME-Proxy: <xmx:zyaMahQPsCCsqPnr_3zf5Cknd6Nx0F2ktU3GsCsdnv3IeorWSulWqg>
    <xmx:zyaMaqc4eo2xpE-f2IL73I5U8cImssW_kLOJWBlWIToirmPygrwHGw>
    <xmx:zyaMahpvvmqbjU9lEtbIQQOto9t3HTg5bSJd_WawGD6kYH0IfkysKw>
    <xmx:zyaMardlL6GZluB8LyeSi035pmLHH9QD1E6yW37Om3dr9YkF-k37_A>
    <xmx:zyaMaq9PVIm7przZx7nLiWF9Fr8y5PY1O4STzi1U9spEtLizbhZxbOMJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:11:04 -0400 (EDT)
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
Subject: [PATCH v9 11/13] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 24 Aug 2026 23:09:00 +1200
Message-ID: <a61832446cb4ba21ddcdd42032c0a3d5c6bc15f2.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
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
   twelve, moving the three controls above it up by four.

That last one is the reason this series has been reporting, since v3,
that the block accepts exactly one task per reset. rocket_registers.h is
generated from the RK3588 description, so writing it unchanged to an
RK3576 asks for task_number 0x7001, which is 28673 tasks, and puts
TASK_COUNT_CLEAR on a bit that does nothing. The counter is then only
ever cleared by a reset.

The layout was confirmed by Chaoyi Chen of Rockchip, including a fourth
control at BIT(18), task_last_layer_clear, which belongs on every submit
alongside the count clear:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

With that written correctly a job of several tasks runs to completion,
the completion interrupt arrives, and /proc/interrupts counts up. A
convolution submitted three times with three different inputs is byte
exact against the CPU reference each time, with no reset in between and
with nothing retiring the job but the interrupt.

Counting the cores now walks the driver's own match table instead of a
second, hand-kept list of compatibles. The array sized from that count
is indexed by every core that goes on to probe, so the two lists cannot
be allowed to disagree.

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
 drivers/accel/rocket/rocket_core.c   | 20 +++++++++++++++
 drivers/accel/rocket/rocket_core.h   |  8 +++---
 drivers/accel/rocket/rocket_device.c |  7 ++++-
 drivers/accel/rocket/rocket_drv.c    | 16 +++++++++---
 drivers/accel/rocket/rocket_drv.h    |  2 ++
 drivers/accel/rocket/rocket_job.c    | 38 +++++++++++++++++++++++++---
 6 files changed, 80 insertions(+), 11 deletions(-)

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
index 6e7dc91c5..e46962949 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -217,13 +217,23 @@ static void rocket_remove(struct platform_device *pdev)
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
@@ -282,7 +292,7 @@ static struct platform_driver rocket_driver = {
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
index 69e29f40f..2a272c2ef 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -21,6 +21,29 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * PC_TASK_CON packs the task number with three controls, and the field widths
+ * are not the same on every SoC. rocket_registers.h is generated from the
+ * RK3588 description, where the task number is twelve bits:
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
@@ -142,10 +165,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
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

