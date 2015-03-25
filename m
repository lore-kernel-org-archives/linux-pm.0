From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] : ARM cpuidle changes for 4.1
Date: Wed, 25 Mar 2015 10:05:23 +0100
Message-ID: <55127A53.8050206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33119 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbbCYJF1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 05:05:27 -0400
Received: by wgbcc7 with SMTP id cc7so19495064wgb.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 02:05:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>


Hi Rafael,

this PR request has the following content:

  - Removed the duplicate header inclusion (Daniel Lezcano).

  - Unified the generic cpuidle ARM driver with ARM64. Each platform ca=
n=20
now define their 'enable-method' in the DT thus allowing to split the=20
low level PM code from the generic cpuidle framework (Daniel Lezcano).

  - Allowed the generic ARM cpuidle driver to register per device and=20
prevent to register the cpuidle device when the underlying hardware is=20
misconfigured or an error occurs, thus allowing to fail gracefully=20
(Daniel Lezcano).

Thanks !

   -- Daniel

The following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f=
62d6:

   Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/4.1

for you to fetch changes up to 9a309d6fd213911321acbfe839e0bdb3a7a9f4bf=
:

   ARM: cpuidle: Document the code (2015-03-25 09:53:43 +0100)

----------------------------------------------------------------
Daniel Lezcano (8):
       ARM: cpuidle: Remove duplicate header inclusion
       ARM: cpuidle: Add a cpuidle ops structure to be used for DT
       ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 func=
tion
       ARM64: cpuidle: Rename cpu_init_idle to a common function name
       ARM64: cpuidle: Remove arm64 reference
       ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
       ARM: cpuidle: Register per cpuidle device
       ARM: cpuidle: Document the code

  arch/arm/include/asm/cpuidle.h                     |  23=20
+++++++++++++++++++++++
  arch/arm/kernel/cpuidle.c                          | 133=20
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  arch/arm/mach-davinci/cpuidle.c                    |   1 -
  arch/arm/mach-imx/cpuidle-imx6q.c                  |   1 -
  arch/arm/mach-imx/cpuidle-imx6sl.c                 |   1 -
  arch/arm/mach-imx/cpuidle-imx6sx.c                 |   1 -
  arch/arm/mach-omap2/cpuidle44xx.c                  |   1 -
  arch/arm/mach-s3c64xx/cpuidle.c                    |   2 +-
  arch/arm/mach-tegra/cpuidle-tegra20.c              |   1 -
  arch/arm/mach-tegra/cpuidle-tegra30.c              |   1 -
  arch/arm64/configs/defconfig                       |   2 +-
  arch/arm64/include/asm/cpuidle.h                   |   9 ++++++---
  arch/arm64/kernel/cpuidle.c                        |   2 +-
  drivers/cpuidle/Kconfig                            |   7 +------
  drivers/cpuidle/Kconfig.arm                        |  28=20
+++++++++++++++++++---------
  drivers/cpuidle/Kconfig.arm64                      |  13 ------------=
-
  drivers/cpuidle/Makefile                           |   5 +----
  drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} |  83=20
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------=
------------
  drivers/cpuidle/cpuidle-at91.c                     |   1 -
  drivers/cpuidle/cpuidle-exynos.c                   |   1 -
  drivers/cpuidle/cpuidle-kirkwood.c                 |   1 -
  drivers/cpuidle/cpuidle-ux500.c                    |   1 -
  drivers/cpuidle/cpuidle-zynq.c                     |   1 -
  include/asm-generic/vmlinux.lds.h                  |   2 ++
  24 files changed, 249 insertions(+), 72 deletions(-)
  delete mode 100644 drivers/cpuidle/Kconfig.arm64
  rename drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} (56%)

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

