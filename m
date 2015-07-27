From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Mon, 27 Jul 2015 16:20:30 +0100
Message-ID: <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

These OPPs are used in ST's CPUFreq implementation.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

Changelog:
 - None, new patch

 Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/opp-st.txt

diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b/Documentation/devicetree/bindings/power/opp-st.txt
new file mode 100644
index 0000000..6eb2a91
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/opp-st.txt
@@ -0,0 +1,76 @@
+STMicroelectronics OPP (Operating Performance Points) Bindings
+--------------------------------------------------------------
+
+Frequency Scaling only
+----------------------
+
+Located in CPU's node:
+
+- operating-points	: [See: ./opp.txt]
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
+Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
+
+- compatible		: Should be "operating-points-v2-sti"
+- opp{1..N} 		: Each 'oppX' subnode will contain the following properties:
+ - opp-hz		: CPU frequency [Hz] for this OPP [See: ./opp.txt]
+ - st,avs		: List of available voltages [uV] indexed by process code
+ - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
+ - st,substrate		: Substrate version this OPP is suitable for [0xFF means ALL]
+- st,syscfg		: Phandle to Major number register
+				First cell: offset to major number
+- st,syscfg-eng		: Phandle to Minor number and Pcode registers
+				First cell: offset to process code
+				Second cell: offset to minor number
+
+WARNING: The opp{1..N} nodes will be provided by the bootloader.  Do not attempt to
+	 artificially synthesise the opp{1..N} nodes or any of their descendants.
+	 They are very platform specific and may damage the hardware if created
+	 incorrectly.
+
+Example [unsafe]
+----------------
+
+cpus {
+	cpu@0 {
+		operating-points-v2	= <&cpu0_opp_list>;
+	};
+};
+
+/* ############################################################ */
+/* # WARNING: Do not attempt to copy/replicate this node,     # */
+/* #          it is only to be supplied by the bootloader !!! # */
+/* ############################################################ */
+cpu0-opp-list {
+	compatible	= "operating-points-v2-sti";
+	st,syscfg	= <&syscfg [major_offset]>;
+	st,syscfg-eng   = <&syscfg_eng [pcode_offset] [minor_offset]>;
+
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
