From: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v15 0/5] Rockchip soc thermal driver
Date: Tue, 28 Oct 2014 16:51:22 +0800
Message-ID: <1414486287-25498-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cjf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series patchs tested on rk3288 SDK board and pinky-v1,v2 board.
I believe the driver can be used on the rk3288-evb board.

Add this driver, The system will shutdown when
the thermal temperture over 120C.If for some reason we are unable to
shut it down in orderly fashion (kernel is stuck holding a lock or similar)
then hardware will reset it.

Changes in v15:
	* address comments from Dmitry Torokhov.
	- enable TSHUT move into rk_tsadcv2_tshut_temp().
	- drop the id argument in rk_tsadcv2_control().

Changes in v14:
	* address comments from Dmitry Torokhov.
	- adjust-alarm-rate-depending-on-clock.
	- 0001-rockchip-thermal-do-not-register-cpufreq-cooling-dev.

Changes in v13:
	- add cooling-maps for cpu-thermal.
	- put tshut polarity in device tree.

Changes in v12:
	* address comments from Dmitry Torokhov and Vladimir Zapolskiy.
	- split-sensor-handling.
	- rename-rockchip_tsadc_platform_data.

Changes in v11:
	* address comments from Vladimir Zapolskiy.
	- fix cpufreq_cooling_unregister() to put in correct position.
	- fix "data->chn",at least can get valid Tsensor temp.

Changes in v10:
	* address comments from Doug Anderson.
	- fix TSHUT polarity,ensure support TSHUT.
	- add the decription for rk_tsadcv2_initialize().

Changes in v9:
	* address comments from Dmitry Torokhov.
	- fix some style be defined
	- remove some unused code.
	- clk_disable_unprepare->clk_disable in suspend()

Changes in v8:
	* address comments from Dmitry Torokhov and Doug Anderson.
	- add three Teperture Sensors.
	- support CRU and GPIO reset chip.
	- rename rk3xxx-cpu-thermal.dtsi as rk3288-thermal.dtsi
	- alarm-temp via set_trips() callback
	- remove "reset-gpios"

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
  ARM: dts: add RK3288 Thermal data
  ARM: dts: add main Thermal info to rk3288
  ARM: dts: enable Thermal on rk3288-evb board

 .../bindings/thermal/rockchip-thermal.txt          |  45 ++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   5 +
 arch/arm/boot/dts/rk3288-thermal.dtsi              |  58 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  23 +
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rockchip_thermal.c                 | 628 +++++++++++++++++++++
 7 files changed, 769 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
