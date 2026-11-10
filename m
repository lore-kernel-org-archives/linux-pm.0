Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329613;
	b=HPSErPWeMwcFsEfmMFlpSWSpjUC/HdGGWgxEE82sTBLlHQgxiwkW54wxL3hGnqdAQqlU
	 dg2zU24lgS9cKKZFbT+jD1pM97+8CYbpF5ejQiGtBsRWFQ8+0gUTSjId7/cN4sfgQTBUV
	 CBoYT6fSeiKWvYz9yfc0LekanDbyHl8qd8WIO1WQaylWdeQ9fePE+vylfYequbaU+L374
	 S4as0LwHW4utrjJxkrVNRDeC/tnckuIpbjO94mwAVzF/Aa+M+fZbxFag6qP7ejGbOPnrh
	 Kv0N8svGlOYGWXGsUdU3q4m36lwtv3Mrx9WTYEtkA4gbJrlufpW3fDN1QeAaLEICYtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329613;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=KYZ2UuvPfB+TRECtfVH9TmzAWUH1wX9K08urgnRmaOM=;
	b=HpQGQfq6SNi1OSWN0hG/n4rhw9MZZ2aaO9K0LOS1iMqFbLbYumtTQo+fILePKl4u3flT
	 9qKAcICX3PTjcCmR7RSca6zf0gHn8CZ8sXFWq7SkMgWrW7p3Ke8xwwvIL/N8fahZZovap
	 tsbNAAMgzfDQ2iRzKZDOBRzdrs8k4aVFpHe2XeISr3pUUEBlXBK1EbWCJ8VCVTjJNcGbY
	 m1ewqPf0YqzUrF2fzn1E0FiuxdFuztDzSr5OlNPg0mw35tPqKGy2RqJcwIeWgPVOMYGtA
	 4nVBsVswxX2mvgWm258EhBM49COeIM0uLyZ+ur9stT1Ga5AexTdkDV1Yf2pklIkf8Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Z4WNvha8;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B855E60A3810;
	Tue, 10 Nov 2026 16:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B855E60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Z4WNvha8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329610; x=1794934410; i=w_armin@gmx.de;
	bh=KYZ2UuvPfB+TRECtfVH9TmzAWUH1wX9K08urgnRmaOM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z4WNvha8zSeDfFu9agMCTu5DqWPnmykuDAAYaTR0NV9xlJqM6kfSYfGuUlAGquL4
	 13bHpcKm1X3k/31atr8upbiR0gdE1zSJYgGQD7PonmGdSd/2jLdiN5NhV67eoZn+Q
	 8RoLizc4xoBjqOZ/EERy1Lu+CQp/llddrrLENllTVjvpekt8jzeILDDEFbc+N3Akp
	 QtgrqVhg/VPuD7cc9Bwr7oUcMuiKw+8jjPOalovKSC0iCP7+44WpPLnt93edGpzos
	 m2/PsrE0eFsyoaZDG69dJFjnUGeUnxJhXtle1PoU7YqnjvVWj5w5ne+rH3wwevJ0g
	 R686tNY+K/F5C4WuHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1wrDQm2o7O-00qjZf; Tue, 10
 Nov 2026 17:53:30 +0100
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
Subject: [PATCH v2 6/9] platform/x86: uniwill-laptop: Mark sysfs attributes as const
Date: Tue, 10 Nov 2026 17:50:07 +0100
Message-ID: <20261110165318.631010-7-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:9JeYf5ln9TaSYTZI/UOztFK2b1Q/2s0MRFc+b6FLzTXuMI/mPm+
 VSNFIRnBaOhBQpTaRK7mDzV9mVwGKLZIpXigcK5JyslGOybI4tUg1LF+W2hUkcevqtNm9aa
 YECI/Kiokpa28D1XIYSrit+xJAQihaT24lPuuuD9RZ6DzNIzaqTDcSPuxox/IE34CvfSmME
 aqMLydYfgrhHkC6dGyqbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SknIBaUXiaU=;GAkbTf5q7vXRrlbE7Frm5p0e5t7
 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
 W0gtYUhAYeYojspGDOw==

Mark all sysfs attributes as const so that they can be placed in
read only memory for increased security.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 63 ++++++++++-----------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index ef3e77446112..fbb704cf6e66 100644
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

