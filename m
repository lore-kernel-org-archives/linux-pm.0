Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184492;
	b=JJTeMm8IvpWvfcZId6KVQuhJsUz6Nl43E98vN/000qc5aYrOou5jBkXGjB8FBzTnjx5+
	 IxLEDTOXLkpqDEwO4uH/I9aZ/LIbHWfq4SMSkGC1p9qFtyUfLRNYucTPcdWzhyCaS3i2R
	 tjCWF5m0E8LeGjENt5SHw8j3zcrO6iLxj9yX84wKzd/r/eAvFJizle5NJ/0tXq5azAwcP
	 4TPkyWnigkodNkzs2C9KEzQeXyKMahCm2hCZ4C4987XdxbQd80otq5EDHJfq/bLAyF9mW
	 CnFODIrh4ubp3PlYo3UfN6gSYKlu3H15UpjOi8FutVfEqVtnHr9ItzwQQeVJWP6vYpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bqalaJtZ5/g9y9/6SBPqjpN1E4M1h8fqL8PuTjv/KSk=;
	b=InGS6BDXvF6O6lWzlnyk1YiLYXvE8slNuykELk0M9O+P/5wlG7z0OglDmqg7TxkEeDOI
	 5qSbjP/PPF7Lcqr5fdg9gh7+T5dKvz7lpTh1YZBjpFIxSc1k9pybe7/tY5Nviy1MsBmkz
	 6rzlPDnoo3JgG1R0ewqMvAubZ1wYpdPaOahVY3o4FS1JrVu/KQzOrJca27kV6r3ytULgn
	 o4mJr2uXBS9TTyDMzNm4Bcybi7AtCHvty4qVXBA0TPsGl726iFFAGZnzw17WOU8LSyEgT
	 U3V7BcPLfFS5SLGq3Zo3biBN4ZBue3HjaLUv3sQwz6nniyH03iGCQBBdRxKVP9M8fow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4mD95aN;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31606082BE0
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31606082BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4mD95aN
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so3481985e9.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184490; x=1794789290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqalaJtZ5/g9y9/6SBPqjpN1E4M1h8fqL8PuTjv/KSk=;
        b=E4mD95aN6utgtguVmche9wruQufBYUmPr7se0FjMNh58DsSqVSMujoYr0keBmRpW8v
         uWQWheuyiSWXxKez1vN9DHsvkz3dIxygT3PejUT5UR97F27EKdO7WTr8MwR/DYX5j7If
         J5n5+NU+o62GTMTKrKJF4U0oIX+yriKVSodOXqH3bAcyiqaL4rHDO9eNXyjje0tgioF3
         kJjFsybCFmRigW6JjznYVc4hYOd89F4ZaDco6gDgRFm/z6xDqoQPjP4mGVKFK2BAHaN1
         NUR9o08rR/2JzDfKTWO51s5/9EiaI8Jvltmy1OQJ6WmNNyfpZkFqT0xbMVSgVs34YbYY
         WCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184490; x=1794789290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqalaJtZ5/g9y9/6SBPqjpN1E4M1h8fqL8PuTjv/KSk=;
        b=gF2wPTtZsbYGcy8xCrZdTpeXoAN5r1j1zRdIHqy53uVN124Mzgg0/5mm892UBR6qki
         pSYpmXEcnVN15bzbMz2HFS//sFmca4uUYeQQ+vaThqM+19eoqF79JqXM1SIvlxJ5iQYS
         oeOEsXw6E1WyU37ru8QKtq4zYnSZHj8allY+pkBzneCk39RaBZmsKz9tyvRlQabfPov+
         tMFnS8R8limvdmjfN2FMrG4jtGqD1G79lJLSU2Bx6tppw/nd+0/ggXnp8uAPqAdAW2Nb
         0NM2bSGMI1KI7mFBvNukJLHSj9BOKO1LxrMrDFr1d/eUWMAK1BMqAFGfGG9ruQTKaJBy
         DWNA==
X-Forwarded-Encrypted: i=1; AL+hErE2I9MZsT5LUyWkC7AiPUU3C0gp3z6CV2wDr+WWPmcgfGKb0xzVLSHc6C6TOSSOioAi92YpDxZk2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z98Omlvj7tqIe5EGzk3Kz42+gqXIGbcBQ9XJP8o3tz4TX/ePldq
	sQRDZTjWRPg0IBLLcAhBsTlMMFME/QBmvkyHH/eX8Lz+EYlPJhBr0Dw7
X-Gm-Gg: AYBFou38aQXzz2VUh9gWd0fdORsaFhuQyZZlC0cnyI+x9hut9UMN24ubpLgNhhZhaTo
	r1KvQylxhk46IGKOtUsl/zGiN6gAmjxsAsimDnZLVYrY3TVxqWa9dipmRp3GYnCwMD8n11JATtt
	7EbbTfk+/U1Bmrpkg3Xu8Fxzo9qHppvaMCxRH8B0vMxYlXyXnBBRxdiMmT8UcKEd8HR93eiOMte
	0F8h92Ht7fmIujr7oDTM4f50k3yKbPL6Rg69vPWr+wHBVmC2XJSgKGPwqXemBFlb0Dfjl2ZCEAw
	hJASJnzbCt98Dq/RTaaqOaLDDmTQ2RltlpT/V8UJVATuNJzJNTSw5aNIg4p/pTb7HTEbXvx3h3H
	IlPtk9h6qNtHYrJkpKEAfH6ZJ7VBtL584L3/lrhaYsqN5H3wK74E649SNtrTjOEyEouwvvPYefz
	e1Vc1H0h3oMYo2VaS7BI8XMAlZgfAx7xV77K1epMZej7mUIYMwOvLhWPZsntateod3wiFouphKj
	ErSZnp1bfwbqnqNP+fBf76zytgAtnYt3xnug0yaFt3ebzACtmHJ7o0jYhDX78s2gf00FfEv3m8Y
	McfYSrwjpniuBm4Iwliwfr2OLGV4ijXyxGEmkJkx
X-Received: by 2002:a05:600c:6218:b0:4a2:1002:223e with SMTP id 5b1f17b1804b1-4b8205955e1mr111833455e9.7.1794184490117;
        Sun, 08 Nov 2026 16:34:50 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:49 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:27 +0000
Subject: [PATCH 15/17] dt-bindings: arm: qcom: Add Samsung Galaxy XR
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
Message-Id: <20261109-halliday-dts-v1-15-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=822;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=GR/L35KkjRTQHIwoej6N0ZVQiPJDeokJdA0dH1/xcVk=;
 b=+pMC0hU92qIlScFgbvyLG0yeciXJR70jYMcQsgbMkAruvtq441EcqoAR24w8+H8PddfDvxdW7
 NeEMu0FiaHdAmbbpArcsFtCmr29OynUnIXhIC1Struq0XQSLzW/yMcu
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Samsung Galaxy XR headset, which is based on the Qualcomm
Halliday SoC (SXR2250P).

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..b96ee339956d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -94,6 +94,11 @@ properties:
               - qcom,glymur-qcb
           - const: qcom,glymur
 
+      - items:
+          - enum:
+              - samsung,xrvst2
+          - const: qcom,halliday
+
       - items:
           - enum:
               - 8dev,jalapeno

-- 
2.55.0

