From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V2 0/4] Add i.MX System Controller thermal driver support
Date: Wed, 28 Nov 2018 05:58:07 +0000
Message-ID: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Aisheng DONG <aisheng.dong@nxp.com>, Andy Gross <andy.gross@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "arnd@arndb.de" <arnd@arndb.de>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>, "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net" <olof@lixom.net>, bjorn.andersson@linaro.org
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and thermal sensors etc..

This patch adds i.MX system controller thermal driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to get each thermal sensor's temperature,
it supports multiple sensors which are passed from device tree,
please see the binding doc for details.

Note that this patch set is based on [V4,5/5] defconfig: arm64: add imx8qxp=
 support,
https://patchwork.kernel.org/patch/10677315/

Anson Huang (4):
  dt-bindings: thermal: add binding doc for i.MX system controller
    thermal driver
  thermal: imx_sc: add i.MX system controller thermal support
  defconfig: arm64: add i.MX system controller thermal support
  ARM64: dts: imx: add i.MX8QXP thermal support

 .../devicetree/bindings/thermal/imx-sc-thermal.txt |  33 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |  27 +++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |  11 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx_sc_thermal.c                   | 201 +++++++++++++++++=
++++
 6 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-sc-therma=
l.txt
 create mode 100644 drivers/thermal/imx_sc_thermal.c

--=20
2.7.4
