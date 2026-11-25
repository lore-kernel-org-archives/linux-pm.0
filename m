Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578218;
	b=FtBAXb1hyVJdYUl74AoyDkMa7D6I5W3Cz9fv9M1CHDzYYCTp02ytuhiOmvJZKOIGPo8x
	 4wvYIkOA5bJBh37CIO4E9Pg2KNOpn6HXM6prKkg4bBRRcYLXNNtHLO7w+nQw/0KsLJ+of
	 /g1fg4d8vQso3Hej0msQ9tcMlXKadhFCXFLKV13rIJYAISaQfIj5pOUkBIhfS/NwDY0P0
	 VyI/8XyB9PjSZ5h6DeNfqX9hwyn5GSj5dojmQEJUQehKNGAHp2Waha+5HGj+0CDMLft3b
	 2bZ4ssgu+5VdZlmhN46xzseJfXs7qUucsDNzwq1PQRg3VEtoixEfb9w5PoIghEwVaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
	b=QXEWs2xHXBUallZ4jilv1jeUdSe/Um4aQvKb7Hxy47oc9UnHxpKoFmAho02AOoL5LInq
	 q0JGF95a/wRjIrwfRaPCeP0vlwqAG+YVeBEFCLynPtVBf/2H4ClkmaqMh1CR2N/MGgo1K
	 dRfNEE40J55VfXUOoOX7hhuW6Tw1rZoMdU/yeezbrKI+pVVxc9jd2g/GdfjAOicJxBDA5
	 BGQwmsYe3PLl/tSqalDgSmnioGaT3xQeZHEa8zEh26YpoVOc4qy83NWBLng+CRDmAipun
	 cBR6ajkY5EaxPX0rIsUx2oFikcmlr3b0g2TXutn8IFEcRuBCQKU3zYRvf8vvP7fMVAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHm56pzM;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C3606A329
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6C3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHm56pzM
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so45196185e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578216; x=1796183016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=UHm56pzME5QuJjhiAlkwHOpYeDJa6yB0YSYI1bvu1L2C1K/b8c8JqZfqvQO604D27u
         kbijntCdsTmXmZuyEXTOb3UWjibtttn9sm4yIUhv5BWWR4I4ZkBHypc2EQoj8gClP2kH
         iWlUwFG+ksAX8PfuGzyqwgPWimGWoKbwCaHODUEXgT6GTXr7IYQf2wZ866+zITCViM9+
         cWdmBvAUOA0q46kcT5cB45N/Ty+c6kaDy9tabJMeqja7JP84/DXzhEmYtOJHcJix8lMn
         ap6y5YurBKaiszdHFCygN5ro1OeYnibVACzFSOUr4CNcobuqzEvh4D1LFkTgVWGuKHY/
         cXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578216; x=1796183016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=UX8tLb7PPuZlcLRA0iGcXt7qswn3R/6smnzzWh6Od6ThGPXMeo6wFyks8/vdmplAU/
         7Z9GSxzbdaV1Kxh0rdEAZB/z3SHdxTvjRekRiRrVUoINQTRblnBRtz523vNmI1zeVWyH
         1Thrha8YzpFsLJWlX8F1V8nq3NUllgnYFudWuZ/2adQfYp3mXKOEohF+B3bwmzoCTad6
         zsV4W5Yg+0zrvhTiaAi0RqiboSPH9I9Pq8xbqwZTpx/6fc3nTXdpQx3jZqRP7lbCHDv/
         sxyaCzmvsoj9oNoudLt2W+0y+B617sAQbLa+5N67MfWN66a1hqWof55yGvjOria0+b5d
         I09Q==
X-Forwarded-Encrypted: i=1; AL+hErEOlpIJbvimqCumBbQdp5KqmWBD/XuV48EKWjzet1SQsmp/0IgcmnzDIRaz3JlhjJzxN7/XDBfXQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ppj2kReGiLr4Y9YUY3dx+pliZOhlC/xcIt1KjO23QNlbTeI4w
	Sj+ipcptljcQQkn7358lK4vzsDYcLYOwv1qCEbcs68wQU1AXmSkNk2Yo
X-Gm-Gg: AZFdTZfaUZ0zMtzcLWMQPzDLCobJQUBOuAbCqFgGp7oT48e1Hb5Kn9lm2lBprzxQH2B
	r7Mb0KYTt+aMOYV/3JzJS4kMYmXO7dj3iKW5ehqClcdoyBh+KI24hI2hSxDnKECiZQW1ceuAA+T
	lrZd8aJ3fyCyCEY2nCd7MkOXHzkNAtWkB1/NJqXezZk1Ok9B8GHr4ZPs1vh7zRy8H9A5NrRskGq
	UvQdwObMnuDZWQZLMRYomO32/RrnQtoDqgiujU7i8qTvSHjXtJ4KRmwiy3CVIyGZ7BLO/r20TYu
	in3Di9dBmEvHUfrsIo3s+B4Ec12CoEL27eDM8Q4jI0sFEm51MWCx2oP9Z0SWLELMRI5YsvCLT+B
	PkSt9Yjc99q3i2yiUiggozCzMIO836gw2tD3oXVHeuTwG03D3nmuf1iD1l7GXEpSjd6SGQ69u8z
	e12+di2QIP8aGQAMgsAsEBpffaKF7/mUaFKmUzqBNApQvEdlLICR5OUntplEojiaVOsYxMJHrSj
	FBuNWeU6dx2zESibzOQryDlmaxu3eZBoJdlzLuZmwhqSr0jJHEBNXOE8RWvnLErWSA3qeMOXPQk
	40mgAW6gxiXTFEmRNIn9gw0iR1tmGW/BMVlreQ==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr346329005e9.34.1795578215688;
        Tue, 24 Nov 2026 19:43:35 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:42:57 +0000
Subject: [PATCH v3 01/14] dt-bindings: interrupt-controller: qcom,pdc:
 Document Halliday PDC
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
Message-Id: <20261125-halliday-dts-v3-1-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=910;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=TIEe9N/cyAzKgpuoZBtDZhrBfZnBIMsVZBId/jMf7sU=;
 b=h6Yv22yIDPhl899/gQR/dzgzFCiAwokqygzx53AniCMssmz68nf3bAUZ4boIxRmClQQzRo206
 0Yy7j0zKrrDAxm4EozqJW8b/LA63zgVJosiVzUEWd1tTWYtwAKtrSzc
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Power Domain Controller on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8401d3b48e0f..cf20041e86c8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - qcom,eliza-pdc
           - qcom,glymur-pdc
+          - qcom,halliday-pdc
           - qcom,hawi-pdc
           - qcom,kaanapali-pdc
           - qcom,kuno-pdc

-- 
2.55.0

