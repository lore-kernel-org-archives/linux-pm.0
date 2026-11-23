Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462690;
	b=bKugvorXNA4pxxdIeI0znJUJi1dFIZDk4KO+VyxPEV5QngDt0LGveCfkmUksCO4OHez8
	 U1bf3ZOdFntbvUI3eQ29RZoniQ6LvRVUspW4RIWJFCKA/ZQBPJ3i4WUfA/jQpiiU85fgx
	 BO8R8uKeWenEf6IlFg9dJyaiQX3OcSK7AIdkMAzqUC0T29uc7djwr2p+qE3sgee3HlHkp
	 feiOAPM226VHk8NeHgi8jxx0hG8LBVj5RrGvACAhgETBzPatJjzqo3c7hPntlEFxInEiZ
	 2HTqDzM4cLKFQaUtA4NvI4S5Gyms60C/yRzg9c3Urj8BweGy+fS2EC9cFdKO8FpZPBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462690;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FKOXP4yMwPrbJh3eEJzSEbE/Lx582DWty8qBWqfTFF8=;
	b=WcaoeVlpHkRUpQOU81St7gcLLjAjqtEqBZu6nwy6fAIetCimM0NblgfMEWO7AtWbFwV7
	 iqCfY0hGbpnzQU84JRYe15UL2r0kRn57sqrDA5tWd96fOXzDAXienEwnuEIywZWTC8iQa
	 w7f6p60PZ4BsxiA9IZmZSB2YJd+EE70Zj2x1kGLNFW/hsT16uqEQz/ihrGG3zxfqSXLoG
	 ZVoAL7sn59BCvz1kTPLqRL0XoqWuMUuSc41eHxsuuFoQmiboEkjjKDN4UPFRpI6kPsCXH
	 tdj6UyUrCOv4Tdgt7J59bFwBLY3ccG2Nwy+HlYx38dEM+JUTh07O1uhnpfH+HBeldOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpMLd7vH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD36606A327;
	Mon, 23 Nov 2026 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpMLd7vH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462689;
	b=SmXrzXRsu9ll+z3FmK4MqX2ZMHSViuqHm76ITMzpVEEknE4BNGIad+dWaYYuISpgykf9
	 wFR/bPfxspjebGZQv6Km4h9CUybte7xSkJlQbKAwC440cD6WkWnbC5WqruPKc1PgbIL2K
	 oK1lkB1dCIdOTxmDhMnNm7qhA00+uM8mtMODT6ZdU+uDxq8DoRITGE9JL2tWhYmzlAHhw
	 1zkGq5CpouJwUsjz3HkBk583TzGpBsnkEyT0KheO3UAUx2NA8Re2NpRQfx6tXEG6aWAHS
	 0PeRjT7zMXhXjfj+vbHysY/+XybHwVGizozrQo1NlwA4KBQD0U1ljXzC8n1EJ3Czi+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462689;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FKOXP4yMwPrbJh3eEJzSEbE/Lx582DWty8qBWqfTFF8=;
	b=d2mQO6FEnSj5pe+LXQG020V0YAeXAAX76iPkE87fGg3xJSwt57dy2sOyAPi9MMdVeABo
	 raFX4/kecrHQrs30yjF6x5GyAdiWO+uJdJk+Y55VHt/tc5tDcGAc7TpKmKiUAx10iuIxq
	 X5TobYztFRt6CLkSnJ3w5BBCq9fH6ygZZxs7nW8oGCjoLNwZvHWdVNdkrATHvc+qY5/y5
	 5r4dqxjq+aQCnJMiIfP8c65fX8hMku8E0fKP/iMcK2kw6TgM1cLr09ml+hile+eeA2l41
	 x6J01Lkw4Jupis0BklNVhkABsG9P04KzQLw/8dEQfg0/BASYskOYbiUIJ0VE7K2VqYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 948D31F008B2;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462689;
	bh=FKOXP4yMwPrbJh3eEJzSEbE/Lx582DWty8qBWqfTFF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bpMLd7vHe4wJ2w/27HFCUJtfYO38vBaDvMAsQBrIkitu9uNgdb9ko3eKo3oKrFcvr
	 Uu9RsUwfs6NG+ROwn64jgWtuQxF2FXEZC7yQBqQJ3WTYpRE8L0GABaWg/D+tr7kpt3
	 2MipHpS7q4slyMjt0YOGqV6IxWRzmpImkK9Scifh8zqw/hzu44tINT2hLHOZPvYo/b
	 BowLJOVpB6grplOMVmSDiWijnuDoqdWERIdjd/IxEK2W8yZPmKc1wHv8q//FR3VlAS
	 y5tZ7JNnGafd5JrmF1SWA1SSeNAPOb4/GW42KgKvwmF11b1gBXJeJCPNMcVO0EwYF8
	 Iy0OimWFpFm1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1DAF44C699;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:36 +0100
