Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DC420468
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576758; cv=none; b=SxHrD6A0J8QJSBAiuRpsLl8BpVw+hM7rgkCNPPTu6VuN50252M7rhbuvfESqVSgHcA+aNevdrnPe5SSJkymawXZCsuWZ0YBEVJ97Kkgp0nAsKu4InLigv5A2Jxtez36pENoUZSB9gVYwfbgOXBQy4rXzDzWZcev2xwCxstRQGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576758; c=relaxed/simple;
	bh=nZLd8IMnK+qlnesykBsMlKugO6FZefT2Z+rNkHuVLQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQB9qwtN1Mztx2VC4vFU92u579i0zLqm0mNhpdrYk0YPYAcrhjy0OFbUxbP9s8iC84kZo2maj1OMKLghEPOrcG6E+zCk/dDIAusXAMqMioZyvxfzso3kurRBi0HDtl3Nyr3mfi3DDDE5eymLrci/QpN0kn3Bg2vlk2jIDXOsUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0eK4lrn; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0eK4lrn"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4472500e25fso2523776fac.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576755; x=1788181555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ckSz6fnME6Yn3dq6dpHlPLur72/KUgppRHgWdzen3s=;
        b=g0eK4lrnbTmgX0cFesKT00oS/Qd4bZWYYQDbTcTkFiuVgMrJWkg+EP1LF6vy9jm6fK
         WlniZLkTtHnrX+AltqnwsbGJ3kxtdkETHZjQIjckkru0ncVK+bnKUIt4pI5fUkmbGUwC
         vau/xUcSETA3LrDDkKYzGhpoYONLkaiwF6z4kp1bHUxr/gQ0Whgr8sDKWTvVbgmt0JJX
         BOClbS61zurkuYemuJIOqtGDh58j8dxl9XNLrqywu4L/kpytCWPlCthL+ocwmf5bWnLy
         xurJDp/KvE/gmAONkItd4+wibFKszjyvozzrlP8Y2SBwvhZEAfDvRiKCM6F5Qugly7ZD
         vQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576755; x=1788181555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ckSz6fnME6Yn3dq6dpHlPLur72/KUgppRHgWdzen3s=;
        b=kIwB4IK5zxCQ8QIVcMRjV/2YI8QwFfyxakMIgGkCT2MtZHHpiFcttYRgsvX4KgLgCE
         CWTn+s5XagZGWM+VTi9v4fUniQf9HVxxJ+XO6hBRDWLi2o379fui4o8ErpDBVhyEaf3y
         fSIQEnOQ8uVxG/m5Jc4FFjZZJM48snm2aZJCvrR0yjpedJCkjvJ+Jqocv5AldOW0gTRE
         VTGB0SOnelbXHdWspukGmrhQar49mYKURgZyVqEnL2ejj8EDbAkFe4P+EdPLfanjwX83
         csueXEZ//4DhapjyTJEIGZGK2qsZF48bgMVqlVDFhXzP5oQqCZVmu4iEkwdZ06FRRLxa
         S7FA==
X-Forwarded-Encrypted: i=1; AHgh+RqNpfPJ/qP1Q1Trp9Xx8NfIM6YuI9GSFgI7YfJHPDl7p8gx6irwd681gpTm5L5fB9lDXXGHPHHhNg==@vger.kernel.org
X-Gm-Message-State: AFuF++kj7wMdxElmusZFxCaFfHAtF3oNCmetE/woYhTRyyp9ybkZ9Fhb
	xIB9r9q0MYd7XQBX42uJRqmjZc4tREZcbSBIXuws+vgBvrIGZjfrXZOo
X-Gm-Gg: AR+sD10FbJ/sTS/XwGptbbeqjKnfUiMXT7SGh/n4DYlr9Zjdt9FVqcYCz6loXwOhOxH
	bDhJdQCu5cFjqOvp/NW7Ts9jM0zTscf+274wdPXRqW4xUbviv+A7k4yllaV7q4vMXJyQ+JK0od5
	LRrzRXfoC1LC9Oi59nnMjJirR3ixHgPHVyON/hwv1//W/OZXAgtdMuNYoZL17ynmVeVV25Cn4PB
	GOyMlbcYJkSGcsliI2JmmaLpX9hovdFBzcR7z8G0mKqBsEy0ArgbCpqJcuTZLr+aQ/sd42gGBjw
	aO/r51zWs9EouMWId0CEJMkzpTGudrWeKPKOe3o/R+SKmdf+WlIh3ILw4En+E0JW5OTc+QCB2aj
	EEHZqluhrPUHDl3SWeGwY6LuSqWubK7RbA+MMvL3tQERs/QvA+C/p+N1xutWlu6tleOun2Zt7p4
	zVp4/HTaLKJWaJuvNRTeoPtvt5uUorX0B2zKeSg3jfseoBlkt57FEUxps3L0ex2FsUOMtE1JVUz
	uTqGMRkonCP
X-Received: by 2002:a05:6820:60b:b0:6b1:430f:1bd3 with SMTP id 006d021491bc7-6b16b1bef04mr16104300eaf.7.1787576753647;
        Mon, 24 Aug 2026 06:05:53 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:05:53 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 05/13] dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
Date: Mon, 24 Aug 2026 13:04:29 +0000
Message-ID: <20260824130437.2771-6-sreeshankar0910@gmail.com>
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

Document RPMHCC compatible for clock rpmh driver on Qualcomm SM7250 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
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

