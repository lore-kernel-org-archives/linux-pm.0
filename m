From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
Date: Mon, 22 Jun 2015 16:43:53 +0100
Message-ID: <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37050 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbFVPoL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 11:44:11 -0400
Received: by wicgi11 with SMTP id gi11so79498460wic.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 08:44:09 -0700 (PDT)
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index f48767e..f57fd83 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -98,6 +98,11 @@
 		ranges;
 		compatible = "simple-bus";
 
+		cpufreq {
+			compatible = "st,stih407-cpufreq";
+			st,syscfg = <&syscfg_core 0x8e0>;
+		};
+
 		restart {
 			compatible = "st,stih407-restart";
 			st,syscfg = <&syscfg_sbc_reg>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
