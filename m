From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/5] drivers: firmware: psci: Some cleanup and refactoring
Date: Wed, 13 Mar 2019 09:36:54 +0100
Message-ID: <20190313083659.7100-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Changes in v2:
	- Drop two patches from the series.
	- Added acks and other tags, no other changes.

All of these patches have been sent earlier, but part of a bigger series [1].
Instead of waiting for that series to get reviewed and accepted, I have split
it up, such that these trivial independent cleanups can go in as a first step.

The only intentional function change, should be the last patch, where we start
checking if PSCI OSI mode is supported in the PSCI FW and print a message about
it, as that is quite useful information for the user/developer.

Rafael, discussions between me and Lorenzo for v1 concluded that these are ready
to be queued for v5.2 - and if possible, we would like this to go via your
linux-pm tree. Can you please pick it up?

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2018/11/29/1801

Ulf Hansson (5):
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode

 MAINTAINERS                                |  2 +-
 drivers/firmware/Kconfig                   | 15 +---
 drivers/firmware/Makefile                  |  3 +-
 drivers/firmware/psci/Kconfig              | 13 ++++
 drivers/firmware/psci/Makefile             |  4 +
 drivers/firmware/{ => psci}/psci.c         | 86 +++++++++++++---------
 drivers/firmware/{ => psci}/psci_checker.c |  0
 include/uapi/linux/psci.h                  |  5 ++
 8 files changed, 78 insertions(+), 50 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (93%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1
