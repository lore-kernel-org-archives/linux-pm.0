Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121379;
	b=kl4Ae2w+j6tsWKlMAqw4W84RW4TRCdJs964OdBJRHdnmf2vvFghKgoWZFHqysYdfPrvT
	 v/lSthgQ32M6cFDVZImOhwiNcMNt6lRynNfLNJuQHwgc0QKuFSNZQf/16y/Ms/5N+l6lz
	 k8MNRh/pEaHqxPxmCTwioadpILNJKJ4i1dVaqNSxFIz1r8Be1/BmU+BRDyu0/CyR76XyL
	 4U3k80feV4BKTQILgYZr2Q1i8U8AJ4ZEeoSUyasn4jXyluWi/02VCdu0uk0z41Rio2twa
	 VN9wNMQmtjaHOqOy6FgZ30crJ5ZkMo2n9hNGd8gMOGqrZ6GzjJ1UAQ4C5/10gPb0mqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121379;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=FXVYakP/oT6Ni/cedh8DXGKsqUJQQrycKKZPqfoyYko=;
	b=h0p4i/sWw8UMvjWblpXWaTpTYYY/oCqKq3hGD8Ud+wQ5gsEXczxyy+s75H3EuhzyBu1+
	 LeWRS1RuJAc9Q6IrfZ13w0YsrzvEoqVopOessI3WqnFsOYdlROGQ1UwXbg4UfUD4WvIu2
	 4LnmjMY+GHYl+jDDcPlK2BnJzOiPKbFnVyg75fpVyqN+3SebXLmx6oztNb1BMJ/9t1V/8
	 HvEfNw1DRmicziF04UbJfi4UDSXxL98iUZlL/0zOuIRjjpMjknS+UeIHDVqxBicUAExvq
	 JRYcpQWbYQnMVSSyGY3b7UGJc8r/UgxwwChWRihQsvGEE+nILOGcwWD2t3Rj0f69sKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b="sF/A3TdS";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ywiMYAgr;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA7606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=sF/A3TdS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ywiMYAgr
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 42A591D00181
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:02:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 08 Nov 2026 02:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121373; x=
	1794207773; bh=FXVYakP/oT6Ni/cedh8DXGKsqUJQQrycKKZPqfoyYko=; b=s
	F/A3TdSMSPUc4wRSltkApXtFV/TEceOW+Qww+z2Oa+u9kBd73D7ZvxryWjwXU6rB
	gn4kbW+CGwyf8E4K7Pk9uKRKr9UfXR97agbI/CNOMTFWt74MNN/5497jxU9cGuBX
	c0cdWodV7g1r/FumKCoScsE4LJ2t0iHrr/BoaXivQTC64gHNp5Jp8vfz1200egxT
	xYF19lmC/WMhKigAde8UV7Txw4GxrfgmJC7YgHznu1GHM1lo65O8g5Miocubfvof
	oZW1nH9JSqADFfa/+bmyppb/fUsQ/LOows48c/djMx5Zukt/USSnzaX3bp/0dHSO
	YystRang2hKEXUOjp0E9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121373; x=1794207773; bh=F
	XVYakP/oT6Ni/cedh8DXGKsqUJQQrycKKZPqfoyYko=; b=ywiMYAgrFBcXGmFRC
	JSFsXUn7kreQ2v8bxjMWGdK4P3Z23VVgFNyqoPqrM+I8nymok5jg3h+Z8gL4dMtP
	RqUf2nkud4qrLPOhJraeMAJPz6DZCEf+jYg8BAQQsyE6GxjbBQ1xFCIKbdL5uH08
	mpuJ5tceYgQlWKyM6i7kHj/5SXBmQWY5mzt2lzXqT5DZDt7MyRyYTxr4BcgZymvS
	FA0cytCVbp3fF+UNpoSwZLFnb0OKt7iBwHGFlnubp/prS2isTBPcSc8IRQIfZkKm
	TJv/okrrglLUSmOvtX/fKHcMqdI7g0PL9kdnZnsx/gjPcf0RRw7EVo9wD8sdHeSA
	KeTZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121373; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:FzNjaMC/RrtYNq8TyfLMJViXQtNnHg2LKLwxY1p10vj1Orr
	X4pwEl3yxPWgLF4BRWMWZ2H/YYvuU9B4N85p8Ov5DTl9wGXGPYcNosf7Ss8p1urt
	30fAB9wCnOKt9BsKGAUesfF7XxgzugwhIzDt/BHbdFw4Jq0r9Z4u7EMwUDCSCno4
	zt+7rd2qc51oXkK8s3fAgZ3zS1fpE22WN9Hh+iy5KKaYhq4TVLz+9vT9/BbrMcjM
	TOQzz+8FGCk81YFsvLN4WKpnQofbUZ8LHM4iIl20ARIjGLIsFWR8cVxDrMRRy60d
	2UB/RdU+ly3FovPYiGsDADy+Kab2lD3lwdXh6TA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mrP7AUNJvHJm3UOr6/xWFtQ6RgYqyK+/JlzFRMVHatw=:Gyw8SQh56a+FgtCmvejUs/7s3yagXlR6MEOZ703NnVc=;
X-ME-Sender: <xms:nR7wahNv6AEGxYCG2blznwmoBs0valiXr4qJ-RiUL6PW8xbM24Pb8Q>
    <xme:nR7wagGoJI6DCRfc1oE3YfgqUVikid4Udck8De5Qi3UtSuxIhwZrAWIhso1g-TyJF
    VH8rHeaJusVMbXoyJmGWVntYX8EmipilVD_DykVQyI69X088mGjtHVmlQ>
