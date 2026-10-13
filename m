Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8F528443
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912950; cv=none; b=nW54arNN6OtX0jcVLQ9cyP7ycP/HAzd43h8+rPy1iPCzGV4IONe7S4dgpkIw6LYDVm9xENjXnEuXwCOHmWFhvy8WZJvf/LOz4sbndReEw41GDzkxCu1jrf2GBjvjjXARnrhafOsrsrQ7Ad68/UsLLBdhPgMLsTvopxMh9aUD0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912950; c=relaxed/simple;
	bh=vTbgxdJuUc8bPT6jOJqWQoEAVh5xzYo4Dkan0XX08wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h79wek1MqoPH8tuV0PqSkOHmUwV3c32oJJXZzYyHgdTdXSx6Qci1ploxvyS8fKb7TiWkN78pkIliptMmGa7VZkrT8RUxG8Gz+DVS54QaEbpBI9iMr18i3COVXortXBQsZ7TXPBK7rFt/PEGiMX0uFJQF1phpz75c7iY+ciOGEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4D35+ia; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4D35+ia"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so26296435e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912943; x=1792517743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dgj4UbbyEsyRyIW26kcdyCzSX0/3ndCVzhgrPch3x2A=;
        b=g4D35+iaEl9PfyFIoyPrM3Amt1jxoWLGvaShf3SMYQCfo+NvRMp35mq/M/QoY54Qmz
         VZDqyUvUjSh1nuepyKVVfBhq0HaaQffrrJT/PJ+Aea2l2fjSwFjc67WO+Ymbsr5A8Mri
         4S2fa7lIUijfl71lUsMv1BWVsgAMTXgdM4da+0/JLg7VhJTuull/px4o/CbHTZZTHJ8g
         rZdroQO1hM8jE7Th7HW+w1gExVz7MPRHyl1moziLMGOeBHgJJrfnK7aApbBnX62T9hKE
         VPaqsThWCZc2zDKoMpSEbecHfMaCaA+SPVA7q4BEpvRi4+6B7ljqw7fwKLbpXrF+E6eS
         MHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912943; x=1792517743;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dgj4UbbyEsyRyIW26kcdyCzSX0/3ndCVzhgrPch3x2A=;
        b=ikKUl8OporYQhk05zCFqY0v1lazWoLlOSlT2an39GhXo7yUeALGxXsGj2zAfbq62GU
         IzTvphYoO4ARn7F/u/Jg99y0Nd8a0VRs1b6lJGuAB+9M48DJvcZIZuAvnASvt/VWHPAo
         x8XtMkcNnNJ9ZVb/zp4WZj4x0A8pCeczgyrzEzfXM7RZ5bHkyBMHKTUhUKNoiKJVltjU
         su268I/HqgyBuP/EEtVhy5kps2UwH7vkE6DsCKL54jSUUz2VeHKtaRAiTBoS9TAYBBKw
         MwwGuCsBDIfNfNX6Bl777BYcQB7eWWoLuuvheVJnSR5mIm/GwJVNg6WJMcNf5EQO6Stb
         9PYg==
X-Forwarded-Encrypted: i=1; AKwUvBzTZONKL6WDQh+Jn7jj42Bi0X58sLV1ksnjZ+P1khae6+XKPNzZIXPIRH6wiSZjWcwWLHyueKH2qA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLnSS3HLo6+6E9cnU7v4UOqPTqPsigfMVoDrp97iuqzWpHFt3rk
	8didLYdCwApHOLdwjPn90dlEwaJrcnZGds/oWkWd8m/xIgDFoYKds5PJ
X-Gm-Gg: AYBFou2EzzHod+Kro7HwTE32lMaCtc6+RFPY7d+rRtCD7V4wFQW9qGRv4wvW9k6ldJh
	GleYbTO/VzAKx+0blk0tOUInfC/EmLaphVN53sD0udzw7bmAXwX2Gqancgns5jKFH0qhYaCsVgo
	M1ws0eTOGfDjUuu6y9jG6PdreJ9OX9enrErxCmgFTr8xl3y6+kqevxkSiATbugPBPuLEHQ2DW6b
	Y5JKkO+CeIQmCGDKrQ6vD9dPEaMOh+9UNvHf1USEcIfnMuO515U31hReZjzp2xMcWYeg9qwAWqa
	87epq3W3S7K01OIxvmR6pUvcIwjXyriaL6QC74mocA2kq+ZQfFBtLeLKD96McNWeZfTICrcBZm+
	meqnQPIz5LaXmBRfLsZzQftkXo32C+CRxVQqilBFnZ0v2ESvKlpBva0CVD+pGCY7QiZsbJL3fQn
	eVDHRS54HhAAT9dCOSde+nO68NG+zXrzOwXRKFAMzhvE0fVpWm4oPjQZI7PzK7ffK2wU58HGyMS
	5xvIvH2rBNfyqLzVJofMsNFTK9L1A==
X-Received: by 2002:a05:600c:19cd:b0:4a1:80d8:aedb with SMTP id 5b1f17b1804b1-4a18e49d9eamr262856825e9.11.1791912943412;
        Tue, 13 Oct 2026 10:35:43 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm284127195e9.4.2026.10.13.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 7/7] power: supply: Add charger driver for Asus Transformers
Date: Tue, 13 Oct 2026 20:35:03 +0300
Message-ID: <20261013173504.451391-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013173504.451391-1-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for charger detection capabilities found in the embedded
controller of ASUS Transformer devices.

Suggested-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Suggested-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 .../supply/asus-transformer-ec-charger.c      | 208 ++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 856eb81c97ae9..16d0a38b41b7e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -508,6 +508,17 @@ config CHARGER_88PM860X
 	help
 	  Say Y here to enable charger for Marvell 88PM860x chip.
 
