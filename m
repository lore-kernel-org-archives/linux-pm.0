Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B34E1C7E;
	Thu, 17 Sep 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646764; cv=none; b=GXzVx8uV8pMQ9B0L69uIIlIiT0f/xhknjSgDZKBVKGPSipXIYpychujTy24sLt1YMg/u54aC9++U6zKQMzrldnJ1NQW0MdsRc1E93D0V4R1Qq0E0u1OTK2iaht0/28dE72MyQA8JGgYCci4hCYMeehhr9SqJaDm8xQrhwBSGVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646764; c=relaxed/simple;
	bh=5Ti8Dhvry7FD8NAFuHxRYTCV6wkupAbeh568d1DiUhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5lWeLBg73WW62AgnPEjL684/Kg1QPbnnNLCaJ/NP0I1npKwXXspPHpZ6rkiADiEcdudh7Vo2TFv9gR626Sc4Q1YF56UABqJgTxvqInyx3U8NPKkgnfAq8FqZRoolos2yWt06hXlyYwLbm96ulRcAqjziF+ecBb5ubnnvNCzH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=u6c6ie8j; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="u6c6ie8j"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9418E1283;
	Thu, 17 Sep 2026 14:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646636;
	bh=5Ti8Dhvry7FD8NAFuHxRYTCV6wkupAbeh568d1DiUhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u6c6ie8jLo6T+ANm7xBv/zeZP25rD/qT0RkDO9GJLUGKDYvltju16MfvpOAyHj36P
	 EpWAVABg09GntSXDGuRYp3UZnGTd4mFdaRruQqDqjrXDKzBnaZpIgk830Z0CrkvxuI
	 B6MmKBqOM7Xrb3/8ktZI1U6218Ojth6k7cPNR0FY=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:45 +0900
Subject: [PATCH 06/10] media: rcar-fcp: Check device revision at probe time
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-6-4c72d4e086dd@ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
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
 drivers/media/platform/renesas/rcar-fcp.c | 130 +++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index dfb0ca93e854dd0bb8aedfb757fd786ef6e45542..d99b3ff976e80f275af19e5dc02c6e1de98c38a3 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -14,26 +14,75 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
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
@@ -152,15 +201,66 @@ EXPORT_SYMBOL_GPL(rcar_fcp_soft_reset);
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
 
 	fcp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fcp->base))
@@ -169,6 +269,15 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(fcp->dev, UINT_MAX);
 
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
@@ -177,6 +286,12 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fcp);
 
 	return 0;
+
+error_pm_put:
+	pm_runtime_put(&pdev->dev);
+error_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static void rcar_fcp_remove(struct platform_device *pdev)
@@ -190,13 +305,6 @@ static void rcar_fcp_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
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

