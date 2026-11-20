Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198627;
	b=b+0AQ6vuumNhbzAw9O/HWAbagwZeMWHVkh3RRUA3lORBl7JuPvBxO7h4MRWplrx87SKw
	 ewBGdhiNB4IO2WKC41teSuCERaQx6rjyufi68vl1V4NUjYpcSzvzSKEjcstFWsvRY9fr5
	 Bn+JV33Zmil+8u86sieUBzcJfo8TTaocm64v0XCchPRvtiCOC4TvfLV3QsjKD3oNubvhs
	 KYCtpFL8+nsFcRmQaj6zMr+3sU/cUZBZFkYWesWxxzn2fWkuLSKTi2pvpkEl3hw6OZJaN
	 BRqBER8dtl67ryHh15Nzi2bBYVVB2+AXa6YikBEFeHHbBxoZCEU49WXgPGmIN+QkJVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198627;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	b=ec5HEj91GE3q8rC7Zw+ggLmDITo2U5hZ8gN3q4OaC/eaEZpxP0bYhG58OcMw+hrtAMAD
	 Ffw5Z+8iEVQawJg74yTtKbm1pG5lUKg0myHsCXMZv7Pjh7/a0FLOFJCFuYz2ACcKL+vQd
	 cCIzbNq51MZ2XS0Bc97fN59vDUP+Deaee51m2ZOgrkKM95SSlVCXPrDHEr0gE+88aeB0z
	 GmHCpJjyS+UpSdLn6jHF13fhj616bMSZz55j+A9DATy86k3BsQjO/KeS+lcbLT5I2ZaLL
	 K0uamrHlGMvEQrK2gtas/DzxOsR1+ErlxdtUTwyfmwZ9M3hD1n5gKSmEbOtvbCdIFUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyFH1h7A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2F606DE29;
	Fri, 20 Nov 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyFH1h7A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198626;
	b=xpArLzySyTaG1NXrOx06tA/3m8mEDYMt8Iq/9/PeTyCIlakB4vM4j+nMpQCWpjclkrys
	 kdO9ZqWjxTrosRC99OEzXjlA0A3KYxIsSHAzZWjyGu8L+JIBLI1tC/UB6LazL148HX85X
	 qDPdpZR/NzYIoH89RX7ow111cF531rFygD+dyCCvPg6OYl24NdCA9/BMkKvc1VyFAJa67
	 cWYJULXsTyga2WNRbs724y+PR9bGWLrbXn026F0YQxt8SCmPABWag7Ion0tTM0Nouxkmq
	 eFpWRz+12qt7k0J//19JEYnKDr7/uhJHdr9/F+39Kq1GOIm/0aSWvP59ebO6DMvzEdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198626;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	b=MGGYSlGDr8rGVh88MM/wc5Ougt3z+pqsFXpGu6ZnDhsLQCfNCRAdr8BnvYeN+G81z95W
	 WJFBfGrUNXQc70+j5fHny1LQKXn8cfJWT2JdmHUC2Z/rK7d6eKPGucb534c1hYqbPQdJF
	 g7TNpW84zcsC7QmoDmHEjFb3vkQ6PtTGmM1K6PfhfHpB+tCV5ObsrGQJ4PZA0cRloyeg2
	 4aF/Qhiy0HhJSraPTfnMJA4LfTtShb8TgNuxoGT5TPxsGzIEmwCVnyJTu5jJK4UpDC4Vo
	 UtT1yjEmq0/E6655H5ADwxbrEILgzc+u3ViUSnKgiXxYt9NPxNa8x58uXfXmhN5M7SQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F2AE1F0180D;
	Fri, 20 Nov 2026 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198626;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UyFH1h7AMsU/rlhNZIbyXYpbVeDEz8F1zZ7feEfjRfuXUxVQ2paRudDaqpqtXb8en
	 7kIYfO8n9ovvnmOyrCQd6BwKHoJNIuhixIWULcG6hC6F19vA5kmuJhyrUCEBWqOClr
	 /xUuzGRJ62gN/bDg9cqohudnTlZhWL81FR9jpd1jTBsouLfP7W1jTX0abnsv2DC4eZ
	 +LgIQxZhGjXGTEUSQdfUeR7FIllXhDwRF+IcLpPaGguIpqjUMk9CQznU5puVkQTHwo
	 AaF+yery04NQ2kJIEtSgmqXkvOMskSBqJHvljLNmpyyZTsfouosSYnyJl4UzqIxcDN
	 u89vo9Z3/S2cA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 369EB4B935;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:46 +0100
