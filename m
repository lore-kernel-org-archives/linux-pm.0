Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978224;
	b=O7KS7BDFZ9lR8PhqXqB+IcCIE3Oj0hw+3mTWpYYVh/dDDAHzk/BcBmVGBdpP03TUc26b
	 jMnzcUl2mGi/lEMsnMvTpGSP424MJNAhzBUDE4vY8P7+OhM0o7lWgLMRuB9yw5HWGVKU7
	 SDgD0mXQicVwseW0VB4Z79n9rYQ7KVSwnJGqE9CPafGQGkhQkq8FENJYWGZ8v73jJPyN+
	 o5C9xdqGZHFNZvCi8GoSyU4mIEcS/ruLRug1rLcs5QMK4DWCTOMbRmCwJSELXACqMRh7z
	 O+gZFkubOdFIo7SN6WveUEtaVbR2KyW7ZJKJdI8mSXCL9iE6LG+nhEcxa2v6+eE+IUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
	b=LnqQQcE4ObgQr2TgcjkqdaXtlB2YZiSZ8Dmu6eGNvIQXfoH21UvDi7LbzjDpzPsuja1J
	 tKwDrElAmuJm9o2yUSlf0G8eJJBVszFFSlE6FVZOnHBdL3yer+D3jD79CQt+CdkowCKZ5
	 GucoP4wDaCG3AQT7+ol5L143D/WoI/AhkQhi8MgFQJLtM+IxFKNoV3g+3SvdFQ0oyBkU9
	 884W599KrZPEhY2gOzrr6u3qWW7vCT3qFZ8z8oC3YqUkVZJET0rUZcudqjvDqxyDBPIBq
	 tNuk+decQH9PLs94d6fj55S8yjZn9EzI0/lNaSLdJJkSdqcbQvqPfxSxRkVH5hgj+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hm57Ipyd;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91EB606A33B
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B91EB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hm57Ipyd
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2327414eec.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978223; x=1794583023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
        b=Hm57Ipyd4zR0uJlvm6dhRylUqkiMorh1ZS7/8CIZIjoXX8W4jWlo5vqp5/4jt/ydkk
         QdnaSgyNWo9/sN8XKK+gMrZJWjv7mm0ReLPBCbwPhKKXSRBomJWJX2ybDOwfKE2jsL7H
         0hyiMTRiYUD/u4oVkNMkMQY1VNevjc6LJcpFos3UhIqI4WVQUnOzO8qd0wmw0mMvYCUt
         ctfNM4AbnSRx9Oczt4ISPdBQCx0OMHEduHduejZq/YeIJRkTPIozhgJPnBHJ6j2kOFr5
         6T6mcZs0HwP7b1+duob7/uJn1O+7ANzgsU8uocJiS2aqejFMnIVJITikaUoSF+beZXCt
         4ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978223; x=1794583023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
        b=sM5j1fVitYBP2XMf8/bhqTUZQH109g7MYhlnxXm3LMQptLqkspX00W8F/J/zMb0Tbt
         12ERFpKkZ216Mu0T+OAQXfhbxLLFZr+C35z3a0CFIM8ocLzxmY1sOmsruVOB7+riv9C8
         4VfDZy0d07TeD15E92L19X5XgVFUeUJAkKAps03lRC3kPcak1PD4QmkEXCw4cEc0rRap
         i6of0tZjPNT3J3NGjpW6qJqHARecaXiDR0xBENahtJXIne9bDU4pPuNE0lcEVBAqOghk
         hCFwsUOkGvP6zA9+v7GDfan/H3zmZGXByk1Yv+Q7/hCz9xDtOd2Q/0kyA0nO2407Tuec
         mSMQ==
X-Forwarded-Encrypted: i=1; AL+hErGaejNDaFiqtD+hN8wpc/SN/CE3kMWOIY5xVE/pl+TjwK/DtNgt9t+ykXNZXX3BWK7K//ulEr+eAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/gFq64yIzXn5IvgftbyQK0H+4gCTS3uEjGNfKumqRMNNVlwzgo
	DRTzGdoc3v5xyTa5MuEf5p0f8DTnS1T9orT9dbi9qbQ/7RMTaCGjuAlw
X-Gm-Gg: AYBFou1IQgR/EfyQzr023HEc/Zho6ApwInmzVOvHKBOYuoKVyEjkB6PpyJtNsQ5HrLK
	j4h6ofWU5lrYtdur3y8lV6VgttqEe4KjMpamQ3/gw2BnDV9OFeHN+ooMoCefJR6VAWwgOHZ4Jfb
	yttWjYTlqWb5Ba7ey6Z0tLH6cL/S+ixpbVcDo0Onf0aAJIqDTImh3Edm3y3Dogg3c3cJmMqgldD
	1a4kWfCYMYnY6WlSsTvR7TpuuZDX4I+bHIZ1ZrlM5ZpG5ujY7WeXIKny7gEalcIUsVrXh/6uYBa
	Yx/FNO4d3gxgQNCpG7wa+QOwwQ7Y53L6fa2CRzAJQS5QoCuxG9FopAES4C21LYkE9Lw5vgjxQND
	EdrHavArYrWOFY8HYykhsGuKqH3opiU2t7nf/JdUwzvuwXJR2ZtN52mEGUGILZAoBn7pSoTZxD8
	pG6Cevcj9LpmzU6yxalYN1WCJqS/XmKJBl+Oj5afEsjABOewoTI5MxRgY2CpUyptV+oh6iUYnnZ
	9LpySYKyewl0orPVNogxvcVqi0+47OZOkhgEVlsX8l5Qzy8ch25KOCGSOKYApFBZagVabUezW+O
	eg4+6dwQj3PLlmH8EiHUZmoJoQJl0CgF99leLafrBj6Rm1Mw7aSaPmzoVU7iW5S66XvJhuutklU
	o2VykLzk=
X-Received: by 2002:a05:7301:d81c:b0:36a:2382:7dab with SMTP id 5a478bee46e88-36f75a2b011mr4038390eec.6.1793978222959;
        Fri, 06 Nov 2026 07:17:02 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.221.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9ed126csm7581500eec.18.2026.11.06.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:17:02 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 06 Nov 2026 15:15:42 +0000
Subject: [PATCH v14 7/8] dt-bindings: cpufreq: qcom-hw: Document SM7250
 cpufreq hardware
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
Message-Id: <20261106-sm7250-v14-7-7d167e993f9c@gmail.com>
References: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
In-Reply-To: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Sreeshankar K <sreeshankar0910@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793978147; l=1157;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=tYOW7ZwAVWXKL25nNQ4vkjon/atY4Dhfdawj8MhM0Nc=;
 b=pBWXHjOFV8yy/kVfddEOkI1z2Vr9iOnPMtTW0sfnFDwT+AdWHZ8KZUKMMqogu35cKmAlw7fOZ
 Tzds03Lu9S/BDhGPFs7OOqoZ0Ml+RHtklhdEbV5ZxocuZ/BaH/Yzk/7
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the cpufreq hardware on the SM7250 SoC.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..f8cdb652f 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
@@ -201,6 +202,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
     then:
       properties:

-- 
2.43.0

