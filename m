Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055360;
	b=OaqWmBhwL0CMz471GBJsmeL+i/Sabi8mMYb9/Tue0bqmomaDhFjFizO+Fy5DsAR7uT2W
	 PmVi1XuZZ2pBdKV1I8/KeX+h7EV4Scv6IF1/VG6njkwRhMv5y/sehp40ThtT1o0bIPZt9
	 LrO7jslemwgt5oEl4Ptie+VEt9g8c7q7/B+SGgzMiaB2/POYrYyxrIL18ecuWlJbtjlc9
	 aL/rvd9JcNdFSq5F5QrD6uJYmbHQqOHornT0Dm1yxpFjc2YyKBV7zQYmViYT0O/5cM+Qt
	 BK+7R0Ok2xo+NEwoGSIFbLBR2ceC7Gj6xgcKs/srXqDqYlHv87ToBuswCYVtwYOxEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kbYJLFT1DlhR6lcyzknCYcaYqjsgEktI+N+QrE2ZDK4=;
	b=HpExb28Wyd3tbB29Hj2xW9Y1koBDxYRv52BTClXH2vyLQdafNsgFu+e4PGKsN0ssUOLd
	 kVwlK1axTCwpALD0Zen0GWw+DhTXmrenSz0vLqqLAWNmpJtSleR0A6tzyS4uoyuxCZiI4
	 cKsrciqsNjxCLxJ0a0dmmQKFWZTUCqbncciMfxsBT2uIIbnwqelZ0mJJ6EIAAsiEDqLyc
	 A9/DFH8wTCvuoQ+eYv2TK3KVcZCDHk03gijWTl7WYRC7MrbaNowP7L+a/XUAp4Gr9NH2P
	 YsVMjwEIyqZ+dtR/dYsreoE7idTqFFRxh0xE9Fg4ruqRuQ6rTiaQOboY6P4d1591e2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1N0ltpF;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098F60A2601
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 02:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D098F60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1N0ltpF
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so4641242eec.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 18:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795055359; x=1795660159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbYJLFT1DlhR6lcyzknCYcaYqjsgEktI+N+QrE2ZDK4=;
        b=q1N0ltpFawRKWSwxcD4XgqVnXfcdX1n1qI/6sPyS/+A07kz+ysPeyw0EDcvqD0dU5m
         mbPwSrAyJrZeCKe+Gj+PiXji7SwlIIzfxzX76+sbaqoJJ/6IT5aNLMJeLdXPTp91yT6z
         c5e+uCNcOKeliriYmzlRL+ywX3mbS939FTbFRTIMKaBzjwsrWeklXebw+Jy0twpeUB34
         lXAYNtP4IEb1inLcnfHZy2PpbKTRlxMO8di9URk/Hsf1PdHuIaKlm+e65J2yjzpC5iO+
         XnaC/pOI+NdZ4QZAkD7uKA7wWN+9c5BN4JjLaHvw6826Yy4RttEoDFYyxoh83V9JhpMf
         D0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795055359; x=1795660159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kbYJLFT1DlhR6lcyzknCYcaYqjsgEktI+N+QrE2ZDK4=;
        b=u3bYKTQxT/Nh9Z5cv5KcAFHjiQLyXYzldiT8iARm//CnAF/GFZYNijNRrmpilpu67G
         hX5P9URKh089fzyFBhp1Y5UV0OAq1PkzimcZA3ucfSPcTbFDbqLuS58QJgTeKi5TGsGx
         yCSZPIwGNfY9YJmIxKs48Zm/xFwVrRMnYNr2wSpxwdeFeF+aH8iKpeuqZ1JtAgDeOdB/
         5VK3trZlaK+6fkuTUYLJcvGVlbhErQYZwvd6qTmP5grdCWj3W55d87D45gjrDn3pjL9f
         Cmr9cEaRh/KCbNdnD0otbiyomZ7qp8noIdWAMz8J6fI4qLM9tiSEtNeB5rwCxjmE9e1w
         VrRA==
X-Forwarded-Encrypted: i=1; AL+hErFDUQs96Yy865TC3hXYXeKQS0RJNNMXDx8OB47dpEmgAFsmszbxtUrpSjL4mWQOO2o/R0kXP3T5jA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ftc0sjAiggzHAGpJpAERXIC2++6MYhgZ3+eTPd6xUsCJkQMN2
	fmYGMQ4cSQDp3uql7j0Yua8qhN+NkkvVeMnrsWu+Zmdk8AyrmbyZTIvDMbbat2a01l4=
