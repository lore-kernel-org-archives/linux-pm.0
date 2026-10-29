Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302504;
	b=xzEXb1UeXR7CIaZ/JTeRSLIznPm1lznP9f7IYnF0zgdSd5uSpI3HuhdApDimpKyEBnf2
	 52QgGvAAjnH+orl4VuclkaaIK4D/0TnqpgtrOdTeEesx3ku0ckpuuXF2cvSwAyekvfjsg
	 EqjfS5UQJ6gYHRQPhTYIvSxMZhFrRe4wB/B5tEdKihxvPNewOz1rq88b93oXbjh7h5cRP
	 0hO4JvmHqLA9EOQ6g0jNgjYBnhydIiTwt7tyMusW4HyUBYwUkZ/FLPNg0bapY3gV5B2fq
	 Jo9pP5DxOPa1t+ORnHxpbdTDhug8kR+eQcL9d12IwsiuBV48coGfty4YaM1X5lxfhAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302504;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DWUyaicLfOcratOVaBCdZhUzQQOEKathswZorNrCFE4=;
	b=0LKfguKuOHkhjxAYceprWlsZB3Cry73/nj65n6c7S8BQmi7jsPE8iZM6XcAXTZlBoNto
	 vQhfueN1KigZukmLjZZ5QLdoAkgSsXvPtaJsZ0NabihSDPZxKIwhuvxgrKT0Mj52Inr3Y
	 Lw6SzZ6ekQVVtN0W9UlLdieqrQWlK6qZ0u58tW7rIA43m0MuXd7c7FjctUzv0CPs9fHW2
	 GHaNztxFJbT21gfjopQdqGB1gb8ThJTqMmU+VFMP4rixe9SAceJnq2sfCCJS7d062iCId
	 nBBX4fiZRpPiI6j9IFfDMHSkUeQx9WFzZGWJ+v8dAdo4mcWgt+1gbTMoG3GJ504d1og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Hs16mx+A;
	arc=none smtp.remote-ip=31.44.14.18
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [31.44.14.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DD606A338;
	Thu, 29 Oct 2026 19:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D26DD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Hs16mx+A
Received: from mail-nwsmtp-smtp-production-main-34 (mail-nwsmtp-smtp-production-main-34.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2499:0:640:3812:0])
	by forward502d.mail.yandex.net (postfix) with ESMTPS id E6E49C014E;
	Thu, 29 Oct 2026 22:34:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-34 with ESMTPSA id NYpk4nSh00U0-yggWupvt;
	Thu, 29 Oct 2026 22:34:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793302493; bh=DWUyaicLfOcratOVaBCdZhUzQQOEKathswZorNrCFE4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Hs16mx+AKpbnw444v21SnTuRFA0QB0iohy/iIz/H8UJJKdnIjiS/8X2MvDBOe7xq0
	 abIhUuBVLm3o72XXgZIz7mNRrW6DITjKF+Dwx5WJi8lAYVcYJfjKFQFB8wwGj0KrJY
	 RYv+i4fTIDx9DB8SsE1twCSe+XFI13u3tLbCLKys=
Authentication-Results: mail-nwsmtp-smtp-production-main-34; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: sre@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] arm64: dts: qcom: tiare: describe CW2017 fuel gauge
Date: Thu, 29 Oct 2026 22:34:17 +0300
Message-ID: <20261029193417.551058-4-keckerz@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029193417.551058-1-keckerz@yandex.ru>
References: <20261029193417.551058-1-keckerz@yandex.ru>
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

From: Kupreenko Danila <Keckerz@yandex.ru>

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

