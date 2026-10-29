Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257440;
	b=pMxKwUYUJtmRWRAz4eWaOPtZtNPxWiybV85ffEpw0Hu1eNJmavEMHk4nfhwv2oG6ZSvt
	 771YSKGjAkoOal0ialo5OKnw0Al1ktws6XomQrbmJndYvoKd1ameojasbCbSWWcmMJuRl
	 8hAjscHKTYeMi5wYuPyldgOfU0pgezKm0N4CEgYFk8ULy/WCQDhpAb3oj5d4tBX7dyHew
	 Em+QnKDZ/lOgnES6St8h/wryau3gG6OLPnLi/FEHug9uS3j9/fHKxu8smtuf+u2XScGH1
	 /4QHz5yYfVqriHdVZNNgXx7YDW3Ql/UHsMkOunBs1pTlas6fmvSeTBgQSW5E43S7y1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uLXUgShYuzqF4ZAuBg6KTg6ZZ2I9Cs8fD8/hYe2JXyc=;
	b=BMAneoHkg5eeW42dm40Q5Rb8+bcjCoIIPSg9mA8FD+pe13MR6EYsUTXZa3rGA13a2D+Y
	 XsSBGOqbGqYpW/6U94+AgfvytPpcjfEo5Q/KQkCcWcd+2vYNsDp0RoF4NSGefdyAGh7W2
	 7OQWQN+2ntZORCA3ZmUfec2pee1kvUa+9fjNFD5cGjJW3+MYHf7lEsCxV8FO4YEWF7Ia4
	 ++nrWnVrGynM/SxYSxwwYKGIpS8LUP4UutMc8URGWWCt8ZaUbV/8jqigu6KXV/2qPnIJ3
	 iWR+e6K9vCq0NjTYuwbnX+r/L97WWFlRnZ2M2k4yZ+5R289Vrl7glrO3y7w8WRLAi1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwNoZ4Cj;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3119606A325
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3119606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwNoZ4Cj
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so3917013eec.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257439; x=1793862239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLXUgShYuzqF4ZAuBg6KTg6ZZ2I9Cs8fD8/hYe2JXyc=;
        b=RwNoZ4CjRuYkg/jasy/Mjn6HOQL5A9DiWfE94RbDJRoMBIXOa8tue5p1UA1PCBjNZg
         9pTEnZ1J8+Nap8yqIUe2E018rdqcdBP2Z2l6pgc5BghO3yb7IRMemJfa5nC1ZKO7Ags3
         QnSoYq79LIDVDMnxJgW2vBfTNhvDlc07kKp87hfd0su92VhjpCSkqJo1wAaSSF6LCT6e
         7Wo5UFuWTCyP8d082kzIEGc2gIYbeBi+Jy/kvyB5Vojav+W3TvejUZ11XSWmbTEdypki
         YgC/ofrBRKlR0nPcrpLSscwvR5e7KdPY4zccsdGIh9U4+KLaTWfC69e4L7gajvFk5Di+
         Xw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257439; x=1793862239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uLXUgShYuzqF4ZAuBg6KTg6ZZ2I9Cs8fD8/hYe2JXyc=;
        b=N0ovmsvKkqjjelWbvKBnah4saF5HbTgLVIMyNIfWvE0BIT1PnQhajeDnhwFlIucq0R
         5kMndsZgTbBdzupmFpX/g5s3oh+1Lc4FTUVChMzsfQf93BVu3CGDcqAr82tmEi8THwZ4
         P/hKrF1ony0lokjBf9BBXnhgY1HIllKENbie0qUB+QS0JAfUdzPrPa54N39KY/JBil/o
         AwVAVDSFT1kkKwHZhf30UDPjInZVWK0n29JBbhFjOzX9sRwrfbrXu0Lruxy1xClW/Y5+
         IQDRiA5oxXUNA8Svkn26sKwvNjoa54kMw3edisPAj8QyzNIpmUE0xmKtB9XPlLckjy/S
         QjTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwceDzMm2s3rmgOe7uq+Ee8n9WO+T/NYIXxHFcv0KayX1PBtey2SyoOaDsxgCullgejFPm7w3O09A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLVaRj4/Onaq98lBFfR5VLjSZq2oCA7eK9qSQiTOfTQy6J8BtLe
	PnrMifKcf+VRF4SHsZh1vz1z57xjr/IzS38x2M+Y9Oca0oiI3+OQmLUF
X-Gm-Gg: AYBFou2D4e3IdRX1Xt9IBC/fhcVIwnSIde4XMsCfT4ohntpByeBmJAOVx2Rgu875dEY
	r2Q1DzJ57n+/wYYANKFWSLCOxrvsjwTfc1EDGhyeknOAV1Lw51VQHT7JPvSDUhqzxyNKIKdfeqH
	pWXi8teOgtQAonWNj2GCkg00Sv8gjYBIIY6mNd9uHg50/akwnT85OSSQSNNrRM0x8fvYRpQcnGo
	D+vWX0pFWC2F/S009iOVovgpCm1G0mz7RzVuXU3dCR9qOMQZydy17wzcPqP7EPD7eVNSaKzh3Zp
	Kt7eo+7klHqAks99zYW6TyJ0JWFkIhp7FASjZFvyWKqb2z8z0Nk/4bj5br7p3VCGRX50Tflja1S
	p4jvL+pFvntPZ0eid7KWQuZ25zddTkOgEApPs6bK7dV3U8hnAUsDUUlaanIwE/lGXNDnPbR8ffZ
	pITC5dT5G6t7NnbqvZkD2tACIycG51rmoRp66UE8+I3pQE48SU+5Wy0Ja+CbeZ6M1NoxE+ZUXlO
	LVhwm1WTytoVt2knzlUz5gzK70Zz3hl+6X2u54CS4P/UHG8FeKx5Hii+zCUc7Z6fjkfK2qGpYMk
	bjgAcd56HXnCZlMHS+N5Um1dRiWncEbqyeFLH3PU9bWMmmqNm/H1D9lBRJO2ZIOT66liNngQsyB
	IZrvb8cP1geX1DsUDx8Bann+xw2vw8Q==
X-Received: by 2002:a05:7300:cb0b:b0:351:4866:255c with SMTP id 5a478bee46e88-36a204a1735mr8418969eec.32.1793257438736;
        Thu, 29 Oct 2026 00:03:58 -0700 (PDT)
Received: from Sobhana.localdomain ([152.58.200.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2398fa4csm16955443eec.24.2026.10.29.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:03:58 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 29 Oct 2026 07:03:01 +0000
Subject: [PATCH RESEND v11 4/5] dt-bindings: cpufreq: qcom-hw: Document
 SM7250 cpufreq hardware
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
Message-Id: <20261029-master-v11-4-2c29e382162c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793257394; l=949;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=x7hZEQOYoMz/dmWpmgNA+PhWEJ3zQC81cV4z3jRraIo=;
 b=ufsKTZU+b0OXPb0mc4gZE8Nc3udFJHAZgWNoVr7Lb6gGfhe/dXr+syALCRixe/7+HHnMIsdz9
 7leJLrSZMDvATc+wj7zQErP26XHUzfF49khI1iWjHMj/aRS0k8/yGm4
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

