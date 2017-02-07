From: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: imx: update snvs-poweroff mask
Date: Tue,  7 Feb 2017 17:56:06 +0200
Message-ID: <1486482966-4497-2-git-send-email-guy.shapiro@mobi-wize.com>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCNJ5VGR4ANRB7G447CAKGQERMCNDEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Cc: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Make the syscon-poweroff driver change only the shutdown bits on the
SNVS_LP control register.

This change fixes an issue with the RTC wakeup alarm, that was
previously disabled during power off.

Signed-off-by: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx7s.dtsi   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f..06984b1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -757,6 +757,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd87..58717d3 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -644,6 +644,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f3330..be142ed5 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -698,6 +698,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 39845a7..505d24e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -606,6 +606,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8ff2cbdd..aadb1134 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -529,6 +529,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 				};
 
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