X-Gm-Gg: AZFdTZcXbHDcD/HxESoCzRG6s0AZCR9NcJNKJeaBhohD8dgv7/VTjaw44lyIKBhGWu3
	OthioO4dY4ARSYEii6wlIaIe5MK4xv/Z1gp9SgKeb662Dx3PgHXaigV8JZuoLP6gpRBX+s3NmLA
	A89CM9bQAdHrooFpr5P8VYQ17OmFVPOtghJoRMcvUFtiKsPxartqDkrkML9sgbHftfUmEH6+sKC
	ET/8p64ZpZNC5kgzJvGFz8G6qcmca3qPGgc+k7TV6HS0ZBgTS5cxkJBFN8aoMPU7Ww6Gu4XhwPg
	rF7XmuMmF380C6EhSCIrHpl3GkUtPZuD2RZHgQiWgU2PyrhI3Fd4AAteTbUZgtBRKE1/CiW/mpb
	rS8Arw5Wr0TLNsrDVgO6vQUIddCId/KkZ1CoWqJaJVisoclmL/sn1gik12nBDQc3qJ7eB2HHHNP
	lR6L3yDGY/6aJuNAsPr6Wg5TFcqFekM021jkNvTXfLd7s/mdw4cdH6BGufqJJIz8XwvpGCA97P1
	C1lSQKqSrFQUWOwznY5Ln+Jw+8nsyF85vrbFw3osrs7GIiPDxpADov8HUXkqSrPfsjvzz4f7wL5
	gDudooHD7Ql78rpux6OX4h6MBH5ReloOQjAq3TQ7YNtFfX1q5Bso6rqbvl/hg0pCcIcuP5p0xaR
	33m1zLMe/xPbNwdLfN+mbV8LfePexBZHXvUm9dRWF
X-Received: by 2002:a05:7300:bc03:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-38281427c34mr5661563eec.39.1795055358638;
        Wed, 18 Nov 2026 18:29:18 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13958331eec.18.2026.11.18.18.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:29:18 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edubezval@gmail.com
Subject: [PATCH v2] thermal/drivers/armada: request the overheat IRQ before enabling the source
Date: Thu, 19 Nov 2026 10:29:11 +0800
Message-Id: <20261119022911.1493538-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118072339.1259719-1-shunsheng1218@gmail.com>
References: <20261118072339.1259719-1-shunsheng1218@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

armada_thermal_probe() requests the overheat interrupt before it registers
the thermal zones.  Devres releases resources in the reverse order, so the
zones are unregistered first and the interrupt is freed afterwards: a
handler that is still running, or that fires in the window between the
two, passes a zone that has already been destroyed to
thermal_zone_device_update().

Request the interrupt after the zone loop instead.  The handler is then
freed before the zones it updates, and the interrupt is only requested
when a critical trip point was found, which is the only case in which the
driver has an overheat source to enable.

The interrupt stays optional: a device without one, or with an invalid
IRQ number, keeps working without overheat detection instead of failing
to probe.

The source has to be enabled after the handler is registered, so
armada_configure_overheat_int() only programs the thresholds now and
armada_thermal_probe() enables the source once the request has succeeded.
A failed request then cannot leave an interrupt enabled that nobody
handles.  The source is masked at probe time as well, in case the firmware
left it on.

The handler polls its sensor once per second until the temperature is back
below the hysteresis, and devres waits for it in free_irq().  ->remove()
masks the source and sets a shutdown flag so that the poll gives up
instead of keeping the removal blocked until the sensor cools down.

Fixes: 879d7362d1d0 ("thermal: armada: add overheat interrupt support")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
CONFIG_ARMADA_THERMAL=y and CONFIG_ARCH_MVEBU=y.  No hardware was available,
so the removal path was not exercised and no race injection was run.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.

Changes in v2:
 - Request the interrupt after the thermal zones are registered instead of
   freeing it from ->remove(); Miquel asked for the smaller shape, so the
   helper and the stored IRQ number are gone.
 - Enable the source only after the handler is registered, so a failed
   request cannot leave an interrupt enabled that nobody handles.
 - Mask the source at probe time, but only on the variants that describe the
   overheat interrupt as a DFX cause.
