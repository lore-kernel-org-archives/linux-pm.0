Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009912;
	b=K5g0Kb7oFtnPSbhVRCufn+vYDR5DUm1wIn0BoqNvy8luAn+rxn4ajfTSxpeYw7lUPykh
	 FIT2/Mk5GSMzu25q4ZgdlWTHJebA9tA/QFVB157QyEbqmEfe2TAoAZ2+aUyEPtD2Rrcca
	 AE4Clj3GxZwMegqxPgCXJfli0x3+p7PNfNBoxOlYlpuZvaolW0R3C648TZItFfYxozIRB
	 9IeWrj/UgZLLZCEcXIsqO1OXbyAxdkVcfOmxcqHg/vu0L7J2L3lFJqMEIMc+YZAFfmWnd
	 xdBt5qj0nUuBd4ZAs0UBj1Nk4NLe4yow9JnQttuyo+MdVBnaFWKskd/a5LCNmQTwORw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=GdYjun+ir64EdXqcZidFlUVCp8VDFd3V0EbMViH7Z2M=;
	b=iuMwMcB9Tgd1BbaJdhfa14MaukSb//a27KxMC6H0V8E/fX+F0AV/0HQYddjSur5R29Ll
	 8ANGEGFIdbe2EtvYVbw2+8xdx6KiVwNOMxmNTV5w1+Fw0maKe4Njq6oeQ6fkMf7ceS+u5
	 pbmGjVVXZt0C1xq9mkUbDxuBgBH9vjJ6Y09LOsZ3mUUe4qkyLSeHLc18JnE8utbKMhkSk
	 mFUu9dmJ1lQICUcUB9aCMR70M6RHCDs3bGkWFgbZibvT843xtb0kjPAQu0Xshe4Boj8WE
	 PIUG18ZPAsubb7RO53uD4M/esS9spkly5lNZ+8nQKFQpMJtThznfI6ARE6VqDpGN/aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FhSimmKQ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CABC606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CABC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FhSimmKQ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so5587615e9.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795009911; x=1795614711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdYjun+ir64EdXqcZidFlUVCp8VDFd3V0EbMViH7Z2M=;
        b=FhSimmKQk+9xaAJLsGe6wweNZgJKEn20mxhnNmEZ2n1WzVfq6fxpNehYKmyXCMIQP+
         ISIXYUSMtttMUZhi16+tqYXiViPcMYK7L8UfPfbikWkPPiOvMC0BiMjCJPMmyxChAtQ4
         Zb9qbyVHeAaPiD1PjpPTB0J1sSuOzjg027w+KsIC2QPh6duB/VEBUxegSTPJXV0YFpBM
         jlK/RqpCt8h60BFHaaRtTmH3i54NNhPeBK39u4EJ9thKoAuRl//AYCm/JPGrD7F9b2/3
         t5Ne66aeFMDetOwiHzJzK8CBQIc14bj9fs7TWdOXrVvw90n+KY+SDA368Bv6lrahVQ2F
         /xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009911; x=1795614711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdYjun+ir64EdXqcZidFlUVCp8VDFd3V0EbMViH7Z2M=;
        b=r2tHUwXYU8KNz9L2cwdjeQ7tB021+mf3DcXQZskzuVsOB1Ij3OE4CViHHPBl2LBrE/
         4/AucSeLH1uSHhOvln+cRt6B7XNNz8dEbKyBUnV9L86iBajJyItFeDNrHwMwa+c5Z+Rv
         frXaVuOf2LrovFBobJc3ILYsvh9/CSxjAk52vx1MPfTr/T5RBm5KH2bYXdHLXuou+Nty
         1crLNfHCptME6/UeE8+OKQkkqPvgHIvJVtuHogGnBpne4v1wPWl/J49ATd+Mk6Nn5zeo
         Gu2nC9w/D4+zJnuukDX4+dKOPJHL1bZQFnPqSBplPkPzJteE4FDaZyy3N5H3F1ua1nY1
         B+qg==
X-Forwarded-Encrypted: i=1; AL+hErF7EPhHvj14e45Uu5PwJ8pZS0hCdW9Uq9DwVLR3Hjec5F27OcC3K/466aAC651FObx9m2XbKgD2Rw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+flVuq0L0XKVyKKwdmcRFQLZILa/ZJsp5a0XDBGNs+NGteZJJZ
	LleKTcc2W8Q25IG1w/HdM5oFxI8bnMWJKKqq6/Nqvy2ZJ2GXmNy0qj7+3TWaaC3EH5U=
