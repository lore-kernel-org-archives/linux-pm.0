Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D835E1DC
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450239; cv=none; b=LEH2vwmcWbKppi1Frjszqa+u+Wl/qrhrx4DLVl9Ho8k0Gxg5vAdLpfT7nGNhutzzeF1DZ6opiqqVwVs2rLmKGMYq+LxvtFouFysMWc4Cq/wv1tT47mSkJnvz91IsJkRBeKDtoBt8qUeDNXZVPFgAFCTXjBprinFLzZ3zV+Rlzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450239; c=relaxed/simple;
	bh=yC/gGh4fjQ/sj7lFfE+M0v7xx0GKo8ofyflPQ+Uh4/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3JAr1/ALbQWRjFqcO+q98/jid7toCSA33fFdXZK9DB3knotqnCYN8zVYC3LRD16slHjBbP3NogDsWp4ZVDA9TQQH5XuEGHcylGXJMMd797t9MKde6jypoOIh2ThQypis2k9R00j+Vn0dH2DAJQcEWm7VGpSk4EuqO+G20y8Q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpwSVdvh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpwSVdvh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ce3876a50cso34380416d6.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780450237; x=1781055037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqcRE4ZV9h59aWUDKIwLPgkTSVEiGSZVcumouuNOvKo=;
        b=WpwSVdvhWTEUEO54EzQjpwWK4tTzR9i0x1kZvXYM/lLvV8rrdMm6NobROY75L1Z0mG
         CXu9BigTYxJlRF+F9VAKGGC22s5kBSJMZwDMj/F0UL6FgHxClJTVkSkS/C/rEksxGrhk
         bP+ptAJeb2W06f6J539twecKicWOpDi8k5kPZPym25qpo0Y0m/BCiTzNYChqgyKdv8ys
         6vcc6wahLWddsAP4hgkr+mlIm7bzKRBqPFYy46iEHo0CWXbjPMwu/caytuIb1HSsxGcL
         fVgaG+bXDxS7dATgNfqTA+faGo6kzU5TuK5RsqdGrdUdQkvz55JqOPbqsj/KCOS/KtgS
         ix0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780450237; x=1781055037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqcRE4ZV9h59aWUDKIwLPgkTSVEiGSZVcumouuNOvKo=;
        b=lrVd2CuLeE3PnwrXaNr6x503wGHvrt43m8gbdYBq6hO8bOCMjZW26DdKiQoh+MOXAZ
         OugftlLvLRjVP8HlMJAqMxUacdsInudYTcqIdaVTg2GNzLZSAkj72K+A81MgUgIL4ZUS
         YAhGVPkexh6yk57PSrXeKkJx3dYNE2DuHN/ZlnSXCaumamEyXt79kzqk60d0gPfJSgCC
         kO+5xdCgSm0K61qM+N5cyjwrCZsO8tHkPdxQJRTL4gVMKyTgpJP+eBF4wcVRaWGW/zqL
         otBPNjvv6kYu/VEJJUqd8vvgV5FC04dvvDRWiSjJ7lORpD2sCbIUvqAOH7+NOrhb8s1L
         Wcqg==
X-Gm-Message-State: AOJu0YzCZ3nbYkjXZ1EZxUF2uzdXTb7I6Uxlm3LgGocjtTrvIcJ/pw7N
	av1tO61OBZtvCULvFsAP/Fatpry8yL16bRSkEGAv9IJqrY/Y5/n0QebEV5wQ4R1B
X-Gm-Gg: Acq92OF0iyV/2kb3yCEvQHmfwqZZY/ghbvVoy5MyhZ7q2EQ+L3lNv2W8NampZs2Fjq1
	aYGWJcskDD+6nE8n1YNEnWGbYXPBJn0pyMwWVqwOwVg1X5ftncOvDAa1jTRC48RrAVdHWXqSqRJ
	5ZLcQlUtJBzqHeWkyq+9l4u0t61+ZNUbEtWNPf/BurWNhRPvLj3HDzZwCxOIWzCsdiKFI96T4gK
	BIswAC5lx8Fti8HSBTdclZGyKTFJkCTPaPYjIs55Cqy8RpmYOE5nqmXvLa66EwrvHowvQtAH4yP
	AcUH/gAi8xkztlhdhaUmyO6TZqOFOICS9eGO6RK8pyW6Xr4STg4UndstuuZtJP9mdKJr0/WCFSU
	n6bUbmxjSmOW+j5Bjdjo71+xKZDtRAo9aSiQIgLTMQnrpNfgtnWtVHJjGsStAyfJ+7DIsitEiDI
	XMbh1mvju7ZaqQtYqu0qMNsC9t3rcX4glSB4ALRZW8g9GrrR5CkptMO6zp3b8PJK/Vx4hqI82gN
	wveTiJNtNLVcIOOYa2NHNz7W6MvCkrM6yliuZk/Frb57w==
