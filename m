From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Wed, 26 Oct 2016 12:02:55 +0530
Message-ID: <cover.1477463128.git.viresh.kumar@linaro.org>
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

Dave Gerlach has already tested it on the real TI platforms and it works
well for him.

This is rebased over: linux-next branch in the PM tree.

V2->V3:
- The last patch is new
- Removed a debug leftover pr_info() message
- Renamed few names as s/set_rate/set_opp
- Removed a TODO comment (as it is done now with this series)
- created struct for min_uV and max_uV
- kerneldoc comments for structures in pm_opp.h
- s/const char */const char * const
- use kasprintf()
- Some more minor reformatting
- More Ack/RBY tags added

V1->V2:
- Ack from Rob for 1st patch
- Moved the supplies structure to pm_opp.h (Dave)
- Fixed an compilation warning.

--
viresh

[1] https://marc.info/?l=linux-pm&m=145684495832764&w=2

Viresh Kumar (9):
  PM / OPP: Reword binding supporting multiple regulators per device
  PM / OPP: Don't use OPP structure outside of rcu protected section
  PM / OPP: Manage supply's voltage/current in a separate structure
  PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()
  PM / OPP: Add infrastructure to manage multiple regulators
  PM / OPP: Separate out _generic_opp_set_rate()
  PM / OPP: Allow platform specific custom set_opp() callbacks
  PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
  PM / OPP: Don't assume platform doesn't have regulators

 Documentation/devicetree/bindings/opp/opp.txt |  25 +-
 drivers/base/power/opp/core.c                 | 510 ++++++++++++++++++++------
 drivers/base/power/opp/debugfs.c              |  52 ++-
 drivers/base/power/opp/of.c                   | 105 ++++--
 drivers/base/power/opp/opp.h                  |  20 +-
 drivers/cpufreq/cpufreq-dt.c                  |   9 +-
 include/linux/pm_opp.h                        |  67 +++-
 7 files changed, 605 insertions(+), 183 deletions(-)

-- 
2.7.1.410.g6faf27b
