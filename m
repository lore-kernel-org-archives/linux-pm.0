From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RESEND] cpuidle for ARM pull request
Date: Tue, 16 Jul 2013 14:04:21 +0200
Message-ID: <51E536C5.1020609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36008 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab3GPMEY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2013 08:04:24 -0400
Received: by mail-wg0-f51.google.com with SMTP id e11so514723wgh.18
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2013 05:04:23 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>


Hi,

The first PR was against the linux-pm-next tree including the patch:

"cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"

This patch has been dropped in the meantime.

Here is a new PR where my tree has been rebased against linux-pm-next
and adding the patch mentioned above.

As stated by Rafael, I will handle the ARM specific patches from now.

The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbefd=
89bf:

  Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06 +=
0200)

are available in the git repository at:


  git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f06=
:

  ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
(2013-07-16 13:57:24 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
      ARM: davinci: cpuidle: Fix target residency
      ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle

Linus Walleij (2):
      ARM: ux500: cpuidle: Instantiate the driver from platform device
      ARM: ux500: cpuidle: Remove pointless include

Sahara (1):
      cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq

 arch/arm/mach-davinci/cpuidle.c                    |    2 +-
 arch/arm/mach-ux500/Makefile                       |    1 -
 drivers/cpuidle/Kconfig                            |   20 +++++-------=
--
 drivers/cpuidle/Kconfig.arm                        |   29
++++++++++++++++++++
 drivers/cpuidle/Makefile                           |    9 ++++--
 .../cpuidle.c =3D> drivers/cpuidle/cpuidle-ux500.c   |   19 +++++++---=
---
 drivers/mfd/db8500-prcmu.c                         |    4 +++
 7 files changed, 58 insertions(+), 26 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig.arm
 rename arch/arm/mach-ux500/cpuidle.c =3D> drivers/cpuidle/cpuidle-ux50=
0.c
(90%)


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

