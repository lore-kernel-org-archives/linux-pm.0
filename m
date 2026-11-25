Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643756;
	b=tu98xHzEwhjF/nnKOaElzXjXSXIbnb2fNjLii8Q/yj+6G7XRDQXM7/xJxozeDtTcMuaH
	 xo/glv4BUojzq0MY8QqrrysxhGwUXiFOVvCDp2nJZBZiQWB/b8wXBdLow1si8cwEVO1UM
	 7S4DDvxWjnwVBI6VBczihF93u1OC/dpWAXheJ1qmU3wo2C2oBHJs0WHnOmRgUFkkM3tEH
	 /G4Rf+PYZIP7scIgzdOf4l1vzmHAJhD2n/cPGa71vFq3BY3fJhTVUUh47x3maBpds/fyp
	 iCtHZVebiSCIHVHOw4Vswpkl6DVSUeHhCQuvKvuAFWpcOjreM6HKRLuEPcXbsN0phzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wyP7vH2rGlbYhb8q27/m4UJghzd8eGwKK/Q/LPzbUrM=;
	b=wqWr6VVV0SfOzD/mtp/+m8sePn10GPx2Zidpe27sXr39d+0XhtAQ5BKibU+EXFTOwztC
	 BKviiyfAJTFqrUaWHUYJWykzqSnfzHYQCYqjgK8LrFJFW8qMfVdrH1y1KqLMcbCd5nQt9
	 iAH5VZ+ibMmN/AHymQMXqKhfFQr5j982BJyxvDV0ysSiRYHkhtkKXUn7x+GPKlSrMjipZ
	 oed0k2fkQ/ux1sXDhBsilHF6xRdcE3ai7gFE1QMreASINiCAxmYFq/6J4Hb4S9nKIefZc
	 SloQkU1eWSP9ql7WOQdjKubixr91zX9vYUu7piQ+61V6GDlCgIAHdZywCQNNB1SKw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MpBzx8g9;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9727606A334
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 21:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9727606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MpBzx8g9
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so7888008a12.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795643754; x=1796248554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wyP7vH2rGlbYhb8q27/m4UJghzd8eGwKK/Q/LPzbUrM=;
        b=MpBzx8g93Uj8Ruy6RhF/in7IdZprugMOEFUfAZDRaIrjPOdZUZq9XsDQ2SSnsFGOz2
         EQvQuVnTQnPQ23H0ERkowHhW0yTsOv5RR818+V2z1TFdHne1R7OzQf28D/KdNx87Se33
         /3HJNGeIvVtLK9ctktr5ipsu2GPmb5Zzp0yHQjucklNfC1LIo97ZhjBUENwdL45IzXmp
         Lj5ObQ8mhFPlZetzP21vaFRyIpMcxkp2Fjv4zzyvMulQkvMJ+heiSHh+oFEyTThMC6CW
         IhnD13e/mBZO9XUUx6GG8EJehae4Cy/Jcp0x4dClozTx++VvrXyKe1n78BcbFe6bM1l7
         Qyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795643754; x=1796248554;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyP7vH2rGlbYhb8q27/m4UJghzd8eGwKK/Q/LPzbUrM=;
        b=BCJkOmEGKp80n48nENYSA9rwdCT7OAWfeQ0K/EifEHSSV76fIh11Ia6fsJCK2kIg0F
         PRDjrpU1xFz0ZJbBEInT8hznkq18aVg3fo+Pae7q59YOGkcSpV0zn3aIdyYEi/As6tD5
         ACcqAL/empV4uf951jjmmRiiYgZuieb0gQTpjAqYlAPAOMARyjU7x9Ggxy6YmGcNxix5
         wTPWgKSKhuMBUk+bpvPGbirGNNMm6bO5Y7Zfs2BgIvb5F8HNX9OkIBlx7UbqyuZlJ5wF
         XXWHYBp0X81U7MmVct0e3TLXtzgjx9e8tqbHlNiKCL11pu3txO6LEivzD0ZAHEs8dB/m
         LwiQ==
X-Forwarded-Encrypted: i=1; AL+hErH0KEroR+U135Lc9zTb9G+o3hzT6+VgBEBKVj3lxrzWbn0eM4pBzbe+bPgFxYcW+GGauJeBGs6uVQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yDqyoXF1AIWHUScHC0DGdmDgb2HqzmkKbYnW96/tCrdcJ+8ag
	ToDDcB2Kf1YqPRD2mJfyiHtUvjnXXb4OQ08VKyXrEqGsj3jN0Ri0jNs=
