Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF633D6FA
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311582; cv=none; b=f+tjsfPalk+eJvMBjCme9Io/K4hiInbYRWPSPYGisZ13FD5RJBBJ4JA1phSQQQqSXEB3bP1EaF+K3xXSH6FlhoFl3gupP5H1RWUi84UrVcu034Ku7zAQHPJglFSRZPO/g5wJdxrY8MEjEwtTxSLyMukS3ZujaNkMNIPmE1ARdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311582; c=relaxed/simple;
	bh=ak4tshfNok3X2hRPXd4e8Yziszvu7kRWCnmlNF5Pb5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvNPOndpxZrOhnLdbzEn9HwLfg03UmokDEHz1/X9tc049Ijy74Org9Jnph/zsCuQOkf1p7C02oTvkFc6D7VI4jjsMgF/BTFy8tcowlCQyTwlOYrE5rU42py1TKFfXAWlw3DRSkN3Rgau+R6dM/XVoHsx+W5hNar4vKSV7qBcGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9CvGy1c; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9CvGy1c"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso1156346a91.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311578; x=1789916378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6v0v0q/G/gLroOU57+Sotz0AlKiMNuB5Ilcu2TBSVco=;
        b=e9CvGy1c+H+BeyV7ALbK9LsNAjPvaScD1wtUjj65xclOGPIqxi5MX1qvtMQLaULH5z
         IMbdyDHPNnubyE/OJ6Px4rT2YyyMe1IRwWyqraSqrEu/IZTacmBDlrv5h+FieCwOmVqi
         /jsMiw3V8Fhtfbg3aspPQlAD8ijYPWAK04loewTreBEexpenkLa7YOpUXH7M0qpvJVcD
         Po5U7/SptpOb5M8nvU1/tokwZ5KLm0Ucxutc5LjYdlpdfu1tAx4bbzxwthFqWiIBF4la
         NdkVYJXZHLoVB9IYzGTNM6F7ZxG9PKuP5wMnKjlaM3qO/9bO6ZvUvwzp4VwCdxvuCqHv
         gKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311578; x=1789916378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6v0v0q/G/gLroOU57+Sotz0AlKiMNuB5Ilcu2TBSVco=;
        b=QTIWoxMIADgLAzmGuXV3kTg3z3HQ9VK+gOdAHuTr1ioJfb/52FfO1hDU68dckEGK7g
         9qkBFX/d6RAyzhDwFALVAvKPdMkwuEup/blzNK8Kd3kheOpoMEUpJe5XIRE3tJN5plq7
         zQP6UCKlrVmnvjOkgNBVrG81wrkoLdzfVW00n4PaBQTJmYGbY5nuSRzVzFiRd5w+Bo6k
         PviU1SAwm0Ib3Tj4oSo62cbPcp6arps5pxsHSQHw+wwcK7PVKnkUjUBFz5ZieqYshn1L
         gVO/CU5e7gsqelnzVMU6t4GcT7g9qjf6+Vt/EbdXzk21cMPo7IAm84iI6TxdaEVPSuo7
         xsJg==
X-Forwarded-Encrypted: i=1; AKwUvBxSXtcQuLtVWm7ZI+6yOsJVlfhFk3//ZjFZslBH/vnbXStkn+BaBNnj72juqfss3hbukpkPrBQ8Pg==@vger.kernel.org
X-Gm-Message-State: AFuF++nKgzgccSfZVioNLbMemoyNw0D9VBh6jbQCB7ndy0iFShbbYjxC
	T2ZcXUIW6Lsks8CA+hhbnggWbBOJrvLQwy3s/uUBUiE0nDO3v3colet6
X-Gm-Gg: AYBFou1xFMiyglgj9oYssLXsGMN0yTWdD9viJL3WQtK9Gr+8enVEAe6hpHPBPGJhGOg
	cN8DA+7dV1uGPAskfOsdph5olhlBjnnJtNbOVMrOkbf+qvo/s2+osg+Er/+Wpsj+84SD8mNQorY
	ElfIna3k4lJ0+e0xpZajeRFazbQl77PIEBZcoxq+G++2IcehiF0EwQvVs7J/OIegXTQChGB74Jj
	G7zTMzaAzpMQjF+QxUP3WI2R6zvUz2dwClX2D5c+AI62fBPC8EmyyENx6Hv6s+swI0HWbJLG6i7
	D2QFxUk8Z+hnQuklciqUEKZdPYnH8LCyukv7zS15uKsjMrH9lcA7TMybRVrbcnfSKahW/B58Bxr
	SRcwajBHwTik41KuPKZ2lqxeQgRIXrXMTlCtsl6T9z/9U5QAHRU7X5uA+7ATJhkZSeVCeLUO4b1
	nb8H5lE8UfWMmuOQBhhlg/DbbIQKBW4BJ9KHDmPPlmbbkRs+gU1PxiQfAKieEFZpbO9mqp8pQhz
	w==
X-Received: by 2002:a17:90b:2588:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-39d9bd99cc7mr24628579a91.10.1789311577951;
        Sun, 13 Sep 2026 07:59:37 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:59:37 -0700 (PDT)
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
Subject: [PATCH v9 3/9] thermal/drivers/exynos: Handle optional triminfo clock correctly
Date: Sun, 13 Sep 2026 20:28:31 +0530
Message-ID: <20260913145905.9404-4-linux.amoon@gmail.com>
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

The triminfo clock is obtained using devm_clk_get_optional_prepared(),
which returns NULL when the optional clock is not present.

Update the clock checks in exynos_tmu_initialize() to test for NULL
instead of using IS_ERR(), allowing TMU instances without a triminfo
clock to initialize correctly.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 825dbdef0b9a..a64b11e6acdc 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -258,7 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
+	if (data->clk_sec)
 		clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
@@ -269,7 +269,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		data->tmu_clear_irqs(data);
 	}
 
-	if (!IS_ERR(data->clk_sec))
+	if (data->clk_sec)
 		clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-- 
2.55.0

