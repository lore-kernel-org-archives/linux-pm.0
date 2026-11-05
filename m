Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793853661;
	b=hW4qrOGBfR/WCx41pCUtUPsFGpvxOXwvAOgeiGhrOJ/TU0rKLKdLS/UzSkFyNaf1G+Zp
	 3vVhadyFAr8GAgGneMQlFpBIZkZ6+8JZVSur5zYUUcTlbyxFOjs+Hiwsdi9L/EZB866iD
	 Ds2K1ldZW2AdzK8bvtzC5HPDDXRQC7SPBdZOiDhkVMNQzVDekSvdStp4F3Ze4N9EqLyUq
	 t/7+w+tSc9ZJc75QIydweFYynSlLNShjCSi5rSfIagMmP57U8CEzkRTqLzrNpOMJcLrNH
	 fZ9Htyj7/2QhR/TUQFwH0vL/OqcqZ5Yamimyf16mjyloiozVPXopaFgyyJ9lv3zOS1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853661;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=llhJDHVHoisfN0tHe6o8AiZ3pTp0FIou5pivHrQApOg=;
	b=eWIJADFcF9YjmbNKPfZm5IjCURwff2n88R7/mElUEMwZKNlJXuhPM5cwHNdABIb7LLJm
	 jm9g28ES6krpwUSsb4j59K/q0HRQctm7EoX0HSjbl7TlQf6RsR6q1aS0Dsr73oR0NHYYc
	 iiSyGAtfPjmjNWFoXjv9iwi/NC6pkzejGC23tJLI+DDkkHABNTqzwI3X9Of9zVAsP0TRS
	 2DKRBDmFYG/uA+vsX4wL/eZPO5iE7yJAZ6UT2SmSgasf7RROzyfbAq0svnSQHGQtmTUTe
	 q68Pb+pM/YWa8NCz3ru1jSSc85x7kutvr7oCI2pi68F9NP3ruMZ1ruZ6+8N5+5vVVAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGpYxquc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A41606D81A;
	Thu,  5 Nov 2026 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGpYxquc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793853660;
	b=A89FxL0cVsscIclqwBNWFofYer3qkwqWHMoPEK/e390or7ZCPa3zN8Ta//5t0948ldTF
	 Sz0D7NdYsLb875dr9E/M8ZDUCCCB62fSbMuxF9Gv7ZYhyGWNGkJWJpN4w2IJwUcgQ4wRe
	 sWgOh2S8+RLoYPav5zMSyhWZ1CW8H2gvzdyHTsX/FTQc5rnnCVEhkC1yy44yXP5++6muN
	 fxTfU6c6rAGf8V5WaArHrKRKGqgidz3H3VX28rLcIJFs66pJYGg7FFhEG5EoifZOMlXOp
	 1WEqzJoBIArs+o3UYLfO/N5ebAHoy25W5ryjCieAWnUgcSZ/kSxBviQH6LP+VG6eYCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853660;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=llhJDHVHoisfN0tHe6o8AiZ3pTp0FIou5pivHrQApOg=;
	b=0mINOOwxXAFaMKonjWbRHLMWsTzcTZsABQ5ZJCGzJuBs+1Cve4q4FPQtPgrTbSBYEn9Y
	 qTsC76bym0VsVEDnC97KyhicIVkoCBKjUnPh7czM/6lTwcIWnYMZvivrh1P+mcYQQmnKu
	 cW0NtVHqH582mPlFneQRoQOJHwNzFd8dyZ5PiRWPqUPOkXdE+1hRache4HXZgWJmHEJZj
	 /BUlYW0AijIdcopi3XQwh6izmTUp7WItg/xisKHUllQkfsbgbf9PD3WzQD2dc0HWEH+yO
	 nobZcwt96R08MoyJRJD+Lf9Pj2f+WPYj8Nd/q1E32xm+/QZF20Bs8mybHAHOkVml39A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7F9261F00A1C;
	Thu,  5 Nov 2026 04:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853660;
	bh=llhJDHVHoisfN0tHe6o8AiZ3pTp0FIou5pivHrQApOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lGpYxqucer31Q62JUlnGIk3/YOy0dwz4SuRU4P63q0F1SsL6yijEeIfOM1lgAOeke
	 jUujqqGPLjG4qxADOLOIIB78jkbFarQR7mVu/+j9EXeLwqzlH39X21qe+RVDfQjarp
	 h/iaf/jnY9Hn85ANiOsEKqE5xrSeA0HOdon30ORBrLJLzMETV5H47MUIuhUoZsF9Xl
	 XE8Tx8vM2rPKgErHBSnYbof4DNeJrCEoJOkWEKXWnzyiGGW7neQqAWMt55cRhGTDZ1
	 hFv079HMKfe2v3/luXn3JoreHcZVbvNMEKbD738WLeapOTSZ5M387h97wze/L2WR11
	 uv/+LdPpvCIgA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 091D2470A3;
	Thu,  5 Nov 2026 04:40:58 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 22:40:59 -0600
Subject: [PATCH 4/6] arm64: dts: allwinner: a100: Add A133 speed grade
 efuse cells
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
Message-Id: <20261104-a133-series-v1-4-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
In-Reply-To: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>, 
 Alexander Sverdlin <alex@sverdlin.org>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793853656; l=1561;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=/IybJoRS+RCeafxjvBtCrPNxM5kYK6ctY7B27mLTNVg=;
 b=NgBTLrOPCIZQ/56YuWB9qFnXvWIEKYUbNUchtr1oEcU4Ll5eeGgzPWYJLFIgfVLIeJDA9sL71
 dhuIeKxEsVpC3qoVoVyJ6nEXPP+mXZUgXiMEbe8nOvVpG9YSewD6k5c
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

The A133 speed grade selection also needs the chip marking ID (SID
offset 0x00), the word at 0x20, whose low 12 bits the vendor BSP calls
PCPU, and the word at 0x28 with the bin extension bit. Add nvmem cells
for them at the offsets the BSP uses. The H616 reads the same kind of
marking ID at offset 0x00 as its speed grade.

The cells are used by the A133 OPP table added later in this series;
the A100 OPP table keeps using only the existing 0x1c cell.

Claude Code (Anthropic) drafted this change and its message from the
vendor BSP device tree; I reviewed it and checked it with dtbs_check.

Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index ba6020989ce..d1164f3b549 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -176,6 +176,10 @@ efuse@3006000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			chip_marking: chip-marking@0 {
+				reg = <0x0 0x2>;
+			};
+
 			ths_calibration: calib@14 {
 				reg = <0x14 8>;
 			};
@@ -183,6 +187,14 @@ ths_calibration: calib@14 {
 			cpu_speed_grade: cpu-speed-grade@1c {
 				reg = <0x1c 0x2>;
 			};
+
+			cpu_pcpu: cpu-pcpu@20 {
+				reg = <0x20 0x2>;
+			};
+
+			cpu_bin_ext: cpu-bin-ext@28 {
+				reg = <0x28 0x4>;
+			};
 		};
 
 		watchdog@30090a0 {

-- 
2.34.1


