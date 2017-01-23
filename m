From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/12] PM / OPP: Use kref and move away from RCU locking
Date: Mon, 23 Jan 2017 10:11:40 +0530
Message-ID: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36449 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdAWEmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 23:42:00 -0500
Received: by mail-pg0-f54.google.com with SMTP id t6so41346509pgt.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2017 20:42:00 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This series is based over the other OPP series [1] which is ready to be
merged and is fully reviewed.

In this series, 11 out of 12 patches have Reviewed-by from Stephen. Only
the 7th patch hasn't got any of those.

@Stephen: Can you see if you can do a generic review of it as well?
Thanks for continuing to review this stuff.

The RCU locking isn't well suited for the OPP core. The RCU locking fits
better for reader heavy stuff, while the OPP core have at max one or two
readers only at a time.

Over that, it was getting very confusing the way RCU locking was used
within the OPP core. The individual OPPs are mostly well handled, i.e.
for an update a new structure was created and then that replaced the
older one. But the OPP tables were updated directly all the time from
various parts of the core. Though they were mostly used from within RCU
locked region, they didn't had much to do with RCU and were governed by
the mutex instead.

And that mixed with the 'opp_table_lock' has made the core even more
confusing.

Similar concerns were shared by Stephen Boyd earlier [2].

This patchset simplifies the locking in OPP core to great extent using
Kernel reference counting mechanism along with per OPP table mutex.
And finally it gets rid of RCU locking as well.

Each and every patch of this series is individually:
- build tested
- boot tested with cpufreq-dt.ko module. Insmod and rmmod to make sure
  the OPPs and the OPP tables are getting freed.

More testing is also done by various build and boot bots for last few
days. And they reported lots of issues (both build and boot time) that
helped making this series more robust:
- Kernel CI (Linaro)
- Fengguang Wu's bot (Intel)

V1->V2:
- Minor documentation fixes pointed out by Stephen
- dev_pm_opp_put() is called only if OPP is valid (in the 7th patch)

--
viresh

[1] https://marc.info/?l=linux-kernel&m=148334828916156&w=2
[2] https://marc.info/?l=linux-kernel&m=147742717527548&w=2

Viresh Kumar (12):
  PM / OPP: Add per OPP table mutex
  PM / OPP: Add 'struct kref' to OPP table
  PM / OPP: Return opp_table from dev_pm_opp_set_*() routines
  PM / OPP: Take reference of the OPP table while adding/removing OPPs
  PM / OPP: Use dev_pm_opp_get_opp_table() instead of _add_opp_table()
  PM / OPP: Add 'struct kref' to struct dev_pm_opp
  PM / OPP: Update OPP users to put reference
  PM / OPP: Take kref from _find_opp_table()
  PM / OPP: Move away from RCU locking
  PM / OPP: Simplify _opp_set_availability()
  PM / OPP: Simplify dev_pm_opp_get_max_volt_latency()
  PM / OPP: Update Documentation to remove RCU specific bits

 Documentation/power/opp.txt          |  52 +-
 arch/arm/mach-omap2/pm.c             |   5 +-
 drivers/base/power/opp/core.c        | 888 +++++++++++------------------------
 drivers/base/power/opp/cpu.c         |  66 +--
 drivers/base/power/opp/of.c          |  94 +---
 drivers/base/power/opp/opp.h         |  31 +-
 drivers/clk/tegra/clk-dfll.c         |  17 +-
 drivers/cpufreq/exynos5440-cpufreq.c |   5 +-
 drivers/cpufreq/imx6q-cpufreq.c      |  10 +-
 drivers/cpufreq/mt8173-cpufreq.c     |   8 +-
 drivers/cpufreq/omap-cpufreq.c       |   4 +-
 drivers/cpufreq/sti-cpufreq.c        |  13 +-
 drivers/devfreq/devfreq.c            |  14 +-
 drivers/devfreq/exynos-bus.c         |  14 +-
 drivers/devfreq/governor_passive.c   |   4 +-
 drivers/devfreq/rk3399_dmc.c         |  16 +-
 drivers/devfreq/tegra-devfreq.c      |   4 +-
 drivers/thermal/cpu_cooling.c        |  11 +-
 drivers/thermal/devfreq_cooling.c    |  15 +-
 include/linux/pm_opp.h               |  48 +-
 20 files changed, 433 insertions(+), 886 deletions(-)

-- 
2.7.1.410.g6faf27b

