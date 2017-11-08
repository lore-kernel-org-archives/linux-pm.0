From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Wed,  8 Nov 2017 16:15:31 +0100
Message-ID: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46759 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbdKHPPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 10:15:44 -0500
Received: by mail-lf0-f68.google.com with SMTP id g70so3570646lfl.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Nov 2017 07:15:44 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The generic problem this series is trying to solve, is that for some bus types
and PM domains, it's not sufficient to only check the return value from
device_may_wakeup(), to fully understand how to treat the device during system
suspend.

One particular case that suffers from this, is the generic PM domain (aka genpd)
and that is taken care of in the final change in this series.

The special case this series address, is to enable drivers to instruct bus types
and PM domains, that the device need to stay powered in case wakeup signals
is enabled for it.

Geert Uytterhoeven, has been working on some related problems for some Renesas
SoCs [1], to be able to properly configure WakeOnLAN, for some ethernet
devices/drivers, which are used together with genpd. My intent is that this
series enables a solution for those problems.

[1]
https://www.spinics.net/lists/linux-renesas-soc/msg19319.html 


Ulf Hansson (3):
  PM / core: Re-factor some code dealing with parents in
    __device_suspend()
  PM / core: Add WAKEUP_POWERED driver flag
  PM / Domains: Take WAKEUP_POWERED driver flag into account

 Documentation/driver-api/pm/devices.rst | 12 ++++++++++++
 drivers/base/power/domain.c             | 14 ++++++++++----
 drivers/base/power/main.c               | 33 +++++++++++++++++++++------------
 include/linux/pm.h                      |  5 +++++
 4 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.7.4
