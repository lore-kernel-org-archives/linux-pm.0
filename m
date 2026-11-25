Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643757;
	b=oqeENucKbd/CXv1UGzRcPRy/Pch92LvjFYf8OitKvHrNkk0l5NAYcYIRtUU6N9ZjX7rf
	 1RvGHMD2KtASJ3rpsrA+MGV3OSu4hwpiifQ+fO/laoU/UaBEyuGH7XJfX7DXkQOTQt8UZ
	 DE3KQPGAIh+DtRdwHyI6NVf+Xi/q0bBu0/HAOMRSfjB30REEI/I+Rv9JA4uMgdLScC0aD
	 ZSHJHrDhCFowJF9m2Y1/gNYMDtUb0xXG4KVpstFjgbfsfjs14EbpGUUbWClHH8iTN6Hot
	 LSk0MuC1u1s34wLzd8pIBkBDI5GUuYTxqFqOtis69sr2m0UnWheEca4U6GqRGQ+IeXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uAN+qnezUmFhxXGPo6XpLvUj0u7gFP0sdPzMCnlyKSE=;
	b=lAwRH+muYYLaAnb2VAU4ax5GbT6MthvHbmU5t6GP3OXdRm3ILIOmgj0EeKisS7GRcxU7
	 hbcjcyaLtosTFt9uqg0foATm7jo5EGmr2lTlM6QWpgHYo5mo+2DGJCnWvURj9PYJmFJYX
	 4i3K+hQrI8r2o2RKJwDCZRGswyoaUB2vuS8GoEtdc57L0ko0D3jD1cD9eVlnAlq56uyFD
	 YbL+yWAT7EwXITC3JEe/W0QgfBJG4FJxSCC3yVmqOCJSXq38S0bLKJZ0WkSjg7KoD2VfR
	 GbBlV3DIjJBN0UwU4fd9MzkBBQpeO4j7QsPu9PqFonGkOm/dnpOcEIKCJ8P0frQPEeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gXo0hC/n";
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AF606A6A5
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 21:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E8AF606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXo0hC/n
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so7730797a12.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795643755; x=1796248555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAN+qnezUmFhxXGPo6XpLvUj0u7gFP0sdPzMCnlyKSE=;
        b=gXo0hC/nffijD3GTgiFu30p6FztE0NaPZrXRVSn1ssm2VPg7P920slYHTUXtguI0No
         5i+BcgE+yT5GypKmCQQFCpAbaggDi3hsLNzZBrTcOL76nYozB8FhrVWIj/+hqvxzo93E
         KYynxwNIPylitInk/wGonjKpwwwx9BOYMeuExwO17P+R54k3196WCj4hpHdRVcrvDaev
         tyqoZvmB3M0VH1vZxvjah0/V/ysq5jLnWS6Z3GUK7uBKuHytklNS6EuK+C4+OZSYb0L0
         N4c6PJGLC149Lun7XUW+wp29maw6rYjdf4jd61rKuSnovs4pd79yuETKfLzgMgEoUoAt
         pWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795643755; x=1796248555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uAN+qnezUmFhxXGPo6XpLvUj0u7gFP0sdPzMCnlyKSE=;
        b=sy+VpKH5uvliARnrQDWuDYuR7nxQqpPs0s5WGkNPFn+jPaHQw3VRaQY/eH4oOTbRYK
         RMK89806EDAzFkSXuh8AXMbV4mqLE9Mg4kX/3EX5g5F+ryH3O4jfUQD4EtmA2m/tK2vY
         NJBrto/dD/7LKP1OkK3UFeize5wySInLjiGOtPLqRKSTd4fT8jHA/G6LczsVhD7Ifysg
         hkURJ7hSWmffaz5ECkRvMXM1iwUgAeIDfqDJIVcGbg2mjnpg+tZjgGtOv9xKR771fDTw
         6t+1T2T6WiZM08BAGHtFAt17b6Du0JDQWtQB8KB96qfTtuBbk8mRNkFDKgLpu4QGk22v
         bZZg==
X-Forwarded-Encrypted: i=1; AL+hErGu5D/UIepZM9z/eCLXClQelhjrjn+PrrkUn4ZVFk3Kj3HyfIfIhu7wdC1OT6wN1uDCmEmgvEsJXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3jQAcdviL0gfnCLV0AuHlnVRZNFKLOT1j5o70fbRTb2aYj447
	i3xyxgU7Z06FNcS2cSdD3A3keUrf8I+UUWl7Q4iX7Y8nyF8sgLGvbD3Ikvrqlko=
