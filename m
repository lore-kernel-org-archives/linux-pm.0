From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v7 0/5] Rockchip soc thermal driver
Date: Sun, 28 Sep 2014 18:38:08 +0800
Message-ID: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: dmitry.torokhov@gmail.com, arnd@arndb.de, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This series patchs tested on rk3288 SDK board and pinky-v1 board.
I believe the driver can be used on the rk3288-eve board.

Add this driver, The system can reset the entire chip when
the thermal temperture at 125C, In case of overing 125C
when tha hardware shorting,The chip will shutdown.

Changes in v7:
        - fix get data->clk=0 when in probe() function.
	- fix some style code.
	- modify dts,main add rk3xxx-cpu-thermal.dtsi

Changes in v6:
        * address comments from Tomeu Vizoso.
        - use thermal's generic framework.

Changes in v5:
        * address comments from Eduardo Valentin,rui.zhang and Heiko Stubner:
        - with BIT() macro
        - manage clocks in suspend/resume.
	- license is fixed as GPLv2.
	- #include "thermal_core.h"->#include <linux/thermal.h>
	- use the generic trip-points.the hw-shut-temp isn't generic trip-points.
	- The method of binding and unbinding be fixed.
	- The pin-name tsadc->otp_out

Changes in v4:
        * address comments from Jonathan Cameron,huangtao and zhaoyifeng:
        - this series thermal driver still be put in driver/thermal/
        - modify the thermal driver description.

Changes in v3:(add dts configure)
        * address comments from Dmitry Torokhov and Arnd Bergmann:
        - fix clock-names in rockchip-thermal.txt
        - remove rockchip_thermal_control() in rockchip_set_mode()
        - fix some code style.
        - add dts configure.

Changes in v2:
        * address comments from Heiko Stubner:
        - fix dt-bindings in rockchip-thermal.txt
        - remove Author mark
        - rename TSADC_XXX->TSADCV2_XXX,it eill ready to merge compatible other SoCs.
        - fix a identation
        - remove clk_set_rate(),it's no necessary.
        - fix the SIMPLE_DEV_PM_OPS() function  style.

Caesar Wang (5):
  thermal: rockchip: add driver for thermal
  dt-bindings: document Rockchip thermal
  ARM: dts: add RK3xxx CPU Thermal data
  ARM: dts: add main Thermal info to rk3288
  ARM: dts: enable Thermal on rk3288-evb board

 .../bindings/thermal/rockchip-thermal.txt          |  32 ++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   5 +
 arch/arm/boot/dts/rk3288.dtsi                      |  24 +
 arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi          |  32 ++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rockchip_thermal.c                 | 608 +++++++++++++++++++++
 7 files changed, 712 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.9.1


