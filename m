Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E9430CF8
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299969; cv=none; b=MzQkSGb7PZikah79Y0IkZwHkZ/wfldhOgfU6xLj1QxTMYz6/yZP9Pt5qeY3NtlDnKs/InkvRrPgU5J8asGu18q7i8txmyZJT+70enV5L/ZS0INCNrTSYihSgDXVEVuSi8AKxiCEqOM+PrmLaAMWL+5nRIcNPQIzPulvhwB4nyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299969; c=relaxed/simple;
	bh=KyU8fbc7e+jGln1gvgBbCQwRZ+9nqq3IhPL/wCHuXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRgqrIA6+WrEEFjoEbxx++LMu7Xk+Pja4LAVDEuH51EpT/HCYW24eyZKZbShJr+9vXjeOJa7L33YTqN5QEVFYlMhMaoVNIJgwKp+Z6KmpOxQPodBHeLInUVhHtVpfOhDhaTFzvtk+snDYRm8n1qBwmQuB4Ab3hoqz372eSpWg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scASW0vp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scASW0vp"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedf318752so569632a12.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787299967; x=1787904767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWJvev8rwDkHrWVtePCBv0HB68OwkWKr1ifArwWeRlE=;
        b=scASW0vp31nf5qVKfqyVi/ygjtkjr+we5uVdhmP/o7Kf7EumwHmdsPXH1th0JxrEvn
         eh5ULlEA9n+MTw1t9RLf2R1+H/xFiVwy/RlYxIFy++f7xY10vXYHcFLQBIQX/jpvLVUt
         BCMXLEvvlpaYyVPboRA2OXKU+lrVgWyl35cUtHZq2KJNVHWG3gcewa4Dw+r0Kn4CPILt
         D/q5qfht85ns7deLgBmbNZoFic8Jcvd5LjfcxdflzEku5OnCf3DIR0vFnCY1dFb7xblC
         0VG9AmDQFbOyBOMcRrgZuyQa1FcXDsg8c9yKnc/wJgb5BYl+bZsTfm2TC9tXP6OMmn4k
         CCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787299967; x=1787904767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWJvev8rwDkHrWVtePCBv0HB68OwkWKr1ifArwWeRlE=;
        b=PmN2mnFPqDl/sxnEay6JUJPF0fTHmWF5uB56LQ+BddzK3lVZnru8Q4EATDtI7Jrov1
         uW4whrNTutAt6QoV5coYFeS4WQElYhQXLV94NF8ZiNptt5vBgtgCk0sZT1C0q4kZx/M0
         NjfYAqgNXWYlYq5l5BoopdYtoNGwy9PLt+G1kx1z9FixW0cs1N5xmvQZqnwCMFaZTo/d
         sVwLQSS++F6euDcTpaSDFsrVsWuBCABik/KaT3utJGnczXCdZwVrhfcNFN0P7dFBhEdr
         SKF8U+HeM+5Q9gqIo89sM8rHIC8qd+2xJfJRrMNYlOjytxeOy7dUAQZq7ZnkTdN/+Ub3
         K98Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5gA4+9ZM72TSu7J4r83ymnEfDbBkxEmqKuVg7BVmeeESSAQktMuqEYjyNbCTsOkSYEsWoli9cnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mXjHH78Kl9N4l/SfKPm92oK0P6jD5kJK8sh1bFH07wrPbnookV
	NHf09skA6k0IHSwuDPbIypycNYOMqk+/DWFKB2ZdkfKiNWSF0knl66QQ
X-Gm-Gg: AR+sD11ejyr9wu7dYe6Gn7RpY4Mq0JuDxk/+D115JN2Hw99h4MbcJ7UjyeI3m976jkx
	nK04rkRFE1QRQ36XvrtaqdkoKSRqnpKKCODWSjLoV6qrCD+DNOklAOxH7jo0z33b22zF21nnfes
	dDHG8rQ7p6xiyyvmVdfxFs+lbdJkc1MrhGnD2zzAVTI8Kmu8JjtjajPWPiPgP2C0veeqr3VETUw
	7VskYS4x5hwoMcXKqv8NEi8HLXibuGhXME/QyEGDKO+4qWnIDlLmCbgwDcZIV0HCvS67cWEGScP
	FwjxZFqjDKw/Z5xobLhLmKe5YnqGQYaySIUHdvk6vEnjP8GJXCCN8StIyl0Xyn9r9rHA0rN/pG3
	p7zU50iwAiqzuZE4xrmFExLGqqAfVlwfGm8NV0VxpyTCWB1BPeYMlaRXlSn/hAEUuytprosIQlm
	d3I4F2inYErNp1zChXmJ5fmZ7/IoubsawJEW7ouGQV3AaWZqOARfjfNUHP9bhgAfhNuJEWoZUAC
	DGEdGIEtVze
X-Received: by 2002:a17:90b:580f:b0:380:f389:447b with SMTP id 98e67ed59e1d1-395c386d163mr9033418a91.11.1787299966990;
        Fri, 21 Aug 2026 01:12:46 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:12:46 -0700 (PDT)
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
	quic_tdas@quicinc.com,
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
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 05/13] dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
Date: Fri, 21 Aug 2026 08:11:17 +0000
Message-ID: <20260821081125.4522-6-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081125.4522-1-sreeshankar0910@gmail.com>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document RPMHCC compatible for clock rpmh driver on Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index d344b3386..df9e37f90 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -38,6 +38,7 @@ properties:
       - qcom,sdx75-rpmh-clk
       - qcom,sm4450-rpmh-clk
       - qcom,sm6350-rpmh-clk
+      - qcom,sm7250-rpmh-clk
       - qcom,sm8150-rpmh-clk
       - qcom,sm8250-rpmh-clk
       - qcom,sm8350-rpmh-clk
-- 
2.43.0

