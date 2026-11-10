Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329614;
	b=KPBOxbSvU+sd7tUxsH2irqsMMaOck4kc20w783dN+OuaxkwBpsYa536Ek61/72mVyaJZ
	 WeJCCJKSylfAa5EkthUb85lPbPAvwEhphSZxbrGs9dlI3ELX0iPo7SZNKAT+sT6Jcj6Gy
	 G7UXX4As6VXfGe0kY704WAJ8nOUhCcqtF8hPppzDt+IcovjYmeJOKoYxM6aMvidHtjSwj
	 w80gn/qVh0XKiwCqpF6+/hZCZwjckz4w85r/vD4ttBh6/4o3cJbU1YXw+8R+yEQsL3T9B
	 7O0nppgjXSp/CtsEcUx5jaZ5KZEycav5JgNVeJxFf08UOlomX6+YSFshgLksPkt+wZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329614;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=JWWehr1RyZSarNuffT99UJfWVpenTyinVDZu2G/e0lE=;
	b=G9halb94+AnHHFQs6a1O1boqXt5WecPHGJSdw38Mkl7FNBX8lu606LsfNQRrO3xxiE8f
	 mHbjj+fhpizid6gSmbVUs1swKv/blLGTBCpoDTmWkL8nYEG68KazVBOUE8eXuVaF9nW+D
	 QFvqRTrVh0axF/M1YImdILwwqlGtW/s0JKOV0fIG8OH8T06Y3hR3WppPA758k6LiJH3vo
	 zGsd2v6Y8cdY09LxJvec/zF3z+x0FsN4qSFv6RhQ223pv4sYQWasYaS6WZij4EZWGdDp7
	 fVeaXjIPvq+pi/3G8G8PalZBxdotagKjhqeL+SWrgnl6cCRVF9pSylrcpVhk4BxFEfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gnR9iN2H;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F560A3817;
	Tue, 10 Nov 2026 16:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791F560A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gnR9iN2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329608; x=1794934408; i=w_armin@gmx.de;
	bh=JWWehr1RyZSarNuffT99UJfWVpenTyinVDZu2G/e0lE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gnR9iN2HuXKkXGH2lF0vNwYxFJDnQ/JSvCGBU+NdSEpkobNFRNClmoqXCNluYJ4M
	 L++3qeHmZSBGnXlVFcA5AS7x2hb8U+lTSed3JuOfPA95/2Q47faxhJZaWlkW6MJai
	 wtQ3SSUZiPqipl1z1EcS6CIc0YKR9Wgkmj3QdlKCGr768c2i1iwxJxY8tQ5E6+d7K
	 HhClrW0NlwOGypnKFAgbyb+t9moTKGpU8daoEXYR/T3bfwseuDnNFS9UJspMd0EQi
	 loUUVX047JIY2qS76FuFI8UohR1+VloPG/Gr3/+bgnoYDOvgPh6o4zSFVmc14HY5G
	 cZ7UEcem2hNhOiyOsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1x2a9Y2RT6-00VgmP; Tue, 10
 Nov 2026 17:53:28 +0100
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
Subject: [PATCH v2 4/9] platform/x86: uniwill-laptop: Expose battery health and cycle count on all devices
Date: Tue, 10 Nov 2026 17:50:05 +0100
Message-ID: <20261110165318.631010-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:lcLO6gziOyO3L266ES5OIdQscpO6Mz1+uHj4Td8Qw+7iHyYLI0h
 9V3exrmR3LQLoIF5kIYY5rmackWM83xDTJlHOS98jdDK+wGTMFvoiw2ktCLB4hTXb20G85e
 j/Cfe056DE6UojfLpU5lNKGVEPjw5b225WbmZj2HhLLvPg6LsySudIczSG31YUOQrSP1UYa
 aJeC8FVKgfw4yCt+cKIWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/5TCkmpwHXY=;70eUPaYZP3M9qj+3cXGT6ItcjAb
 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

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

