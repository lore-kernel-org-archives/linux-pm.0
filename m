From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] ARM: cpuidle: at91 platform driver conversion
Date: Thu, 17 Oct 2013 00:09:05 +0200
Message-ID: <525F0E81.5030002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:52273 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759708Ab3JPWJJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 18:09:09 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so1373846wes.37
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2013 15:09:07 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@sisk.pl" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>


Hi Rafael,

This pull request based on the pm-cpuidle branch contains the following=
:

  * Daniel Lezcano converted cpuidle to a platform_driver for at91. The=
=20
standby callback is stored in the platform_device's data field as a=20
callback for the driver, so the pm specific code and the backend driver=
=20
have no more dependency. Each SoC init function fills the right callbac=
k=20
at init time. As there are no more dependency, we can move the driver i=
n=20
the drivers/cpuidle directory.

  * Jean-Christophe Plagnol-Villard and Nicolas Ferre made a cleanup on=
=20
top of the patch described above and fixed up the ddr standby callback=20
so more SoC are supported. Even if the modifications are in the=20
mach-at91 directory, they asked these patches to be included through th=
e=20
PM tree as they depend on the platform_driver conversion.

Thanks !
   -- Daniel


The following changes since commit ac9f1cc2ce1a178696763444f2a2f8a0ec66=
1772:

   Merge back earlier cpuidle material for v3.13. (2013-10-07 21:31:21=20
+0200)

are available in the git repository at:


   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 6b625891c6b541080bdaad97bcb82bd9ecd9e44b=
:

   ARM: AT91: DT: pm: Select ram controller standby based on DT=20
(2013-10-16 23:51:47 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
       ARM: at91: cpuidle: Convert to platform driver
       ARM: at91: cpuidle: Move driver to drivers/cpuidle

Jean-Christophe PLAGNIOL-VILLARD (2):
       ARM: AT91: pm: Factorize standby function
       ARM: AT91: DT: pm: Select ram controller standby based on DT

  arch/arm/mach-at91/Makefile                        |    1 -
  arch/arm/mach-at91/at91rm9200.c                    |    2 +
  arch/arm/mach-at91/at91sam9260.c                   |    2 +
  arch/arm/mach-at91/at91sam9261.c                   |    2 +
  arch/arm/mach-at91/at91sam9263.c                   |    2 +
  arch/arm/mach-at91/at91sam9g45.c                   |    2 +
  arch/arm/mach-at91/at91sam9rl.c                    |    2 +
  arch/arm/mach-at91/pm.c                            |   27 ++++++---
  arch/arm/mach-at91/pm.h                            |   59=20
++++++++++----------
  arch/arm/mach-at91/setup.c                         |   14 ++++-
  drivers/cpuidle/Kconfig.arm                        |    7 +++
  drivers/cpuidle/Makefile                           |    1 +
  .../cpuidle.c =3D> drivers/cpuidle/cpuidle-at91.c    |   29 +++++----=
-
  13 files changed, 93 insertions(+), 57 deletions(-)
  rename arch/arm/mach-at91/cpuidle.c =3D> drivers/cpuidle/cpuidle-at91=
=2Ec=20
(79%)


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

