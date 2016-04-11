From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v9 20/20] ARM: dts: Add support of bus frequency for
 exynos4412-trats/odroidu3
Date: Mon, 11 Apr 2016 12:57:58 +0900
Message-ID: <1460347078-15175-21-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1460347078-15175-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

THis patch adds the bus device tree nodes for both MIF (Memory) and INT
(Internal) block to enable the bus frequency.

The DMC bus is parent device in MIF block using VDD_MIF and the LEFTBUS
bus is parent device in INT block using VDD_INT.

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
[m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
Tested-by: Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
Tested-by: Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 47 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts         | 47 +++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index b4983cbc4f8c..2015f10071f9 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -109,6 +109,53 @@
 	};
 };
 
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
+&bus_acp {
+	devfreq = <&bus_dmc>;
+	status = "okay";
+};
+
+&bus_c2c {
+	devfreq = <&bus_dmc>;
+	status = "okay";
+};
+
+&bus_leftbus {
+	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	vdd-supply = <&buck3_reg>;
+	status = "okay";
+};
+
+&bus_rightbus {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_display {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_fsys {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_peri {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_mfc {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index dce3cebe0606..9f3fb9a7f5f4 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -289,6 +289,53 @@
 	status = "okay";
 };
 
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
+&bus_acp {
+	devfreq = <&bus_dmc>;
+	status = "okay";
+};
+
+&bus_c2c {
+	devfreq = <&bus_dmc>;
+	status = "okay";
+};
+
+&bus_leftbus {
+	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	vdd-supply = <&buck3_reg>;
+	status = "okay";
+};
+
+&bus_rightbus {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_display {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_fsys {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_peri {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_mfc {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
