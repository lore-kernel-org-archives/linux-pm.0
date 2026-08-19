Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D348481661
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153297; cv=none; b=IltoeziL70HOGm05XB+3XSGT2Jxxpc1g12u9yyj17UFXHQwNXX1lbulcg2XfWIwh1ymg19rXC2iCfEOhX9NL4rirunyKRHD68NmnU6BccAoe5uEft+UdorB42qMcbgRQqwrIpcbOrRJ44lw+6rkVe6hWlud7qDqjc0q8OnMzv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153297; c=relaxed/simple;
	bh=u2Yu4YBYm2njILlYS8QED4Q5XuAaD+AtoFT/SlvHqq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxgbp670oGyJaBDh12HF+R4qBYgku0aof+ERnCb06GpQGMUiSv37AdSiQ14p023KHcyQRVVsk7nz7w2/ZbcbeOJcQJFf7KB77uFb6srmySTyWghvLWmZs4Yk01PVIXmiddWsn7kCAbnHOn3iBaL1agCf527Hyz1Oh9ZOzymFMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f87GJ0F9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f87GJ0F9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1061a91.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153295; x=1787758095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEFzlhBjAhuEe8xovPGxxPJuQ8Ojqn67sRBJbsAP39c=;
        b=f87GJ0F9CgoxS/V3fp0BO2vgvBXL4YUzhJqblmGRG/tFQrfZq6UuqdRPjAvE8LjnfL
         VmjYP+RKg28MJf+GTTls79ge2iPw6PJc++/RdyAb0LP3RZTPTXQVUYaD/PLNzJMVSzta
         UOwV08k4VtLwCi6kdAYRgWCPz1mzaHesFGtgHgeIV60IEC0lwX+Ojph2youlTf76kD4c
         aGlXAUWGmkeXECo85hcyohfDMWOjk6lIxhXs68L8Xbi4/LyaydoOJ7e0goIbMlFRGKoS
         NYsqyHeU4BNS7Q6iQXeCsoo/LtfTccg0KaH33zq6z6t7GLM2lnX506nXSSxVqMa5+t7M
         XHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153295; x=1787758095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEFzlhBjAhuEe8xovPGxxPJuQ8Ojqn67sRBJbsAP39c=;
        b=VCjVxR6VN1hlaD92lCFC9nfi7tRf/B6AAx0ltZOjy3hvot+wh7acFGaRD8K21LKkEA
         yqd2Z3v3YgXqr1Ne0EmvvmQs6WhaFV8gdqv/MdQnQOhOHPMkpVmxqbJSQqlb2/1IZHri
         1hlpVEBHccXeDTOCwf9Xz3FJLu6/17gI7MuqYDSwfe9Q35SCdto7RE76X1pjej7/ukLw
         4vClEHlfa/X3bMI8cBPPF7Au6QNleSMDFQOD9kdnVP6B6VrAUE7qQ92nZ9fvmTKQPshl
         f6PHLDyhp7+UslqZLTtDLKIgR7frIHNXKNlTPzVeZTHfRa+xdeuEr5OlJg9s/Mlcpv2g
         Y13Q==
X-Forwarded-Encrypted: i=1; AHgh+RpMI5/pmEsGdRs9lbgm6s05Qo6bO1xJ979tC8N0W/IqOz/nwFGo8cyBig0CASTPfMpddLGKkrQZZg==@vger.kernel.org
X-Gm-Message-State: AFuF++knhW84mzROwnTHSJZhFo/QJlQlZST+C4d01HBd1PIzqzeGDaDt
	GI7vVe2L8jxgkRgiV5MKo7qWfOZNbW5cE9pNihaLvShvPQ8SbHbz9wfi
X-Gm-Gg: AR+sD10GMIbE2U7/59IuJ/+3SuUsPqyFFhNo9kxnvc/ReYnnXluh8xxclSjbEUQVIuX
	5qQa+mBXK0R14SdrBgqa8FQW8QipzlJwBMDhELfJ/b8Q858yJYy4khHPkm4LjFpJyzXxU3ohror
	vsVmuT3qIkp3T555EADhD0lJEmontutOhk9ynXOZ8TXoFysMjPtQFtE6LMYu4RNTnnmITHEFImp
	K/d88r/CWU4EK8k9e+l5G6XXX8F+GTJDBMwlgj2jpGHUlK+/gL3hk8srUaEDnDvXluRUqllhbrc
	aAW69j4VuACHEKGaokJhaLij0/52+Pc8c0VV3fSykrDZdxP8owiSrj3fUn/Ax5Gnti7Ig6/gUHl
	f9B+QwCB/czJqYmMo+VBP7HHLl1N+EZvnB0LULlKguHi4grX3Xd7j4FkkaYDd95zsQOl6lUxQTV
	HRQvWrzqkFxscQax383LLynSLDxrTBDZTnXX4m3ry7HPKiGcOLATR+qvm9AXqmonX4pTSQOtul9
	v5rDyxxVOA=
X-Received: by 2002:a17:90b:4a83:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-3957f8f49c0mr6838442a91.9.1787153294591;
        Wed, 19 Aug 2026 08:28:14 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:28:14 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v2 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Wed, 19 Aug 2026 15:25:41 +0000
Message-ID: <20260819152545.3934-13-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819152545.3934-1-sreeshankar0910@gmail.com>
References: <20260819152545.3934-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

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

