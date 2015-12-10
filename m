From: Lee Jones <lee.jones@linaro.org>
Subject: [PICKME 2/2] dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
Date: Thu, 10 Dec 2015 09:42:17 +0000
Message-ID: <1449740537-12619-3-git-send-email-lee.jones@linaro.org>
References: <1449740537-12619-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37729 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbbLJJoZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 04:44:25 -0500
Received: by wmww144 with SMTP id w144so16633358wmw.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2015 01:44:24 -0800 (PST)
In-Reply-To: <1449740537-12619-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
new file mode 100644
index 0000000..d91a02a
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
@@ -0,0 +1,91 @@
+Binding for ST's CPUFreq driver
+===============================
+
+ST's CPUFreq driver attempts to read 'process' and 'version' attributes
+from the SoC, then supplies the OPP framework with 'prop' and 'supported
+hardware' information respectively.  The framework is then able to read
+the DT and operate in the usual way.
+
+For more information about the expected DT format [See: ../opp/opp.txt].
+
+Frequency Scaling only
+----------------------
+
+No vendor specific driver required for this.
+
+Located in CPU's node:
+
+- operating-points		: [See: ../power/opp.txt]
+
+Example [safe]
+--------------
+
+cpus {
+	cpu@0 {
+				 /* kHz     uV   */
+		operating-points = <1500000 0
+				    1200000 0
+				    800000  0
+				    500000  0>;
+	};
+};
+
+Dynamic Voltage and Frequency Scaling (DVFS)
+--------------------------------------------
+
+This requires the ST CPUFreq driver to supply 'process' and 'version' info.
+
+Located in CPU's node:
+
+- operating-points-v2		: [See ../power/opp.txt]
+
+Example [unsafe]
+----------------
+
+cpus {
+	cpu@0 {
+		operating-points-v2	= <&cpu0_opp_table>;
+	};
+};
+
+cpu0_opp_table: opp_table {
+	compatible = "operating-points-v2";
+
+	/* ############################################################### */
+	/* # WARNING: Do not attempt to copy/replicate these nodes,      # */
+	/* #          they are only to be supplied by the bootloader !!! # */
+	/* ############################################################### */
+	opp0 {
+		/*			   Major       Minor       Substrate */
+		/*			   2           all         all       */
+		opp-supported-hw	= <0x00000004  0xffffffff  0xffffffff>;
+		opp-hz			= /bits/ 64 <1500000000>;
+		clock-latency-ns	= <10000000>;
+
+		opp-microvolt-pcode0	= <1200000>;
+		opp-microvolt-pcode1	= <1200000>;
+		opp-microvolt-pcode2	= <1200000>;
+		opp-microvolt-pcode3	= <1200000>;
+		opp-microvolt-pcode4	= <1170000>;
+		opp-microvolt-pcode5	= <1140000>;
+		opp-microvolt-pcode6	= <1100000>;
+		opp-microvolt-pcode7	= <1070000>;
+	};
+
+	opp1 {
+		/*			   Major       Minor       Substrate */
+		/*			   all         all         all       */
+		opp-supported-hw	= <0xffffffff  0xffffffff  0xffffffff>;
+		opp-hz			= /bits/ 64 <1200000000>;
+		clock-latency-ns	= <10000000>;
+
+		opp-microvolt-pcode0	= <1110000>;
+		opp-microvolt-pcode1	= <1150000>;
+		opp-microvolt-pcode2	= <1100000>;
+		opp-microvolt-pcode3	= <1080000>;
+		opp-microvolt-pcode4	= <1040000>;
+		opp-microvolt-pcode5	= <1020000>;
+		opp-microvolt-pcode6	= <980000>;
+		opp-microvolt-pcode7	= <930000>;
+	};
+};
-- 
1.9.1

