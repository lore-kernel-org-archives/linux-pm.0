Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184441;
	b=4lHMx9YS+hwTjRygi8sC+L8zMXsLKrLHHcYBqFah/9ebUouP6MJCFGFN0Bx3q8OxF/hk
	 hrPohW1vExX6I016Qi3559asMmMVtDGj+yAIWddFLWV71j8mqiWMk7VSlCGb8sn5+1eyP
	 mXvg/MtlpNjLQNQmfd3+6Mz0+roz5fbzECdVc9UcXiADjCDGaGTTcg4Jzw3FpQsEQxRiG
	 vu2liN1yqV5F9tPA0LH8OAetSr2QyalEnXuIBRwvnQtXrJzPBvUraieKrarVyoX1u8V2p
	 8rO3BEzdxcdR8S9bRRini4A3c2OasdjKyeBsJ0cKz0M1XYxlz/+gw0tneaOHaoFBXvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
	b=TjShdLPzvwq16TGisZm45VZfJYwEI6C8JH/eS6dSNzYQ9LJc47iCEGK1eyGauBIU+NoU
	 bW3D7PiwyTH9j0fk9T99ikTdi8G0IbtOmy6VVSBk/9UUzMDSD1ZAGE7OKUNg/64NqzwYr
	 7RTnDLWcQ3lAzDhqQ6k+q9woCxSX22Tq1LNT7/L92PKP9ljQhQBXMPKwbOFW33cevbcro
	 TnYiBUU+a6rQpzg/DlY9xwIBiDhxHi7u1GqjSQzBTrRx/GB34Mbb+tIBPPZq9EJnVUAf7
	 JSNBLLKLfJM2LBZLfQqfrXKj5l+FXFll8cJpY+ugXj70rE0j/gyTXlpdWCWFgfQY54w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ULEuYnxb;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016F606D810
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3016F606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ULEuYnxb
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49318428d98so146011f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184439; x=1794789239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=ULEuYnxb9uEPYMVwaCZFAhBSr3XRRf7x47G6eugQCaMON9WlvKKlg8odFviJChKVQz
         L5ivnacejg1JFvAECb3CXO3G4CGlkXkRUf5nvRqM76uVba7f3AbCgFEyfN//93jXlobk
         RRpUD1wxP334PPruCEBCm7XnO4U67yem2Q++cYePF+tA6Ll3cXA7KHUYpVW7bHGXPv3W
         01KWH5s+I/rChWyEAC4I/nugfLSJhWg9sy7NvKigj0oOHHQWEH6RZ1gw31QBj3pWz3YO
         YoqU83BPVVunbYylhg8fGTfC+v6UuQYbRsQ69PfH+mnbpLdKnjMRZknNIjNiF3iaLp2o
         JADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184439; x=1794789239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=jJ6GEtiumoYpAi0+9Xq/v725jm19S93rGntmBLZ23BBLqK2JJb4vZoKY3RcXFyNxVE
         QF1q1tCXz5PAN8D9zty+okwjU4lYvZIMZhQSnxpfFjr5bpNwniLs2uxs3/NeLMOYWTOT
         P9d2jKAEvWQKibdDPUDvr8n3KpH42fxlvuDPTbcpT9lrIpSC5M7UBIhun3a/dcrfL9d6
         8Y50OgW4lmkGRd1bwAQTDxCyHaJsSoes+0B1LYs1EpK8EQtS1q1s3Lvb7NaFYiPEt1Og
         pesfncE4Ihy8n2nFtzSl7myjdE5+ozqKvpz8lJGh2n+Cyyl5T6QrdzDfHSm6GnKpXXm5
         8wOg==
X-Forwarded-Encrypted: i=1; AL+hErH5LZ+RKSPcVnZ7WMByFxptjGrJfJGMsJuh4I6zXNol5A/fzwkzvUkUOxmmq42vwGUweVInFskN+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8EzzVFjBEwtXfDHK4TSOyKsoVTZxYDFzlcX4P6UytIv/ZnIVw6
	3HOPEcOw2QTf5mDu9Y6RPfY479Ln9mnck12LVPfjM8ad4SitwnwH9XaJ
X-Gm-Gg: AYBFou26m/8Z/jFGkYCerxydZL+yLOoQyYeUnS0qgh0aNHpYUmBAHcx1mUb8YAuvWjd
	W191nZkGo+wixE6BpSo9TFFCQuK6BIYvd8I9jwpqhVwAnL3+Eh+VBylZBxIqHg7K266IMiiWylN
	5TkhXZkILz1fURMQkUhdegn66S2Csu3QCNYWitoH5lwmEZZy9vgrNCQ6IBqcXIKmcG6s+aSo60M
	uxv1jG/LUNqXgGsFLGTOsrFW2TUNOoTajeiIC+L0V8oAjjz6mLRvLrFvfvbbMTbgby38egGLdhT
	YeukvjpaEtVGcsE3ZGYpM0ysK7ZJOXDd3FyE6hFUD12fq+ubuUyOYaU6WpDjHPpl9+BFjVo4DLZ
	HpPrtbupDNgzNAG+33G8GkT9prdTgb/A5kLwWW+JsvhjQgq+t3mkRFiBJxo8vClUUeoyzUipWoR
	OdhtdZsfagY2CmzTeSw28UzSIfRW4NYo+YvXpY/CfTWYyyPMR+aa6SxldBFWMyMvRbcvIO6Y6eJ
	3ZxtAEiaxvWeBAMwFRk+omTBKMgzE5+qIB51RiNSQWlajQ01wevTQ5N2EN0kE881/qklmcAyxKm
	M1iSKOptIh9bROuzhgFpelKlmKTMFKZdFH1h5LExiRhA+6zhmVkOD30Nrx4H1g==
X-Received: by 2002:a05:6000:3c5:b0:493:2376:81b7 with SMTP id ffacd0b85a97d-49588ecc152mr4851434f8f.27.1794184439552;
        Sun, 08 Nov 2026 16:33:59 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:59 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:19 +0000
Subject: [PATCH 07/17] dt-bindings: usb: qcom,snps-dwc3: Add Halliday
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
Message-Id: <20261109-halliday-dts-v1-7-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1289;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=cCyX7eu7E67i1+mb+zFb+/V3MZ2Z8Bvs+BbDvfy8HQI=;
 b=HQwzvS1g9UbQKH8v0/XpwTYPPGyIcJ129Y8yti74NjNwgnbgo8LwZJmaOxKeuHMuvgkZ+EP/2
 IP5h1J7SLhzC0/e/TSquB9CwBZEDq02qBgUbIWpMHDatD8Y+sZaCkxU
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the DWC3 USB controller on the Qualcomm Halliday SoC.

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

