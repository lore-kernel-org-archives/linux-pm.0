Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785666;
	b=q8wbQq5r21gAaHTOwtrOhlkQg4cLed7OHv0AMVZnPk26NfN4EAXW5P4E2PnU1MkWgM7r
	 fZqcOOpYcZUkz0TNsgeYYGcQ8xiUWV6ReP9jIsIHa11+7chb0K2lJWkkvqvlYdpu+oL+d
	 GEVrGfPA3dgc+xUa152mi1YcIPekCcL2bcs+9M8CAx2fq4N+l5CL16RWKKRWtU4XRXaoY
	 JYIVHHnp2+u0nBZuVTEIm+arjc3pA5LodL7d5UeK2PGMgVKZBAJjoKixf2zGoOJptO1jb
	 ZioBI1lzV7xaeR5kyjJ4hju3sUXxfOeRUYzrdhQyTPVJfTQqtQXCxiJOy2nEHcdeYZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:Message-ID:To:Cc;
	bh=Uh7Kzi5HknUWaE4263UOKqC/5G4430WqvI/t+055Hh8=;
	b=WpxKgWX/4ovtZOSFhcDxl/2t2eagwTydShk5Is05SfCuOAhcTCVLGY34K7hgAXauSULl
	 H0IQ3HCs470jUVN5wUdky6uaA1zD3CErQC8gaSu492BQAm+cV89aLeXZaMm9jNcl9aQJN
	 UdICM3iCIqa9Ffy67lXkBIuAbqdnB6Jdb/ZYmEwkQETtPu4OBIYNBREQF6ZsSHLPI6Hhl
	 hTFYK2J3DtVu4u+OvjgiPA29Y0KK/qv87CJgttSfmuU00nB/DGVXn+6TR0yJZ9xCGPSHJ
	 WhRPMnKqpUz2ZaC3qaNgCB7wsoJyJ+58jgVv7MSP+vIZEQEN8JMBouXEPOk/d1egyhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BcUl6U+U;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDD606A32D
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 09:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5CDD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BcUl6U+U
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so912556c88.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 01:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785665; x=1794390465; darn=vger.kernel.org;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uh7Kzi5HknUWaE4263UOKqC/5G4430WqvI/t+055Hh8=;
        b=BcUl6U+U5Ou1V+OPIEa0wBAlKPH/Ca4ZNT6sIaYz1Iv156zEQdRXZgV6BJbM4PR9Ff
         HrKfYe2WJnPoOBJznPFr/TpofGloVrSSBO3crPlG51Ef4OcmcKZqXHewSNPmKDb/3/Nc
         nISBaemsAMd4wrBtLnKpKBWtvPWak3Hnb1K4V0e3sSYMH0EkAmhQKq80g3w0c8ruatf8
         mlz4cjVUxtKrFWgCe8XuAwB/MGToaN4p/W2U9QElW+s3egYN+SDnLydHZZsGPI4u2SHA
         p9/qC/5G/s+FyllFpaNq2Q/hwybrHAzYKLyUDZXBD0IX23LM7hiVKqf5skXHHLjVYOQu
         rcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785665; x=1794390465;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uh7Kzi5HknUWaE4263UOKqC/5G4430WqvI/t+055Hh8=;
        b=JRcMJZgjqWamaJVcBzyHEj8ZCJJpX22YATuEEqHZCc5LNVMYCNg7DkASu4dWf28T0b
         M3qd93hoZBFR5F1nLpGI4nHu+Ju62TBihTOWdXiD0zK6ctzW35LhF9yEPADpErObsfgh
         FX0likWfoVt93JUoAVX607dzVn5RId9gKg+5e69j9bTGyUvbJPfHFJnMc1lVW65PNVu5
         d+imjTJDUerObihIEjUloQ4Tj2GyI4jdp9gdAx/t6/tiQQWBJDeYWPvq5WX6Wp7FERU8
         G3x0lygZ2tKlW6JswmG5Aq27Xnrldyyond6IaPmjNjflZjhkew7eYggBROXxgqGLVJjS
         UaGQ==
