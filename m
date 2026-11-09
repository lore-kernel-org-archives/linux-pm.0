Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184428;
	b=FISJmwx+KM99/ddwcekj4/5AwO7Ltufrl/1UM8uXntfYvBifk3HE3FrFj/OQlAwr5Iom
	 1KRFK9fo5rvGMhQyj50ps9cPO2oZPqYJwcvDTTfaDqBAdNVXO8QZa54I6oQTEtWhFsPLF
	 d5thPbvio59X5a82/cj/ru/kOuJACC0coooxYXNiLYbXf70BrPFK5IoyCG3XOhdybuDlV
	 ars4Zr1FeBn4ZncTheW6InK4FmUNBbncQIb8ut/P/2qs2Ol9hlItWvEXxYtmdLZPrNlq1
	 Bpoj+75Ne3fxBB6UWWZUFCsITRn8oj1hRENoy7EHUoQB6qo0Af1d8QUQTS4Pi947Oaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PkFPVfDx+55MAHBA3oCOcT0HjrgdVU03z1VGaEKFF3w=;
	b=AjdOQwoBLxz0QIjpi0I40UEjT3HALxsTPHQ4t6haBl/N792DBaGTIux2GU1pIlmH/yEL
	 uqcSana033DzIMmBggyPK52lmERhXXXhpMRa/SD11/On1FfLK3IDTg/DrNOBJWg9tw98F
	 ZgvHBBAt2z1py3QcAfnB+9ORgJzp1xlBK1cgD6otAjCYHlQJrZJYUZF+8uYBdVa4HNv4O
	 kkvFCprlmw6ObhbUATLqGY6WjuW3lkKRsDAWXUpiy8m/J5KzJwEdMjedSJawm/wiuZdr1
	 ledFjSI4IqtoMXqps0/hp3BpOuNU1Oi7IST7JrJnNw/8k4KWjJ6FH50ceq4wg7CZfjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FyDzKlyt;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE4606A33B
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACE4606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FyDzKlyt
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so3724995e9.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184426; x=1794789226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PkFPVfDx+55MAHBA3oCOcT0HjrgdVU03z1VGaEKFF3w=;
        b=FyDzKlytNlxAxLxC2gOdtwF1+dCkfYwbnWO6d6oPLIvthh1fBT5kqIqv3qhAxjwF+S
         PFR8nekUaUaUbx6CeF7ug3qsqKHwR/kTO9V1T4Gh8dASycorY7RcdrnLPeG1D5Txou55
         xgDbR4iPItBw5wvy3bOWz0Iyu/+OIfpLVhUWEPhctXpoFJ8gpgnVrNIaGCrAUOL0ZPyt
         NxOLj8n/xATQtJPIEPyzFjU842UmMjHxhCBNhBfhWuqVNq1zEGFr9t43gIXHmKQ8IbKc
         HMtuRXvOTX5bhQuwRu6FbfL0UoFdw7t7IXKyKMYwATRvVboP24aPvmrx5uB0BcbSe3Hm
         TZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184426; x=1794789226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkFPVfDx+55MAHBA3oCOcT0HjrgdVU03z1VGaEKFF3w=;
        b=TnO5NaPNrHKBXbuJT27m7DSNFwq/8rFh9MO1SF3ndUNbSV7VTnvHP7RIcTMIFJyCG5
         PzBh1XhG+j+rx1koN10Z0SxUeWnnUSEST4M5ZURlCYuOMjASWfxxAW2Cz0XNO1F4YB2h
         qGjg4bFUpfykbj5o54dstzay+vg/mvhbHg2O2vee3xxfLsLWh2FYbZbede8sYf1bd7EW
         6FhA/5MhYckAsWvEoXtpfVanKn63FUR1Ur7lXTs/byQjt1GkjkfuDBJc/jv3JcnaizBw
         WYLxszw/StmbKYSpOUua8OB/o0tKfvCqhyGQtnzBS0vvjPiisx/pCL613+LpaTpbI9uA
         jcVA==
X-Forwarded-Encrypted: i=1; AL+hErGYJEgqVsh5RA6ZVSXDlILfTlvHf5R56Z4wY+fk4HYrtxM6N7bMrxjG6G1BygqSHGsAGThpWfW8mQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LG56d1k6MKpFMN4ZNkX746hB7AeTRmQm7uVwHSedQjo18L+Yc
	GwRX6JDC/FHDLXj10T6v/3BRROnTeeIOpFzhlayAfxK7p/+KBqaXeBlW
X-Gm-Gg: AYBFou2P6jVKDuvut4WF+x15yWnSS3avPMdu4DUS6J4BlMgivWtAbV5acFCUkplRFAl
	//kmvuwg6Vofdgm4/BrdsojbOQjc/GCBXl1lnNzM6VwusK2+QUfSlSeW55R42LqxfbQKKsAlEc8
	gICXe70IMQV6ACRk24Mgv98zHgCixJrz25xwsSiO9BzOB2GOTMP/H1bQQdPZ3jB1xF4yvyln1LW
	BSDM2Vi65UJs3uBStDf7ORk0hdyWHVlHVUFOncA6egnUkGEjyvGStZDjYDsCItBzEmQe1AzQKPZ
	+WDdc2NIckA/6uprDWG7kO6I9n8PnUEfyiGpNMDVSbdKBWSgIKlBNytPyuMkxh25+hnqZcGzCE0
	nVH8q9gt6sQ4MB7X4TrPhGAw614Xz17ow+h33QFC0kIfVvCOE/pGFDXbflqxItBIEKxL6KVhsFB
	5+hD51vkml/S4LJgpJaJXMzaBzsYsLhq0L5K1CqcTlCAYKYRLyR3rELWAIAE25a0zgmvd+WHALS
	cW0tLt5yjQIUeER2Scs05lmLy+mi73PDFciWJOssVNn59r1n770O7dpYPwiVxSZ7456QjGWxNVK
	hOFSoHdwl8Z+XP2cuI6c9kLTk4tALwHfU/0IRcV5
X-Received: by 2002:a05:600c:3e88:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b963c8809emr43372595e9.35.1794184425700;
        Sun, 08 Nov 2026 16:33:45 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:45 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:16 +0000
Subject: [PATCH 04/17] dt-bindings: power: qcom,rpmpd: document the
 Halliday RPMh Power Domains
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
Message-Id: <20261109-halliday-dts-v1-4-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1003;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=el/mD1li+25cayhCgWCSoEmU7xbrdbDdv2bm0vKCgf0=;
 b=AAbKZuaWziyLaKTlH3TAQLDLLUPJbQQuUGnW2/exeZlWjcPjeJvTUQ3Mzs5Xy0Jsi923+4Jy6
 HYpQrlT+Y7QBXM0fnEs6fk3DZfReSJNsf74HPnCiwzI9V/RMLtbXEW8
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the RPMh Power Domains on the Qualcomm Halliday SoC
(SXR2250P). Its command DB has the same power domains as SM8450
(CX, EBI, GFX, LCX, LMX, MMCX, MSS, MX and MXC), so use
qcom,sm8450-rpmhpd as the fallback compatible.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 8ee1c25a7c9d..663baae9cc64 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -82,6 +82,10 @@ properties:
           - enum:
               - qcom,maili-rpmhpd
           - const: qcom,hawi-rpmhpd
+      - items:
+          - enum:
+              - qcom,halliday-rpmhpd
+          - const: qcom,sm8450-rpmhpd
 
   '#power-domain-cells':
     const: 1

-- 
2.55.0

