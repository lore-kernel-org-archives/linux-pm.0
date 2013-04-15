From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 0/2] ARM: at91: cpuidle: move driver to drivers/cpuidle
Date: Mon, 15 Apr 2013 15:29:56 +0200
Message-ID: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:51806 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab3DONaB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2013 09:30:01 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn17so1542886wib.12
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2013 06:30:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org

The number of cpuidle drivers is increasing more and more. Today we have
in total 24 drivers. A lot of the code is duplicated, at least for the
initialization. A work of consolidation has been done during this year:
 * a lot of code cleanup in all the drivers
 * time keeping is now part of the framework
 * timer broadcast is now part of the framework
 * a WFI state function for ARM is defined and used in the drivers
 * an init function has been proposed to factor out the initialization across
   the drivers (patchset pending)

What has been observed is a lot of code duplicationis, modification made in
the framework takes awhile before reaching the driver which uses an old API,
duplicate routine and bugs, etc ...

It appears the drivers are belonging to different trees, the cpuidle framework
is under linux-pm, the drivers are per SoC tree. The communication is made
difficult because of the different mailing lists where the cpuidle are
submitted.

After this work, it is time to prevent all these problems to occur again.

I propose to move the cpuidle drivers to the drivers/cpuidle directory, hence
having one single submission path for cpuidle in order to have the cpuidle
framework and the different drivers synced.

This series move the AT91 cpuidle driver under drivers/cpuidle. That does not
change the rule to have the patches acked-by the author of the driver.

Note the calxeda and kirkwood drivers are now in drivers/cpuidle.

Daniel Lezcano (2):
  ARM: at91: cpuidle: encapsulate the standby code
  ARM: at91: cpuidle: move the driver to drivers/cpuidle directory

 arch/arm/mach-at91/Makefile  |    1 -
 arch/arm/mach-at91/cpuidle.c |   66 ------------------------------------------
 arch/arm/mach-at91/pm.c      |    8 ++++-
 drivers/cpuidle/Makefile     |    1 +
 drivers/cpuidle/at91.c       |   55 +++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm/mach-at91/cpuidle.c
 create mode 100644 drivers/cpuidle/at91.c

-- 
1.7.9.5

