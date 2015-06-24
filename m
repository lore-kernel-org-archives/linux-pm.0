From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 8/9] dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
Date: Wed, 24 Jun 2015 14:59:07 +0100
Message-ID: <1435154348-28840-9-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34361 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbFXN73 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 09:59:29 -0400
Received: by wgqq4 with SMTP id q4so37162573wgq.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 06:59:28 -0700 (PDT)
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
new file mode 100644
index 0000000..e871a9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
@@ -0,0 +1,72 @@
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
+- st,opp-list		: Bootloader provided node containing one or more 'opp@X' sub-nodes
+ - opp@{1..X} 		: Each 'opp@X' subnode will contain the following properties:
+  - st,avs		: List of available voltages [uV] indexed by process code
+  - st,freq		: CPU frequency [Hz] for this OPP
+  - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
+  - st,substrate	: Substrate version this OPP is suitable for [0xFF means ALL]
+
+WARNING: The st,opp-list will be provided by the bootloader.  Do not attempt to
+	 artificially synthesise the st,opp-list node or any of its descendants.
+	 They are very platform specific and may damage the hardware if created
+	 incorrectly.
+
+Required properties [if the voltage scaling properties are missing]:
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
+		st,syscfg       = <&syscfg [major_offset]>;
+		st,syscfg-eng   = <&syscfg_eng [pcode_offset] [minor_offset]>;
+
+		/* ########################################################### */
+		/* # WARNING: Do not attempt to copy/replicate this node !!! # */
+		/* ########################################################### */
+		st,opp-list {
+			opp0 {
+				st,avs = <1110 1150 1100 1080 1040 1020 980 930>;
+				st,freq = <1200000>;
+				st,substrate = <0xff>;
+				st,cuts = <0xff>;
+			};
+			opp1 {
+				st,avs = <1200 1200 1200 1200 1170 1140 1100 1070>;
+				st,freq = <1500000>;
+				st,substrate = <0xff>;
+				st,cuts = <0x2>;
+			};
+		};
+	};
+};
-- 
1.9.1

