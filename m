Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691C223DE9
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537375; cv=none; b=REml5fAixtrYIBf9qGP8+B7nlCM79JduGX8aGbQTQGXTsF3vqDbPueL3issYT7eIOF5JXQj3V2R3++geHmD3Y+2U6PTuWXhlJ07RY9WZQLqL7Y6fKE7xHGl4OzbkkpBXkSkJ7lIhqx2KaxCj3qCUnWUu2EBCd5z96oNFdC5QQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537375; c=relaxed/simple;
	bh=BE+DGdAbW/QfyBCBRhkx1zHdr4Mm28zjPjW+NfTpbx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGuhAgqia87WA5ijaBI3G0fL5tybknK0TJeFwiWedXxzKz8Bi/EJoCSwDmoyAy9ArJqiD9NYljddD6zShzYHoMMGgkH3iCmP58w1NTzMXjuV1Hini2amVYbgxa3X3c7zNAh9N59P1MYNjYjNKffye5RPMlpGmlNz5Ju8WOG2Los=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1yOas0Y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1yOas0Y"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f1d8902so57909b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780537373; x=1781142173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lpnYjV8Ig/zZCSkvQJauvrjccH7UfxeEgfbLG6AD0g=;
        b=d1yOas0Yq+QVqqEpkMmOTUrQu8augJXaZjq590TxxryU++4idSP+5EhNPK6oXrsfZ3
         Z2snazMCGAc0N3ueZWxp7KBK7JzvFoZAq3st9YwvLhGTdd63RfvR7anO495Mhf1Gre9p
         uZKmjEKJ6CMGxER8bl0eqD0aNrwHfXQPtNJayxw4v+wTSBlgLC2uEtKU8UKeYtFP2jim
         8LlQyWYfpXDKRkQrfZsUDlV7Stk0H1mFOut2psnancCSDLBB5AaxbNFX/uxVa1Uo7YrS
         YNjtoWKBPySw1KyDumDlyNu0VeRyjJkarQOQLKDiUE+5a9ny3Y9r1yDLP5e5OG5jUGU/
         XPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780537373; x=1781142173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lpnYjV8Ig/zZCSkvQJauvrjccH7UfxeEgfbLG6AD0g=;
        b=D+x8kLZPSZn83yJMOKgSBdW1fL1B5l97dcvVOEGTHuJDHTajgkAehZs86UK7wvhQTf
         Lv8CvmUJy4RmIMwOvEO8pMX1kL1NwNKLcc8+qb09utzoLRd5jj1D89NUEK788Uz/cWXW
         eoevxMIrayLb9PFije7AIawnT+3aMCgkUrW9jtJ46gXidC/CC5Nk23SjQjcpMTeA1v+5
         T7V/I7iEUgkn+RDo/aqEa+BubCtEp1d4P6KVm4oTbSfQXyYOCcc2xWislZYvjFs91rUf
         K6YGXDhmIC3wRvEH4FaOvMKE4rn89saBVA5OpOrt6XcanYGjfIndf0Uy6Snl3wLUMLYC
         0z5Q==
X-Gm-Message-State: AOJu0Yy9wSyuZYidP7M4LRsWp0zNzpmM2CZFT14eSXv+hbw1Weei4iXb
	uifUi7C2sXEwufto2YjEvbARdFe1BeIXxNu1pPOXpy5REbZINu/5WSfAc9V8h29D
