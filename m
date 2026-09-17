Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0054DD3BC;
	Thu, 17 Sep 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646766; cv=none; b=RK1lgqDu83nsHqSGZhUGYQaeCcEDxFG4gCn5w7DROWHcFOYmUX8gCMd3X+8ITk9uN8GoV+H+kncuBlTEtsLJmDjO4nRijn5d23JZCatDJG39+FBuomgn1O5vgj7dAtBiUStmplSSqkh7xh+ZQwOD6Ig9qHwXrGhRjgIhhTwCsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646766; c=relaxed/simple;
	bh=VO0MkX7yJ12M3F7By/Za1k0A2sGl8bkjoOoRpYRe8II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUyhQHyEhtc/EQ+dVC9oGUpXkEzdcyfgB2HXzZvXzVk8+4W8b3sefVWgKmW0kThlgyRU0h9LW65nUXaT0DdQOTJYxgD0dGQJ37WFjbbfNMtzKcMP4yTxhumJRI5GxHJtlWPtUn1U8LydhyUlcfX44eorpaut2c+9JABsVNaK3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XmLdNZQk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XmLdNZQk"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C887914C2;
	Thu, 17 Sep 2026 14:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646642;
	bh=VO0MkX7yJ12M3F7By/Za1k0A2sGl8bkjoOoRpYRe8II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XmLdNZQkbYgjgHVQdbQ2yva49rhCVj+8wk2YOqxgQ3MmH7Pq4pqFLMYJyMCSDX+sR
	 DBOss/bqtfG25VhrxPHLUxPWTRiI8mi2WTE+qesvAQtmA2aIK64tNEkRVKdfBgQQlm
	 PTCWLUXYZcKOJqATWsB4DJwfWKHDkyAMPuWtoP3A=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:46 +0900
Subject: [PATCH 07/10] media: rcar-fcp: Handle resets
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-7-4c72d4e086dd@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

On some versions of the FCP, such as the one on the X5H, reset control
is required to operate the FCP. Add support for handling resets
optionally, to continue supporting versions that do not require it.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/rcar-fcp.c | 34 +++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index d99b3ff976e80f275af19e5dc02c6e1de98c38a3..15bcbbda3b853f71780aae876f6440b33addf193 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include <media/rcar-fcp.h>
@@ -63,6 +64,8 @@
 #define RCAR_FCP_REG_BA_REF_Y2			0x0118
 #define RCAR_FCP_REG_BA_REF_C			0x011c
 
+struct reset_control;
+
 enum rcar_fcp_type {
 	RCAR_FCPF,
 	RCAR_FCPV,
@@ -73,6 +76,7 @@ struct rcar_fcp_device {
 	struct device *dev;
 	void __iomem *base;
 	enum rcar_fcp_type type;
+	struct reset_control *rstc;
 };
 
 static LIST_HEAD(fcp_devices);
@@ -262,12 +266,19 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 	fcp->dev = &pdev->dev;
 	fcp->type = (enum rcar_fcp_type)device_get_match_data(&pdev->dev);
 
+	platform_set_drvdata(pdev, fcp);
+
 	fcp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fcp->base))
 		return PTR_ERR(fcp->base);
 
 	dma_set_max_seg_size(fcp->dev, UINT_MAX);
 
+	fcp->rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(fcp->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fcp->rstc),
+				     "failed to get reset control\n");
+
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
@@ -283,8 +294,6 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 	list_add_tail(&fcp->list, &fcp_devices);
 	mutex_unlock(&fcp_lock);
 
-	platform_set_drvdata(pdev, fcp);
-
 	return 0;
 
 error_pm_put:
@@ -305,11 +314,32 @@ static void rcar_fcp_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int fcp_pm_runtime_suspend(struct device *dev)
+{
+	struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
+
+	reset_control_assert(fcp->rstc);
+	return 0;
+}
+
+static int fcp_pm_runtime_resume(struct device *dev)
+{
+	struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
+
+	reset_control_deassert(fcp->rstc);
+	return 0;
+}
+
+static const struct dev_pm_ops fcp_pm_ops = {
+	RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume, NULL)
+};
+
 static struct platform_driver rcar_fcp_platform_driver = {
 	.probe		= rcar_fcp_probe,
 	.remove		= rcar_fcp_remove,
 	.driver		= {
 		.name	= "rcar-fcp",
+		.pm = pm_ptr(&fcp_pm_ops),
 		.of_match_table = rcar_fcp_of_match,
 		.suppress_bind_attrs = true,
 	},

-- 
2.47.3

