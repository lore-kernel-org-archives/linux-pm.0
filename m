Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030493;
	b=1Kj+XOdMV5QNJuz3LF1k7RCqhFCLirnjNNG3+5JEi/v8d84iWQDZBq+JtkamPEKuv85A
	 YC0loR22CLol6/lTByQTqaRbhXkfWPL+Mdwk4P3AjsFM7xUfYdDF8Q3HFCwQ/CHQVoZ9H
	 Vs4NSjs3ccQTcWhT2ukLZ7Ez/SkbQ8EQKhO2gBjVP330UJ/w1rqWaJBtsKnN+w1EsSiLt
	 BdCAZyq9cxc3DzRWYpNgteQdTTfWMciPWxdMEtMXk/3aACe4s1u8HJGTHcmPUbKvaeAJN
	 Dltwd3es8tookogh1cf6c7iNcX4sTE5P6TQrCRWGqXKfvajM7Uw0ByByinX8v6O/lwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HWaT+wPpmTfJJ1DIQuA8Cru6WQxlbWyH1qkN23llu4Y=;
	b=a2/4dkhDIt2ElIVqsOUTtivvfD4DvPvI0XLZr76wgG1V4N4Skx3jSnDRbgTc85DGf0Rw
	 d/UsKEnGDNsut5j58+bT5Ljn7Gpjpv23F4qZkYe+OO2EV01gOYmoSPn0aOc6ulWNADlB9
	 yMNCZXkginMgN9EeWpJ7Dw2SamMN/BXN3f+VCub+4/Zxx6YI56IUOfzUpTn8a/88nfzfe
	 3tEm8oH6EBsvRxWLjV1ifq69ukM14/PxTjEdA4r/kWNZaS+2ORu24xTwbO4GIaAMirp8i
	 zcxEfjcjSbR0UdLJ1HPt9IFSOZjq60D6wSjyHQhqmxQCSFzjEfPCUg8XP5St1lTf4GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FAklovfO;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38C606A33C
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A38C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FAklovfO
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so5371685a12.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030489; x=1793635289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWaT+wPpmTfJJ1DIQuA8Cru6WQxlbWyH1qkN23llu4Y=;
        b=FAklovfOmzD1Z1Gf319Ep8DxnBvK9Cqnnye+n0R/lnq0IBkWsbGdt5Vg53su4r0nPK
         0vwLx1aXQooGyE0y6S0qt6QR4XaKX58fCSOMQkf5J1+4vueIrb/ig3uSZL0ksv6j0Ry7
         eEFt/Cll8in8pjG/gOYNxBg/+wjZ/qFipgprQfP22rZPCBj7c/JlltSo7BUvOFElNGFp
         xHlvQxDTTW2iDvInkjSPTcVFbTLoGaFK73DPHjt88x3ASKZn1mfPHxJlJH38IBoFtRMP
         Xgk4fSZnphbgbOD7bz/w1+B7CH8cscrmgEYjpMK5TkVPj53o1c7JCr+KLB8FIYZPpESy
         EvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030489; x=1793635289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWaT+wPpmTfJJ1DIQuA8Cru6WQxlbWyH1qkN23llu4Y=;
        b=befFE1qaWZ2lAswvoKXHUzjsWbg++wlLcN03QRQKMJONcmypb8uUFeaxXzZsjq8doA
         K+l/cMPUTuRlAHVJl4QVcLIadfJXPlIVV1x5ugati2rHt8vQv81D8XXTZIBLGoxGFMyp
         lVsmDpuf7YzBW+WdSuWYOmFoWhgzt4djq4A0OtlqW2QuCn6q6RDP+Va1G4i80rmYd3P8
         epp3B3E/xWDB28gQEMeiU9s2mwUeWEDbNawdx7YH6SDn9QkJW6fJcDskQMPpFTI9G7Ux
         22qzjYJZEw70J3nK0Jv9EJe+1X9d3xLVkvDco3hOg3cCJGTcfp0uODXc7TW9+ft5c/gC
         RsnA==
X-Forwarded-Encrypted: i=1; AKwUvBwA7nGMuiQhPqhz9QPvnaRs+AV+Okt3fOYZSVKU/pfOnLBVLBLn7DX4Fhu9WIYAc/Net6vaeiTwQQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKSqHrX/MHcYnMaQo/sH/wvmAlFGmIiQyYihR6792StNsA+COAN
	61ncPT0GvFcufgaEj80dX/6rBZyZmXsdxH5GX5cB4QaNGzxsiH4h2IgqgKfmNf6FOVM=
X-Gm-Gg: AYBFou0Rzcy/tGjBK46AddyBxsHgN5u+1a/P8Kq/ftj6PvEtJ3ZWGxM5KoAUd3lPZYZ
	9AXb6dkelM5vh+Cvg8mmCrw3pPmPqyuG7xZKMKoKVuDUxWu4627G5kvNFUZlWBS3a0cHUOIbTw5
	qft26OFUcU9gzZ21NlkKCcn/5Y3ACbK2tJZmfRGM+RRi0GXz3KRJorFjmQwk1J0FNfSXgx6G1aC
	ckuOA/S6cGf9etRbKuNzYhpwpa3crPcn4PFKEidilmI2nHr+E2gt+YUJsK5BeVbknY9kZmGQmfF
	02YzCxgG6xuyqZWN9FRsVorP6IF2ycGbmiqPzhBKPJuUMZ2SHOS09xyKUo6IVMiJj3yHuRMrQyI
	JiYDkOQvudw+OKIOZNABoj0hYs+bWHDGGKBYAvVqxX9N+TYoNPTYKSJZtvl0ytfRGef2Ls17aS4
	sE/L3CKDtRhpskNaW47HdKn7t94zfZmqLMq2tMLvOKt6dvJBYbJWuAgPXaDzCsr/fkLwCcRKA2q
	/2fXhOnSNB3YEeGfdR6ipyi8OhkB6sOWLvC+GM5GUKWNidi5uZ2uuVbpMLakgowV1BNndskEETf
	DJtz4zOJXWtMovjnwS4YZQZ64WHb28pGKaPPQkmTsSKJrFaWjCx7J9cijf+lLlGcF1WAzvbrHYY
	tb6H5qVm+2Q==
