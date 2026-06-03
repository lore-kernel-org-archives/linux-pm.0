Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356EE480DC8
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491625; cv=none; b=crR0Q5HF+VeM4J08kSOQqbc7G+vBWz77NN/fQTDGeQzkO8fVF+tSFYccMsOptKuSauxbi2nalQRClJ9q4P0MVrrZf0Wbi4ZLNtgiA/pzgn99mqv9KjZeYB8FaLkZcrqEZMZI+liALnmjaugpEprD5bswrG2cm+UQPlZfueRauj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491625; c=relaxed/simple;
	bh=BuCPimd0wnIGZnAHNo8kq3fbLznVxR/5ajKR3GVVTto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6pe7ynt61sxwnr/27I8XAZOnN3Y0urD5ZAJ/2b7+NUPPK+kS2vK5+6nX8zZ0FQCVi+pB7pQGUqtAYIt6viHp8WwmjQiUUzvySibue2cwjisO+p7aapk4FW07cmhp0nr7xPNmlT8WGtJ8J7OAlYnrJzo1HJI1mebqmeHG5yZ06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLhrpkLz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLhrpkLz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso115558725e9.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780491620; x=1781096420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sk5k1GMtYr/HULN9/BDkc9qWrRFDftSIlp3dBX3ccaI=;
        b=eLhrpkLzrMhpBdXJxSskzpA+dYNMjGSqQfyYFqyiowQZIeRUVXPB0uIBk3jXq2SCm2
         2k6OORU+0vzcoYmcUemsCW3ul9SHVj0NSjk/2sD7lPWMm5ztBM+UbK3WyFDX4UQUrMDi
         GRKKxmBJRGJvrSi/8ZcyNhGZdvKjHRWVfBoiEcpaXIYma7urvPGqWgde+veYcFt6GjXQ
         J3d76/oPA3EP9rWn9oXqEVsHu5/3rZ/eyyHxMF5v3hKnRCOYRfv5yRIEM5kujy2B/Ma6
         e+5ovPhP2Hjkh2RSqpWLN6hWRYrRnOquk5UZiP4wrDt0REWxEoXyxX8hAxv7Ilagunv2
         /FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491620; x=1781096420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sk5k1GMtYr/HULN9/BDkc9qWrRFDftSIlp3dBX3ccaI=;
        b=G9AdhVgj9X6Dvw11uUK/AQvRUQnmDYeiu8N+r1AKkqvP898h9KlVXFXOJxk4lkSrJa
         +0BE5zzX0PDSIoHxr0h7sOLpaOFpiKhUAgqnQSnbOhwZUtNe5snoSRhGMMXIsSCSy5Bq
         eAesVz+Y8/f5rl7m9sXNe6Bt1Wb244KLxNd+M9Dnq6M1HI89HgrKiZHue0CODclKbscy
         Bsda89M9iunTbUJOr/TvvOw7R+YIqDm97OpXfmZWqk0eVUQLip5uacjVNM+Hw47fDHDE
         2hdfnJCwdTth8OHtf8aL3yY5uiARPNq5bP2zhNGEskhEie0Ggn1hkvUKFSIISpjGaF5e
         Rh0A==
X-Forwarded-Encrypted: i=1; AFNElJ9nXnhagg/tq6AoFV0ioJIswfjt9/rJzBr4Xt6ML3i5OjB/oZ7MbRcpqNFRvfURIFdLiRRTbW8EZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFykHCGD4oSruuzxNzLa0qfetg8MbRR3eIgEvbj4C73exWEqY
	RorOVESVe+MAe5BOOlr8UqZp0Gpt+KGyU07u1i2TBLx8LKG8SUBu0SNCDjXM/kyNOO8=
X-Gm-Gg: Acq92OGNbnQOdjRI6dhCR9hcTCLiVTbuICk8ZWDdIVldi6FEfYia15ZM0beftS1GxOD
	25/9NctNOIRyTuIhuTSpCXPCs0XpSz37NdTtbd8MWa9N1bQmZoY8ramOcYZOfsqimwa4pLV41ZR
	unTCRjPwNpvQaikouj3sEfvp6j66oKr7ky3+GjBssxNRiE2cGT7yKWEguC6pP1cF3QmQPjCMGdo
	B5piOJBe32trG09RG+pSBZzfu1DRvhpx8zHOMyYu8Q/sQJ6815b8zLezAWuxiXJbOGo40H4ddtE
	oApFcKTPLSx/WCiBKir6TwQZwbX0AArg2e7CgHlo/kHa2zEh4+p5OkTV+hxKAnlSl1oTJgwiHRQ
	NrpSrtlcfc1pZGTxXEAwKHLm5p7cgUPtemqDLfDqRtsuYil1d5AV2npyQUm4ULT81E3pt23ukF2
	8uty1tUU4/+H7KyPndBOU7nokUA+L3o6Ts6YfSTT0QHyD2ua+vPMss+gGX6mFsAcKTazwUh8LD8
	JPnC5QGE3xOnyw=
X-Received: by 2002:a05:600c:35ca:b0:490:5527:3be2 with SMTP id 5b1f17b1804b1-490b60e3d76mr59120555e9.32.1780491620405;
        Wed, 03 Jun 2026 06:00:20 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm149179045e9.14.2026.06.03.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:00:19 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Jun 2026 13:00:18 +0000
Subject: [PATCH v8 3/5] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780491617; l=989;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=BuCPimd0wnIGZnAHNo8kq3fbLznVxR/5ajKR3GVVTto=;
 b=DDZhmy4QEP4ZUJ3uSYAEbuRQYdLBa/kBCUb/9RRroulU8b4Zq9zpGbgR2jB1y/YeZYSXwq35u
 DpIMVH9L39wDoT0TXUDdgkEeWc0sFgtrSbGO061VKn883T2zS0XCYWP
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8218c2749b7..6a8521270daf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23661,6 +23661,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.54.0.1013.g208068f2d8-goog

