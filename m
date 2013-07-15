From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: pull request for cpuidle/arm
Date: Tue, 16 Jul 2013 01:28:25 +0200
Message-ID: <51E48599.8000104@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40460 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab3GOX22 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 19:28:28 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so3480950wiw.17
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 16:28:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

The following changes since commit 68ba7add2f6e216227c3a3d225316987624b=
71c8:

Merge branch 'pm-cpufreq-next' into linux-next (2013-07-15 14:12:32 +02=
00)

are available in the git repository at:


git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 6a814a059092c3934d13c19c34123827d0e1dc95=
:

ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
(2013-07-16 00:55:05 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
ARM: davinci: cpuidle: Fix target residency
ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle

Linus Walleij (2):
ARM: ux500: cpuidle: Instantiate the driver from platform device
ARM: ux500: cpuidle: Remove pointless include

arch/arm/mach-davinci/cpuidle.c | 2 +-
arch/arm/mach-ux500/Makefile | 1 -
drivers/cpuidle/Kconfig.arm | 8 ++++++++
drivers/cpuidle/Makefile | 1 +
=2E../cpuidle.c =3D> drivers/cpuidle/cpuidle-ux500.c | 19 +++++++++++--=
------
drivers/mfd/db8500-prcmu.c | 4 ++++
6 files changed, 25 insertions(+), 10 deletions(-)
rename arch/arm/mach-ux500/cpuidle.c =3D> drivers/cpuidle/cpuidle-ux500=
=2Ec
(90%)

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