X-Received: by 2002:a17:907:3ea1:b0:c41:b4e4:7958 with SMTP id a640c23a62f3a-c46bd95983emr863865266b.0.1793030488581;
        Mon, 26 Oct 2026 09:01:28 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:28 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:23 +0000
Subject: [PATCH 06/15] thermal/drivers/samsung: acpm-tmu: Rely on devres
 for probe error and remove teardown
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-acpm-tmu-fixes-v1-6-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=4225;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=IJeXySMGcYifUwBq633Cferss1iIcf0iRvDQk01LEvI=;
 b=hYIgikztdPaJbrzUwRxNl8rAWnP8eNJqKC6JvSPvy4S9fPCi5C3d1Q6+OnF91mTrK6fBTrreF
 T4AnaiUwDdjDqxmKUH8Rck13WpJ6EtVUR2R71anCWahkYFYvQsA+hGd
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Disabling sensors manually on acpm_tmu_probe() failure or in
acpm_tmu_remove() happens before devres unregisters the thermal zones,
leaving live zones backed by disabled hardware.

With .change_mode() implemented, devres tears down the IRQ, thermal
zones, and runtime PM in reverse registration order:
devm_thermal_of_zone_release() disables each sensor via
thermal_zone_device_disable(), and devm_pm_runtime_enable() disables
autosuspend and runtime PM.

Drop acpm_tmu_remove(), acpm_tmu_control_rollback(), and the manual
teardown in acpm_tmu_probe(), and switch acpm_tmu_control() to
pm_runtime_put_autosuspend() since pm_runtime_put_sync() was only needed
by acpm_tmu_remove().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org?part=2
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 56 ++++----------------------------------
 1 file changed, 5 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 69793fce3bf1..4257bec802c1 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -153,26 +153,6 @@ static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
 	return 0;
 }
 
-static void acpm_tmu_control_rollback(struct acpm_tmu_priv *priv, int start_idx)
-{
-	int i;
-
-	for (i = start_idx; i >= 0; i--) {
-		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
-		int ret;
-
-		if (!sensor->tzd)
-			continue;
-
-		mutex_lock(&sensor->lock);
-		ret = acpm_tmu_op_tz_control(sensor, false);
-		mutex_unlock(&sensor->lock);
-		if (ret)
-			dev_err(priv->dev, "Rollback: Failed to disable sensor %d: %d\n",
-				i, ret);
-	}
-}
-
 static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
 {
 	struct device *dev = priv->dev;
@@ -199,7 +179,7 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
 			err = ret;
 	}
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return err;
 }
@@ -489,7 +469,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 	ret = acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);
 	if (ret) {
 		ret = dev_err_probe(dev, ret, "Failed to init TMU\n");
-		goto err_pm_put;
+		goto out_pm_put;
 	}
 
 	for (i = 0; i < priv->num_sensors; i++) {
@@ -510,7 +490,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 			}
 
 			ret = dev_err_probe(dev, ret, "Failed to register sensor %d\n", i);
-			goto err_rollback;
+			goto out_pm_put;
 		}
 		sensor->tzd = tzd;
 
@@ -522,39 +502,14 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
 					acpm_tmu_thread_fn, IRQF_ONESHOT,
 					dev_name(dev), priv);
-	if (ret) {
+	if (ret)
 		ret = dev_err_probe(dev, ret, "Failed to request irq\n");
-		goto err_rollback;
-	}
 
+out_pm_put:
 	pm_runtime_put_autosuspend(dev);
-
-	return 0;
-
-err_rollback:
-	acpm_tmu_control_rollback(priv, i - 1);
-err_pm_put:
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_put_sync(dev);
 	return ret;
 }
 
-static void acpm_tmu_remove(struct platform_device *pdev)
-{
-	struct acpm_tmu_priv *priv = platform_get_drvdata(pdev);
-
-	/* Stop IRQ first to prevent race with thread_fn */
-	disable_irq(priv->irq);
-
-	/*
-	 * Disable autosuspend to force the subsequent pm_runtime_put_sync()
-	 * inside acpm_tmu_control() to synchronously suspend the device
-	 * immediately, preventing clock leaks when the driver is removed.
-	 */
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	acpm_tmu_control(priv, false);
-}
-
 static int acpm_tmu_suspend(struct device *dev)
 {
 	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
@@ -648,7 +603,6 @@ static struct platform_driver acpm_tmu_driver = {
 		.of_match_table = acpm_tmu_match,
 	},
 	.probe = acpm_tmu_probe,
-	.remove = acpm_tmu_remove,
 };
 module_platform_driver(acpm_tmu_driver);
 

-- 
2.56.0.257.gf7497c7d27-goog