Subject: [PATCH v2 07/11] drm/meson: dw-hdmi: Drop manual HHI clock and
 memory PD setup
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-7-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4251;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=Va7r71zAoY5+1f1lapvKRBrSntc7NXGNh523dnCyfas=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX4GZjNy7xIJ/H7Xe3WBc8u2oglNt/veMTOfiemZ/r
 Q+bnOZ0lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABNJ6GX477i2lk/sTIjI0ZxF
 4iXO8a8mXHe/vNNiU9cTlqomseNMnYwMkzUfeofIZiXGz+cNVDjwgW2db19U1t9PMX6unqnTDXa
 zAgA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

meson_dw_hdmi_init() programs two HHI registers by hand: the HDMI clock
mux/divider/gate (HHI_HDMI_CLK_CNTL) and the HDMITX memory power-down
bits (HHI_MEM_PD_REG0). Both are already covered by resources described
in the DT:

 - the HDMI clock is selected and rated through assigned-clocks
   (CLKID_HDMI_SEL parented to xtal, CLKID_HDMI at 24 MHz), and gated
   through the "isfr" clock, which the driver already enables at bind
   time;
 - the memory power-down bits are handled by the VPU power domain
   referenced by "power-domains".

Remove the open-coded register writes. Take an explicit runtime PM
reference in probe and release it on removal, so that the domain is
guaranteed to be on for the lifetime of the device.

The driver now relies on runtime PM to power the HDMITX memory, so make
it depend on PM.

Those properties are optional in the binding and were only added to the
in-tree DTs in v6.11, so DTs without them would no longer get the
registers programmed by the kernel. This is not a concern in practice:

 - the DT used by the kernel often comes from U-Boot, which used a DT
   based on Linux v6.2 before v2024.07 and has used the DT synchronized
   with Linux since then, matching the v6.11 DT with the clock changes;
 - U-Boot already sets HHI_HDMI_CLK_CNTL and HHI_MEM_PD_REG0 when
   probing dw_hdmi, since v2019.04, so both registers are already in the
   expected state when Linux boots, even with an older U-Boot and DT.

The risk of regression is therefore very low.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/gpu/drm/meson/Kconfig         |  1 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index 417f79829cf8..6645665f6038 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -17,6 +17,7 @@ config DRM_MESON
 config DRM_MESON_DW_HDMI
 	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
 	depends on DRM_MESON
+	depends on PM
 	default y if DRM_MESON
 	select DRM_DW_HDMI
 	imply DRM_DW_HDMI_I2S_AUDIO
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index eb33c70f29c3..20a821936b3a 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
@@ -102,8 +103,6 @@
 #define HDMITX_DWC_CTRL_REG	0x18
 
 /* HHI Registers */
-#define HHI_MEM_PD_REG0		0x100 /* 0x40 */
-#define HHI_HDMI_CLK_CNTL	0x1cc /* 0x73 */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
 #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
 #define  PHY_CNTL1_INIT		0x03900000
@@ -599,12 +598,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 {
 	struct meson_drm *priv = meson_dw_hdmi->priv;
 
-	/* Enable clocks */
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
-
-	/* Bring HDMITX MEM output of power down */
-	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
-
 	/* Reset HDMITX APB & TX & PHY */
 	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
 	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
@@ -829,9 +822,29 @@ static int __maybe_unused meson_dw_hdmi_pm_resume(struct device *dev)
 	return 0;
 }
 
+static void meson_dw_hdmi_pm_put(void *dev)
+{
+	pm_runtime_put_sync(dev);
+}
+
 static int meson_dw_hdmi_probe(struct platform_device *pdev)
 {
-	return component_add(&pdev->dev, &meson_dw_hdmi_ops);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power on HDMI TX\n");
+
+	ret = devm_add_action_or_reset(dev, meson_dw_hdmi_pm_put, dev);
+	if (ret)
+		return ret;
+
+	return component_add(dev, &meson_dw_hdmi_ops);
 }
 
 static void meson_dw_hdmi_remove(struct platform_device *pdev)

-- 
2.56.1


