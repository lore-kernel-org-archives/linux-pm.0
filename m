Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D5429CEE
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462149; cv=none; b=okqWMNqn5vZq/pOy3fAtD7Qby2U1V6mj8313w0DRDLcbsAekVkeK2MIjGuItOhh6mHj1bcYVuCfIfBlH475GCRBKwYQ4xO3AqOPGZao/Z1wITHDO52WwPvI3Tl1n5I5JNS/G4P+gvL31qpr5GISi9bSLj6jUz5EgbiZPdxwPRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462149; c=relaxed/simple;
	bh=Tjd+qqKRlPATrV03pdQqCuwbNQZAlKYm8gvQMT9w2Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku+ycwCMhqKSBo0D3qmUMC/zz/kfLpapjHlrzrk+heStF1PS1IeafncF8GkqEDTqLVGImQvzjFUdJeOvgLKwD+TeRcluFLH7TbC/2bANgOi5gz64AD718In1VurzepvXfSvxExKeQk4hgxW/NMi3f5dWV1FAlLuD9cPIV9J91fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpsIwwIR; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpsIwwIR"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so438615666b.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462146; x=1790066946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw0S7j61Xivg5Kyv67PljsWbYXB5K5jcfpwkKzbAMRA=;
        b=DpsIwwIR1aRjXWbrBHfODdRB6u9aUKN/BjDVq0Nm/KbMjM7ID8ZHrbToOWKGsGmt/Q
         TpG3+U4fFRmEKKMXHM3vjlmIehEW2eO4NRBxbjKwIP+Zh+wapKXDz0VG/hyOeyvlCqbc
         lBbE36PpF6Z+zLp/51s/Mvz90i+mjILvzwMJ01hDb7WCkx+LUo50ffLVY06ca/mMwtMm
         8lKSJEYDmI/ggbJdpmqwqn/EsSEMv2+74MdrLsEvo/ebYCR3Gdo1cl4SWHUl7q4ZLkz+
         uFJ9znWENOSPGyYwpko2vp9ghnypxR02h1dAzhB7iaX2jepUmIUulAfW5sx4zP7qis6I
         xN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462146; x=1790066946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw0S7j61Xivg5Kyv67PljsWbYXB5K5jcfpwkKzbAMRA=;
        b=zs1E2NBMJ52PwiXj1aeW2OYgH0q6+66D8EbV/SO0gADYKSmh6dha9tUAV6Vlj0nKru
         yR/n4w2L4glZnRXv8INRZsdx3GJiovadYy/TWxsWVTYl2D8THZMMTQJRdvm8edlkXQFZ
         q0VuD8LYqM6Uh/YIdX5TyM3HOV4nnfo5tEolM0yNnlyXgDR/j/4r6YrrPWLp5bkNxqdy
         umLIrtkjdHRgs2koID7zGD51kilUaGMUflGS+oC8yBJTuv280HUpGNkoJNQx+h6SpcKL
         1jmhLMw8zlDNa96INaZktud6kF9q2lvp9zV3KwRQxraMC9ZxRJfqEAcuiM+9I3mbhfFm
         ncTA==
X-Forwarded-Encrypted: i=1; AKwUvBysjWrN2vzDVuqsVt4uTxr1uwTC1I6SaAi6zPqrSG1mcRio4bhNv0X/Yah1YCNis6l0xoGWaCoD9g==@vger.kernel.org
X-Gm-Message-State: AFuF++ncimjWK5OQ/18uxL+ZCrPkCO06JjslXm8yJJKpMt7XhUsKfSBl
	lNqJMTwMFxdf2SB+FyU1EpGY9IQGr5I1dkL0R+d5KJJy1L+jgv5uHwlb
X-Gm-Gg: AYBFou3trGOtgxcnfbAb1ZIbA87YGjr5WD7aKG9sJCSqmxv3ObcSVNccXrSBYrLbv7r
	NbU/jJrdR7LCA/90SCuIP9kQvmylo6DEuAmTm3b4DS9SpYphEjU4WmgHgsudNyXlmv3tRabI0Yd
	GIiiGdTg5S93AN1wr2Po38ZHOQyupCYPhT909FRYn5xKbC+u+brFrxG6U3uMSFMDXVLsKrzznrc
	vIdkBLm+aCdiN7OQmSc6Tq6z/bOqlMD5jvhqMD570CM4TNGw6OH00DKZGDeCd6EOHk6wRmZzVGo
	liN4mhrHyHyh+BH0kNQv119XQ1EKT5z3soa6F8S3PUUf2+fL/3PveStz6p7aqLpB59E7S7UHznJ
	sQ3RKSJ7KPgdo/qIOhUU4ohQPhBBoebMzfHaSl2F3poDzkLN7ZydccmL5VW+tDDi1nF6fQaR1bQ
	6aJAxiHH/z9zo8NNSqZghBZXD4gtkQwtbnWa/34ZIBpXIZ7ejEdpvYP3KzrkhFpPbt50yU6X1jt
	YK7OpHSGSqCkqAJsthGhq5h80SrpVvTGg==
X-Received: by 2002:a17:906:4fcb:b0:c26:22ae:b66b with SMTP id a640c23a62f3a-c29b86b7565mr667871766b.15.1789462146179;
        Tue, 15 Sep 2026 01:49:06 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966067101sm552702966b.35.2026.09.15.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:49:05 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: soc: qcom: add xiaomi,taoyao-pmic-glink compatible
Date: Tue, 15 Sep 2026 10:48:59 +0200
Message-ID: <20260915084901.56622-2-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915084901.56622-1-zstaseg@gmail.com>
References: <20260915084901.56622-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
battery manager can be matched to a device-specific variant in
qcom_battmgr.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 16ad4f5698fc..8ca057c4e3e6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -41,6 +41,7 @@ properties:
       - items:
           - enum:
               - qcom,sm7325-pmic-glink
+              - xiaomi,taoyao-pmic-glink
           - const: qcom,qcm6490-pmic-glink
           - const: qcom,pmic-glink
       - items:
-- 
2.53.0

