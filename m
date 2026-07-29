Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95135408018
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317480; cv=none; b=bXWUn7M/N+Q7YrHz4a2buzdP59VcY8ysi3pyNNXJnbEnajMze/nOZeVyy8umPY8C1ts7DuwJrr8CGgwLnmTRenPa3QqIUediFf63QkpyUI3owRrshxuhX/LSRmPyro2c++Igw5h/+2rp08lEKUyq8rt+qwdDsQ6X8DgBV5nVVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317480; c=relaxed/simple;
	bh=iVNh9vZzlMsFwb4ZF0Jz4j5wRqJzGgmF7aRnnevvHUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4k7B7FDwmt87Aw5rzFumTu/x5StoSuXMw0JmcdF4od4SHcIs+Mkqw0vu5/3v9G3d+0XloKm3lDEkxyqjMSDt04mtWvSAskY8XK5QryCMRkg6fGAhi3Gg3nMQZTzOwRFdx2yhqGh7+LLh8QF/npNz9CKCSRICLS/9iIMaZbk3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWKKEeHm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWKKEeHm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1230978f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785317477; x=1785922277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I92szghQgPQ6t5MlAj59io8fO+k2eTpgdxA/RVFQPt4=;
        b=JWKKEeHmoE8SCbo2bS0p7NGpLmIV8X41AtiN9tTec4OEgCc6G8Ds838p73WZzvHtw+
         mYfRmWxKoxLVs1IM9VVjwJwRx2LWLkLc9Yz2cnTiZqtJm36jmtoD5PZfufVeYUf2DdZh
         4xOf+zmRG+bQD6kGHUTyEn2T1LU4LSVU1ZkMBnLZFGR8naStnyuyGlwKAm3TNRlCbIVh
         OGPzCUUje1MNxv4DTChmqx5fUpJgV+ZyoZH3U9jNFG27WdjQvOM08d2Qqel4qpnWmlJv
         8aACbsCjAoXQ2BJiaUKQ14wSm+2D6N/xhQxRilwArZkQlIlDu0RyypUZSuc4TRhQiFun
         NNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785317477; x=1785922277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I92szghQgPQ6t5MlAj59io8fO+k2eTpgdxA/RVFQPt4=;
        b=UShCrMLk/pc2ylXV/iIgDO6ueCpYpLd5OaK8k37UK0KpCw5ZeEH5uFpWCZEMBeY5Ga
         IP5RaU67O7Y0xkNrydE+db+IKx7wy+4+cZCTC6W6exYaPmkOt2W4MSrVOHj861lTsJK9
         CT4cQ1cmyI/chTr76lkLRuU7FMIXzwJzU4vYmUb+1ODTwwjEo4Tw3hWgfrrJEdw241yV
         S4trbNUanivZhkI5X2YPKkVtaf8ZZCefIOt34ysBf7gP4+gIW4DksxTmtQ//e3geVrbP
         b/YX2j06mQo4RuyiBzBG6TpabeAy5q9OVItd/sI/IB6ku3L4+JqQjjOaN4PwP/M2CVb1
         eXOA==
X-Forwarded-Encrypted: i=1; AHgh+RpNCXs+lEixu5SCPNscE5gob9S8MB2KuQIiOqWt1Hjvjt8vBItHLCvuOP4ePGVmJLhlWQvm/d9hnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzRQN9I5v5dbDVLbNHWzQeJduEWbzj/SPbsuKIHE0zPtGq68Pc
	yD9qGZcmEwUWw22Ci8KXC0VElxl6AGObXVFYEte1loG4aVy3u61g5O0/
