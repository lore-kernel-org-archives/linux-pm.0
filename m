Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795253433;
	b=sWwaZyv47q7oXOZ1y9SqpUKyd+6SES8caRQx8/9ZjceezjwuaulscUIgazM8CLdM56vl
	 Hk0wO1N6eWWw7i8WVmM40cnVyKYL1oUQvYAVdXEX51p2zd/Y6edhXiyS+jRvgI6AEZTk1
	 B6TLgH/KR3kClifj6LkQfl0gOyl+gaagUzTC7OzuR3RReamV673qiMk3b3lfhFKjUpnT8
	 1l/EkbFuAl/a4INPmH7bPpYt0sXTGM01oTKi4uJDwS+hQbgWIfi1UNsfuZ2sLnhIx5nms
	 sArSUYh/DV4qGd66VmE4bQ8x/OKEq2bawB79COzS3mbW1LxDaaGk0UxZsJHfC4Var8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253433;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3iYSmVFOXGgqakgxiNgSisiE7SKTLdVKidEPMtm1aqg=;
	b=pRgj8Og+8tFQIdPpMCT4vDbI1pkXjh1nKpQyfXJmPOP1Hqrl9FJLZ9D+yHmd9tQnXhEt
	 4gpeJqoWFdVKo5pcBjVDIQIhFqb1M3qxssHmpRVw0aW3XR6n4FsJ8AeDHyP3GGYWDixMk
	 8uf1JzlVgSk+MxkiPSs5gctBzSi7ANojZmy2Vs6JlqHqAX79Lsw9jYPk/r0XS60/3zeN+
	 XCjclDFAVdNYJxCXuB7RdD048JVTo/Z8lgk5Phpv3KJOP+sCPRrqcuwsW/wUnrvOaoHKR
	 7GU4sm2qId2E3zxj8VxsaoJZ8HENE9FnSxONFiWOyA+cJfnLvzAGGq/NjfQ6PDMaiOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCZIkmY5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2311606A687;
	Sat, 21 Nov 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCZIkmY5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795253433;
	b=Ufw/q+qnetfGpwz3DOqz75CGuMT/t0wc839JP+iJzaNoZOF615rXZxMasA6AcpLLaA3t
	 oL/TfD/yn7RqSyaL4lUsGIyb/4qv06ZDpmMn9bY5aHuUcZth9CxtcQS8S1vKsclmWa56x
	 H3I0QETTvwmEv+Vx0csWwphARMe8Rxl/MNiVI7MGdAORNqG+AiwWgL08XFSj+Ygsf20Is
	 VDEZEeO7JMt2UdZpNE6qEUAdgLa3GIVChx15CPoCyywhkrhEPgDvCOHa7yePApIOeLN6/
	 CFRAN8BhN1x51qx1jcEsbrDbnkdTM9NOoZ3WeTFrQ3mUG+/BnFsVVzO4l7XmeDT/VTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795253433;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3iYSmVFOXGgqakgxiNgSisiE7SKTLdVKidEPMtm1aqg=;
	b=Acsv9dqTt5m+gze+FwObFpfHlXAfuy3MW+ncl8tqOMzsAa2PtHxLQ4ntgBLtN8kVbOr1
	 MKx5DtBVo2RfzHJTRKb5QiSWiY/XxzjNo9rVa4AQCCnB2FPcsifzgareUq5SCY07haaG8
	 rFc7lsGiIFsPRYDf3XX6U9b2RLrKBKMl3lByMA0KvIYK68cx+WRRs/tt/jjwjRDaZsuPg
	 F48MMAgEGRR3X+gv5pUM9pqiZbal4tR1FwDK6tMWydRX4Y3zILsNWdhclkVBuzUpwA1gB
	 H+4NCK/nM2uJSjUz8Ikrt1pQROS9pLh3XNAY7GFQzRG8HlxjFeTuQBraydUGy2N1Hgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6A47D1F000CF;
	Sat, 21 Nov 2026 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795253433;
	bh=3iYSmVFOXGgqakgxiNgSisiE7SKTLdVKidEPMtm1aqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LCZIkmY5PkYApqLExlEhLgXLHOcurhLiGcP8QvnPrQ7CofWLN8t8gDahZImHXlMoj
	 rhVPdNsLkPSzC0zrh1RKm7UVQk36kHvHoJYXIURs5RveTksWZV8PCGqOpTabqcfMQ2
	 7+dAyYz3DY2aApogt0ScTu92w+1kSrsKpDtVWlC1IjCgGGQyvTxH8khpnyGGci8rDe
	 RQoqfHHrUlErrR2svhdWEX4Y5Nfv7CPnxIcCw0pRQ74XPToIYi3F14qCJcJ2aWupFU
	 0q97xfWp/JW9LTrHD4QU3lB0aI3hghCjh7nvPCecmfMwqyOAvwtk+xQoTkT2x9tFNV
	 1/1dvqNnbG/FQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EB70F4BBB8;
	Sat, 21 Nov 2026 09:30:30 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sat, 21 Nov 2026 10:30:21 +0100
