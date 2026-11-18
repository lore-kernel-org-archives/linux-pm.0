Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986627;
	b=3w+Br/DggS6kZxnTMoGIPaFKDdBObdx0SQwAjYuMmajA8MPC1SjwgyNicMUq927yYa6C
	 T/PgQJxCjd7+CyhGDyyEV4MUhFsPbCNTp4hgy4ELqU7pwcsJoktCj71TGUcgw5bsW/bVy
	 QHBT2UE7ViwMTlgijs4TsEPUdi/2C2Hi3aJdUkBF7pTVJhwucWl3vf0HIpdxaKkRQTJxQ
	 m+RVltlCjbAKuxDmEsKSKjjokdXSk2+9q1XNGSVo5uGRD2WnNm33UWxrfcbmvUHREM9Zy
	 bheFKHB/rGUuZeUqeZBAVyQ5fwfFjRSTpwJr6pgvmtld8J2xJZkfUfRagEHzU0Mtkew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vQ2c++ctYVEsMIRs4ak0P2XeKQncytEGP/X4DLiiT8M=;
	b=Dx4Lx6FpW/udVe5+DH+bDeQKjXv1C1t4QQtxnLO83Eh7oYcjXufuomkG4j/McZs4NMoD
	 WTBEYQ5fmj3U0tGN7yREPL8K8Zn5WgpFLA7luCazdesRAVOTOpNM4B+oDinwg1QDR0lR6
	 0heM77q1CTb7O3RDFFYlhC1UvirhxSZZA5JloC3fHpk0zCHY9/kI4VjsBajobW8DfOOTV
	 Uep7a2te5gXwCUXsXcrGav6BA6SFfMbZiegPwHzmk/LYmKvI/oXRxrmNRvxZABNjbxKfc
	 CE7XtETlRQJXtxyWXQYhfjGVTbrsiQtMUh7wd2tBjgOQp79/iknXeFuV/BYtpJkr0hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsLSbPyL;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781D606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E781D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsLSbPyL
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cddc250d815so389760a12.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 23:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794986626; x=1795591426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQ2c++ctYVEsMIRs4ak0P2XeKQncytEGP/X4DLiiT8M=;
        b=jsLSbPyLLsW/Z6lk6LrfFzkL9mmQx+MaqKPcKHp04gITZ+j+BPmd/5kMLyUmIshOML
         yVvX4/Lu4PeX39hOzgO0WxGtb9YdjvBk0RCH4Scyhe/IUS2DblnhCdLYvyk1xUSTWLDv
         aaEvQK+hUQ8UiPU8PvtJiZK/HyUq+zWoGMXUL2nWcqlqmBURDM3JBa6MA2s6avZkNZIg
         G10zjtYjKslIUR7KEQIbOnoE4Wkz4q19MYXMJ53k9Bp9VrU6nzEfC3wMz3u5huZyxv8q
         MB+yXbAnCiNNtclwZswsch0W5ZBj0w2rIy6OYEJDCKNVQuiTkRTRqOR9MIEc+wWb3DMp
         aK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986626; x=1795591426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQ2c++ctYVEsMIRs4ak0P2XeKQncytEGP/X4DLiiT8M=;
        b=p9kKHqWMUdg0JdrZTX/G7DRAcsXNvElrxM8GcRjVlEWDxj4Nux7dSPKciVxIfPeZ10
         oEHR4VBxPpBLnuqFbSGihhEAdh852nvwCEOF76ZEVT4xqlauY1ZOB03MXJgwFSIjWFlB
         zN4yarFfKvt7eS9Zo6uXY+svmjYzi/DoeHTIDASXqbunbU0iegI16O/Nk0j2b0RHV8ek
         ScS8brHOWThGCs6D9aJ7mfgcbM6Gh6+rPevIYeZz0irrlgcs5MModLzr1+5jh57QVA+W
         8ktOH2no1/lxePEVXxpAq490VXbq2kOYt45rbhXPaKClccWcB/f1KPf0EfI6EMjtlhbw
         HgPQ==
