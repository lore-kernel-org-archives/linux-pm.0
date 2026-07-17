Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7053FADFC
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295264; cv=none; b=BahPyMeDSu7PTz5urdYL/dqQr69EgVvk1OKuglzjZGawbs+yV69LlvSQUM5z5sOWPep3MRdpDn/WOECjIYT6CznR7OWRhkktGYZOQj5orRItMoFPT0zo0jAAWqj3I/iN5Yh0qo0HkOsVCxpL4TlQvy/o/YLtLGhj93Fq3UgXsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295264; c=relaxed/simple;
	bh=C198r3gCqIY/J6Fr9Vk6dgw0/uX+Jq8YQlIxFo6EDYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoudaSFXS9Fn+D9Zy+1M7I/ZtoDd/nTP50rEwgEQwes1FuFCWMNSZWCGOEYWqcKKnC6H1Z06dLrqAouMnclixJ8peQZKRYjdUkjo+00A4HQ88xSutBYmLktVIXbA9tTvQ721UWvnRPNZg/Jqax2HvwvwQWVVxyghzsQeVbJASSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0iMOR2J2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0iMOR2J2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4798bea72f9so4110884f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1784295258; x=1784900058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liDsHYovAigQzHiel9REIyn9bO9n/jItQ4bNthduX5I=;
        b=0iMOR2J2IjWIomwA6oRx+ykFPhOi4CP57SKNi7KVyssSe31WfzVQ9rbgKjP17yyzdK
         rbnvAg7Lbi8Y4/3jIY2XbEiutG2wkY3sMckwe3Owb+8lScDt0VsdiqfkBd66gBKPCTv+
         vBOeSndV57pSpg9QUVLw4bwDOth5teQN5ZHaNyJX4/GoOZVOPCE+nnqYz0UEiS0Qi797
         Q29PtfK1/GimlKmFoLqah5OWftNzU/d0lgSPjlOxnFF+4aaDViOTQmj0HbHVhXxGSwwU
         bu3l900Hc53Gc/d4hELZsniW404EJ/I3XiiXexDxZqFbYts00JeSg3fajZnptfRJ4Ley
         mkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295258; x=1784900058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liDsHYovAigQzHiel9REIyn9bO9n/jItQ4bNthduX5I=;
        b=erWf/viwaidG6xEQY/xTSE/44MFo6mbnYjmFnzUxOM/YB9bRuz8JHI2k0rNC9rq0Mw
         O7n7FLV107cD0dNQclmWjvB6D2NYyDJd8eXB7CMXxqSiRiGoVci4szS8saEI/Ig80+y6
         E79viONCkvFLvvMF/s8SN0XEDs9zN/eJrowptFSQV4vdIg3csaf4T+CpTrX/IfSxOPjc
         055GPpD1lH8GiEeODp0XEJEDBLUZagLDWJMAAZnXFrBiKhTxd5uCEESYXdDovmolvZ+L
         EgURS4lqLb6wVSYG/O0XVRV1SC+aXRvrsFCK7IzuZETQ0pGs3S3njT5Csf8E64go0NMJ
         roXw==
X-Forwarded-Encrypted: i=1; AHgh+Rrk2zKChPFcfVJLejWlNAqTWzPPPDZCJVgQeAzehhdZ7mw1qLsnsGw7m1h6jNKJwMsOMiDH0ZjGtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtlI3fGhQY4Uu+XE2jvjPMvsY7tuGpS93iMTnCxnOq83Ce5F9
	TNQchYtvcIpFW1zD85JQcjz599vNHtdLwFjIyda0aNiyM7fmKL5rtaRS3IvUd/b+vlQ=
X-Gm-Gg: AfdE7cmxTFGJbCjamhxCcPN262F8A+ojCoT2IISkkaeE2Z3NGm5Iqj4Fqr65iSv1NRw
	0vdUjtCEmX+pS2EGuJDa70ASp4Yd3rHFYeRNQcQLlEyl4L8CLgA8G/8ycsFeS9YFKdXEOOvbgYN
	KWwSMa+6l/Zqp8H9S6k++u+FK9lqOXo3C7qFcUortT2n7bglUyPrJaqGeLL1Ii0ds3xspTTohLM
	MeT7fgp58Jmg64EQHh1cOJYx46Bw9rkNfnGIpq3MIidwZkgATGcmgd5h2BkbtnWniA9XuKjhfLX
	nBQEozE4Kmm5g5z3Zh3t+uJOBp+aT56luaQHww+1C01heXGbk4HKPzSMq0W3kWrO0u7/wQpxzbv
	V8Ba3HqPenegCqPUrfFLDqZj9Ph5J9CCbcEF1XoXv0efnXZzUmnT1l7ByfKLqz9xMGhppoG72yN
	hdzWY0UOzxYP2spoQ=
