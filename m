From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/9] ARM: STi: STiH407: Provide CPU with clocking information
Date: Wed, 24 Jun 2015 14:59:01 +0100
Message-ID: <1435154348-28840-3-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33745 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbFXN7V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 09:59:21 -0400
Received: by wiwl6 with SMTP id l6so96287287wiw.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 06:59:19 -0700 (PDT)
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 2680ac7..fcab003 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -27,6 +27,10 @@
 					    1200000 0
 					    800000  0
 					    500000  0>;
+
+			clocks = <&clk_m_a9>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.9.1

