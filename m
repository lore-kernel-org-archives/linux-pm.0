From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V5 00/10] PM / OPP: Multiple regulator support
Date: Tue, 29 Nov 2016 12:06:47 +0530
Message-ID: <cover.1480401041.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Some platforms (like TI) have complex DVFS configuration for CPU
devices, where multiple regulators are required to be configured to
change DVFS state of the device. This was explained well by Nishanth
earlier [1].

One of the major complaints around multiple regulators case was that the
DT isn't responsible in any way to represent the order in which multiple
supplies need to be programmed, before or after a frequency change. It
was considered in this patch and such information is left for the
platform specific OPP driver now, which can register its own
opp_set_rate() callback with the OPP core and the OPP core will then
call it during DVFS.

The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
and code to pass values for multiple regulators and verified that they
are all properly read by the kernel (using debugfs interface).

Dave Gerlach has already tested [2] it on the real TI platforms and it
works well for him.

This is rebased over: linux-next branch in the PM tree.

V4->V5:
- Stephen boyd had some minor review comments and gave his Reviewed-by
  tag for the rest. Only 2 patches don't have his RBY tag.
- Individual patches contain the version history from V4 to V5.

V3->V4:
- Separate out cpu-supply fix in the binding in a separate patch (Mark).
- Add more documentation to the binding to explain that the relation to
  the supplies and the order of programming them is left for the
  platform specific bindings and that every platform using multiple
  regulators for their devices needs to provide a separate binding
  document explaining their implementation (Mark).
- @Rob and Stephen: I have kept your Acks for the bindings as the
  bindings only got a bit reworded (improved) since the time you guys
  Acked them. Please let me know if you want more improvement in the
  bindings now.
- V4 for 10/10 was sent earlier, which added a missing
  rcu_read_unlock(). Nothing else changed in it.
- Added some missing Kernel documentation comments

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
[2] https://marc.info/?l=linux-kernel&m=147924789305276&w=2

Viresh Kumar (10):
  PM / OPP: Fix incorrect cpu-supply property in binding
  PM / OPP: Reword binding supporting multiple regulators per device
  PM / OPP: Don't use OPP structure outside of rcu protected section
  PM / OPP: Manage supply's voltage/current in a separate structure
  PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()
  PM / OPP: Add infrastructure to manage multiple regulators
  PM / OPP: Separate out _generic_set_opp()
  PM / OPP: Allow platform specific custom set_opp() callbacks
  PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
  PM / OPP: Don't assume platform doesn't have regulators

 Documentation/devicetree/bindings/opp/opp.txt |  27 +-
 drivers/base/power/opp/core.c                 | 536 ++++++++++++++++++++------
 drivers/base/power/opp/debugfs.c              |  52 ++-
 drivers/base/power/opp/of.c                   | 105 +++--
 drivers/base/power/opp/opp.h                  |  22 +-
 drivers/cpufreq/cpufreq-dt.c                  |   9 +-
 include/linux/pm_opp.h                        |  69 +++-
 7 files changed, 634 insertions(+), 186 deletions(-)

-- 
2.7.1.410.g6faf27b

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
