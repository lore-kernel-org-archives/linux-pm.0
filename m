Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0947D472
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254805; cv=none; b=ah7A6l2sJ8q6cfhw9/BzqG/HTvv3RWYCXAWltyz3NoS17qlVeZ0XFLgL4lmQJVRl9kQ/gnU341ActydlXnAhWprYqWxudD2uslDkV8A9+RFY1E5DRrOAitHGzbpPVJCqTIes0yhur/XXk+YVPq4+9hZSmOqJ+LDjy2cHs/390WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254805; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJgCwSDPBQoY8Q24dq8yzTPoy0vx9Y+cluwpcH2G4NbWF+E1OLMmOjjhARB18bzW3ftZqztbeK2/bLBT0J6cMedzakeQ3X+DY2Bent5F5eZfIonvb828qn6CUZYQ5/10IQR9W+3GC7MomLI6QggI8BopaE9Ei6C4MvpQmH1Zmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzTeYvDB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzTeYvDB"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso724718a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254803; x=1788859603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=GzTeYvDBKgXDqnAI/yVJ+M3Wxav2Ar/x9LKCOas+qBwun97d7j0uMttwbnBTjcfqBU
         6r+CFazRkXovZ4xkohMOQ9bLhqLp8p6FLyXVX7ZhXDV7rPCvof/g6cTzuuzeu+mFJzxr
         ZZr5RO/qm+3GetnaQcTCcCJQ5AcgJr55rPFmBPUb7dKzcfI6KIPtmqbuIszBNV35GoTE
         RC4RcYpX0GFy3wr6tAjdZ2cuRJspNscgWvkelcN/ABlRXAS/R/AWIcYMoplcTXKNEiqL
         2uL7iSgmFshXFi4IJgyjSif0q6bRC+WLWCRLiFZdanL6vh7dj6IOUlLyUP3+Yd/02cDi
         pHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254803; x=1788859603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=odHtbuErAiU3FSgYaQqo5SAGNI4tlGIp89nczLMlFSIO1z24Mb+z6TljNXp7oUhehn
         9hOJ2RMb82lUtIzs2mTI4aFpQCFxeZcOjTXPYSDLALunXfu/tY4F7daT6oEY4HG0RlSO
         o9jfYuGcjf+GVqRZMeJklQzJOJiOWK5SeYInQb6/0lpdnfZwF9BYGqZVJil//1EaM5jm
         2M/aHGwrj1Z7A9U+DCV6tyuhLywAvMvxsVHajCleaahHGtUnPyhlakXBCE4UEaGPX/rF
         8Sizy1sJEfbO538FcG9RXk+DKGMIwN35ybi3WhxyWxfbZAK9PPXhrjvOsTEsZ81NX379
         ts5g==
X-Forwarded-Encrypted: i=1; AKwUvByPmn6KPNQb99U4N/AC7c9YZFpwU02/af4AhZQY5+KgNiZVqheVgn+xrQmxFgTEXRE9qjQ6lYNUfw==@vger.kernel.org
X-Gm-Message-State: AFuF++lxl5bm5Ysu2n05vhBQSqdKNvHTEaOk45U3cfUt1L+DiPj/NU8V
	DMXh4AyLCBIsbTiuDloLJqSKiPBGsMrg7SJjuO+eCwZftzAE/LhHkZWK
X-Gm-Gg: AYBFou2qVfYTXxqbd+f+EcADwy1e0/FUeXajnfY+NUxtVOUFgZMlUydGlG3elw/uro/
	kMjFADEcaj8ZCBb4k53ZBED0In7sdPqqyqyu6Ds6u76lNwwQlqpAfG5jnMJorRoOXY8pyVpSzYp
	YyW5BtK7JShGQfi8gTyUKeFtsnuSU0Kvw5Fb+Yp2/UQo2il2xomv8gdWlfGNqNhet6N7pu302VC
	Jk2jxnu/n3VmOb18bOLRaAH+WA70TS/mrmJz5PrSuzakKb73m8zESFnAwTz81Rgi1ez7T3IxEvm
	tYB3c06HGIY+kfKWA/kpx+bvW+6Jkb8/WLBDwIWZDWmi5t0eC7hRQXpiVWVBHH3gdAOkrwRSW6p
	QXjAzHLukjv7soCJh1ewoCuGwi5wcq3pAObVTPgw3OtQeeDQha7M1XcW8Zmx8gJ+fEGtsca0pRJ
	8M0eMl0o0bPZlFZmDstOaj2KxGBH1UdBJ41eVE48RmC1jjJFvf3RoT5HNE6LxTe+H/fhSZWwdkR
	jCYDV09JzWT
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396d0f2391cmr45758593a91.7.1788254802943;
        Tue, 01 Sep 2026 02:26:42 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:42 -0700 (PDT)
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
Subject: [PATCH v9 09/12] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Tue,  1 Sep 2026 09:24:44 +0000
Message-ID: <20260901092447.3028-10-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
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
index 037d4ad8f..0cbdb3b2f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -74,6 +74,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
-- 
2.43.0

