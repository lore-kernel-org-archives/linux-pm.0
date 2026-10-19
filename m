Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792436898;
	b=xz+z+pMwwlDWghscMOZ3zIfnkxunIqiQm5kI57wsKyAiIEECVd0WH6J/nDYEzuL3BT44
	 4FKRirRV1BBwcl+LBluPpXWoqor9Eo1TtID5kkmLYQDadCigO4b8D+GWO/ZlswSQL+uvj
	 eK+0F5rw1sky2A2T0+Ua3NvZvBec5saK49ErhDz2JEVrr8FrPpB3tO2ES4HoFy4+6doDA
	 TFJ2X8+LUADGcvwEdf3fC6DLQvAY6IAjYRhacfcBAxMDH/TLu8vVtF9lyomBtZil2uBwT
	 idOHOAGJ2KwckiCW0SAJkxHtaYUmjCwqOmqTW+PycnvCf43KoPZLmRcETYaYYaPL2kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436898;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GtqT5jKayZCyLMZzwi+S2xzw/Yyak4R2T3ZqqCXNvwg=;
	b=ECmmSq7LbJR9WDWRgvCZxKH0WLSdNgWxInL2E/yLdMPOaYqWWLr8LoM9L1ZKiBHFRSVD
	 rhxkLq9mgyZ6Jmi3i6XqjktkckzQxFWccRQ3hZ+0rK6eaCgmGvghGTizNOj00kcBWIezZ
	 dI4oy+ANP7m2J+HtVqaQd7/HNaSJNPt3xNMwJLXfxupfsUEr4AYE//B8liOvkARK2WkyD
	 6bO6lfjtZxUDqKqoWGJnazTKuVshb0gkSJxzzDXtsqzUH9xjW8ff2xgSgTnHmUHnW5PKe
	 Fxh9n2/cIg5e7nUobWEi0LfdE9JOUX+p3AHDH2PGA9n4BATAEOupMKEbY27a5wEj/jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvrlmbS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F80606A319;
	Mon, 19 Oct 2026 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvrlmbS9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792436897;
	b=bLV1zn+qCRFcE0/U+CBs0HPI1yXRtglx2pfpiiI6gicWL0eWF8BC9PxsLf/dzYPLPZmd
	 ZmM8rlm2ChwRm/LzHRNeU3cPf1rQpxZMIj0r8XNOyj8muLFTOioGimGCzWuIM4Pm8UZ9z
	 wK+b3ag3DY6Dim5vs9+BT4jted+3HGHy4RgMNPMAJguFZcmHIHcG0bg6lx1EJ/K+zaBZ/
	 74zT6WH+AQPGgAdyfIRh87fJPI1OaHaIXq/FoutghLVRX25x5NpNaUX1TIwjUmYupAIKc
	 vZhCkLY//yuEqKAJGLSXNGD5mW5NxH2Afidg/OQ3RJ/iEMjFAZ76RORkX4pLn2E3PPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792436897;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GtqT5jKayZCyLMZzwi+S2xzw/Yyak4R2T3ZqqCXNvwg=;
	b=QsUVzRHto4W4vUqEco1hn/Av0NHLq/HjuuHH+JOSVFAAxuqcTUoctGGXf0JMsMBQHynK
	 abKB6NlnfaWPSWdVhdvb7S6UpAnLyCrU1ZcEUYNK30crB2cxrHxAOfyX+iq9J3vkdiMqI
	 c9+hzFedOBafNxQiV4JuC2IaK5J09v3aScIiosS1T0c6nUPebLYbJBwCva10cD2Oiow64
	 2HGH8As6HrTKFc3ZSfyPp2NavxJyTKLFVg4Woxsuj4i3Vbh/fdISlqTL444FzKKnfSqpt
	 I/uozYs1UjfHYYAYt9yGaaDr14pFDPC2AfSCyrJkxhzBh3ouhBeIMfliJCyEz4kyp+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 41EF41F000C4;
	Mon, 19 Oct 2026 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792436897;
	bh=GtqT5jKayZCyLMZzwi+S2xzw/Yyak4R2T3ZqqCXNvwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YvrlmbS9oKdXNXS/WEJD+5dMO+1zc5mEV4Ej2X96Y1pnazlSYZoSHiDq4r6SPkE/3
	 IvxBcXQzQrmOgAZb0JNYT603fTw3H7j4n9AozyRPKT+FA7mNzZEBspI+j6QMeL5Grf
	 pHDm++FVrYviGkWrfFJrskwWLwim3n+gogLkElaVC1ayZagVTi3EZvcIaw9JFavSqD
	 2Oj+uak3bVa5KdGOAJKOMmekpmWlrzTBnpFFCRdbGEqI3lVYW9D/4i9xGeI4/FVcNj
	 3l/lppdv7NDHwqtkWoQLEWvHCafSAZ32TTOYdZy/pawPmcf+EZb0+08fgsBQJGdRVZ
	 rzgNCxVWCitNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9BC6E4060D;
	Mon, 19 Oct 2026 19:08:16 +0000 (UTC)