Subject: [PATCH 2/3] power: supply: smb347: Make the APSD and AICL
 registers readable
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-upstream-smb347-apsd-v1-2-ca46b92bfd44@tsv-stahl-riesa.de>
References: <20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44@tsv-stahl-riesa.de>
In-Reply-To: <20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44@tsv-stahl-riesa.de>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Dmitry Osipenko <digetx@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Bruce Robertson <brucer42@gmail.com>, 
 =?utf-8?q?Martin_J=C3=BCcker?= <martin.juecker@gmail.com>, 
 Mithil Bavishi <bavishimithil@gmail.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795253429; l=2425;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=qo/m+YK2xUxKc3Lw/oUCa6pEdiiFJLNVhUkFo+v1kq0=;
 b=Aa8mbgRF9MIDgIuMhXTKajcLZsAjFkfhCso+OP8Itmcc/LiaMaG5VI6qKO0LtLR0b319+P/su
 N6x6ZPiJhzcAWju/kaToJiGtDjYCptW1nTX9uCi11hK6/OAcOfXMTLO
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

The charger has a few registers that the driver does not list as
readable yet:

  0x02  CFG_VARIOUS_FUNCTION  includes the AICL enable bit
  0x04  CFG_CHARGE_CONTROL    includes the APSD enable bit
  0x3e  STAT_D                automatic power source detection result

The bit assignments are taken from the Android 3.1 kernel for the
Nexus 7 (2012), drivers/power/smb347-charger.c in the
android-tegra3-grouper-3.1-lollipop-release branch of
https://android.googlesource.com/kernel/tegra.

Add them to the readable registers. STAT_D reflects the state of the
input and is volatile. The other two are configuration registers like
the ones the driver already caches.

This makes them visible in the regmap debugfs and prepares for using
the detected charger type to set the USB input current limit.

Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/power/supply/smb347-charger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 72dfa15b3d80..03d58b378a25 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -43,10 +43,12 @@
 #define CFG_CURRENT_LIMIT_DC_MASK		0xf0
 #define CFG_CURRENT_LIMIT_DC_SHIFT		4
 #define CFG_CURRENT_LIMIT_USB_MASK		0x0f
+#define CFG_VARIOUS_FUNCTION			0x02
 #define CFG_FLOAT_VOLTAGE			0x03
 #define CFG_FLOAT_VOLTAGE_FLOAT_MASK		0x3f
 #define CFG_FLOAT_VOLTAGE_THRESHOLD_MASK	0xc0
 #define CFG_FLOAT_VOLTAGE_THRESHOLD_SHIFT	6
+#define CFG_CHARGE_CONTROL			0x04
 #define CFG_STAT				0x05
 #define CFG_STAT_DISABLED			BIT(5)
 #define CFG_STAT_ACTIVE_HIGH			BIT(7)
@@ -128,6 +130,7 @@
 #define STAT_C_CHG_SHIFT			1
 #define STAT_C_CHG_TERM				BIT(5)
 #define STAT_C_CHARGER_ERROR			BIT(6)
+#define STAT_D					0x3e
 #define STAT_E					0x3f
 
 #define SMB347_MAX_REGISTER			0x3f
@@ -1199,6 +1202,7 @@ static bool smb347_volatile_reg(struct device *dev, unsigned int reg)
 	case STAT_A:
 	case STAT_B:
 	case STAT_C:
+	case STAT_D:
 	case STAT_E:
 		return true;
 	}
@@ -1211,7 +1215,9 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CFG_CHARGE_CURRENT:
 	case CFG_CURRENT_LIMIT:
+	case CFG_VARIOUS_FUNCTION:
 	case CFG_FLOAT_VOLTAGE:
+	case CFG_CHARGE_CONTROL:
 	case CFG_STAT:
 	case CFG_PIN:
 	case CFG_THERM:

-- 
2.56.1