X-Gm-Gg: AZFdTZez92aG7g/Q6bEJIb+k/9WKqx3qi4ce+pRAbqN9iEQHJu5Kw22PPJKYVzROkpY
	X/mvddwELVTwitKcRM0hJg2ERyQcbiCTK5OMvwgEp40OIW8QBAOYOMq1E/zlZj5LYPJDjA4sJl2
	Cm+UO2hGSrlH/4NYavDpfB/Da2ph7tVNna9aHZPe/VdnjcRz+ve6j17rJktMGwRD7CAIVLyk9Wc
	tWPu54E3WoJer4T20wzHG7OQggPGn3mf0wRwJO+RhawT6LE6BpuFlCkXRBM91a2O0oErBnr2N19
	XzrcAy8SYVrILAkqrrrwqwAh5MdeOsaloOlGqTiF+D054q+Wdfi7x+rUDl2X7gIV+gfq7jqC+Pd
	CDWXdrqoWlUSUBdOBNPQafLW2J/QsLxlGepc5LeUB2HXiL/0fMs6ctVFxRKHnlZ7s1jZEcBbnpH
	V+uk/Lgyr9mSHbeUvYvfxq9zF+ehgLzPwuQ2TNz1sK459IfvICnpMG+kNF2K6RA/7azB3X0f+Km
	NpfdEStPTpu6CVE8CdxzHQTwJ0sGGMX/CZyU5l866UWhiv7CkFC3B/ODlhjslnnPgTIHoJ0ASSa
	07aYZ3l4J4UUo0X8/J55KB0yqSDancaJkmj+ltbYk6DLYHVKIa4uM/sAkhJU8V2w11AiEBUOZSi
	zwyR2c60IO9Q9G1kzLHb5/VnX
X-Received: by 2002:a05:6402:22e9:b0:6b6:edfb:5885 with SMTP id 4fb4d7f45d1cf-6ba37c75eeemr11786385a12.1.1795643753754;
        Wed, 25 Nov 2026 13:55:53 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e77d8sm8608871a12.14.2026.11.25.13.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:55:52 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Roman Linev <admin@mswin.me>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm6125: Add cpufreq-hw node
Date: Wed, 25 Nov 2026 22:55:49 +0100
Message-ID: <20261125215550.1834075-2-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125215550.1834075-1-majidhhdri@gmail.com>
References: <20261125215550.1834075-1-majidhhdri@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SM6125 has cpufreq-hw (OSM) blocks at 0xf521000 (silver cluster) and
0xf523000 (gold cluster), each 0x1400 long, per the downstream
"trinket" device tree. Describe them and hook up the CPUs so the
frequency can scale instead of staying at the bootloader setting.

GCC on SM6125 has no plain GPLL0 output; GPLL0_OUT_EARLY is the PLL
itself and is used as the alternate source.

Tested on a Xiaomi Mi A3: policy0 300 MHz - 1.80 GHz, policy4
300 MHz - 2.02 GHz, scaling with schedutil; a single gold core holds
1998 MHz under 7-Zip.

Signed-off-by: Majid Hajiheidari <majidhhdri@gmail.com>
---
Changes in v2:
- Region size 0x1400 as in the downstream device tree (Barnabás)

 arch/arm64/boot/dts/qcom/sm6125.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 5f558b548..cbc500d69 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -43,6 +43,8 @@ cpu0: cpu@0 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
 			l2_0: l2-cache {
@@ -57,6 +59,8 @@ cpu1: cpu@1 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
 		};
@@ -66,6 +70,8 @@ cpu2: cpu@2 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
 		};
@@ -75,6 +81,8 @@ cpu3: cpu@3 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
 		};
@@ -84,6 +92,8 @@ cpu4: cpu@100 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
 			l2_1: l2-cache {
@@ -98,6 +108,8 @@ cpu5: cpu@101 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
 		};
@@ -107,6 +119,8 @@ cpu6: cpu@102 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
 		};
@@ -116,6 +130,8 @@ cpu7: cpu@103 {
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
 		};
@@ -1633,6 +1649,19 @@ intc: interrupt-controller@f200000 {
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		cpufreq_hw: cpufreq@f521000 {
+			compatible = "qcom,sm6125-cpufreq-hw", "qcom,cpufreq-hw";
+			reg = <0x0 0x0f521000 0x0 0x1400>,
+			      <0x0 0x0f523000 0x0 0x1400>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0_OUT_EARLY>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.56.0

