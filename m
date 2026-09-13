Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D186331EAB
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311571; cv=none; b=TVtx3hoMhIf3YEMtOziiv3OAg4Pdh5nI1QBYdDuSmqzoTQy3z43n3YwBT5ckEe94UmDDJSXSRUVLkn8VjzocniE2Dlzt2w4rsSV/T26/OT5ush7OrjPT2BytO6gailHSSDQAHp05s0Qt/b4duUS4i91Jy9HE5F3kO6YYTdDBiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311571; c=relaxed/simple;
	bh=YSeTXGq1Y5urvm2AfNfvAhzNyUp8BTVNviU+imO++Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQiINgmpo2azHomvxGW5n2/EEhqrTc32Y9VJD+HWrLyojKD3Skf/VBX2nptbLIYBRxIH/x2GMfMsg5wjHDFmO2K65axIYtGMxc+AQFdchCrBph1vzvy7SPQZWrkKnEWLQ7ZPi3V2rps5wZWBkeoUPaoG+xS7PAjXTEy7XGe+2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9nWPm5k; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9nWPm5k"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1359260a91.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311563; x=1789916363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DxAiZIWTohCHE3URqspBODvbQB2hR6En63VyQJNJmas=;
        b=P9nWPm5ktdxTi8vygHLvmupNqrNpRSKZbgm0UBX2H3lqWDcC3O/f2Wy+wkeA8bGCV+
         c9uINg12A3cCISGcFUDOHWLqtKLY0n1IXZmX+0bR7n2WFUkrk91dD1GxiC+pFioWengd
         TARnC2EkKekkk6Kmjv0yjvgUkkmhQQWSi7JJC0SAwMhTPLmV0i8lSjANvv53mGQTZjLE
         iZOl7BoN32JGGCtqxRwzPGN2hrlm7gOoL7VISHUjvevarPlYlin/4heW61OSXE0UpExp
         vmalsg4B5zqEpKaMQrjnDzQMD+eEPWcBy7wFelKJHA2gNSTAFCpaoAX/+Gi+z8UWFEur
         Q+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311563; x=1789916363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DxAiZIWTohCHE3URqspBODvbQB2hR6En63VyQJNJmas=;
        b=ZzGPLt35LPdIKvHA6C0Hga8X1E35p4lbOKyPeHax62B2KivRJm6a/owBavOibaE5cC
         CYPeCAp5mzYzRTOiOCRkW+s/QK+3sY2pKrzg2PQtC5tbm6oY2B5dCGDG2yuY5sVLeYkH
         mXBKyLfn+IBykxv/0+/uaUaRYSMXvQjgY76SNBKAGoqqIiM2H7O9NMWu1xl/KxZO9jQh
         wYkYA9Tqhgh3GGSxRheKthKSfYl6IMMy0Wy+K+L5+tnRCh7lK4oHFsxwGZM8avLOIt3x
         HKnwdjfigzIEHa0II/TAuqTpC7D19p0rE+oa7mADxM0zAnFwmqh2q5uy/251NPqI80OO
         KM1w==
X-Forwarded-Encrypted: i=1; AKwUvBxTFjG572aaXRJ3feUCyl+OZzIoGw1JYXOf3iNPq296VirKuVHwE/YA2kIpaxEQnYF1uDaGuh+ylQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m7hpqrwSPOADko+kPM+CzrPiVCeM0rADXGsamB5OuLRHmY0wPH
	yszlkrffwBY2DOPIrG9N4mPOd0qtSOsANB2DCri+D3wjHdkVSua0TYlq
X-Gm-Gg: AYBFou21hzmdmysnyo950x1MMLHtB+ods7nhzx/Or2+8EuPc2yrcgshm7e24pifdPDF
	bD6zYn8eNu1+Ya5dOuQfmWcDOeBlpQ+krZeZCpqzkiDGc3RQJCfKaiUbIdt9TI6ub6SSy8keshS
	Gr00wan/vabJEWX946QWFg58xNRBDvyZcjjnqcYGNWH3/KPtCEQyAv/llgpTrAKJgMQiWgp4M9S
	E6tDGWK5I8gAgDaivilPucrjOBMSulre3dyyeIjS9KejRVSDedlV+trGTNnAXhFqjwT5/L3Ec3U
	QouEa01e4WzZjmCohSazcNCTKxI+GWRV2hv/Q6KXzm3pitopP9F/T9mzSG1OCjkCvhYM7Trgo1A
	vBiyAqU9HYkNJlsnjxdmkok5DmoPEPYVFW273nhDogl4nR99YLFKZIw6h34kJL7Wcb2zF0pcJTY
	mfz8EvkrjziRF9AVgA+e4S6wYoeaSPGILRDsueOThaW0Adc5e0RibvkRzVRqMe5PFC99z6/ZgGe
	OnvUjoRfps=
