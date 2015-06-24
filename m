From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 4/9] ARM: STi: STiH407: Provide CPU with a means to look-up Major number
Date: Wed, 24 Jun 2015 14:59:03 +0100
Message-ID: <1435154348-28840-5-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:35978 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbFXN7X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 09:59:23 -0400
Received: by wguu7 with SMTP id u7so37110205wgu.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 06:59:22 -0700 (PDT)
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

This is used for CPU Frequency Scaling.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index f48767e..838f1c3 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -32,6 +32,7 @@
 			clock-names = "cpu";
 			clock-latency = <100000>;
 			cpu0-supply = <&pwm_regulator>;
+			st,syscfg = <&syscfg_core 0x8e0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.9.1