Subject: [PATCH v4 04/11] phy: amlogic: Add Meson HDMI TX PHY driver
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-4-3fb94f5534ca@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12653;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=vqCPhKL1YPqx9BNZ7Q6idQmOOAu9TDiJSL8M8T35XXE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNG4NFqYVLcuYeo88eHSgv9t+7+qVJd1LjsdemOUbt
 1n+e7Z6RykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCR/9yMDEv2MN22i9/3o0tz
 x2kWxorN4W/9mtzZHgr4l3/7qC0VJcXwVzpi3oITk2R+Gata5jEd1+05tUZc56elKNOc6duaDLZ
 OYQEA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add a PHY driver for the HDMI TX PHY found on Amlogic GXBB, GXL, GXM
and G12A SoCs. The PHY is controlled through the HHI_HDMI_PHY_CNTL0..5
registers of the HHI system controller, of which the PHY node is a
child, so the regmap is obtained from the parent syscon.

The driver implements the generic PHY API with the HDMI configuration
options: .validate() accepts only 8 bpc and a TMDS character rate
covered by the per-SoC table, .configure() programs the analog
settings matching that rate, and .power_on()/.power_off() handle the
reset sequence and the return to the initial state.

The per-SoC register values and rate thresholds are taken from the
existing HDMI TX code, so that the PHY handling can be moved out of the
display driver.

For DTs that do not provide a "phys" property on the HDMI TX node,
export meson_hdmi_phy_create_legacy() so that the display driver can
still create the PHY itself. It is marked as deprecated and will be
removed together with the fallback in meson_dw_hdmi.c.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/phy/amlogic/Kconfig             |  11 ++
 drivers/phy/amlogic/Makefile            |   1 +
 drivers/phy/amlogic/phy-meson-hdmi-tx.c | 319 ++++++++++++++++++++++++++++++++
 include/linux/phy/phy-meson-hdmi-tx.h   |  19 ++
 4 files changed, 350 insertions(+)

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index ce7ba3eb2a8e..14fcde8d88bc 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -105,3 +105,14 @@ config PHY_MESON_AXG_MIPI_DPHY
 	  Enable this to support the Meson MIPI DPHY found in Meson AXG
 	  SoCs.
 	  If unsure, say N.
+
+config PHY_MESON_HDMI_TX
+	tristate "Meson HDMI TX PHY driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HDMI TX PHY found on Amlogic
+	  GXBB, GXL, GXM and G12A SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 91e3b9790c03..fa7165700a93 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG)	+= phy-meson-g12a-mipi-dphy-analog
 obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_DPHY)		+= phy-meson-axg-mipi-dphy.o
