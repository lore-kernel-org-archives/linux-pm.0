Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269997;
	b=ANY+f6t3kIKFvpw2YLFU/K41/V6k7FUYkrglNQF+h23nS3Sqhsh5KORq9D/ZCcuqYc/o
	 iNF6CyRX9fOPSyJQgHPfinAMH9JX4V0s0NGOS0i6AV3x9cttawrOzlt4EixBtMrARZFX7
	 BQY/K3TuWOFO2fCvT08p1D1sk+VPubyLz880Jg0cZuWospCSjxKPBzXE9ML40/yUnKfVS
	 A2+2MZii2BMF6h5Mc1BOn/HP5b431IlWco9fV/DZjdP3qyeRZH8TKoS3Fx7/s2WD8VVTx
	 ozzla8wTS6Wl2zjJvt3EDPe/Dxfpg7yTRHX3VhnB9hPDwajVOpaVFhDFeTnGD+kKl5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269997;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=ea+QWxPOcppuf4ZbzpuUOJF7bzhWIkkFCSo0JFnv+0E=;
	b=TRPqRuYLPAG4kUPa4ZbVc8srvCg6lpwNgwZKP1L21RS1NX6LKPyecysTh62xM7Ond8bP
	 CcKhsV7Q4f4hMpmybK5syKOU2dLx/hRvStD8CRpEPwhzN/wglz+j9SsI7HOXc4Bh5VRWk
	 MxTdHlHkKfKQBCgGtO0HH7vXbeW1lFnUhbAsVuhaiAJgaiTjiO3/ytdjfOEWCTSFUIQxY
	 236saao7WH6hbdpj/t98Ar4TYCb69HjSWxZViaG/t13mFoCEmhcUizb13KC0XIqeJuoR4
	 VsQDqTnOQS+tczPDsRhonKGfiN6ISa6imnDLnTqVYXfmQlmDtiVHD+dfUgFlpj/qyBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="F/oT4iIR";
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEA60A263A;
	Tue, 10 Nov 2026 00:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4EEA60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=F/oT4iIR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269989; x=1794874789; i=w_armin@gmx.de;
	bh=ea+QWxPOcppuf4ZbzpuUOJF7bzhWIkkFCSo0JFnv+0E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F/oT4iIRZ0C5gn/2BW2QNKtldvuwFQf26VEKIsZ+EtLrIUBwf5He0JIIEpL5Osjk
	 eMFAi2fxhQJVfme5n63ab8GbeYAtTbMehPyw9uDBTOo+tgfz46smGqy9LdQxeF/EW
	 DIHnv+06gBjaSGDywI03ey80/tobzjJgmY/HYUOUT/2HBNvkkpThDqmX+ZL8wDzQ5
	 NQ6hRJpn8esbEn3jn4fDBfX70tSZOnAIOaAUAWvtT5ZT0MQxkZtixgj2nVwldGC0a
	 hE0RFLQTM/+08CI3wWOBMuMHPjiOK3m3Qm2fgAcFtWUi8G0TG0ocHZpTyy4g5nbZ8
	 VUTcx7ynkNaiUhCCMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1wz0BM3db2-00IZGt; Tue, 10
 Nov 2026 01:19:49 +0100
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
Subject: [PATCH 5/9] platform/x86: uniwill-laptop: Expose raw battery capacity to userspace
Date: Tue, 10 Nov 2026 01:06:47 +0100
Message-ID: <20261110001725.851443-6-W_Armin@gmx.de>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vIlqxPpBDNBq8wONLqfa0N/rjbvvbMGD7WmjKep6HsDeNSlDPmJ
 ujuXvuapJslddYGxth7WCb1VmJYzMXnUgYzcI0Fp+jIcL0tetYogLm32x6pZriqFm4cBVa2
 zz42QJZvVydMFb9PZz0sftjTkCnQNsKJ7ilcL21syESoryGrBddBiVARAs/YCq64+bxdSeb
 M5Sq2ZX/qLVdsOAR3zPGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K3MgS8gN74o=;0K6182d0xq+xmMm48cYhaJ66cXt
 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
 RJtcB

It turns out that Uniwill will not report the true battery full charge
capacity for the first 64 charge cycles. While this is likely being
done for correctly calibrating the battery, it still prevents custom
diagnostic software from accurately detecting the battery wear.

Fix this by exposing the raw battery full charge capacity to userspace
using a custom sysfs attribute.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/testing/sysfs-driver-uniwill-laptop   | 11 +++++
 drivers/platform/x86/uniwill/uniwill-acpi.c   | 44 +++++++++++++++++--
 2 files changed, 51 insertions(+), 4 deletions(-)

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
index 66770f939c83..3d59b9a0f5bf 100644
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
@@ -2120,16 +2140,18 @@ static int uniwill_add_battery(struct power_supply=
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
+	if (ret < 0)
+		goto err_remove;
=20
 	guard(mutex)(&data->battery_lock);
=20
@@ -2137,6 +2159,14 @@ static int uniwill_add_battery(struct power_supply =
*battery, struct acpi_battery
 	list_add(&entry->head, &data->batteries);
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

