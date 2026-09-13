Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C15329C48
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311399; cv=none; b=ObBPVSXR84rtIVLwu9wpdFQdkHMocMTf6HetOqgnnvaZsLz1xDL1yhkixfrYP/3vgh0YaAShxNhPOayEkB+xZwCnf8runKK37Sm6jInAmx0Oa0HMjXRE/W5VYKOgEBV53mbhnZjvYszim8uC//K8ASRwsIT+g0VEODzkIHy8zzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311399; c=relaxed/simple;
	bh=eAYwAL+ffPnZAqP7POHGmOo+jkIZt7HAkY6H3prb/vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njcjq1MMNuwXmbNauUNSomeS4WWXB1x31mUSyLrENAOmnljJc4dBAysUbAeA/FxF7OyaIfozX/9f8qLWI4+Vh2wmHuRZl2UGJF3a9k6kopXC92IkdhI0OU2zygQGV5pHtbYgTSSprcqx2lfN0Hf1nWJOiWvkBDmyNB3Ob23q+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcaqpT0+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcaqpT0+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caced6038eso23563665ad.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311397; x=1789916197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdQEo7CCMpGixzfwvENOdVkMVrSMvvagZo4VCY8/koc=;
        b=OcaqpT0+gBFQrkMzyr2vzf5Y4zk3uknGTv8HE3sNmaVO80G8Vrqq7/fPvCwEtp1xb5
         LEH38vyKs46GhO01o2hImbmgipOC3yP9BdpCxdSnQofG9AWadmtedu/0bgN73rhfBCvV
         YnMXRd/rMvQwHYOMzQU39Ci7EEK4oBIN9CVEH5BZMBurauh5IAiQjM648g9Ox25bHZVM
         t4RfOoTVEuEEbd7M1RHO7MCRe8BLRDiduUyTjgbm/QgbDIhMcHQ141+/IvtsOc4kdpmS
         J9+ZmiXnvo7023xnR386dUI0UsnjZ5UJBeiXGVBkfaYfJO5h0i3QHdGHzuKJ924Vo5sA
         /rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311397; x=1789916197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CdQEo7CCMpGixzfwvENOdVkMVrSMvvagZo4VCY8/koc=;
        b=ciHqSs6oAWoTJZLChngFyyxOecq+U8WZvrUTqubucJqEZdg9ckqiup6E69sFHf7Yru
         rOUSZRG3tb+mXi8mpVnEFR7KsAQjvL6V3m5BFFF22IBt8Y7CAlQwh4pb+YABloHdFQ6Q
         hsD+G+fAl6WMm7Xll4R6l0aVQ5x5y2Hwawit56LNf2Kp6XeYMkPY8PMlysbGKt8mPwjP
         P+DoLXqcvBnBpzokVqOYFQs9+NN8jycOKBLAz/xQ6zrZHnv8uRjHeEyYnJpr2+8EgOj4
         xX0u/iCU0rtks26ETb8B/c+aaqdIHaFibF3ObFMuXUtE1gUhTq9wXigDV5Vd7YHo1JEn
         AEPg==
X-Gm-Message-State: AFuF++kodb2o+kDPl4ivKT71UEPsb0RrceJrWqllzJiG9t7FlgGZa52d
	4wl2cwo7ioHsJOapTCkIzy6nY+lRVs8ye0mb4r763Vl+Y5ut2cSNGc2/
X-Gm-Gg: AYBFou3hX5Nx7HPxA7iBL7+P8w43ApMVWV8pzhex1u4hkj0NCP1ot+M34YUukkicE5I
	cCBLUXboQgAPJXEM5Ap8bBuArUuZEexEV4VEbBpX4IfW4tkDLyWnTuBTSIIengZW1RoYRXdln62
	WlOqrVKEoDulQcDCWD1mg7IMJzbO4+XxH6TYyZxFEzi7TMA59m24/Q5tGOIpFzU3sBJnuql/5tR
	llGVRMSlRKv3p19EL/Eqnt/noF0/EKKBPqwMfxsymRIWAmDteu34VQjxR/tf8KK0F9/QzaUJ1CL
	qF+SRq4yU9PQHIV6InFn8+oVAhEd/6mx6dCjYhAnmCtA5RwuE+9D5O/PnYQzt5z8q5NNZ0eaIPu
	XNtAwLF294cMLaVUjX47NjneGpfHY0/UOUf/kA60XG3A72r0ytyyXdecj/ic9VpZOAXIr5RpJaz
	+PGRmJ/yFXYeKieKFRvaZCSZL3QaBDoGphbsMHJ0cj0N2xSmPwdGGs8yoy54mSmNQn
