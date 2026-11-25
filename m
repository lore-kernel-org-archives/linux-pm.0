Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575827;
	b=IyV0UcH5rrDwD2uJw1ZyRCBvdW+4AZZjSskZyom7RaqJfo/+3QeQ95Z2/CyYfj8RAkku
	 33e/nZVBFKRcZt015epmmlSRmd76HDr9eoa6c5gQDa6BJR5scFdqFgN6uBvhSd0EM84k9
	 9oIlymlQZVZCSJ1IXGKMUl+EUpczJ5QrT++N7TfP4+YexI6HS5l0cnDBv1B/giaTahDJu
	 xhetv0xYJcIPuNSwyzcLDnZyuNrmQxaOWprlur4duYCjgSmsNmg4wv//XaX0lq26NgZYX
	 VYZJBfcpgyPTiPEpRlXGhmGx0bFNcgmPsCFSL52FubbJsTzGhhxL8LsSVyg1i/LeZvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Zu3Yeo2OLQkh3UXmT7WR67CwGlfanLBhnGcJEX5N8h4=;
	b=SRpzT1tJ8ToZfUzYrOrCxl6vy/3lshdQdc1lvs7uzC9lfOIcS52GAh/oR2ikckL7eph8
	 miy62L2NVlIDkVXGQNQLBZ+d5Q7MtgTmSIDl4yi2yTgmQZb8zAkzYIi0RduX5PSA2Uupb
	 +T0CV57GN9tcmP9wH16jy3wOn9z/F0wxnP1F4aKTifwPCxEtxAiWgusclB8HmdxcJOyBe
	 RobF0ZjpYY4I0DslluYqO9PbF8RJtdf1u2+h0IPdOBkEJSermH9SdAPUt784OfSlftckw
	 SQvOKs6a40q3BBsDtOptQSUiLROHQoD7mZT+kUAAHcul8qSy1vKbpg3hT6cpRrK+6FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FEsg4als;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84289606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84289606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FEsg4als
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso11299784eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575827; x=1796180627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zu3Yeo2OLQkh3UXmT7WR67CwGlfanLBhnGcJEX5N8h4=;
        b=FEsg4alsigq8zQuBxvor29owXsrk3UL7lHGkrGfoP98bwya2+CG5WDD4PTJS6DfeYs
         AqVxAxYInZvn4JuW0oweFyU1yRT7Q7CRV1uvZ4zKGakKwMjr0DGdlp03GWAGByQdRSD0
         CmnjkjdUXabNkhx3cL6Y9/JW3zIlrOOg4vaTbVHK2z9VcPZZeb9zJgUD7sKikTU6vdTm
         EwsuiLXCJ0Hj+FJiXiTDqu+54kfWtiM+w+oLHdKQzurA2+uKdInIXnq0ypS9lHdEJVRU
         NCFWb+2x7/a8i0A3wTI5sZuWE3qKo5Nc+77wnkVzmgENdSCknAXdIu1s9/oq09RY0Odp
         8dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575827; x=1796180627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zu3Yeo2OLQkh3UXmT7WR67CwGlfanLBhnGcJEX5N8h4=;
        b=Py4jvksOLtoc+CUdGBYKF8ZlXD2pW91B7eT7gYfnbBoHGLQ/tH4aHceq4ib65qIKe+
         SVPdpZDHRuIBIZ+/y85mH0/I3NpsWvMjSn52BQqqh3barJYG3yGxv975pKpsp5E7cBFz
         IYoEuw6ilMnPGwHGMV8vNNxLINAQ8wvFshW0m1nOjlyxJ5CoVlYnw+L3VaTAlBckYFH0
         7hzBM1MCmISwZIR6B2RdliLWG/hDtbx3aehvKRGXT3Rve0sb2rhFYRF5e2mfJ8tmSidk
         lQAaYRyKeN77LdhlSUZ/xrp58QnUvumOqWFwIFPo1GWiH99NvvvruaSOWpRRy9ppaoAq
         T4RA==
X-Forwarded-Encrypted: i=1; AL+hErH0ABpV846ntRziwpAm9/y2YPJkBYp88a10BXghidbglG/l3WFDfJvtFLuaNyVjcv6VUf9RCRSPWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9hU1CTQsnYFHk6W+6aecjV2gqpnDcsh4lTGdzPTPDMhiaoEJue
	JUH5RwOaaGubvfLidttbIL3fO5uO4M0vN+PFr7G64c0k/TNnpSvZLOD0
X-Gm-Gg: AZFdTZcJMv28BH/yHsdIjcXTZjcajPIhiUowI5FZf0OtqatOPsAATyKrCuuVA4365wp
	ErklRfcMdwxlycqHeeQgD7XVhc64ZHU21otiSow1yfgsOqJMdMdHirsP9P0M9cm6z/EpQV1kyqo
	J5zecB6HDZQ6DR50Wk+g/o03oo93rDTMHj/p9eLtxJc/9rwk21IK3RoPj3zcvuvC6C2sdg4BGuQ
	YiGts1Nzo3Q6YTrmfEYHm+13NOak4StRkv41XKAr68Cu9cxbFPLHvx/6uW7a6KuwWjzsbntKQfq
	piKxCdhpumayeXrFP7MvitOeZ5V52bTf+3tJjQfUR9v4ZK7hjqKHB9xy62mHyvTkyvNLDC5J0p8
	CdQi9VurV3/afKuss7DWRfS8cEK3YPF3onW2cEJ537eqQcfsZCCLiNEhNOscqV7r3yFlmlY0d14
	duYp5wtBcK+e9hEeoSSazeqenXh9AP7dzZute0DX3wfCFJuAucqz6aMwGVbyVvGo3ghuThdlVjy
	VgqgRvqAwbo0U9IqtkrXwVluTN04+BJGBrTrw691N0IcGSrnL4HNcljo5LLtd6dto/K5flTNIxo
	+JvifClNLS4AnciJGm81SFxxq9Nzj2uH1GP57lrHPPqNHby+JuO/cqIlKLsXi+3sf/WPa19/NCF
	Ay2BsbEu+utbYUSRwPTR/Z+3AUE5lsLTD/WKvgnpyNgmRGts5
