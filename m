From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/8] ARM: STi: STiH407: Provide generic (safe) DVFS configuration
Date: Mon, 22 Jun 2015 16:43:50 +0100
Message-ID: <1434987837-24212-2-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38808 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbbFVPoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 11:44:06 -0400
Received: by wibdq8 with SMTP id dq8so79447322wib.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 08:44:05 -0700 (PDT)
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

You'll notice that the voltage cell is populated with 0's.  Voltage
information is very platform specific, even depends on 'cut' and
'substrate' versions.  Thus it is left blank for a generic (safe)
implementation.  If other nodes/properties are provided by the
bootloader, the ST CPUFreq driver will over-ride these generic
values.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index be201aa..2680ac7 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -22,11 +22,21 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 	};
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
