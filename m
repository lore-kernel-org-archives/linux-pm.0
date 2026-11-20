Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795148856;
	b=bsU31PwfZrVwQ+CXUX3cuOkvihHv4CE4hik9/OYofI78kvhKLaRS+c1SyEVItg0oXs8E
	 N/tqc/lDECR6mZ5OLpdrb7GLuT5226reJKfZNJhUT1nuoCrviIa8xECS6kbSPjoPmwAWi
	 Qtt1C5hM5oBueDElraff+dBZlpre/NgxtmOtXIPdXFV057Zn/IBWIs9H6Vb/I9ob5EzQc
	 NzO4cqDI+TRTXeWJzTyPmUFUE5cFCX3OoZxBifo8XbAZa9CzaSr9LfeSoVyQSbvN8TD3s
	 5JNX+vsiFU7IDR6Mr0g3PQpSKYliHklHlPr7ID9wQLx2eeBtdqMjGGO8ifQ7cCKdtfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795148856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hem28UIpo5xvSwY95FHiT3Wbk82MMv1kpFc0Qx2vjCk=;
	b=riO04804UMAfA0f4dlKVJyYSmO9Dt62pbl8nTFSlf715bSylUquj59Df7ZzF4NdUrZsd
	 PW6Yhy+4X25VxtUoGJrnH0QHlFNYiB4AZFkshhPc28QOQv7FNQTg/dmQUn+VV15RMoLIC
	 jtaDjdXC14XLdQHUMJgNNryfXfIDZN7RmfbXX4x1b3KvkHv6S4o23g86xNhLNI7bHxImo
	 u5kgiMnie5jwgaRKoTN+E5FqRgUA2hmHlG0TbaMQW+QSu7FKTlxdRtMa3ohjYfgtwC+JD
	 p/kG8yCewybH6zKObABIRPHrQQwSZ/ka6iFbAlXXIiIPNUU8e1smnDjNDGhpRYYQBtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EuKrq/5Y";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D1606A326
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 04:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EuKrq/5Y
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso415486a91.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 20:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795148855; x=1795753655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hem28UIpo5xvSwY95FHiT3Wbk82MMv1kpFc0Qx2vjCk=;
        b=EuKrq/5Yr8MMWEOZ0jC7v/HVaK6TF+iO0Da5ghamm9rrNRnY/iifFf1c5LyvOYk7cJ
         UjhIC54IXutVj1Sm2KiBnRELkL9NQhnxXjDs2M7AXYH0taulzltM5YZkfPu2vzV9o5cc
         9RxyGHc+8ddheGol9DoBsO3Eiy+8DKJMeZB3HDRXAgbz6KPRx8ePX5IG0oGUrXZNg7u1
         xGDoDcVHlSJhAuciaczKiFyiEDpEgbmPQe9nddylNrO2EENscuzOFoXpibSh0lqQCQO0
         5gX/AAF3YfwlFDYSP5ggGg+4gnkSCFzRcxF8DH2WLkgQd2vSw8xAIn4re3s9lE0VUeRv
         P3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795148855; x=1795753655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hem28UIpo5xvSwY95FHiT3Wbk82MMv1kpFc0Qx2vjCk=;
        b=mneHSiymi5Vlgm7mQtJYcUZvt8gIRxZMxrHc7R3HB1kb11j9vjczehPztDRyNh22mj
         sjatE0zGVfG1iQlfmqMt5qOqkbOJpkinM6JKx3pl3P7IQji9dMZVq6KWv4oIfx4MdN88
         ptRueJTccvthkTUYlgwdmkzFeud6RLtd1A42kNI7SfhQtQeQuMJ0RgpKHi1W0pYHd3X4
         PE/eNi0KHeUPQnGe9eiG9vdZtJD8klMwqiY+g6JWUZIehf5pqnEQnXx3SSEhMvpi8zbs
         bs41g0FPvsureFipmpgc5c9a0NPc0l38e1CPo4VqyFGjbeKyfOgODPIgNslxol0203Jx
         DQlA==
