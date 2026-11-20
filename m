Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202498;
	b=h1VN80wke6X9A5GL426kDSeydYF/n7V24QnvWaUA5rMje1+jpJAwxPO2MWuqh0yBaYgj
	 uiCzUq9SI/lqgAyMbf1bJW4rCgOHc/QrUJyW+X87odMbU+y6luWsfARtlwq7VXCXqOGIf
	 39tPndZyYYLBCk+QN/UVeoL3l4en+CaK9pevKQxm7wkcfPzxXDTKdA6P8wtAAuQEdHYIK
	 JM24As1PxfsThxqg4Akkl23nAbBlUTNPUvXjHnmoE56EOUQ2fg0WBbhe8ojiVOYZY67qT
	 a+1r+dWskzWDs7RW8Se8KuTqOBgpTjruGyr3BVMFAKh4TcjrOhJESOINHv03+o37zlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bBmqP69mry+lGbki19N79NWmhaQ/6EL+J2EA0Ie++Zo=;
	b=PSIMXdsE2ATM/pij3JdCl9oaOCqeQ0UuWIrf7Bwe7ePIIAffiarxxYJmkpCywPj1bKba
	 pFpdJYg+khRX8cPLHAboReI4W6DdzyPrYUXuqc30AYylGU6iJRKhy+9pK/d/hAv0JQZQ2
	 FTBd0XJnR3tbGSv875RAFmIqFqYF3qqUS+/LLZFmda9ubZsFk0bNF4IaxKQiagGV/xALZ
	 moU8ap1iDtR7AVmkeQKMJhThkKz3N+H+FPgkLUktGlNFVhSSypMlF02tBwd3q6Qbe5IY1
	 jCLVfigl4eoNiMOuyapTUfnrNBFrNqfkeWSKWEKy+czFUDAcCPw3MOudGw1N2lt+7sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9TuiA7k;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C460A261A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A84C460A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9TuiA7k
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e09aa5264so702293f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202493; x=1795807293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBmqP69mry+lGbki19N79NWmhaQ/6EL+J2EA0Ie++Zo=;
        b=b9TuiA7kL/LWUVNnDt4r8uL8hJ3c1kZtprGU75ftxO4VFgjHwqdIP3sM95mLfRyVzM
         VSNBfVz9+1bF9vYdgh6ZC/pq2M1PduUtbMk0PomXQbSijh9AzHr6lZIpMnKteJiV5hDt
         m0aVNH1Sf3PlxSNqCoz4ROJxI9srGp0a1jlKPDCgpF8kiD+77I8FbWcCpf6NLiNC6YVH
         UCA16OBlZufkgy3PQam7zJeCt27VFmC2/jraCJl1zSEDG3+Uk/xAPeiA4Hb2bnEDvIu7
         itF4HwSsfGPiJFeoaQOaKOT++/yALBRh3NY299IJYU1+89F9j3EmDeRv9zeiARp8/iC2
         Ww4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202493; x=1795807293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBmqP69mry+lGbki19N79NWmhaQ/6EL+J2EA0Ie++Zo=;
        b=Aac10/uRx2czL6eNdpfYULgoTI0pPWon5D03GdEtk0vZlcGjNR/wLGdDYKx1lnTkfQ
         FAjwA6iTnVG5bhQ/qYjbBJoWX0yXVDSOzd9giHM0+tIZ7q5rLLJL9dLeZZp4WL7oQvmx
         IVnlVecYWt2tgLoiEK/AdsHeZbVHl9XgZTVXtVzKM4PzO1RDy23R2IiMnIxL6Orc6XUh
         Gb3Q9If+v5sNDaD5K0Cymxmu19/GYabPsYJgoOCI0Q2GBR7/ZBwaRLo0tJ46QglZQEGa
         5OarCHonlBtW58q6pBK0QIfM83t3tUpfqdrMwUu+2/lzMNPqzOTOKTfN4qh/7Vfg4JfM
         6HYg==
X-Forwarded-Encrypted: i=1; AL+hErFJvY4wLisDGBAASRXrIJ9TI7M+ypg4Atwz8ATjC2ivt4V9Sl78s04W2/dm5Zb2oTbQlw4jy33+mQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/wR01TNYnGbIC1JZDXiGzNfYa5NkP9Q+oVU0hHHoJd29KXJPCz
	Gu7kDPnV1lS/veCDrFdocIqXBGiFCxE8d2Mg6NMnHMBgPOFymactpZ67
X-Gm-Gg: AZFdTZcobuoGzSePK4MSep/weDIpQOt5nWlfJArx8h7QWssYcAPd0GZVJZLa/SeVgbW
	c3BlcMDQnm/ssCkjo2hTzIi+dR+XXEWHc8/RRkYicDh8Os7CBUQsZfYCXGE2zuRbxmnOwprminm
	eYFTX2hs/+t5U+turOHAsVkQ0coy4t6buxAdOgPc+bqMxPslRt4CK3bakZpOhRRu8HS3NMRl7lo
	Jx2s9RimSqIbMafzJlJjv5ER0jAsFWsU5cyGWOEloaZXweMAwcQ/FC9+HpjT5uUsJBgD/ihWuRe
	cB3xjSLAvNBVXwzTBrglXTJLmY5nG12LSjSqroIWy7kD02CIhhGvlOdbdy8RNtiAy4soNBw7l2W
	wdVrAU/jpXAdxuzMecshhyCkPVHP78D2iXFC5hOq4v81kd6W4V1RXr1iEnpmk1fIzgQV+uU6bwy
	N++S83phNidPA0Fx6AF6XDZaZ7Jhy7BC+EHziuG+ExL+amXWx8CUESbfVY2BWMVF3hPpadueOfa
	Kv2uXkMnK36sXsn/sqLBSiAeHHY+Bha9w/+SC59omGV3QVQXh7Gh1ojkPNSyjKT45+c2k1VYghc
	NA/Z1v/exGAkK1zWHJBRXVhaUGRk6734avO0+tNVOQ==
