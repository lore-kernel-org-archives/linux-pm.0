Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749853;
	b=hUDMqazemUKI5nIwjk9gUfCG2qwOkF6qs17N4KFa2umPbOGv2nbne3q8Oe883Y7b3S9+
	 VrhCT8yG2D6X7+eFqMKg0jzpt1WwNaPGIHRjl0iJYfjeK+hrTv9hJPVQy242KBjUfZz/0
	 FufPPetMx1m9otltWrwW6qSTFGXcKyXKGTkS6oG2j5QbbmnhQBs2CHv5WpNQx2lJ4N38A
	 ZaTNz5PuBuwKp67RhbTW3+5S7oRzfY6FBqT+T4PGLHi2XD8WNC8K6ILWBNPnxluRUyO8A
	 wv+wcDhOsrE4QvBmkFpcpjMsBBHYloTvTLN/FJdKRoPp8Rac7tryBKJukUQkuoWY0lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BFJi21nGBQW1GClHu4/H7QoMZnTybBGVTarQRFp+2DE=;
	b=PbTLXcnrP+W8mTFunggTRe8dnaONUN+ao1E5pJbhGA6BrNEMneaPkr7Jk0yW3ffkFK+S
	 jKa9W8Q2xXJ3+msUA5VOQTqxISpCGeosrwxI9Kdx3/2qmQkT5RQTZPXIqAwjAQQTS+dPq
	 Wh3KzLt89a6oYxg2VkQiUOG3t8mQ4aTqmjieJdvXVEXZaTNpdNzU7lzswbiwCVsyBgLTz
	 I2YUhMJ9I3nswc7scMjBkx+u3HkTZMaNXY9zIhgyaQaEPq4PMYWCwGOVHlIZ55pyfRpec
	 TApOjwjaTY4x52LlSoBjrmdHWF/67vwG6gEzTcaVOgaXxRSXO8XMkSTkjCGFHty8ppg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dViWy7Qr;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11760A2627
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D11760A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dViWy7Qr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so6706635e9.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792749851; x=1793354651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFJi21nGBQW1GClHu4/H7QoMZnTybBGVTarQRFp+2DE=;
        b=dViWy7QrutayxL7c/RcPn7bdE/t2t9WvGMlmrHVD3Itn2TjiwT7dCu73oYCD1cr+Az
         NSZGx0xOB5EzC6acLMGIZBL1LNvUmzHYZB369f/rNmCegdG5TcrCFS+HkFhL6ByvfgX+
         xuKNeOR6z7szbZFci2VBdIGHjn+aVPs354/sntcvJl+Y0Hb2DeDggb4RvBuzxhqOdqYh
         gb/Ms/WqIhJ6nOSub03QAzu0GtRl4mDvWMu3eiZe25kJgYT+efOn3moS3mqYlI22jDx+
         pmAnvFHYLCAcTkLjKBovVYEaOGsHTeGTN6W3oGHDw4wPI/TO8XrN5GnAY/fCAVK85F2j
         PMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749851; x=1793354651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFJi21nGBQW1GClHu4/H7QoMZnTybBGVTarQRFp+2DE=;
        b=NG4Juo1TlsJadmBxEJuYJ5e3XcoUfgppi01JXlH0J9yj19oW51J59p7eQddS48kWsg
         +HTSxjY9DzPdMA1p1durMcXam3ztjJOUu9dHXy9bw5dh7ev7qw+75tfum+HDjls3jgvd
         M2nN+ooSlkTlSYzsdRqfk6DjHw59WzP3HG7CPIz7knOiBlf8uGJC8wdlpTc5CZtkNeDf
         M65ryLCP1yFcKztedYmnYLXYwpzo8DKvlNsIgzVFYjbaxuQhnhbBqbkrcI0LvSuOt4gG
         5kQwnAUR9j8BQgzdiutCDkvM2uzN+DdM3HN9Nl2P6vp3zUEMI1pm+64lU2oe0VnKw0Dq
         1eWA==
X-Forwarded-Encrypted: i=1; AKwUvBzB6XobiUB9fuZ8DBzAynLz/EE1u4CQrrUsm0YC/3VOiVfw4rdVD5frs7aq2pelW/1U06hpU4JM3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgaMMGDKIJLr07yzyMzbu3HAeCFc8gAOAEMLqrN8r7yoGI5Hk4
	sahkw3hFQJ3uqkaEAMOEWF5scvTaiI7Ed2KHV57N1+BwqFyEnKU009UeRg5Z8MNx43RkvOzqb56
	aTF/40T4=
