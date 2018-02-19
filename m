From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 02/13] ARM: dtsi: axp22x: add node for ADC
Date: Mon, 19 Feb 2018 13:47:25 +0100
Message-ID: <b6fd4d32e99d343f85eac484ae9c7c7133fcc471.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Reply-To: quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBCEPVPKAKGQEGQ2DDAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds a DT node for the ADC of the PMIC so that there can be
consumers of its IIO channels declaring their consumptions via DT.

Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 87fb08e..65a07a6 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -57,6 +57,11 @@
 		status = "disabled";
 	};
 
+	axp_adc: adc {
+		compatible = "x-powers,axp221-adc";
+		#io-channel-cells = <1>;
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp221-battery-power-supply";
 		status = "disabled";
-- 
git-series 0.9.1