X-Received: by 2002:a05:6000:2c03:b0:473:1706:7f01 with SMTP id ffacd0b85a97d-47f623348ddmr3506789f8f.43.1784295257935;
        Fri, 17 Jul 2026 06:34:17 -0700 (PDT)
Received: from [172.18.170.139] ([185.104.138.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm4361547f8f.5.2026.07.17.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:34:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 17 Jul 2026 15:33:04 +0200
Subject: [PATCH v2 2/2] arm64: dts: qcom: milos: add CPU OPP table with DDR
 & L3 bandwidths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-milos-cpu-opp-v2-2-428813fafd52@fairphone.com>
References: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
In-Reply-To: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784295239; l=12661;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=C198r3gCqIY/J6Fr9Vk6dgw0/uX+Jq8YQlIxFo6EDYI=;
 b=J5h8jexeERNkt8ITTPhYzqpmuvlh1tfP2Wi7h6vmcTY9sx1EnZ2guiaf4+WuvqHRmdbTJ++am
 C5KP8pPZJxOBVG7hWNlJkrng9cyShmlAiIpYhKSbSBW72A58YQk5yDt
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the OSC L3 Cache controller node, interconnect entry for each CPU,
with 2 different paths (CPU to DDR, L3 Cache from CPU to DDR interface),
and add the OPP tables for each CPU clusters (cpu0-3, cpu4-6 & cpu7) to
permit scaling the DDR and L3 cache frequency by aggregating bandwidth
requests of all CPU core with reference to the current OPP they are
configured in by the LMH/EPSS hardware.

The effect is a proper caches & DDR frequency scaling when CPU cores
change frequency.

The OPP tables were built using the downstream memlat ddr & l3 tables
for each cluster type with the actual EPSS cpufreq LUT tables from
running devices. Note, that higher frequencies than SM7635 are available
on QCS6690, those have been added here as far as possible but may not be
fully complete. Additional OPPs may need to be added for that SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 344 ++++++++++++++++++++++++++++++++++++
 1 file changed, 344 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 8c9232988953..974afd7a582e 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,milos-rpmh.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
@@ -65,6 +66,13 @@ cpu0: cpu@0 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_0: l2-cache {
@@ -98,6 +106,13 @@ cpu1: cpu@100 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 		};
 
@@ -118,6 +133,13 @@ cpu2: cpu@200 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_2: l2-cache {
@@ -145,6 +167,13 @@ cpu3: cpu@300 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 		};
 
@@ -165,6 +194,13 @@ cpu4: cpu@400 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			operating-points-v2 = <&cpu4_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_4: l2-cache {
@@ -192,6 +228,13 @@ cpu5: cpu@500 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			operating-points-v2 = <&cpu4_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_5: l2-cache {
@@ -219,6 +262,13 @@ cpu6: cpu@600 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			operating-points-v2 = <&cpu4_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_6: l2-cache {
@@ -246,6 +296,13 @@ cpu7: cpu@700 {
 
 			qcom,freq-domain = <&cpufreq_hw 2>;
 
+			operating-points-v2 = <&cpu7_opp_table>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_7: l2-cache {
@@ -394,6 +451,281 @@ memory@0 {
 		reg = <0 0 0 0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-441600000 {
+			opp-hz = /bits/ 64 <441600000>;
+			opp-peak-kBps = <(547000 * 4) (364800 * 32)>;
+		};
+
+		opp-595200000 {
+			opp-hz = /bits/ 64 <595200000>;
+			opp-peak-kBps = <(547000 * 4) (556800 * 32)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(547000 * 4) (710400 * 32)>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(547000 * 4) (806400 * 32)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(547000 * 4) (998400 * 32)>;
+		};
+
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(547000 * 4) (998400 * 32)>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-peak-kBps = <(768000 * 4) (1094400 * 32)>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <(768000 * 4) (1209600 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <(768000 * 4) (1363200 * 32)>;
+		};
+
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1363200 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1497600 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1516800 * 32)>;
+		};
+
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1804800 * 32)>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-peak-kBps = <(547000 * 4) (364800 * 32)>;
+		};
+
+		opp-633600000 {
+			opp-hz = /bits/ 64 <633600000>;
+			opp-peak-kBps = <(547000 * 4) (556800 * 32)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(547000 * 4) (556800 * 32)>;
+		};
+
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(547000 * 4) (556800 * 32)>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 768000 */
+			opp-peak-kBps = <(768000 * 4) (710400 * 32)>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 768000 */
+			opp-peak-kBps = <(768000 * 4) (710400 * 32)>;
+		};
+
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (902400 * 32)>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1209600 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1209600 * 32)>;
+		};
+
+		opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 1555000 */
+			opp-peak-kBps = <(1555000 * 4) (1363200 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(1708000 * 4) (1363200 * 32)>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-peak-kBps = <(1708000 * 4) (1497600 * 32)>;
+		};
+
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 2092000 */
+			opp-peak-kBps = <(2092000 * 4) (1497600 * 32)>;
+		};
+
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 2092000 */
+			opp-peak-kBps = <(2092000 * 4) (1497600 * 32)>;
+		};
+
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 2092000 */
+			opp-peak-kBps = <(2092000 * 4) (1497600 * 32)>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 2092000 */
+			opp-peak-kBps = <(2092000 * 4) (1516800 * 32)>;
+		};
+
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1516800 * 32)>;
+		};
+
+		opp-2707200000 {
+			opp-hz = /bits/ 64 <2707200000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1804800 * 32)>;
+		};
+	};
+
+	cpu7_opp_table: opp-table-cpu7 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-peak-kBps = <(547000 * 4) (364800 * 32)>;
+		};
+
+		opp-633600000 {
+			opp-hz = /bits/ 64 <633600000>;
+			opp-peak-kBps = <(547000 * 4) (556800 * 32)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(547000 * 4) (806400 * 32)>;
+		};
+
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-peak-kBps = <(547000 * 4) (806400 * 32)>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 768000 */
+			opp-peak-kBps = <(768000 * 4) (998400 * 32)>;
+		};
+
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			/* TODO: ddr4 = 1017000, ddr5 = 768000 */
+			opp-peak-kBps = <(768000 * 4) (998400 * 32)>;
+		};
+
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <(1555000 * 4) (998400 * 32)>;
+		};
+
+		opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <(1555000 * 4) (1209600 * 32)>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <(1708000 * 4) (1209600 * 32)>;
+		};
+
+		opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			/* TODO: ddr4 = 1708000, ddr5 = 2092000 */
+			opp-peak-kBps = <(2092000 * 4) (1363200 * 32)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			/* TODO: ddr4 = 2092000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1497600 * 32)>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			/* TODO: ddr4 = 2092000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1497600 * 32)>;
+		};
+
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			/* TODO: ddr4 = 2092000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1516800 * 32)>;
+		};
+
+		opp-2496000000 {
+			opp-hz = /bits/ 64 <2496000000>;
+			/* TODO: ddr4 = 2092000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1516800 * 32)>;
+		};
+
+		opp-2707200000 {
+			opp-hz = /bits/ 64 <2707200000>;
+			/* TODO: ddr4 = 2092000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1804800 * 32)>;
+		};
+
+		opp-2918400000 {
+			opp-hz = /bits/ 64 <2918400000>;
+			/* TODO: ddr4 = 2092000, ddr5 = 3196000 */
+			opp-peak-kBps = <(3196000 * 4) (1804800 * 32)>;
+		};
+	};
+
 	pmu-a520 {
 		compatible = "arm,cortex-a520-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
@@ -2639,6 +2971,18 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		epss_l3: interconnect@17d90000 {
+			compatible = "qcom,milos-epss-l3", "qcom,epss-l3";
+			reg = <0x0 0x17d90000 0x0 0x1000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPLL0>;
+			clock-names = "xo",
+				      "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@17d91000 {
 			compatible = "qcom,milos-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0x0 0x17d91000 0x0 0x1000>,

-- 
2.55.0

