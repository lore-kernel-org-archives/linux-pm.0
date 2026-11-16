Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807298;
	b=RoyJUdczkvS1YVGp2w/q4TdKMgxHNI7VwiIvF81KvHT9BbLOUbiua7mrMY64ZyTzrYxj
	 +Gd+aGCmnNZC4Q319GTfbxgcVZKG1ckzDX6Vz1QVkU1gRFpI2ZhW11jJocZst2L0Snn4V
	 EBuOftj4UgsYe5q8zmUCS05SQTAsva/bGYU9zdeMCOyfkbMB4h6OnemBoERKLPsZrJsR3
	 1JNWQiEAm7AXnnyNdrZe7xhUWD+2T6RZqBv2QcWAAxQJDszmbR5ai/wN5y2hVFufHhtwc
	 vw2bodwxDTBdj5Kim6Sz44+2lI3o3KNz9NYk9rDEZZQK0pFRGqUPlPgZrNr4l65TUww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
	b=DIPXWtYdPkY2uHO8A5jTFNpUm0q3Xr5PybhvGkbeHtzoL2MVCjLu8PCUn9mSFoksii2Y
	 IBcTnY43FLJQg2A5YyXwD9dS1qOkOn0o6FegGUHDl8Xhxj41dwP8W2tNSLtMM6RgD8X2x
	 4p+E7nmahEooPCJngAQkvm+AYlbXpoKDqZwbzeuSiXvVso36IxnL39mqx+neKt4Qetfkt
	 q7nQpTucD/GC4hT8qoF39TP2tKlc1pn1h2TftvWRsJAFkXXmQcXem7N66JXJFvTxn867V
	 PZqiJ2DNt6QTUIrTIcohcZU/OJ9khoZInq6YL5N+siRzUl/lLrQeUq8ButWoXawLE4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgEkfLmM;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098D606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2098D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgEkfLmM
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so4835909c88.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 21:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794807297; x=1795412097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
        b=QgEkfLmMhlXHSaXrEB0rI647/8WJYtvt3ZL7nLXeWKGpzH0ChM+Z2sLkznM6o6l77U
         cIn902Q1pBIMkZPFitNjrvZuw2QwqYqnlmtddITPWhfX9HKYLiTY/EqF8a1ToeGRPZcB
         s33PjUoWn8gqONynWBg4d05aZfkRhr6A6OfcR4yq4Q9L5UioKsKqwiZ60DU0/NgroA9q
         Sdu6OPgMFF70Hmv4Z1JO/Oi5zKNhANjV3I13rE0DxZuZ1yZTPpJxVN6wi7PXPUgW4R20
         YfSMgCxfexW66Qe3CuXnLFZFGR4rdRAcHiTw0YZXvFj4s2s2djNDKAJil/XHvo1RLoAf
         4cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807297; x=1795412097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
        b=1SAw+DDoTPmcrk5FsTFOCEjUMHioYbrVC+y218WJ53q7sjHfLHDK7BZ7dDb5vWTCrN
         dRjkLPO0pC2+zMx9QEcRQ2Y82Zn16VMOCEDT4UxNbW57+zcZ4ETTM5md+RZ6X82bkNXv
         8OXNGZoW0z2nHKnwHtvk+iyOWqNEt+0GIo/khF73O416Dk0pJraDh/9cq5WuNFuGXn2x
         IbnAOR0+1EdGeS3PQV1eOBXGJAZkXzM/DXmzpDNjUPY+cswOlrmwoqbuXYjbcWveqD5z
         YTJA0kWx0sPEmFKKPgE/uo6m6VMg5YXJyFOBeRVeoSqANyDA4YlZDLb0xzJTVcwLrl46
         Oazw==
X-Forwarded-Encrypted: i=1; AL+hErF6/BFylQu6mJv1eVjkxIkIrWVQH6uKQ71tGRA3+XiuOOlxf2dGTxpZb1VXhuFJZ8uW/npeF12taA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9pQ0cDpmYxs+YlXDA9f6xnqriIS/9iWZtoDiboUsvd948tB4sj
	AHKQjYFJoPpVtr6b2rsjIB7RpFmRvcp9SyaUqJd3x9rVSZCS0Ka0Cnip
X-Gm-Gg: AYBFou1imM2tO7PYAZ6/sNWFm1v5Z1ztM3wc9Y3MA4hsLk37qht4ECuJId6b+jnoY+o
	a1rSqHjhAc/qJx8diSIWtqDNLJv6Zi0We7clk6W90Ak5/607E+u38CfSPLI8ypU7FOYoyuQp3Q3
	qzakPnUFUJCGUkRX00KFckDFcFLrvx3DbTAAYYyiklmeA/Qeuh++3cyhB1QJ2T/f33VsoIBgSG1
	K8Qsi/6q7cwTjJd49e+E6slG4eQ3nWG+dGJs7VhMrotGdrg03elF4ahb/AQruMAtXT58Oh2wlB8
	D8YKTKzQZ74vEgW3BPp1kZofv5IlX63TBFb57kojmbLHzfAlK9ZYPquxaxrU1WPtHdYM1Jjdvmy
	zdwUW3HcBudD7HRkUluzJR3Qnbu3nUxm8x5Oo/FUs5ITyNcLw/usYL7NST3cjZoRw8gQxvTdb79
	QTH7+kx1y/+8YfpEKzpwcCuA7fHhWePXM0P3nOMXrV4oxz4602ZXFWOkDfCib5eB6tJm5XrEpoI
	JDGkH2wEbKd23p7bgyfcC7SV6Ku7OsuWPVIaqirviIjIBfTMe00KV76ng6HLJ+Vs9Lb+nLO75lU
	kim+Pt46v8vwMhv4xsRRmOBip8iTW84n6D5gA/jKjnS/RQRAMEEfu4h+CttcpOd9kxDL6dxVZs3
	HcTLB
X-Received: by 2002:a05:701b:2202:b0:1b5:e9d:c641 with SMTP id a92af1059eb24-1b50e9dcabfmr6979275c88.18.1794807297153;
        Sun, 15 Nov 2026 21:34:57 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.206.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm33463380c88.5.2026.11.15.21.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:34:56 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 16 Nov 2026 05:33:50 +0000
Subject: [PATCH v15 6/8] dt-bindings: firmware: qcom,scm: Document SM7250
 SCM
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-sm7250-v15-6-6acbb232fef8@gmail.com>
References: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
In-Reply-To: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794807229; l=838;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=rejlxjgmjiSGoOQieemcJFRPRnZEl4/NvRv6It0RMUo=;
 b=+oPS+u7aNVKFGbhmW2mW9YMFYA8wj0VjuFaEEsNN19MH2mpLFA9LeS7/pYH3W5tSsVCAi+/dP
 DVlXk6/wjvhD/uXpn/EzjI8ASaJBL7/qCvU3NQ3e7f8GcDRtdKMByIM
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the SCM compatible for Qualcomm SM7250 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 40a267c54..ee02a9c20 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -76,6 +76,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350

-- 
2.43.0