X-Forwarded-Encrypted: i=1; AL+hErFWwrWXv0D/z/BXUdLNT6lHYKXv4aTMGPB7EZz7i4MCMCNMoT7uIEYGgE1N5NhgezN/3Q8n0qbP/A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8s7CnnMQtvikgTKkAjc1YhAmIOYUdVvifbYeK3851I7GVj/ChM
	BqaPbFEV20Z3YCT1w24tI6GOqghpTWBLxNCg1TLsDf36tPE6ct3J/Rq1
X-Gm-Gg: AZFdTZe/TGQzzXn23M3S21jyqCJLQ6Lxxm5MT662ZwAVhVnwi6KdKUO+w5XuSmdGqdf
	65Wpcf5gp1zcA7TNalEcyZCGQXGR2WY2g1cKIh+pcTF6C6ReHgvpYTU+Ap6lNqHZs/QeGlYMdRk
	29+ETZ6nAsgqjzBxCZU8uK0uU1yhOUUrVAY2/UGEQHe7f4sf5OYp8sdaWFNOWlujhf5BZ621JNJ
	ejusku2rNfzBlGEBNvfbQwVbz7032jPL94Va5OwboJ0ENqaxCTBbCbEVEpU9tO4owik5xsr9XhW
	XgJ5KKKHZXfKEbfTlXI1knQINarBGospbVYNc6sFw8iSwbE+4gvDp2wksJXn6itYL+aY2mx3wtP
	33rCTYtNe7Fr2x8huZT3wSKCVbRxhqv1GGOJbeyv8mJGrHBSPi5EB2hhkHmykr5T2p/Fr4XCo4u
	MGAJpRgdfeYaXA/0vTWiQzTJrX1n5MKwSgr2mBHCRrb1tLRv6bFpBV66zBEJvs0c8If1dnqvlPA
	y2dKLDhsCfrQJFcCuTGYzxLq5qd28B9TAvR5jkBHZzuJ4GToONkPd8EuiZMGmDplQaStduFUu4q
	aCB/+rhBqC9135/K8YoezmL/si5vjBlzQGegZuC1jB+pGPnVqaE4frDdRRE+zMEwfal+dw0CWf6
	PEQGBYPCaCoKjMnTrRQv3YvfQlLgOp+AI5feHOMAogDIPa7E=
X-Received: by 2002:a17:90b:2fcd:b0:3b3:c2d5:cb06 with SMTP id 98e67ed59e1d1-3b41c9543e2mr1557624a91.38.1795148854907;
        Thu, 19 Nov 2026 20:27:34 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0457fd68dsm2401545ad.39.2026.11.19.20.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:27:34 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] thermal/drivers/armada: request the overheat IRQ before enabling the source
Date: Fri, 20 Nov 2026 12:27:28 +0800
Message-Id: <20261120042728.420697-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87o6bldqjo.fsf@bootlin.com>
References: <87o6bldqjo.fsf@bootlin.com>
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

The interrupt stays optional, as before: apart from -EPROBE_DEFER, an
unavailable or invalid IRQ number does not fail the probe, it only leaves
the device without overheat interrupt handling.

The source has to be enabled after the handler is registered, so
armada_configure_overheat_int() only programs the thresholds now and
armada_thermal_probe() enables the source once the request has succeeded.
A failed request then cannot leave an interrupt enabled that nobody
handles.

The zones are now registered while the source is still masked, so the
driver masks it at probe time on the variants that describe the overheat
interrupt as a DFX cause: a firmware that left it enabled would otherwise
raise an interrupt that nobody handles until the request below.  The mask
is released when the request succeeds.

->remove() masks the source and sets a shutdown flag so that the poll loop
gives up instead of keeping the removal blocked until the sensor cools
down.

