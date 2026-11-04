Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810865;
	b=un7BnnjaWgSMB3wrwf78Bb66gldTfrvXskAEoykyhctYLb2E/fUhj5QW1sV8Glz3DzmT
	 3sFxgNwyOVl4qFss47n8SogpcI6DrynvsRcPRpkGEmiR2IAPm6o9iRJFEDqADuPgaheAY
	 EIpD+//Aw8dRUKKl7XDWNF7rhe1wh9zOHWA8xQNjWvvXmc1OGEQaWKrKqhwwMbuB6sMkt
	 0K5hZ7ASdbqwmnbBp2BkhsgZIFqdHvh0qM9Jet39Yrfw0epxHsKCrXCJTbBvcJuFGWtB8
	 aNSYytt/c2Bl+DojQSNiQM5yrAHlvVACdMWhDGHCVDkgpUmVPLjMoa9q4scXy3WtPHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
	b=m6PeyZKYszl9TKmb23KZYW4dH8/iwrY+FJEmeQFCGvT4d+s9lP+l1rGmfHEHrX9s3vm1
	 FT5FKZf30KdO5wiFb4YEA4Bmd372YEpiNba2cJdnxvwGvlc1w8A8Ims4MfaZTI1pXpxNi
	 Ro3ld+EyXmEulL/Rctupc3VDrHxFVW31x8tFwzXE9pEtkygaCeWuBXFFIu8LrOSeYgScy
	 CIFRjGpAvggIRfG/klGOsVwc5mifNj7QDgFAM5s4u+dMTkLt1Cspy7W59kvSi4BDEg+7P
	 M+arp8dZNJl8yciXzKj7OjQEUSihn3UoZZzXKEH9QGB22e13RpQJjsC2yR5hRZhV55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDKTeHu9;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D90606EEAD
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25D90606EEAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDKTeHu9
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15943c9c005so2295096c88.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810864; x=1794415664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
        b=oDKTeHu9/D7LEgoLtX2Id9RcRVT+1ag0PVlRkJn6LRUJ+tPK8qy9UNhH2k58LkNP7E
         qwgy6EaLkLHJ5BwA5IvnkC7NrLSYc+VeBrciVkYShA1mSofVv9xqO2P4ZLrlUdVgesFb
         U4oV45ybr0Ly2k8X2vFleAjnX6CyM7N/Xgxg+9o+QTkozkOGqbyFkhZTJC0C66h8lVn3
         Ngdhe2KDalL8T+jNBgDzqtZqBlnUPLVnkYXrCHkELW7VjmOHykwjTSDbPWfceaQ8znz9
         Hm8qjdk7tKhA0eI3M5t6XXN9tlH8Ir7rgJs6gdNaxOal2rgWZbfX415OgUxvpsc1Yu39
         sfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810864; x=1794415664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
        b=hrHzPl6j8GGtExuiLsS0wlRozGgLpcs8qD3o9HXbaS2XHVczSkKAJ/uE+NAxbLBk3Z
         sWyXigQ8PNjEv2I8uwOdVBe22TKBzIXQ098FZwjXNY9JHB3dcxjTE4Dwmc/KPcpVqMTb
         avAUjHZr8Ewun+2bqzBYzFADzvwAHneR/fkDE0oN3sVcBNxeV4Uw4W3lRqrh+f2Lp30N
         yx+bxTmgFUuAV9rtFdoKcS6LOPuq85mUjPjOuS99Z92aNd8ZEnVXRUVEb6pmY2c0WZ/S
         4dOL4qYmjVKmgG4qpPyaG88KXwpHM7WHD4LhHvxKQHkv8aD0HZhgl4ltSicuhLjefksK
         l1AA==
X-Forwarded-Encrypted: i=1; AKwUvBwuqzXi7HdHQ/lRxF4kyN4eRzMJvYFrHQEttvbshGzreGhcP5ZeJTleoSNyVqsEFG8xyeyYMjISXw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+mzl2d2Ej3uKz/wTu5Ldx1eJao3Ana321wHkqgmmN5sRwV/qvI
	lbPn0VUJKPglEHjzAHdeuIzzgDS9IZA/7FSuyjxmF82L5cmSoAOSQH4E
X-Gm-Gg: AYBFou1xC5Kta4QxTjtZ8/CqlvHG+ZL0VcrnQk7x82d8H2gpcWzNRMNXgshUBx9SS60
	yX1a+i89ww6bg/mH7X/ZOwOQVPOYpgk2PlAeVRoiYSx/OdEevZGnPsI+7K13r+fl0nXz4BU5wP+
	x6HjQaY2mWLP264YL4RbiGN9hHe075saVS8XGGn1adiazvyAbOayse1uoE1vMQGcWt+Q8ZVEm1u
	Ina95Ih3cxaQsl9S21JEBnwT7WN2TKJ/5k1596fQQ5RJ9aDiYDov0CIEAxCypAATt+qoG5KdxP2
	eUi2C9e3RQe3IR/NU7kK+tJLPD/4ixQBmd7Uw/yzEkBP8x7xuPJMLzfPaLgF29WVASmzetlAdVy
	Su7OJxaFWzubMV1C+qPIOwYM3z0SyO54B4X6oQ3mRc+qEF3aXF00PtV4+uTqxNxJ28d2LKtTqmC
	DElNuFE5FBMIJU8IAhuxlbVmm7KJfgqGzRsYMf2YdhKRrthW0cCfYYi9jQTk0A/CCE/sfqUogRz
	gUL1qAAJUlcYAOzbWEyJT9PTAcp1KVOrJDg0bOlFRcQ2T5p5itI2Zy/XIY8h/PmE4tVWiDykS3S
	JnTC+0ABrfqoHQcdc9RMzPru5nMQlmhfXtShG/epQGHEKyfhI9tHBZjlylIe0XisFNv2og8QFJ9
	8xNYlTjE=
X-Received: by 2002:a05:7022:418a:b0:195:e4b9:d326 with SMTP id a92af1059eb24-1ac5b9cb638mr35445301c88.12.1793810863974;
        Wed, 04 Nov 2026 08:47:43 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.207.207])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c57430sm10839666c88.18.2026.11.04.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:47:43 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 16:46:38 +0000
Subject: [PATCH v13 6/8] dt-bindings: firmware: qcom,scm: Document SM7250
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
Message-Id: <20261104-master-v13-6-355b65c6f764@gmail.com>
References: <20261104-master-v13-0-355b65c6f764@gmail.com>
In-Reply-To: <20261104-master-v13-0-355b65c6f764@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793810796; l=838;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=n/5l0LzNHQkrbMmziTZYOIF2FEcc8PMKPnj4oscjta0=;
 b=Sm+u4EHvzCpGgwZKZFX1DxrtxcvbrxK0wHlNVW12r/ijgENS8oSQFaV6rQsbmumD7aCwcC/gt
 fIcKsAunm2yBJViY0+UhK+wTGor9I9Ro18x6cbo/n9EqUuUrNeNrdiu
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