X-Forwarded-Encrypted: i=1; AL+hErESXT53gK2nl84fwTk8kKpxi91JHV+gylsjcPiwAWnX+fGIMpKlsnZAJm7Q4ZHwkJZUnE/X5r+vZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/MTPEvvCvAi72PmNuTrSAcDCXi3IkyKBggsheyCESmhCKu1B/i
	zadqMi6NgOiRriPJEqIHfFTSCfIrYyTS3JIdPKzlecSkJQr2YMk2lSA4
X-Gm-Gg: AZFdTZdlLCnC+iDgx7ifrNUgKDqrf7wVi8Nj5g2Huyfv+D7B7QHShTA1eXYqW6eMAk7
	u0yLYvuC8jg/rB5rZN9zDTGPTFbTlWztvYoDR+AR5iIvYkPHG12919YDz5f38HCMCSXF6XA7tqt
	L+d2MLNStENwO7zcKMAfvunlIN1ihy1Lntoc9Wf+Q7MbjwTV5ZpUeKQXgYlv0Jo4PAH9tDwR5fu
	udPH/dGDg3i6uiPgSOnoxDcqyFZGppvN0G0wgL0d/r5G8XLBJxW6/FZR9mB6L4yVdbU0IPS99Kv
	AmrcHTpMPZY11mT9nh1WlYdGqjo38uEH/NjvSEZMeOoRPXXCxXExkHG2HK2ZP2TVkQjZ1m6SVom
	RRQRzan/YhadbWwMmfgOiOFkOowPtIuKf8ETOAwleIP0x8dFr+F8x73SbizeyJ0Tv+f5UxVM9lg
	SmS8wJamTofrPozPVTIvHan5v5/Ij9Ur1NEfHzYmLY8m/LqTPLPF6o4sAA+VxSJ3lHMbTR13CnC
	Js/LZFxlRfeXBAZbCWpN1frGT4vokX030eEmFMPd01EJlF4+Fvyt/tku6Xt/Y0UNMXw2fiJGxJZ
	gCuVMJvaEC3pebJjBU754tRV8NOUupC8nTKqJb0I9cA5Bb9TJG3bmqzxAoCvpKO8R4GpCsbXQWo
	E4hVEUEQ+yJVTVa43hgHA01GvrsdFU/ukQJn9B6j6XXWBX0f/WTdo6BBZPn5Tng==
X-Received: by 2002:a17:90a:d886:b0:3b0:9bfa:72b1 with SMTP id 98e67ed59e1d1-3b3d07caebemr2082646a91.49.1794986626214;
        Tue, 17 Nov 2026 23:23:46 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d5570208sm1046395a91.0.2026.11.17.23.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:23:45 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edubezval@gmail.com
Subject: [PATCH] thermal/drivers/armada: free the overheat IRQ before the zones are gone
Date: Wed, 18 Nov 2026 15:23:39 +0800
Message-Id: <20261118072339.1259719-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The overheat interrupt is requested before the thermal zones are
registered, so devres releases the zones first and the interrupt
afterwards.  armada_overheat_isr_thread() calls
thermal_zone_device_update() on priv->overheat_sensor, which by then has
been unregistered and freed, and thermal_zone_device_update() locks the
zone mutex unconditionally.

The handler also polls the sensor once per second until the temperature
drops below the threshold.  If that poll is still running when the
device goes away, free_irq() waits for it and the removal is blocked for
as long as the sensor stays hot.

The same handler runs while priv->overheat_sensor is still NULL, because
the interrupt is requested before the zones exist and a spurious
interrupt in that window passes a NULL zone to
thermal_zone_device_update().

Move the teardown into armada_thermal_quiesce_irq(), which disables the
interrupt, frees it and tells the poll loop to give up, and call it from
->remove().  The same helper is called from the probe rollback once the
interrupt has been requested: the driver core does not run ->remove()
for a probe that fails, while devres still frees the zones and the
private data of an interface whose handler is registered.

Read the zone once at the top of the thread and bail out when it is not
published yet or the driver is shutting down, and reuse that pointer for
both thermal_zone_device_update() calls.

Fixes: 879d7362d1d0 ("thermal: armada: add overheat interrupt support")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

Testing: compile tested only (arm64, gcc 11.4).  No Armada hardware was
available, so neither the removal race nor the poll loop were run.
 drivers/thermal/armada_thermal.c | 66 +++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 83672f95b011..72261338d744 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -68,6 +68,8 @@ struct armada_thermal_priv {
 	struct thermal_zone_device *overheat_sensor;
 	int interrupt_source;
 	int current_channel;
+	int irq;
+	bool shutdown;
 	long current_threshold;
 	long current_hysteresis;
 };
