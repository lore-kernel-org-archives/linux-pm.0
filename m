Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4353356A38
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326946; cv=none; b=FEm3C7dk2utIorYDcAfkSU1y6rzcqjGG5iixLLX5TE4GCsuT/tW5dTW9wrPYoOwEzu5rYpu6WIzI+W43QGKf/+z5ueVSh549McuWtveOzC5frNqXP3GusjnAYvSUwKYy7bZM0pqgv3eHG8GKIJbtQYirBmCsBmFo+vkM/yds9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326946; c=relaxed/simple;
	bh=Unl00eAfFi9To3aFPzg9GlTfdXTVfm9Q5VowGJ6jvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyydMgkT4cwJJNaiKLqs+y/2VoJmLjiUPKw8ugqNlTTUy75MK8w8+AYs8MOdEOHFOkX7ghsK7BzSVia6Ryn+qHHApiMcj8qYUzPUBf9256eADL/wDm7S/SMWkBdE3qLQufVyHHiyR9kJo95d7zdUkXgv0Ga0drzVeaj1+a+YlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1tHq6Yv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1tHq6Yv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1372951a91.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326944; x=1787931744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=b1tHq6YvPwXtf5nW7b5uSWj9XO+kTtJ/2lNdtA54MYuJaDu+vqHIdmUCeJrTNxhWqk
         N/vfTXI3kLTGzd7nrDzKsDcgbpjfrVccjGAvh0JKGjYIshjzYh0xEQmmijwGeDzJooXC
         UioHgEj6kX3fPMAmH3XrSn6v7++LMIlcUs7SXzuKIj2UeWrRDiatF7spcn+CRjcWLIyy
         gF3M9IrGC1BHSaRU1uJc9mcUasZOLCLzxHENxeKO7zl3V+FjjTHRmANPWfhIhCmDlIyl
         iv3MCAk3Mqg3+/nqeKX+mrvq6k4lizwAYNYrmYRBo3fT48lmbuM6uVctTJACvYheTsBa
         ZNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326944; x=1787931744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=tZE5T5UknnvEtKHjm7hTby7GNclIVXKUdQxRvnQY0g6c6dRCKaYfgiKwjjr6wDBfnV
         KFOoEBGJZ5hULncq67O/2ivhD3GXht8U36nGfYLLrsd4aJVgfqx1wU+xeJmiSsIRIZhN
         UQjxEP8syMHtLGlxpn1a1NLSk9ezdCP5InmmpEZAZC3fRORQtqMTOpAgkC+ItE46mz5t
         FAyZqZVR9nSwuOyGbl44xdRnN4d364tTno/5jRSzjiJq6JEIWP5+1t/6ArzfuHHAngku
         Nnt8EfQRWBrJ4fDSeIBPCLMCwtU0gYnqaVExw6wtydkse8hV2MF1m2WHM3GWuHwcGlSX
         Fukg==
X-Forwarded-Encrypted: i=1; AHgh+RqMK71EzmpQLVFkamXmYfH3GKnyRCk7TpNrCGcouAsRasOQXeYLdFn6pJXJf3CKQbSHWRKVZLgSgg==@vger.kernel.org
X-Gm-Message-State: AFuF++kL7yWqfy4bmOPac04vU2gBdwNlJNKs3nOCVQQYpcBfqULT63qg
	w8KP0K0DlYckWppycqwGvL9EB7bfXIKiSQu2R2H14Ts/l80nGXsEXKwV
X-Gm-Gg: AR+sD11SpaoYqbPmYMPQk78ITdvJZ8D6TBe5sSxLnH4MmM5gt1aPG2HlxnNW6lZ0iqB
	z4Dx8IqtHD5IZ8XTHMwdTu/cvhwM9BpzEShNEv65uS89IxXHzLzmxFd/B/JCJeqJg7eTTN8LOxt
	KMcNoEDY0hB7qM7Bpv1FQysMLHXwgY3ZlMBlcPFcC9WnufBL0Kf5bZqQM4OpMmfVJDWU2zDkeg7
	1ZhbcEoAMbU48YQRP2RwlFt6TKD3njmWQiYQ2ZCfaes2PZeDnpSCuPgLUiVMYW0tAZhcwd3r0Bx
	L5r4xSPTCFHCMThx+MuT/HH1NIklwenlW/BeGV6DlBDRqdoIic1+4AeQ5zS9cvg9Lx4V3Gt4fTI
	KuEIODs/WUNKuD4581SY5eiZ2xkkp7BahGd19NISsYUmlRT8Y1o41+zj5FY86r8EOYNn7UDre/S
	tbZGxme1aA1RC5VqAbVNNEyvMIjVXLctcbsABEFcEHMpcO2FBO4plu3uOVdWJPLA4MdhQOUo89a
	FpV+dPADavg
X-Received: by 2002:a17:90b:3142:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-395c35e27c2mr12635806a91.9.1787326944265;
        Fri, 21 Aug 2026 08:42:24 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:42:23 -0700 (PDT)
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
Subject: [PATCH v4 09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
Date: Fri, 21 Aug 2026 15:40:26 +0000
Message-ID: <20260821154030.2514-10-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821154030.2514-1-sreeshankar0910@gmail.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Kryo 475 CPUs found in Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5be89c584..2a90af67c 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -212,6 +212,7 @@ properties:
           - qcom,kryo465
           - qcom,kryo468
           - qcom,kryo470
+          - qcom,kryo475
           - qcom,kryo485
           - qcom,kryo560
           - qcom,kryo570
-- 
2.43.0

