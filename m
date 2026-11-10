Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329625;
	b=FC094IqXO2HHoQv0d6oYXFj9lBIE3CujNyoc/RGt6UoSc1HgJbIAYkdFV6u3M32eO553
	 9lzGwbbkgM0Cgz/8k+00nm0WGQdFGgb1kIPLynA+bcXY1/zsxJWU2qtoT8LkSMaa/EgAY
	 QvDeTeUMfMNPiOcLs7GI6qckvc2rpDlCeQuazY/CX4aFpgL5zqir/T6txNLxZWa45sdAB
	 9sbn/SKsPd/WKGSiuQoj0bTvg3G8OuD1y+b9VZH+t9B8Vu7/OCr0RasWIyUkEH/Wgpyna
	 f4Sg0CHBXAYA0tSJkseFpr388zQlHUJOskteSuelVMh8XuIuMiObIi9BdpWrQ2ylzfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329625;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=SaGWrPfjgnfhc91g2CLib8vdRx1sIMhhVJ4htpbuQDE=;
	b=cVLyYXO23JG2PlapGv9Ley35oPZKun+VqhWG/adxsKJptx9egHbJMufhesJP+j+EwqEl
	 bG3O0cOiFN7vyU4GiogK8SwWUEOBnud0N9FCGxGQ0+fFTJAMK0+GFF+7ArPE0QNXBLg9G
	 JhE8HsUKl5ILQfyicNEktmSr4JxGoaFJQvSFtqUxRvdegYbecfcTsormNJMrZCleASwAk
	 9BllYnH1m8siboEV5G6Y3CMJAjru2LCwdij9CZFRZgOXnWZQ1imReTjfxsipjpQD+K2JB
	 VnsaL7jN6ajsTb6HA2c9tpK7PBwwjhGTluz1Np+g99xkhVRbqqZLFmvrZ5UUrZVVzMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=NFrGmR3g;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C9606D223;
	Tue, 10 Nov 2026 16:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 079C9606D223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=NFrGmR3g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329607; x=1794934407; i=w_armin@gmx.de;
	bh=SaGWrPfjgnfhc91g2CLib8vdRx1sIMhhVJ4htpbuQDE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NFrGmR3gM6SBadvhheKX0zWlTWrmTOXUUCbkYFQHtWC9GVnB++S7IA4a/tN6kxjT
	 CPHpxGeXFlSqL0yJlntmlAWaxNOIiiklcuOvt21EiAHNlMNNwnE0zPcnoS00iLn31
	 FVNcnBQ4ETUa6OVTKO6uyfr2rbdQKGfMFt/YiQxccMbFH5n88BHxP49WG81CB764d
	 zFVGNbYrproqmAXVzSI3OxXV74xW+0It2zTXUEO+MsUSabhu74brxskmUNNMs8TL4
	 nXWBFsKTLe1rJQlMdSaVdp2POZVpd+lC9kHqSKDFv/PfRyuYSLqj9InIdrxQ6o5bR
	 8t1sZ28YGVxMR9zzAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1wYS890x3u-010aOH; Tue, 10
 Nov 2026 17:53:27 +0100
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
Subject: [PATCH v2 3/9] platform/x86: uniwill-laptop: Report battery cycle count
Date: Tue, 10 Nov 2026 17:50:04 +0100
Message-ID: <20261110165318.631010-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110165318.631010-1-W_Armin@gmx.de>
References: <20261110165318.631010-1-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:2yAou2QAdaLFxk8uhBeohct6jawR5SrNn65NQgnDaK1QvgMmkCm
 XbIsSGNB/0RWWOFiuzhRSDrl1ecgkwaJEBhrjzKGk5Wp6R8DCcO1/nfQBAGEdccVYUM+1zx
 1r51xC6VcA5djrzqeGno/dRtU95aja6RPBG1+iauDdnNBasWLl66+ZB3spp7YnKrlq5ym74
 BkxnCJQ5ny4CKkUr70WJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OpWoN/GKU7I=;fZLWdaT8245clBn5Lfi7fpEwsK0
 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

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