X-Received: by 2002:a05:6214:4992:b0:8ce:b2e9:a4bc with SMTP id 6a1803df08f44-8cecdc89589mr18651456d6.15.1780450237066;
        Tue, 02 Jun 2026 18:30:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda0904sm7724306d6.7.2026.06.02.18.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:30:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/exynos: fix clock ordering race and shared IRQ handling
Date: Tue,  2 Jun 2026 18:30:18 -0700
Message-ID: <20260603013018.239703-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two pre-existing issues in exynos_tmu_probe/remove:

1. Clock ordering race: The driver manually unprepares clocks in
   exynos_tmu_remove() and the probe error path, but the IRQ handler and
   thermal zone are devm-managed and remain active until after the manual
   cleanup.  If the shared IRQ fires or the thermal zone is polled in that
   window, clk_enable() is called on an unprepared clock, which is illegal.
   Replace devm_clk_get() + manual clk_prepare() with devm_clk_get_prepared(),
   and devm_clk_get() + manual clk_prepare_enable() with
   devm_clk_get_enabled(), so clock unprepare is tied to the devm lifetime
   and happens after the IRQ and thermal zone are released.  Remove the
   now-redundant manual cleanup from the error path and remove function.

2. Shared IRQ handling: The driver requests a shared IRQ (IRQF_SHARED) with
   NULL as the hardirq handler, causing the kernel to wake the threaded
   handler for every interrupt on the shared line.  The threaded handler
   unconditionally returned IRQ_HANDLED without verifying that the TMU
   actually generated the interrupt, which could cause other shared-IRQ
   devices to be starved.  Change tmu_clear_irqs to return the interrupt
   status register value, and return IRQ_NONE from the handler if no TMU
   interrupt was pending.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 81 +++++++++-------------------
 1 file changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..5dc22006d7f8 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -196,7 +196,7 @@ struct exynos_tmu_data {
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
 	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
-	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
+	u32 (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
 
 /*
@@ -760,24 +760,28 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
 
-	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
-
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
+	if (!data->tmu_clear_irqs(data)) {
+		clk_disable(data->clk);
+		mutex_unlock(&data->lock);
+		return IRQ_NONE;
+	}
+
 	/* TODO: take action based on particular interrupt */
-	data->tmu_clear_irqs(data);
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
+	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+
 	return IRQ_HANDLED;
 }
 
-static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
+static u32 exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 {
-	unsigned int val_irq;
-	u32 tmu_intstat, tmu_intclear;
+	u32 val_irq, tmu_intstat, tmu_intclear;
 
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
 		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
@@ -803,6 +807,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	 * support FALL IRQs at all).
 	 */
 	writel(val_irq, data->base + tmu_intclear);
+
+	return val_irq;
 }
 
 static const struct of_device_id exynos_tmu_match[] = {
@@ -1036,43 +1042,22 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->clk = devm_clk_get(dev, "tmu_apbif");
+	data->clk = devm_clk_get_prepared(dev, "tmu_apbif");
 	if (IS_ERR(data->clk))
 		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
 
-	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
+	data->clk_sec = devm_clk_get_prepared(dev, "tmu_triminfo_apbif");
+	if (IS_ERR(data->clk_sec))
 		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
 			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
 					     "Failed to get triminfo clock\n");
-	} else {
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(dev, "Failed to get clock\n");
-			return ret;
-		}
-	}
-
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to get clock\n");
-		goto err_clk_sec;
-	}
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
-		data->sclk = devm_clk_get(dev, "tmu_sclk");
-		if (IS_ERR(data->sclk)) {
-			ret = dev_err_probe(dev, PTR_ERR(data->sclk), "Failed to get sclk\n");
-			goto err_clk;
-		} else {
-			ret = clk_prepare_enable(data->sclk);
-			if (ret) {
-				dev_err(dev, "Failed to enable sclk\n");
-				goto err_clk;
-			}
-		}
+		data->sclk = devm_clk_get_enabled(dev, "tmu_sclk");
+		if (IS_ERR(data->sclk))
+			return dev_err_probe(dev, PTR_ERR(data->sclk), "Failed to get sclk\n");
 		break;
 	default:
 		break;
@@ -1081,20 +1066,18 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to initialize TMU\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
 						  &exynos_sensor_ops);
-	if (IS_ERR(data->tzd)) {
-		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
-		goto err_sclk;
-	}
+	if (IS_ERR(data->tzd))
+		return dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
 
 	ret = exynos_thermal_zone_configure(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to configure the thermal zone\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(dev, data->irq, NULL,
@@ -1104,32 +1087,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 					dev_name(dev), data);
 	if (ret) {
 		dev_err(dev, "Failed to request irq: %d\n", data->irq);
-		goto err_sclk;
+		return ret;
 	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
-
-err_sclk:
-	clk_disable_unprepare(data->sclk);
-err_clk:
-	clk_unprepare(data->clk);
-err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
-	return ret;
 }
 
 static void exynos_tmu_remove(struct platform_device *pdev)
 {
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-
 	exynos_tmu_control(pdev, false);
-
-	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0

