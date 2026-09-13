Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7933FE33
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311575; cv=none; b=Lv0tv8JjMN6isS0nnaW3/MlAD9YainM2p9DqPwg0K5CsU/UmgaSQF7kRc352CP3bm5i0iBA/WrLUgx/+EbHzaCJvVotj8RZQrFK7yhT/E7Q87s8x3SUYH2uGBoRhaoYNz+ZLqaW0tqvQzLOQAEMAsXD5M4/NFED0BpT4nK1f/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311575; c=relaxed/simple;
	bh=mLKbgQtKfNZH/MukbGyy0RqhzRY81GCD/PEfQFLWI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMR39u3cjR7aj++EdmUGVzE0pTkDVC0nA8dWCVwlJSrNIpBjf388W5M17L3kTRFsWpXxUJXtKmptDGNC7yqtu5/HvPkEz6C2qWwqKnvxgLrhg19ja1g2JfCMkPPTKxNA9lL/ttdrReJg4jNdm3Y3a2owELv9LJUvOeqifEUYZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb2L7w0M; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb2L7w0M"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso1156305a91.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311571; x=1789916371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlgimeCT04wK/VVZmKrnlafua+eQjTo1OlyMX75Ktyg=;
        b=jb2L7w0MsQKMULUFtG2bA5zGtQbb96dngYd7gZ7psaP5sEg4Y5BU10g4wTit2RCLU7
         jp2LrG6aP2BsxoDgpegEXHUOz6sAGOn7BO7iZurAyiB8bTJGIqwWN16ZmG/74Uu947Y4
         r32S3AskI8PkejxoMsO5IwCvPw3LW3nDOnyQG2RLeL6PjNnbg2x3uP+1A3NazCiteLEZ
         sUp0SsG16YW1nWKZkFyTeOg3LOupF3Gs5jzGCDHbFYLzA9kC6Fq9HtwOD8nJNDRQ2b+/
         RIWh7vJpK3D7xRGILCf0MjsqUTVCfOsravRKduG1IjzR8qAnF5aBpQxWVPVrvcVMdIO1
         IdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311571; x=1789916371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlgimeCT04wK/VVZmKrnlafua+eQjTo1OlyMX75Ktyg=;
        b=cLWnxhQXu0dh7XXZLiXJumV7ASsUjQqChfq/geS+V64LYWvlYWgAV7lXFXymRlgOBp
         F3gJxyegY65Y6URgrJh4FTro8IjAgMM0g8yPUeVXOLNOk5e/1QQupbjxZw8pVngQuEyR
         tM8EQW8j/3cFChBwZ2CyQ5m2NAk8wIKYsPQmnBQzq9PkMLTDmU3g88CVBJDv11ij1VUz
         08FjW6um4Ql4+ztbMLxaT7ChSv3aBsr76jnm8N0gv7tS/NyC8gK9XqwfOw/XgitMW8FT
         1xIuSJ3aGcNxdXXKm/n53361Jj+Zog/03/YrQo0MQO3TV0RUPVltHIfsn1QTadDBRhOa
         zngw==
X-Forwarded-Encrypted: i=1; AKwUvBymBYfTjYhAzVt4uvi6Mr3mWcfgpTcDfPBg5lG1OlGySV2ncpqy4WSJUBrZHLHffaJ2nvYooG/vCg==@vger.kernel.org
X-Gm-Message-State: AFuF++nW1IOj3+JaQmeUVa3ygkLmkxqQWJTrakx1Y+VyEPium/gT7Eu0
	j4sEkItIMShr7O2ilDWLtqgwX962tQdLoUCOkzOXyX3DE/BNaHpcQ/TK
X-Gm-Gg: AYBFou1heD07sJzksZUHq0qz7xig+E608FLCb8VfAn+3TlBRGUOnYLDEazfAxRZIv0X
	XSqtMKI3vcrsJrldRau0+mVg0pMwXiEhiXaUqRZfF4pLCOsqCzu/uwzwUkgIoKIrWXXyCLJ+uCi
	lVAsWO4MhmiAOxozgSxbBUHLNwTcaK49hKrzXCbTzP14MHu3WGq4KXoKyyH4yLDKGje9HebeQ8D
	3cgxWqS3Y5dUXwutFp++IU1NkKOfY8MCwDCzF5y9g78CFJQT8kJAqh5NdD/khfPe1ciYJxGn5MR
	Fog8CPMKw26OocNw0eLo0Pauex7/UBArIkAuZOlUSt5OSqNATsIkWx/6dnVi6e/q7fBUV96BVIn
	Xl+AxDw+y5Wp4DJXvOWtd93WIQpz696qXnFUXkxyac4ZORV16DAlqSAgjmFxHr35B41PzgJ73xF
	zPj456TvdNTxSSl2TQQ6dUG1HbMSxreUrckt5ll/UtBLdbKvUrw7skcRSXEnRaAuV4P+wiewnC
X-Received: by 2002:a17:90b:3c03:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39d9c1db154mr25881100a91.15.1789311570670;
        Sun, 13 Sep 2026 07:59:30 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:59:30 -0700 (PDT)
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
Subject: [PATCH v9 2/9] thermal/drivers/exynos: Drop invalid IRQF_SHARED flag from TMU interrupts
Date: Sun, 13 Sep 2026 20:28:30 +0530
Message-ID: <20260913145905.9404-3-linux.amoon@gmail.com>
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

Remove the IRQF_SHARED flag from devm_request_threaded_irq().

The driver requests a threaded interrupt with a NULL primary handler,
which requires IRQF_ONESHOT to keep the interrupt line masked until
the threaded handler completes.

The TMU interrupts are dedicated GIC SPIs in the Exynos device tree
configurations, so there is no need to request them as shared
interrupts.

Requesting the interrupt without IRQF_SHARED avoids unnecessary
interrupt sharing and matches the dedicated nature of the TMU
interrupt lines.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e75040222ccf..825dbdef0b9a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1078,8 +1078,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, data->irq, NULL,
 					exynos_tmu_threaded_irq,
-					IRQF_TRIGGER_RISING
-						| IRQF_SHARED | IRQF_ONESHOT,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					dev_name(dev), data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
-- 
2.55.0

