Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270007;
	b=FCYZoDLgmlYYEOmMCmSI2djOJChZxD5TF48TkO4JWlWnFbgRO69LS1unUy8vvmWIsfvh
	 IrdhGAdsTdRDIMnisEyO/L5wmn2xTridSHPbFUCdSTZRGH7/SBu1SrWuRjZuoW01tLW0d
	 qVRxkFIofHQnfbtyi3gmExd0q3qMTQsMp+1RVV8dtbkaBHLBoLa7aR+63Hws0zsEsqJwI
	 uMBEY4ZorYOT3+oWJE8TFwYhvU8wQ2LlRg9cnpF2qhb82W9uqgDD34oSRPZBjqYdMqCap
	 OokSqtTHWKUcvk9sMNOM4UYOe7LiCXgsjQUO7h5QRWeguVutZsnWVkz3XdjVgo6ftmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270007;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=ejyktL2towpL/IjM8aC92aTG5TB/ICNIBeHAn2URDf4=;
	b=ux6Mde2o/kWjiaRZNFgz0Ztcipd+VCiXb/vYhEY/kS5w72QDkAd3QwDynWlUsnGPmru5
	 /LPKeTzo2s4FGBWlOh0rH7WOD8Iob788QEsGjZlJP1W9PAuzUPY2WIDCGxraJJJ0q/2GB
	 cKpNp1j5duPyUhPEYPirzr1Ri1yKv5HE/6gkZXGtvI55lodOYePlg7f8pe5M5RZuSfnvt
	 3kZPxfw3vHzWw8C9eF//q9asVn2I6fMMSUrV1zwNih9CAHarWhtIaUX0t8wvhKq26oCSe
	 R07XOMo2hcS25Qp8/enl0mh2Tjk4KBcKFKX+eCFknD4QzWLcGuaqHJyh1ndYmsZgpRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KXhQDZ2K;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3060A261A;
	Tue, 10 Nov 2026 00:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD3060A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KXhQDZ2K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269990; x=1794874790; i=w_armin@gmx.de;
	bh=ejyktL2towpL/IjM8aC92aTG5TB/ICNIBeHAn2URDf4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KXhQDZ2KA4rZFZKktuYz2Tef2ihQgAuzPbOFBGZ0BOI8R3tVqJHc3K+oHNW/AE0s
	 Dgb20PzbFSzXkUuHA+g5352OmVoOn6HC45Wbefdzt6wy+uy7mK6OvrfTaqtK2ZdeE
	 IK7F7Z0Ct7LEoIP3agbfSNjaSMYKc0x5dtb+oTgec9jr0BtKEuB/b//fh1JJUyGZu
	 +R+OQLH0eBMqxO7JZtxbljRawdFxwvCeg96AM4qc/D8lz7DWTqHEiD1L9LNLpQYPM
	 TGIRZavwM2pSQYOwDU8wfPG6scJcIPkB4xppK8d4G+GTFo9hIsXq6N4zBQKZ8cPus
	 zlDy79Ds+byZ//6DbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1wqxee2enK-00q6Xs; Tue, 10
 Nov 2026 01:19:50 +0100
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
Subject: [PATCH 6/9] platform/x86: uniwill-laptop: Mark sysfs attributes as const
Date: Tue, 10 Nov 2026 01:06:48 +0100
Message-ID: <20261110001725.851443-7-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:Wwdv0HH4R9eluuwAQnacE4TXGuyFsld2dZMlfF8U1oiHlCxYr4v
 HyDVkChAwDaujRyNWbWCXSnxr7bm+K8bbr0DjgduZA5FvRxJW2ScCP6XbJ7DWyM5VsM+mYy
 AfrRbPDpujv985/N2QZqomNpxewi4mIxqwjvgBRv6xQgOK9OdOun6UdLWlBchG3AWvQsjxk
 UG3kl46WPKg6HuMCJMBmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VPlFMfsr8S4=;+XGCPTK4fjx8OtOT5/67E2RQN8J
 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
 PjbLbYx8Rk7ES/GnexMijeg0S2+A==

Mark all sysfs attributes as const so that they can be placed in
read only memory for increased security.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 63 ++++++++++-----------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index 3d59b9a0f5bf..a987fb310b81 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -740,8 +740,8 @@ static int uniwill_write_fn_lock(struct uniwill_data *=
data, bool status)
 	return regmap_update_bits(data->regmap, EC_ADDR_BIOS_OEM, FN_LOCK_STATUS=
, value);
 }
=20
-static ssize_t fn_lock_store(struct device *dev, struct device_attribute =
*attr, const char *buf,
-			     size_t count)
+static ssize_t fn_lock_store(struct device *dev, const struct device_attr=
ibute *attr,
+			     const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
 	bool enable;
@@ -772,7 +772,7 @@ static int uniwill_read_fn_lock(struct uniwill_data *d=
ata, bool *status)
 	return 0;
 }