X-Gm-Gg: Acq92OEhi1VmDNm6cjwXGxFqlcj3cjoSJj21QrtJhIDYD6/e5r3H47YGUNJNCp9MmQl
	t9ZjBtwYSn7KKs/p/fo9eBD9SD5B+OmPErXFRd5uLnUq3X64QssBizcK1eDih3IjsY1zK1q33N/
	ZuJSCzKldrNVACWw1YnDUzLhvtSHeGSL3y+jILLRcHDIwNfDGtn+wyImrmIlvHee+DQ/JxDPLB1
	62HY8/wXjm1SrnYOs409ykqmQ1yXErwa5oATbxb3rSM+64J9rPdYBfHEzXlCa9YF60tiyH3vfXu
	sJ7WzTMOPVx8gsRMMwG8efuTXyFt/dM8CSiZA5lUpdlwkLSwyGPC2oRnfKZsiQV+exeLkWXydad
	KwICfyTTlNhE5rVpREfM+IggGykwYDbwvfwuGz5XYNG9rbuVpEd1PI53EtdnFvKf1RGPwB70e/d
	i+A7YjIbECpYaUa0wtKXffqIJtNhUPk5L7dOcizaSb1nq2FPlezhVZBVffTSIFJPpRZPcR3AiOV
	rdnke52YrA6KcwpfpAG6kZbG8Lq1+pozv5Vwd2I5XtzuQ==
X-Received: by 2002:a05:6a00:17a9:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-84284f5fedemr5522133b3a.25.1780537373220;
        Wed, 03 Jun 2026 18:42:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm4603728b3a.19.2026.06.03.18.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:42:52 -0700 (PDT)
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
Subject: [PATCHv2] thermal/drivers/exynos: fix clock ordering race and shared IRQ handling
Date: Wed,  3 Jun 2026 18:42:35 -0700
Message-ID: <20260604014235.39303-1-rosenp@gmail.com>
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
   NULL as the hardirq handler, causing irq_default_primary_handler to wake
   the threaded handler for every interrupt on the shared line and, combined
   with IRQF_ONESHOT, mask the line until the thread completes.  Replace the
   NULL handler with a hardirq handler that reads the TMU interrupt status
   register and returns IRQ_NONE when the TMU is not the interrupt source,
   so other devices on the shared line are not delayed.  Also return IRQ_NONE
   from the threaded handler as a safety net if the interrupt was already
   handled or cleared between the hardirq and threaded handler.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fixed sashiko comments and moved TODO.
 drivers/thermal/samsung/exynos_tmu.c | 104 ++++++++++++---------------
 1 file changed, 46 insertions(+), 58 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..11b2f1e2670c 100644
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
@@ -756,28 +756,53 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }

-static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
+static u32 exynos_tmu_intstat_offset(struct exynos_tmu_data *data)
+{
+	if (data->soc == SOC_ARCH_EXYNOS5260)
+		return EXYNOS5260_TMU_REG_INTSTAT;
+	if (data->soc == SOC_ARCH_EXYNOS7)
+		return EXYNOS7_TMU_REG_INTPEND;
+	if (data->soc == SOC_ARCH_EXYNOS5433)
+		return EXYNOS5433_TMU_REG_INTPEND;
+	return EXYNOS_TMU_REG_INTSTAT;
+}
+
+static irqreturn_t exynos_tmu_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;

-	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+	if (!readl(data->base + exynos_tmu_intstat_offset(data)))
+		return IRQ_NONE;
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
+{
+	struct exynos_tmu_data *data = id;

 	mutex_lock(&data->lock);
 	clk_enable(data->clk);

 	/* TODO: take action based on particular interrupt */
-	data->tmu_clear_irqs(data);
+
+	if (!data->tmu_clear_irqs(data)) {
+		clk_disable(data->clk);
+		mutex_unlock(&data->lock);
+		return IRQ_NONE;
+	}

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
@@ -803,6 +828,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	 * support FALL IRQs at all).
 	 */
 	writel(val_irq, data->base + tmu_intclear);
+
+	return val_irq;
 }

 static const struct of_device_id exynos_tmu_match[] = {
@@ -1036,43 +1063,22 @@ static int exynos_tmu_probe(struct platform_device *pdev)
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
@@ -1081,55 +1087,37 @@ static int exynos_tmu_probe(struct platform_device *pdev)
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

-	ret = devm_request_threaded_irq(dev, data->irq, NULL,
+	ret = devm_request_threaded_irq(dev, data->irq, exynos_tmu_irq,
 					exynos_tmu_threaded_irq,
 					IRQF_TRIGGER_RISING
 						| IRQF_SHARED | IRQF_ONESHOT,
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

