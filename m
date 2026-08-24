Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F2421241
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576817; cv=none; b=s+oAAQryRI5M6WETnr9yN990F4G8RJfAMzJMO5oDoKSOVWcNDvDblAiqBq9/PkHlMZJfQMw8PyawRcmI+Lonikbr4tr+RIk1ojnM51H0VzgrFIG7lgIl+xsY0KiwaqZ9gBtLCnmO1Yq8Bf31diSTZvzrC1lWitR2E2GD8up3LYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576817; c=relaxed/simple;
	bh=S4gVIUWwuoALYuzwzRm82WuAYzYN5KLWtNbqZ/oM/+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/lKh3kDyuTvaxuOhbQTXU0TIHxKD6znFjpxpKJieYrkhVl6m3JEEu60/HANdPMSxIWBZjlqGYRJwjB6eG8Z3pNio0ZxsVVyKts6DIAY0TyFTmt2gB9dTbGlmxwPragi4h/alfYJkqT4I7wRHMHct6V4J/v+eq4r0mZDH28tYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR4ldn4+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR4ldn4+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2918690a91.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576815; x=1788181615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3FdfDbvToHSgtTrj8YFlW83QqqTfihaw6vnLz7PZc8=;
        b=FR4ldn4+0piraMrYiGpAT5yAvUsgGTNMIaDUDHRkGNjLabNaCiuNYz+yhgFO+uZ7KD
         ljgQklwBfFcEK9uisZYjF80BfeHVWFKfXJoXSt6Ef6aBfse63Dr+Q6gTeSG1lsiq8E1e
         A9FpuflxRcLf7WghoNBUAPW7OHg3kBuNn9/aFfdK16tJ7fSk0mLlCa0neGIue8pTbTMU
         RMr70B8unMIaTnTJSItezUK6+a6Z5pCivH/SSckiq7MTNphl9eMhDdRbxpX+8ebZfWTa
         BXPhobbTkcMwI59YLzliwRJ/mF6u/+197G/jYZN04v6fIDqX13LinD2N7HtSLEy/sYGj
         WEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576815; x=1788181615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3FdfDbvToHSgtTrj8YFlW83QqqTfihaw6vnLz7PZc8=;
        b=ciIIfCLhpWy/egEEiZMnLr8WMNjpu+lB+7qvKUYKepnXzDTujOTZjCgLhR6Q0WxhVN
         kmwMMg1TS0ZkucjZ5R98Hh0orvXuctP2D/TXrBy02NCAx7/inCrgHGHXj4e4Y2iDljSN
         IN1slXG5L1o5306tnH2g6SCRtovqOydbmxzgMbOWZYi21u9B2aJr+stPfD2ErxGzRu0m
         X3KYAoQ89QLUbXq3WSkRZg/2n924LEfrRVKpMNsO4b1ZaF9/RsTRjnhuGX51wWd1e6O+
         Lbl9RSijR1tfWf+p8fsH9px3/SlElypbnMOJKkDqAZLGx5J1RK7BvwuFaEii/YyF+Kgr
         hcag==
X-Forwarded-Encrypted: i=1; AHgh+RqfUtdj7uju0+nMRx2pb5Szgy/Fyq8MdFsM6vSqTKVCUllv1maJZyPKjX8SkvmpXXtQLmsb2UzJng==@vger.kernel.org
X-Gm-Message-State: AFuF++m3mzwS/21OaCWw73Bnsvq62sQuMZ/3daoPien8lq4L/vJ4G4h4
	kQKUYQ5SO53GvggWobh2/8+ysj0ABqF9mrImuKTMILuu+a5X+QhmVladLpdGZ/+C
X-Gm-Gg: AR+sD12ddZ65pUukhoUMPXSI8LG3xDDrI9Sa4euJJtXa0h+RBKSoNPlPMdAOUW2grWJ
	tt94Yn1EPytEU5kBsA6WX9vQVShxSRmNrPUZZ3IwpLIDmZ4Iqxd4WeWaXRJZHMT9RZEstSPeUos
	tDFNjcnVtZyUbVSMsWln+Vw+ulSbxEhU+IBWWQ7d297nRGiiNbPttwWzfl6VA5krsj9QTw/ONJB
	N9WoYlMezRp2FcB1cMqSo/AOyNxeFOU/7KlLaQpume2GohR3+6kSSF6thzbahldRkE1HC/qyYhg
	jpXQIf6ejmnJnPaxQJdlNbmshunQobrGXHX1gfPGYV7h5kZy1BnFCwkp6/h3D06bksmIXIrVgfe
	QbZPX3jKvNEK53T08+/v9PgN4jxwXsKngbw4zlb2ZSMZPGtETKpIb1T6EsACmeUnTdy1B6Et7Xh
	rrM7BfCYzjQ8F3pf1urHt/9aD6xg3uhiUM1CSrdMKO2sazxRlV7Ac+wfRt/VCca3+JNgmcmExqF
	1yyIhG1IlkiiSCh0dsdI437
X-Received: by 2002:a17:90b:33c2:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-395c3597c56mr43924218a91.5.1787576815440;
        Mon, 24 Aug 2026 06:06:55 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:06:55 -0700 (PDT)
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
Subject: [PATCH v5 11/13] dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
Date: Mon, 24 Aug 2026 13:04:35 +0000
Message-ID: <20260824130437.2771-12-sreeshankar0910@gmail.com>
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

Document the PDC block on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d4..c30b88589 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7250-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
-- 
2.43.0

