Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462700;
	b=Tn9CWNxXOAZZJw5vH6fWZ+2s/4HS/DuTC4R+K3hScN6PMMelJ9lTAFsmgkmqYkQxrTBp
	 eSydkrtim1B4npvzMrPRlLnNoyccYNZ8nX99lfNdTXcR2B/KFAVT0E8PToofKTk3DiN7K
	 FeX6zjZHwFq19w16wl83LgxH+cflyNrjebYew8OZEy/cEW1gN7o/NUf0RSQ/NyJN2sUoe
	 bN7KOcMqOJiB9ck4u3V//mfsjpPn/nKMPB4CdSgb5xl8TVnxVLQbT5tMdQz5G6i632UaI
	 sPH87ukGA3o5zWPWRbTA4h7dqsY50GqBvumS27A5ITKuH3bQgVfUUa5/Y0JsC1noslQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	b=y7sypBtY4DzjCObmHP1qRTXrfYJHhpE7hHhQXp4puTFxA5w6FMIy585TZiQsIzLKp2jq
	 9eku9/Ew5yUacM8g4uO7T6kpsjl/IbQgvDQ5y1FVTZTKWh45uN8X4B45CxCF+fjNHUER7
	 NfEvGy0nwzbyNIYRHHwZ+jywHiBgyhqPN0O0n6HKoaWA/i8lCSCj8Q/ZvFqoQFysNMDQe
	 PVfowgyIUokWKbM55nqjgzRKZzYP7qyHQc99vkHSY13VHSohTJTPRSrIs4b3O2rxqpwT3
	 mxceG7Mw4KYkyIiDhV00aLw8qfLegoxhjHOdQqtLqFOlbyI0rnKvA1fllPBmvDuDjFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdG9XM7E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AF60A261F;
	Mon, 23 Nov 2026 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdG9XM7E
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462700;
	b=PtGBAvaCs3Toqe6Ir4zB5F3llg2x1HAXwJeIYze1KfeFfcdtwF2kEOWJZEGbCKxPQC3i
	 hiCk9i3kHt5IfNGASQJMpj3eU8ieHZabdNHICybHfBgzeWNCHsnk4NSUnfFEFKt8LBmUH
	 4LG2h80A0COeu9ikE1smceYhmgOMvhqUCQpmrvrR62slNanZRlEhvcYzqei+5jCgBTAT/
	 SPzfnF+cbMn4Oi+yFhA4K56w9Ig4CO6i3UYtLer1l6ur9G0kURfBWbY+AHD8d74S9DFxh
	 /R6u+avqh1f/i4NuhSvnpFyZ/BaYZLpztuEg6O7CZyfUQrPXwadN9+CgJbej+vwyAaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462700;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	b=geITENjSIP8gb4OODgWiikXH+6QqPm8U+CDvwugOzxbxE/gWaUzv7r49k8ALHZasNVLb
	 Sp14n9G9fjImAvyTfjmD99REbD5K66vgXXKnf9NAkdZQvndsBa/nAL3uN5sIGDSfsej5K
	 eFJzLhIEYK4ZLV1wClMJQThm3VOWDZqrysiledDTB6aOul5LBaL5MVLSLp0Djn0YByeAK
	 DgQtQmrUfDPiFhi/ZTlnOVvKMDLYQbXHDCPxGGlAKBhxW/6vBSIJm+JgCOeM7WF6lGH6c
	 f9mPryomkbF34EkIMdHoaznoUM4ppG7/UQCGrXHqnHSBd9lFv4EzHegIH1Hc/jaKQ4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 712331F000E0;
	Mon, 23 Nov 2026 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462700;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mdG9XM7EvziQLSc36dVIbBEzHAaBv3DNTi5uwyXDRn0buLB9XgVWabiBauK1fMip0
	 t3Hy9JwYqV3iXVmhzgUECJl/1o/ddHJ75k0B7dTVNLIGLeWpRy3t49SkrObPdLmPa+
	 jjoaCMWxvPpoWwUVRJkn/yYwizTECjLvs8u+xMOrOZAWtwkYjDl8GXkip92Vza6KL7
	 Wuz2NUmuVafoU3fSOZgoy9yXVxqSDAbsVPNIayngtzHzNQmD2h6MTY2zBUb//18FC4
	 HwQS1729xdi7Ij+5OMbqpMFoMPK8R1+sZSQOFrhMYkQGcaMkTTbLCyZ1JGCG1FU8wN
	 nNEpvq7oGqxzA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 707E24C6A5;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:39 +0100
Subject: [PATCH v4 07/11] drm/meson: dw-hdmi: Drop manual HHI clock and
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-7-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNIHfK5aqzi3t3uQvwjXf8pbLr5Pv57z8vIRZ+funw
 FwHzkSFjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiMrsZ/ue0ndXWYi1gvRM6
 Nbdj0zz+9DxfwU2lbW8fSt9+VRF4rIGR4bV7n0X2BaFnx9nWP+tN/aUh+kXCVm7HitWaRlPld1l
 MZAAA
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


