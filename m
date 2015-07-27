From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
Date: Mon, 27 Jul 2015 16:20:29 +0100
Message-ID: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33557 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbbG0PUh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 11:20:37 -0400
Received: by wicmv11 with SMTP id mv11so143872068wic.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 08:20:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com, Lee Jones <lee.jones@linaro.org>

Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

Changelog:
 - Using OPP-v2
 - Moved (and linked) a bunch of documentation to ../power/

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
new file mode 100644
index 0000000..79add9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
@@ -0,0 +1,40 @@
+Binding for ST's CPUFreq driver
+===============================
+
+Frequency Scaling only
+----------------------
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
+Located in CPU's node:
+
+- operating-points-v2-sti	: [See ../power/opp-st.txt]
+
+Example [unsafe]
+----------------
+
+cpus {
+	cpu@0 {
+		operating-points-v2	= <[OPP list phandle]>;
+	};
+};
+
+For an example of an OPP list, see ../power/opp-st.txt.
-- 
1.9.1