@@ -297,8 +299,7 @@ static void armada_enable_overheat_interrupt(struct armada_thermal_priv *priv)
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
-static void __maybe_unused
-armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
+static void armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
 {
 	struct armada_thermal_data *data = priv->data;
 	u32 reg;
@@ -517,14 +518,22 @@ static irqreturn_t armada_overheat_isr(int irq, void *blob)
 static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 {
 	struct armada_thermal_priv *priv = blob;
+	struct thermal_zone_device *zone;
 	int low_threshold = priv->current_threshold - priv->current_hysteresis;
 	int temperature;
 	u32 dummy;
 	int ret;
 
+	/*
+	 * The interrupt is requested before the thermal zones are
+	 * registered, so overheat_sensor can still be NULL here.
+	 */
+	zone = READ_ONCE(priv->overheat_sensor);
+	if (READ_ONCE(priv->shutdown) || !zone)
+		goto enable_irq;
+
 	/* Notify the core in thread context */
-	thermal_zone_device_update(priv->overheat_sensor,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_update(zone, THERMAL_EVENT_UNSPECIFIED);
 
 	/*
 	 * The overheat interrupt must be cleared by reading the DFX interrupt
@@ -538,13 +547,15 @@ static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 		mutex_unlock(&priv->update_lock);
 		if (ret)
 			goto enable_irq;
-	} while (temperature >= low_threshold);
+	} while (temperature >= low_threshold && !READ_ONCE(priv->shutdown));
+
+	if (READ_ONCE(priv->shutdown))
+		goto enable_irq;
 
 	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
 
 	/* Notify the thermal core that the temperature is acceptable again */
-	thermal_zone_device_update(priv->overheat_sensor,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_update(zone, THERMAL_EVENT_UNSPECIFIED);
 
 enable_irq:
 	enable_irq(irq);
@@ -807,6 +818,29 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 	return 0;
 }
 
+/*
+ * Stop the overheat interrupt for good.  Both ->remove() and the probe
+ * rollback after the interrupt was requested go through here, so that a
+ * failed probe cannot leave a handler behind either.
+ */
+static void armada_thermal_quiesce_irq(struct armada_thermal_priv *priv)
+{
+	if (priv->irq <= 0)
+		return;
+
+	/*
+	 * devres unregisters the thermal zones before it frees the
+	 * interrupt, because the zones were registered after it.  Stop the
+	 * handler here so that it cannot touch a zone that is already gone.
+	 * Tell the poll loop to give up as well, or free_irq() waits for the
+	 * sensor to cool down before the removal can finish.
+	 */
+	WRITE_ONCE(priv->shutdown, true);
+	armada_disable_overheat_interrupt(priv);
+	devm_free_irq(priv->dev, priv->irq, priv);
+	priv->irq = 0;
+}
+
 static int armada_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_zone_device *tz;
@@ -903,6 +937,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 						0, NULL, priv);
 		if (ret)
 			return ret;
+
+		priv->irq = irq;
 	}
 
 	/*
@@ -912,8 +948,10 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	for (sensor_id = 0; sensor_id <= priv->data->cpu_nr; sensor_id++) {
 		sensor = devm_kzalloc_obj(&pdev->dev,
 					  struct armada_thermal_sensor);
-		if (!sensor)
-			return -ENOMEM;
+		if (!sensor) {
+			ret = -ENOMEM;
+			goto err_irq;
+		}
 
 		/* Register the sensor */
 		sensor->priv = priv;
@@ -942,14 +980,22 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Overheat interrupt not available\n");
 
 	return 0;
+
+err_irq:
+	armada_thermal_quiesce_irq(priv);
+	return ret;
 }
 
 static void armada_thermal_exit(struct platform_device *pdev)
 {
 	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
-	if (drvdata->type == LEGACY)
+	if (drvdata->type == LEGACY) {
 		thermal_zone_device_unregister(drvdata->data.tz);
+		return;
+	}
+
+	armada_thermal_quiesce_irq(drvdata->data.priv);
 }
 
 static struct platform_driver armada_thermal_driver = {
-- 
2.34.1