From: Rinat Muhamedgaliev via B4 Relay <devnull+rinat.muhamedgaliev.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 22:08:16 +0300
Subject: [PATCH v8] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
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
Message-Id: <20261019-master-v8-1-2517e41c8992@gmail.com>
References: <20261019-master-v8-0-2517e41c8992@gmail.com>
In-Reply-To: <20261019-master-v8-0-2517e41c8992@gmail.com>
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436896; l=3577;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=3741MIanP4eFbNiDO101+hIyxN0viS5/BgzVbL3dkKk=;
 b=icd4FdYOvvtF0nDiVUfRgQBEguyYF8F9b5Li4YWGRUthZ7ALJJFjXznzxol7XHQlLHKx8W53k
 DDTMgr8NLuHBV/sv1jZ9mFJxxduTgrMkGtwkC3aEAB46LBD+NKs6k5L
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=
X-Endpoint-Received: by B4 Relay for rinat.muhamedgaliev@gmail.com/default
 with auth_id=1072
X-Original-From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Reply-To: rinat.muhamedgaliev@gmail.com
Content-Transfer-Encoding: 8bit

From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>

OnePlus 6 and 6T replacement battery packs may contain either a bq27411
or a bq27541 fuel gauge at I2C address 0x55. The device tree currently
identifies the gauge as bq27411, but a bq27541 uses a different register
map and then reports invalid battery values.

During setup, query the DeviceType control subcommand for bq27411 and
bq27541. Keep the profile whose DeviceType matches the compatible, or
switch to the profile returned by the fuel gauge. This retains the
established DT ABI and supports replacement packs without introducing a
generic compatible.

Keep this logic in the bus-neutral core so it uses the existing register
maps and control-register access helpers.

Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of
charge, and temperature were reported correctly. Testing on hardware with
DeviceType 0x0421 would be appreciated.

Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 8bf048fbd36a..57b51348ff2b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -86,6 +86,10 @@
 #define BQ27XXX_SET_CFGUPDATE		0x13
 #define BQ27XXX_SOFT_RESET		0x42
 #define BQ27XXX_RESET			0x41
+#define BQ27XXX_DEVICE_TYPE		0x0001
+
+#define BQ27411_DEVICE_TYPE		0x0421
+#define BQ27541_DEVICE_TYPE		0x0541
 
 #define BQ27XXX_RS			(20) /* Resistor sense mOhm */
 #define BQ27XXX_POWER_CONSTANT		(29200) /* 29.2 µV^2 * 1000 */
@@ -1141,6 +1145,56 @@ static inline int bq27xxx_write(struct bq27xxx_device_info *di, int reg_index,
 	return ret;
 }
 
+static int bq27xxx_battery_check_device_type(struct bq27xxx_device_info *di)
+{
+	enum bq27xxx_chip detected_chip;
+	int expected_type;
+	int ret;
+
+	/* Add fuel gauges with supported DeviceType reporting to this list. */
+	switch (di->chip) {
+	case BQ27411:
+		expected_type = BQ27411_DEVICE_TYPE;
+		break;
+	case BQ27541:
+		expected_type = BQ27541_DEVICE_TYPE;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_DEVICE_TYPE,
+			    false);
+	if (ret < 0)
+		return ret;
+
+	ret = bq27xxx_read(di, BQ27XXX_REG_CTRL, false);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case BQ27411_DEVICE_TYPE:
+		detected_chip = BQ27411;
+		break;
+	case BQ27541_DEVICE_TYPE:
+		detected_chip = BQ27541;
+		break;
+	default:
+		dev_err(di->dev, "unrecognized DeviceType 0x%04x\n", ret);
+		return -ENODEV;
+	}
+
+	if (detected_chip == di->chip)
+		return 0;
+
+	dev_warn(di->dev,
+		 "detected DeviceType 0x%04x instead of expected 0x%04x\n",
+		 ret, expected_type);
+	di->chip = detected_chip;
+
+	return 0;
+}
+
 static inline int bq27xxx_read_block(struct bq27xxx_device_info *di, int reg_index,
 				     u8 *data, int len)
 {
@@ -2089,10 +2143,17 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.of_node = di->dev->of_node,
 		.drv_data = di,
 	};
+	int ret;
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
 
+	di->regs       = bq27xxx_chip_data[di->chip].regs;
+
+	ret = bq27xxx_battery_check_device_type(di);
+	if (ret)
+		return ret;
+
 	di->regs       = bq27xxx_chip_data[di->chip].regs;
 	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
 	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;

-- 
2.56.0


