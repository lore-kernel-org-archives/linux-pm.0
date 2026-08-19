Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3034078FA
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166816; cv=none; b=UvhMdnmRx2CJeHNEZalimzVbNYZhUpBJFcCdPxxKcx1Bq8E7xW0Blh9WLJUe12ne7q+AC8kq3aWMOG/lju/i8kpYXHnPeuLtuEAfBn6PBSzRFnZm0DSz0nxF5gzPjgsRgbPHDcBWpXu7fsiT6G0dIOBP1h3A23zpm2b+O5XxlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166816; c=relaxed/simple;
	bh=o5XyH9P3vk3BoInj2kkvE0oSF9Z7JoGE7pBySmVKWiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyNuNgYvKJRXIYglCgLcQCOvLdt9Nzu3/mbKN6gvAH93gZa/mh7DThJYjLRzKygPkIjH036Pfkc0f+6gzSVoPamOT3Ayhi8W1IYCYhrZxSdrMLttEEh64w1vL1AhVbW9XW3RaAsMIeJdDW9ta3KSnd1ZoaA/7MK5Okffd6Z9sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZfq3DVj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZfq3DVj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1267843f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787166811; x=1787771611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NzEHqotBWJArYmRLxXL7fUfQ6/GXiPEhm7Sayo0OovA=;
        b=oZfq3DVj0oFrykWovN8rJwfFuHUALSSf4BROJg9DJGiQ/ZCAX69CyoaDcGhII6/wy6
         WHa/uUyVtcxbTC7cV0g41pRHQUd/soMjAtll43su5yKBdr+tCFXeu/KlDBb0/+Nrt2U7
         ZbnHYGWsS87Hpi7YWVHuApJlJMjfzIVPCFmxzZUwnIwrchLTpu2NOj8oQYzTKOR87ijd
         EB6i1XnWzjeoPG0ogPSz5las7CtpmAEoKzQhtzHB1fo+tADrtivd0Rp5/uLIrT4WBXHB
         HexKvx+Ojt3IJDG3WTNPAdoJoESeTil3ALkcbRd18bRT7Ow5a0NVRFSS13CZW4Ps6uCN
         vFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787166811; x=1787771611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NzEHqotBWJArYmRLxXL7fUfQ6/GXiPEhm7Sayo0OovA=;
        b=pvgUFM8aewFcm5nQAK0H1ipW8bOnrVhJ718ciu93GZhNJASJ48K2WDIcLXODy/6DYz
         nO86sIRCns1G4Qgc3xke/gbDtET8Zrr4GwFxgkVq6057OHN8Z0dmKHaXFKP82lUnRC7x
         x53687FXmflcljdzYSPHxPYwShRfZlj6WAQy3sEzqlOmnmqCm0+2YYEOv1Y7xjDRd8t+
         /cy6s7ATV85Wfqo1YlWK0YxS8TZi96gT8g11W5WZjuYs0rbD0GaCICgp52FMU62wykgi
         eEagDK98Jr47lNc3wHwjNrp5ovAjhx/o1rc3pXoFd0pR7xR74fS0v9uMaZ8ySEnmwe31
         Ioxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2vm5CXbTyCqiDXng5t54B+doBZ1JYiW0OZYdTnXivc8vY1kLp5MfBSj0PuzcOwQbYqg/TtDwbxw==@vger.kernel.org
X-Gm-Message-State: AFuF++lFiU1Wb6+vod69vRi+Y6atT8GJSUH0hMMrNFcVrc9f9I7xVVGS
	CUbecrGK7/L/oCl+HuIHwV8niKjskIFSsNoA5y1jxf/BuAIVmAi5G2SX
X-Gm-Gg: AR+sD10OXyJ03raVzdz4+0eI9/2aq01ucCj9Hn5AR73HfZIYQoQnhKU9xl47xT79zh7
	ANXgm9XVQVEMSVMrY8aXqy2qZnxT5uTPlCv5l/6v6eB0YrE3PPzYXlDChnLmCCbW2GSUZ8U44jR
	FvvNJH2ngdBjnJ7OyOOWQDbQOLm2m/xpKj0cYMEceytwhHB1hFAzaJNuHlTR5mo59ANe85hv6Sd
	3pRGVlu6G80+2qqKbY1SDc4otv9q7NOTcHNfG1iwJaHP9nXIhFi9uj48dEdgA0FZ11GiUalWBmf
	bdWcKegXO48POtWAQon5D1DCs9pIbXCE/9oNi8tRyOEGk4S1HPz/btII++vFeK2LOH7W5CY4E9X
	TK3q/dNlHAXwrCs2ItDAKnbqV8UW1Uw76ilJt/KqRljXeiR4w8OoBH3yg20dQr496GNuPYzMCOD
	soBRAGbV4mJbT59cmdlqOgpsEBAdxPPJ/sRrDvLhjPCkqXZiIpKkf6CzRyuz+0Pv72HQUM
