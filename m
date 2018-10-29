From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v7 6/6] arm64: dts: add LX2160ARDB board support
Date: Mon, 29 Oct 2018 08:58:01 +0000
Message-ID: <1540759926-3641-7-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Sriram Dash <sriram.dash@nxp.com>, Horia Geanta <horia.geanta@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, Ying Zhang <ying.zhang22455@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
List-Id: linux-pm@vger.kernel.org

LX2160A reference design board (RDB) is a high-performance
computing, evaluation, and development platform with LX2160A
SoC.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++=
++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 86e18ad..445b72b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
new file mode 100644
index 0000000..6481e5f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2160ARDB
+//
+// Copyright 2018 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model =3D "NXP Layerscape LX2160ARDB";
+	compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
+
+	aliases {
+		crypto =3D &crypto;
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "MC34717-3.3VSB";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&crypto {
+	status =3D "okay";
+};
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status =3D "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width =3D <8>;
+	status =3D "okay";
+};
+
+&i2c0 {
+	status =3D "okay";
+
+	i2c-mux@77 {
+		compatible =3D "nxp,pca9547";
+		reg =3D <0x77>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		i2c@2 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x2>;
+
+			power-monitor@40 {
+				compatible =3D "ti,ina220";
+				reg =3D <0x40>;
+				shunt-resistor =3D <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x3>;
+
+			temperature-sensor@4c {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4c>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+
+			temperature-sensor@4d {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4d>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status =3D "okay";
+
+	rtc@51 {
+		compatible =3D "nxp,pcf2129";
+		reg =3D <0x51>;
+		// IRQ10_B
+		interrupts =3D <0 150 0x4>;
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
+
+&usb0 {
+	status =3D "okay";
+};
+
+&usb1 {
+	status =3D "okay";
+};
--=20
2.7.4