X-Received: by 2002:a05:6000:4812:b0:491:a219:8506 with SMTP id ffacd0b85a97d-4abb55183dbmr8227192f8f.48.1795202493000;
        Fri, 20 Nov 2026 11:21:33 -0800 (PST)
Received: from [192.168.0.2] ([197.250.160.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm8405703f8f.21.2026.11.20.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:21:32 -0800 (PST)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Fri, 20 Nov 2026 22:20:54 +0300
Subject: [PATCH 5/6] ARM: dts: zte: Declare nodes to enable the board's
 dwc2 controller
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-zx29usb-v1-5-b0433258e51b@gmail.com>
References: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
In-Reply-To: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>, 
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=VM93HH2t+Y1jF4XnpLTskujk8HKKI0SNwO3Nkis00qQ=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBrAJ2XsdE4XtHXB32BoPfUssqGek5Snakxjcygb
 ymjgroPEw2JAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCawCdlxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiKGoA/+Jg//JNfc0k8TCoWlB57VTEUolY5k3Cb
 /BrSS9BX50YVGu/+HzfpBKoj+zDVoYQYMR7YMv3QDqnLEU+zqcZFaXyh476zzi72itSOU4kGTtj
 +9SgKtUdCm9bxN8rdctWmeWLqbXPrcrpQiTk2ZL61TLT0AGOki56beImFwuqbro8vkjpAV8Lr1a
 lSYW04G/FKMIVyuygKvLKGhZ+Mu/RRYRMvtFuPJ4E0XeRJ7JbwR4g0yjpiAhyybMRWetDuHwJoX
 UASgZ7aaIcGMMm7ajBQ/9Iy/r3MxVZNdRk0P4lncHRPXhQuYxo5/LA92VPadtxDJcuBppv6hBar
 aUDxcmjqvs/zZlTHMMQxcHKoqI7tdfmYUx7ziw4WSIDgmSf8myzoZq00XAGfhpf9BAP3ObuDTQg
 R0xumTXxnByaAMo9QJH8ZzLGg6xl6ZdP405AeqkNreNOCBOZxMOcTIomfdZsSo6Dg02Oqu4W+fO
 onN/KsBNwl/BPAny3WdPYb8Fp5GmIbqLvqxXfCqwfi8TveidunVclh+TDa+nb4eSQsf5tncF94t
 c7FQEK65ldHG9HnblB6KbWI42xu02XXFa88SwSd1qspzIKrbBji6lNs+6Yyp27DZLOPb9mJqVll
 NYFWkTtipcDBCYyRbXgSu5TnxIFdOcZePEEYjNqtlJEwn1S+kLzQ=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This adds the socsys syscon that provides the power control for the
controller and the dwc2 controller itself.

On all boards I have seen so far the USB connector can only operate in
peripheral mode - including one device that actually has a USB A
connector. DWC2 and the PHY can be programmed into host mode, but there
is no VBUS power supply.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 arch/arm/boot/dts/zte/zx297520v3.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/zte/zx297520v3.dtsi b/arch/arm/boot/dts/zte/zx297520v3.dtsi
index ebac3cd137df..2fc888b10006 100644
--- a/arch/arm/boot/dts/zte/zx297520v3.dtsi
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -5,6 +5,8 @@
 
 #include <dt-bindings/clock/zte,zx297520v3-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/zte,zx297520v3-topcrm.h>
+#include <dt-bindings/power/zte,zx297520v3-socsys.h>
 #include <dt-bindings/reset/zte,zx297520v3-reset.h>
 
 / {
@@ -111,6 +113,13 @@ reboot {
 			};
 		};
 
+		socsys: syscon@140000 {
+			compatible = "zte,zx297520v3-socsys", "syscon";
+			reg = <0x00140000 0x400>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		matrixcrm: clock-controller@1306000 {
 			compatible = "zte,zx297520v3-matrixcrm";
 			reg = <0x01306000 0x400>;
@@ -176,5 +185,19 @@ uart2: serial@140d000 {
 
 			status = "disabled";
 		};
+
+		usb@1500000 {
+			compatible = "snps,dwc2";
+			reg = <0x01500000 0x40000>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topcrm ZX297520V3_USB_WCLK>, <&topcrm ZX297520V3_USB_PCLK>;
+			clock-names = "otg", "utmi";
+			dr_mode = "peripheral";
+			resets = <&topcrm ZX297520V3_USB_RESET>;
+			reset-names = "dwc2";
+			power-domains = <&socsys ZX297520V3_PD_USB>;
+			phys = <&topcrm ZX297520V3_USB_PHY>;
+			phy-names = "usb2-phy";
+		};
 	};
 };

-- 
2.56.1

