Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578233;
	b=L9AGPDz7i5pP1KNTjuNdeN5dRgT5UzsT3VyhzBfMfC7N2EFGYN1TLyEc6WeBqE0ZlD/3
	 I5TMN0bgPBJGC+LGnDOiRFppfqxfql4CV8qnC2MaZ19Xi4yaJSweGt/s0OYPqxqK3Ck/p
	 K4NJHjkYrKNd9GjFidrQkIeM+iqv1gkoJ0M/w7xm4wMAhnAsOecUn0AC/GVV2XUmOmXZE
	 Hb/Blu8Eozakg51xhdi9wJftipnUxgxvsweOt0flCW3MhOVOa/1wSigejA4nT7s6ETh2Z
	 K6O22RVccszmE8NjMp7a8/4SKVY0Llvfgh2j3F2UttmltWOKiHE0gRGoRIjDqsfl1TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TFgqKxlazYIiygHGpDBq+o3O+fyKWKSRL7cBtsKpS80=;
	b=GFq01bKZo31ixAjbGbC9NL3fjitRGkoTUx/LSIL8lRfRX1MjyxmhHqH32ytCoZpYTxz7
	 9nWwidHcD/Hh/egPU9APOGcro0ipJBr4DG8wJql1lyVxyhldE/leReSZmAGjFP1u85P+s
	 uTOnCOPA6GARTe/tGAp+uz/fTGlQxZU5UC5ph0ctvbM5Fyyh2Kw8qKTcBCUM4daWWYEGK
	 sxUuX+njS8I+njDgU9l4+u1FLUwgb1CRfS5s/qIfqhP9s1hgwDwjOb0ZspYRSg5xAs048
	 ZZzqCaao7j/gH7cyq2A+wrS5Ky1xhiCAyd8P9YbHA4swNl00Pv7dC5F20G5/wqOUQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk8tnEm8;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393D606A332
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F393D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk8tnEm8
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so41904935e9.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578231; x=1796183031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFgqKxlazYIiygHGpDBq+o3O+fyKWKSRL7cBtsKpS80=;
        b=nk8tnEm8F0P2E1eehLNgHEIiXKzmAdnv1GtH/CF8tgRUFnMdxr5LS3wLsOby7S2Q1a
         cu5bhPH6llcMl0Bd4Ml3YCNlc2qzQVZYy64BU5JCXGdyxYTYIWgn76wItDfnowDbq+tj
         mBu/u2AoC4EQMLN4E5+BKngr2RQbPOWFa/jkefPtJmpcw6O8iLS9NHjTaOlxM5gw5aE1
         TTT1BHa+N0e/SyZxRABUIDdmTTKnn6jXzsMzYF1JRXep0cV+iS6lgDbG7uwfsTTzKX8i
         P7xAltyFkuPxXGNxubmztICD+yHtWeFb0K/WzvCEm/RQin7lrSfWUIrr7aelUKKa99i4
         BZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578231; x=1796183031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFgqKxlazYIiygHGpDBq+o3O+fyKWKSRL7cBtsKpS80=;
        b=rnt/o15F4NdV3hDQ4uDI+EPu6Y1w+MEcHEZ+G9lBDk24I4gIrq0YNC4dLpD3629hgj
         LgDzTzgIq9rC4C5B5Myv9w0G4F44XWJUwXlz++ceJoIdJvbwgqg4wIf3B0WuJRwSH146
         5XfD40RkY0Y1QCGyJ4tmYPCjclNoSQKIc98SKZxycKO9U++Q7VDpAtOMK6qEMj7IIpZZ
         qMhYGz2bJBWEFsIWQXNxe6GV+oGVF1KbwgSF7H43O/JYTIDEAiIwOdc9YcjcL6wmYXm1
         2ZbOIyuCLrPm/lzQzuLWI9CTCGGSSRdKyYOWW64z2V1Sk+8QQqrm1pc9VXAnLxP0rDYt
         uRCQ==
X-Forwarded-Encrypted: i=1; AL+hErEJ1+6Q9+No4Z/FoC/ND4CPNKDNSIf70qIV2NCRudbxHF9sGAAHDJH2w/0cJQRAMVeHfpe0zxuOFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9eK3+FOOpwOGJIrTubgn9yfamzBCWyhzeBWtnkiGBdN0z6viOj
	N+xqcAZVYtwhgrOr+IpeCrAWCCeUbuTJ/M2acy7ovZL+ilN6lUSFMweM
X-Gm-Gg: AZFdTZd8xDjfSQZqNB60sfGYM0JfqbNmRfUieoRo++Uuehi+hxUGlj+isIKf5vaiWBE
	rqfd8AJyeg8/BDki0CfRy7WCvjjlkhoLTMZZfwFMh1UMKpG+/1l5Aej+BQ+IWWrZmaAYs1UqSg1
	Z4J3blq8jukqjN13RWwAqDyxXmuhXY639JPRweXsuh4Rzm+5hjTL/i3CId9mTeyQx1Y3X+0k05p
	qUHDYF1sm7vt53jzotpQWfa5lewj5sv7+pGqSSLl0p2ZfOO7sQ3NZ3mqeGoioWjSVsJIltYad7+
	RZcJIs9rNGzxyP/DzBj/g+P+Abiu7HHLYCFQEyXQEEBa1TbWUMaO6fysJCH6ApJxAm5UyB2Fuzd
	/yYGYxAS3aXZstg/xINnZnKGYZrs+1K3GiysCCmW0TUPnijEPSiN0C540H9IyuwqDoylHVMteBa
	enwr7pQkFwY88qIQpaWgpSE+Yvee2TQ9ZWleqvn0sAoFuHl5/KoZEEwi8PVjjaB9VmkqHSvjR1z
	xQP5wqDqXozMj+S4BUDBIDtETB46NoZ8/cKHczptl7MwYa+Le7khH1aWvGnFeuPKr85Ek30VY2/
	TNGIGnxtM50oYs0Oi2LCptx8C6lPEEHKm/Gr9w==
X-Received: by 2002:a05:600c:820d:b0:4bb:7b4d:6396 with SMTP id 5b1f17b1804b1-4bb887e21c6mr298467665e9.3.1795578231386;
        Tue, 24 Nov 2026 19:43:51 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:50 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:00 +0000
Subject: [PATCH v3 04/14] dt-bindings: usb: qcom,snps-dwc3: Add Halliday
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
Message-Id: <20261125-halliday-dts-v3-4-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1362;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=rZ5xhc0Wj0SK9I/jsxkVVRd7EbEiuk5dcQZat95a7Og=;
 b=FzPufPd+aRuNJyTsxE9xMnhrwTERQ8Vq2nvn15hQVL6HtktHPs4XaCfbTVnTG1Tm3lVHQREl1
 vEmjvIE2KTICBxf0qc9edU3Nbke7+MDNmTz+aRTaj8sSAc1QRotZJxE
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the DWC3 USB controller on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index b77c02c64d45..7a8b72d2929d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,eliza-dwc3
           - qcom,glymur-dwc3
           - qcom,glymur-dwc3-mp
+          - qcom,halliday-dwc3
           - qcom,hawi-dwc3
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
@@ -209,6 +210,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq5210-dwc3
               - qcom,ipq5424-dwc3
@@ -570,6 +572,7 @@ allOf:
           contains:
             enum:
               - qcom,eliza-dwc3
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3

-- 
2.55.0

