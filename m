Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793339;
	b=IZjTz92LwUKTaZVmCN+eE2k+DDRu2VS7H8YLrhkXPHX8xc7JxKpzPTCKIAIgYLbzRQK7
	 ilp8MACVL9X6ndtvRlpaw+M/bkD6+QNjatX7uGCi/ZQ78sxA6rJvWObY35VWZiqgrfShy
	 wkDpV0mGBvP7HkC579VpnKFc1+pxIQMkYxlYqU9xMvNYBNEK514J9AkQUrm7o0XEN6P2k
	 7gvlSNyZxBvEVep5KOiGzZk29JWT97oyS5bMWhiuiUCKxC7mCzCW2Q7yB/wFK6C4XO33b
	 4jGw5sk1Z7fDORp2s1lEiyUBep5/StOct+EwRmmyLRK0oHft9pTfqbMdkddvmKqyYEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793339;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	b=ASopexcW2ZOaMbZYknBzRhK4y1OzvA8vfQj4zLKyIQqKy1t9AfbrNA1HeKtO7cVAEEAG
	 HpuMeoMH9/TWuTLWwu8dmNvlpnGB/yMLUGOPeFKp6P+K1w3lXcqUseSxLaNk5Hs4IyI0u
	 1Ipn/Mdq1StPuPeaY7sSJuBshHmBUaugbsQ6ZsrN9cMZlwFOmkxVs0y1q13DwaVbA0iTt
	 HjFoBzJUoNUXYcLN0mH4rKanSnyRISXhwUzZxt/FICkTkaqlA99b7SX52bKMjWkOdvG8Q
	 3rlhCniUYz/4wNcijjhfdwahOGZL5kTcmeVRrH7e17qFF89v9AZAF8S6y3mI1vqblZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6X68AE2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC0606A31C;
	Fri, 27 Nov 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6X68AE2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793338;
	b=rG80B2qN9ZxUV8Q7ZjT5XIuqVZgPzfbf245R2ykxzoi3zrZJqjmP8b7KqG69AWj9byMi
	 pQ0sOtSwcg4WZD/Oc/h9PflPl20L7Z1BszcrGgUCJtMblPCY+4Su1kddsK9ksOtTsLPba
	 l+4fQiD7owp59bvFcYm2Cb7TcLdVbT+0FupYqct37g7r55N9/Dh/7CbuzlmrdadaSJSKl
	 9GCSMpiK57R4FouzjDHvyeCBJeR+g5RSVpOqW7pgn68eAP083qZ2kZhjl+ngus1GI4DPH
	 M5h6zkOo+X1oxIvO4apQAjwOvR3Ww/TUl5S1gRiT+BxwNbU4y2LbBnKTjNrZ+wzqXmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793338;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	b=fzdBVJnZMUqn77rsvlB3EYGnLEaVLdDbWwp6ZiSgfyRwm2B/if+4fUfHIbsOkhy+Z2v9
	 jZKDRth53+VwO04dBN0IGM8/h9uCP9UpFp2oK8mRLrzsVYO2aj2z4UipDRNwtpBa8E1//
	 /I7yFLiOGshP80zicUgQnx7/DlCqLf4vLVKebZc7WlSSOMoPAMUDrJkgsN+R7L1CZhVPZ
	 t6pHa6Tvzpn39ve4r8qIPbWP2Des6JEAAmw5ErVXS9zYodLJBdm+k0PBeM9qo1aOLlzDa
	 4exa9kXtZBESXRC7tYfsmoOG9p2Fahazru3ATmXhZucFVPSpkIWMUNkM/MkP9mOqcBw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 16B611F00A1C;
	Fri, 27 Nov 2026 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793338;
	bh=jnPu9C8U78zwh2haTTxt6kMsYkBetNfurHLTgZHI+MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l6X68AE2e2xP9XEMZuEpwKaWwdYQM/zzUP2kjbQqmXKuD8DZH7aaiaw4dq7KKn+8t
	 hth9qlVVnadQIkBht4G+Wedm8/NQ/soa55Uw4P3oQHnbNe3nCPQBCim9nSBMRiZ/QJ
	 ECLvlM3tMmuECqeAG1FXFKuN/tjPiDC6L3q6bvPPKyDJLW+Fc9uyAZQksHKoVeTdIn
	 JfhdcSaYmVG1W+uAZU1zYmhTkzJkmcCYLhYrYo55QNRhXKzd4ogsabXjlaF65dSb4U
	 K9UtBBnsWUwt4rQsuGULvngPR0ImiNcpM9G4TP6Pam1BQ0IcC6XT+CEJn5hduHEPsF
	 Pe/rWVfP1nXNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DBAC04DC8C;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:09 +0100
Subject: [PATCH v5 08/12] drm/meson: dw-hdmi: Drop manual HHI clock and
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
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-8-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwinf5xUnzPhy+3rGVQYzu5JHXGve+uzW5mXUZMye1
 7SK+dD/jlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiJwQZ/pctr840/HT4i1lN
 1hL2sAtKynn/TlgkB/8XiXg5N+7MPCdGhlfZ+tO4GqaGhwr7TYx4+75ZQXbG3r9b1Df8+6rt8VW
 pgAEA
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


