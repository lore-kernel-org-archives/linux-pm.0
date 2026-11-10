Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270005;
	b=5Bz81AL8yEZx7fGzIdKQxt2L1fuoW3NW60sWPJ8aZqmtOadRNPPdWtaaF6SwnWwGVNbW
	 TBh5SA7a+wmgOLYZo1JutM6H9RZFLtioSlY23gSiLnKF7jndIfBbt9SljzjKRpAsHfoKz
	 pjR6NiiJp6VlIq5gpi31udENEkAMo4UQfDRkXtd9YQgz8WO9b/lRfqN2iu0OWerHacW15
	 TwMTdhBAEioePm9IPQ/ntm+7OWT260C1wgK+ItFnSFrSWPKI3e4wKOSwQwawNAkrWJuvt
	 ljUjLgyzdsD/9VVY6ZjwuVz/0wQ0gaN11oljRpw/e9pMmI8T0qvRy1qgwkxxLzAQT1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270005;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=JWWehr1RyZSarNuffT99UJfWVpenTyinVDZu2G/e0lE=;
	b=mNmgtEFGkM2hBTlJUFduykpR+TwmcRKmsHJynIhpZDqj2ibA9pGF+V54liQYBbqgdyfF
	 qf/ur7Yg1ePoqlNW2pDW3IaTo1tKy6j2m74uvQ8alLY76XtKNyJBsCTVoIJbpvw/UvvsU
	 O20zoYjJ4iUcjYQ8XdEKL+hjXrY48IMh4hWNeHbUIV4euRiCEM+UxLBNM9XTqPwCV4whe
	 OXV1kE10bym6h7KatuJuBHNaz49DZEq/aOu58dY6f/omqAGinFOUudiIAJppjjFIH1Fg9
	 xNVvobymTlgA0urPRMII42pGDTsVKUSfT2NWZU5dC2Hb2wvYEgG09JHqQrTauQCHyVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ZvDUjmVh;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1F606A330;
	Tue, 10 Nov 2026 00:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01E1F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ZvDUjmVh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269987; x=1794874787; i=w_armin@gmx.de;
	bh=JWWehr1RyZSarNuffT99UJfWVpenTyinVDZu2G/e0lE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZvDUjmVhMC7YSdmqDI/btrdXaG57QFQ6AmUh4ErsqGOvb666vdyMQhG4/MtQm20Q
	 KB2/Q8R3ZYha+XgGxJKhCoTs+Mo7Xtv+plSvRkHbss3uutHsdBrrj3VOgmywt32Z+
	 IaMML8SjZG1eT1I5mpDZfoqCQVAUv8cCRrbY/nnGzhrs/NwZ8S2YEylqFsOD/HSsK
	 lb04jw7Mrxf/7oclmpqJhwnVfRpphupp21Q/+mjKAjfnM0PpJeiGzO6ndjT2SovcX
	 IRdXubzdgglREvmmj+sUI7EJXUKiJSVIdgYBkkMfoMdaAVd/QtJOWtsXzZP2fL5PT
	 Uq4znQFxZsekfTZwqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1x0LUQ0emX-00QK1e; Tue, 10
 Nov 2026 01:19:47 +0100
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
Subject: [PATCH 4/9] platform/x86: uniwill-laptop: Expose battery health and cycle count on all devices
Date: Tue, 10 Nov 2026 01:06:46 +0100
Message-ID: <20261110001725.851443-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:WK1+ZK8jBaqxYPP/rZr3Dq600WvxylwkutO9Sm1mMQlHHBtGWE4
 brDRSXj5IJbWt7mVeOuNvWZqR1HvoNB5aHN3iFnCKdQT2RpgiKdm8yvDkxoyHLYxCQVLp5o
 BYAJjwAqX4RXp1YKtHfbKteXFv32lOPiX0dSEaWK+jYQTQAdOyDUZ/gQoNPsxazfNlYLX3e
 M9e6POVN/QNKlyStyiuPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rGXIwTuaQV8=;/kcLA6Q6r9pbHsa3yCbPaPRE5UG
 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
 SjGUYSw8nStorlF7cLw==