X-Gm-Gg: AYBFou2tX3ypWse0d7bfhB0RcCsLqOpR02XFALG6Rt9j9zOkuIXhUwFAAgqiG3Bz85T
	d1zGz2IRTeY+7oQW/qHr81+Uk383DopHv/z2HJ+3QK37cMa1BdKhKsbA9qlIRWmjKm/ROzmoGXH
	KsrH5dW/fCmSqpNOXdApX0JIUX8qW5lKXq2G3jAJXuPDbflCce8yQ5vEZ7KRVsTDCjSjfzb5Y6G
	zMiSRSu9lEy0Z2LtQtwCwQQGiUHpifuOqgni2zYnjzkV5Spz9LBfOdtUsOwalbLU9d74t9Tt+zB
	ouAZqE52XqxQVuhppoUbVZC5MqLq7bG+ulUjSX4tmfULCpmyt4ikL1AlzK9+lFB9GViLk1Yxu3g
	y8ite7vkOFHcbpEQpSgbAWWJTpZF3qrRoyh5YgX3XnQz+jlMhbCEEGL2UELeoRkSIZLCVvAVsQN
	RAgGYnLFaFVhQR37o9aJuixIiMXxJDOTtbl0Vm8HmD8LL2bBDj+hKKwcgjKBa7OJo1CQwfCWK2F
	MIcwFQFyKWPZGahLvRhmm0r7q8iFx/tf6H1Sv8GFUnJTusE4/UCUg8N+9wWZgypx/SyKpa2bc99
	1QF7kBLrsUFy
X-Received: by 2002:a05:600c:3b0a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a211c869d9mr27147775e9.16.1792749849627;
        Fri, 23 Oct 2026 03:04:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm75761435e9.8.2026.10.23.03.04.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 03:04:09 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] power: supply: axp20x_battery: Add support for the AXP2101
Date: Fri, 23 Oct 2026 12:04:01 +0200
Message-ID: <20261023100401.67592-8-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023100401.67592-1-olivier@mgcrea.io>
References: <20261023100401.67592-1-olivier@mgcrea.io>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Program the AXP2101's charger from the monitored battery: the end of
charge voltage (CV_CHG_SET, 4.0 to 4.4 V), the constant charge current
(ICC_CHG_SET, 25 mA steps to 200 mA then 100 mA steps to 1 A), and the
termination and precharge currents (25 mA steps). Report whether the
battery is present, the charge state (precharge, constant current or
constant voltage charging, done, or by the current direction) and the
settings.

The supply is read-only and reports no capacity: the AXP2101's own fuel
gauge needs a battery model, and the HiBy R1 uses a CW2015 for that.

Tested on a HiBy R1: the charger registers read back as the stock
firmware's values after boot, and the status is Full on USB,
Discharging unplugged and Charging after a replug.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 drivers/power/supply/axp20x_battery.c | 221 ++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index ee8701a6e907..a653ad923144 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -91,6 +91,26 @@
 
 #define AXP717_TS_PIN_DISABLE		BIT(4)
 
+#define AXP2101_PWR_OP_BATT_PRESENT	BIT(3)
+#define AXP2101_PWR_STATUS_MASK		GENMASK(6, 5)
+#define AXP2101_PWR_STATUS_BAT_STANDBY	0
+#define AXP2101_PWR_STATUS_BAT_CHRG	1
+#define AXP2101_PWR_STATUS_BAT_DISCHRG	2
+#define AXP2101_CHRG_STATE_MASK		GENMASK(2, 0)
+#define AXP2101_CHRG_STATE_TRICKLE	0
+#define AXP2101_CHRG_STATE_PRECHARGE	1
+#define AXP2101_CHRG_STATE_CC		2
+#define AXP2101_CHRG_STATE_CV		3
+#define AXP2101_CHRG_STATE_DONE		4
+/* CV_CHG_SET: end of charge voltage selector, 1 to 5 for 4.0 to 4.4 V. */
+#define AXP2101_CHRG_CV_VOLT_MASK	GENMASK(2, 0)
+#define AXP2101_ICC_MASK		GENMASK(4, 0)
+#define AXP2101_ICC_MAX_SEL		16	/* 1 A; 17 to 31 are reserved */
+#define AXP2101_ITERM_MASK		GENMASK(3, 0)
+#define AXP2101_ITERM_ENABLE		BIT(4)
+#define AXP2101_IPRECHG_MASK		GENMASK(3, 0)
+#define AXP2101_CURRENT_STEP		25000
+
 struct axp20x_batt_ps;
 
 struct axp_data {
@@ -213,6 +233,44 @@ static int axp717_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 	}
 }
 
