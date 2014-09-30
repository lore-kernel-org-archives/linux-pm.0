From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Fix race conditions during boot
Date: Tue, 30 Sep 2014 14:43:49 +0200
Message-ID: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:37090 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbaI3MoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 08:44:06 -0400
Received: by mail-la0-f43.google.com with SMTP id gb8so10293165lab.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 05:44:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>

When there are more than one device in a PM domain these will obviously
be probed at different times. Depending on timing and the implemented
support for runtime PM in a driver/subsystem, genpd may be advised to
power off a PM domain after a successful probe sequence.
    
Ideally we should have relied on the driver/subsystem, through runtime
PM, to bring their device's PM domain into powered state prior doing
probing if such requirement exist.
    
Since this is not a common practice by drivers/subsystems, enforcing
such a change doesn't seem viable.
    
Instead, let's improve the situation, by preventing genpd from powering
off any of the PM domains until late_init. At that point genpd already
tries to power off unused PM domains, so it seems like a decent match.
    
Cases which can't be covered within the window of until late_init needs
to be adressed separately and likely through a more common long term
solution.


Ulf Hansson (4):
  PM / Domains: Remove pm_genpd_dev_need_restore() API
  ARM: exynos: Ensure PM domains are powered at initialization
  PM / Domains: Expect PM domains being powered at initialization
  PM / Domains: Enforce PM domains to stay powered during boot

 arch/arm/mach-exynos/pm_domains.c   |  7 ++++---
 arch/arm/mach-s3c64xx/pm.c          |  4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c |  2 +-
 arch/arm/mach-shmobile/pm-rmobile.c |  2 +-
 drivers/base/power/domain.c         | 42 ++++++++++++++++---------------------
 include/linux/pm_domain.h           |  7 +++----
 6 files changed, 29 insertions(+), 35 deletions(-)

-- 
1.9.1

