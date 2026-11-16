Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864453;
	b=rX49S3m/rtNhmg51/y3zM4lN5+bkjF+PzNAcmUO4sEyaNvVSQEMlNrWMyE9OuBxiOHAc
	 jPBx7OGNIw7wuoJCNUdKlzYEVHbwqnl6Vs1LbKv4BxgCTFBcBfPDBtaf72BAnG2sseO7t
	 novQkC72Cb3ED5pOW5wCrav8UsjV232UR4y3fCPMP62plxCsCii6+v20BpAqfJjnMFytE
	 qC+PIAAjBfUssoeUkER10l10K6A7DF/rEFmxr9phB8p0wFO9EtH2JTRIW3P/2j4TUMy4h
	 oEjulljRmHu075IZ3BPSeqOK3orhZVkd2gBWzFd3ngKopxZoJApyokLHrVji9MzCXhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
	b=ITkwgBU7yYJIlSc044Fb2gUQzlOFq4m7T8HYh/q12nf9Do9g0zWNpo7oNUr+YVGWQlD5
	 yQfTSKOQ3YmfhfEsTejC5gn5gBwlqGn4U/kuMXCwH4mdHZJNrbFvCkYcARdvm7H045Yb6
	 nC45tDejV1A+Gh52E3Kq8f5yo6eeAilS3mfIcWGxm6m7JZsqkYk+ERbb1sSSuWD4a+Ly6
	 PXQBHokE251NZrbYmDrlpsqBT3Hz+Inu3W5UXsPSQqBT5AZ2FdLptU9e/PCwIJWDnqFlu
	 BBWQJloaWICEfcBY+7dXYPD4HMQADnYeFFQW5cgm/toXjeVBwoXDUcMnZ6VeackC+Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pe94GAJI;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3981606A332
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3981606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pe94GAJI
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so41825715e9.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864450; x=1795469250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=Pe94GAJIWEr/y+mRBwb7Iog7Ajds3LL8wRIVBH/8xPQNrjbBDNlEcQCn+p1QOcbrOV
         bH70aW245d90T1wUfTfa0Sb1xipFO0e3BL/QPMT4jfWcMzOuboVOx66DzI97tdUkpVn8
         em63v1WpvLz1xDjpzkqtc09ikGmguqMkXF/iBCSCrH/7rvMJVikSjBvdeaH+nfm2b/iW
         Hjkp5FslDnjSyufprS3LahKBu44fJFSHmzAIkvAgbVTvZCwJLs5vDW8WjGCFxFP3mws8
         5H88Pj/ByqUxoJReDfmjknbzv2qH6Xj3kHe//wfRUbrzreMGjXoGLArpiGQAfFxpX0lR
         wpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864450; x=1795469250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=Xn2wx0ldsAFqlivGJFOfdYVbjxgQeFbtkR/ovQZF26yJK4vV5I3o03RTksIhEOyzjw
         uGDVG4XrCkC4+YD/71Ev4PhnYGUf8K0Hpw5dVNEuBtGre63xxow68wAFE+GT4ZLMeAQP
         76KXFW6F2tBvDhKv8a3p2jK3xLMK+9y+KS23vGNz8AfwaNVo0hEn4bWW3LYpbTR6983f
         gOjKtJwxBMccPj5G+qEBjJ2xV8rFEJ7EJLmUYQgLNyBTuE+wluX7KKxrtncqq0ZBF3DY
         Vtqj0Mi2Asr9aeTG88tb323uzI1ute0mSN5aknB6olbsTTJGYPjL4uAz3OsDgNt0yGJC
         n1Ag==
X-Forwarded-Encrypted: i=1; AL+hErGdViNWTYdaz7V9NxhKm3pQv+AuktsvWqJVoinOUE8SEHzIOlK9vU/iiLPpFEfkEbpu5+wJdbNyjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+KGv1Bi2knvaX2SpbrM/N4WVNR4dwJ1kZ5Kt2GPKjtaS/dzgeE
	UHGT2vXxXuDow9oJtKaUbs7bQXCElN/2wVATtzvBsT20G5zALf7quwuh
X-Gm-Gg: AZFdTZdkZO53VmtonB+rJlQsvIbRQJQuFnbCejLaH4xqw7rn1aPHEpsV4x0ov/hLstp
	2IAO8hGRbJKRL0ThVhgdcTHMrdoG8OpbNdON8XBSJSb0qvwBNH90GT4FoPxfXm4JObhJWsBzwOu
	ULKvPX3CB9kdG5IHQYNtE3Ya2fhX6XfHVh4+ahcEi4HApAic/xFiqnAvBKq2xrMvYGrZcqplfFc
	PYhWvu/VWMe/9/nA/UWT0+ejM9qG6B3dDcUf0+uvxzBzHNFOjp9GeQhVklk07pyF1Twkqxs2TWk
	PuVZm3Qb+F5I3K/iwfRGz6JyTB63Alw+ifTM7DTb36vzlKDiEcfawu4dcCi//waCOhuP7/V3eig
	q6eLClyHRG04I8gah7lWJ6zRYtmwgRbBWtqYsXHCmgWLB4tZIifdDpIAdJB+oj4zWPOvUC800ne
	8bynDgxVeuMpnbN31YzVLuyMYicKmEYgVsgr+n3t5AEeRzqIskrxg4Wx40HOve1FmMeJLcMVBa4
	OwReQZrKw9p+K1VlIYM0QgyfZestiwr+/xazSleV0wzjRKISgTwXapFrg7GS232CwczU5jmvQVQ
	yOc8nAnkE6+yHhn12mhkCRy73PGeRQzChj3EGKIe
X-Received: by 2002:a05:6000:1a8f:b0:4a3:8b21:51c1 with SMTP id ffacd0b85a97d-4a38b2152c6mr1214677f8f.53.1794864450317;
        Mon, 16 Nov 2026 13:27:30 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:29 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:25 +0000
Subject: [PATCH v2 09/16] dt-bindings: crypto: qcom,inline-crypto-engine:
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
Message-Id: <20261116-halliday-dts-v2-9-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=921;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=LNBr+b73CKCaJq+Lcoy2dBwwEKE3EuPIoRzvD97HKJ8=;
 b=Oo5JC5eiOukaaqszf2JD96qfK1gjo4Z88L7lhFkJnmKZtf8EiRQqPApokWBgoFrRDRq84oEys
 dN0aV0Wol0LDOOw0PtPKsKDeYZp8RCTw6bkJAf6hQZCCV8VanxNS3ZJ
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Inline Crypto Engine on the Qualcomm Halliday SoC.

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

