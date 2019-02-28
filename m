From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] drivers: firmware: psci: Some cleanup and refactoring
Date: Thu, 28 Feb 2019 14:59:12 +0100
Message-ID: <20190228135919.3747-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

All of these patches have been sent earlier, but part of a bigger series [1].
Instead of waiting for that series to get reviewed and accepted, I have split
it up, such that these trivial independent cleanups can go in as a first step.

The only intentional function change, should be the last patch, where we start
checking if PSCI OSI mode is supported in the PSCI FW and print a message about
it, as that is quite useful information for the user/developer.

As there is a ARM/ARM64 "tree wide" change included, it would be nice if
this could go in already for v5.1-rc1, to set the foundation for the next cycle.
I know it's *really* late for that, but maybe Rafael can help take it via his
pm-tree, if all acks are received of course?

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2018/11/29/1801

Ulf Hansson (7):
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  ARM/ARM64: cpuidle: Let back-end init ops take the driver as input
  drivers: firmware: psci: Simplify state node parsing
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode

 MAINTAINERS                                |   2 +-
 arch/arm/include/asm/cpuidle.h             |   4 +-
 arch/arm/kernel/cpuidle.c                  |   5 +-
 arch/arm64/include/asm/cpu_ops.h           |   4 +-
 arch/arm64/include/asm/cpuidle.h           |   6 +-
 arch/arm64/kernel/cpuidle.c                |   6 +-
 drivers/cpuidle/cpuidle-arm.c              |   2 +-
 drivers/firmware/Kconfig                   |  15 +--
 drivers/firmware/Makefile                  |   3 +-
 drivers/firmware/psci/Kconfig              |  13 +++
 drivers/firmware/psci/Makefile             |   4 +
 drivers/firmware/{ => psci}/psci.c         | 114 ++++++++++++---------
 drivers/firmware/{ => psci}/psci_checker.c |   0
 drivers/soc/qcom/spm.c                     |   3 +-
 include/linux/psci.h                       |   4 +-
 include/uapi/linux/psci.h                  |   5 +
 16 files changed, 113 insertions(+), 77 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (91%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1
