Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329612;
	b=f0wc5PcdBfTdzI9+D6A3CBCgqZeGAV0JB5YHY4b+1DvQm4za1BsxKpMtOX2qZWlFwejF
	 TrEquPsAKhWCSfCPeQx8MGJrdQ22tIlA+C6l9lLYTjYDOuY2RAqMLBlOk8Mby5dRoHlC+
	 IIn59Wd5K4sI1WS/fAWRBiPnyE20OTQVJMuVc9iXIj40OPy2v3+SFyviNOA0Cqg/KlNWI
	 j82PAFcjtOvKIzeMc+EODGApDUCIhwS39yyhoFkq8qjH6tL1u9wfLmCeR1KScHlGLoDLg
	 Baa2AhDdWvSUC7UH0ipQUYzJ6k6y1VTvEXX2S1A9mWdekDv9F9ASNEYVhsMZBSV17pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329612;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=0rj1XHNYZzGUfvEGFEeb+DMShOMai38hfZMBONwzmMw=;
	b=wG6Sy9CV0YNnDBvEnNfIxTqcELrj73OL9kizYVlmqJhdf9fA8I3jRWrGPHPMdl2aa4oV
	 8LmYSYpINj49nUcIvOQRV7363Xyq5xOwWHphkgBtlXjocpRkFktwNXV4KVbYFJtueCPGb
	 69g5hv4PNtDGDNC8T2RY21UQhsi8tAwjY67vECXLhN9YYDg2RZjAwERM37CU12E4ZycRO
	 LXlNpyeCAXNL5lvroM31n1PAqhGqsAc+cZNP9meKfuT1fq1ddLdgzN4uZp+fSQPXVYpew
	 bppNjzVn8Hn9Mame4Siq4UIAbfQU31GR7sKvK+GQ03eAq5kGhAt63ZPx1tPPZGRsRBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HAU77KYO;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3960A260A;
	Tue, 10 Nov 2026 16:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E3960A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HAU77KYO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329609; x=1794934409; i=w_armin@gmx.de;
	bh=0rj1XHNYZzGUfvEGFEeb+DMShOMai38hfZMBONwzmMw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HAU77KYOS8If3fRplKotPcHkiyHW+QKLQwF6xAHsa+DFRv3ng7BV3+8+L0nCxvGV
	 q8UJPPekV2o780G3gQA5aiUNjTXlc8XJMmoizfFrtTz35uwDNo/VrXvMZLf2r5wCQ
	 nL3PzismR8w1wT6/DKbXSr7zg/G2CKAOi0i0zlGmcog9UYLtSBerR9wDDEvjt+ZXN
	 RfDvfdB8VBN0117YDp3pYNFKsn0cUCLJiJtOgRbFat7MyvgSVjOspnL3ETPcCuA3T
	 dhDVPzOd+4+kBMQGowIoQFtH3RT//qyozTx0b7vG55jbS4a6j9xHZD8D2dUFgmRnb
	 ed3ZvNWQpOROfFMP7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1wkdrX2bPO-00mwDl; Tue, 10
 Nov 2026 17:53:29 +0100
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
Subject: [PATCH v2 5/9] platform/x86: uniwill-laptop: Expose raw battery capacity to userspace
Date: Tue, 10 Nov 2026 17:50:06 +0100
Message-ID: <20261110165318.631010-6-W_Armin@gmx.de>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cmwvKpCBQ2UtDAkzC2lxYIldQgUfU9ZzILIn2HxCBwx+aXUXyOZ
 s2kB8D1fhMuuogDQgDV7IJHlnyy+YBlvdYhE5yXW3vg+3hEkxOUHdMRaAG9AgwbNAHk9Wit
 ilDT78cRsRsl4b0pCFpkFhGTslds2/bsfmLN0QDCmBbs4u8A1q2j8N0fbPlKqPVcIkKoPS4
 TelNtMy5M4YMzB9yMZemw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Eo/nlKdBb9M=;/2ueJdNeFQpURFSvPmMf1T3ae/Y
 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

It turns out that Uniwill will not report the true battery full charge
capacity for the first 64 charge cycles. While this is likely being
done for correctly calibrating the battery, it still prevents custom
diagnostic software from accurately detecting the battery wear.

Fix this by exposing the raw battery full charge capacity to userspace
using a custom sysfs attribute.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/testing/sysfs-driver-uniwill-laptop   | 11 +++++
 drivers/platform/x86/uniwill/uniwill-acpi.c   | 48 ++++++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-uniwill-laptop b/Docum=
entation/ABI/testing/sysfs-driver-uniwill-laptop
index f3060aaf8a76..5f7eccb2d205 100644
=2D-- a/Documentation/ABI/testing/sysfs-driver-uniwill-laptop
+++ b/Documentation/ABI/testing/sysfs-driver-uniwill-laptop
@@ -92,3 +92,14 @@ Description:
 		boot at the same time is not supported.
=20
 		Reading this file returns the current status of the USB powershare func=