=20
-static ssize_t fn_lock_show(struct device *dev, struct device_attribute *=
attr, char *buf)
+static ssize_t fn_lock_show(struct device *dev, const struct device_attri=
bute *attr, char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
 	bool status;
@@ -785,7 +785,7 @@ static ssize_t fn_lock_show(struct device *dev, struct=
 device_attribute *attr, c
 	return sysfs_emit(buf, "%d\n", status);
 }
=20
-static DEVICE_ATTR_RW(fn_lock);
+static const DEVICE_ATTR_RW(fn_lock);
=20
 static int uniwill_write_super_key_enable(struct uniwill_data *data, bool=
 status)
 {
@@ -809,7 +809,7 @@ static int uniwill_write_super_key_enable(struct uniwi=
ll_data *data, bool status
 				 TRIGGER_SUPER_KEY_LOCK);
 }
=20
-static ssize_t super_key_enable_store(struct device *dev, struct device_a=
ttribute *attr,
+static ssize_t super_key_enable_store(struct device *dev, const struct de=
vice_attribute *attr,
 				      const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -841,7 +841,8 @@ static int uniwill_read_super_key_enable(struct uniwil=
l_data *data, bool *status
 	return 0;
 }
=20
-static ssize_t super_key_enable_show(struct device *dev, struct device_at=
tribute *attr, char *buf)
+static ssize_t super_key_enable_show(struct device *dev, const struct dev=
ice_attribute *attr,
+				     char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
 	bool status;
@@ -854,7 +855,7 @@ static ssize_t super_key_enable_show(struct device *de=
v, struct device_attribute
 	return sysfs_emit(buf, "%d\n", status);
 }
=20
-static DEVICE_ATTR_RW(super_key_enable);
+static const DEVICE_ATTR_RW(super_key_enable);
=20
 static int uniwill_write_touchpad_toggle_enable(struct uniwill_data *data=
, bool status)
 {
@@ -868,7 +869,7 @@ static int uniwill_write_touchpad_toggle_enable(struct=
 uniwill_data *data, bool
 	return regmap_update_bits(data->regmap, EC_ADDR_OEM_4, TOUCHPAD_TOGGLE_O=
FF, value);
 }
=20
-static ssize_t touchpad_toggle_enable_store(struct device *dev, struct de=
vice_attribute *attr,
+static ssize_t touchpad_toggle_enable_store(struct device *dev, const str=
uct device_attribute *attr,
 					    const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -900,7 +901,7 @@ static int uniwill_read_touchpad_toggle_enable(struct =
uniwill_data *data, bool *
 	return 0;
 }
=20
-static ssize_t touchpad_toggle_enable_show(struct device *dev, struct dev=
ice_attribute *attr,
+static ssize_t touchpad_toggle_enable_show(struct device *dev, const stru=
ct device_attribute *attr,
 					   char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -914,9 +915,9 @@ static ssize_t touchpad_toggle_enable_show(struct devi=
ce *dev, struct device_att
 	return sysfs_emit(buf, "%d\n", status);
 }
=20
-static DEVICE_ATTR_RW(touchpad_toggle_enable);
+static const DEVICE_ATTR_RW(touchpad_toggle_enable);
=20
-static ssize_t breathing_in_suspend_store(struct device *dev, struct devi=
ce_attribute *attr,
+static ssize_t breathing_in_suspend_store(struct device *dev, const struc=
t device_attribute *attr,
 					  const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -942,7 +943,7 @@ static ssize_t breathing_in_suspend_store(struct devic=
e *dev, struct device_attr
 	return count;
 }
=20
-static ssize_t breathing_in_suspend_show(struct device *dev, struct devic=
e_attribute *attr,
+static ssize_t breathing_in_suspend_show(struct device *dev, const struct=
 device_attribute *attr,
 					 char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -960,9 +961,9 @@ static ssize_t breathing_in_suspend_show(struct device=
 *dev, struct device_attri
 	return sysfs_emit(buf, "%d\n", !(value & LIGHTBAR_S3_OFF));
 }
=20
-static DEVICE_ATTR_RW(breathing_in_suspend);
+static const DEVICE_ATTR_RW(breathing_in_suspend);
=20
-static ssize_t ctgp_offset_store(struct device *dev, struct device_attrib=
ute *attr,
+static ssize_t ctgp_offset_store(struct device *dev, const struct device_=
attribute *attr,
 				 const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -983,7 +984,7 @@ static ssize_t ctgp_offset_store(struct device *dev, s=
truct device_attribute *at
 	return count;
 }
=20
-static ssize_t ctgp_offset_show(struct device *dev, struct device_attribu=
te *attr,
+static ssize_t ctgp_offset_show(struct device *dev, const struct device_a=
ttribute *attr,
 				char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -997,7 +998,7 @@ static ssize_t ctgp_offset_show(struct device *dev, st=
ruct device_attribute *att
 	return sysfs_emit(buf, "%u\n", value);
 }
=20
-static DEVICE_ATTR_RW(ctgp_offset);
+static const DEVICE_ATTR_RW(ctgp_offset);
=20
 static int uniwill_nvidia_ctgp_init(struct uniwill_data *data)
 {
@@ -1036,8 +1037,7 @@ static const u8 usb_c_power_priority_value[] =3D {
 	[USB_C_POWER_PRIORITY_PERFORMANCE]	=3D USB_C_POWER_PRIORITY,
 };
=20
-static ssize_t usb_c_power_priority_store(struct device *dev,
-					  struct device_attribute *attr,
+static ssize_t usb_c_power_priority_store(struct device *dev, const struc=
t device_attribute *attr,
 					  const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -1064,8 +1064,7 @@ static ssize_t usb_c_power_priority_store(struct dev=
ice *dev,
 	return count;
 }
=20
-static ssize_t usb_c_power_priority_show(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t usb_c_power_priority_show(struct device *dev, const struct=
 device_attribute *attr,
 					 char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -1085,7 +1084,7 @@ static ssize_t usb_c_power_priority_show(struct devi=
ce *dev,
 	return sysfs_emit(buf, "%s\n", usb_c_power_priority_text[USB_C_POWER_PRI=
ORITY_CHARGING]);
 }
=20
-static DEVICE_ATTR_RW(usb_c_power_priority);
+static const DEVICE_ATTR_RW(usb_c_power_priority);
=20
 static int usb_c_power_priority_restore(struct uniwill_data *data)
 {
@@ -1125,7 +1124,7 @@ static int usb_c_power_priority_init(struct uniwill_=
data *data)
 	return 0;
 }
=20
-static ssize_t ac_auto_boot_store(struct device *dev, struct device_attri=
bute *attr,
+static ssize_t ac_auto_boot_store(struct device *dev, const struct device=
_attribute *attr,
 				  const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -1149,7 +1148,7 @@ static ssize_t ac_auto_boot_store(struct device *dev=
, struct device_attribute *a
 	return count;
 }
=20
-static ssize_t ac_auto_boot_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
+static ssize_t ac_auto_boot_show(struct device *dev, const struct device_=
attribute *attr, char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
 	unsigned int regval;
@@ -1162,7 +1161,7 @@ static ssize_t ac_auto_boot_show(struct device *dev,=
 struct device_attribute *at
 	return sysfs_emit(buf, "%d\n", !!(regval & AC_AUTO_BOOT_ENABLE));
 }
=20
-static DEVICE_ATTR_RW(ac_auto_boot);
+static const DEVICE_ATTR_RW(ac_auto_boot);
=20
 static int uniwill_write_usb_powershare_high(struct uniwill_data *data, b=
ool status)
 {
@@ -1180,7 +1179,7 @@ static int uniwill_write_usb_powershare_high(struct =
uniwill_data *data, bool sta
 	return regmap_update_bits(data->regmap, EC_ADDR_TRIGGER, TRIGGER_USB_CHA=
RGING, value);
 }
=20
-static ssize_t usb_powershare_high_store(struct device *dev, struct devic=
e_attribute *attr,
+static ssize_t usb_powershare_high_store(struct device *dev, const struct=
 device_attribute *attr,
 					 const char *buf, size_t count)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -1212,7 +1211,7 @@ static int uniwill_read_usb_powershare_high(struct u=
niwill_data *data, bool *sta
 	return 0;
 }
=20
-static ssize_t usb_powershare_high_show(struct device *dev, struct device=
_attribute *attr,
+static ssize_t usb_powershare_high_show(struct device *dev, const struct =
device_attribute *attr,
 					char *buf)
 {
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -1226,9 +1225,9 @@ static ssize_t usb_powershare_high_show(struct devic=
e *dev, struct device_attrib
 	return sysfs_emit(buf, "%d\n", status);
 }
=20
-static DEVICE_ATTR_RW(usb_powershare_high);
+static const DEVICE_ATTR_RW(usb_powershare_high);
=20
-static struct attribute *uniwill_attrs[] =3D {
+static const struct attribute * const uniwill_attrs[] =3D {
 	/* Keyboard-related */
 	&dev_attr_fn_lock.attr,
 	&dev_attr_super_key_enable.attr,
@@ -1243,7 +1242,7 @@ static struct attribute *uniwill_attrs[] =3D {
 	NULL
 };
=20
-static umode_t uniwill_attr_is_visible(struct kobject *kobj, struct attri=
bute *attr, int n)
+static umode_t uniwill_attr_is_visible(struct kobject *kobj, const struct=
 attribute *attr, int n)
 {
 	struct device *dev =3D kobj_to_dev(kobj);
 	struct uniwill_data *data =3D dev_get_drvdata(dev);
@@ -1292,11 +1291,11 @@ static umode_t uniwill_attr_is_visible(struct kobj=
ect *kobj, struct attribute *a
 }
=20
 static const struct attribute_group uniwill_group =3D {
-	.is_visible =3D uniwill_attr_is_visible,
-	.attrs =3D uniwill_attrs,
+	.is_visible_const =3D uniwill_attr_is_visible,
+	.attrs_const =3D uniwill_attrs,
 };
=20
-static const struct attribute_group *uniwill_groups[] =3D {
+static const struct attribute_group *const uniwill_groups[] =3D {
 	&uniwill_group,
 	NULL
 };
=2D-=20
2.56.0