X-Gm-Gg: AR+sD13jmYazNZE9PFtfA/cCRdXK71c3urxui1luRm5AmXJXFb/9DlBX7dBUeojET77
	kSxnhLjuT2PUCMfSJrjZHe17jAKb8aju4huCols1BjB0a3ty4zXQaNNOPhzVnoR3JQzIcWXpUa+
	nA4oNnd6xzauqQ4ho7zIwzDN4v4QosxXOozVnWVDLBBkHTrUbM3P+0calKfv1k7bt+Ky3h+7an0
	HlfV5IspyiM/tur2HlzGp0J1Djg1qkdLfZdSbiDgy4BolFqnSzTsE46uCdj5vhW6w0i02hPdXtK
	Y1zjxjP5O0GAryH/n54imx4YqhFYsxcaQqAsCosROlGoJgquX+jOwMOfBI1UKjvXVsEi6AFk6NG
	loEUm45lG21zlIyeMR6kBSPqpWx+BrFgKCaOh7LyWUNocrUlVLNe/x487niKte71T01C4stIPrL
	3wHyWjP3LKOURh1O2LysQD4/NuuyDqp77VE0oYtnUlKKXDoo4uaLOCseYFZ2DTj+8zUm72/ZEbd
	L3XCS5SYEcqrw==
X-Received: by 2002:adf:e19b:0:b0:47f:97e9:fe55 with SMTP id ffacd0b85a97d-47fbac001b8mr2134310f8f.22.1785317476692;
        Wed, 29 Jul 2026 02:31:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3935sm6766388f8f.4.2026.07.29.02.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:31:16 -0700 (PDT)
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
Subject: [PATCH v2 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
Date: Wed, 29 Jul 2026 10:31:07 +0100
Message-ID: <20260729093112.98324-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093112.98324-1-biju.das.jz@bp.renesas.com>
References: <20260729093112.98324-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * Added a comment in pwrseq_rzg3l_pwrrdy_match().
 * Dropped dev_get_regmap() from probe as regmap is now part of platform
   data.
 * Added a blank line before devm_pwrseq_device_register() in probe.
 * Dropped the error message devm_pwrseq_device_register() as probe prints
   failure message.
 * Dropped local variables dev and regmap from probe().
---
 drivers/power/sequencing/Kconfig              |   8 +
 drivers/power/sequencing/Makefile             |   1 +
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 139 ++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1c5f5820f5b7..245961cc8123 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -27,6 +27,14 @@ config POWER_SEQUENCING_QCOM_WCN
 	  this driver is needed for correct power control or else we'd risk not
 	  respecting the required delays between enabling Bluetooth and WLAN.
 
+config POWER_SEQUENCING_RENESAS_PWRRDY
+	tristate "Renesas Power Ready sequencing driver"
+	depends on SYSC_RZ || COMPILE_TEST
+	help
+	  Say Y here to enable the power sequencing driver for the Renesas
+	  Power Ready signals. This driver handles the power ready signals
+	  required to power on the various IP's on RZ/G3L platform.
+
 config POWER_SEQUENCING_TH1520_GPU
 	tristate "T-HEAD TH1520 GPU power sequencing driver"
 	depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST
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
index 000000000000..723d574c3f10
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3L Power Ready driver
+ *
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/regmap.h>
+
+#define SYS_PWRRDY_N		0xd70
+#define SYS_PWRRDY_N_USB_MASK	BIT(0)
+#define SYS_PWRRDY_N_DSI_MASK	BIT(1)
+#define SYS_PWRRDY_N_CSI_MASK	BIT(2)
+
+static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask, u32 val)
+{
+	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
+
+	return regmap_update_bits(regmap, SYS_PWRRDY_N, mask, val);
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
+	/*
+	 * The pwrrdy provider does not rely on any device-tree phandle/property
+	 * matching, so it unconditionally matches every consumer device that
+	 * requests it.
+	 */
+	return PWRSEQ_MATCH_OK;
+}
+
+static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
+				     const struct auxiliary_device_id *id)
+{
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config = {
+		.parent = &adev->dev,
+		.owner = THIS_MODULE,
+		.drvdata = adev->dev.platform_data,
+		.match = pwrseq_rzg3l_pwrrdy_match,
+		.targets = pwrseq_rzg3l_pwrrdy_targets,
+	};
+
+	pwrseq = devm_pwrseq_device_register(&adev->dev, &config);
+
+	return IS_ERR(pwrseq) ? PTR_ERR(pwrseq) : 0;
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

