Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261041E6C5
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576828; cv=none; b=HXMIYFHDo3XTpcp3N9qYDBkBjjzcZB2Zv2NikPv8Nc34QUgeL9/3ve97kBmf3FP49HyE24hC4niTE0ftHBz2fdxT7BHfuv7NGCrbA2k0JKZ2L/bIqWk87t+lHRQgV5B2ZITRftU645PKv8t89EdtBTxV7CLXxhSbcVb+xFkRdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576828; c=relaxed/simple;
	bh=4RIma+Y+HLa539L6LCBdujL9cmImh2ch5UAVuCX8GcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGS1G3IOGCZj3Bg/fzgvMipRfgP6ZaxWhd1AbrZuC+zNpX4T7QHKGEixGvua2SayX8DrdpGBN274lckk1N9SmP+5rlBskKqX1bChFydvn9IS/+6xJFOOVGwXaUWcSXU4Zr90a9K6RqDuV9aF5jzi7Ci/pB31b2kGtLYeIah3NI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bffr6PrZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bffr6PrZ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso2250401a34.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576826; x=1788181626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FyimhIuXwBU1D0482FUuZm2aPAmZo3McPam/rouEA1c=;
        b=Bffr6PrZnY9Goe/SQao/FHiRWG23Y7ymKvkiMomxRf20s06ddC0HX4RiTVkKPrxcJI
         rH2FyPbTO58JNxMsaiKlMYQ7xtdauRm8nekzbPqZjtOzNouCIzMrHWQ+BI7t0NknzZiy
         1zR7XXU1N8yZI+LvWHwgmw8MpadIpc/TQAiIO/MHdRdvbRbImT69AU2oU+oek9nlvHZm
         KeV8qe17+hVBq1W+TqqNATU6ZrHCiyJoY8A6yShG0O5kjFaaR3cWBBuizCPlzbK/Mins
         Gi/3Ch3p4rlJ0PNW19pYCsEpZ7Bx27v0LhpFefMnuyaFepO7X0u7Fmh81Q0hSw4r4FQL
         9qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576826; x=1788181626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FyimhIuXwBU1D0482FUuZm2aPAmZo3McPam/rouEA1c=;
        b=k9Tw3xkN3KKCX9Ln77+cqrMUyUVUGB7QqU7JyWeibxERcJ3ppjY6yt5aooRD3HO17R
         z21s/rI2gcExfylb/MA3bk7Ee+wMJ6KictWvSwc5+pPW2TC9Zl9Do518AWSSKeLmzLZl
         e9wJWpzQG6KZj9Dtp5a4Y/wUlUVO3fRngmHuHq79SYDnBgfU9mBuXrKYU43PJLlZCxhO
         RR7mkgV2ePnwb2dnilPZylMLC1Z7aGqEJoHysp4vPExCwVRt5EsPQVvJRwwP7mhxJKTV
         mhFHigV7HQpOw0lVWBAo+RNewQANQu0pi68ADAYaBocM19CO/EpRTAcXHKdmg3fq5rs9
         G/RA==
X-Forwarded-Encrypted: i=1; AHgh+RqqVTnt7HTqGmk6Dg41di8j5VPBvobq68dzNeDqxb6+71QtlmrmFZT/n4UzNdUw8YorteTxOZqnLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n3HMRrK6PFOtY1zTLrChAEaHpPx+IDc9pD+eDxEsRDC5OUdIFl
	5ptAZD7aLezJwUPS2nqZzrc4hY/NLb86XM5Hg/S9SZY+gpK6Xp9ksS4D
X-Gm-Gg: AR+sD10ANIXmN8figeBINViH7rdWiiGdXCQMghR8rmw5YqjWeVKu5CCDQlyB1+11uhX
	gCXyKXxFsf462/kqMwWGoECSttr3khdB7bS8nODCb4YRpxVR96UuEYGPzhhi+N0S6aopPNDVK7Z
	/lQAoJjzS/NjndMnS3iVlGzKUL037MWyxzV9W3Ej8+E8wSNuen9TaYtSYJvl9ydyd+WXZUsa9V0
	D81q2vn1DOtQ/XpLgF+5VHHpRLGFBdyeVVNyWIRB9mVDnOeZGs2CQqY2Vl0DIyvZcZJtaXsfYrT
	qUDYRhoww+oNgf/ODVUtltVOceh+vNOWJ5P7Af9mbmFl7Vy7OfJrkt6u5qoPhrR4l3EKDyNuMZK
	JL66JWZGx2KQwL16xy0JQhoPvAs4MNLSmsWeg5idChQqW2J2wM3dqdnuX7nQUrZ0pZstNK6g1Xf
	9E41nuEOiM4t1fQAMzpBs2O6qJa4swBXE/D9fyaRFMmNJ5MC5NmX20w9tf5dE+Nh29Q0joYQQ5R
	szkHzalo+z58Cv8EUdXFMo=
X-Received: by 2002:a05:6820:4089:b0:6b1:37e6:92ca with SMTP id 006d021491bc7-6b16b1f9ea8mr14908866eaf.3.1787576825665;
        Mon, 24 Aug 2026 06:07:05 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:07:05 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v5 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Mon, 24 Aug 2026 13:04:36 +0000
Message-ID: <20260824130437.2771-13-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824130437.2771-1-sreeshankar0910@gmail.com>
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..2dc2c265c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
-- 
2.43.0

