From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/9] PM / Domains: Don't leave unused PM domains powered after ->probe()
Date: Fri, 13 Mar 2015 16:43:40 +0100
Message-ID: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:41124 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088AbbCMPoF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:05 -0400
Received: by labmn12 with SMTP id mn12so23480586lab.8
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:02 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Commit "PM / Domains: Power on the PM domain right after attach completes",
helped to make sure a PM domain stays powered during ->probe(), but unfurtunate
it also caused a regression.

In those scenario where the driver leaves its device in runtime PM suspended
state, and don't bring it to active state during ->probe(), could cause an
unsued PM domain to stay powered.

The intent from this patchset, is to fix this regression and to rework the
solution of how to make sure PM domains stays powered during ->probe().

This patchset is a rebased version of the below earlier posted patchset.
[PATCH v3 0/9] PM / Domains: Fix race conditions during boot

You may find that patchset from here:
http://marc.info/?l=linux-pm&m=141320895122707&w=2

>From that patchset, there is a "scenario 5" described, which actually is a more
detailed description the regression commit "PM / Domains: Power on the PM domain
right after attach completes" was about to introduce.


Ulf Hansson (9):
  PM / Domains: Add dev_pm_domain_get|put() APIs
  PM / Domains: Enable genpd to support ->get|put() callbacks
  amba: Keep PM domain powered during ->probe()
  drivercore / platform: Keep PM domain powered during ->probe()
  i2c: core: Keep PM domain powered during ->probe()
  spi: core: Keep PM domain powered during ->probe()
  mmc: core: Attach PM domain prior probing of SDIO func driver
  mmmc: core: Keep PM domain powered during ->probe() of SDIO func
    driver
  Revert "PM / Domains: Power on the PM domain right after attach
    completes"

 drivers/amba/bus.c          |  8 ++++++++
 drivers/base/platform.c     |  7 +++++++
 drivers/base/power/common.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c | 27 +++++++++++++++++++++++++--
 drivers/i2c/i2c-core.c      |  7 +++++++
 drivers/mmc/core/sdio_bus.c | 21 +++++++++++++++++----
 drivers/spi/spi.c           |  7 +++++++
 include/linux/pm.h          |  2 ++
 include/linux/pm_domain.h   |  5 +++++
 9 files changed, 118 insertions(+), 6 deletions(-)

-- 
1.9.1

