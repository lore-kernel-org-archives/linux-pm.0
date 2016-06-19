From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH 0/4] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 support
Date: Sun, 19 Jun 2016 10:31:29 +0700
Message-ID: <57661211.7010900@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org

This patchset adds new thermal sensor driver to support 3 sensors
found in R-Car Gen3 series.

It has been decided to create new driver, instead of using the existing
thermal driver due to many differences in HW setting flows, the method
to calculate temperatures value and some newly supported features.

The new driver can support both polling mode and interrupt mode.
It has been tested with R-Car H3.

This driver is developed based on early work of Hien Dang and Thao Nguyen.
All comments are welcome.

Khiem Nguyen (4):
  thermal: rcar_gen3_thermal: Document the R-Car Gen3 thermal bindings
  thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver support
  arm64: dts: r8a7795: Add R-Car Gen3 thermal support
  arm64: defconfig: Enable R-Car Gen3 thermal support

 .../bindings/thermal/rcar-gen3-thermal.txt         |  79 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  86 ++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rcar_gen3_thermal.c                | 524 +++++++++++++++++++++
 6 files changed, 701 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

-- 
1.9.1