+/* End of charge voltages of CV_CHG_SET selectors 0 to 7; 0, 6 and 7 are reserved. */
+static const int axp2101_cv_uv[] = {
+	0, 4000000, 4100000, 4200000, 4350000, 4400000, 0, 0,
+};
+
+static int axp2101_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					   int *val)
+{
+	int ret, reg;
+
+	ret = regmap_read(axp20x_batt->regmap, AXP2101_CV_CHG_SET, &reg);
+	if (ret)
+		return ret;
+
+	*val = axp2101_cv_uv[reg & AXP2101_CHRG_CV_VOLT_MASK];
+	return *val ? 0 : -EINVAL;
+}
+
+static int axp2101_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					   int val)
+{
+	int sel;
+
+	for (sel = 0; sel < ARRAY_SIZE(axp2101_cv_uv); sel++)
+		if (axp2101_cv_uv[sel] && axp2101_cv_uv[sel] == val)
+			return regmap_update_bits(axp20x_batt->regmap,
+						  AXP2101_CV_CHG_SET,
+						  AXP2101_CHRG_CV_VOLT_MASK, sel);
+
+	return -EINVAL;
+}
+
+/* CONSTANT_CHARGE_CURRENT: 25 mA steps up to 200 mA, then 100 mA steps. */
+static int axp2101_ccc_from_sel(unsigned int sel)
+{
+	return sel <= 8 ? sel * 25000 : 200000 + (sel - 8) * 100000;
+}
+
 static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int *val)
 {
@@ -425,6 +483,89 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 	return 0;
 }
 
+static int axp2101_battery_get_prop(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int ret, reg;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = regmap_read(axp20x_batt->regmap, AXP2101_PMU_STATUS_1,
+				  &reg);
+		if (ret)
+			return ret;
+
+		val->intval = !!(reg & AXP2101_PWR_OP_BATT_PRESENT);
+		return 0;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = regmap_read(axp20x_batt->regmap, AXP2101_PMU_STATUS_2,
+				  &reg);
+		if (ret)
+			return ret;
+
+		switch (FIELD_GET(AXP2101_CHRG_STATE_MASK, reg)) {
+		case AXP2101_CHRG_STATE_PRECHARGE:
+		case AXP2101_CHRG_STATE_CC:
+		case AXP2101_CHRG_STATE_CV:
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			return 0;
+		case AXP2101_CHRG_STATE_DONE:
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+			return 0;
+		}
+
+		/* Trickle charging or not charging: by the current direction. */
+		switch (FIELD_GET(AXP2101_PWR_STATUS_MASK, reg)) {
+		case AXP2101_PWR_STATUS_BAT_STANDBY:
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			return 0;
+		case AXP2101_PWR_STATUS_BAT_CHRG:
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			return 0;
+		case AXP2101_PWR_STATUS_BAT_DISCHRG:
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			return 0;
+		default:
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			return 0;
+		}
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		ret = regmap_read(axp20x_batt->regmap, AXP2101_ICC_CHG_SET,
+				  &reg);
+		if (ret)
+			return ret;
+
+		val->intval = axp2101_ccc_from_sel(FIELD_GET(AXP2101_ICC_MASK,
+							     reg));
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return axp2101_battery_get_max_voltage(axp20x_batt,
+						       &val->intval);
+
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = regmap_read(axp20x_batt->regmap, AXP2101_ITERM_CHG_SET,
+				  &reg);
+		if (ret)
+			return ret;
+
+		if (!(reg & AXP2101_ITERM_ENABLE))
+			val->intval = 0;
+		else
+			val->intval = FIELD_GET(AXP2101_ITERM_MASK, reg) *
+				      AXP2101_CURRENT_STEP;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp717_battery_get_prop(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
@@ -852,6 +993,15 @@ static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 };
 
+static enum power_supply_property axp2101_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
 static enum power_supply_property axp717_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -895,6 +1045,15 @@ static const struct power_supply_desc axp209_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+/* Read-only: the charge settings come from the monitored battery. */
+static const struct power_supply_desc axp2101_batt_ps_desc = {
+	.name = "axp20x-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = axp2101_battery_props,
+	.num_properties = ARRAY_SIZE(axp2101_battery_props),
+	.get_property = axp2101_battery_get_prop,
+};
+
 static const struct power_supply_desc axp717_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
@@ -978,6 +1137,57 @@ static void axp209_set_battery_info(struct platform_device *pdev,
 	}
 }
 
