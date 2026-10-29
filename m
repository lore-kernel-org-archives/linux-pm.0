Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257431;
	b=nU7F0n5Wnd87lcRzQRY2t6+ba44fdAVFGyu4wRzJJbMpQYPCt1H0CVkjdYYff3ygpNtK
	 50Tbje5S1Hqzf4091tyxUMoRKKlyOw9/jDpuUA9Ywe1TUbimZJoHu6z9gK6ZRlUwQpdYY
	 4qrJgyctgyNnahrNnd/MacxaNyouVoBWpleO3I7dWV7+bSUvm66rfKFQNzZ2p//rM+mj0
	 IEkH5wdcQ5KrhG6ZkyiYHfn6E+9A6DfITEo3ewL1/QSMlXaHRfGYXC5PAySAL1Kz7GS3V
	 N5DVFNRycHxp6GdeinfZffY/FtQwOxA0m7bhjMUtLiVivKVVL+F8TPK/50W1D+oJY2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
	b=y+V7rR2ODp2tY75EPzwgyWNJrsiwEe5gPmYYcd3yLlKGFQ3GOOMdEYIuNHc66JmjvWNX
	 ZwQjSx0ZU5NaQ4q3eOEdsLZFr9eHsoOOz4tRBZySAQj4K7LJF64Fxi2u+NQ6RzCYHmvYH
	 m8T31FUQi7dxA+40Z7wvY9mHciFoOuDjXEHawTbojH01wbYoHtMBV6c7lsDUIVQZf7HzG
	 76t0Xoc8ScOTFlJ8zG9XPQrNRA4p3vRGA6sJEVmWWGef8JbOk0iVwFFWxrwxOzrAoVsqN
	 3m8N2nWGpRM7qZ/anjtuO99XCcEZLUTcR/y1+yUxZPzfe1jC1GhwYBmUWQ2ftBYFjFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+pudE1W;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9A606A326
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+pudE1W
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so3356377eec.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257430; x=1793862230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
        b=F+pudE1Wz7CqOqPaimvu4Pl/+YNsvoQM/t+U/mEYukGErBeyHWCN272+UtDoWNvHMC
         vAbOVjw5jNDZKqVWvZIigAyIF/4ESJZJg24DbMqgqsPrjUo1VXoyaa84Qnoc6dpgsKow
         JnXYjABw0qcn7QpUtnBpbMfNOIp8jsS/bzIG1KqgA32WsNOOhrTRm0M8ilMrd+WFoIIj
         2Hu6CwA/ZyDT2GE4BajHITQmDKwrg38kvYBXwKRGjaijJByJT/VazKfta/CnxRw+8FlJ
         ut22x4oOCDQDYQeIdnZqr9s59cDhITvsT3mB0kPl54Nkafg1zi2Q1XTY7Hd5k28YU8XO
         lt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257430; x=1793862230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
        b=rmSDLhztWJoSMVqUl3RxTQfIfKItr4/dUHc2MkX/q/wsrBCbrs2me1ROa0cuVDFLHE
         vAnjiV3lvhJMplbpclBlqQl+bkex+i4ahQK3f6dL772V5Tn7Mm/4qZjQMEKiOm/e0kOe
         Bx5eVECRks37X0pZuoz1O4oE6DkNBZeXNEBI9cWQ9FehcHFZPCySviMj4vP8/9gUW+LX
         wRxC8Iu+yxKxYac3Akad/KR2K1g13QoiYau8r2gHo21Vjr59LKKe3sxbSjfPjEvIpany
         IMKdH/w0zbyRGquFkM0UsuxzdZPYnbM6h19Rje21hkAwyO+SILaackTSjbtFAaAyDBTK
         tL/A==
X-Forwarded-Encrypted: i=1; AKwUvBwOWy5pjn5DCVWMoMRplC53BzYlHnvVd1fHi486xhTKvVP51hBKynUiCZ5m9XG3bcZdxF4Tdfgvqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIt4TN2uZqp5lfuApnEJjufacb8oLkvk2YDgfjAl1RVi37+o9UZ
	AsNRmgePX2os5akqPph187njE+3JhDO1z0JWdai6rOTg0O8ljl73Y6aD
X-Gm-Gg: AYBFou14NVdz2By6aof26eNn5/vDsdOulJmK7YzSd78oCS08QeiCFLGCTGtjRgYshyW
	SNlQy7H3C3O4WVUgW1onLzDlSOB3BS/ne9GYHB8gk34+yWC8wRr+NroseeZ6UQZvTY9gs9wKNS2
	oLz+YpXElZK1yE33t0yBAiI63+h2605eZKQXjAh3YDshAbCVhwLe6CPqMh5otf6+NnhNxXqnr46
	tRFOnOzGgFWbhTjMm/Y5IeKQvWHg84URNBgQRi98bw6o20H0Erhbz1foQcdvBuF4j4+X+1nwDtO
	r5SaJhIrZGiavMnPHbdaw/w3v5neqNa4R9DV+87NgyNHq1ks/agLHkQ5zhE2mBRlhaVGoAsIkA7
	gJTU5QKo4waKxZM9fTwS82PKPDWXyKIWxaLXyc9rxx50TVt49Nnr0Ted9004wBdjqbmi89yuQNm
	3U/7D7msaGFPHb9Y6x7/kLxVAOJleSNlM5nqefKfgSXgPvF7IHzZcMHyApa0WHK9ZVz9dsKcyNw
	G6z+SMZKBwSCPeEeOYCUgSR/7jMWGcX/StK9GAFwZ1WOIQ2vXBonZCoe8+wk+HwMg00kncSBn+e
	66yqB1YyEYyIvTqx+2NmqYDRdbqETDed5fnjiOP86xSV2AyFPM1F1dt1npCdkVC1OOBOKVaV/xv
	PuDJFBL0iENY9VmqTfzT+ZFTM2ygr
X-Received: by 2002:a05:7300:e11a:b0:353:7d17:9a86 with SMTP id 5a478bee46e88-36a200bea2cmr7029875eec.26.1793257429997;
        Thu, 29 Oct 2026 00:03:49 -0700 (PDT)
Received: from Sobhana.localdomain ([152.58.200.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2398fa4csm16955443eec.24.2026.10.29.00.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:03:49 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 29 Oct 2026 07:03:00 +0000
Subject: [PATCH RESEND v11 3/5] dt-bindings: firmware: qcom,scm: Document
 SM7250 SCM
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
Message-Id: <20261029-master-v11-3-2c29e382162c@gmail.com>
References: <20261029-master-v11-0-2c29e382162c@gmail.com>
In-Reply-To: <20261029-master-v11-0-2c29e382162c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Danila Tikhonov <danila@mainlining.org>, 
 David Wronek <davidwronek@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793257394; l=838;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=n/5l0LzNHQkrbMmziTZYOIF2FEcc8PMKPnj4oscjta0=;
 b=gjdaSkAxoqehvftK1W3o4GIVUIA72A6eMiGKTKK8PKFf4JbbGxuhscbbg/ywU6MqKNl0mpR9g
 xohlD0CPLyOAVuyH5IEDoVDWsgs3nVO3qP+to1jabBDFYp6pcoRN6tB
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

