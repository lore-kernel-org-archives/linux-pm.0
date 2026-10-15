Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770324B4043;
	Thu, 15 Oct 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050802; cv=none; b=kBaVXKaVgMPKpIfqVQBZaJwa7jK2OLRvWv2+cVmdAWP3l3NdHkRFH1AsZ8cKjhg8U1Cv2cpOi96CqhQqKl1IJtLkx+vGMBxdqlMZ2kJaWie4d1w5ufm63cg2/TKZakkYy3r6IViiGPRjGqq/4RYqtISLx7/lo3WYI26iQ+aAb0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050802; c=relaxed/simple;
	bh=vxw4nMxaECnIc0YHwRfwBILmFkhBQvUD6HX2LsSEB34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWhtucL6whVh2AFhOMQhDiS7p5zalmiofgmYVRo0Uq8xkgyBeeDO1sKvlUmsbgFo3GIIFdWf+4aXEOCmhQ14JpkJfPNAQ5+FiHQ1VAebYkGqSGfOL3HzsPR9gnJ2lwO8UFcvNGrZeXdRiwwfsuQJQXxoazSKbgMmFeqJly96bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lvi5hYAf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lvi5hYAf"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F52A22B;
	Thu, 15 Oct 2026 09:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050676;
	bh=vxw4nMxaECnIc0YHwRfwBILmFkhBQvUD6HX2LsSEB34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvi5hYAfM4BWFRsETfm0uGfpWapVjYU2VpcNuFRkjB+U+ngs7xLfB4EoFcYz7Hdnp
	 DF5RxeNI9kEZl/vuXVl2HRkjjJiZgiG+ErQ6bxTiIuIeaaE6XUrbFKY73ARwPPQgmZ
	 qa5fXAjNPNXUEr4oSuiqfSrPHye42VXaaQF0TQWU=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:55 +0900
Subject: [PATCH DNI v3 15/15] media: rcar-fcp: Check device revision at
 probe time
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-15-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Verify that the device revision register reports a valid value,
otherwise reject the device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
Changes since v2:

- Add FCP type information
- Reject devices with an unsupported version

Changes since v1:

- Use devm_platform_ioremap_resource()
---
 drivers/media/platform/renesas/rcar-fcp.c | 132 +++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index 76d4c250b30815d9eac58f9b54ad923748df79f6..5f2c483f71f42f0fc614db216c54d65e2372e8fb 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -14,28 +14,78 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
 #include <media/rcar-fcp.h>
 
-#define RCAR_FCP_REG_RST		0x0010
-#define RCAR_FCP_REG_RST_SOFTRST	BIT(0)
-#define RCAR_FCP_REG_STA		0x0018
-#define RCAR_FCP_REG_STA_ACT		BIT(0)
+#define RCAR_FCP_REG_VCR			0x0000
+#define RCAR_FCP_REG_VCR_CATEGORY		(1 << 8)
+#define RCAR_FCP_REG_VCR_REVISION_H3_ES1	(1 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_M3W		(2 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_V3M		(3 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_H3		(4 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_D3		(5 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_M3N		(6 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_V3H		(7 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_E3		(8 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_X5H_V1	(12 << 0)
+
+#define RCAR_FCP_REG_CFG0			0x0004
+#define RCAR_FCP_REG_CFG0_FCPVSEL		BIT(1)
+
+#define RCAR_FCP_REG_RST			0x0010
+#define RCAR_FCP_REG_RST_RIIFRST		BIT(22)
+#define RCAR_FCP_REG_RST_RSIFRST		BIT(21)
+#define RCAR_FCP_REG_RST_DCMPRST		BIT(20)
+#define RCAR_FCP_REG_RST_MODRST			BIT(4)
+#define RCAR_FCP_REG_RST_SOFTRST		BIT(0)
+
+#define RCAR_FCP_REG_STA			0x0018
+#define RCAR_FCP_REG_STA_ACT			BIT(0)
+
+#define RCAR_FCP_REG_TL_CTRL			0x0070
+#define RCAR_FCP_REG_TL_CTRL_TLEN		BIT(31)
+#define RCAR_FCP_REG_TL_CTRL_VPOS_C(n)		((n) << 16)
+#define RCAR_FCP_REG_TL_CTRL_VPOS_Y(n)		((n) << 0)
+
+#define RCAR_FCP_REG_PICINFO1			0x00c4
+#define RCAR_FCP_REG_PICINFO1_STRIDE_DIV16	((n) << 0)
+
+#define RCAR_FCP_REG_BA_ANC_Y0			0x0100
+#define RCAR_FCP_REG_BA_ANC_Y1			0x0104
+#define RCAR_FCP_REG_BA_ANC_Y2			0x0108
+#define RCAR_FCP_REG_BA_ANC_C			0x010c
+#define RCAR_FCP_REG_BA_REF_Y0			0x0110
+#define RCAR_FCP_REG_BA_REF_Y1			0x0114
+#define RCAR_FCP_REG_BA_REF_Y2			0x0118
+#define RCAR_FCP_REG_BA_REF_C			0x011c
+
+enum rcar_fcp_type {
+	RCAR_FCPF,
+	RCAR_FCPV,
+};
 
 struct rcar_fcp_device {
 	struct list_head list;
 	struct device *dev;
 	void __iomem *base;
 	struct reset_control *rstc;
+	enum rcar_fcp_type type;
 };
 
 static LIST_HEAD(fcp_devices);
 static DEFINE_MUTEX(fcp_lock);
 
