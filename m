From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 00/10] PM / OPP: Multiple regulator support
Date: Thu,  1 Dec 2016 16:28:13 +0530
Message-ID: <cover.1480564564.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33687 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755734AbcLAK61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 05:58:27 -0500
Received: by mail-pg0-f47.google.com with SMTP id 3so94060467pgd.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2016 02:58:27 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

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

V6->V7:
- Added RBY from Stephen for the 8th patch as well.
- Rebased over pm/bleeding-edge as the dependency patch is already
  applied there.
- s/dev_pm_opp_set_regulator()/dev_pm_opp_set_regulators() in a comment.
- Removed the local 'names' array in cpufreq-dt and used "&name"
  instead.
- Only the 6th patch doesn't have a Reviewed-by Tag now..

V5->V6:
- Rebased over a recent fix (and resolved rebase conflicts) that will
  get applied before this series:

  https://marc.info/?l=linux-kernel&m=148047843010418&w=2

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
 drivers/base/power/opp/core.c                 | 538 ++++++++++++++++++++------
 drivers/base/power/opp/debugfs.c              |  52 ++-
 drivers/base/power/opp/of.c                   | 105 +++--
 drivers/base/power/opp/opp.h                  |  22 +-
 drivers/cpufreq/cpufreq-dt.c                  |   6 +-
 include/linux/pm_opp.h                        |  69 +++-
 7 files changed, 633 insertions(+), 186 deletions(-)

-- 
2.7.1.410.g6faf27b

