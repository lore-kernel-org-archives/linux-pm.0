Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030495;
	b=B0V53ueqMQUdB4AfI8mtJiiHD0LPiLnzkFspTzxFfuRWJG6KBQ17xS4Ualf6Gk6WEEjI
	 kCOCKcV1iu6Ho/nHjjg5W1rz75vvwAbsSW/qFBuC3B39KmowrHIAkO7cMT0nHWxfrCuyo
	 nJApQYV49tLaBG5grE6xMmyQsCaBZHVAsw6wg1Fucbc+2SMqK0t+kQRQKIH2c28xYbO+t
	 3hiMwGLeD2DZNWlanpg6/l4ib0u7Gmf9soBmExiCt/RoRZSzbWqwqxIdugpQKBlWFvXXR
	 loV4us9wCMZPqFXlJOMbHsQvu9WGNiVhw36i6bC0N09tGUruZZ+38DypoPzSTy1VK3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=kBw7AsSPjsfDBCQewWzDRPOIx+yoCp8Gcws1tr4ymx4=;
	b=zMRB0HW01kjtJ6aXKfX+rysp+79RAsLeh4eDS+8FfRlWZqwRQVT3vhZCQs1hNPqlAP/U
	 kRMzgOjH32qVKhnENoyHCTS5uKP0G3vDoiIj3ZjPxhH+TGFpUy/fPuqUOEle2AwW29cmg
	 aZA2Iua9hSeAJZIZ5Jvb/Q9e1lE7NTfMn0phSud5h1JLp2FrCFEzS3FfPm7i6vIPxvG+W
	 dAW83MbpxEZtLF/otaUgto7H+ZH1FjIGSxpaEzjfDq5Bc8cKfrkGZm5EjTb7nFW2Ygk4b
	 gTp1ZkAljKZTFvs2om7fip+IKKLtJn8kFGFys1x/j4A9cpnRM4q91Wh6Xhv1Iceph5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q2+gKLTX;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3560A2613
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC3560A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q2+gKLTX
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c423b145922so426714866b.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030493; x=1793635293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBw7AsSPjsfDBCQewWzDRPOIx+yoCp8Gcws1tr4ymx4=;
        b=Q2+gKLTXKBmiFtZ3oS6jQ/Alb+7Y8/226FUbzVO0UsRgn0WP/nSIudqsHDvjXVWlYe
         ppKS28mUWuunFTQtgq3SL7OpecpO5D87T58jH32UNB4L/hAPcqmu/8aSkrJM05L/ZNbp
         uijzsrmQDyDLNoCv4nswrIlEfI0NCvKa5H4/aZbyATgqu/ekcUtezv8kqOqPBFAyv5ae
         1yacVh897Y8xxclpOvfEbgIwheoneVYdNswZ9dkOj8TKA6JhrnnaBWLdv8DTlnd+wOfC
         dJUE/FDAWdd3OTlm4hD98Hs094pws974LOzbU5vUIrWNR2n1i2FV3SZwBuPuU0lQkAdB
         KiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030493; x=1793635293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBw7AsSPjsfDBCQewWzDRPOIx+yoCp8Gcws1tr4ymx4=;
        b=X1TJVZ6UCc7cCP1ieplJgUnwJoiQXhiTJcHZtjftsU4utBuNBKuSpUzOEBzMfjkv5x
         95YG5PUl7+3l/K8ZW4CxyR07D9LtuYDOyR+sT613R7kY5ayzjMHXRCPp5TRvfzzI0zfA
         rwQIF71O90kYohBjteuv28i1EAAaSoCMjA2ZoFav81DfPuXlAEnyqoS2pncRsIMzqZJD
         W/RGVD5+IpGprLW4pjmpadWM+UyCXXQVaxFa6DBiVHIDPSNiaLqGqZNWrumCVElGtw+6
         L1/5bUOp0jjupVYzeMjW7ICaaLD8JwQfTdhHreqNM9cp4eabm2Rqauwk6uz0463RT4EJ
         Kznw==
