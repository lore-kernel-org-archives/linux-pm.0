From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.4-rc1
Date: Wed, 11 Nov 2015 10:18:35 +0800
Message-ID: <1447208315.2770.15.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55452 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbbKKCSj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Nov 2015 21:18:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.4-rc1 with
top-most commit 7c5b2759bf8c2cbc60e5560c72cf51a2628f6d30:

  Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc' into
next (2015-11-06 09:32:10 +0800)

on top of commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)


Specifics:

- Implement generic devfreq cooling mechanism through frequency
reduction for devices using devfreq. From: =C3=98rjan Eide and Javi Mer=
ino.

- Introduce OMAP3 support on TI SoC thermal driver. From: Pavel Mack an=
d
Eduardo Valentin.

- A bounch of small fixes on devfreq_cooling, Exynos, IMX, Armada, and
Rockchip thermal drivers.

thanks,
rui

----------------------------------------------------------------

Bai Ping (1):
      thermal: imx: register irq handler later in probe

Caesar Wang (2):
      dt-bindings: rockchip-thermal: Add the pinctrl states in this
document
      thermal: rockchip: support the sleep pinctrl state to avoid
glitches in s2r

Dan Carpenter (2):
      thermal: underflow bug in imx_set_trip_temp()
      devfreq_cooling: return on allocation failure

Dmitry Torokhov (2):
      thermal: rockchip: fix handling of invalid readings
      thermal: rockhip: fix setting thermal shutdown polarity

Eduardo Valentin (1):
      thermal: ti-soc-thermal: add OMAP36xx support

Javi Merino (4):
      PM / OPP: get the voltage for all OPPs
      devfreq_cooling: add trace information
      thermal: devfreq_cooling: use a thermal_cooling_device for
register and unregister
      thermal: devfreq_cooling: Make power a u64

Krzysztof Kozlowski (5):
      thermal: exynos: Fix unbalanced regulator disable on probe failur=
e
      thermal: exynos: Fix first temperature read after registering
sensor
      thermal: exynos: Use IS_ERR() because regulator cannot be NULL
      thermal: exynos: Remove unneeded semicolon
      thermal: exynos: Directly return 0 instead of using local ret
variable

Nadav Haklai (1):
      thermal: armada: Fix possible overflow in the Armada 380 thermal
sensor formula

Olaf Hering (1):
      tools/thermal: tmon: use pkg-config also for CFLAGS

Pavel Machek (1):
      ti-soc-thermal: implement omap3 support

Rasmus Villemoes (1):
      linux/thermal.h: rename KELVIN_TO_CELSIUS to
DECI_KELVIN_TO_CELSIUS

Srinivas Pandruvada (1):
      thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86 thermal

Vaishali Thakkar (1):
      thermal: cpu_cooling: Remove usage of devm functions

Zhang Rui (3):
      Merge branch 'linus' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into thermal-soc
      Merge branch 'linus' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into thermal-soc
      Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc'
into next

=C3=98rjan Eide (1):
      thermal: Add devfreq cooling

 .../bindings/thermal/rockchip-thermal.txt          |  11 +-
 .../devicetree/bindings/thermal/ti_soc_thermal.txt |  14 +
 drivers/acpi/thermal.c                             |  12 +-
 drivers/base/power/opp.c                           |   4 +-
 drivers/platform/x86/asus-wmi.c                    |   2 +-
 drivers/platform/x86/intel_menlow.c                |   8 +-
 drivers/thermal/Kconfig                            |  17 +
 drivers/thermal/Makefile                           |   3 +
 drivers/thermal/armada_thermal.c                   |   6 +-
 drivers/thermal/cpu_cooling.c                      |   8 +-
 drivers/thermal/devfreq_cooling.c                  | 573
+++++++++++++++++++++
 drivers/thermal/imx_thermal.c                      |  21 +-
 drivers/thermal/rockchip_thermal.c                 |  42 +-
 drivers/thermal/samsung/exynos_tmu.c               |  68 +--
 drivers/thermal/ti-soc-thermal/Kconfig             |  15 +
 drivers/thermal/ti-soc-thermal/Makefile            |   1 +
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 176 +++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  14 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  11 +
 include/linux/devfreq_cooling.h                    |  81 +++
 include/linux/thermal.h                            |   8 +-
 include/trace/events/thermal.h                     |  53 ++
 tools/thermal/tmon/Makefile                        |   3 +
 23 files changed, 1065 insertions(+), 86 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
 create mode 100644 include/linux/devfreq_cooling.h


