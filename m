From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/6] PM / OPP: Add debugfs support
Date: Mon, 10 Aug 2015 12:01:56 +0530
Message-ID: <cover.1439187821.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33073 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbHJGcW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 02:32:22 -0400
Received: by pabyb7 with SMTP id yb7so99547569pab.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2015 23:32:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

This isn't necessarily 4.3 material.

This series is targeted towards exposing opp information at user space.
I wasn't really sure about adding them to sysfs, as its mostly static
(fixed) data and so debugfs looked to be better place.

This series starts with 2 cleanup patches, and then moves all opp stuff
to a new directory as its expanding enough now.

The last patch adds debugfs support for OPPs and works for both old and
new v2 bindings.

Rebased over: pm/bleeding-edge branch.

Viresh Kumar (6):
  PM / OPP: reuse of_parse_phandle()
  PM / OPP: restructure _of_init_opp_table_v2()
  PM / OPP: Prefix exported opp routines with dev_pm_opp_
  PM / OPP: Move opp core to its own directory
  PM / OPP: Move cpu specific code to opp/cpu.c
  PM / OPP: Add debugfs support

 drivers/base/power/Makefile              |   2 +-
 drivers/base/power/opp/Makefile          |   3 +
 drivers/base/power/{opp.c => opp/core.c} | 372 ++++---------------------------
 drivers/base/power/opp/cpu.c             | 268 ++++++++++++++++++++++
 drivers/base/power/opp/debugfs.c         | 165 ++++++++++++++
 drivers/base/power/opp/opp.h             | 179 +++++++++++++++
 drivers/cpufreq/Makefile                 |   1 -
 drivers/cpufreq/cpufreq-dt.c             |  10 +-
 drivers/cpufreq/cpufreq_opp.c            | 114 ----------
 include/linux/pm_opp.h                   |  16 +-
 10 files changed, 672 insertions(+), 458 deletions(-)
 create mode 100644 drivers/base/power/opp/Makefile
 rename drivers/base/power/{opp.c => opp/core.c} (80%)
 create mode 100644 drivers/base/power/opp/cpu.c
 create mode 100644 drivers/base/power/opp/debugfs.c
 create mode 100644 drivers/base/power/opp/opp.h
 delete mode 100644 drivers/cpufreq/cpufreq_opp.c

-- 
2.4.0

