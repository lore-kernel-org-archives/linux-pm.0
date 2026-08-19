Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2A480DC0
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153276; cv=none; b=GTPUtsylJtYm0vQab7X+BPI1mpiH1tXNP0yMcXRnHw1KKA+QAKG9uF4/aOXfwOXlJlbj7Zghx4BVbcIuNTvrD2AqEf+SnsvDJCwM0hK19fCLf8HvINyirGJjkhbFhWcsvukRMSkqH5dUqgT1HsbcdH+9OPGFQ7OuxJR/CfA/doI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153276; c=relaxed/simple;
	bh=gGRs8PNvl8Xi/tUIg8+pD+wbWYIKM4YMN8DIqhxVxmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2edQZERCey9TQqlqvUyFultz9bebyPLCrMqdkydMtysiU4S2jfpwNFKCQav0eYvuTBs9/1LsC0wvByWrLt5p00Hj1F2GmPMolR3bbppmFnnbqEZ5fnhBD+NDP+rHozizSkRUXvngt+hOLoS2sMhsKkWajuWWYdcNQ3IlNZC6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0sUoFR6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0sUoFR6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceaf8a1265so13817555ad.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153275; x=1787758075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4p0M/MEu5nAOoTIIepmDuyjSd5dmIXE6lm7R/SDctT4=;
        b=N0sUoFR66sGylAFgSLXVGwyEJ0UH83NTRMp46/tToh+DFe9hRIxE/12XgHDm6COQJO
         5uRBtQdYiw7xNSWTDjHOC/3Ak1jfJGR7yRIGsMQjIW/TpC95I4L/xWqwEWKnX+q0aA72
         LrkMuqQY+MDfp8Zq7Eeda+btl3dPvtS2VviI8bjlguPrCW6M6TunrVn29giuIfhv8mUH
         QIdclDHjhXuZswK2YI5nG7Ks637B3CvNrNCPrNVqBbArsOCIA/nlrWXZ3nZVQzohY4L1
         Ba3O64Bm/g/gAxU2Tx8sIZKodD8x/6sl0cok42tb3d/9MCBXZpJuvSrxCYYPrxddDI2p
         R0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153275; x=1787758075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4p0M/MEu5nAOoTIIepmDuyjSd5dmIXE6lm7R/SDctT4=;
        b=E63AyWBL9CqabO6h9OqKatvmj+fQW97VOgoH7CPO2yJdJr3m5ykeeWFNynGRJRjlmN
         rpBiZuGo7i8IOEcocWMWCJtSOCRezXLBN+dMxgAJ1h0WBAzdT6YocqIj5B4kv7NNY8m/
         YF9iUvlyGTEqVxMdWQwXYd0eNc4SaCHeI8BwkmI3hDg6yL76hbzFT3ClkSgtA7RerJc9
         2Li04CSNCXrIin82j+k4HMkU/AddjyWwmiocoT900DM9/oQUESylomd/u5PDgzHDIIFC
         imQPYP+cOpZHK/9M6jEJOCQ6uPaRAo0mEegO7ONO6OiDCumDs7gxAi+riGAbdq2cKYfS
         bGDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUHbWprevv0J1ejdyc4btwoQj2wANZApaZ3R/6d++c7mHE2t9AHoqSc+lq67xqgM9+93N+vwgVKg==@vger.kernel.org
X-Gm-Message-State: AFuF++n8smjQEMzCraT+nv48g1kEJzMSxjnuOCyM1XaiMJQ0igsliYuR
	GB2AkHEkPXLr3TqIQ3XXd3Jk+on4pph5skpFjec0wv4uMN/n/qcXyF8Z
X-Gm-Gg: AR+sD10OmMDzNsDw9io6GpM8gKdpN6ZYbehTQkaW3Sf1BHdqGYNPsFMf5yed2gilMb4
	K/jiv8uZItKcakueQuCqF3a2TA6/BCENrXsJ1+FXC27QsURyPr6OSNTl2P2rsJfkV3a9KJBklH8
	+7IanKVIZKWiLpGozBtvCUfHXRSzVoBod/6hAsynPjJSuT5CEd9cvmfPYnrJfJ/Ge7HffzeEB2K
	sU8+yjUmrxOb9iA0DAUk/ZStuFtA+HqVMA/TXS7kr9nLA0Ho95q+jKKOKBkRgcHR6nQdUaeR2Yp
	bbw0qlEzNNzyyD1WeQhpn20pYMOymFxF297K76uzSsji/qUpoKObSpp/lkI23QrvMilN8kY9P/N
	l1zbVlq7Jyium8XlrxSu2Y9DegVygcwc9yK6Hz4SQ/u7HfOPuW80eEMSmuCxWkc5gL1DM8n8+nH
	w2LxDclRHMF96p2GvMAcM9U7fR1nqIuC6aztNNe4lCD4IcIMIfmK/I9yOk/pUGzCntWGlJTj5Xp
	PRbKlTID9g=
X-Received: by 2002:a17:903:40c9:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d60197c4c5mr109473845ad.12.1787153274724;
        Wed, 19 Aug 2026 08:27:54 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:27:54 -0700 (PDT)
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
Subject: [PATCH v2 10/13] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Wed, 19 Aug 2026 15:25:39 +0000
Message-ID: <20260819152545.3934-11-sreeshankar0910@gmail.com>
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

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 24a49613c..c8f92de19 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -73,6 +73,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
-- 
2.43.0

