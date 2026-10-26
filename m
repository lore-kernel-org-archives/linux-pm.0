Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030494;
	b=J1kIoMWxEksBFOOG+bz9a6bXgrMiYHv+Ty5NaLaaRISM6NNWfSxvMyr5EjIY24W3MfJc
	 NtSCbM/QKvP3ik8UQaAkHFLrD07nLfAtTBFZuUuudrJQdzKdBPvmyCOoQQ31OiDkBh5NU
	 Osu0OouKi9mqVCFMqtti9IZ18M5BqP0Ui80fWqO+pBFpaDoOX7QvE8U1cYidNR0p7WWgd
	 xj8JhLOEilZtiDkYyzHBg9i7L1Rv0zY9/yoqO8Vry2Eu3XFPS4mQWCoLHduIMemaRG8ni
	 mCuMTZVQtNeffOuvnhYm98dW/XMorhrthb63x88IlG9AVCzbp0g4l/IpkXfYKqd+mOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=K3sKvuhBViiGlLU3TkCVl1Keg1pObMrKBIESSV0t2zI=;
	b=Os03+37mXNL8f6Pj88bLvFw5at+jhUlN62GcdMO9sk7o7TuWp6cpF78u7jBrkxbrxZx2
	 BK0GLnPZ2mRS2uLa0sV7vevZzMe5xxZyOt38xRMYeoIqrqDT/3FwytyGleswObNnsKpow
	 O6Xa3/Z4DJ0jbo0zh8F39UPEPE6baNuUv/PEmYd74SXI7Kb8fFwIqmzH4Vti+SyxRRX1u
	 P5K1tK96G0yw8FkGBK2QT5yVVXF5+NPcNIVFUh+3jmkUIb2tMt1nlQbhP5if9TQbmG+YZ
	 32MTSxRt2oq3Gc0zDWoxwrjQ8WR0pS48Yp+IZhxnHmoaHQOYXmNiuLBR0DOwGFnY5cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gy0DTVQr;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551C60A380A
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5551C60A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gy0DTVQr
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso487770666b.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030492; x=1793635292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3sKvuhBViiGlLU3TkCVl1Keg1pObMrKBIESSV0t2zI=;
        b=Gy0DTVQrLWfIPaQzWTsoxJdmXUaoLO60RxOiIn2NcsjY0qLd/YUHf9FPyp4pku997H
         2oZlIQQxp19q2U/moXXwRMkMqGSKDGYN4XJ7q7zvaUyLgXTcv/I8SDs7HorJ1QJWSXbr
         4vunZikuIuU0uWS8VxTpzmh9sP3DO5N4ExUv46NkvA0lQ4iXBgrq0lXsW/OCNAbBt4Uz
         WFHNdP/wiVtn/206+6E7Krq4EZHOQVspCDYezqamM1H4c7jIsTrLZzP7yRdYJtObc2zw
         3bfEa94JqeBeZIRHwLBTRnBYvr95ZC7rbK7ViuTNIp1pGA0hHSqUKrlSm4Z2Nu9/O3+q
         sxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030492; x=1793635292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3sKvuhBViiGlLU3TkCVl1Keg1pObMrKBIESSV0t2zI=;
        b=jNcJJJqrV3j4y7/ijB+dKRJC/G38gEdf1z5wUXN0rDhIv/zuDmb9URJC+KmIMDERM7
         qtMHCje8QDux6a4nGjiuGAXdecrSWZEtPnNbDJ/kdeGwi1D+37+Ov4m6LVwSMXBeB9Lg
         IWsAgjM463J02B53G19nODYLXqOrAtC5/mrvQaamaln8r/XAPWnC0TUxfSpTuhaWp6sr
         7zilE2L7Uq+BD3BnHEMlbF6jVs7P+mIsoaVKJNBEi6xTMlhGscHeA7l7PIesDjBP6mxo
         sXeV1QDz9Nx4KKijDg40IqYm2q7UilsJksywvNK6GnOOhHWrb1JnLw8hTXBSqb3vMV/B
         mU0w==
