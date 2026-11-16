Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864436;
	b=JgESCgg6Vf45ZSNepdOBIArTlzcaS9BfGx6wA2IsloqVDZQC1Gjti943AzsIz7y+qID/
	 KePKi7sK2Hn3jqlxs4w/2aHN1Pj2b8sy5YBgNtE9xMVFS5nQ3L4K9Lciyd+jWJV9U5pmu
	 3JB1OA1eiOQhXL+URNJQIPOoinbwXdkfRCfpisiNhVqr8NQVGeqVklcyY8T9T/onhlvuP
	 HPSbz1bIOykW84J87SoJZh+EjUtPHlrct45Ug5qCDWoHb+m/oODyLaC+26OWswSJkapT/
	 B+2sJogcy6UPQ7wpvVVoGD21106floy6Y4R3/gpOS984qw4Bhu8sQoOyADMsQjmLOWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
	b=T/T/C3SpqJYvZiv+DYgXDMLnPHKcBrOdoBvWu3AThT6bYPv7DL091MvdbeAaZGGSc3mb
	 g0qU6Z6llLcZMsX29Qfx5rj7L3cqpkxaOZMz2dqv3wnZ+zCDkEhr6H0L8+Ev20by3w9jJ
	 rNWEhRT6Qf+vClK/qRuGiBab1zvTgEYl6HONuCQB4ulC7JSmrYTWaEIBVjjC3/UcQRlA5
	 +fdnIOHU/LwFZRNUQiN0q6h1z9qx7ffBM8150S1omPka1/rWaAtnA3/MxC2rsMYUn9Ki5
	 WBWp8fz/yUPjohhKcqBqXxxkPtdY2AnArTK2jHmPGbhOty1cx0L96XUkrOVsssAT4pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P16DvILv;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F47606A322
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F47606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P16DvILv
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1997447f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864433; x=1795469233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
        b=P16DvILvAkJjX6pET/OY1y6yCbL6KHNvFmQ8Vc5ms2Nh4pBtOsH5swOYSMdfoItM4b
         t5MUV5RS8EsfFWLaJSSS5E70h3/UCARtpvqtPXICi2MnbVDPa95XtCUmcFtAYjMi3iD9
         sCZvL8DZRUZv/G7eI4SHBKPuYPPoNAExEKI30EQbOIauyxIQR0kIV/+D532rj4kB4ZjR
         LbaVAAYCUUzAIoRJt6nlQejAo2Qj82puHxbZwDW1Fa8tRWYcjQNNMrBV4t0c64r9Bq5k
         XxoBse3bOdVc5KRCAVJVYP/0nrxUtbAZayRyyja7hKGad0rPdK7UrkQNvPW9f3BimHA9
         xUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864433; x=1795469233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
        b=MwETAZgIsj4bC07QrpxYyo5A8HYFRQm+izP1RncvYXbxb/+s74uUBGcSQsFf8MoNFQ
         eJD/GH5wbb0Nx9v57BFnh/YZL9RmkK9Am/pXx8YUV50Ro4wnkuN/V39gj949wBeuBX6k
         +DdM4fdgrgIX4XSPneYblUhCR+YbTgQXMFLba2dBqwD3mmABAFM8jqyTxWHbYZs0wfs1
         GtSVLKsokYDIYJIjxjselBCwd2Pksk3C54VCFZX4jfjycAU6SuOTK7nQ6Rzj4pUCj/ao
         KYRFlZjGGtQQUs5wjmwQ2kMOOKrryej9ajsJkKseV1Yo0z2wMUod35RLDgbneR0rzMry
         7QKQ==
X-Forwarded-Encrypted: i=1; AL+hErGMK6SmDIFAJaGGAoCxY/lVKYi5B0AqGr7KjDFK1qslf0uLQFfzyqCbALgr1c6GhQ4wpi35IiJbvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xxuzmNASgQmE0JEGQ+i2JSH4u1HeMlegPg6kXA1DrvBypk1rq
	aoVb+BfbbvWgXMcYwyeXt0YO2ww6y0IZIOMDPHD++qv53KcmbU1kwsBkax8GS9Xho+25tQ==
X-Gm-Gg: AZFdTZfnFUkKrRobJr1qZAZTaphC0mcOVBzNS/joYsGftjSjpD2wOPIx8k9P7RRer19
	9bnfpckFrZp06WIs/LaV89QQgqBmiDLi3/wIlgPGerirtoMFmwD6sdguypFrO7ibKQPcDsJiDZV
	ZWsBSnF9PisdUA9oKPql1Ku5USHMGoaHkZfwMHfkQaHo/H4049TDaMnAVuX6WOX6Y/YY4Oq2ccg
	BqUY6oZIIpRLAO1trPgR/1cmECbFXLtW54yTgi7ky4dme5NbaPTD7R54URSyWaVLOXUe/OTM1Ol
	/prxefONo7bum0OVslWaUb+vcNxVgEfb9j3T4Ooy6bWKvWboKAcQQ3+b4QJtUwtxb6YNtBRiHlR
	H4fwC9v6JWaqLDPNdFuxsLrlhcoEYhpFNGi/X+sUC8TAafqzo7/470dYcyFoMrd0lfFKBTk3m7W
	31ji6z0DKxse2XWaAxcbtOfKSWPXEpCt21LJj+1fkFM+4GXgp2IYVKxVxQqc7aAN2T5M1bSJ3m4
	OkmpQ+00T80QjOZpmQxV2Vs8lNP0MY7C2JCE37eQ+fvRbNFq+q9K/HJp8I6YBq0fTxyNan/xYqt
	10fdD8JLirZ9q4j1LQfCOCsy2jqO5p1UR8YRVbFO
X-Received: by 2002:a05:6000:610:b0:495:5c83:51b9 with SMTP id ffacd0b85a97d-49c7467a893mr27328310f8f.50.1794864433590;
        Mon, 16 Nov 2026 13:27:13 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:13 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:22 +0000
Subject: [PATCH v2 06/16] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 Halliday HS PHY
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
Message-Id: <20261116-halliday-dts-v2-6-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=891;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=iomST/Qr961He4Ne7crBcxin7EtHuKLr8auNEsY1c6w=;
 b=XlBnHuuXKSsmwBoy79zd7CM/aQS0V4vz73O5I/ykrhOgY3nFJG4rnY0qnm4zfFTA5sK35VFT6
 GeLVT3WztE2DdDA/hh0iSPFr/rHt5tVJ5B9S1do1YbNU2FqHh/CJpdT
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Synopsys femto USB high-speed PHY on the Qualcomm Halliday
SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 661759b25064..8ff1db4a1d79 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -22,6 +22,7 @@ properties:
           - const: qcom,usb-snps-hs-5nm-phy
       - items:
           - enum:
+              - qcom,halliday-usb-hs-phy
               - qcom,qcs8300-usb-hs-phy
               - qcom,qdu1000-usb-hs-phy
               - qcom,sc7280-usb-hs-phy

-- 
2.55.0

