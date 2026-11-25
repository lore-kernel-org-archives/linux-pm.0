Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578254;
	b=xyNbQsG/UFL8dkZpefDj4JKx71DYDkBkxXjZ6f8s9HCmEM7B0/a40YJIyYQnuFEMU4WK
	 EzD3mFhe4IRXbm/P7TDheiEs56WfJNRLfDNcKtzRjY90Hd/e5lRzmS1HV4dY6K5sfWqyt
	 uhD8hyo2oqpV19NAaztZYNhiooXTfvRi07jXeKo43ipQz75WWqgtuvFs4VbKHjrdMNR+y
	 7wO3eVrgUlfzUeWGAUs8qHwUfrVHOIL1OmuJcPax+SK7u15zfUoLt9KJCtB0csGgV5qhn
	 C2Z98By7W4XRQhX9x7IfiEjeSFE1mexU3+jygxatJlH4frinoVxSbKDBuEIRMHcwwOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0gMkbbLOot3bX7ZvRSJsql+Zsoh4W/ttXNIHMpReErE=;
	b=ZnZ035hFBtVuL+JevkGpScbKxb2/ehRjx/cjTp8HTnRUkxFoIKDotoPNacT6RvHGpDW7
	 jciioSWO7r1iJRhqndgHmWCZjgs1X+Iuz0iYMyh6j9sKa9wxktpTjiLlBeLpJSCY05XqQ
	 4RKXmMzg+CFWAJ3bNJtIsqiyPgqxgvKxUVBbjG8EzI0quW8H0y2zvGC2qUChpwWryreIM
	 8yvGkD39TgQWJusvF5l768v7fnLTa4wFs9JqB7wTW4gfWbl/izeCTMNsq8wrQ7FdHWSzd
	 /mjyt1Vwu992crgCkD+CGHyoLpJl/JouRviPXxNn4fTswHx/WtatXIbLUEndQLErLkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lEdBuKcF;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB559606A339
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB559606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lEdBuKcF
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso1781895e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578252; x=1796183052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gMkbbLOot3bX7ZvRSJsql+Zsoh4W/ttXNIHMpReErE=;
        b=lEdBuKcF0JncIpcutUemWRCVLwcBptVk45nftYoXdUPaaPEMjOXhRvlDgUBMqszRSi
         GjVW7ES9OlK67a/2KLB5I65GkIV14Ylzo/LfhicqUla0tHCcqXUHFVnVhyXZGsWk1GYi
         30KWFrA88HI/8R90LcNab9RdDuPnarcq6aW8IuA8Dbg3UasrVz81iXsAmAz52FFpSxkl
         kwCNrdjoDvsHBIUIV7L7pGx49IZu2fqgEP7oIu858HUHqjSUGsKRfpJS4Xm/DgASvkCY
         ohconOG9BXS7zsTTxG601/wjTYdl90IpxPDLaEEQRmhw8dfhpInmpWHAFkRnignmsUL1
         jNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578252; x=1796183052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gMkbbLOot3bX7ZvRSJsql+Zsoh4W/ttXNIHMpReErE=;
        b=JbnpufvrAlnrxMcTeR1JPQUprxn4QGf5pPcb/0XGYYWssWZrgjibwg5ArGm8ndF0sV
         +wxfQp/UR3BPWniBICoQyWNHTqiuJJZbUKzSKVB2eWMf8bBFRH8N6HFt0WwE16FBXTh5
         /Wnw1crTDz5u/0DaTQkH4I+r9N00yL6xF5KD+LUD+iz9cWB84zL2KgOOHA+6CoZVk2WD
         cyrHEG1G+SBwqQjLglMsTtNfJtEa34QbuDhDPCIVqBdydsW4fI9J/q6nzNwaQiAItUQl
         KYh3SQOvsfzXUCG44uI6KwJ8ahV35YtmkRfFFIxjHUhVy4mgwPP3fA3inZEOgw4GmGKQ
         kYBA==
X-Forwarded-Encrypted: i=1; AL+hErFnDM3h1flpORXrxL+MbEXiVH3/h9FZ2imyWEeJy2OUI1HLdmA4/SzWPIAicX3TrPBy700kiJqMgw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+K263I822gE+ax6CCx4oU233neLlHxxVTA1Y0rN5hSIk0jySQN
	REnnWXJHkbRiQEca841qTjZKE9n7FXH14y9z0XvCa4onpX71WkohQfpZ
X-Gm-Gg: AZFdTZfK8Gdf9gUNzchqcVXazcXeL+ap8vVb1Pca73dZ+bZb7HNb2D2QzS3j1yplkjh
	lvU3aoHI7qsPkYTLGnF5G+cjzY+EWC+h93A/Q57mQglMcPMIPZHCorh36PIAyycETDMiZXEMTca
	sf3Ubxv4PyrmrEMObNxBGdjmVw4PuEaSeILtdvH7+NXJ+a59/ryKO9KzNg/B0WbzDH0Vz9bSZDC
	Kc3iI4KTEkb3LtmyozQI5WX1cLglr5a7KFi7VVAwqI/UHtGChmZtbv4WsPJu0wLZ8RHNsXxvv6h
	JbyEcQJlPQTTlM0qVtm1j7OxiG4Hlf6ssYhnaDxGnbVxwpd/+HtrHAGOtgEKY+83XDo1mAxifzl
	lmpW8e82fm8dd8wq6ouSDyGp+B8p9JgY3xpQAV/oV+YW/x7R1wrzNiyOI6RapeU0xzkbqhHAr3O
	frj1XTdGv6P41z2fuovfbyw37b4M3yYJvB8b3rF8a5aQGfOKQ+qu87KOY0Ib60adsXTRyvcFxgV
	YVweRq/EMml1LnkHYWLI5kC1q4KhExE2GVxqo7+ndTj+9xWB7xPDQnXrwS+HQX4JazZeUi8MNC8
	S6hEO3vcEFYnzP2Vn8TrSf9mw4suwMohndmvTCJA08mpvW3bjhMPj3Y4d1Y=
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb888074bbmr399963545e9.12.1795578252392;
        Tue, 24 Nov 2026 19:44:12 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:10 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:04 +0000
Subject: [PATCH v3 08/14] dt-bindings: crypto: qcom,inline-crypto-engine:
 Add Halliday
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
Message-Id: <20261125-halliday-dts-v3-8-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=991;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=iODhhsd3yfvGtcciUvxgx8qkDXgsEtkBlczLh6ZRfrQ=;
 b=lvcDevXHoUjfOVIKmGcAADmxVZULBy9zMoHqx2H32a0E3wUM2ikLAFlGNM8+8Y16B1yXdXwzE
 0y99BcDJDu0At3F9ibFbmmvIZEbRo82dQ3K+iKDoR8DVQfXtRsOln6S
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Inline Crypto Engine on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 23bf98c2b9fa..1512fd1d7471 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,eliza-inline-crypto-engine
+          - qcom,halliday-inline-crypto-engine
           - qcom,hawi-inline-crypto-engine
           - qcom,kaanapali-inline-crypto-engine
           - qcom,maili-inline-crypto-engine

-- 
2.55.0

