From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/10] PM / OPP: Fixes and cleanups
Date: Wed,  7 Dec 2016 10:11:56 +0530
Message-ID: <cover.1481085478.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36134 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcLGEmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 23:42:13 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so74743072pfz.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 20:42:13 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

This series fixes a memory leak (first patch) and does some cleanups to
the OPP core.

It is based of pm/bleeding-edge branch.

This series is tested for few days by various build and boot bots:
- Kernel CI (Linaro)
- Fengguang Wu's bot (Intel)

V1->V2:
- 6 out of 10 patches have received Acks from Stephen/MyungJoo.
- dev_pm_opp_get_suspend_opp_freq() return freq in Hz now
- s/opp_table/table in _opp_allocate()
- Improved comment over _opp_add() defining its return types
- opp_rcu_lockdep_assert() added at few places
- Dropped a useless comment

--
viresh

Viresh Kumar (10):
  PM / OPP: Fix memory leak while adding duplicate OPPs
  PM / OPP: Remove useless TODO
  PM / OPP: Rename _allocate_opp() to _opp_allocate()
  PM / OPP: Error out on failing to add static OPPs for v1 bindings
  PM / OPP: Add light weight _opp_free() routine
  PM / OPP: Rename and split _dev_pm_opp_remove_table()
  PM / OPP: Don't allocate OPP table from _opp_allocate()
  PM / OPP: Rename dev_pm_opp_get_suspend_opp() and return OPP rate
  PM / OPP: Don't expose srcu_head to register notifiers
  PM / OPP: Split out part of _add_opp_table() and _remove_opp_table()

 drivers/base/power/opp/core.c | 294 ++++++++++++++++++++++++++----------------
 drivers/base/power/opp/of.c   |  89 +++++++------
 drivers/base/power/opp/opp.h  |  11 +-
 drivers/cpufreq/cpufreq-dt.c  |   7 +-
 drivers/devfreq/devfreq.c     |  26 +---
 include/linux/pm_opp.h        |  20 ++-
 6 files changed, 254 insertions(+), 193 deletions(-)

-- 
2.7.1.410.g6faf27b

