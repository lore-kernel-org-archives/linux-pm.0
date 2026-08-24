Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85111420488
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576808; cv=none; b=q5j89bGxjX2RdcnTfYr0E6g+I0JJhYSVWTuwW6oMzQrNPm9OnjAunk6wYNQNzF1HUvlI+jk19Sx6/MpZSXHd3DX/i9jdIsu++knooCcXdMkbvB765q+t0qkVFIXfWHI91u39FXUa8GiaOqD/hLDSUHVHgYKlALKw11J/LVSQ1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576808; c=relaxed/simple;
	bh=iyIt2VTzEWJFddhlukajc/L6+s0oCbiYJdxmCZQgWaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lh/7ek9OXr9u9Kc2idPtYdXyerDcQF43yg+p6+7mAh24hH+zgzYGg3qsdcgYfavWV3Hpj9qj/8ISBomy8hisXeRe0rnOM59bf9qe0QHAgNTZrd1S+NsdADrAF2I3IIqs+WebCuohmdTSe+kDD+/2lb3AEVe3oXaBkopBNyz+MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQ+ZNjxr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ+ZNjxr"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2965700a91.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576806; x=1788181606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRwL2GsSIS/j4FawlFSo6ds2Awqey70m0LWn3uJFJ0Y=;
        b=qQ+ZNjxrt9TCZP7krXpKT3XtkPWwGXThNVY8pamUDRY7RpthSuS7emqbqg+Z0vz1hO
         T/Q0U2+N8XUXCkZ3wgIv5fWgEZGEbcA3AFbXDW7nMvOYu4qfO7GGJhMW/5DgtWbxvjdS
         iMft9LPMbLYnCRwts1cQizR7LXrfe4njfyq11lN67Fp/oCfeB7xj2lamC18bD1e9nphg
         QLiefDzftZahxK+tjIsf5gxT6aEeDJDNah1FuN+pJ0/1sOgRhviQ0GUh//RCSmpPlAkP
         JSYaOYnza35VWNhIiPS6eHgsdZOUJoxx3nU4VjGrdEEUV9NIc5Lo3zMhRNtohxCkXMsF
         7Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576806; x=1788181606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRwL2GsSIS/j4FawlFSo6ds2Awqey70m0LWn3uJFJ0Y=;
        b=lzCuEKjQbDxrdti0QacSuE4TAkMrVluiBsnOSVwStexADc8EyzP+6R9viZhDkWLsDn
         apNd7BHXH4Ure2vEazzTDSbW4IQOaILz90kOrEEcptCCFJYzMHm/xyTzyd91Z94uwgbB
         bZFV3E9FxuAg4cTki+ijGJ4ASJfP2zYM10E0eGkFJS5S0ii0h+G/kqCM4LFWOrmmO7dY
         eyOYtDopz1fqQQ63L0STl6NdqoTEg632A587tv/zVA/xsnpTrjooji/ZM4iSqz9wuYuA
         kw+P+aQBmhL15PBBwHWo26x0sesfdNJBAFN+7wCrsW0J9hOGNJCcNvAaXi9RUmoL3fI3
         lr4A==
X-Forwarded-Encrypted: i=1; AHgh+RoBKgkh8N6ZXaA10/eJd5MHAnFPGSKhkM1eynF6fuyDDnExckDy6JUMEHsX7i03ZkIwJmI400Xf2A==@vger.kernel.org
X-Gm-Message-State: AFuF++k9oTXzcAIeJ3OepWKVD8+zctNo6ShpnMOBFaHfbwKj0Sa6oLyl
	qcqv6wCtAnoa5ZG0A5+rbMNdiHibFsnSEDFvBNiYXKEVz0oFqobmjYO6
X-Gm-Gg: AR+sD1381EP4bcgnXXbuHb3ciH9BxUS6HywWihdbf6OpacMnUUtjxeMdLVedFGkPHRI
	10VYJXQea/ljj/+VJnKEJjfcWPNg0Ehz4WXKlNxaKzXRBr8se4BjY/6TvtynnTKa1nTUUMRh9Q0
	MdetouQuLfneywEAYccI8iAnBRcg4wJ5iSj3YuPdceS/r2RKh6gFcshDvJN1Gk3aecPwb3aBSjH
	AKxGnEBui+qXoR4mnpUzHNhRLKXH9dMvdYigHgC/2HjubInhS0MhtN7ebenvOzvJ0Fz3m0zahcw
	xYshMsRU4dKuN9Zi3+uXQHEuQWe8Yiu3t2zd4GqgUHlKZBoxIpDFoOFFgvmhP2KbDMWgg41Ywfi
	D9y/011xWaAOkYTz5SDwcKabHb1U2MzWdUHCHH2k+Xzd3qhCK07nowGm3ys6ki6Iaq4ac7ITa2E
	XB4UmY/POVVQIr+RmkU7FMDmNeIRhKUcJO5glycIJxDXF2U6fkUVJ9t+GOHRfKxIsCR+BIY2iVY
	Vysw0RFcLgo
X-Received: by 2002:a17:90b:3bcc:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-395a06bc47amr39222445a91.16.1787576805712;
        Mon, 24 Aug 2026 06:06:45 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:06:45 -0700 (PDT)
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
Subject: [PATCH v5 10/13] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Mon, 24 Aug 2026 13:04:34 +0000
Message-ID: <20260824130437.2771-11-sreeshankar0910@gmail.com>
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

Document the SCM compatible for Qualcomm SM7250 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
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

