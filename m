Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578227;
	b=4C0N4tZBi97gJ6TS6lOnv9ZMIOKGFumPFelHwIlOxRDY67PILkr5Ez/5yF5YAJ4VSwiX
	 BgZRLD7r0z51zyrhfRNWWSloBbtOxw1YTHhDWojDqsrfk4KM4hxwgF/ynmBxnyHx2tofk
	 gpAUaVhVcY8JLgs0oRLBCzVH9pnTtHW0kTvHvnKI06gD3egPWNDeFE5dSOGL9TXSB299n
	 2qsmEce7yTtY0BjplgXi5z77QT76bP4QSrUyfh/QdmZo2NdtzC13R8uinRJAu3SCgkyXR
	 ScEpTD5i/uJxXEW+rVV5HJYGSSJZV5p9G+2xaGmBNbAf5NC1Dq8HaDjaD+S6q3B/Z7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
	b=FJaRYS/IbzRvPsqRUeFtncQ0oTP1vsrMYXJ9WCwBrCOmbgSKKeWkkkK7K3DdgXzYMdVp
	 GoQGiGNGeA6abZbAvJovLQaDsXaQg8jrICMnFDx1g0X+uHYH/Uriptdx2bYi2vwrdm4za
	 U9gVGLMJfG0AXC+XL7ABNx8tBrUaVc7skcmKhL1QRVMWni0RXnKQW04GSB9yDMY9TdN1b
	 Rv/xatGETgs7zjmNsSE5ciXzhoA3VQR69/oRjVpe1tzr0mVV0WGUkgtN3dZe0KOd8Oqj9
	 FrbQGOAWpmD5qpRtuMr+nMw/UhaI09DpxmX9PuYn24WuQp54tyRu2buYQL5SYwBdL7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0aAO2IER;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B5606A32C
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E6B5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0aAO2IER
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb61185057so33999475e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578225; x=1796183025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=0aAO2IER8kB/PZ8lVTz4ay0gUM3UnHZ/vSUnCLSG1JyAoz5XBu+KK21LecUcxMVVPv
         jsWMrr2ej7wBkGLSf8knbqOSbMCkQdfrO2H4N9ahqoxf9PkhuCMk6yKJ7aDsuw1Sllog
         n2h6BpZ1eYdLP/1TkWg1m7+VsZgy8lsZOcBvobJ1rYYRa+rc165fSgbxd2iwaIWTmohp
         xI8SWD8A92goVkdIoTQEWJCO0+eeww55ZY12t5skqCSUwNhKBJmDg8DwQBPFg/USKm9z
         q3u4ku2M7AyMbCbVEsn4NWbOtiIroMB03dZehtwAeTejOqd33rkDhsXaDj0ZB3S0ZgJ1
         veug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578225; x=1796183025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=mBMNqT8y/UVDDUPqhHZEl4tDzWHbXPS7dQoRF80MDfPBaiv+99/Fefzl3ZgZok1agu
         fCHAhZ/7RkZ11Gl1nbZAnhKzrqX4RHldf/gsvqydoj7bHYYlvY/3sV30QCcZxUwoagYX
         W175WLKKGqd+S8vGyTcEZUNbn4lH3E4HrhKcQQwE2D3jiYemHZzzcZsbyOPAR0qrYyAu
         H7vvTtO1+ueiLU7maXSD9LFNttaQjyuCpSQuAzIiBTsuNvcSqW75svj/OjyQUrzHgtEG
         KGeaOKwXyiqLtLF3iyzocYXMBLdtMiCgKp3WS9afG3vZAmoH0+gs5LOTSo3mbh4GTT9z
         bsRg==
X-Forwarded-Encrypted: i=1; AL+hErGo7dh/WEvSoekCkLcEXyogoS/WmCM78hwRK3XTd+A6SBNbNu/xu0REPkleaMpcqNB1tw+zSe6FhQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9VAa90V75jHw6KM8+fJCb2kFeaw+MUHZbpHHV6uAUbzmS2hyW8
	LvizK7ahIrc/X+vu5kfd5HwlhBIReTrB3OPYvX87ubomnKFQgtp87XiE
X-Gm-Gg: AZFdTZe9+fIx+dTjCK7l4EzYTFF0CJ0hUNu0w/2HvMVykQis92RWX5EVkkOk1YZ9yWG
	so5kilXH3YwNSWOm0uS0fY62F1SGhxudDt3CJ05pvC/py9zrGrREX1XhtZAe5+lhx+Pv7aUyauV
	0L5jc/koxsVc7WG0yeTl2JvafT1dJMQFGyl3/QzKK/ah+8M0ENe9uC2bf0Y97l6Rt1Cm03cQxnl
	6/PL7j+8DQS1p9giv+26DYdSydE8E9OK3BdvJRK+wzwQVge3FZFVI+M28lEyChEQf93s0R+dj1k
	901GyY5NJpIRMyr928WHMEnU/MzSvh4XbBKenL/Oxusm3qHN+SrpEyibkt7blRmZ9fQMIfNM7og
	yWCWqLDI6iv6WO7H1y6ZTv2sovLGi/bk0SizPf/yO/8Z+DXtvpKfo8wO+jp6d2acrEiGxFPOQmw
	IJeSlZyGE9sqMmdVTFvu2srLfCbFrE6tJW7LCJmxGzKaQLhtZ//GgyG43zfGSdS/MhxwKec691F
	1KWWm/iqW2RT3Lf/21tNcMRoMRGSJgAkfkIu5RVdwgq5yhm28YV5TPRxjoC1eqy6qnbOH77SIvq
	FZpFPW2E09x+hW7FUmVHzexJYw/Z0JwfM+4/XA==
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb887c9fbamr346060575e9.3.1795578225601;
        Tue, 24 Nov 2026 19:43:45 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:45 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:42:59 +0000
Subject: [PATCH v3 03/14] dt-bindings: arm-smmu: Add Halliday SMMU
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
Message-Id: <20261125-halliday-dts-v3-3-5c8311c0b70b@gmail.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1185;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=48k8tRM2Ds8B2KdX/k6MNHyKgJdAqOSEc8lLmnEqak0=;
 b=xCVPapQpg3IOzKVtAOHGmXsvfGx4fLaMkQfgRrvbjtK325rtMzpV4avhI4qPqmiTdlTgkoLxC
 dBxQBhGhobHDwrnWCUlsJvGEoN9HKps7J2KipZyJFkE2yjFIhJECBv7
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SMMU-500 on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..925afa8cca8d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,halliday-smmu-500
               - qcom,hawi-smmu-500
               - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
@@ -629,6 +630,7 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,halliday-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,ipq9650-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.55.0

