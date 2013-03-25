From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/9] ARM: CPUFreq: Move drivers arch/arm/ -> drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:31 +0530
Message-ID: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset tries to move all CPUFreq drivers for ARM platforms from arch=
/arm
to drivers/cpufreq directory.

This series is dependent (rebased of) on following patches:

http://www.spinics.net/lists/arm-kernel/msg232540.html
https://lkml.org/lkml/2013/3/24/151

I want this series to go through Rafael's tree due to dependencies and so w=
ant
Ack's by respective maintainers.

These are applied here for people looking to test them:

http://git.linaro.org/gitweb?p=3Dpeople/vireshk/linux.git;a=3Dshortlog;h=3D=
refs/heads/cpufreq-move-drivers

Viresh Kumar (9):
  cpufreq: ARM: Arrange drivers in alphabetical order
  cpufreq: tegra: Move driver to drivers/cpufreq
  cpufreq: davinci: move cpufreq driver to drivers/cpufreq
  cpufreq: imx: move cpufreq driver to drivers/cpufreq
  cpufreq: integrator: move cpufreq driver to drivers/cpufreq
  cpufreq: pxa3xx: move cpufreq driver to drivers/cpufreq
  cpufreq: pxa2xx: move cpufreq driver to drivers/cpufreq
  cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
  cpufreq: sa11x0: move cpufreq driver to drivers/cpufreq

 arch/arm/Kconfig                                   |  79 ---------
 arch/arm/mach-davinci/Makefile                     |   1 -
 arch/arm/mach-imx/Makefile                         |   1 -
 arch/arm/mach-imx/mxc.h                            |   6 +-
 arch/arm/mach-integrator/Makefile                  |   1 -
 arch/arm/mach-pxa/Makefile                         |   6 -
 arch/arm/mach-pxa/include/mach/generic.h           |   1 +
 arch/arm/mach-s3c24xx/Kconfig                      |  66 +++----
 arch/arm/mach-s3c24xx/Makefile                     |   6 -
 arch/arm/mach-s3c24xx/{ =3D> include/mach}/s3c2412.h |   0
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |   2 +-
 arch/arm/mach-sa1100/Kconfig                       |  26 +--
 arch/arm/mach-sa1100/Makefile                      |   3 -
 arch/arm/mach-sa1100/include/mach/generic.h        |   1 +
 arch/arm/mach-tegra/Makefile                       |   1 -
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h |  10 +-
 arch/arm/plat-samsung/include/plat/cpu-freq.h      |   6 +-
 drivers/cpufreq/Kconfig.arm                        | 191 +++++++++++++++--=
----
 drivers/cpufreq/Makefile                           |  24 ++-
 .../cpufreq.c =3D> drivers/cpufreq/davinci-cpufreq.c |   2 -
 .../cpufreq.c =3D> drivers/cpufreq/imx-cpufreq.c     |   7 +-
 .../cpu.c =3D> drivers/cpufreq/integrator-cpufreq.c  |   2 -
 .../cpufreq/pxa2xx-cpufreq.c                       |   2 -
 .../cpufreq/pxa3xx-cpufreq.c                       |   5 +-
 .../cpufreq/s3c2410-cpufreq.c                      |   0
 .../cpufreq/s3c2412-cpufreq.c                      |   3 +-
 .../cpufreq/s3c2440-cpufreq.c                      |   0
 .../cpufreq/s3c24xx-cpufreq-debugfs.c              |   0
 .../cpufreq.c =3D> drivers/cpufreq/s3c24xx-cpufreq.c |   0
 .../cpufreq/sa1100-cpufreq.c                       |   3 +-
 .../cpufreq/sa1110-cpufreq.c                       |   3 +-
 .../cpu-tegra.c =3D> drivers/cpufreq/tegra-cpufreq.c |   2 -
 include/linux/cpufreq/imx.h                        |  10 ++
 33 files changed, 223 insertions(+), 247 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/generic.h
 rename arch/arm/mach-s3c24xx/{ =3D> include/mach}/s3c2412.h (100%)
 create mode 100644 arch/arm/mach-sa1100/include/mach/generic.h
 rename arch/arm/mach-davinci/cpufreq.c =3D> drivers/cpufreq/davinci-cpufre=
q.c (99%)
 rename arch/arm/mach-imx/cpufreq.c =3D> drivers/cpufreq/imx-cpufreq.c (99%=
)
 rename arch/arm/mach-integrator/cpu.c =3D> drivers/cpufreq/integrator-cpuf=
req.c (99%)
 rename arch/arm/mach-pxa/cpufreq-pxa2xx.c =3D> drivers/cpufreq/pxa2xx-cpuf=
req.c (99%)
 rename arch/arm/mach-pxa/cpufreq-pxa3xx.c =3D> drivers/cpufreq/pxa3xx-cpuf=
req.c (98%)
 rename arch/arm/mach-s3c24xx/cpufreq-s3c2410.c =3D> drivers/cpufreq/s3c241=
0-cpufreq.c (100%)
 rename arch/arm/mach-s3c24xx/cpufreq-s3c2412.c =3D> drivers/cpufreq/s3c241=
2-cpufreq.c (99%)
 rename arch/arm/mach-s3c24xx/cpufreq-s3c2440.c =3D> drivers/cpufreq/s3c244=
0-cpufreq.c (100%)
 rename arch/arm/mach-s3c24xx/cpufreq-debugfs.c =3D> drivers/cpufreq/s3c24x=
x-cpufreq-debugfs.c (100%)
 rename arch/arm/mach-s3c24xx/cpufreq.c =3D> drivers/cpufreq/s3c24xx-cpufre=
q.c (100%)
 rename arch/arm/mach-sa1100/cpu-sa1100.c =3D> drivers/cpufreq/sa1100-cpufr=
eq.c (99%)
 rename arch/arm/mach-sa1100/cpu-sa1110.c =3D> drivers/cpufreq/sa1110-cpufr=
eq.c (99%)
 rename arch/arm/mach-tegra/cpu-tegra.c =3D> drivers/cpufreq/tegra-cpufreq.=
c (99%)
 create mode 100644 include/linux/cpufreq/imx.h

--=20
1.7.12.rc2.18.g61b472e