+config CHARGER_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's charger driver"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here to enable support AC plug detection on Asus Transformer
+	  Dock.
+
+	  This sub-driver supports charger detection mechanism found in Asus
+	  Transformer tablets and mobile docks and controlled by special
+	  embedded controller.
+
 config CHARGER_PF1550
 	tristate "NXP PF1550 battery charger driver"
 	depends on MFD_PF1550
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index bec4a6263048c..cd3640f4b7480 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
 obj-$(CONFIG_CHARGER_RT9756)	+= rt9756.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
+obj-$(CONFIG_CHARGER_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-charger.o
 obj-$(CONFIG_CHARGER_PF1550)	+= pf1550-charger.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
diff --git a/drivers/power/supply/asus-transformer-ec-charger.c b/drivers/power/supply/asus-transformer-ec-charger.c
new file mode 100644
index 0000000000000..c7a6bd2ba533f
--- /dev/null
+++ b/drivers/power/supply/asus-transformer-ec-charger.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/err.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+
+struct asus_ec_charger_data {
+	struct notifier_block nb;
+	struct asusec_core *ec;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+};
+
+static enum power_supply_property asus_ec_charger_properties[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+static int asus_ec_charger_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct asus_ec_charger_data *priv = power_supply_get_drvdata(psy);
+	enum power_supply_usb_type psu;
+	int ret;
+	u64 ctl;
+
+	/* Check if model name is requested first since it needs no hw access */
+	if (psp == POWER_SUPPLY_PROP_MODEL_NAME) {
+		val->strval = priv->ec->model;
+		return 0;
+	}
+
+	ret = asus_dockram_access_ctl(priv->ec->dockram, &ctl, 0, 0);
+	if (ret)
+		return ret;
+
+	switch (ctl & (ASUSEC_CTL_FULL_POWER_SOURCE | ASUSEC_CTL_DIRECT_POWER_SOURCE)) {
+	case ASUSEC_CTL_FULL_POWER_SOURCE:
+		psu = POWER_SUPPLY_USB_TYPE_CDP;	/* DOCK */
+		break;
+	case ASUSEC_CTL_DIRECT_POWER_SOURCE:
+		psu = POWER_SUPPLY_USB_TYPE_SDP;	/* USB */
+		break;
+	case 0:
+		psu = POWER_SUPPLY_USB_TYPE_UNKNOWN;	/* no power source connected */
+		break;
+	default:
+		psu = POWER_SUPPLY_USB_TYPE_ACA;	/* power adapter */
+		break;
+	}
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = psu != POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		return 0;
+
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = psu;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		if (ctl & ASUSEC_CTL_TEST_DISCHARGE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+		else if (ctl & ASUSEC_CTL_USB_CHARGE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int asus_ec_charger_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct asus_ec_charger_data *priv = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		switch ((enum power_supply_charge_behaviour)val->intval) {
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+			return asus_dockram_access_ctl(priv->ec->dockram, NULL,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE,
+				ASUSEC_CTL_USB_CHARGE);
+
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+			return asus_dockram_access_ctl(priv->ec->dockram, NULL,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE, 0);
+
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+			return asus_dockram_access_ctl(priv->ec->dockram, NULL,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE,
+				ASUSEC_CTL_TEST_DISCHARGE);
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int asus_ec_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct power_supply_desc asus_ec_charger_desc = {
+	.name = "asus-ec-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA),
+	.properties = asus_ec_charger_properties,
+	.num_properties = ARRAY_SIZE(asus_ec_charger_properties),
+	.get_property = asus_ec_charger_get_property,
+	.set_property = asus_ec_charger_set_property,
+	.property_is_writeable = asus_ec_charger_property_is_writeable,
+	.no_thermal = true,
+};
+
+static int asus_ec_charger_notify(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct asus_ec_charger_data *priv =
+		container_of(nb, struct asus_ec_charger_data, nb);
+
+	switch (action) {
+	case ASUSEC_SMI_ACTION(POWER_NOTIFY):
+	case ASUSEC_SMI_ACTION(ADAPTER_EVENT):
+		power_supply_changed(priv->psy);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int asus_ec_charger_probe(struct platform_device *pdev)
+{
+	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
+	struct asus_ec_charger_data *priv;
+	struct device *dev = &pdev->dev;
+	struct power_supply_config cfg = { };
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	cfg.fwnode = dev_fwnode(dev->parent);
+	cfg.drv_data = priv;
+
+	memcpy(&priv->psy_desc, &asus_ec_charger_desc, sizeof(priv->psy_desc));
+	priv->psy_desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s-charger",
+					     priv->ec->name);
+	if (!priv->psy_desc.name)
+		return -ENOMEM;
+
+	priv->psy = devm_power_supply_register(dev, &priv->psy_desc, &cfg);
+	if (IS_ERR(priv->psy))
+		return dev_err_probe(dev, PTR_ERR(priv->psy),
+				     "Failed to register power supply\n");
+
+	priv->nb.notifier_call = asus_ec_charger_notify;
+
+	return blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
+}
+
+static void asus_ec_charger_remove(struct platform_device *pdev)
+{
+	struct asus_ec_charger_data *priv = platform_get_drvdata(pdev);
+	struct asusec_core *ec = priv->ec;
+
+	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
+}
+
+static struct platform_driver asus_ec_charger_driver = {
+	.driver.name = "asus-transformer-ec-charger",
+	.probe = asus_ec_charger_probe,
+	.remove = asus_ec_charger_remove,
+};
+module_platform_driver(asus_ec_charger_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-charger");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer Pad battery charger driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

