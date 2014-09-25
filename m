From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle ARM new material for 3.18
Date: Thu, 25 Sep 2014 14:10:38 +0200
Message-ID: <5424063E.4020500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36184 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaIYMKl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 08:10:41 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so9246479wiv.11
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2014 05:10:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net >> Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>


[resent because of the missing Cc]

Hi Rafael,

this pull request contains the following changes:

  * Lorenzo Pieralisi implemented a framework to initialize the ARM=20
cpuidle drivers with the DT. As an example, it provided a couple of=20
drivers using it: arm64 and big little. The former one is a new driver=20
while the latter is a change. There was also a patch for Exynos allowin=
g=20
to use this framework but as it depends on a change in Samsung's tree, =
I=20
postponed this patch until the change is visible after the merge. The=20
set of changes depends on some other changes made in the ARM64 tree, fo=
r=20
this reason a shared branch is used. This is why there is a merge from=20
arm64 in my pull request. I believe we already used this procedure.

  * Kevin Hilman added the compatible string for the exynos 5800 in the=
 DT

Thanks !

   -- Daniel


The following changes since commit 0f33be009b89d2268e94194dc4fd01a7851b=
6d51:

   Linux 3.17-rc6 (2014-09-21 15:43:02 -0700)

are available in the git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/3.18

for you to fetch changes up to d2e5c871ed8a250f7ee1fe34dd52ed5757363fba=
:

   drivers: cpuidle: initialize big.LITTLE driver through DT (2014-09-2=
5=20
10:52:21 +0200)

----------------------------------------------------------------
Daniel Lezcano (1):
       Merge branch 'for-next/cpuidle' of=20
git://git.kernel.org/.../arm64/linux into cpuidle/3.18

Kevin Hilman (1):
       cpuidle: big.LITTLE: add Exynos5800 compatible string

Lorenzo Pieralisi (7):
       Documentation: arm: define DT idle states bindings
       arm64: kernel: refactor the CPU suspend API for retention states
       arm64: kernel: introduce cpu_init_idle CPU operation
       arm64: add PSCI CPU_SUSPEND based cpu_suspend support
       drivers: cpuidle: implement DT based idle states infrastructure
       drivers: cpuidle: CPU idle ARM64 driver
       drivers: cpuidle: initialize big.LITTLE driver through DT

  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
  .../devicetree/bindings/arm/idle-states.txt        | 679=20
+++++++++++++++++++++
  Documentation/devicetree/bindings/arm/psci.txt     |  14 +-
  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  23 +
  arch/arm64/include/asm/cpu_ops.h                   |   3 +
  arch/arm64/include/asm/cpuidle.h                   |  13 +
  arch/arm64/include/asm/suspend.h                   |   1 +
  arch/arm64/kernel/Makefile                         |   1 +
  arch/arm64/kernel/cpuidle.c                        |  31 +
  arch/arm64/kernel/psci.c                           | 104 ++++
  arch/arm64/kernel/sleep.S                          |  47 +-
  arch/arm64/kernel/suspend.c                        |  48 +-
  drivers/cpuidle/Kconfig                            |   8 +
  drivers/cpuidle/Kconfig.arm                        |   1 +
  drivers/cpuidle/Kconfig.arm64                      |  14 +
  drivers/cpuidle/Makefile                           |   5 +
  drivers/cpuidle/cpuidle-arm64.c                    | 133 ++++
  drivers/cpuidle/cpuidle-big_little.c               |  20 +
  drivers/cpuidle/dt_idle_states.c                   | 213 +++++++
  drivers/cpuidle/dt_idle_states.h                   |   7 +
  20 files changed, 1340 insertions(+), 33 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/arm/idle-states.=
txt
  create mode 100644 arch/arm64/include/asm/cpuidle.h
  create mode 100644 arch/arm64/kernel/cpuidle.c
  create mode 100644 drivers/cpuidle/Kconfig.arm64
  create mode 100644 drivers/cpuidle/cpuidle-arm64.c
  create mode 100644 drivers/cpuidle/dt_idle_states.c
  create mode 100644 drivers/cpuidle/dt_idle_states.h


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

