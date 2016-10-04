From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/8] PM / OPP: Multiple regulator support
Date: Tue,  4 Oct 2016 17:26:42 +0530
Message-ID: <cover.1475581665.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Some platforms (like TI) have complex DVFS configuration for CPU
devices, where multiple regulators are required to be configured to
change DVFS state of the device. This was explained well by Nishanth
earlier [1].

Some thoughts went into it few months back but then it all got lost. I
am trying to get that back on track with this thread.

One of the major complaints around multiple regulators case was that the
DT isn't responsible in any way to represent the ordering in which
multiple supplies need to be programmed, before or after frequency
change. It was considered in this patch and such information is left to
the platform specific OPP driver now, which can register its own
opp_set_rate() callback with the OPP core and the OPP core will then
call it during DVFS.

The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
and code to pass values for multiple regulators and verified that they
are all properly read by the kernel (using debugfs interface).

Though more testing on real (TI) platforms would be useful.

This is rebased over: pm-4.9-rc1 tag in the PM tree.

--
viresh

[1] https://marc.info/?l=linux-pm&m=145684495832764&w=2

Viresh Kumar (8):
  PM / OPP: Reword binding supporting multiple regulators per device
  PM / OPP: Don't use OPP structure outside of rcu protected section
  PM / OPP: Manage supply's voltage/current in a separate structure
  PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()
  PM / OPP: Add infrastructure to manage multiple regulators
  PM / OPP: Separate out _generic_opp_set_rate()
  PM / OPP: Allow platform specific custom opp_set_rate() callbacks
  PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()

 Documentation/devicetree/bindings/opp/opp.txt |  25 +-
 drivers/base/power/opp/core.c                 | 501 ++++++++++++++++++++------
 drivers/base/power/opp/debugfs.c              |  48 ++-
 drivers/base/power/opp/of.c                   | 104 ++++--
 drivers/base/power/opp/opp.h                  |  36 +-
 drivers/cpufreq/cpufreq-dt.c                  |   9 +-
 include/linux/pm_opp.h                        |  33 +-
 7 files changed, 574 insertions(+), 182 deletions(-)

-- 
2.7.1.410.g6faf27b
