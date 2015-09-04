From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/6] PM / OPP: Add debugfs support
Date: Fri,  4 Sep 2015 13:47:21 +0530
Message-ID: <cover.1441354424.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34173 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbbIDIRh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 04:17:37 -0400
Received: by padhy16 with SMTP id hy16so15231765pad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 01:17:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This is (hopefully) the last version of this patchset, all the patches
are reviewed by Stephen (Many thanks for this) now and sending
everything again so that you know exactly what all to apply.

This series is targeted towards exposing opp information at user space.
I wasn't really sure about adding them to sysfs, as its mostly static
(fixed) data and so debugfs looked to be better place.

This series starts with 3 cleanup patches, and then moves all opp stuff
to a new directory, as its expanding enough now.

The last patch adds debugfs support for OPPs and works for both old and
new v2 bindings.

Rebased over: pm/bleeding-edge branch.

V2-Resend->V3:
- 2/6 is a new patch
- 3/6 also modifies of_add_opp_table() now..
- Reviewed by tags from Stephen

V2->V2-Resend:
- V2 1/6 is dropped as its already merged, rest unchanged.

V1->V2:
- Moved the second patch to the top as its a fix (Dan Carpenter &
  Stephen).
- Also updated it to fix things properly.
- rearranged opp entry in drivers/base/power/Makefile (Stephen)
- Device-directory name also includes its parent name now, to make it
  more unique (Stephen).
- Migrate debugfs directory properly if unregistered for the owner
  device (Stephen).


Viresh Kumar (6):
  PM / OPP: reuse of_parse_phandle()
  PM / OPP: Rename opp init/free table routines
  PM / OPP: Prefix exported opp routines with dev_pm_opp_
  PM / OPP: Move opp core to its own directory
  PM / OPP: Move cpu specific code to opp/cpu.c
  PM / OPP: Add debugfs support

 arch/arm/mach-imx/mach-imx6q.c           |   2 +-
 drivers/base/power/Makefile              |   2 +-
 drivers/base/power/opp/Makefile          |   3 +
 drivers/base/power/{opp.c => opp/core.c} | 378 ++++---------------------------
 drivers/base/power/opp/cpu.c             | 268 ++++++++++++++++++++++
 drivers/base/power/opp/debugfs.c         | 217 ++++++++++++++++++
 drivers/base/power/opp/opp.h             | 186 +++++++++++++++
 drivers/cpufreq/Makefile                 |   1 -
 drivers/cpufreq/arm_big_little.h         |   2 +-
 drivers/cpufreq/arm_big_little_dt.c      |   4 +-
 drivers/cpufreq/cpufreq-dt.c             |  10 +-
 drivers/cpufreq/cpufreq_opp.c            | 114 ----------
 drivers/cpufreq/exynos5440-cpufreq.c     |   6 +-
 drivers/cpufreq/imx6q-cpufreq.c          |   6 +-
 drivers/cpufreq/mt8173-cpufreq.c         |   6 +-
 include/linux/pm_opp.h                   |  24 +-
 16 files changed, 750 insertions(+), 479 deletions(-)
 create mode 100644 drivers/base/power/opp/Makefile
 rename drivers/base/power/{opp.c => opp/core.c} (79%)
 create mode 100644 drivers/base/power/opp/cpu.c
 create mode 100644 drivers/base/power/opp/debugfs.c
 create mode 100644 drivers/base/power/opp/opp.h
 delete mode 100644 drivers/cpufreq/cpufreq_opp.c

-- 
2.4.0

