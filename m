From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle ARM: new material for 3.13
Date: Mon, 07 Oct 2013 16:51:04 +0200
Message-ID: <5252CA58.700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38460 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab3JGOvE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2013 10:51:04 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so4928960wib.15
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2013 07:51:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Hi Rafael,

this pull request based on 3.12-rc4 contains the following changes:

- Daniel Lezcano converted the zynq cpuidle driver to the platform=20
driver and fixed a section mismatch for ux500

- Lorenzo Pieralisi fixed the Makefile format for ARM


Thanks
-- Daniel


The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe6=
80af:

Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 2c2b24d9c3e96d5cf974be4559a936e7f3b50225=
:

ARM: ux500: cpuidle: fix section mismatch (2013-10-07 16:47:07 +0200)

----------------------------------------------------------------
Daniel Lezcano (3):
ARM: zynq: cpuidle: Remove useless compatibility string
ARM: zynq: cpuidle: convert to platform driver
ARM: ux500: cpuidle: fix section mismatch

Lorenzo Pieralisi (1):
drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entr=
ies

arch/arm/mach-zynq/common.c | 6 ++++++
drivers/cpuidle/Kconfig.arm | 22 +++++++++++-----------
drivers/cpuidle/Makefile | 2 +-
drivers/cpuidle/cpuidle-ux500.c | 2 +-
drivers/cpuidle/cpuidle-zynq.c | 17 +++++++++++------
5 files changed, 30 insertions(+), 19 deletions(-)



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

