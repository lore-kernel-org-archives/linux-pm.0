Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855336B921
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583874; cv=none; b=XZmQgD2DQIQATeSB+yIld/INDWc/5b1Ami4KJHidEgCTd0BSyEHFhh2Ff0V9WpyJouNLYEZk2gUhFvuajSy0QYLcPEnzhEqCQSYzbdWCxZ4XsojxxVkAUbRqlj2VltFHIiIwQPOS4oNfm4jbwuNFLTjET50u0SEJunThIz+AEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583874; c=relaxed/simple;
	bh=ncFl2egTrX19lpiIOG79kyk7c7SQHpgeuOXFeTOnh4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XB9bUucS7fHWbI7o5REdFheSvxkal2VN3WCT3ndJ3MaxoLx6WwEuiAixL8RVXzllrZUJT5WljBqPyCU8uyuJPysphjMJGqfaIgGU6PG2qSobXEEBKvLJTXHuAcxVdJvQPTJ9N9zoQXCIB2kreL7z0AdEHlczSxmAteN+X6Amx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs4tBhBq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs4tBhBq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caced6038eso38521015ad.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583872; x=1788188672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCzOxn9mb1pZe8tLnIPRTIlgORGGKeSrG6TEFfLDvGw=;
        b=Xs4tBhBqH1L1qnIgXTbYG3HsNlRooZYJy6C1tv5NR6YnSke3+Gt/PyvFNFPwzQwGoH
         PaLmqiFW6O4xT5uGHMn5fahKZ+yPtMmytWvtPk/bd5Cx+FLgaUUwHRblXJzhR/AhnFPo
         HZn22c4ZCNMlJvr+aKl6JKYeSLNl3i1KD5BmbbmmmEB51cPaumL7YTUPzevclgqa1b2j
         O14G10yb4BFqbHuDjJrsvOOh7pnzpZ323y2LBrHhYyq8sP/byXkWLEGStGkiWlwiBgJY
         JmAy+Qohkx3ECbYXY8W1srXj2xwQVo6VmiuJ6uaHc4z40h0TL1lCDuojSI9kqQBq6Jat
         Ah+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583872; x=1788188672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KCzOxn9mb1pZe8tLnIPRTIlgORGGKeSrG6TEFfLDvGw=;
        b=KH4DL99pd0fsGMV6BgZwPwaX9hAkXuDR9l+haHdNBF7sAI7fZz6/YBATRCMSvNjzll
         2S6i0+IM00eMjiDUKsjOkYo7h8BsFEh3happtirHMN9sSaQSQwh5vadMcV7Bb2v3Ux9c
         gxyTczmfJZczKNhxkSXZsxSjDZ9/MK7T42B6FzzTi320w7Tz0M/Pf79cvj+j4lHlV/bp
         OW/XW7p9mvJobFYUbhxxumhryNkPT7bbZViScX4OoJGP9ucllxpNfcIszs4C/ZS2/SLD
         ai1YJ8wJ8HJCGmNg3TgCOYQ0e+Oibvw7JLY13zsbcJvsZg96D98PKmDtwDNoq5k60Fb6
         FIbg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9m2MC/S2tr2zRb1f3lczWTD+yXUEwmlI0lP/aHwW6dJT8JMZINa/42EZm9wQRElkZYcQ0MV8YAg==@vger.kernel.org
X-Gm-Message-State: AFuF++ka56EJtwSVReANaWunLYO4dWZN9Yvxprurr6Qp0P4t0EMKCwVk
	Isku9oqMrEjc5PmG/lYbvcUsGinO6C2irAzxhAMYBpwH6evTEl2Q7FiW
X-Gm-Gg: AR+sD12v/BChFsZLzWTDlu/Y3m8GIZAde2gTHYhHyjQkWttLPNV4yKrrS1CuVz/XaQC
	E+YCY228gGrwFwvVbdy97JW6lHwktfU2/oCscsSsddHOdLKQE97DMr8W73OsOd+WSfvYHIneW7b
	HxNIgC2JFnuRGpidS0zPfPA+OSGfY+26xUS6ee54T9YZyJc9FvAYtQ5H7cXto0KR6Ht0BpTzAEr
	vnAFnS2UKDWiJLGKbMOnUI2PMu8arq/2kKi/1vQlT5iboadqdhKbp0+0M7a7FNZefOMpuaqPCWI
	Lo5kVuw2oDDg9nfQSNpxO5zHTDMgTi6YupxeluxPQcdJzT6wCt8n6zDwUBV/PaoWMDEMjIb3V96
	toY4Dsm8ZgF1ItlyKO0MVYhPYZoA8LItszKt/XlZSuPGXpK4UOYl1Kr3oRYqmqsG5Ato9Qrxy2k
	1s4uM7mtUC8MEV8I3118T9/3ijlh9ZjVFJyVVoJl7MlU/avNvJbh09svaO5OfTXrlHwmqo5FvBk
	5Xaqp/JeoCJ
X-Received: by 2002:a17:903:19cf:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2d61a15e3e6mr409361745ad.9.1787583871757;
        Mon, 24 Aug 2026 08:04:31 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:04:30 -0700 (PDT)
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
Subject: [PATCH v6 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Mon, 24 Aug 2026 15:01:55 +0000
Message-ID: <20260824150156.1310-13-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
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