X-Gm-Gg: AZFdTZe0CgPo+xURhm+16HaGfnUbkK7nY6QhaLEXR70pw7cPlh14qB+p4tLEHuJlmYq
	2uKBhe/HYWOs2M6ca0YFghzbow8KNwZ4+NN2lEfa6T092zWzXih/feujpDINjcywSwhp0Bo7uhH
	joFKfUt/WdcrMoV7qFMybzLUdXkALjEA2WosOfuaBSjJ0yNw6rggyyLa4B8bymjN/HNDlV2FugV
	NouS5cvTOHMt9xRJQTkXnc9jhPJWlmW2orzpV9bYtLMk64NYeeu04fY6VCbIaQGnrDXR5gNR5I7
	l5NPgwN0giwxx1OFNEjIV6dZsJNtSNbi5fcxL6Z33HyFLM/7iFdLaHNXWk3mlcpGi6fMqBhRGmx
	mKtTvZQ3zRf7vE/o1wzB948OUuqSlvCALz6IgQYOpx0V9ufKZCWEYIwe1bsQFymyQcxNH8huBFS
	f/vQrg9zw8qLsAyBc/16TrWyAIDdFJ9gu22y704Moo9gFBQsm3HyTSocy7oyQAfTQDa4toVAusf
	A4yY798BjHp/Hn2c98NTHIEyqhCtUyMEUAIvA4/qCiS9hNNXDrqf1nbsp4vJbSTgpKwsHypFSN0
	qJgc4g4Ox+UuXIoBKy7bVSnsHMtiFY6QPNNYicoc2agbpia+fgundkIoaPUf7lcIEVJVd80j5Hm
	guZTf2OOFNPR+K08rijwBXvuy
X-Received: by 2002:a05:6402:280e:b0:6b7:d55:87d3 with SMTP id 4fb4d7f45d1cf-6ba37ea7696mr12598729a12.36.1795643755329;
        Wed, 25 Nov 2026 13:55:55 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e77d8sm8608871a12.14.2026.11.25.13.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:55:54 -0800 (PST)
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
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm6125: Add CPU idle states
Date: Wed, 25 Nov 2026 22:55:50 +0100
Message-ID: <20261125215550.1834075-3-majidhhdri@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add per-CPU power collapse states. The downstream "trinket" low power
levels use exactly the SM6115 numbers (silver: entry 290 us, exit
376 us, min residency 1182 us; gold: 297/324/1110 us; PSCI CPU mode 3),
so reuse them in platform-coordinated mode.

Cluster (domain) idle states are left for later; their PSCI parameters
still need to be checked against the downstream levels.

Tested on a Xiaomi Mi A3: WFI and cpu-sleep-N-0 show up in cpuidle and
the usage counters increase.

Signed-off-by: Majid Hajiheidari <majidhhdri@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index cbc500d69..f30f7b16d 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -44,6 +44,7 @@ cpu0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 0>;
+			cpu-idle-states = <&little_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
@@ -60,6 +61,7 @@ cpu1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 0>;
+			cpu-idle-states = <&little_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
@@ -71,6 +73,7 @@ cpu2: cpu@2 {
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 0>;
+			cpu-idle-states = <&little_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
@@ -82,6 +85,7 @@ cpu3: cpu@3 {
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 0>;
+			cpu-idle-states = <&little_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2_0>;
@@ -93,6 +97,7 @@ cpu4: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 1>;
+			cpu-idle-states = <&big_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
@@ -109,6 +114,7 @@ cpu5: cpu@101 {
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 1>;
+			cpu-idle-states = <&big_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
@@ -120,6 +126,7 @@ cpu6: cpu@102 {
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 1>;
+			cpu-idle-states = <&big_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
@@ -131,6 +138,7 @@ cpu7: cpu@103 {
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			clocks = <&cpufreq_hw 1>;
+			cpu-idle-states = <&big_cpu_sleep_0>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1638>;
 			next-level-cache = <&l2_1>;
@@ -173,6 +181,30 @@ core3 {
 				};
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			little_cpu_sleep_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <290>;
+				exit-latency-us = <376>;
+				min-residency-us = <1182>;
+				local-timer-stop;
+			};
+
+			big_cpu_sleep_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <297>;
+				exit-latency-us = <324>;
+				min-residency-us = <1110>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	firmware {
-- 
2.56.0

