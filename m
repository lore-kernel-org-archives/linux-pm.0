Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DD34D93C
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311617; cv=none; b=lnlm6Vi39IxrkKUHEA1nptnn0pc2SO7H925RKrDIqXrgRUL0DVXwyyl7wxk8JJgDXmMbJ4/UWPev0fU/zbJGJ02QF7pYxxbXWTC1vhUCdAQIoGEmy/0hi+Q3lMpczgFFf+lj6pvC3hICuu1EVPy331pun3KoBzzUBaNAT3lAtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311617; c=relaxed/simple;
	bh=DwPp2HkWQO6qcGBPqXNMiD7gLL4HfMQuCnHnKBFbtEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ty9VBx7KPV4OhORRG+yeW2/b7WEdJmO4IgQZcrV8DFsPfO7/nQjhAjKB71CbnGz/13jnyC09fEF+dZ+hMRJYVOq/ieend+JsYDMoSue5LsqFfA8w1kSNuLMxOqHsUWgRPf4SxEbE7G2HiXlSD/Z9o3+oTVnI8tk4nCA27iMLkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slmo+67r; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slmo+67r"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-86a25369f16so1870899b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311615; x=1789916415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbLN5q31GQxj4DJ6F6WcgB1JNfvwxcLXSAMVbVPmGVE=;
        b=slmo+67rnC60p6O8J4HY+vLW7Hzz9wwMOgxilKYZ8+u/QYZvAXLHGWvg4jEVXOSg2u
         9x9w1qEGVtoBliyqdwZouLxM+RK6yVJ6883R7gXwLwqPpw4DGHoNMnaoZrKCSRPXwXbV
         AyuwwFd4QDpatHSwozBYkIYOIz3SEQxDV1iwa8pXMcFcKx/DOOrea8cZ2dBKtyUQssyL
         6imbZBDCL4mvAiLJ13AdCUulUhR3ok+yscU0FZPA0unJ97xGPerc4vd+fN8mcS+bG9H4
         cuIYilz8VO6j/gyb5uOnExJVUgFxxSPsgyed2YvwmfWLzvHhzlQ0xCcuqLarNYsbS8Pj
         37WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311615; x=1789916415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbLN5q31GQxj4DJ6F6WcgB1JNfvwxcLXSAMVbVPmGVE=;
        b=L/UaJphuGTfMJMHgMLI02CkUXL+F9ibMIbmfr4Mj99kySWgU3bQ69VevO2gTlOsxMO
         pAOTPuo00I8L+V/bnlFbU8u1XK5VuGL8LNoayKGewWccxWqaMS2bn3o0qESsL0r6aCO5
         f5oz7/4BsOmK++CybzdhKKPYx+CCWwYJXv6QKKAsHeK5UmZaqvF5oR/dtvbgXa0+8/tS
         nddctbODD4w2OyvlSd5yDbsKOMZkjDE9jsKPkS+yT1aJni3c0wuAGRLuyQXs+S50czaA
         M1SaYxRuMhVE/QAHcTTye59eDG7B59Lt77tFEyG1qhesFzIol2jy5Tn893vErUfoOIbT
         fHxA==
X-Forwarded-Encrypted: i=1; AKwUvBwJEJ47o/YtIwy3HKKXZGylevnuaqfGhNDOLMSHSysI89RJi9Lt7Z3rDC1LJrGY4khOiG5alxU+yw==@vger.kernel.org
X-Gm-Message-State: AFuF++nVHHgqkVlPmSDmk78hyazqATf/RiDsUraFnxf1nTPUV2WcOGbb
	ct5q7+NduYrUGXGTBqa/9DdkAfJ8prt3JtknALTJR8nfxL6K5tEK6s/E
X-Gm-Gg: AYBFou07upkX9x5Ads8UynTrL79dWUcaauyMKDiY7ldK9MJ+4u6ZnoMiJUNF/HR1vES
	CaffMWC7YWrS+GIVNR4fCj4KN7UbASXiv4uqzFfjki4n0vpWydeChNSgiuEFa6G0juoWBvJLEeI
	CZVXEfGbv5ljwm8rq7S4FovbFJKyB7WRx/VDzF3pH9iilci6yu/CLLHxi5BRAISCjb8R88gAVfL
	AW4SrI3maHPevYWNSGYzuYu+z9U8kJYrX7S9mIjK1a/cAqqCxhcOColrzJomWuzyGQC+OTfKs8q
	OphgLXnPRJBaMbZrGhMrk51ss5Jevi/jKwwr8xnKoukSsZXMqWPD0jPGu+DNhAfZ0RYbQhIV6W2
	pDYSiCflDSWKlZzFvD3lnXZUNyxBAALUXaURK+11C551lQirogntxylnVcmVMQ1kUsMxgQ42XAf
	OPoE4oVtaw6Zc6PTE859f2mOBrM7ZME5UO6/tbO4BlcNYndGaFp68u7wZ9l7/wx1VGt1qN3Mu1Z
	ZCxE81+6D8=
X-Received: by 2002:a05:6a21:140a:b0:3d1:66cb:d49 with SMTP id adf61e73a8af0-3daed46b0e3mr24749980637.4.1789311615337;
        Sun, 13 Sep 2026 08:00:15 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 08:00:14 -0700 (PDT)
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
Subject: [PATCH v9 8/9] thermal/drivers/exynos: Add missing drvdata assignment in Exynos TMU probe
Date: Sun, 13 Sep 2026 20:28:36 +0530
Message-ID: <20260913145905.9404-9-linux.amoon@gmail.com>
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

Add dev_set_drvdata(&pdev->dev, data) early in the probe function,
ensuring that the driver data is properly registered and accessible
throughout the lifecycle of the device.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0e7b92035850..fe56a48be5fe 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1125,6 +1125,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dev_set_drvdata(&pdev->dev, data);
+
 	data->clk = devm_clk_get_prepared(dev, "tmu_apbif");
 	if (IS_ERR(data->clk))
 		return dev_err_probe(dev, PTR_ERR(data->clk),
-- 
2.55.0

