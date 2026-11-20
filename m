Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210110;
	b=IqjwNnwsFbMQIBcY7lZmdcgfa7vO/JcF4jko0x8MJHJgHTAI0dJSuMLt+S86CKo8UOrS
	 V3VtWCvHVCb7Ec1S0G2PU9oC+VsB4xx/8QyKK9z/NyhX5Klwmy3aTQRln5R3EvFXfJRXY
	 zlDki5jJBHHY3DOahhyxUY0Zs8B5dcqbk+JP1+1W2ZLVeJnQGcN8QHZrfgzP0teKlH1TS
	 4tnM45+UIzb9SPQ/RANY8MVqISXWywOHLgRzspzCKHfcQkiukiDH+eMQdNbx7FVkhA97z
	 BRs6sB6M38eT7PbnYB8gpr+Qgggds/l/9pRQr215Zgs/I2bOGmogT+SlErcH7Rl9uHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
	b=4VzUqaiUEAMzxDKowbnRI+YDhdyygLVYmu8BRybB9cOAGVvJq2XHQu8PivbgnkCff2Rt
	 X4qASA2bVyN+BNa8Uw5C8hIU0+ohknVaru4Qf/s4ge6ttYRQqYCo7QclNkoxm/5Mo3lcV
	 cUoE//hxK/27wgod1NSZIOahT9e8SLKwoNJiohs1Qc0w4C1D5Y+Rwg1mN6tF+rx7EFRKO
	 2b32PV1Hqyk8/iRe5fbcmeqe9tP84UxPHRS5qqD4a2TV4Dq/fpDuiz68u8hywjqNz6MtK
	 dOjFLWgqLOBSd+ReqRebHuXc1YxnaZu3yhY2zS8IftAbfy0CJBR7o/WaKBaBgViAkkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyhgev7m;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC127606A682
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC127606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyhgev7m
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4ad89c49e0dso493701fac.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210105; x=1795814905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
        b=nyhgev7mW5eKBV/iKX707sp3mXrsjD5epAnpVMWmVKuROT4viIW4bTgsI2iBXHsOlB
         OXVox9hCt42Kdcr2vRg/RB3gQhEBD2XdVO1ctPLQyIErv/gys/LRURfV7p0iCQb9fMYX
         mZ4PJyQp8TW/wN4BW1oyyLZhQIP8f/tt44O1FzFGaLs8CGeYhrsjye0MX0k08vAgmjYU
         Q3C9xNoaVill0AgotMzYXItP5geKFhdrfBgXbEa5Ij8DeX4i5tkiWy10lkfgqAVQjDCD
         jUyOFKFZlLk1PojRBFcAXWqIAJuSEq4u5rA/b4Pgce5tPB1BfnRbZwrCHQ9O2tsaxNvK
         ilOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210105; x=1795814905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
        b=ttSoJVtgGwI9Tjppsey+plEjMRVlUOOJvc/1QVUvZV9BrpXWvBDRBFz8bWzAlYnAbQ
         8gVCMiCmmj7WwPZ4/v4OB0xoC+ak7sqKNnieAtWTUgbV9h8ZVhnRqqhBbdvk8htCe9hG
         o1b2E6EIvE3n2jfFM/goNEKcScrrkwt3tK/tNgQtzmvFHBH3/E1dnr4/OmYvcL6w9b3W
         14qTld8XhTE2KVXuevaPECKIRYUiU1pguhyWguAun0tbiZPEsqGnko57/dINRLS5u1eY
         o+63iZd0LvvsQja73wXRwpu5vKGR5ehiJJU+95PeJToKAzATH7ZSVn52xEhOMWoJwmEG
         kZpw==
