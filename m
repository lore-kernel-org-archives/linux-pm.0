From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 0/5] ARM: at91: sama5d2_xplained: Put the PMIC a proper suspend state
Date: Fri,  2 Dec 2016 14:57:11 +0100
Message-ID: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60756 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760749AbcLBN5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 08:57:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Mark, Raphael,

This is just an attempt at solving the suspend/resume issue I have on
an atmel platform: the PMIC is only supporting partial "suspend state"
definition (enable/disable output), and we need to setup the remaining
parts (voltage and mode) at runtime.

Mark, this patch is trying to implement what I understood of our
discussion on IRC a few days back. As you might have noticed, I'm not
yet understanding all the subtleties of the PM hooks, or how they are
implemented in the regulator framework.
This patch is clearly not meant to be applied as is, it's more something
to start a discussion, so feel free to point my misunderstanding or the
flaws in my approach.

Thanks,

Boris

Boris Brezillon (5):
  regulator: Extend the power-management APIs
  regulator: Document the regulator-allow-changes-at-runtime DT property
  ARM: at91: Call regulator_suspend_{begin, end}() in the platform pm
    ops
  regulator: act8945: Implement PM functionalities
  ARM: at91/dt: sama5d2_xplained: Add proper regulator states for
    suspend-to-mem

 .../devicetree/bindings/regulator/regulator.txt    |   5 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  32 +++
 arch/arm/mach-at91/pm.c                            |   4 +-
 drivers/regulator/act8945a-regulator.c             | 255 +++++++++++++++++-
 drivers/regulator/core.c                           | 291 +++++++++++++++++++++
 drivers/regulator/of_regulator.c                   |   4 +
 include/linux/regulator/driver.h                   |  29 ++
 include/linux/regulator/machine.h                  |  13 +
 8 files changed, 631 insertions(+), 2 deletions(-)

-- 
2.7.4

