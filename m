Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398643;
	b=V4p8VFO1M2K3g5MEZlT29sg8xuNNi/fnHZfc/A6I4G2JIeQJnOA2iesniUZuIDE+F8sI
	 a1pZH7pMNiqe987wLufCLQFw9kFtfBJJv1Z2P0nP95Bk029cM//ROo+LsI2RCXbVTql9T
	 cnevjLYsKN4mirARqBH1EzpBbeTWnEGnh2Itj78xTrOZIcWl2Tkbgeyb6glqNMA1V1Dwf
	 HeaK/jmOIwvj7IMSWaGmpaQVM1TCRdYyIO71JpB647Gv8Rzpncjwfi9eRYkloLFg3G8n+
	 TEoVUAcsaV9JRkpA85OvIhva5JswVQjFpX1DwQdqAjCyL4sCEVVUsJ55ka0kx3BrBJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
	b=kHNfFDFmaVDAy7+wE9eLD3EI5d6qnyRVgJAKXkmiSZZ9/mlqthxO5FixSd8rzwQ5FeoN
	 yGSwDYB5w9C62f99vmrtsSj0MaymRGOXXnZZa8eogZvl9+p4SzMXHrdgygBSEiK7DSC3k
	 RYSfMWqk4gGCHvJgs5gTT9uCo3IIuqKTkX90mc8sCXA4pGx26fm1c6jM7V9+qr44A9Oh/
	 0UKvdVRhFTPr4Wv/25LLB2HPUrPOOukodLPsw1ZXkCq9nEKxHkLJmVsroaf3aydYl+m7J
	 /mE1Kiy2oWJGwEgzvY7l5/xC6f5ISYW2N7X2jcodIeYGZ2OPr/XKaUkUTPuVQWcUQHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BnmEjv4F;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D32606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 01:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D32606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BnmEjv4F
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46556b9e02cso2177662fac.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 17:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795398641; x=1796003441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
        b=BnmEjv4F9phMdjsssxMAHoJOKTucq2jeBrTuFvujQ5JHJCNZT/NcJlxU2YAdmvrbA4
         t7qhlNCoTejLZq5+il4P0PREQ2s8wzIsGuHzBMIwG+viIc2lqG2rZEvKSFHJOjrFS4Aq
         QOkQqDJeqM8HFmDVtHBSr00xUe97ZjOwNW78icwsXmRtHgg32Z1Hshui9OiONTgWHXH4
         f2Er0Wr0ZP67H8zqMQPwellI5WFPuhCVAiniU5CPz8XxlQ0Dtsfd4JMxlOCGYBySe0vp
         9wTxzclgRhKk3FqCCRCKb3B7tQA22tgPGeF0agLf4SvcWC17I7kUXf7gh03DIMBAtCax
         eaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795398641; x=1796003441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
        b=XPzb5imi/zLi5IHw9Cqb4OVaO9LT+jip5/PCTQCNr964DMvwE4QOQPSE4Rw2PAOLi2
         99s2R5l6kwjet6RUiq8B5n7ki7k4e+VN815ETQ13k5dk8Xnk25gEb1ygrxioVJ/RpB6k
         AYKbuc4VsrLjhGC5mPq85fY4MHhtKbN0+SeVRbd1dAzwCQYTmseYKp4zbrQ/YcVm54hk
         6XIJI1vJ+sOcU6iKpLij/Ja7b2MVlTtKe8kFHjCt5VvV3M7IzxqB+IJw+T5aiQ8TEYLx
         TZ1TdahpLhjWQj0OxDOAPsUqtSndQ22wY55+QXmwZgxzpgWbLjI2edgQPUsQSFWbWeM0
         jdfA==
X-Forwarded-Encrypted: i=1; AL+hErH0hRW7i+7s9uMZq656apcD0Mov03jnRn4lijcZEIBVHbdKMWE7N4R2XHRORNzxMPYoj7Z1rZpXkA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8fFUD4+Fwsim9WsoxVDjLV96ejktIIfxuEcCRIXDvMhGHKj+nY
	fVsUBBgoZORhFXdo662CQRhdmrEUVV9QTEKnvgF7Fv5OJ7Db6FP43cqA
X-Gm-Gg: AZFdTZdj08zVVvEGzQ7l9FndcRiGfabLk1ExP4lIf2HV0aGZ217kf8N8dir3K7bu3/l
	OfcXvtaiXkNFcETxBxqXtJuH/gnNRVjBTKXTU6v4DEbv6zI6rTZXenQNsoCkt4IOYHoniTQWW1Q
	kAB4/us2WwJE3Yo8cRdLpQalx+ptx4OmuxiOKMOShAnAJKkkgeURse4syF1Yqw1GLNjsiJfGlj8
	F1nMUCq+wVgppj8ATm2rU3n2t3CQZLa3iWqZ5oW5gkbQ4IuV+9nkPd6xm4LVLYef7HQpyHjrvlZ
	QNsniz9naifgGClQvWPTaV586TkskNJnkSBE7o5BuZ+1VIb62Gb95KHwxufplloAfP7o6D4/QTV
	4+bqeSuThoDi+E9xO0D1C8irg/ZmcDjzBjxw1xxz8FNJV8uGLIX9ztMmmXbb8Jp5qaZAERb/cOo
	kssolUvTG24Buu7odCK8LyOpmWgFdQzrbGJD7LfIoa/LY7mgdqsxmZEqKd4sjDGwVJX4/OteTFy
	rO5kOeUI7LtYjtTZD42VDKCugHvqH+wPM+gwtMGq9gQ+WZrFN3ymw1NGkMuGi3RjLBLyYd5KKDx
	kl1ZqUa5DSTu5malleUW+lPbKv/lCg==
X-Received: by 2002:a05:6870:b0f6:b0:48f:e0f6:bfee with SMTP id 586e51a60fabf-4bc852ff281mr6943652fac.26.1795398641649;
        Sun, 22 Nov 2026 17:50:41 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm9209484fac.8.2026.11.22.17.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:50:41 -0800 (PST)
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
Subject: [PATCH V3 3/3] arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro
Date: Sun, 22 Nov 2026 19:50:35 -0600
Message-ID: <20261123015035.369192-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123015035.369192-1-macroalpha82@gmail.com>
References: <20261123015035.369192-1-macroalpha82@gmail.com>
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