X-ME-Received: <xmr:nR7wapiKzfD3RthEbKK85vnt2o9USkB9C-xdlQG1odRvxgevFb6T262ChsDCWKPFjfByFgo1>
X-ME-Proxy-Cause: dmFkZTE+dfomWWdqprUxj4/gaP67KtM1QzxdvzYexx4ticKE2LHx68cWKHqsmd44P18pPW
    4gf1XQHcVs660UFNxyimOb9/xX2fJYhIZ5E4/RPcr0+5B2ECZDQnQKPd11oSJYSc9dP1tn
    1D+dlgDSbf0NVzpSrGBS3hvXvohbWChlfE4ZVL7HJaGgQ3XNyZa5vysjDW9Hkjo+rVA3z7
    CDI8SBB36R2DQiGVV5LgYrGWcW81i1X6zW8At+jVOUPUtnhdVEuWNPtnOYlRpcGhg2eD0V
    0uYGocj8eW30E62Nm4rNY5HS6BVVmAyFbdaUnYiVhR7YN12+2vM8TpgK17t2agGcED9sXD
    AvZyyamdXojz0AL98AvhBWvJAUpKLlBwjFdWNyeGYnlxQFliPvqJgWZAE8M/hdQ6Sf84Tk
    GcVnIvFM7lMhOaYpTJVJ+u4xWew5QpRYI6MB/OgY5S/UibWR4YzAu7H/HH7LdnqPDF0WId
    MfwOYTsBL4nSDoKHnsLuv8GB3ZFUp2vLw/M3TrcGGs6Nak5LcuKMWMUEuRSE4pMTGaeohV
    T3wWjOysGjkZN72UU7HN1meRmiHQgwYg6QnjbXjYjfNSIkdeqD+sCPaj7I32MfvF1iIGyX
    f0KxTtuhVjAll4kU04MCQL9Qy1USf8AmMeLTH+hJSyMjVCjKlGNpXscVL/EA
X-ME-Proxy: <xmx:nR7wasz3CxppKMTCwMVrm1Y2uAftCVrrHnyvibAQOTMFVsAue-ujjA>
    <xmx:nR7watrASYan70SPSTieJTOOCp-neZLNDTTbCAaTG0_CVZRQwHYMpQ>
    <xmx:nR7waqXthBr9ZCcCCHq7pADqywnHXpwQFBtlwvhI56zwrjUl9yG4fQ>
    <xmx:nR7wauPvAYRjH9DO8cEXPz2GiPbK55pp3_P5ABBVRs6hPkJTn7FoSQ>
    <xmx:nR7wan28BMTcmAP9PBwke58zQD4WDJZMjrSq6mIaKnPviGeZCFFiMQ4t>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:02:43 -0500 (EST)
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
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 12/16] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sun,  8 Nov 2026 19:59:13 +1300
Message-ID: <20261108065917.135194-13-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the RK3576 NPU. It has two cores; each core needs six
clocks and one reset, with aclk_cbuf and hclk_cbuf on top of what the
RK3588 has.

The task number in PC_TASK_CON is 16 bits wide, not 12. BIT16, BIT17 and
BIT18 are pp_en, count_clear and last_layer_clear. Chaoyi Chen confirmed
this layout on the list:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

The number of NPU cores is taken from the driver's own match table.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   |  2 ++
 drivers/accel/rocket/rocket_core.h   |  3 ++-
 drivers/accel/rocket/rocket_device.c |  3 ++-
 drivers/accel/rocket/rocket_drv.c    | 14 +++++++++++---
 drivers/accel/rocket/rocket_drv.h    |  2 ++
 drivers/accel/rocket/rocket_job.c    | 20 ++++++++++++++++----
 6 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b202d15816a3..128ebb4f19fb 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -32,6 +32,8 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
 	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index bfbf5110b524..d5d353cc38e7 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -30,6 +30,7 @@
 struct rocket_soc_data {
 	unsigned int num_clks;
 	unsigned int num_resets;
+	bool task_con_16bit;
 };
 
 struct rocket_core {
@@ -42,7 +43,7 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[6];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index efd004194c1a..39e8b7c49896 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 
 #include "rocket_device.h"
+#include "rocket_drv.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver)
@@ -27,7 +28,7 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
+	for_each_matching_node(core_node, rocket_dt_match)
 		if (of_device_is_available(core_node))
 			num_cores++;
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 1030d8407b78..fff31c1ebe52 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -226,13 +226,21 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.task_con_16bit = false,
 };
 
-static const struct of_device_id dt_match[] = {
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
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
@@ -291,7 +299,7 @@ static struct platform_driver rocket_driver = {
 	.driver	 = {
 		.name = "rocket",
 		.pm = pm_ptr(&rocket_pm_ops),
-		.of_match_table = dt_match,
+		.of_match_table = rocket_dt_match,
 	},
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99ccc..0cd692a66b85 100644
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
index ea23a44b1d9e..a33c9ea694f0 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -31,6 +31,11 @@
 /* Bits 3:0 of PC_BASE_ADDRESS hold the mode selection bit and reserved bits */
 #define ROCKET_REGCMD_ALIGN	16
 
+#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
+#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
+#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
+#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -166,10 +171,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
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