---
 drivers/thermal/armada_thermal.c | 69 ++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 83672f95b011..23f820415e56 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -68,6 +68,7 @@ struct armada_thermal_priv {
 	struct thermal_zone_device *overheat_sensor;
 	int interrupt_source;
 	int current_channel;
+	bool shutdown;
 	long current_threshold;
 	long current_hysteresis;
 };
@@ -297,12 +298,19 @@ static void armada_enable_overheat_interrupt(struct armada_thermal_priv *priv)
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
-static void __maybe_unused
-armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
+static void armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
 {
 	struct armada_thermal_data *data = priv->data;
 	u32 reg;
 
+	/*
+	 * Only the variants that describe the overheat interrupt as a DFX
+	 * cause have this source; leave the control register alone on the
+	 * others.
+	 */
+	if (!data->dfx_overheat_irq)
+		return;
+
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
 	FIELD_MODIFY(CONTROL1_TSEN_INT_EN, &reg, 0);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
@@ -538,7 +546,7 @@ static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 		mutex_unlock(&priv->update_lock);
 		if (ret)
 			goto enable_irq;
-	} while (temperature >= low_threshold);
+	} while (temperature >= low_threshold && !READ_ONCE(priv->shutdown));
 
 	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
 
@@ -802,7 +810,6 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 	armada_set_overheat_thresholds(priv, temperature, 0);
 	priv->overheat_sensor = tz;
 	priv->interrupt_source = sensor_id;
-	armada_enable_overheat_interrupt(priv);
 
 	return 0;
 }
@@ -891,20 +898,16 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	drvdata->data.priv = priv;
 	platform_set_drvdata(pdev, drvdata);
 
+	/*
+	 * The firmware may have left the overheat source enabled.  Keep it
+	 * masked until a handler is in place.
+	 */
+	armada_disable_overheat_interrupt(priv);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq == -EPROBE_DEFER)
 		return irq;
 
-	/* The overheat interrupt feature is not mandatory */
-	if (irq > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						armada_overheat_isr,
-						armada_overheat_isr_thread,
-						0, NULL, priv);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * There is one channel for the IC and one per CPU (if any), each
 	 * channel has one sensor.
@@ -937,9 +940,29 @@ static int armada_thermal_probe(struct platform_device *pdev)
 			armada_configure_overheat_int(priv, tz, sensor->id);
 	}
 
-	/* Just complain if no overheat interrupt was set up */
-	if (!priv->overheat_sensor)
+	/*
+	 * The overheat interrupt is optional: a device without one keeps
+	 * working, and an invalid IRQ number must not be requested.
+	 */
+	if (irq <= 0 || !priv->overheat_sensor) {
 		dev_warn(&pdev->dev, "Overheat interrupt not available\n");
+		return 0;
+	}
+
+	/*
+	 * Request the interrupt only now that the thermal zones are
+	 * registered: devres releases what was registered last first, so the
+	 * handler is freed before the zones it updates.  The source stays
+	 * masked until the handler is in place, so the device cannot raise an
+	 * interrupt that nobody handles.
+	 */
+	ret = devm_request_threaded_irq(&pdev->dev, irq, armada_overheat_isr,
+					armada_overheat_isr_thread, 0, NULL,
+					priv);
+	if (ret)
+		return ret;
+
+	armada_enable_overheat_interrupt(priv);
 
 	return 0;
 }
@@ -948,8 +971,20 @@ static void armada_thermal_exit(struct platform_device *pdev)
 {
 	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
-	if (drvdata->type == LEGACY)
+	if (drvdata->type == LEGACY) {
 		thermal_zone_device_unregister(drvdata->data.tz);
+		return;
+	}
+
+	/*
+	 * devres frees the interrupt before the thermal zones, so the thread
+	 * is waited for in free_irq().  Mask the source so that no new
+	 * interrupt is raised for a handler that is about to go away, and let
+	 * the poll loop give up instead of keeping ->remove() blocked until
+	 * the sensor cools down.
+	 */
+	WRITE_ONCE(drvdata->data.priv->shutdown, true);
+	armada_disable_overheat_interrupt(drvdata->data.priv);
 }
 
 static struct platform_driver armada_thermal_driver = {
-- 
2.34.1

