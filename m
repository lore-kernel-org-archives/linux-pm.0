Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269996;
	b=yJ6wVG/0lAQieQ9zLtnttAjMjpKmsURYcFxMyINiNCF81wcnccd/YH8Z9h8ZarHO9KDE
	 DL13wbsfzCsVTUWPmXNhLIq9NRWVL8116uulKZsA7g+bHbHrSqt/IzcAJmHgHuKVx95z0
	 QtLvgiquIpq8U64pPsAF1V1hcPLk+L51enHMRQ1uMh9AihQqvKc5HFuYxpplwSgWYc788
	 be+Rca/luZRd4YL4VaI9CoyJpAou/5lW/CUYIXZdRLlg3yeK3vUJMOmz9xTrnQuLbH8q2
	 1u/wep6lwrviTUn+WDfG7WvsKd5m6oatkBG3Q2smcliCvEWqHqG4rB+F9F9hwx9okBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269996;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=SaGWrPfjgnfhc91g2CLib8vdRx1sIMhhVJ4htpbuQDE=;
	b=tHjnZVaDxG7lNCqa8yMF4YJD/M8OApqKbtfSRMOhXKKJZf0DpgT7Zfc8vCk/W5e0ejKY
	 RYv5yYh5EB9UFLmD2UbnKDnYmM9PBuKyuE8eSa/m5LDzG+dNKsWzjg54lfJOVT6nBsp8Y
	 RS6ZapwW6KyHWOK/wsGML9HuC8aDwXl950Fm2QWP0bb9e+8HZy5Qkse0EDFnxUZJ+SDJU
	 DuBV9UncgGvTBVCzYuOvRZZ5xfT5+f9arz+LQxDe/3XdFJJwIWRU12/UF46WqDDYJTklI
	 DxWAEZdZncWnP2IuoB7/2lyqCKvV2XBxMFNDgjG+k9c0mDvhRNnAor4gZ8bSwy2LCkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MTi9PTta;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D760A2602;
	Tue, 10 Nov 2026 00:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F9D760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MTi9PTta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269985; x=1794874785; i=w_armin@gmx.de;
	bh=SaGWrPfjgnfhc91g2CLib8vdRx1sIMhhVJ4htpbuQDE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MTi9PTtagITF5NkqzqqNLDdpHH2w0E0ghPq4yWBGBjy7Hwl5BcX8Uk/OaXPN08GQ
	 jsgGgUuXjcK2ts6/9LYw1T+oeyIG/UTEOvXtjp/3VrabU1RPuCm85JelUe/RwKETN
	 t8NHboU31DqogQDO4lYET1s+WsZGKJ4aQtUBy7s5GgHfz5lUJ+e1P4fxgOCDGUHhM
	 Gh53IgYYnWDHp+kg23EPZGMiZQdyWze+FXTuol73Uf48aRed9mkMhCEIeqi3F/ton
	 N4O2HCpfqDahUwWfZlvp5iJY5hYyrrBpHa3ghB1fKKXkB0uy0itWTsWVwySk4LvdB
	 6UJmHaStMKF3V++jVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1xDuP12Kf8-002Rz1; Tue, 10
 Nov 2026 01:19:45 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bifangknt@qq.com,
	nicokessler@icloud.com,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH 3/9] platform/x86: uniwill-laptop: Report battery cycle count
Date: Tue, 10 Nov 2026 01:06:45 +0100
Message-ID: <20261110001725.851443-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110001725.851443-1-W_Armin@gmx.de>
References: <20261110001725.851443-1-W_Armin@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SHWJxbSuV8hjX3qLOl8CwZgcVxP8nBuWlYUIXyyYW6gqjywP7RD
 /0QnEDJwVdi09C8rHVtJuqKFV+YydHZH8M2QBniVzCGzWAMyVx0rCtIM7tXg17S6/ivxzxB
 1laSu3Y/3C3JAJ6k2IFurtEH3hQ62i5YbhH2f0PRqVKJN4alAivA2d2i+L5GnN5BVs6e36Q
 c9Rgbfd5EkzqIWLdxWbfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h0gU0xiixQA=;4TeU72Fe1YoW+R1n7k0h35T0liv
 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
 Ovkthjct2ew5zVUn04MBlFfr11Cg==

It turns out that nearly all Uniwill-based devices do not support
the _BIX ACPI control method for ACPI battery devices, instead only
providing the legacy _BIF ACPI control method. This prevents them
from reporting the cycle count of the battery, even when the EC
reports this value.

Fix this by supplying the battery cycle count using the power supply
extension on devices where the ACPI battery does not.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 94 ++++++++++++---------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index 060324ed3c4d..1958a1bfc880 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -392,6 +392,9 @@ struct uniwill_data {
 		};
 		unsigned int last_charge_ctrl;
 	};