X-Received: by 2002:a05:6000:4310:b0:482:a9d7:7ced with SMTP id ffacd0b85a97d-482b1fd9655mr11682573f8f.14.1787166810601;
        Wed, 19 Aug 2026 12:13:30 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:c7e0:8c9b:65f0:4aef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c338dsm6153398f8f.25.2026.08.19.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 12:13:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
Date: Wed, 19 Aug 2026 20:13:20 +0100
Message-ID: <20260819191325.217809-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819191325.217809-1-biju.das.jz@bp.renesas.com>
References: <20260819191325.217809-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
SoC. The driver binds as an auxiliary device to the parent SYSC driver,
using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
{usb,dsi,csi}-pwrrdy pwrseq targets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Replace the large of_device_id structures by C strings, and
   using of_device_is_compatible() will reduce kernel size.
 * Replaced of_device.h -> of.h
 * Dropped local variable pwrseq from pwrseq_rzg3l_pwrrdy_probe().
v2->v3:
 * Kconfig selects AUXILIARY_BUS to avoid compilation issues.
 * Added match for consumer device and added of_device.h header file.
 * Replaced regmap_update_bits()->regmap_assign_bits() and updated
   the function parameter of pwrseq_rzg3l_set_pwrrdy().
 * Simpilfied probe() return with PTR_ERR_OR_ZERO macro.
v1->v2:
 * Added a comment in pwrseq_rzg3l_pwrrdy_match().
 * Dropped dev_get_regmap() from probe as regmap is now part of platform
   data.
 * Added a blank line before devm_pwrseq_device_register() in probe.
 * Dropped the error message devm_pwrseq_device_register() as probe prints
   failure message.
 * Dropped local variables dev and regmap from probe().
---
 drivers/power/sequencing/Kconfig              |   9 ++
 drivers/power/sequencing/Makefile             |   1 +
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 137 ++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 226c62704d9b..6b5d187dd4b5 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -27,6 +27,15 @@ config POWER_SEQUENCING_QCOM_WCN
 	  this driver is needed for correct power control or else we'd risk not
 	  respecting the required delays between enabling Bluetooth and WLAN.
 
+config POWER_SEQUENCING_RENESAS_PWRRDY
+	tristate "Renesas Power Ready sequencing driver"
+	depends on SYSC_RZ || COMPILE_TEST
+	select AUXILIARY_BUS
+	help
+	  Say Y here to enable the power sequencing driver for the Renesas
+	  Power Ready signals. This driver handles the power ready signals
+	  required to power on the various IP's on RZ/G3L platform.
+
 config POWER_SEQUENCING_TH1520_GPU
 	tristate "T-HEAD TH1520 GPU power sequencing driver"
 	depends on ARCH_THEAD || COMPILE_TEST
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 0911d4618298..b33d08d82f43 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
+obj-$(CONFIG_POWER_SEQUENCING_RENESAS_PWRRDY) += pwrseq-renesas-pwrrdy.o
 obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
 obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