tionality.
+
+What:		/sys/class/power_supply/<battery_name>/charge_full_raw
+Date:		December 2026
+KernelVersion:	7.5
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		Allows userspace applications to read the raw full charge capacity of t=
he
+		battery. This value might differ from the full chage capacity reported =
by the
+		battery itself, usually caused by postprocessing done inside the ACPI f=
irmware.
+
+		Reading this file returns the raw full charge capacity in =C2=B5Ah of t=
he battery.
diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index 66770f939c83..ef3e77446112 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -395,6 +395,7 @@ struct uniwill_data {
 	enum power_supply_property extension_props[3];
 	struct power_supply_ext standard_extension;
 	struct power_supply_ext cycle_count_extension;
+	struct device_attribute charge_full_raw_attr;
 	bool last_fn_lock_state;
 	bool last_super_key_enable_state;
 	bool last_touchpad_toggle_enable_state;
@@ -635,6 +636,8 @@ static bool uniwill_writeable_reg(struct device *dev, =
unsigned int reg)
 static bool uniwill_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case EC_ADDR_BAT_FULL_CAPACITY_1:
+	case EC_ADDR_BAT_FULL_CAPACITY_2:
 	case EC_ADDR_CPU_TEMP:
 	case EC_ADDR_GPU_TEMP:
 	case EC_ADDR_MAIN_FAN_RPM_1:
@@ -684,6 +687,8 @@ static bool uniwill_readable_reg(struct device *dev, u=
nsigned int reg)
 static bool uniwill_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case EC_ADDR_BAT_FULL_CAPACITY_1:
+	case EC_ADDR_BAT_FULL_CAPACITY_2:
 	case EC_ADDR_CPU_TEMP:
 	case EC_ADDR_GPU_TEMP:
 	case EC_ADDR_MAIN_FAN_RPM_1:
@@ -1932,6 +1937,21 @@ static int uniwill_kbd_led_init(struct uniwill_data=
 *data)
 	return uniwill_rgb_kbd_led_init(data);
 }
=20
+static ssize_t charge_full_raw_show(struct device *dev, const struct devi=
ce_attribute *attr,
+				    char *buf)
+{
+	const struct uniwill_data *data =3D container_of_const(attr, struct uniw=
ill_data,
+							     charge_full_raw_attr);
+	__le16 value;
+	int ret;
+
+	ret =3D regmap_bulk_read(data->regmap, EC_ADDR_BAT_FULL_CAPACITY_1, &val=
ue, sizeof(value));
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", le16_to_cpu(value) * 1000);
+}
+
 static unsigned int uniwill_sanitize_battery_threshold(unsigned int value=
)
 {
 	/* 0 means "charging threshold not active" */
@@ -2120,23 +2140,33 @@ static int uniwill_add_battery(struct power_supply=
 *battery, struct acpi_battery
 	if (!entry)
 		return -ENOMEM;
=20
+	ret =3D device_create_file(&battery->dev, &data->charge_full_raw_attr);
+	if (ret < 0)
+		goto err_free;
+
 	if (power_supply_has_property_direct(battery, POWER_SUPPLY_PROP_CYCLE_CO=
UNT))
 		ext =3D &data->standard_extension;
 	else
 		ext =3D &data->cycle_count_extension;
=20
 	ret =3D power_supply_register_extension(battery, ext, data->dev, data);
-	if (ret < 0) {
-		kfree(entry);
-		return ret;
-	}
-
-	guard(mutex)(&data->battery_lock);
+	if (ret < 0)
+		goto err_remove;
=20
 	entry->battery =3D battery;
+	mutex_lock(&data->battery_lock);
 	list_add(&entry->head, &data->batteries);
+	mutex_unlock(&data->battery_lock);
=20
 	return 0;
+
+err_remove:
+	device_remove_file(&battery->dev, &data->charge_full_raw_attr);
+
+err_free:
+	kfree(entry);
+
+	return ret;
 }
=20
 static int uniwill_remove_battery(struct power_supply *battery, struct ac=
pi_battery_hook *hook)
@@ -2155,6 +2185,7 @@ static int uniwill_remove_battery(struct power_suppl=
y *battery, struct acpi_batt
 		}
 	}
=20
+	device_remove_file(&battery->dev, &data->charge_full_raw_attr);
 	if (power_supply_has_property_direct(battery, POWER_SUPPLY_PROP_CYCLE_CO=
UNT))
 		ext =3D &data->standard_extension;
 	else
@@ -2239,6 +2270,11 @@ static int uniwill_battery_init(struct uniwill_data=
 *data)
 	data->hook.add_battery =3D uniwill_add_battery;
 	data->hook.remove_battery =3D uniwill_remove_battery;
=20
+	sysfs_attr_init(&data->charge_full_raw_attr.attr);
+	data->charge_full_raw_attr.attr.name =3D "charge_full_raw";
+	data->charge_full_raw_attr.attr.mode =3D 0444;
+	data->charge_full_raw_attr.show_const =3D charge_full_raw_show;
+
 	return devm_battery_hook_register(data->dev, &data->hook);
 }
=20
=2D-=20
2.56.0

