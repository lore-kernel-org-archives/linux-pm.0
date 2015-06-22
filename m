From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
Date: Mon, 22 Jun 2015 16:43:57 +0100
Message-ID: <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37953 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbbFVPoR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 11:44:17 -0400
Received: by wibdq8 with SMTP id dq8so79451954wib.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 08:44:15 -0700 (PDT)
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
new file mode 100644
index 0000000..cfa8952
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
@@ -0,0 +1,48 @@
+Binding for ST's CPUFreq driver
+===============================
+
+Required properties:
+-------------------
+- compatible		: Supported values are:
+				"st,stih407-cpufreq"
+
+Required properties [for working voltage scaling]:
+-------------------------------------------------
+
+Located in CPUFreq's node:
+
+- st,syscfg		: Phandle to Major number register
+				First cell: offset to major number
+- st,syscfg-eng		: Phandle to Minor number and Pcode registers
+				First cell: offset to process code
+				Second cell: offset to minor number
+
+Located in CPU's node:
+
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
+Example:
+-------
+
+cpufreq {
+	compatible	= "st,stih407-cpufreq";
+	st,syscfg	= <&syscfg [major_offset]>;
+	st,syscfg-eng	= <&syscfg_eng [pcode_offset] [minor_offset]>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