We can assume that all passive battery properties (health and cycle
count) are available on all devices if the underlying EC interface
is supported. Rework the battery extension initialization code to
always register a power supply extension with at least those two
properties.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index 1958a1bfc880..66770f939c83 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -2171,6 +2171,7 @@ static int uniwill_battery_init(struct uniwill_data =
*data)
 	u32 charge_types =3D BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
 			   BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
 			   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE);
+	int i =3D 0;
 	int ret;
=20
 	if (uniwill_device_supports(data, UNIWILL_FEATURE_BATTERY_CHARGE_LIMIT))=
 {
@@ -2195,7 +2196,7 @@ static int uniwill_battery_init(struct uniwill_data =
*data)
 				return ret;
 		}
=20
-		data->extension_props[0] =3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRES=
HOLD;
+		data->extension_props[i++] =3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THR=
ESHOLD;
 	} else if (uniwill_device_supports(data, UNIWILL_FEATURE_BATTERY_CHARGE_=
MODES)) {
 		ret =3D devm_mutex_init(data->dev, &data->charge_type_lock);
 		if (ret < 0)
@@ -2205,28 +2206,26 @@ static int uniwill_battery_init(struct uniwill_dat=
a *data)
 		if (ret < 0)
 			return ret;
=20
-		data->extension_props[0] =3D POWER_SUPPLY_PROP_CHARGE_TYPES;
+		data->extension_props[i++] =3D POWER_SUPPLY_PROP_CHARGE_TYPES;
 		data->standard_extension.charge_types =3D charge_types;
 		data->cycle_count_extension.charge_types =3D charge_types;
-	} else {
-		return 0;
 	}
=20
-	data->extension_props[1] =3D POWER_SUPPLY_PROP_HEALTH;
+	data->extension_props[i++] =3D POWER_SUPPLY_PROP_HEALTH;
 	/* Needs to come last */
-	data->extension_props[2] =3D POWER_SUPPLY_PROP_CYCLE_COUNT;
+	data->extension_props[i++] =3D POWER_SUPPLY_PROP_CYCLE_COUNT;
=20
 	data->standard_extension.name =3D DRIVER_NAME;
 	data->standard_extension.properties =3D data->extension_props;
 	/* POWER_SUPPLY_PROP_CYCLE_COUNT is usually already provided by the ACPI=
 battery */
-	data->standard_extension.num_properties =3D ARRAY_SIZE(data->extension_p=
rops) - 1;
+	data->standard_extension.num_properties =3D i - 1;
 	data->standard_extension.get_property =3D uniwill_get_property;
 	data->standard_extension.set_property =3D uniwill_set_property;
 	data->standard_extension.property_is_writeable =3D uniwill_property_is_w=
riteable;
=20
 	data->cycle_count_extension.name =3D DRIVER_NAME;
 	data->cycle_count_extension.properties =3D data->extension_props;
-	data->cycle_count_extension.num_properties =3D ARRAY_SIZE(data->extensio=
n_props);
+	data->cycle_count_extension.num_properties =3D i;
 	data->cycle_count_extension.get_property =3D uniwill_get_property;
 	data->cycle_count_extension.set_property =3D uniwill_set_property;
 	data->cycle_count_extension.property_is_writeable =3D uniwill_property_i=
s_writeable;
@@ -2251,11 +2250,6 @@ static int uniwill_notifier_call(struct notifier_bl=
ock *nb, unsigned long action
=20
 	switch (action) {
 	case UNIWILL_OSD_BATTERY_ALERT:
-		if (!uniwill_device_supports_any(data,
-						 UNIWILL_FEATURE_BATTERY_CHARGE_LIMIT |
-						 UNIWILL_FEATURE_BATTERY_CHARGE_MODES))
-			return NOTIFY_DONE;
-
 		mutex_lock(&data->battery_lock);
 		list_for_each_entry(entry, &data->batteries, head) {
 			power_supply_changed(entry->battery);
=2D-=20
2.56.0