+	enum power_supply_property extension_props[3];
+	struct power_supply_ext standard_extension;
+	struct power_supply_ext cycle_count_extension;
 	bool last_fn_lock_state;
 	bool last_super_key_enable_state;
 	bool last_touchpad_toggle_enable_state;
@@ -639,6 +642,8 @@ static bool uniwill_readable_reg(struct device *dev, u=
nsigned int reg)
 	case EC_ADDR_SECOND_FAN_RPM_1:
 	case EC_ADDR_SECOND_FAN_RPM_2:
 	case EC_ADDR_BAT_ALERT:
+	case EC_ADDR_BAT_CYCLE_COUNT_1:
+	case EC_ADDR_BAT_CYCLE_COUNT_2:
 	case EC_ADDR_OEM_9:
 	case EC_ADDR_PROJECT_ID:
 	case EC_ADDR_AP_OEM:
@@ -686,6 +691,8 @@ static bool uniwill_volatile_reg(struct device *dev, u=
nsigned int reg)
 	case EC_ADDR_SECOND_FAN_RPM_1:
 	case EC_ADDR_SECOND_FAN_RPM_2:
 	case EC_ADDR_BAT_ALERT:
+	case EC_ADDR_BAT_CYCLE_COUNT_1:
+	case EC_ADDR_BAT_CYCLE_COUNT_2:
 	case EC_ADDR_BIOS_OEM:
 	case EC_ADDR_PWM_1:
 	case EC_ADDR_PWM_2:
