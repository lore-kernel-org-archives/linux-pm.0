Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94A4CDA3C
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545091; cv=none; b=hDLFiu0ta0pao45OuZqr3Iviium8Lq1TOG31Mt8OZ3KtzovaQyb1oZGPRizSbJnh/WRo5Uiu1J7+bZ78pbBDyYDrIC++WivkrzIgii5PgbnYvAEx9TJE2tQ1C1HvEZzFT0dBAhavviQNc2NCygTiQCi1RTOj0X6qr6epvvy7Hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545091; c=relaxed/simple;
	bh=lzV/JOwZceG3YxOPL82K2UBdcZS5W230ZAh1fveVVcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bb+1sic1CFCGWignvOgyVeLPiRZxmpCMFZrP0D6EpidBtt0MH2G8uEOTJ+kJrkuBvAO+MseF5BVtOpf4KQ8VezFMOeKDCTPcaUUHaV8KkxRwo5P2l7KHM4xWUwRHQh9SQpuk4XWFbWZ4WFXKFM3I1ruSe1ei7bOnpJ1GsXa+Fn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9aL5ot1; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9aL5ot1"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-157fe9d771bso1958370c88.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545082; x=1792149882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=je2Q3HHMwOmDG5bekFREQfFaKgEfAjyCYUmGYt2rUu0=;
        b=K9aL5ot1AVomxF4MmjhtFiX4L5DWlQr1g/wmvMuOdSzTLg1quU2zmro2CDX4cUIYgu
         YMWhuJ87k7RusHDoCQ+Nh2SKvOWynLBisA00Ec/ZhzirRLemu1UDrmvxaLEqWVz4tpPb
         Z+AvQA6Lf4RGwrlCRBhrxu+gyv5kh8Yv3LZxaoTHA05Llbb9u0i6UHTlhWXcFfGFLK+J
         b8Mly2zCms7m1+8ZYys4w/wqL3VunMM/JJlNho/hk0DXlv/Y438I50QrDBsV1UGl+zxJ
         LDMOxB89VeW4nDNXHAXTCIjgmLMOGf/+DVXC5OCO7XKCAfhcMO/EYCAqGnBmri8jRYfg
         mwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545082; x=1792149882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=je2Q3HHMwOmDG5bekFREQfFaKgEfAjyCYUmGYt2rUu0=;
        b=Z98grbSXxZtsZ/dLxCHIhwmkYFHu3oQRGpd1XrE70AGURRMwTRntXL1XCgsu9KlaIN
         7IsjJFEgxxxigrMDMhvDGCKdjUf2vuTQG+j64+wyaFiKJ0e31dVvM+b/exqAmFjdjtn6
         FpA/jFzWcApYnR3PhtW5jr4PIaftlAFwr325CA8KZvmfa6Ul7c54FHddxcf79xy4/9Ck
         DKOwUbNnQzgGYK6JhA1tW9uxcZVs6ebfYlOM24bRBqHbO7bW4vZIDBuCL96YlVKU0scx
         obbyqddvQnjN/gfLRMmrQ0PiNu7HW+Z4FSuCyEmT/dKMcPfCItvwtOhNJVc13knnAKNh
         ZR2A==
X-Gm-Message-State: AFuF++lTayKD7naiHIMvcJSVO8MRyX0KLB5uZtthpr2gWqlOYnsEPR6z
	F4HZ9ZSocHmH1fEHJlBGHUAN/tl5H1vyMB5BY4HFRGDVJufpMHUVS1llocoRYA==
X-Gm-Gg: AYBFou0a1LVcm16iukpx8Rnsb8cXXIjX7yoMBLm7z2noNQ/6N95ZxBNMSXT9Rh01lRl
	/i9w3TAWA5OSlk4AEKBMwkktNCLsJ+8rYz9f80dgnC9bevLIg5kK/uqnXXwPORLQpTiaHgOODje
	6YNearTSuanSHmZ/VR9OVMUBVjtQw1ElNjIS1o95o7F3o4zZrbk+9P6bxDogDQOiXHWgeLaSZDJ
	eCvvXU8pB3Fs9iwaXZTTiXRrIWNjoFI+wExc5s/AhFaMBSyue5I4MH6iFYwRlPDKC/Qnsxmy/RL
	MPmQWt/K0A9A+de09xo8PDNcbsE+KeUUQSVWkjCKiSSljdfNWGNBQ45UGHuGxP4P+/QnIUhpFww
	k+VQm3Wf4QIQLGyq6fkIylP0XurA9XCBDK7JeK5+HCAdro9n5+FeUAT1i3YkY2Y5rJzUGA4HG30
	vBgVUv1M5S6IpDK2Z9wbbFTpY5s8bjKbnSuFOIYd4iPtlcRzJ1vDtsDp2AfZF9CuIwo6AhB+Ahy
	3UM6QkKikm52mtFRYK4n2lEdGM3quidGimqa2/QMbc/dCochzrem12e4FFfWc9pUC3fv6rObfwp
	DQXF6BBuT/3S6w==
X-Received: by 2002:a05:701b:2309:b0:153:7a27:b89 with SMTP id a92af1059eb24-16a5ed4008cmr2359046c88.21.1791545081842;
        Fri, 09 Oct 2026 04:24:41 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16996eac537sm6304632c88.1.2026.10.09.04.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:24:41 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] power: supply: generic-adc-battery: Propagate charged GPIO errors
Date: Fri,  9 Oct 2026 18:24:29 +0700
Message-ID: <20261009112429.33318-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

devm_gpiod_get_optional() may return an error pointer such as
-EPROBE_DEFER, but gab_probe() only checks for NULL. The error
pointer is then passed to gpiod_to_irq() and the original error,
including -EPROBE_DEFER, is lost.

Check the return value and propagate errors from the charged GPIO lookup.

Fixes: b0327ffb133f ("power: supply: generic-adc-battery: Use GPIO descriptors")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 185f55d2fd70..f3ca3ebb2533 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -238,6 +238,9 @@ static int gab_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register delayed work\n");
 
 	adc_bat->charge_finished = devm_gpiod_get_optional(&pdev->dev, "charged", GPIOD_IN);
+	if (IS_ERR(adc_bat->charge_finished))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc_bat->charge_finished),
+				     "failed to get charged GPIO\n");
 	if (adc_bat->charge_finished) {
 		int irq;
 
-- 
2.43.0

