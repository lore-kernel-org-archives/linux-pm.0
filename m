From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/4] PM / core: Extend behaviour for wakeup paths
Date: Fri, 29 Dec 2017 12:36:59 +0100
Message-ID: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Changes in v2:
	- Added a new patch at the end to warn about users calling
	device_wakeup_enable() during any system wide PM phases, suggested by
	Rafael.
	- No other changes in the code, but only improved change logs, according
	to comments from Rafael.

Notes for v2:
	- I am working on a new version of Geert series[2], as to give the
	complete picture of how the new DPM_FLAG_WAKEUP_PATH can be used.

The generic problem this series intends to solve, is that for some PM domains,
especially genpd, the current information in the dev->power.wakeup_path, is not
sufficient for a PM domain to fully understand how to treat devices in the
wakeup path during system suspend.

Particularly this applies to resources being consumed by the driver that has
configured system wakeup settings for its device. Currently the PM domain lacks
information about these consumed resources, which means it may decide to power
of their corresponding device and its attached PM domain, while they actually
would need to stay powered to allow system wakeup signals to be delivered.

Geert Uytterhoeven, has been working on these kind of problems for some Renesas
SoCs and there have been lots of discussions around this. After some
consideration I have dropped my first attempt [1] on how to address these
problems, so here's hopefully a better one.

So far I haven't included any patches for dealing with the "OUT_BAND_WAKEUP"
thingy, but I suggest we do that in a second separate step, since it's not
immediately need to fix the problems for the Renesas SoCs.

Geert's Renesas series [2], needs to be re-based on top of this series to make
it convert to use the new DPM_FLAG_WAKEUP_PATH flag, which is introduced in
this series. That leads to a tree-wise-dependency, so perhaps Rafael can host
an immutable branch the Renesas tree can pull in. Let's see.

[1]
https://www.spinics.net/lists/linux-renesas-soc/msg20122.html

[2]
https://www.spinics.net/lists/linux-renesas-soc/msg19947.html

Ulf Hansson (4):
  PM / core: Assign the wakeup_path status flag in __device_prepare()
  PM / core: Add WAKEUP_PATH driver flag
  PM / Domains: Take WAKEUP_PATH driver flag into account in genpd
  PM / core: Print warn if device gets enabled as wakeup source during
    sleep

 drivers/base/power/domain.c | 8 ++++++--
 drivers/base/power/main.c   | 9 ++++++++-
 drivers/base/power/wakeup.c | 4 ++++
 include/linux/pm.h          | 8 ++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.7.4
