From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #1
Date: Tue, 3 Nov 2015 03:10:28 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092633A909D91@SHSMSX101.ccr.corp.intel.com>
References: <20151101203036.GA9793@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151101203036.GA9793@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Monday, November 02, 2015 4:31 AM
> To: Zhang, Rui
> Cc: Linux ACPI; Linux PM; LKML
> Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #1
> Importance: High
>=20
> Hello Rui,
>=20
> Please pull from
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-th=
ermal
> linus
>=20
> to receive Thermal-SoC Management updates for v4.4-rc1 with top-most
>=20
> 8fb2b9ac2aadd6d87f89071c2c85f8c12b41c943:
>=20
>   thermal: underflow bug in imx_set_trip_temp() (2015-10-30 11:35:50 =
-0700)
>=20
> on top of commit 3225031fbeb1e32b269a82eccd815128267a4bfe:
>=20
>   Merge branch 'stable' of
> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile (20=
15-09-28
> 12:27:18 -0400)
>=20
> Specifics:
> - OMAP3 support on TI SoC thermal driver.
> - Devfreq cooling device. This comes with a change in OPP layer Acked=
 by
> Viresh K.
> - Fixes on IMX, Armada, and Rockchip thermal drivers.
> - This branch has been compiled tested and boot tested by Linaro bot =
[1,2].
>=20
> Apologize for the silent in the past weeks. I had two trips in a row =
and had
> limited Internet access. Please let me know if I missed your patch. I=
 tried
> checking those that were idling in the mailing list and cleaning the =
patchwork,
> but I might have missed some. So, still catching up.
>=20
> There are still new drivers to be reviewed and merged which is on my =
radar. I
> will be sending updates still to see if they can make this merge wind=
ow. For
> now I would say they will be scheduled for the next one.
>=20
> [1] - http://kernelci.org/build/evalenti/kernel/v4.3-rc3-52-g8fb2b9ac=
2aad/
> [2] - http://kernelci.org/boot/all/job/evalenti/kernel/v4.3-rc3-52-
> g8fb2b9ac2aad/
>=20
> BR,
>=20
> Eduardo Valentin
> ----------------------------------------------------------------
> Bai Ping (1):
>       thermal: imx: register irq handler later in probe
>=20
> Dan Carpenter (1):
>       thermal: underflow bug in imx_set_trip_temp()
>=20
> Dmitry Torokhov (2):
>       thermal: rockchip: fix handling of invalid readings
>       thermal: rockhip: fix setting thermal shutdown polarity
>=20
> Eduardo Valentin (1):
>       thermal: ti-soc-thermal: add OMAP36xx support
>=20
> Javi Merino (2):
>       PM / OPP: get the voltage for all OPPs

I think this patch should be took by Rafael, right?

Thanks,
Rui

>       devfreq_cooling: add trace information
>=20
> Nadav Haklai (1):
>       thermal: armada: Fix possible overflow in the Armada 380 therma=
l sensor
> formula
>=20
> Pavel Machek (1):
>       ti-soc-thermal: implement omap3 support
>=20
> =D8rjan Eide (1):
>       thermal: Add devfreq cooling
>=20
>  .../devicetree/bindings/thermal/ti_soc_thermal.txt |  14 +
>  drivers/base/power/opp.c                           |   4 +-
>  drivers/thermal/Kconfig                            |  14 +
>  drivers/thermal/Makefile                           |   3 +
>  drivers/thermal/armada_thermal.c                   |   6 +-
>  drivers/thermal/devfreq_cooling.c                  | 569
> +++++++++++++++++++++
>  drivers/thermal/imx_thermal.c                      |  21 +-
>  drivers/thermal/rockchip_thermal.c                 |  38 +-
>  drivers/thermal/ti-soc-thermal/Kconfig             |  15 +
>  drivers/thermal/ti-soc-thermal/Makefile            |   1 +
>  .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 176 +++++++
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  14 +
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  11 +
>  include/linux/devfreq_cooling.h                    |  81 +++
>  include/trace/events/thermal.h                     |  53 ++
>  15 files changed, 985 insertions(+), 35 deletions(-)  create mode 10=
0644
> drivers/thermal/devfreq_cooling.c  create mode 100644 drivers/thermal=
/ti-
> soc-thermal/omap3-thermal-data.c
>  create mode 100644 include/linux/devfreq_cooling.h