X-Received: by 2002:a05:693c:41d1:10b0:386:9d4b:9403 with SMTP id 5a478bee46e88-3869d4b9723mr12768057eec.19.1795575826354;
        Tue, 24 Nov 2026 19:03:46 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm52243475eec.14.2026.11.24.19.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:03:45 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] thermal: rcar_gen3: do not enable the interrupts before the zones exist
Date: Wed, 25 Nov 2026 11:03:27 +0800
Message-Id: <20261125030327.953450-4-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125030327.953450-1-shunsheng1218@gmail.com>
References: <20261124095110.131258-1-shunsheng1218@gmail.com>
 <20261125030327.953450-1-shunsheng1218@gmail.com>
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

rcar_gen3_thermal_probe() requests the interrupt handlers before the
sensors are initialised.  Once num_tscs is set, the handler can access
the sensor registers while sensor initialisation and thermal zone
registration are still in progress.

The handler checks whether tsc->zone is NULL, but this does not prevent
it from accessing the sensor registers during initialisation.  Masking
the device interrupt sources alone does not prevent delivery of an
interrupt that is already pending.

Request the interrupts with IRQF_NO_AUTOEN, so that the handlers cannot
run until the driver enables them, and initialise every sensor before
the request.  Enable the interrupts and their sources only after all
the thermal zones are registered.

rcar_gen3_thermal_resume() re-initialises the sensors and the sources;
the enable state of the interrupt itself is left to probe.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
CONFIG_ARCH_RENESAS and CONFIG_RCAR_GEN3_THERMAL.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 53 ++++++++++++++-------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 37348f4413b6..e6682c5759aa 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -326,8 +326,7 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 	return true;
 }
 
-static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
-				   struct rcar_gen3_thermal_tsc *tsc)
+static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 {
 	u32 reg_val;
 
@@ -337,11 +336,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 
 	usleep_range(1000, 2000);
 
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	if (priv->ops.set_trips)
-		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
-					IRQ_TEMPD1 | IRQ_TEMP2);
 
 	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |= THCTR_THSST;
@@ -350,6 +347,15 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 	usleep_range(1000, 2000);
 }
 
+static void rcar_gen3_thermal_enable_sources(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < priv->num_tscs; i++)
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
+}
+
 static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen3 = {
 	.ptat = { REG_GEN3_PTAT1, REG_GEN3_PTAT2, REG_GEN3_PTAT3 },
 	.thcode = { REG_GEN3_THCODE1, REG_GEN3_THCODE2, REG_GEN3_THCODE3 },
@@ -523,7 +529,8 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						rcar_gen3_thermal_irq,
-						IRQF_ONESHOT, irqname, priv);
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						irqname, priv);
 		if (ret)
 			goto release;
 
@@ -555,9 +562,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	priv->info = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, priv);
 
-	if (rcar_gen3_thermal_request_irqs(priv, pdev))
-		priv->ops.set_trips = NULL;
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -596,10 +600,20 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	rcar_gen3_thermal_shared_coefs(priv);
 
 	for (i = 0; i < priv->num_tscs; i++) {
-		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+		rcar_gen3_thermal_init(priv->tscs[i]);
+		rcar_gen3_thermal_tsc_coefs(priv, priv->tscs[i]);
+	}
 
-		rcar_gen3_thermal_init(priv, tsc);
-		rcar_gen3_thermal_tsc_coefs(priv, tsc);
+	/*
+	 * The handler walks the sensor array, so every sensor has to be
+	 * initialised before the request.  IRQF_NO_AUTOEN keeps the
+	 * handlers from running until the zones exist.
+	 */
+	if (rcar_gen3_thermal_request_irqs(priv, pdev))
+		priv->ops.set_trips = NULL;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
@@ -620,6 +634,13 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		dev_info(dev, "Sensor %u: Loaded\n", i);
 	}
 
+	if (priv->ops.set_trips) {
+		for (i = 0; i < priv->num_irqs; i++)
+			enable_irq(priv->irqs[i]);
+
+		rcar_gen3_thermal_enable_sources(priv);
+	}
+
 	return 0;
 
 error_unregister:
@@ -633,11 +654,11 @@ static int rcar_gen3_thermal_resume(struct device *dev)
 	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
 	unsigned int i;
 
-	for (i = 0; i < priv->num_tscs; i++) {
-		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+	for (i = 0; i < priv->num_tscs; i++)
+		rcar_gen3_thermal_init(priv->tscs[i]);
 
-		rcar_gen3_thermal_init(priv, tsc);
-	}
+	if (priv->ops.set_trips)
+		rcar_gen3_thermal_enable_sources(priv);
 
 	return 0;
 }
-- 
2.34.1