@@ -1966,6 +1973,7 @@ static int uniwill_get_property(struct power_supply =
*psy, const struct power_sup
 	struct uniwill_data *data =3D drvdata;
 	union power_supply_propval prop;
 	unsigned int regval;
+	__le16 cycle_count;
 	int ret;
=20
 	switch (psp) {
@@ -2010,6 +2018,14 @@ static int uniwill_get_property(struct power_supply=
 *psy, const struct power_sup
=20
 		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
 		return 0;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		ret =3D regmap_bulk_read(data->regmap, EC_ADDR_BAT_CYCLE_COUNT_1, &cycl=
e_count,
+				       sizeof(cycle_count));
+		if (ret < 0)
+			return ret;
+
+		val->intval =3D le16_to_cpu(cycle_count);
+		return 0;
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
 		ret =3D regmap_read(data->regmap, EC_ADDR_CHARGE_CTRL, &regval);
 		if (ret < 0)
@@ -2093,54 +2109,23 @@ static int uniwill_property_is_writeable(struct po=
wer_supply *psy,
 	}
 }
=20
-static const enum power_supply_property uniwill_charge_limit_properties[]=
 =3D {
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
-};
-
-static const struct power_supply_ext uniwill_charge_limit_extension =3D {
-	.name =3D DRIVER_NAME,
-	.properties =3D uniwill_charge_limit_properties,
-	.num_properties =3D ARRAY_SIZE(uniwill_charge_limit_properties),
-	.get_property =3D uniwill_get_property,
-	.set_property =3D uniwill_set_property,
-	.property_is_writeable =3D uniwill_property_is_writeable,
-};
-
-static const enum power_supply_property uniwill_charge_modes_properties[]=
 =3D {
-	POWER_SUPPLY_PROP_CHARGE_TYPES,
-	POWER_SUPPLY_PROP_HEALTH,
-};
-
-static const struct power_supply_ext uniwill_charge_modes_extension =3D {
-	.name =3D DRIVER_NAME,
-	.charge_types =3D BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
-			BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
-			BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE),
-	.properties =3D uniwill_charge_modes_properties,
-	.num_properties =3D ARRAY_SIZE(uniwill_charge_modes_properties),
-	.get_property =3D uniwill_get_property,
-	.set_property =3D uniwill_set_property,
-	.property_is_writeable =3D uniwill_property_is_writeable,
-};
-
 static int uniwill_add_battery(struct power_supply *battery, struct acpi_=
battery_hook *hook)
 {
 	struct uniwill_data *data =3D container_of(hook, struct uniwill_data, ho=
ok);
 	struct uniwill_battery_entry *entry;
+	const struct power_supply_ext *ext;
 	int ret;
=20
 	entry =3D kzalloc_obj(*entry);
 	if (!entry)
 		return -ENOMEM;
=20
-	if (uniwill_device_supports(data, UNIWILL_FEATURE_BATTERY_CHARGE_LIMIT))
-		ret =3D power_supply_register_extension(battery, &uniwill_charge_limit_=
extension,
-						      data->dev, data);
+	if (power_supply_has_property_direct(battery, POWER_SUPPLY_PROP_CYCLE_CO=
UNT))
+		ext =3D &data->standard_extension;
 	else
-		ret =3D power_supply_register_extension(battery, &uniwill_charge_modes_=
extension,
-						      data->dev, data);
+		ext =3D &data->cycle_count_extension;
=20
+	ret =3D power_supply_register_extension(battery, ext, data->dev, data);
 	if (ret < 0) {
 		kfree(entry);
 		return ret;
@@ -2158,6 +2143,7 @@ static int uniwill_remove_battery(struct power_suppl=
y *battery, struct acpi_batt
 {
 	struct uniwill_data *data =3D container_of(hook, struct uniwill_data, ho=
ok);
 	struct uniwill_battery_entry *entry, *tmp;
+	const struct power_supply_ext *ext;
=20
 	scoped_guard(mutex, &data->battery_lock) {
 		list_for_each_entry_safe(entry, tmp, &data->batteries, head) {
@@ -2169,10 +2155,12 @@ static int uniwill_remove_battery(struct power_sup=
ply *battery, struct acpi_batt
 		}
 	}
=20
-	if (uniwill_device_supports(data, UNIWILL_FEATURE_BATTERY_CHARGE_LIMIT))
-		power_supply_unregister_extension(battery, &uniwill_charge_limit_extens=
ion);
+	if (power_supply_has_property_direct(battery, POWER_SUPPLY_PROP_CYCLE_CO=
UNT))
+		ext =3D &data->standard_extension;
 	else
-		power_supply_unregister_extension(battery, &uniwill_charge_modes_extens=
ion);
+		ext =3D &data->cycle_count_extension;
+
+	power_supply_unregister_extension(battery, ext);
=20
 	return 0;
 }
@@ -2180,6 +2168,9 @@ static int uniwill_remove_battery(struct power_suppl=
y *battery, struct acpi_batt
 static int uniwill_battery_init(struct uniwill_data *data)
 {
 	unsigned int value, threshold, sanitized;
+	u32 charge_types =3D BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
+			   BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
+			   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE);
 	int ret;
=20
 	if (uniwill_device_supports(data, UNIWILL_FEATURE_BATTERY_CHARGE_LIMIT))=
 {
@@ -2203,6 +2194,8 @@ static int uniwill_battery_init(struct uniwill_data =
*data)
 			if (ret < 0)
 				return ret;
 		}
+
+		data->extension_props[0] =3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRES=
HOLD;
 	} else if (uniwill_device_supports(data, UNIWILL_FEATURE_BATTERY_CHARGE_=
MODES)) {
 		ret =3D devm_mutex_init(data->dev, &data->charge_type_lock);
 		if (ret < 0)
@@ -2211,10 +2204,33 @@ static int uniwill_battery_init(struct uniwill_dat=
a *data)
 		ret =3D uniwill_read_charge_type(data, &data->last_charge_type);
 		if (ret < 0)
 			return ret;
+
+		data->extension_props[0] =3D POWER_SUPPLY_PROP_CHARGE_TYPES;
+		data->standard_extension.charge_types =3D charge_types;
+		data->cycle_count_extension.charge_types =3D charge_types;
 	} else {
 		return 0;
 	}
=20
+	data->extension_props[1] =3D POWER_SUPPLY_PROP_HEALTH;
+	/* Needs to come last */
+	data->extension_props[2] =3D POWER_SUPPLY_PROP_CYCLE_COUNT;
+
+	data->standard_extension.name =3D DRIVER_NAME;
+	data->standard_extension.properties =3D data->extension_props;
+	/* POWER_SUPPLY_PROP_CYCLE_COUNT is usually already provided by the ACPI=
 battery */
+	data->standard_extension.num_properties =3D ARRAY_SIZE(data->extension_p=
rops) - 1;
+	data->standard_extension.get_property =3D uniwill_get_property;
+	data->standard_extension.set_property =3D uniwill_set_property;
+	data->standard_extension.property_is_writeable =3D uniwill_property_is_w=
riteable;
+
+	data->cycle_count_extension.name =3D DRIVER_NAME;
+	data->cycle_count_extension.properties =3D data->extension_props;
+	data->cycle_count_extension.num_properties =3D ARRAY_SIZE(data->extensio=
n_props);
+	data->cycle_count_extension.get_property =3D uniwill_get_property;
+	data->cycle_count_extension.set_property =3D uniwill_set_property;
+	data->cycle_count_extension.property_is_writeable =3D uniwill_property_i=
s_writeable;
+
 	ret =3D devm_mutex_init(data->dev, &data->battery_lock);
 	if (ret < 0)
 		return ret;
=2D-=20
2.56.0

