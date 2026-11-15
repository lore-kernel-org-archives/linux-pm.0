Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702731;
	b=Q1TBeTsOKpWgfSIepuO07DKE5tgw9i7v1mj7t7xnui38YmdpA1oEZD1PT160sydLAN8i
	 u68DffZVTaf6d1qe2YivYzjGcLvjYqfu6lvC0EKw2z8wdNTiwIz7BxJCgRVnauZKXZFDH
	 3/wSkO9xjCjsH/br0ikTj3am5SmQyaQXrbAd/A4uOVmo2AQanRFmbWGp+MhReJr+PRgSg
	 JAsK0y7fmHwGDfgpnAoykvINOnjyELH6c77cybngWPWd47qD/w36ftqwW20QfIlgEoOKs
	 3nP54La4iFvG5vCYj4O3admAJhShds/3gLq91q5gF8JYbgnHQQ7sHWVyr3FrJsZEnrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/V2Llsn9Ob6GsqoLU7bUjN5jzG8A9WYSdTy8aKE0Szk=;
	b=JjF/iac5bzSI6eB7n36ph4/YsJbZLoLsxwF7WiizKWGW38xF14gCik/aZaZ9yT+fdID8
	 veMxV1VfwJVQp3Vwunw81NE2UwuizgcN2tl7kIvxGbHEog2OOgFGGEl65SpJl1ofgtKe+
	 6r8ywNXH//WQ/64MJVf4CcurHUaLnuFaiLEHUgu+kPQM58vkyMivrAXkb2t2hr2VL/XTP
	 jUVZgNIxL5fZkNjGxDbbu7fTOGkoht+TtncG5uI7nZC7pZ9j1UlflANL6XPWPvskBFnlq
	 +4crmBG4/q4a7gyBDtLAc/7NO9Y63Kmzbw1f8Pq547pzCJfzaayTFzDV33f/r/W9dsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+MAAQqn;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49F606A894
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD49F606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+MAAQqn
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c505186727fso424887166b.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702729; x=1795307529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/V2Llsn9Ob6GsqoLU7bUjN5jzG8A9WYSdTy8aKE0Szk=;
        b=I+MAAQqnmdX816Yuya9hYCTG1HjEcrD96aKoQbrYdMjff5KADXulZWqJpg66oJy1zG
         yuagg7rqaGsybkAKhlX15mmm1bEMZFz2D2rNI0rZcYaaPSbRV5cz4taVJ4waTfHc44/3
         XmGc+XX5lLLPBL8jt6DQSVVzK+JqC8njNusX0d29uCM5HJlMtUH5ZIDlubk0x53fqX7D
         aR5ExrfbHMlrTa1s6EIsR54gkUzfSWyX73bZIYnd10l6OERnBkF4GjT64T/DOr5pDCgZ
         p671Mw+++D30ttsUaxYspVeYxl3NbwXYNlveZePNB9EG1ste+MRqEj6qds+Exo9Qh1tO
         mEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702729; x=1795307529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/V2Llsn9Ob6GsqoLU7bUjN5jzG8A9WYSdTy8aKE0Szk=;
        b=Hf4WaDuidcr25O4jFxAlsK8ud48bm08Uijd8vYFkUztc6QygMy17Ga3ojUaS7RPQeF
         Fob19jyY/TH93z96cfXBRGEmEXHrjyTVYp4R49iAWwHLl2Y6EZYUMETC9+sXrm+nzeGw
         Zox5lICfPnzQRvENnvv4OLEnSdaZsCjEkIg7P9BxZrvPp/EA9xvKcOm5CNasIqyTNXr8
         znIsY73zSz0Q/cl6jIlYYxcZ0n9psiCzp/1FdcsmY7xfZme8TxlLsxx/p8n1jyb3zpuZ
         0798g5kkdyrufssmlohnN/wVlJrHUVgN7CwU0fEXUoKgVS/kQymh6lKFZSnQY6xmFOi8
         Wp8A==