X-Received: by 2002:a17:902:c409:b0:2d9:2ff6:246e with SMTP id d9443c01a7336-2dd5f1d74d6mr32381155ad.23.1789311397076;
        Sun, 13 Sep 2026 07:56:37 -0700 (PDT)
Received: from archlinux ([207.90.239.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm21467366eec.31.2026.09.13.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:56:36 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	=?UTF-8?q?Juan=20Manuel=20L=C3=B3pez=20Carrillo?= <juanmanuellopezcarrillo@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v6 3/5] thermal/drivers/sun8i: get calibration data from two nvmem cells
Date: Sun, 13 Sep 2026 22:55:25 +0800
Message-ID: <20260913145527.18148-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145527.18148-1-iuncuim@gmail.com>
References: <20260913145527.18148-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has calibration data in two nvmem cells. To be able to
add support, the ability to add data from two cells into one array must be
added.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 81 +++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 1412bce63..360654880 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -300,43 +300,68 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
-	struct nvmem_cell *calcell;
+	struct nvmem_cell *calcell = NULL;
 	struct device *dev = tmdev->dev;
-	u16 *caldata;
-	size_t callen;
+	struct device_node *np = dev_of_node(dev);
+	struct property *prop;
+	const char *cellname;
+	u8 *caldata = NULL;
+	size_t callen = 0;
 	int ret = 0;
 
-	calcell = nvmem_cell_get(dev, "calibration");
-	if (IS_ERR(calcell)) {
-		if (PTR_ERR(calcell) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		/*
-		 * Even if the external calibration data stored in sid is
-		 * not accessible, the THS hardware can still work, although
-		 * the data won't be so accurate.
-		 *
-		 * The default value of calibration register is 0x800 for
-		 * every sensor, and the calibration value is usually 0x7xx
-		 * or 0x8xx, so they won't be away from the default value
-		 * for a lot.
-		 *
-		 * So here we do not return error if the calibration data is
-		 * not available, except the probe needs deferring.
-		 */
-		goto out;
+	of_property_for_each_string(np, "nvmem-cell-names", prop, cellname) {
+		size_t len;
+		u8 *caldatapart;
+
+		calcell = of_nvmem_cell_get(np, cellname);
+		if (IS_ERR(calcell)) {
+			if (PTR_ERR(calcell) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			/*
+			 * Even if the external calibration data stored in sid is
+			 * not accessible, the THS hardware can still work, although
+			 * the data won't be so accurate.
+			 *
+			 * The default value of calibration register is 0x800 for
+			 * every sensor, and the calibration value is usually 0x7xx
+			 * or 0x8xx, so they won't be away from the default value
+			 * for a lot.
+			 *
+			 * So here we do not return error if the calibration data is
+			 * not available, except the probe needs deferring.
+			 */
+			goto out;
+		}
+
+		caldatapart = nvmem_cell_read(calcell, &len);
+		nvmem_cell_put(calcell);
+		calcell = NULL;
+		if (IS_ERR(caldatapart)) {
+			ret = PTR_ERR(caldatapart);
+			goto out;
+		}
+
+		caldata = devm_krealloc(dev, caldata, callen + len, GFP_KERNEL);
+		if (!caldata) {
+			kfree(caldatapart);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(caldata + callen, caldatapart, len);
+		callen += len;
+		kfree(caldatapart);
 	}
 
-	caldata = nvmem_cell_read(calcell, &callen);
-	if (IS_ERR(caldata)) {
-		ret = PTR_ERR(caldata);
+	if (!caldata)
 		goto out;
-	}
 
-	tmdev->chip->calibrate(tmdev, caldata, callen);
+	tmdev->chip->calibrate(tmdev, (u16 *)caldata, callen);
 
-	kfree(caldata);
+	devm_kfree(dev, caldata);
+	caldata = NULL;
 out:
-	if (!IS_ERR(calcell))
+	if (!IS_ERR_OR_NULL(calcell))
 		nvmem_cell_put(calcell);
 	return ret;
 }
-- 
2.55.0

