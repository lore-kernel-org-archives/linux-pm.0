Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4242669A
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246567; cv=none; b=GvyYXwNfVqAAmjNoZI/CM5fCAHdKhTgGHPRdEUaajnFGMJyNt+PpOv80uFbPEV9/5E2W7YC7ijnLqTV6X4qgSYZ832s8KEl1X8IxN/XhVypjqdr+w1P70ghNkgymra2489cfK179WMa0esE9VOc+FzTQhwrwFZ4kU3IHWn0r2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246567; c=relaxed/simple;
	bh=0S9ZiRaNeD0ONuhBWck3LZ15qfVQqVd9GHb68v++sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL+YClhhlv/M3I04RbTmp/2CQ/8rC6MlMFUm1OGBvDO6wsH0uEjyJytZ6G2sKmiVF58B82T4UaQbd+m+qlHBeYISuNGxxQIjeWtU+JK2nt1+gy9EoXH3paO+PEoLLj8YpUoC0gfMBe1YacaGdi9AEPFnDGw8WtEnVdy8wAYPYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPkjIEQK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPkjIEQK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5cad1a6baso42073615ad.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246563; x=1788851363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=rPkjIEQKdxLZ/sXl1sfckXlub5hLeRHLy5Vf7DydP0RRWgPmVtiTv/Bs5OF1SHHaBe
         +GXv5zKI6kNnmpMTKhFLFuPmVZhPsAIXJ5NJdeSXvRP2wZqh3mQPp1Uw9kb7Kvwrk+jF
         QlSSicUyzhoD5f1DKA0uT95cHi819y4UQOnh5Dm60fE9SM4K4LyNYJYkU1VfOufhSnZh
         U7gWpE4+g/UGi+s7G4sueh6/dTdiP8jQmc1GTZmV3XUr9/ENTel1GdJ/BMRjnyTxrD3b
         iHRG5tMayKi17hOB8HhCiIjuhCokVNVKlKjxNSruGE/mqBaQm8f0ukqVhsNzuMGc1ABu
         sm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246563; x=1788851363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=LPDt/uksnkEdtUDszupxZq1j2U9p+W+r4te1Q8i9j9iZ+F3OvsOORVUASloIxVLykA
         i/vXT8uLPjFMFtN5nJ7CkFi3G7jyIkmNCsllng14b4spwpCqK7ZlM0ZikE1dwyhoZ5vL
         CgXLa+XjYl5Pu7O931MFjxAXK9EX3l28NSGh8ik3zpzOouyyB9TcLdm1ijb2ySSUnHd7
         ge9ZjXEV9Sg1IK+oVUbUHhsd/RNtBdFWcp94jIWBechXxC5t8wvkICUXjOESGE/5m8s0
         KYYU57tgDfCTQ512QvwN4iO/k+9oHv+aKNcDlymmioWbFpuUNsqsb2mV3E5zPdZb+2iy
         4lXg==
X-Forwarded-Encrypted: i=1; AHgh+RpG2qsL91lNo0ZEx6mGfzPqBsOGX+ldZGkCiR5zG27t8Edka9fToi4tFCkqjdil2NnXCcbaRR+YtA==@vger.kernel.org
X-Gm-Message-State: AFuF++mT/itw9ttaIA120JA5LcbFmnCKeJG0YVSzk4AMYBPdesYDfyKk
	p0tOu5Eh34U7AH90UJP0hfkUm5WC0CW3a7jH9p46NmR9YDJ+VL1cPyQL
X-Gm-Gg: AR+sD12lP3qEyrXadxPe5AgKgbqTWqESXDQDKH18MCmHWKV36RftMp1ZfPF9u9eJCbu
	bCEVQVO0iL5D7RLzzkf4PgZXSj8GeCSRquRbQC0saj87jlz4XKPwGXePof44PrjJ7aZhiliofNp
	xYOf5Fmkxm65veqL2befCkkiq4GhYbC0fKN6PpGA+CXj+768zgrFN9o49XxRYrV/wX4L5u3L5JD
	AUweNuJGpjAsiINx3sKQGlLs45wmRgvKyqkHvCMymVcXexA51mz/T7mF6OVRtRMoYqnKHCZew5b
	F2iu4Jr2qWjAj677TM7ix9z4GBrjVGtN4g+VH1GzSiAXG7TQPoMuAww9EXT+5s36WxtUbHmg/Zz
	kSlBYteNmwM6Uj6P4TcJpic/m2Cb1UiFoK7Ark9oyCG2gechez+g9ehiOWmGRgp8GYfiDNZbNJf
	hjLo15UaEszPreGdXF1or+mBGLtKWbwKI02LxY9EE+mSFvlikex1FCQutJnfFK3rgxOW+KG6h0k
	/jkQAJ1wKYz
X-Received: by 2002:a17:902:d48b:b0:2d6:e401:9676 with SMTP id d9443c01a7336-2d94a713d37mr81458035ad.1.1788246562799;
        Tue, 01 Sep 2026 00:09:22 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm18274680eec.1.2026.09.01.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:09:21 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 11/12] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Tue,  1 Sep 2026 07:07:16 +0000
Message-ID: <20260901070717.20513-12-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901070717.20513-1-sreeshankar0910@gmail.com>
References: <20260901070717.20513-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