X-Gm-Gg: AYBFou2f4LJ5W1wN8rnETeQ30fIQLORA99Rm0x9lxfKUT2DaiBPL/C0ZhvF4mQudnt0
	1lRcUpdVWP/VnYWw9MUa4VDmyx1yCMFD/YesjWKM+b0wdeKKilFeJ6ktVE3D0AsqQ7l1SG/RDVL
	iVfL01JfMkBlkXHG4lz/8DPa6ODajJnIZkqhTLIMVt7mJV4ywqRX3r11iXbkZAgSIFFSq2TAH4h
	SiTQXB1s7qK899Smk+CYOvJ0aZK8kgayo59rpVFDj0KWlh0JwCvp6JmqtsMuHf9cGrSNEkvxm9u
	snkrGo2XOgYklesH0ivqsVX1ioncLG6QOOHBa1Z0ubGWWJDE+zJ0BbFUSDQM19emmzjjcHOfJGS
	mhaoPDVl+CsE4XoaxIbgK+n2BEhAz8l3QB/1H0z5ZIzSKIYe1qyu4WVIaCyP92KQXnYvr4Cbw4p
	cD7qjSjRZ5buOTu+WCtyN6F/9AKwqGh1nr9RTLPjlcXA/7Jt45xOjId7nnQupkTSwzT0N8h8AWy
	TswUAJZTa0SIvW5E3pOUDZB2QA4dUJ/rGlCG6wEzLURwqm2K/78JQ/8iiUvyBU5m3geXRWKZBwI
	9ZgCZz3du6aB3/moPdwEfYw2Fv9KnKEomh6pEOP/Pqy2iDT1hXwfR3aOaeGtHNCQ2ZnRHTgJXF3
	MeG06BXtyBnkBDsMzFuKT15Q=
X-Received: by 2002:a05:600d:82e8:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4bb7da18d83mr47018785e9.9.1795009910482;
        Wed, 18 Nov 2026 05:51:50 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:80a3:e955:3785:90b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm208544775e9.10.2026.11.18.05.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:51:50 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 18 Nov 2026 13:51:45 +0000
Subject: [PATCH v2 1/3] dt-bindings: thermal: gs101-tmu: add Exynos850
 compatible
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
Message-Id: <20261118-acpm-tmu-e850-support-v2-1-19848c0d97e5@linaro.org>
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, 
 Thomas Turner <tturner@lineageos.org>, 
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

Document the `samsung,exynos850-tmu-top` compatible string for the
Exynos850 SoC.

Unlike the GS101, where the ACPM firmware handles most of the TMU
initialization and threshold configuration, the Exynos850 firmware
implements a significantly smaller subset of TMU IPC commands.
Consequently, the Application Processor requires broader direct
MMIO access to initialize the thermal unit, configure thresholds,
clear interrupts and collect calibration data.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 26 +++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
index 75560ebca48d..bea208cd4619 100644
--- a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -15,17 +15,27 @@ description:
   both direct register-level access and firmware-mediated management
   via the ACPM (Alive Clock and Power Manager) firmware.
 
-  On these platforms, the hardware is managed in a hybrid fashion. The
-  Application Processor (AP) maintains direct memory-mapped access
-  exclusively to the interrupt pending registers to identify thermal
-  events. All other functional aspects - including sensor
-  initialization, threshold configuration, and temperature acquisition
-  - are handled by the ACPM firmware. The AP coordinates these
-  operations through the ACPM IPC protocol.
+  On these platforms, the hardware is managed in a hybrid fashion, though
+  the distribution of responsibilities between the Application Processor
+  (AP) and the ACPM firmware varies by SoC.
+
+  On the GS101, the AP maintains direct memory-mapped access exclusively
+  to the interrupt pending registers to identify thermal events. All other
+  functional aspects - including sensor initialization, threshold
+  configuration, and temperature acquisition - are handled by the ACPM
+  firmware. The AP coordinates these operations through the ACPM IPC protocol.
+
+  On the Exynos850, the ACPM firmware implements a smaller subset of TMU IPC
+  commands (mainly temperature querying, basic TMU initialization, and power
+  state management). Consequently, the AP is responsible for register-level
+  access to initialize the thermal unit, configure thresholds and handle
+  interrupts via MMIO.
 
 properties:
   compatible:
-    const: google,gs101-tmu-top
+    enum:
+      - google,gs101-tmu-top
+      - samsung,exynos850-tmu-top
 
   reg:
     maxItems: 1

-- 
2.53.0