new file mode 100644
index 000000000000..b8d62a4fecc7
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3L Power Ready driver
+ *
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/regmap.h>
+
+#define SYS_PWRRDY_N		0xd70
+#define SYS_PWRRDY_N_USB_MASK	BIT(0)
+#define SYS_PWRRDY_N_DSI_MASK	BIT(1)
+#define SYS_PWRRDY_N_CSI_MASK	BIT(2)
+
+static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask,
+				   bool val)
+{
+	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
+
+	return regmap_assign_bits(regmap, SYS_PWRRDY_N, mask, val);
+}
+
+static int pwrseq_rzg3l_usb_pwrrdy_enable(struct pwrseq_device *pwrseq)
+{
+	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_USB_MASK, 0);
+}
+
+static int pwrseq_rzg3l_usb_pwrrdy_disable(struct pwrseq_device *pwrseq)
+{
+	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_USB_MASK, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_rzg3l_usb_pwrrdy_unit = {
+	.name = "usb-pwrrdy-power-sequence",
+	.enable = pwrseq_rzg3l_usb_pwrrdy_enable,
+	.disable = pwrseq_rzg3l_usb_pwrrdy_disable,
+};
+
+static int pwrseq_rzg3l_dsi_pwrrdy_enable(struct pwrseq_device *pwrseq)
+{
+	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_DSI_MASK, 0);
+}
+
+static int pwrseq_rzg3l_dsi_pwrrdy_disable(struct pwrseq_device *pwrseq)
+{
+	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_DSI_MASK, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_rzg3l_dsi_pwrrdy_unit = {
+	.name = "dsi-pwrrdy-sequence",
+	.enable = pwrseq_rzg3l_dsi_pwrrdy_enable,
+	.disable = pwrseq_rzg3l_dsi_pwrrdy_disable,
+};
+
+static int pwrseq_rzg3l_csi_pwrrdy_enable(struct pwrseq_device *pwrseq)
+{
+	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_CSI_MASK, 0);
+}
+
+static int pwrseq_rzg3l_csi_pwrrdy_disable(struct pwrseq_device *pwrseq)
+{
+	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_CSI_MASK, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_rzg3l_csi_pwrrdy_unit = {
+	.name = "csi-pwrrdy-power-sequence",
+	.enable = pwrseq_rzg3l_csi_pwrrdy_enable,
+	.disable = pwrseq_rzg3l_csi_pwrrdy_disable,
+};
+
+static const struct pwrseq_target_data pwrseq_rzg3l_usb_pwrrdy_target = {
+	.name = "usb-pwrrdy",
+	.unit = &pwrseq_rzg3l_usb_pwrrdy_unit,
+};
+
+static const struct pwrseq_target_data pwrseq_rzg3l_dsi_pwrrdy_target = {
+	.name = "dsi-pwrrdy",
+	.unit = &pwrseq_rzg3l_dsi_pwrrdy_unit,
+};
+
+static const struct pwrseq_target_data pwrseq_rzg3l_csi_pwrrdy_target = {
+	.name = "csi-pwrrdy",
+	.unit = &pwrseq_rzg3l_csi_pwrrdy_unit,
+};
+
+static const struct pwrseq_target_data *pwrseq_rzg3l_pwrrdy_targets[] = {
+	&pwrseq_rzg3l_usb_pwrrdy_target,
+	&pwrseq_rzg3l_dsi_pwrrdy_target,
+	&pwrseq_rzg3l_csi_pwrrdy_target,
+	NULL
+};
+
+static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
+				     struct device *dev)
+{
+	if (of_device_is_compatible(dev->of_node, "renesas,r9a08g046-usbphy-ctrl") ||
+	    of_device_is_compatible(dev->of_node, "renesas,r9a08g046-mipi-dsi"))
+		return PWRSEQ_MATCH_OK;
+
+	return PWRSEQ_NO_MATCH;
+}
+
+static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
+				     const struct auxiliary_device_id *id)
+{
+	struct pwrseq_config config = {
+		.parent = &adev->dev,
+		.owner = THIS_MODULE,
+		.drvdata = adev->dev.platform_data,
+		.match = pwrseq_rzg3l_pwrrdy_match,
+		.targets = pwrseq_rzg3l_pwrrdy_targets,
+	};
+
+	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&adev->dev, &config));
+}
+
+static const struct auxiliary_device_id pwrseq_rzg3l_pwrrdy_id_table[] = {
+	{ .name = "rz_sysc.pwrseq-pwrrdy" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, pwrseq_rzg3l_pwrrdy_id_table);
+
+static struct auxiliary_driver pwrseq_rzg3l_pwrrdy_driver = {
+	.driver = {
+		.name = "pwrseq-rzg3l-pwrrdy",
+	},
+	.probe = pwrseq_rzg3l_pwrrdy_probe,
+	.id_table = pwrseq_rzg3l_pwrrdy_id_table,
+};
+module_auxiliary_driver(pwrseq_rzg3l_pwrrdy_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G3L Power Ready Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

