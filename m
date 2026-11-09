Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231362;
	b=cDe+jcThbIEWaEvRfmKlPRYePKJfBeba6+jipJeo5eB/Ok69f+4Rj5a0pW0KWJoOyqvc
	 cpRJVbi8F2E+wqZ3HRt5ip6N+/y7q9ULtB3kfBl5dIC9GRF1HhwmM0m9OEyVdne9tKXcw
	 dag3vJWe/QL9coAY/rqGJR3MbviCs2wQb9mVCRSkcNGhrtP4GywnBmO4DMchdJP7T0CG+
	 +SEmyZPKvQsq0OiEyVT9fb6ecFouYN0O1fG4BZ1Pxp11tUnfM0/cRhLT5YbLLfUH/prqY
	 PNKulDQX+ZOt1+VkQp37tfEoVxj2IEq2P4jh8e9uxmYUkfwwHQcacZTosL1craiylXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231362;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=uznXjmkiTWgfr98zmBQdrDMNZkUNxUCbvJ6ZfvHz890=;
	b=MjuyCUXoAA433Vka9yXOegjKqKVvWBSTBQHbpQW7UV+Vju0SWlcb+VO6JGWRZIhOGIsd
	 J6MXD5w/ULlpiiFXmrFJ065dWJBGSE5nAMRc7CpEEBcR+mrGbymoNbb8e0jE3jcJUGsUF
	 uV09thvu9RM3hn+OfwUUsJ5Z8DaBsmoLbHDvwjhO7gc9GCWbVSb+0n3WCG3uoUtatk5e8
	 g0Dwgl1ovU8TRwXD1bho7XHiMK5/IujrfZR1sSyLIiVXLhuCDfNsFvzNfVTbQgA6fjN7t
	 DALzcl6UwL3HbkGmXwljFF8kf5KG7nW9EN4LRUaWa+jc2bS5EmasqqfUgEDQnXH7OcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=NpDJfk8W;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE77606D822;
	Mon,  9 Nov 2026 13:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE77606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=NpDJfk8W
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8CCAA219;
	Mon,  9 Nov 2026 14:33:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231218;
	bh=gGqO8nVz867c6XThKctEkhYpYd9ubmcf2l1S/Rb7Zr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NpDJfk8W/JZFZnnW4MrohS7IVZJm99HTCMLNVdLC8uuBy1S+YWPwR+/V5v3s5ZPz6
	 35arQ74YMKo9Ns8IVX5iPHZeKhKrPbbV2sfrui6e2xfonlVUg7pfBJyRzhEYhBG2Mn
	 mYAdeFdN4YKP0ZFomtE8xGUFeCYwrvfmhmf1ZBVE=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:34 +0900
Subject: [PATCH DNI v4 13/13] media: rcar-fcp: Check device revision at
 probe time
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-13-1b2072e8c37e@ideasonboard.com>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
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
 drivers/media/platform/renesas/rcar-fcp.c | 126 ++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index d782101842af7acbb3c0675d72677bc5a4854cac..93584fdc19cf46e021efeed0f47064dea96a4edb 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -14,28 +14,80 @@
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
+#define RCAR_FCP_REG_VCR_REVISION_V4H		(10 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_V4M		(11 << 0)
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
@@ -154,15 +206,62 @@ EXPORT_SYMBOL_GPL(rcar_fcp_soft_reset);
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
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V4H, "V4H" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V4M, "V4M" },
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
 static int rcar_fcp_probe(struct platform_device *pdev)
 {
 	struct rcar_fcp_device *fcp;
+	int ret;
 
 	fcp = devm_kzalloc(&pdev->dev, sizeof(*fcp), GFP_KERNEL);
 	if (fcp == NULL)
 		return -ENOMEM;
 
 	fcp->dev = &pdev->dev;
+	fcp->type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	platform_set_drvdata(pdev, fcp);
 
@@ -178,12 +277,27 @@ static int rcar_fcp_probe(struct platform_device *pdev)
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
@@ -216,8 +330,8 @@ static const struct dev_pm_ops fcp_pm_ops = {
 };
 
 static const struct of_device_id rcar_fcp_of_match[] = {
-	{ .compatible = "renesas,fcpf" },
-	{ .compatible = "renesas,fcpv" },
+	{ .compatible = "renesas,fcpf", .data = (void *)RCAR_FCPF },
+	{ .compatible = "renesas,fcpv", .data = (void *)RCAR_FCPV },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);

-- 
2.47.3