X-Received: by 2002:a17:90b:28d0:b0:398:9bd4:d18 with SMTP id 98e67ed59e1d1-39d9c3f2ba7mr26213072a91.23.1789311563420;
        Sun, 13 Sep 2026 07:59:23 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:59:22 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 1/9] thermal/drivers/exynos: Optimize clock lifecycle with devm helpers
Date: Sun, 13 Sep 2026 20:28:29 +0530
Message-ID: <20260913145905.9404-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145905.9404-1-linux.amoon@gmail.com>
References: <20260913145905.9404-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the managed clock APIs to prepare and enable the TMU clocks in
exynos_tmu_probe().

Replace devm_clk_get() followed by manual clock preparation or enabling
with devm_clk_get_prepared(), devm_clk_get_optional_prepared(), and
devm_clk_get_enabled(). This also allows the manual clock cleanup and
error handling paths to be removed.

Preserve the existing requirement for the triminfo clock on
SOC_ARCH_EXYNOS5420_TRIMINFO when using the optional clock API.

This simplifies the probe and remove paths and ensures clock resources
are automatically released when the device is removed or probe fails.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 86 ++++++++--------------------
 1 file changed, 25 insertions(+), 61 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 56717bb50d60..e75040222ccf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1036,65 +1036,44 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->clk = devm_clk_get(dev, "tmu_apbif");
+	data->clk = devm_clk_get_prepared(dev, "tmu_apbif");
 	if (IS_ERR(data->clk))
-		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
-
-	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					     "Failed to get triminfo clock\n");
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
-
-	switch (data->soc) {
-	case SOC_ARCH_EXYNOS5433:
-	case SOC_ARCH_EXYNOS7:
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
-		break;
-	default:
-		break;
+		return dev_err_probe(dev, PTR_ERR(data->clk),
+				     "Failed to get tmu_apbif clock\n");
+
+	data->clk_sec = devm_clk_get_optional_prepared(dev,
+						       "tmu_triminfo_apbif");
+	if (IS_ERR(data->clk_sec))
+		return dev_err_probe(dev, PTR_ERR(data->clk_sec),
+				     "Failed to get tmu_triminfo_apbif clock\n");
+
+	if (!data->clk_sec && data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
+		return dev_err_probe(dev, -ENOENT,
+				     "Failed to get tmu_triminfo_apbif clock\n");
+
+	if (data->soc == SOC_ARCH_EXYNOS5433 ||
+	    data->soc == SOC_ARCH_EXYNOS7) {
+		data->sclk = devm_clk_get_enabled(dev, "tmu_sclk");
+		if (IS_ERR(data->sclk))
+			return dev_err_probe(dev, PTR_ERR(data->sclk),
+					     "Failed to get tmu_sclk clock\n");
 	}
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to initialize TMU\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
 						  &exynos_sensor_ops);
-	if (IS_ERR(data->tzd)) {
+	if (IS_ERR(data->tzd))
 		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
-		goto err_sclk;
-	}
 
 	ret = exynos_thermal_zone_configure(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to configure the thermal zone\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(dev, data->irq, NULL,
@@ -1103,31 +1082,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 						| IRQF_SHARED | IRQF_ONESHOT,
 					dev_name(dev), data);
 	if (ret)
-		goto err_sclk;
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
 
 	exynos_tmu_control(pdev, true);
-	return 0;
 
-err_sclk:
-	clk_disable_unprepare(data->sclk);
-err_clk:
-	clk_unprepare(data->clk);
-err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
-	return ret;
+	return 0;
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
2.55.0