X-Forwarded-Encrypted: i=1; AKwUvBy55QDkGitp8RNH1EMbW+icS6srpfoYhqiPvWCGJYvuPT8qIkCRzrZf2S//h/KH8B0X2kEChVxgDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QsXipX5cxpe+XsIiKIRN+tSjLOO/qbq6s0iFXDzNQRlr3at26
	1sE8M6A0q5BOZM8o8EqkiC5RLqWZrAOClIrnM2ZhnY4T7YgCptY6oYrO
X-Gm-Gg: AYBFou04s76yfgXBdXMCILoFcIsbt/QKXqZjsknCZnn1YLJVNgeXuKYccogxy4KgziM
	AKPovVXY4mzA1FvcjSMHbjjq0xVW8AoDaGSq5fitkmlkjNGKHQOYVKGENeQWkD2RhRf4wNCec+F
	bOteHw9VfFD8vYLkGF0VaMwNpyPRbOf57fF2mX9ko2wbkCHJNDV8moqaBVjxerTtrdM90Z4b+JA
	fr1DARXggWSe6rcrodcoSk59Xi0ZdYF4CpYP7s7IYBp6hEAlFFFBX21NQZABZp7dWX/+VdUZxMi
	7vYUiuNTj90QYYBhPfDwfJyWSDb/0ORfehlMERj/J6luBD6MGy5Pac3RUONqUXbsp8BIibTaDbs
	X/QjT7o3f4GRba5QzLCSwOW1veUbr64HdbfyATh04EOPOHL+ayUyDqOB4vfzCdi3JTNiFx1mn4F
	/WAFvUiM+ODloFsSQ7Tff/yOz0Z554rZ+6EepRKyOKl+EO/38IKaqtadje+/ZNe6GTylQokavhc
	djWN2+5K6lkKkmtbcfHQIQi0pH1grzIrVsgtOF/gvSNSPw1tem56Mi2CilCkK4c5R+nnGp6RAYh
	Btpg9H84eumBFZUOKur59f8Yhg1mx3b5Q/lb1U3nZ6dQDiZllCjGDnRWmxUKE3droXo=
X-Received: by 2002:a05:7022:7f0b:b0:13b:3132:6e99 with SMTP id a92af1059eb24-1ac5af2da84mr21527601c88.20.1793785664520;
        Wed, 04 Nov 2026 01:47:44 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm6065186c88.12.2026.11.04.01.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:47:44 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:47:31 +0800
Subject: [PATCH] power: supply: bq25890: cancel pump work before supply
 removal
Message-ID: <179378565123.72475.2497991563887142080@gmail.com>
To: sre@kernel.org
Cc: hansg@kernel.org, marex@denx.de, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The existing devm cleanup for pump_express_work runs after the
managed power supply has been unregistered. A delayed or running pump
work item can therefore call power_supply_changed() with a freed
power_supply pointer.

Register an additional devm cleanup action after power-supply
registration, so devres reverse ordering drains the work while the
supply is still alive. Keep the original late cleanup as a backstop
for work that might be queued again during supplier teardown.

A KASAN test using a simulated I2C device and the real bq25890
driver reproduced the use-after-free before the change and not under
the corresponding teardown sequence afterward.

Fixes: a7aaa80098d5b7608 ("power: supply: bq25890: Ensure pump_express_work is cancelled on remove")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f7510ada6b734..a3e35e036b97b 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1459,6 +1459,23 @@ static void bq25890_non_devm_cleanup(void *data)
 	}
 }
 
+static void bq25890_cancel_pump_express(void *data)
+{
+	struct bq25890_device *bq = data;
+
+	/*
+	 * Cancel the delayed work while the power supply is still alive:
+	 * bq25890_pump_express_work() calls power_supply_changed() at its
+	 * end and must not run against an already released supply.
+	 *
+	 * bq25890_non_devm_cleanup() stays in place as well: it runs
+	 * after the devres-managed power supply has been unregistered,
+	 * catching work queued again from the supplier-change path
+	 * between this cancel and the unregister.
+	 */
+	cancel_delayed_work_sync(&bq->pump_express_work);
+}
+
 static int bq25890_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1531,6 +1548,10 @@ static int bq25890_probe(struct i2c_client *client)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "registering power supply\n");
 
+	ret = devm_add_action_or_reset(dev, bq25890_cancel_pump_express, bq);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq25890_irq_handler_thread,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-- 
2.34.1

