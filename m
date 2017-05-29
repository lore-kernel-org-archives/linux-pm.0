From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/4] add UniPhier thermal support
Date: Mon, 29 May 2017 18:15:41 +0900
Message-ID: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

This patch series adds support for thermal monitor implemented on UniPhier LD20
and PXs2 SoCs. This driver supports temperature monitoring and alert function.

Kunihiko Hayashi (4):
  thermal: uniphier: add UniPhier thermal driver
  dt-bindings: thermal: add binding documentation for UniPhier thermal
    monitor
  ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for
    PXs2
  arm64: dts: uniphier: add nodes of thermal monitor and thermal zone
    for LD20

 .../bindings/thermal/uniphier-thermal.txt          |  54 +++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |  21 ++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |  21 ++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   6 +
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  25 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   6 +
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/uniphier_thermal.c                 | 390 +++++++++++++++++++++
 9 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
 create mode 100644 drivers/thermal/uniphier_thermal.c

-- 
2.7.4
