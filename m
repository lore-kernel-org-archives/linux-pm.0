Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184447;
	b=z4U8w7QOFfIOJNh6LS8badn1Gvke7tZndfxmSYAz+6dZJSBpjizFiUYN8NBmwV7NqsPl
	 jtr3B+cgGubB9dM7Bxw/iHulGlPAplE0i0LxIFaLqRzZIuuaojBOPNKjnJeZUksDjPFVK
	 2UM/WpPgu6YKgzQZYnz0dsgTGzTg3Mbh+Xz2DfiYFCcxwrbErb4ZCaI5ID7OEf0WEEAWN
	 i/2z4XYJkF5JSZZDnKUCyP98W34/GMbrzUse8lpzhbtrpq23Z3nk8iAeSaLaP1UL3OkZw
	 Z4o9LAELy5hDfp4OMsf3rTRZBVpYcU4RQBTrYrMK23iZ2q1eX6FQLRe18L1jPmz3RNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
	b=nv4mmdrn+x9EJvOcRIMOi+vV9nacmEaJx/YJTCXmfDaUhOMctcsKFWbYFoQOCzzvqart
	 2xUb0xU34Ola7CaEe9XnOtkudNqMy/5A5RngfSdFJPgj8ygfdeSgBK/+mM+Or789l7As4
	 CoNYs81Wtl7uhiikMUiPlxbWmZkB9WuOVT6P6NWW/jUWpCmF1YIENd5neCt+ENtwiDbLc
	 PeDkpZL09DEQ/Ghu7QCgIq2GuY0TsDjdOrl55CYQljuP8vFM/6CNj2VByoJpbqVas16wu
	 HQTQAf5PGLTeOmKCsUCC8oUNCTWziZQA+ZLwC3m8+Gqe2gEVaGswkdhGNqTgr6r+H2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qSlqzKjX;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568C606A337
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4568C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qSlqzKjX
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so2506085e9.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184446; x=1794789246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
        b=qSlqzKjX/7sPDCZRvmng2Fd7M44NFkTn1QnTKlon15ILFRt36QNjsrqLJYYai8FaJT
         xqdBUzCmut3CjikZFdWRXcM18asXALumcNCoDZ8wkDUy/vLNU2Yu18uXCs9ENs9OPJGu
         nTOZcCyszK4wAzAPo3RgIbwzygxedCHuazWjHdx+F6NUU18zcCBMt/igNH+VXF7b6oYH
         qlTinMkSbUjNgaZL5pqDSb6HsOSqrLuMpY53PyfJXRmWyJcmK2xZiyNp6qhlx0aMWWyk
         XD5wvPWvs0D8+P9xSygLy6qITW/i8jKmud5s6HzgGS2nR4vlHSyW1pd61/CmzpTA+ZFX
         bwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184446; x=1794789246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
        b=XY05F2MkEK8vSGpL7XAOcQSDYATTQrbxnHRncJqCo/RkoBc+4DBvS35Jvk5nzwN8bJ
         XpGrs8KQFAbdGOfDtxxUFW2K1EkcTUCZTzpY2sTPFa4yb3LhsDCqaTQdyNlLp+MhoJ3Y
         qNmJkg3UMa/NCJQhHvWfCKPmLj+ol0y+wtWtdd8jVqZnp37PT3AlIH96u3EzODPbe8wl
         gI34NOrz2z2/F1TrFmj9GCOX7ydkwt31UicG9sSRus1kO2BSkANRb8l/x2UIANZXOb3h
         2RHy8CsJjratDZ3u1I5IeyFKrNvNg7E9PSoSjLlsCcZ4JF/t8ua7lf+LDjxfdQ50ReRI
         wlhQ==
X-Forwarded-Encrypted: i=1; AL+hErFxn0Kqbc6BBgZsMFIddGMaL52t1Eh87oMNNwuF39EmhSbzVVzEuFRY9+kxzVaCsRmhjaYz4cMdzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8BTuq+rDa1EmauRL7WkMz/mq47L3FTZbwmQWwyi1GO7U5Ye2ew
	tcgAtgZE8/oN6aeIQ2msAGaNG0PuopKVr0c/QyXo+ZI1QTMVskxtDuhS
X-Gm-Gg: AYBFou2q6Y8gQTIw/m1uLV3+p0LR2n79o1JQjgt5DGtBMFv/QttdsA3/50hzm7WSeUg
	TkUosWCjDa8GvApTRhqbBYG86wLvBW3Sb0lVwgzKw5uOCyS0cr0rZEZ9DupPujM7dItcNAfcY11
	tUETwf1GX4gAGlm+1vJFvCoH+bpMo7bSbYhw4DKL+d7ztRm9s2Mx7WmsJ8jxj955GD5vFD29EHu
	2lrzkG1WUF715QiKZgWUWqBQmjDeJmi5io9QCsDbzT//VQi7fY0ih8ryhusadK5SHTKFZIbAFW9
	TCHj9xkGX9YLJ+4oF0cU4HGxP3mB8ZSH8am+Rj6+KE/Wxf8atRhQa+1q6abIwgD7/LdLFtzW1tv
	BsPOckF1wFbAK9E+R3sEMMGZtfa74K+MLpKKUDuUt6fDhKPbuGxPTG8vqugnBlKGCkS6wAm24Ui
	Kdm1FHMyiZuptiPU7dhl+R6ggxQU8xy3+PVyuLL9IZ9xNSfmWd3SExTWxsalA0xr+8BF2cSfsNU
	HreOrY+sS8L9stD2YjimZGAIHChdVx21dIZ7WitOPVUy8Bnqsu9R7ikF+FP8FrN/26bk/aM5FVG
	V5fBhn6vNtTomT1MNKHo5kNMkCWh4OURT0E49Pwr
X-Received: by 2002:a05:600c:a010:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4b963ca3a7cmr51069905e9.35.1794184445733;
        Sun, 08 Nov 2026 16:34:05 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:04 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:20 +0000
Subject: [PATCH 08/17] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
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
Message-Id: <20261109-halliday-dts-v1-8-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=891;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=iomST/Qr961He4Ne7crBcxin7EtHuKLr8auNEsY1c6w=;
 b=4DxRuDlo3Sv6o3VM377FCKNLzrNNMHf6FsM5TYa93t66FIlBhCp/mgcC4QeOncc3ZgmuRzx3Y
 hjxDAxOeJv2BA5u50QEvvg0b3XgcZ1hYXm30qFoJ+yx+NwOICn4vuuC
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

