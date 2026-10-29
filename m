Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296595;
	b=VDKMWPYUYnT4FI1VWvVlkwqkMhyOK0Xv0rpFwrkRKikwr2iShIwXG6FH/8Z0OjCzKcSI
	 jwlzvdXCUnCCyASNesuPmX2FNItGTcvR7APBsJN+BkIqMYsuRKrZEnzK1SFeEdlN3f/1D
	 Ti8AV3QKNMaSWebKVVpIhb5Eziwgb1vFYE4sg/AH33tplNs0jVLnnw/n3IbD292cVzER5
	 hgz40m7hQQNTRg5UOQA8ilFejoEknVJP5mCE7ydgtl0c0JTHvGhz02uMwoWFNrWd6jGfZ
	 kvt4h8cKdB4u6LClmbYDUdi7DAGnDq6klLGsYpVok/pPQPOpt8Hcq3oGsKeZhNf2p+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296595;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=bCkMJ/fY+PBBJ7kqCl3N6Vr3rAKZmYSCmvGAsuu/Eac=;
	b=TE429BgjypETvOymVrFLVk46ynVKqsDVQDAT90lAVeBJMKcaWUbnQItT7r+9WacH+Y8/
	 VTYWV10tB0oQ/DdXZSasyQS+PiPbqdZBYOhkkw6Mt6zkUkx2/wBHtnTH557bLwXWRWhbL
	 aYPLiKXywPeFVqFBsu2DrUgRJu3zPqW90keSSbCXYR7UFyCBKM2ZXnN137d4lqSJXx/DE
	 HR8ao8uPOCwyDgr5isXdlhR4zC/dt+GIn4Vot0sR10q8bBJUDdjZ33nEswQxXgF3VlQJT
	 1dimdwLl0cI55B0cRLUOEFsrlfTcNGjkX8Cpb5/KsBs0hV4SbQbpW4yZYHtVSjDG+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=iSj4ePoZ;
	arc=none smtp.remote-ip=31.44.14.17
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [31.44.14.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A4606A329;
	Thu, 29 Oct 2026 17:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6A4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=iSj4ePoZ
Received: from mail-nwsmtp-smtp-production-main-38 (mail-nwsmtp-smtp-production-main-38.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4d01:0:640:e9ac:0])
	by forward501d.mail.yandex.net (postfix) with ESMTPS id 32C438150A;
	Thu, 29 Oct 2026 20:56:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38 with ESMTPSA id itnBq5Sg9Sw0-WdkOhG0A;
	Thu, 29 Oct 2026 20:56:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793296584; bh=bCkMJ/fY+PBBJ7kqCl3N6Vr3rAKZmYSCmvGAsuu/Eac=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=iSj4ePoZRC8ZB7HDIc53N2OWnFkjRoSjs1KFhk0ws5fpmIHkLpsYFQEWMZ8P/0AHv
	 7Ln528Kj+HiEYQ2kBR6ptb9ocC9d3YT+fwSKxxc5efgPFGBw0NpQ/QJHENogMgegMx
	 c5OB/lLmHcz0KuPWAAevJbIzYoaWVObp7e0VZD+o=
Authentication-Results: mail-nwsmtp-smtp-production-main-38; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] arm64: dts: qcom: tiare: describe CW2017 fuel gauge
Date: Thu, 29 Oct 2026 20:53:16 +0300
Message-ID: <179329639684.489944.11313132727575469130.cw2017-first-public-rfc-3@yandex.ru>
In-Reply-To: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
References: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
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
X-Mailer: CW2017 public RFC via Python smtplib

Enable the I2C controller at 0x7af5000 and describe the CW2017 at 0x63.
The controller mapping and gauge response were demonstrated on Redmi Go
with Linux 7.1.3. The independent monitor also registered power_supply
on that kernel. No charger node or battery profile is added.

The resulting mainline DTB is host-built and schema checked; it has not
been booted on the device.

Assisted-by: LLM
Signed-off-by: Kupreenko Danila <keckerz@yandex.ru>
---
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-tiare.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-tiare.dts b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-tiare.dts
index fe8442300..6d72a4763 100644
--- a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-tiare.dts
+++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-tiare.dts
@@ -14,6 +14,15 @@ / {
 	qcom,board-id = <0x1000b 1>;
 };
 
+&blsp2_i2c1 {
+	status = "okay";
+
+	fuel-gauge@63 {
+		compatible = "cellwise,cw2017";
+		reg = <0x63>;
+	};
+};
+
 &pm8937_l22 {
 	regulator-min-microvolt = <2850000>;
 	regulator-max-microvolt = <2850000>;
-- 
2.56.0

