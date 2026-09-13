Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34B314B73
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311594; cv=none; b=bMWLzhB+ginf1LzlLdmUpHU8r+1qAoKKHYzqQpYVrI12rqKHiHQQiw93QsqI7sa5cwWg+jsJ0vOEXPItEE/Y+B88d21cNaaWedYL4K4ZIXETqMFmnPBbZhqrOsWUbsAR0xwlfjfcrPHB4HMlSh2GNQHwM8JsNUmp0jVTDp3fWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311594; c=relaxed/simple;
	bh=QU92jHTgyoOrjhQ/jU9kAlPGDiTL57NK+D0wMhaXJLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pikb0xAzfNML3USv4mTp4HC/9LezsAAiEqYA0ioceNW3PsiGprIQR8raMj5tN30KyWgmVQ5koERKAU8Q21WXr/xnfY167BVKNd2QCjGwyGpxMBu+K6gfeW8G2pmOi7E63X7HhEWjtNIGGrqPcZ49zUvwAm3LcF2HfTh0IHh8y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF5GS5jL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF5GS5jL"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d942c7cc2fso23199885ad.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311592; x=1789916392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4idUXl5Bb6HMJGTVQ31rHFIN8Up+7p6vXg8EYrcuCCA=;
        b=eF5GS5jLO1ZJSx3znAkjYKLPaYdgrg5gR3qDovuNkrFhDMKaaXfa9UxpgdZ9B6ogh6
         /3hgyFklQlnm094EuCHGNpawSZ1Rw8MmcuTnWbU8NI7451lkhfVR495Xr/Ev5wSusdSj
         5LMr8lk1aNu/NfWrUB8TYJYMxC+2+C1mCtBezeZ8DMfDUNq9wCmMDNLMT+MB8PtFaflk
         s2O6San/KtM3GrhblkxqtrZodtF+u0qSDvkPKRDNYNgCR0eKBu+chqYs/CzOlzxrvQRd
         f867pxFTu8zsiPfqe+NU5Odu0ci8PiKMU+V8Ao/F4L0u/vuWvLujA6eARD+fKyS3DZFS
         4xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311592; x=1789916392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4idUXl5Bb6HMJGTVQ31rHFIN8Up+7p6vXg8EYrcuCCA=;
        b=kQfTYrB3GB/PGJd42FAmxpbZIrIibz1D+pETmzTxUCAKGarM3TySk+OngSoS3OEXFY
         GAZT+iqmd88p/ohI/47PZANrBRYY8tVVG+HSq4Xq20H+prLHBBZ8U5AaD3Ulx91PWjig
         rkNeoGInvry4oR54RifWYx6IH/wikG6xZsLPYfOOg+h6S7WWcw3afIvl0nbHmT3lwAHf
         9wBlX1ctsfzVSR46CXTdXcL5/7SmBfmkgctYQCuOXqYIqaWhfZz5kfORQYDh+HH48PGt
         0rW45DC+ZbN88eswhTp32szvT7zdiB9KwuuHxWTgzuN+1heuz3H4xoLhZa3Wx/LRdeP7
         FGwg==
X-Forwarded-Encrypted: i=1; AKwUvBzgpwwfMr+SnRgW0jvtKrfBXCRpGMH75myl00PsTeDeY6A6VghxjNFagNj2Dz9nS0eK1cCRHBKGYg==@vger.kernel.org
X-Gm-Message-State: AFuF++lrS+FRiMQvlf8KXYB+58j0ykhCuxovbrXyv3AvCFLysR78+ZO5
	b80VpP5lNBXWcaNpwhGrcxdMucRekNSmr7B2QiHT+MKgKfCCi9hUjL0B