+obj-$(CONFIG_PHY_MESON_HDMI_TX)			+= phy-meson-hdmi-tx.o
diff --git a/drivers/phy/amlogic/phy-meson-hdmi-tx.c b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
new file mode 100644
index 000000000000..a925d02007a9
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Amlogic Meson HDMI TX PHY driver (GXBB / GXL / GXM / G12A)
+ *
+ * Copyright (C) 2026 Ronald Claveau <linux-kernel-dev@aliel.fr>
+ *
+ * Based on meson_dw_hdmi.c:
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-hdmi.h>
+#include <linux/phy/phy-meson-hdmi-tx.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
+#define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
+#define  PHY_CNTL1_INIT		0x03900000
+#define  PHY_INVERT		BIT(17)
+#define  PHY_CNTL1_CTRL_MASK	GENMASK(3, 0)
+#define  PHY_CNTL1_RESET	0xf /* enable + software reset */
+#define  PHY_CNTL1_UNRESET	0xe /* enable + unreset */
+#define HHI_HDMI_PHY_CNTL2	0x3a8 /* 0xea */
+#define HHI_HDMI_PHY_CNTL3	0x3ac /* 0xeb */
+#define HHI_HDMI_PHY_CNTL4	0x3b0 /* 0xec */
+#define HHI_HDMI_PHY_CNTL5	0x3b4 /* 0xed */
+
+/* The code resets the PHY 3 times in a row */
+#define PHY_RESET_COUNT		3
+
+struct meson_hdmi_phy_rate {
+	unsigned int min_rate;	/* TMDS character rate, in Hz */
+	u32 cntl0;
+	u32 cntl3;
+	u32 cntl5;		/* only used if has_cntl5 */
+};
+
+struct meson_hdmi_phy_data {
+	const struct meson_hdmi_phy_rate *rates;
+	unsigned int num_rates;
+	unsigned int max_rate;	/* Hz, TMDS character rate maximum */
+	bool has_cntl5;
+	u32 cntl0_init;
+	u32 cntl1_init;
+};
+
+struct meson_hdmi_phy {
+	struct regmap *hhi;
+	const struct meson_hdmi_phy_data *data;
+};
+
+/* GXBB */
+static const struct meson_hdmi_phy_rate gxbb_rates[] = {
+	/* 5.94Gbps, 3.7125Gbps */
+	{ 371250000, 0x33353245, 0x2100115b },
+	/* 2.97Gbps */
+	{ 297000000, 0x33634283, 0xb000115b },
+	/* 1.485Gbps, down to 159Mbps */
+	{ 15900000,  0x33632122, 0x2000115b },
+};
+
+/* GXL / GXM */
+static const struct meson_hdmi_phy_rate gxl_rates[] = {
+	/* 5.94Gbps, 3.7125Gbps */
+	{ 371250000, 0x333d3282, 0x2136315b },
+	/* 2.97Gbps */
+	{ 297000000, 0x33303382, 0x2036315b },
+	/* 1.485Gbps */
+	{ 148500000, 0x33303362, 0x2016315b },
+	/* 742.5Mbps, down to 159Mbps */
+	{ 15900000,  0x33604142, 0x0016315b },
+};
+
+/* G12A */
+static const struct meson_hdmi_phy_rate g12a_rates[] = {
+	/* 5.94Gbps, 3.7125Gbps */
+	{ 371250000, 0x37eb65c4, 0x2ab0ff3b, 0x0000080b },
+	/* 2.97Gbps */
+	{ 297000000, 0x33eb6262, 0x2ab0ff3b, 0x00000003 },
+	/* 1.485Gbps, down to 159Mbps */
+	{ 15900000,  0x33eb4242, 0x2ab0ff3b, 0x00000003 },
+};
+
+static const struct meson_hdmi_phy_data gxbb_data = {
+	.rates = gxbb_rates,
+	.num_rates = ARRAY_SIZE(gxbb_rates),
+	.max_rate  = 600000000, /* HDMI 2.0 */
+	.cntl0_init = 0x0,
+	.cntl1_init = PHY_CNTL1_INIT | PHY_INVERT,
+};
+
+static const struct meson_hdmi_phy_data gxl_data = {
+	.rates = gxl_rates,
+	.num_rates = ARRAY_SIZE(gxl_rates),
+	.max_rate  = 600000000, /* HDMI 2.0 */
+	.cntl0_init = 0x0,
+	.cntl1_init = PHY_CNTL1_INIT,
+};
+
+static const struct meson_hdmi_phy_data g12a_data = {
+	.rates = g12a_rates,
+	.num_rates = ARRAY_SIZE(g12a_rates),
+	.max_rate  = 600000000, /* HDMI 2.0 */
+	.has_cntl5 = true,
+	.cntl0_init = 0x000b4242, /* Bandgap */
+	.cntl1_init = PHY_CNTL1_INIT,
+};
+
+static const struct meson_hdmi_phy_rate *
+meson_hdmi_phy_find_rate(const struct meson_hdmi_phy_data *data, u64 rate)
+{
+	unsigned int i;
+
+	if (rate > data->max_rate)
+		return NULL;
+
+	for (i = 0; i < data->num_rates; i++)
+		if (rate >= data->rates[i].min_rate)
+			return &data->rates[i];
+
+	return NULL;
+}
+
+/* Fallback to init mode: CNTL1 first, then CNTL0 (order matters) */
+static void meson_hdmi_phy_set_init_state(struct meson_hdmi_phy *priv)
+{
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, priv->data->cntl1_init);
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, priv->data->cntl0_init);
+}
+
+static int meson_hdmi_phy_init(struct phy *phy)
+{
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
+
+	meson_hdmi_phy_set_init_state(priv);
+
+	return 0;
+}
+
+static int meson_hdmi_phy_configure(struct phy *phy,
+				    union phy_configure_opts *opts)
+{
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
+	const struct meson_hdmi_phy_rate *r;
+
+	r = meson_hdmi_phy_find_rate(priv->data, opts->hdmi.tmds_char_rate);
+	if (!r)
+		return -EINVAL;
+
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, r->cntl0);
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, r->cntl3);
+	if (priv->data->has_cntl5)
+		regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, r->cntl5);
+
+	/* Disable clock, fifo, fifo_wr */
+	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
+			   PHY_CNTL1_CTRL_MASK, 0);
+
+	return 0;
+}
+
+static int meson_hdmi_phy_validate(struct phy *phy, enum phy_mode mode,
+				   int submode, union phy_configure_opts *opts)
+{
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
+
+	if (mode != PHY_MODE_HDMI)
+		return -EINVAL;
+
+	if (submode != PHY_HDMI_MODE_TMDS)
+		return -EINVAL;
+
+	if (opts->hdmi.bpc != 8)
+		return -EINVAL;
+
+	if (!meson_hdmi_phy_find_rate(priv->data, opts->hdmi.tmds_char_rate))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int meson_hdmi_phy_power_on(struct phy *phy)
+{
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
+	int i;
+
+	/* Reset PHY 3 times in a row */
+	for (i = 0; i < PHY_RESET_COUNT; i++) {
+		/* Enable and software reset */
+		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
+				   PHY_CNTL1_CTRL_MASK, PHY_CNTL1_RESET);
+		fsleep(2000);
+
+		/* Enable and unreset */
+		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
+				   PHY_CNTL1_CTRL_MASK, PHY_CNTL1_UNRESET);
+		fsleep(2000);
+	}
+
+	return 0;
+}
+
+static int meson_hdmi_phy_power_off(struct phy *phy)
+{
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
+
+	meson_hdmi_phy_set_init_state(priv);
+
+	return 0;
+}
+
+static const struct phy_ops meson_hdmi_phy_ops = {
+	.init		= meson_hdmi_phy_init,
+	.configure	= meson_hdmi_phy_configure,
+	.validate	= meson_hdmi_phy_validate,
+	.power_on	= meson_hdmi_phy_power_on,
+	.power_off	= meson_hdmi_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *meson_hdmi_phy_alloc(struct device *dev,
+					struct regmap *hhi,
+					const struct meson_hdmi_phy_data *data)
+{
+	struct meson_hdmi_phy *priv;
+	struct phy *phy;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->hhi = hhi;
+	priv->data = data;
+
+	phy = devm_phy_create(dev, NULL, &meson_hdmi_phy_ops);
+	if (IS_ERR(phy))
+		return phy;
+
+	phy_set_drvdata(phy, priv);
+
+	return phy;
+}
+
+/*
+ * DEPRECATED: only for DTs without a "phys" property on the HDMI TX node.
+ * Remove together with the fallback in meson_dw_hdmi.c.
+ */
+struct phy *meson_hdmi_phy_create_legacy(struct device *dev,
+					 struct regmap *hhi,
+					 enum meson_hdmi_phy_soc soc)
+{
+	static const struct meson_hdmi_phy_data *const soc_data[] = {
+		[MESON_HDMI_PHY_GXBB] = &gxbb_data,
+		[MESON_HDMI_PHY_GXL]  = &gxl_data,
+		[MESON_HDMI_PHY_G12A] = &g12a_data,
+	};
+
+	if (soc >= ARRAY_SIZE(soc_data))
+		return ERR_PTR(-EINVAL);
+
+	return meson_hdmi_phy_alloc(dev, hhi, soc_data[soc]);
+}
+EXPORT_SYMBOL_GPL(meson_hdmi_phy_create_legacy);
+
+static int meson_hdmi_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct regmap *hhi;
+	struct phy *phy;
+	const struct meson_hdmi_phy_data *data;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	/* The PHY node is a child of the HHI syscon */
+	hhi = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(hhi))
+		return dev_err_probe(dev, PTR_ERR(hhi),
+				     "failed to get HHI regmap\n");
+
+	phy = meson_hdmi_phy_alloc(dev, hhi, data);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "failed to create PHY\n");
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id meson_hdmi_phy_of_match[] = {
+	{ .compatible = "amlogic,meson-gxbb-hdmi-tx-phy", .data = &gxbb_data },
+	{ .compatible = "amlogic,meson-gxl-hdmi-tx-phy",  .data = &gxl_data },
+	{ .compatible = "amlogic,meson-g12a-hdmi-tx-phy", .data = &g12a_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, meson_hdmi_phy_of_match);
+
+static struct platform_driver meson_hdmi_phy_driver = {
+	.probe = meson_hdmi_phy_probe,
+	.driver = {
+		.name = "meson-hdmi-tx-phy",
+		.of_match_table = meson_hdmi_phy_of_match,
+	},
+};
+module_platform_driver(meson_hdmi_phy_driver);
+
+MODULE_AUTHOR("Ronald Claveau <linux-kernel-dev@aliel.fr>");
+MODULE_DESCRIPTION("Amlogic Meson HDMI TX PHY driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/phy/phy-meson-hdmi-tx.h b/include/linux/phy/phy-meson-hdmi-tx.h
new file mode 100644
index 000000000000..fe76a5f7efdb
--- /dev/null
+++ b/include/linux/phy/phy-meson-hdmi-tx.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __PHY_MESON_HDMI_TX_H
+#define __PHY_MESON_HDMI_TX_H
+
+struct device;
+struct regmap;
+
+enum meson_hdmi_phy_soc {
+	MESON_HDMI_PHY_GXBB,
+	MESON_HDMI_PHY_GXL,	/* GXL and GXM */
+	MESON_HDMI_PHY_G12A,
+};
+
+/* DEPRECATED: compat for DTs without "phys" on the HDMI TX node */
+struct phy *meson_hdmi_phy_create_legacy(struct device *dev,
+					 struct regmap *hhi,
+					 enum meson_hdmi_phy_soc soc);
+
+#endif /* __PHY_MESON_HDMI_TX_H */

-- 
2.56.1


