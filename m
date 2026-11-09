Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231333;
	b=0/QlgV3HIBm7DG5+VbTQwTKmZbs6AWua/0rLnJLsAFya1bz2p2LQXQTxDRdwlGNUkT+m
	 5TsChJqJhNriErXlfORFyze2SV735sFNCTQLKoqdg+R3uUCtt0P9DvFMnjniYg51Z2r8/
	 3PBNVTAN5j9vvPvaZkc1E5bqCwuaLLVIOD8yWOVLtZNlVnibCR/6YpQRPA/9iqT5loLvc
	 yCsRAn56sKj9ULfAEde4SI5k4Anp2dA/f60dr7jZwoBeaKvQIAqMUBAH0TLGIxEQpHZ2g
	 xY59c/ap38v3l/dLwIFW81ysYS9iyXEpPE7RiR1FBVT8R14rX7C4Vx2O7VYhLxxtE4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231333;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=estD3HstV78utNXv39tKhRc6B26Eq4vvZGB5TDFeXC4=;
	b=TXNwTi0mseKfTTZTPT96h2qnDYRNN4zPCZffb5ZR9ko1OWdD7wSuoiv4JL8H9wRY3lly
	 wBcYdOvzDyfE/EeVTaakdueANQnjyjbbmAAeZJWWJCxAk1Bb87e5uURGXpx+jO7yHnXDp
	 OCd9pWsOMDYX0z4ZGc6Ho/xk3Uw5eJ2EmqUzSuFgCgbKL9O5uT/j56uSfHYqWtF7DrFUR
	 CECvWqV5n3MWhLS0QRxziCQ8e43oPYkhO5d7LVAXybE17zoTz11jRhL/oRV7BnGdUO2xd
	 EscSzNoI/JC6UGIBSz5Owzzfd11zwrescc73VwERJShGiPaRJv52xrtVHhQ6kgcTeEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=p28idVDk;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A1606D826;
	Mon,  9 Nov 2026 13:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524A1606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=p28idVDk
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3EF2DDA8;
	Mon,  9 Nov 2026 14:33:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231189;
	bh=UUfSeQ3FfDUzEykHg5AwzI0IDfapjjOpkrDBSJB0Y/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p28idVDko2Ty89O356tq5AXPgCcrwafwd8+bHCv6lzvpnmKEkhz0GA8vdGywkMVrf
	 a0J+FGfEQggOILb0UKJNUM6gjFQTs3Gl7sKic6gtiOsDlwdH+vkpc83mCWyUrOMJM3
	 YBAeurO1tI/VVFuHBl1QwnL6QEuZabU23RWyVtxY=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:29 +0900
Subject: [PATCH v4 08/13] media: rcar-fcp: Handle resets
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-8-1b2072e8c37e@ideasonboard.com>
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

On some versions of the FCP, such as the one on the X5H, reset control
is required to operate the FCP. Add support for handling resets
optionally, to continue supporting versions that do not require it.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

---
Changes in v4:
- use devm_reset_control_get_optional_exclusive

Changes in v2:
- handle errors
---
 drivers/media/platform/renesas/rcar-fcp.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index dfb0ca93e854dd0bb8aedfb757fd786ef6e45542..d782101842af7acbb3c0675d72677bc5a4854cac 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include <media/rcar-fcp.h>
@@ -29,6 +30,7 @@ struct rcar_fcp_device {
 	struct list_head list;
 	struct device *dev;
 	void __iomem *base;
+	struct reset_control *rstc;
 };
 
 static LIST_HEAD(fcp_devices);
@@ -162,20 +164,25 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 
 	fcp->dev = &pdev->dev;
 
+	platform_set_drvdata(pdev, fcp);
+
 	fcp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fcp->base))
 		return PTR_ERR(fcp->base);
 
 	dma_set_max_seg_size(fcp->dev, UINT_MAX);
 
+	fcp->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(fcp->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fcp->rstc),
+				     "failed to get reset control\n");
+
 	pm_runtime_enable(&pdev->dev);
 
 	mutex_lock(&fcp_lock);
 	list_add_tail(&fcp->list, &fcp_devices);
 	mutex_unlock(&fcp_lock);
 
-	platform_set_drvdata(pdev, fcp);
-
 	return 0;
 }
 
@@ -190,6 +197,24 @@ static void rcar_fcp_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int fcp_pm_runtime_suspend(struct device *dev)
+{
+	struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
+
+	return reset_control_assert(fcp->rstc);
+}
+
+static int fcp_pm_runtime_resume(struct device *dev)
+{
+	struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
+
+	return reset_control_deassert(fcp->rstc);
+}
+
+static const struct dev_pm_ops fcp_pm_ops = {
+	RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume, NULL)
+};
+
 static const struct of_device_id rcar_fcp_of_match[] = {
 	{ .compatible = "renesas,fcpf" },
 	{ .compatible = "renesas,fcpv" },
@@ -202,6 +227,7 @@ static struct platform_driver rcar_fcp_platform_driver = {
 	.remove		= rcar_fcp_remove,
 	.driver		= {
 		.name	= "rcar-fcp",
+		.pm = pm_ptr(&fcp_pm_ops),
 		.of_match_table = rcar_fcp_of_match,
 		.suppress_bind_attrs = true,
 	},

-- 
2.47.3