X-Forwarded-Encrypted: i=1; AKwUvBycSdPVdcjvxWFuUo7UaPup7jLhVvXtoy9scfpaMnFxlGRmVtPJuxRSlK1y95OKP/Iyv/l/+dC1bA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6xbx/aMfbA608O36Gn/KWVtkmOA+5Tbbq6bsUp9WzCguJYum2
	CGYiJtwGkiE+MZ/JqeaRuYJ3tfpyuG3ElcetKPgR0CkCfrt0AZa831vd98UCrHrIUcc=
X-Gm-Gg: AYBFou242dn4dEAT4ZC8QLuAkdBSM5VheHUsBSoXl3NSOSdNdVhPuC78E8Z+rq0HbJZ
	Nw76CSsdxk8jbZmd+MUc2gtNAX6kuw2hW7tLqvEFbBr9O5UW3vehcWvuU7rXqLlZhOhFEPe0zF0
	zztg4MMgkVNeNenoJuqrqeEktjlJ15/rC+ETy+DTipkfewmnocYAp8znquxGW88eXlxVL7Dm0QB
	LJurkOySU3JfpMvoHEC1J4Lqu0ML3ADYwh78hKL4gKczwYAXwF1TnmxGCtlpGoup+cujAtpnlbR
	/FnFDoFC8y9yJ9MTCKaLwoUg8SlErrFPfw6VMXvgEko1cqLi/OlvBs3hxwWflnVwJ6V4voZoWT4
	qQVlGrj/k7RlJocFBVZ0G6ynf/T7XKLzfmWR8+QEHbOfLC5wunT4bVkykTapNe0v91DqtBfRVXa
	QfKUF7Z5cdEqap0yNH1h/F+YUIkQ+vvG+2M9NU7o4q8LNFRT9N8DCtcSjxBHXVCyjVbyG9CMhEG
	nRyNETj3A0bqxhNOq68YSNVrpwoPtdnrOUv4sN1Jwsc3l5HirGLVgbNRcDuuLkhIY3GTCv1HUle
	kysrC5Dwk8fDHntq2P23/RRTVus1oYxDmp7Che36RUeopY5dgRW9z/dMxi0j2YlOv3QTjMvv/zC
	N6Mz3uYrzQw==
X-Received: by 2002:a17:906:7952:b0:c24:adf4:5c73 with SMTP id a640c23a62f3a-c46bdaa744dmr805676266b.1.1793030492733;
        Mon, 26 Oct 2026 09:01:32 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:32 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:29 +0000
Subject: [PATCH 12/15] thermal/drivers/samsung: Drop redundant composite
 object in Makefile
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
Message-Id: <20261026-acpm-tmu-fixes-v1-12-0637431b7268@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=884;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=SDTotlLZ4kEAoPrEqW6PvwCyKZkwJhZmCCGyB1TBPzI=;
 b=JadGXkbxn+EafNhgFKNtszZPIyTWdwhW8qTIY37B/py/BVkrrWmdJpOWgaeZTF461yBeuiH6t
 pQrC4KFxCwoBCxlHTzjvL6fSlwGnY2iXIZSE9WCw0AgKuhCRPGCehLb
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Exynos ACPM thermal driver consists of a single source file
(acpm-tmu.c). Build acpm-tmu.o directly under CONFIG_EXYNOS_ACPM_THERMAL
instead of wrapping it in a single-file exynos_acpm_thermal.o composite
object.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makefile
index daed80647c34..d5b6e9e05377 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -4,5 +4,4 @@
 #
 obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_thermal.o
 exynos_thermal-y				:= exynos_tmu.o
-obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+= exynos_acpm_thermal.o
-exynos_acpm_thermal-y				:= acpm-tmu.o
+obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+= acpm-tmu.o

-- 
2.56.0.257.gf7497c7d27-goog

