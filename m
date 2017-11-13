From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Mon, 13 Nov 2017 16:46:40 +0100
Message-ID: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The generic problem this series is trying to solve, is that for some bus types
and PM domains, it's not sufficient to only check the return value from
device_may_wakeup(), to fully understand how to treat the device during system
suspend.

One particular case that suffers from this, is the generic PM domain (aka genpd)
and that is taken care of in the final change in this series.

The special case this series address, is to enable drivers to instruct bus types
and PM domains, that the device need to remain in its current power state in
case it should be able to generate wakeup signals during system suspend. This is
done by an opt-in method, however bus types and PM domains that has additional
knowledge about devices' wakeup settings may still override the setting.

Geert Uytterhoeven, has been working on some related problems for some Renesas
SoCs [1], to be able to properly configure WakeOnLAN, for some ethernet
devices/drivers, which are used together with genpd. My intent is that this
series enables a solution for those problems.

[1]
https://www.spinics.net/lists/linux-renesas-soc/msg19319.html 

Changes in v2:
	- See change logs for each patch.


Ulf Hansson (3):
  PM / core: Re-factor some code dealing with parents in
    __device_suspend()
  PM / core: Add IN_BAND_WAKEUP driver flag
  PM / Domains: Take wakeup_path_in_band status flag into account

 Documentation/driver-api/pm/devices.rst | 11 +++++++++++
 drivers/base/power/domain.c             |  6 ++++--
 drivers/base/power/main.c               | 35 ++++++++++++++++++++++-----------
 include/linux/pm.h                      |  6 ++++++
 4 files changed, 44 insertions(+), 14 deletions(-)

-- 
2.7.4