X-Forwarded-Encrypted: i=1; AKwUvBwki3r+2awGMNXFXxVHwDkUHbeaq722PBM91uHx8ZZIDp5ccAmyOwQeZWR6Bz2LLYsneVSRy3Zg2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6uTJBnfwgtVyjIcBUPXrxbjjZkhuj0zGw+QvVaQUCJMz98xLs
	bIWIiacHo17ZvNXaYcFaByYGKyJPQXII+mFsml/D16fV0+UZkZXaX8VzilFy41o7Qzo=
X-Gm-Gg: AYBFou0qh4rTZfUbeIy/pHp4oKD/bdRtgM/zCucz22KYm3NfXxcvqC0s6GGQA2f+WyW
	CXxOYryHJjnUgln3VRTwi5dnuvuJDX5QJlaLg7l9uzyRYU/xzHpJ3M743syDVPtnldPoUSGiJWW
	s9EzQxnWhmWsRUdu4uU9DEdBNe3eVLxZZ63XyTJarXJnvmKl+U5xYiurGwXeYZO1YL/toVGvZNh
	nrbDtK0i5MRjzGwg9dIbTCjq6zOGsweEQYwZPElt5PqJ8P/LVwC5mDDHJJZn+8z8ahhmzUbxMkg
	EVmIvc2En1wcI4R4T4lEbpmLwBvI9iHNGH2XipW0d/QgTIauj9I/wNl2n0dLBc6tAvYD5CQSY/r
	U3/U5wxVzCVJ10sDxXmQLLcmr4J0lcwWsOIpVixodqFaIWlOZezv93EHK6C94aUkOu1Ikp854m1
	KmiDnQ41pJVvppiayqtfmVwxVZ4ZcDSKjeHSADS3sYxpBYOlXIneiwp/SIQVqDjHtriitTQ0CTi
	f47cveJ6ktWLncKz8DBiT/bpvItaRudJHXGo49CWx2EkR0QTaUA7rhLFGh1sHUn7PWRl9L4Q3ai
	pdT1l1xv97dcv2o3ZV+PGR23T8YugUOBa7iG
X-Received: by 2002:a17:907:3f1e:b0:c3e:d0ca:d2fd with SMTP id a640c23a62f3a-c46bddaefadmr876184966b.12.1793030492156;
        Mon, 26 Oct 2026 09:01:32 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:31 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:28 +0000
Subject: [PATCH 11/15] thermal/drivers/samsung: acpm-tmu: Rename platform
 driver to "exynos-acpm-tmu"
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-acpm-tmu-fixes-v1-11-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=1029;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=kKFEY7/HvEq+100xRnR+XskO/ds5n+vISMebLJ4Xmr4=;
 b=ec7B0504Wi6Z8WS8KfhDktthnTx3XbHQeg00S34wCbflTe0KQVBU5L4yBFWkH1RAfbPukMl7S
 +PP33+KjN88BE+Y3NUBrjPmJBAV/M7X3mNPO26BGuX5nceHOnSZjuZL
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Rename the platform driver from "gs-tmu" to "exynos-acpm-tmu" to reflect
that the ACPM TMU architecture is shared across Samsung Exynos SoCs
(such as GS101, AutoV920, and Exynos850) rather than being specific to
GS101, matching "exynos-acpm-protocol" in drivers/firmware/samsung/.

Suggested-by: Alexey Klimov <alexey.klimov@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 42b338d8d093..2324efcffb84 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -597,7 +597,7 @@ static const struct dev_pm_ops acpm_tmu_pm_ops = {
 
 static struct platform_driver acpm_tmu_driver = {
 	.driver = {
-		.name   = "gs-tmu",
+		.name   = "exynos-acpm-tmu",
 		.pm     = pm_ptr(&acpm_tmu_pm_ops),
 		.of_match_table = acpm_tmu_match,
 	},

-- 
2.56.0.257.gf7497c7d27-goog