+static inline u32 rcar_fcp_read(struct rcar_fcp_device *fcp, u32 reg)
+{
+	return ioread32(fcp->base + reg);
+}
+
 static inline void rcar_fcp_write(struct rcar_fcp_device *fcp, u32 reg, u32 val)
 {
 	iowrite32(val, fcp->base + reg);
@@ -154,15 +204,67 @@ EXPORT_SYMBOL_GPL(rcar_fcp_soft_reset);
  * Platform Driver
  */
 
+static int rcar_fcp_setup(struct rcar_fcp_device *fcp)
+{
+	static const char * const models[] = {
+		[RCAR_FCPF] = "FCPF",
+		[RCAR_FCPV] = "FCPV",
+	};
+	static struct {
+		u32 version;
+		const char *name;
+	} versions[] = {
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_H3_ES1, "H3 ES1.x" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_M3W, "M3W" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V3M, "V3M" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_H3, "H3" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_D3, "D3" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_M3N, "M3N" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V3H, "V3H" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_E3, "E3" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_X5H_V1, "X5H v1.0" },
+	};
+
+	unsigned int i;
+	u32 version;
+
+	/* Check the device version register. */
+	version = rcar_fcp_read(fcp, RCAR_FCP_REG_VCR);
+
+	for (i = 0; i < ARRAY_SIZE(versions); ++i) {
+		if (versions[i].version == version)
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(versions)) {
+		dev_err(fcp->dev, "Invalid FCP version 0x%08x\n", version);
+		return -ENODEV;
+	}
+
+	dev_dbg(fcp->dev, "%s %s device found\n", models[fcp->type],
+		versions[i].name);
+
+	return 0;
+}
+
+static const struct of_device_id rcar_fcp_of_match[] = {
+	{ .compatible = "renesas,fcpf", .data = (void *)RCAR_FCPF },
+	{ .compatible = "renesas,fcpv", .data = (void *)RCAR_FCPV },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);
+
 static int rcar_fcp_probe(struct platform_device *pdev)
 {
 	struct rcar_fcp_device *fcp;
+	int ret;
 
 	fcp = devm_kzalloc(&pdev->dev, sizeof(*fcp), GFP_KERNEL);
 	if (fcp == NULL)
 		return -ENOMEM;
 
 	fcp->dev = &pdev->dev;
+	fcp->type = (enum rcar_fcp_type)device_get_match_data(&pdev->dev);
 
 	platform_set_drvdata(pdev, fcp);
 
@@ -178,12 +280,27 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 				     "failed to get reset control\n");
 
 	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		goto error_pm_disable;
+
+	ret = rcar_fcp_setup(fcp);
+	if (ret < 0)
+		goto error_pm_put;
+
+	pm_runtime_put(&pdev->dev);
 
 	mutex_lock(&fcp_lock);
 	list_add_tail(&fcp->list, &fcp_devices);
 	mutex_unlock(&fcp_lock);
 
 	return 0;
+
+error_pm_put:
+	pm_runtime_put(&pdev->dev);
+error_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static void rcar_fcp_remove(struct platform_device *pdev)
@@ -215,13 +332,6 @@ static const struct dev_pm_ops fcp_pm_ops = {
 	RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume, NULL)
 };
 
-static const struct of_device_id rcar_fcp_of_match[] = {
-	{ .compatible = "renesas,fcpf" },
-	{ .compatible = "renesas,fcpv" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);
-
 static struct platform_driver rcar_fcp_platform_driver = {
 	.probe		= rcar_fcp_probe,
 	.remove		= rcar_fcp_remove,

-- 
2.47.3

