From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/6] PM / OPP: Add debugfs support
Date: Tue, 11 Aug 2015 16:04:33 +0530
Message-ID: <cover.1439288881.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35216 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934095AbbHKKeq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 06:34:46 -0400
Received: by pdrg1 with SMTP id g1so82357230pdr.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 03:34:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

This isn't necessarily 4.3 material, but its fine if it can hit 4.3 :).

This series is targeted towards exposing opp information at user space.
I wasn't really sure about adding them to sysfs, as its mostly static
(fixed) data and so debugfs looked to be better place.

This series starts with 3 cleanup patches, and then moves all opp stuff
to a new directory as its expanding enough now.

The last patch adds debugfs support for OPPs and works for both old and
new v2 bindings.

Rebased over: pm/bleeding-edge branch.

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
  PM / OPP: Free resources and properly return error on failure
  PM / OPP: reuse of_parse_phandle()
  PM / OPP: Prefix exported opp routines with dev_pm_opp_
  PM / OPP: Move opp core to its own directory
  PM / OPP: Move cpu specific code to opp/cpu.c
  PM / OPP: Add debugfs support

 drivers/base/power/Makefile              |   2 +-
 drivers/base/power/opp/Makefile          |   3 +
 drivers/base/power/{opp.c => opp/core.c} | 376 ++++---------------------------
 drivers/base/power/opp/cpu.c             | 268 ++++++++++++++++++++++
 drivers/base/power/opp/debugfs.c         | 217 ++++++++++++++++++
 drivers/base/power/opp/opp.h             | 186 +++++++++++++++
 drivers/cpufreq/Makefile                 |   1 -
 drivers/cpufreq/cpufreq-dt.c             |  10 +-
 drivers/cpufreq/cpufreq_opp.c            | 114 ----------
 include/linux/pm_opp.h                   |  16 +-
 10 files changed, 733 insertions(+), 460 deletions(-)
 create mode 100644 drivers/base/power/opp/Makefile
 rename drivers/base/power/{opp.c => opp/core.c} (80%)
 create mode 100644 drivers/base/power/opp/cpu.c
 create mode 100644 drivers/base/power/opp/debugfs.c
 create mode 100644 drivers/base/power/opp/opp.h
 delete mode 100644 drivers/cpufreq/cpufreq_opp.c

-- 
2.4.0

