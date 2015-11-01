From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #1
Date: Sun, 1 Nov 2015 12:30:37 -0800
Message-ID: <20151101203036.GA9793@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-ther=
mal linus

to receive Thermal-SoC Management updates for v4.4-rc1 with top-most

8fb2b9ac2aadd6d87f89071c2c85f8c12b41c943:

  thermal: underflow bug in imx_set_trip_temp() (2015-10-30 11:35:50 -0=
700)

on top of commit 3225031fbeb1e32b269a82eccd815128267a4bfe:

  Merge branch 'stable' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/cmetcalf/linux-tile (2015-09-28 12:27:18 -0400)

Specifics:
- OMAP3 support on TI SoC thermal driver.
- Devfreq cooling device. This comes with a change in OPP layer Acked b=
y Viresh K.
- Fixes on IMX, Armada, and Rockchip thermal drivers.
- This branch has been compiled tested and boot tested by Linaro bot [1=
,2].

Apologize for the silent in the past weeks. I had two trips in a row an=
d had
limited Internet access. Please let me know if I missed your patch. I t=
ried
checking those that were idling in the mailing list and cleaning the pa=
tchwork,
but I might have missed some. So, still catching up.

There are still new drivers to be reviewed and merged which is on my ra=
dar. I
will be sending updates still to see if they can make this merge window=
=2E For
now I would say they will be scheduled for the next one.

[1] - http://kernelci.org/build/evalenti/kernel/v4.3-rc3-52-g8fb2b9ac2a=
ad/
[2] - http://kernelci.org/boot/all/job/evalenti/kernel/v4.3-rc3-52-g8fb=
2b9ac2aad/

BR,

Eduardo Valentin
----------------------------------------------------------------
Bai Ping (1):
      thermal: imx: register irq handler later in probe

Dan Carpenter (1):
      thermal: underflow bug in imx_set_trip_temp()

Dmitry Torokhov (2):
      thermal: rockchip: fix handling of invalid readings
      thermal: rockhip: fix setting thermal shutdown polarity

Eduardo Valentin (1):
      thermal: ti-soc-thermal: add OMAP36xx support

Javi Merino (2):
      PM / OPP: get the voltage for all OPPs
      devfreq_cooling: add trace information

Nadav Haklai (1):
      thermal: armada: Fix possible overflow in the Armada 380 thermal =
sensor formula

Pavel Machek (1):
      ti-soc-thermal: implement omap3 support

=D8rjan Eide (1):
      thermal: Add devfreq cooling

 .../devicetree/bindings/thermal/ti_soc_thermal.txt |  14 +
 drivers/base/power/opp.c                           |   4 +-
 drivers/thermal/Kconfig                            |  14 +
 drivers/thermal/Makefile                           |   3 +
 drivers/thermal/armada_thermal.c                   |   6 +-
 drivers/thermal/devfreq_cooling.c                  | 569 +++++++++++++=
++++++++
 drivers/thermal/imx_thermal.c                      |  21 +-
 drivers/thermal/rockchip_thermal.c                 |  38 +-
 drivers/thermal/ti-soc-thermal/Kconfig             |  15 +
 drivers/thermal/ti-soc-thermal/Makefile            |   1 +
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 176 +++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  14 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  11 +
 include/linux/devfreq_cooling.h                    |  81 +++
 include/trace/events/thermal.h                     |  53 ++
 15 files changed, 985 insertions(+), 35 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
 create mode 100644 include/linux/devfreq_cooling.h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
