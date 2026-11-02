Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597637;
	b=4bVeSeSgh31b7+vPVYlOBQ3diO5+HFKGZOSeGh2u+jiGOBLkhS6eDeBTQfE04Y5bSmyd
	 67WLNlVf9rIPPHVbMzBKHHJH7G/CXQYuYm8lZoXZodbjAmGYWZZHKrpgN1mdzqhcIhkpj
	 ilCmYFCMLs5A7eJ1LraCNJ1AO08dtnjU06Tr2NsOB96w++eMd64S+Sp22VR+DNSwrlqJF
	 mNbCOQ916CS3ZCvVsH3FFlK8EqFCnILWjPu4u+5a01UQD0n843U6rwIz5KufzCbIbWeJS
	 fzdyKOvGOJEoEOexYcJzw+mnUUAY/cdWWd52SsPl4rjwSu0b2KqFLjwG2NRjmNzPBmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=fzpgC5Iq6UmNwAV/YxFMKMcnuTBJ158cMfcPvMXN/0k=;
	b=05VE3dgQV1OQrL45c1uwEZj0FmQtGYqgwsyqdTfzKRVeNlDVBcSeItq6CLycEKBy4J4O
	 NOawvaQvSaFfANlkXrMvxAtRG+rjT+tyVPsaPHlajDbVlWfk7M57F6NA0gHL74b1xLWPB
	 csWy7uyjg2Q0WnhQ8JmBWPoF064zCT/GWitIuEv4fonw1HEuYx+2pPqV3+PySnFZIkZpF
	 GiLuuYHawodHxlVZ/+Gz2IqsuaiqgKs5tWEsOG0rH2heimmKaLZ6ha317k5pAXY1Z6Erg
	 9Eewt5CTswbc9JEw00o9vesxA4LYoCS0dWaIMe8b2RpgW8lGV2/+RhzIEwMwHeNVNVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAuHaW0v;
	arc=none smtp.remote-ip=74.125.231.139
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C03606A330
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 05:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C03606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAuHaW0v
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-853d57a81easo517414a34.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 21:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793597636; x=1794202436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzpgC5Iq6UmNwAV/YxFMKMcnuTBJ158cMfcPvMXN/0k=;
        b=sAuHaW0vR6UMGmh9a3LoCfGHR5y2OPt9lNXxAGnagx7UZvkrXmXTFynCOsmmiHLGYq
         GYb9meKDxStFKyJb74iFcxP/aWQQCOg8G3LExXifnWFM3E/7n9VPHXqAtKYCY0i4RTSo
         22nw5djiSJ1MSjDKZG41Dk+Id1piCjeh5PFA135IQ6F6qTtWyzC3gwiU6q1Xoz3lSt5D
         v8ajt5atmPCUw4A+AbfXmQKrMDoTBEdGnXHwCuDXrWT5DHYtckAIPRnRJwyCIks/8rFA
         GC/p9TNJD92kO5t7NKQeiHniFUwdDXG8NsBaLsAGXPTejpHsGwwSDNZ5htqRqyQTNear
         R54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597636; x=1794202436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzpgC5Iq6UmNwAV/YxFMKMcnuTBJ158cMfcPvMXN/0k=;
        b=tSsb91R3TyRR6qBUILMYd2KSG+RTcYOz56R+zcttC1nm2ncbL1LowEzCEBg9TMb2iL
         Sds2vQedad9jRZNhEoTQrgKaFrHrvNq383fM0EUVuD2Jm9TAtpt/3ljuxkLcM/xhfa5D
         NEd6HK90shckOjUwcSGsgtKUu6dybKr+/iKm9SlixyfOT6VP+laNCewG8Y0fGao134Ly
         S5JgftUMs3FUZhEZfuF94KX8MiY/lbR4eBsgeriGtKEGPnCBcMuxVEu3zauSrRwCQYhw
         rDqIld2/OAoJuYQSv+78xvg4LtmISbXL8SMMl7wA/9A0Xf3F7y6PTrCOLyuURrDGmmCo
         YBtA==
X-Gm-Message-State: AFq9FYLvW92rDVRFp3F2p/q4VFuAmm/MIQKn8VjheKmW7symhILwv8FD
	2oF3t9TMnAhO5ieYLRjxc6Zc5EI5klqq+FBKwrQwwfNdMh1xjZ+SHHk6
X-Gm-Gg: AYBFou10mgZSzsd6/kPwMxe/6c+c94FWEI2Z5EBWWhH3/rOzS4NiVLTT7CEdI1U1MZP
	3kEDhm6/NU2TdUV+hZXDefElCUxyhUjaaAVfpqKmluiYN6UtN49a5s1QZyGnXLVrEUdfL1Chfnc
	FK/a74XlEWzXFoxzFhmwoh5oWlNKAv//y6wpGfuf3vRwYNbFGJlIOtP4DqyZxPXF14x+HTNEKII
	2fW0vkCVr0MildAmktkuWerLuOLsEgw3ZUSgADDnwn/kANdyuS+eJSMY7G5KjmkmfurYWd93XgE
	TUcngSbHDmTzaoNEaplkITR8/o6gxajuftBJLN7YDBmsB0WHoAwci5sgCcyUzG4oNxoNjuQpYnS
	OknbHWWAVTtOnJqHRp5Ws+RWJR2BmTanUQRN4CM4YZ6z8Z3MMLHVedBStD2Y6QjKeHO03EkfeGf
	oDYeTkLHV4RJtloUoR8oqoh0MY9dLfwKr5TrjReRNKC6EyliKlLpDMTLdDC/U94M9PZiagQTzYu
	ombltgwqF3vQqOJ66OXrLGOEdBqYFku4ycR6u4X5RyYBwhZ4Wzdesj5tfy8OlrDuoXRLwNjsMVW
	YXzArh+9aVPONlpdnpmDJvKO
X-Received: by 2002:a05:6820:1343:b0:70e:3e8e:efdf with SMTP id 006d021491bc7-714f2ae369bmr4807837eaf.89.1793597635764;
        Sun, 01 Nov 2026 21:33:55 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm8321164eaf.1.2026.11.01.21.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:33:54 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 01 Nov 2026 23:33:46 -0600
Subject: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's
 32 kHz output
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
Message-Id: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793597629; l=1164;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=GgCulyiRe8JqnSbuYJBNp+S895kQy071XDUKSDOt2BQ=;
 b=UE2preFnWrcfBUGQB9fs2ZLD6a5Iic6l7jXV2HPJqVzl40mf4eCBFIpiaxRBYwOVNNpkVcGzQ
 NP955JBBzvAD5zz3cEjRiUa5q86u2PzDOoj38Yx6ZzP9oKolUFV8h/8
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
is off unless something turns it on.

Let the RTC node provide it as a clock.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 055625362951..3bfe1ad60d2d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -84,6 +84,11 @@ properties:
 
       start-year: true
 
+      "#clock-cells":
+        description:
+          The 32 kHz clock the RTC drives out to other chips.
+        const: 0
+
       nvmem-layout:
         $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
         description:
@@ -694,5 +699,6 @@ examples:
 
         rtc {
             compatible = "mediatek,mt6397-rtc";
+            #clock-cells = <0>;
         };
     };

-- 
2.55.0

