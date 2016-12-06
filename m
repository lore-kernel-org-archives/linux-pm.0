From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/10] PM / OPP: Fixes and cleanups
Date: Tue,  6 Dec 2016 14:45:52 +0530
Message-ID: <cover.1481015522.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34624 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbcLFJQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 04:16:51 -0500
Received: by mail-pg0-f42.google.com with SMTP id x23so147423001pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 01:16:11 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

This series fixes a memory leak (first patch) and does some cleanups to
the OPP core.

It is based of pm/bleeding-edge branch. Though not compulsory, but it
would be nice to get queued up for 4.10, of course once they are
reviewed by other OPP guys.

This series is tested for few days by various build and boot bots:
- Kernel CI (Linaro)
- Fengguang Wu's bot (Intel)

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

 drivers/base/power/opp/core.c | 290 ++++++++++++++++++++++++++----------------
 drivers/base/power/opp/of.c   |  90 +++++++------
 drivers/base/power/opp/opp.h  |  11 +-
 drivers/cpufreq/cpufreq-dt.c  |   7 +-
 drivers/devfreq/devfreq.c     |  26 +---
 include/linux/pm_opp.h        |  20 ++-
 6 files changed, 249 insertions(+), 195 deletions(-)

-- 
2.7.1.410.g6faf27b

