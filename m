From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 1/1] dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
Date: Tue, 21 Jul 2015 12:33:40 +0100
Message-ID: <1437478420-26419-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34332 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbGULdq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 07:33:46 -0400
Received: by wibud3 with SMTP id ud3so111515376wib.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2015 04:33:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com
Cc: kernel@stlinux.com, Lee Jones <lee.jones@linaro.org>

Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

Only submitting the binding document as requested by Viresh.

v2 => v3:
 - Using OPP v2
 - Moved OPPs out of the CPU node into their own one
 - Using generic 'opp-hz' property

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
new file mode 100644
index 0000000..a478eec
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
@@ -0,0 +1,77 @@
+Binding for ST's CPUFreq driver
+===============================
+
+Required properties [for working voltage scaling]:
+-------------------------------------------------
+
+Located in CPU's node:
+
+- st,syscfg		: Phandle to Major number register
+				First cell: offset to major number
+- st,syscfg-eng		: Phandle to Minor number and Pcode registers
+				First cell: offset to process code
+				Second cell: offset to minor number
+
+Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
+
+ - opp{1..N} 		: Each 'oppX' subnode will contain the following properties:
+  - opp-hz		: CPU frequency [Hz] for this OPP
+  - st,avs		: List of available voltages [uV] indexed by process code
+  - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
+  - st,substrate	: Substrate version this OPP is suitable for [0xFF means ALL]
+
+WARNING: The cpu0-opp-list will be provided by the bootloader.  Do not attempt to
+	 artificially synthesise the cpu0-opp-list node or any of its descendants.
+	 They are very platform specific and may damage the hardware if created
+	 incorrectly.
+
+Required properties [if voltage scaling properties are missing]:
+-------------------------------------------------------------------
+
+Located in CPU's node:
+
+- operating-points	: [See: ../power/opp.txt]
+
+Example [safe]:
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
+Example [unsafe]:
+----------------
+
+cpus {
+	cpu@0 {
+		st,syscfg		= <&syscfg [major_offset]>;
+		st,syscfg-eng   	= <&syscfg_eng [pcode_offset] [minor_offset]>;
+		operating-points-v2	= <&cpu0_opp_list>;
+	};
+};
+
+/* ############################################################ */
+/* # WARNING: Do not attempt to copy/replicate this node,     # */
+/* #          it is only to be supplied by the bootloader !!! # */
+/* ############################################################ */
+cpu0-opp-list {
+	compatible = "operating-points-v2-sti";
+	opp0 {
+		opp-hz		= <1200000000>;
+		st,avs		= <1110 1150 1100 1080 1040 1020 980 930>;
+		st,substrate	= <0xff>;
+		st,cuts		= <0xff>;
+	};
+	opp1 {
+		opp-hz		= <1500000000>;
+		st,avs		= <1200 1200 1200 1200 1170 1140 1100 1070>;
+		st,substrate	= <0xff>;
+		st,cuts		= <0x2>;
+	};
+};
-- 
1.9.1