Fixes: 879d7362d1d0 ("thermal: armada: add overheat interrupt support")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
CONFIG_ARMADA_THERMAL=y and CONFIG_ARCH_MVEBU=y.  No hardware was available,
so the removal path was not exercised and no race injection was run.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.

Changes in v3:
 - Keep the IRQ handling inside an if clause instead of returning early on
   the success path.
 - Drop the DFX source guard from armada_disable_overheat_interrupt(); the
   check sits at the probe call site instead, where it tells the variants
   with a DFX overheat source apart.
 - Keep the probe time mask, ahead of the zone registration, so that a
   source the firmware left enabled cannot fire before the handler exists.
 - Drop the two long comments and the paragraph that restated the existing
   poll behaviour.
 - Say in the commit log how an unusable IRQ number is handled.

Changes in v2:
 - Request the interrupt after the thermal zones are registered instead of
   freeing it from ->remove(); Miquel asked for the smaller shape, so the
   helper and the stored IRQ number are gone.
 - Enable the source only after the handler is registered, so a failed
   request cannot leave an interrupt enabled that nobody handles.
 - Mask the source at probe time, but only on the variants that describe the
   overheat interrupt as a DFX cause.
---
 drivers/thermal/armada_thermal.c | 46 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 83672f95b011..859e2f9da1c6 100644
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
@@ -297,8 +298,7 @@ static void armada_enable_overheat_interrupt(struct armada_thermal_priv *priv)
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
-static void __maybe_unused
-armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
+static void armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
 {
 	struct armada_thermal_data *data = priv->data;
 	u32 reg;
@@ -538,7 +538,7 @@ static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 		mutex_unlock(&priv->update_lock);
 		if (ret)
 			goto enable_irq;
-	} while (temperature >= low_threshold);
+	} while (temperature >= low_threshold && !READ_ONCE(priv->shutdown));
 
 	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
 
@@ -802,7 +802,6 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 	armada_set_overheat_thresholds(priv, temperature, 0);
 	priv->overheat_sensor = tz;
 	priv->interrupt_source = sensor_id;
-	armada_enable_overheat_interrupt(priv);
 
 	return 0;
 }
@@ -887,6 +886,15 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	priv->current_channel = -1;
 	priv->data->init(pdev, priv);
+
+	/*
+	 * Mask the source until the handler is registered.  The firmware may
+	 * have left it enabled, and the zones below are registered before the
+	 * interrupt is requested.
+	 */
+	if (priv->data->dfx_overheat_irq)
+		armada_disable_overheat_interrupt(priv);
+
 	drvdata->type = SYSCON;
 	drvdata->data.priv = priv;
 	platform_set_drvdata(pdev, drvdata);
@@ -895,16 +903,6 @@ static int armada_thermal_probe(struct platform_device *pdev)
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
@@ -937,9 +935,18 @@ static int armada_thermal_probe(struct platform_device *pdev)
 			armada_configure_overheat_int(priv, tz, sensor->id);
 	}
 
-	/* Just complain if no overheat interrupt was set up */
-	if (!priv->overheat_sensor)
+	if (irq > 0 && priv->overheat_sensor) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq,
+						armada_overheat_isr,
+						armada_overheat_isr_thread,
+						0, NULL, priv);
+		if (ret)
+			return ret;
+
+		armada_enable_overheat_interrupt(priv);
+	} else {
 		dev_warn(&pdev->dev, "Overheat interrupt not available\n");
+	}
 
 	return 0;
 }
@@ -948,8 +955,13 @@ static void armada_thermal_exit(struct platform_device *pdev)
 {
 	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
-	if (drvdata->type == LEGACY)
+	if (drvdata->type == LEGACY) {
 		thermal_zone_device_unregister(drvdata->data.tz);
+		return;
+	}
+
+	WRITE_ONCE(drvdata->data.priv->shutdown, true);
+	armada_disable_overheat_interrupt(drvdata->data.priv);
 }
 
 static struct platform_driver armada_thermal_driver = {
-- 
2.34.1

