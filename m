From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/8] ARM: STi: STiH407: Link CPU with its voltage supply
Date: Mon, 22 Jun 2015 16:43:52 +0100
Message-ID: <1434987837-24212-4-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Used for Voltage Scaling using CPUFreq.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index fcab003..f48767e 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -31,6 +31,7 @@
 			clocks = <&clk_m_a9>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			cpu0-supply = <&pwm_regulator>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