X-Forwarded-Encrypted: i=1; AL+hErH/YG34vs2ph/bagYo6ByOaAi1Zi6JhvIMEGGH5aCsfgL+HyyVLaQ2alb4jJTXRyH452SlJCL/+Yg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8U/+IGaXvV0iD/s3aMhuNZjxJWjLcr1Ku4/IPJOPMeZ83BAFIw
	D/Z32G8N0WABYFEv35fZJBiCXB8s1aaOqplyaAErGZHgLB4PeoMWIJI694944Rib
X-Gm-Gg: AYBFou1E/5yjw4Ps9RszEdjGBG0gMDGit6D/CphZaelrxJRm3iHV8vV0MDMXJNRT0bC
	0wOdw5LOSCsXz4i6qOI0stWmYCiubx+jtVjVnrmFYrf5Hd91/4j0fwZc1mm5sGxSd07YKffvm8R
	Omo6BKlPj2MGlrJijE7Xzrz5d2HgFtoQh5i5VutuMLlvta3g9EckoKvoQj/IQKOTonp5Uny9yGv
	ro6wO7Ps8MnyCwPxiZFCb6DWYiZp9C9CbAb1z6pIgGiMr6vO4WiyUxtnEdSWI8wT/i8W9V8VXfF
	qSJ4rqQHhpfhvqJBxjbzLvKSefriC4lpchNLzz92tCfFnGzvHWkefCBEM8+EFzHZZOviIVuqsW2
	FTW0IMlUUwt2Fg6uiGYaEN7ijYuLT3hdCmNF9/pL577MsDjpkh7WeQgyJkCnJhR9yDK91nD0HIK
	HK6RFZtga5iH21O6roAZQoauy7zT11t998wFqcZaNxMMPAYAddEmfnQ34Sv5t7GELnbToYCM6tZ
	4YWmPOhifAKwXl9z1/aQQVbw7mWmivrT/yQOGJIABSMpLxZCRgagu8+IKm2Xt8Q440bmEE+hyvt
	KGAwRGXgRddVxDSbnf0qxlAsWKl7Bg==
X-Received: by 2002:a05:6870:5b9a:b0:4b4:8c0f:40b6 with SMTP id 586e51a60fabf-4bc821920bcmr4451217fac.20.1795210104791;
        Fri, 20 Nov 2026 13:28:24 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d766sm3774126fac.2.2026.11.20.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:28:23 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 3/3] arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro
Date: Fri, 20 Nov 2026 15:28:15 -0600
Message-ID: <20261120212815.35663-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120212815.35663-1-macroalpha82@gmail.com>
References: <20261120212815.35663-1-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Cellwise cw2217 battery gauge to the Anbernic
Vita-Pro.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
index e66803b5399c..2203e092e8c8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
@@ -954,7 +954,26 @@ hym8563: rtc@51 {
 		wakeup-source;
 	};
 
-	/* cellwise,cw221X battery manager at 0x64 */
+	cw2217: fuel-gauge@64 {
+		compatible = "cellwise,cw2217";
+		reg = <0x64>;
+		cellwise,battery-profile = /bits/ 8 <
+			0x5a 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+			0xab 0xb5 0xae 0xc0 0xa9 0xa4 0xcf 0xaf
+			0x96 0xff 0xff 0xd7 0x9a 0x83 0x70 0x69
+			0x65 0x65 0x65 0xb8 0x81 0xd9 0xaf 0xd9
+			0xd2 0xce 0xcd 0xcb 0xca 0xc7 0xc8 0xc5
+			0xc2 0xba 0xa8 0x96 0x8a 0x85 0x7d 0x7a
+			0x7f 0x88 0x92 0x93 0x94 0xd3 0xff 0x5f
+			0x20 0x00 0xab 0x10 0x00 0x91 0x68 0x00
+			0x00 0x00 0x64 0x3c 0xa0 0x89 0x00 0x00
+			0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xb2
+		>;
+		monitored-battery = <&battery>;
+		power-supplies = <&sgm41542>;
+		shunt-resistor-micro-ohms = <2000>;
+		status = "okay";
+	};
 };
 
 &mipidcphy {
-- 
2.53.0