X-Gm-Gg: AYBFou21O/aor1uWw1LFZwNGFyZKI8scMDm0VPiA8ckU12OfmW2aMaLU6IVnbU+tOq1
	OkkUFJiZHdSEkbIpN/degEiUwUBO41M2moWzoJVprWFqq1ojsXVeMaWV56Um7NVv5Dlti50MY6U
	TD/h7Y1TUbFp1i0V3KrNJ8kYMJ/b7CJm/lZLmz19V9ltUQFuan89r/7Lj9elVoA6uOIxy0n7zS0
	7eIfEOp/B7Q99DDaq03K0KvNck2IebeZELaB/pjG6jnyyuK3dpo6OqDNGZeGPLodOHMy1c2CV2R
	aNfpiy0eeiJcrFxfH/0xYmIPXgurdLf6OHrSo2mpFGMApBxMOLj8fwOsbgAmWLhv2s0wTcTQj0/
	VLE6Sm2lKdKZAd7SWhF1+gIURM3mGLW7+p3nrV6u4y7EgrcVOOVKtLwdbC8Ew47MWlw4LQuAac5
	yWhdkKiO0dxlv58Q3xpmjAoRv29UJigUQXWIdwymBShbLM9xwWsSc2gWkR+NcwzFZIeh1HeVT1G
	PGqIqwEemI=
X-Received: by 2002:a17:90a:da8f:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39d9bc10072mr20891195a91.6.1789311592428;
        Sun, 13 Sep 2026 07:59:52 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:59:51 -0700 (PDT)
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
Subject: [PATCH v9 5/9] thermal/drivers/exynos: Remove redundant base_second register resource
Date: Sun, 13 Sep 2026 20:28:33 +0530
Message-ID: <20260913145905.9404-6-linux.amoon@gmail.com>
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

The Exynos5420 TRIMINFO register can be accessed through the main TMU
register space, so a separate register mapping is not required.

Remove the base_second member and the corresponding second resource
mapping from the driver. Access EXYNOS_TMU_REG_TRIMINFO through the
main TMU base address for all supported SoCs.

Also simplify the triminfo reload handling by directly using the
appropriate reload register for Exynos3250, Exynos4412 and Exynos5250.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 39 +++++-----------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a38b48e2236a..82cb4140646a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -139,12 +139,11 @@ enum soc_type {
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
  *			    driver
  * @base: base address of the single instance of the TMU controller.
- * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
- * @clk_sec: pointer to the clock structure for accessing the base_second.
+ * @clk_sec: pointer to the clock structure for accessing triminfo registers.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
  * @cal_type: calibration type for temperature
  * @efuse_value: SoC defined fuse value
@@ -172,7 +171,6 @@ enum soc_type {
  */
 struct exynos_tmu_data {
 	void __iomem *base;
-	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
 	struct mutex lock;
@@ -447,23 +445,17 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	unsigned int trim_info, ctrl;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
-	    data->soc == SOC_ARCH_EXYNOS4412 ||
 	    data->soc == SOC_ARCH_EXYNOS5250) {
-		if (data->soc == SOC_ARCH_EXYNOS3250) {
-			ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON1);
-			ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
-			writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON1);
-		}
+		ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON1);
+		ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
+		writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON1);
+	} else if (data->soc == SOC_ARCH_EXYNOS4412) {
 		ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON2);
 		ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
 		writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON2);
 	}
 
-	/* On exynos5420 the triminfo register is in the shared space */
-	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-		trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
-	else
-		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 
 	sanitize_temp_error(data, trim_info);
 }
@@ -965,25 +957,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	data->cal_type = TYPE_ONE_POINT_TRIMMING;
 
-	/*
-	 * Check if the TMU shares some registers and then try to map the
-	 * memory of common registers.
-	 */
-	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
-		return 0;
-
-	if (of_address_to_resource(pdev->dev.of_node, 1, &res)) {
-		dev_err(&pdev->dev, "failed to get Resource 1\n");
-		return -ENODEV;
-	}
-
-	data->base_second = devm_ioremap(&pdev->dev, res.start,
-					resource_size(&res));
-	if (!data->base_second) {
-		dev_err(&pdev->dev, "Failed to ioremap memory\n");
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
-- 
2.55.0

