Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC047CA76
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216117; cv=none; b=hJJ953zI8OdoozVnLSq5uj8ZP2uxETztnUT9OhlGT7HZHnawYnyWAneXVUWWRzwDEf1SmV7sAo6x9iM2DawBv8aDd6ERqEs9J/L5SuN/3b0qMoLdb73S9YeaqlDXo4oHIIZPHaD3nfqsS8p1Whko8e9IO396iRae9vIVwXh/atI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216117; c=relaxed/simple;
	bh=yUyedlztWXbA3lwvxrO/styw1IzAPB86ioonRT5zCKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eW1vylMhIW+2pnsokOhwWClVZbKc3q9Qnx/JURI5ecBgba1dhEmg9oyjd4/vlfnXT0DeuuY2w9lw4jJFmK9LnuGsJTcSG8A0kdUwbWPwb4PlM7wjWHs5FUe3723fio7JLRvrbE/ifEL/80SuCBX/WCXTYsR5quGutR+lKBgPo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQMGHtNX; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQMGHtNX"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b355ffso243413b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789216114; x=1789820914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NujR5wP2r0gRxOSsqzPbYYRli2E0gkVnbRP1/4DKQ0s=;
        b=FQMGHtNXnLSv3hx05ZffmV9mTCQwmOmkig6m+l4oAeJJIyusqLx6maD60McHA53IG4
         CohFJbO11R593vSPuqvVtGgMDf3U5sjV2ZH6FeSihHI99PXnltnrUZZGBUWpoayo4XhZ
         8x1HLTsiuskSsls5XWpQ9F+1s6lioJnZRA4FBy5bjwKUi/cHnyqMOelT+CPIctt5K2ZX
         Zvub1Rox9JK8pmnKpIYhd9lRD1+LtCzIl04rAYW/vRt0c/dBp95fe0T5g3VVAuSBGDgv
         yyZEg9QScLZcxDMF90TZIQG34imUmf5DEtIy6L2dI5Nl7gR0Pbzgoiherc8KKVElmZTG
         asHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789216114; x=1789820914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NujR5wP2r0gRxOSsqzPbYYRli2E0gkVnbRP1/4DKQ0s=;
        b=JKlMyB3U040LuKhbxOa/wn+csWxHcAyzN9EkpnO8TitODg6QzdF/VTBdcxrqoiSNvh
         QC1Mp/I7gs4QZFCHroaQA+tm5pIU+TcxyJECJ+nmaTj9i2iBW1N8k4tMSHCLbXsaSbE6
         Dhzwx+0fn1lOqt1ZMV0aByLgIARWXgB3jVj2ujtGj+SxAxeG0CTvQ/EE9CcHM/2PK7Dp
         0JzRnp3WQPV+BK3EzqxPOSfZoPV389/vS8TgglyYHfD932Dk5m0ViMhHJg6ZldKVtNHm
         l1yHAygbdu9UsSMZ1MJIdDLP+iAKhCoE7FLkkMpan3kA4f7vWwPi7v3FzLYAOC5Zpggm
         HfQQ==
X-Gm-Message-State: AFuF++kBgYTtwft/RWnezeT+WnWdcU6ZeKsT/tx4VorfBDph1N68hZMG
	iaoR0qbvvF1uCytTV7SA/hDe7Kn8VmzODiLzZbx/tYInyA0VESbCdSTI
X-Gm-Gg: AYBFou1c8Tf3EJJHRfrQpo3nt44DELvCXZUYHIRoj1tgjW4/3aPfQdSo3+3eQK9L771
	17jQRvjyE2Y97V5pxqv5L1owQhhpMnctgMebxHlvMrvfbENZjKrP9Jw6CPNMkuIFQ0Er/223Mee
	7nY28OJzIEdJhggxDor9i8UAScNokLUr86K0mFfhPZB94Rk1ZXxpG8K1bvCXjV4gLmKp0NVV3Yw
	98gV1vXKXUl/o8WRLk9zOU82iUpzIof3VCbOXW95CEjG0+Qli+Z1CYoeGDuH0gIr8XA3sQUCQPA
	VMZZGDoQLwosjm8sFpYC5eFvNpH7ONknjKAN91V6XKHD02QGSqJafw5RD/E1lNT8Pxjvjoq3eZ4
	Tygd9QJlzcJWeKYBuBIjvC3Vx+i5qHYFuLJTq5b1zFOweS1OZokkCo8NwLowP5YUXJsjUdg8Q12
	QUD82/owLurgHDBy+BTYQpgri0uYPqU0lFpWtJwLM/QKh6RsGTqkgxdFJpSjZHQas=
X-Received: by 2002:a05:6300:6684:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3db0e1f7d7bmr4991615637.16.1789216114472;
        Sat, 12 Sep 2026 05:28:34 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701d:4e35:aab7:8c01:68f1:4912])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65b1a63sm2512427a12.31.2026.09.12.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 05:28:33 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 12 Sep 2026 12:27:34 +0000
Subject: [PATCH 2/2] arm64: dts: qcom: msm8917-xiaomi-riva: Enable USB
 support (peripheral mode)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-riva-usb-v1-2-0acd5cf8c62a@gmail.com>
References: <20260912-riva-usb-v1-0-0acd5cf8c62a@gmail.com>
In-Reply-To: <20260912-riva-usb-v1-0-0acd5cf8c62a@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

Enable USB node and PHY. Since VBUS is wired to the charger IC, also
set extcon of the USB node to inform the USB driver of cable events
emitted by the charger driver.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
index 7c323214a..c47aad978 100644
--- a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
+++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
@@ -69,7 +69,7 @@ power-monitor@55 {
 		monitored-battery = <&battery>;
 	};
 
-	charger@6b {
+	bq25601_charger: charger@6b {
 		compatible = "ti,bq25601";
 		reg = <0x6b>;
 		interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
@@ -89,3 +89,18 @@ bq25601_int_default: bq25601-int-default-state {
 		bias-pull-up;
 	};
 };
+
+&usb {
+	dr_mode = "peripheral";
+	extcon = <&bq25601_charger>;
+
+	status = "okay";
+};
+
+&usb_hs_phy {
+	vdd-supply = <&pm8937_l2>;
+	vdda1p8-supply = <&pm8937_l7>;
+	vdda3p3-supply = <&pm8937_l13>;
+
+	status = "okay";
+};

-- 
2.55.0

