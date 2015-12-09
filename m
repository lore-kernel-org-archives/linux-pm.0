From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/2] PM / OPP: Parse opp-supported-hw/opp-<prop>-<name> bindings
Date: Wed,  9 Dec 2015 08:01:45 +0530
Message-ID: <cover.1449627691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

These patches parse the newly added opp-supported-hw/opp-<prop>-<name>
bindings.

Rebased over: Latest pm/linux-next
Tested-on: Exynos 5250, dual core A15.

V2->V3:
- Stephen had an interesting point to make for V2, as the patches
  created the dev_opp first and then updated it within the OPP-list
  lock. But a simultaneous reader of the dev_opp list need a rcu way of
  handling this.
- The big difference, why its not a problem here, is that the platform
  needs to call this routine before the OPPs are parsed from DT and the
  opp-list will be empty. And so no-readers.
- It wasn't guaranteed earlier, but now we have installed few WARN_ON()
  to make sure about that there are no OPPs while these routines are
  called.
- It should be pretty safe to get these merged now.
- Lee's work depends on this to be merged,
  http://marc.info/?l=linux-kernel&m=144958553611215&w=2

V1->V2:
- Fixed locking
- NUL terminate strings instead of sprintf
- Remove NULL checkers for the routines
- constify 'versions'
- s/EINVAL/EBUSY
- updated comments over routines
- Use of_property_read_u32_index() instead of allocating arrays
- remove dev_opp for failures

Viresh Kumar (2):
  PM / OPP: Parse 'opp-supported-hw' binding
  PM / OPP: Parse 'opp-<prop>-<name>' bindings

 drivers/base/power/opp/core.c | 313 ++++++++++++++++++++++++++++++++++++++++--
 drivers/base/power/opp/opp.h  |   7 +
 include/linux/pm_opp.h        |  22 +++
 3 files changed, 327 insertions(+), 15 deletions(-)

-- 
2.6.2.198.g614a2ac