X-Forwarded-Encrypted: i=1; AL+hErGk+N/5CEIdHNTZr+2bCXyihtaWuMNS6OhX1l/2b9xTkwxHJEg3M6O8B06yQxdrduw5gysXy8w2iw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QBqvPppoEZ8WjcTGZeeoL2WJahFE3Z8qcy0d5samviGyS4YsS
	c+wCZsTLf9ZzEhNO9vpxANYTpDdRq2PUDemQNPqvdNOcd54w53/9ZrM=
X-Gm-Gg: AYBFou0VJZiWyrtD9tdLqZZzDJIEM8522THltRbC94lUWdg6V3thJMcIADjQ4+kuX6N
	kt0iNQ+F8j1YxPN8BhEVJJtEb02drNWo20O5dNcCQGKDgai2mwgsaK9E1WfiPps1kyrzimUatT2
	fP5qeBykNaL2t8jvBgNSky01aNIQJiELzRd+kpjgYm33fz3AE8fXr4NLBIVNjb6SlvYn8Kwu+O3
	CCH6fhiAcTC+loBp24y40ocHv7BNOsj/s08hVkbskCwAlm7zR4Ge6k73OaY4Qp+7wzLMTZJ3zF8
	Y7letiubY7mF9vJ82f4auRsWIBxhiAOX+No6/Prj+ajtCswolMCO2GgUpWVM/rNN6Nkd6nUGYHD
	Jd2SMJmu3nBOXSA0/UO+7fEcZNRnnODp2S8NvxBIsb0eSzoH9p5kSVcgXS8Hl4dXFYKoahfx/oj
	bj3ANUNLx/NAGVM8VJf1ZBuUqQxP7LQacFu1p42yNEm1wY+VmFe7XKW/ZALoXumY2XhPA39ZkmL
	D+JPc3KjfZNJNgIJUJPRWLmMUYgJ2RK6oLwrYdZ7aGv+tNauMh+in+soZMEh/MvHy3Xp8oDQ4Nq
	f1I59w4KrcUOvzOT7zFvWhZ054/T0PlIdB7nFNEvP3WFV0iS4QLVeZMrOo65BQUVWMLWQCQ2O2B
	zrVr5mt+0+h6jUb8RuRXwp4/wL6RNJWTOQbY=
X-Received: by 2002:a17:906:9f8f:b0:c49:a539:aa45 with SMTP id a640c23a62f3a-c50963cf771mr521124166b.42.1794702729152;
        Sat, 14 Nov 2026 16:32:09 -0800 (PST)
Received: from sohrab-omarchy.taila18b31.ts.net (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5c4b7sm260695166b.1.2026.11.14.16.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:32:07 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mani@kernel.org,
	admin@mswin.me,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm6125: Add cpufreq-hw node
Date: Sun, 15 Nov 2026 01:31:57 +0100
Message-ID: <20261115003158.391171-3-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003158.391171-1-majidhhdri@gmail.com>
References: <20261115003158.391171-1-majidhhdri@gmail.com>
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

SM6125 has the same cpufreq-hw (OSM) blocks as SM6115, at 0xf521000
(silver cluster) and 0xf523000 (gold cluster), per the downstream
"trinket" device tree. Describe them and hook up the CPUs so the
frequency can scale instead of staying at the bootloader setting.

GCC on SM6125 has no plain GPLL0 output; GPLL0_OUT_EARLY is the PLL
itself and is used as the alternate source.

Tested on a Xiaomi Mi A3: policy0 300 MHz - 1.80 GHz, policy4
300 MHz - 2.02 GHz, scaling with schedutil; a single gold core holds
1998 MHz under 7-Zip.

Signed-off-by: Majid Hajiheidari <majidhhdri@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 5f558b548..1b148e453 100644
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
+			reg = <0x0 0x0f521000 0x0 0x1000>,
+			      <0x0 0x0f523000 0x0 0x1000>;
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
2.56.1