+static int axp2101_bat_cfg_iio_channels(struct platform_device *pdev,
+					struct axp20x_batt_ps *axp_batt)
+{
+	return 0;
+}
+
+/*
+ * Programs the charger from the monitored battery: end of charge voltage,
+ * constant charge current, termination and precharge currents. What the
+ * battery doesn't give is left as it is.
+ */
+static void axp2101_set_battery_info(struct platform_device *pdev,
+				     struct axp20x_batt_ps *axp_batt,
+				     struct power_supply_battery_info *info)
+{
+	int cv = info->constant_charge_voltage_max_uv;
+	int ccc = info->constant_charge_current_max_ua;
+	int iterm = info->charge_term_current_ua;
+	int iprechg = info->precharge_current_ua;
+	unsigned int sel;
+
+	if (cv > 0 && axp2101_battery_set_max_voltage(axp_batt, cv))
+		dev_err(&pdev->dev, "unsupported charge voltage %d uV\n", cv);
+
+	if (ccc > 0) {
+		if (ccc <= 200000)
+			sel = ccc / AXP2101_CURRENT_STEP;
+		else
+			sel = min((ccc - 200000) / 100000 + 8,
+				  AXP2101_ICC_MAX_SEL);
+		axp_batt->max_ccc = axp2101_ccc_from_sel(sel);
+		regmap_update_bits(axp_batt->regmap, AXP2101_ICC_CHG_SET,
+				   AXP2101_ICC_MASK, sel);
+	}
+
+	if (iterm > 0) {
+		sel = min(iterm / AXP2101_CURRENT_STEP,
+			  (int)FIELD_MAX(AXP2101_ITERM_MASK));
+		regmap_update_bits(axp_batt->regmap, AXP2101_ITERM_CHG_SET,
+				   AXP2101_ITERM_MASK | AXP2101_ITERM_ENABLE,
+				   sel | AXP2101_ITERM_ENABLE);
+	}
+
+	if (iprechg > 0) {
+		sel = min(iprechg / AXP2101_CURRENT_STEP,
+			  (int)FIELD_MAX(AXP2101_IPRECHG_MASK));
+		regmap_update_bits(axp_batt->regmap, AXP2101_IPRECHG_SET,
+				   AXP2101_IPRECHG_MASK, sel);
+	}
+}
+
 static void axp717_set_battery_info(struct platform_device *pdev,
 				    struct axp20x_batt_ps *axp_batt,
 				    struct power_supply_battery_info *info)
@@ -1047,6 +1257,14 @@ static const struct axp_data axp221_data = {
 	.set_bat_info = axp209_set_battery_info,
 };
 
+static const struct axp_data axp2101_data = {
+	.bat_ps_desc = &axp2101_batt_ps_desc,
+	.get_max_voltage = axp2101_battery_get_max_voltage,
+	.set_max_voltage = axp2101_battery_set_max_voltage,
+	.cfg_iio_chan = axp2101_bat_cfg_iio_channels,
+	.set_bat_info = axp2101_set_battery_info,
+};
+
 static const struct axp_data axp717_data = {
 	.ccc_scale = 64000,
 	.ccc_offset = 0,
@@ -1082,6 +1300,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp717-battery-power-supply",
 		.data = (void *)&axp717_data,
+	}, {
+		.compatible = "x-powers,axp2101-battery-power-supply",
+		.data = (void *)&axp2101_data,
 	}, {
 		.compatible = "x-powers,axp813-battery-power-supply",
 		.data = (void *)&axp813_data,
-- 
2.39.5

