From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv4 00/18] device thermal limits represented in device tree nodes (v4)
Date: Thu, 26 Sep 2013 23:13:07 -0400
Message-ID: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello all,

Here is the continuation of work of representing hardware thermal properties
in device tree infrastructure. The present patch series is the fourth version
of this work. Previous versions were sent as RFCs and can be found here:
V3: 
RFCv2: http://lkml.org/lkml/2013/8/23/594
RFCv1: http://lkml.org/lkml/2013/7/22/319

Major difference from V3 is on the parser itself. I have updated the binding
documentation and improved the code accordingly to previous comments mainly
from Mark R. and Joe P.

The changes on hwmon drivers have been accepted by Guenter, and in this
series I am including his Acked-by, as I didn't change anything on that side.

I also found a bug while using all involved code built as modules, thus
I have reworked a bit the cooling device registration part. This is why
there are two new patches in this series (patches 02 and 04).

Tests were done, just like in V3, on TI OMAP4430, OMAP4460, OMAP5430 and DRA7,
although this series is not including the DRA7 part (I will be sending separately).

Thanks all who have been contributing reviewing this code.

All best,

Eduardo Valentin (18):
  thermal: allow registering without .get_temp
  thermal: core: allow binding via .bind when tzp is present
  thermal: introduce device tree parser
  thermal: core: introduce thermal_of_cooling_device_register
  thermal: cpu_cooling: introduce of_cpufreq_cooling_register
  cpufreq: cpufreq-cpu0: add dt node parsing for cooling device
    properties
  hwmon: lm75: expose to thermal fw via DT nodes
  hwmon: tmp102: expose to thermal fw via DT nodes
  thermal: ti-soc-thermal: use thermal DT infrastructure
  arm: dts: add omap4 CPU thermal data
  arm: dts: add omap4430 thermal data
  arm: dts: add omap4460 thermal data
  arm: dts: add cooling properties on omap4430 cpu node
  arm: dts: add cooling properties on omap4460 cpu node
  arm: dts: add omap5 GPU thermal data
  arm: dts: add omap5 CORE thermal data
  arm: dts: add omap5 thermal data
  arm: dts: add cooling properties on omap5 cpu node

 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |   7 +
 .../devicetree/bindings/thermal/thermal.txt        | 537 +++++++++++++
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |  41 +
 arch/arm/boot/dts/omap443x.dtsi                    |  15 +-
 arch/arm/boot/dts/omap4460.dtsi                    |  15 +-
 arch/arm/boot/dts/omap5-core-thermal.dtsi          |  28 +
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi           |  28 +
 arch/arm/boot/dts/omap5.dtsi                       |  15 +-
 drivers/cpufreq/Kconfig                            |   2 +-
 drivers/cpufreq/cpufreq-cpu0.c                     |  16 +
 drivers/hwmon/lm75.c                               |  35 +-
 drivers/hwmon/tmp102.c                             |  19 +
 drivers/thermal/Kconfig                            |  14 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/cpu_cooling.c                      |  56 +-
 drivers/thermal/of-thermal.c                       | 845 +++++++++++++++++++++
 drivers/thermal/thermal_core.c                     |  79 +-
 drivers/thermal/thermal_core.h                     |   9 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  77 +-
 include/dt-bindings/thermal/thermal.h              |  27 +
 include/linux/cpu_cooling.h                        |  25 +
 include/linux/thermal.h                            |  32 +-
 22 files changed, 1880 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal.txt
 create mode 100644 arch/arm/boot/dts/omap4-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-core-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-gpu-thermal.dtsi
 create mode 100644 drivers/thermal/of-thermal.c
 create mode 100644 include/dt-bindings/thermal/thermal.h

-- 
1.8.2.1.342.gfa7285d

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
