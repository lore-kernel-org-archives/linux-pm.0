From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RESEND PATCH v2 0/5] drivers: firmware: psci: Some cleanup and
 refactoring
Date: Wed, 10 Apr 2019 10:20:20 +0200
Message-ID: <20190410082025.5989-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Rafael, could you please queue this series via your pm-tree? It has been acked
by PSCI aintainers and it's ready to go. There is no dependency, so the changes
are standalone.

Kind regards
Ulf Hansson

Changes in v2:
	- Drop two patches from the series.
	- Added acks and other tags, no other changes.

Background:
All of these patches have been sent earlier, but part of a bigger series [1].
Instead of waiting for that series to get reviewed and accepted, I have split
it up, such that these trivial independent cleanups can go in as a first step.

The only intentional function change, should be the last patch, where we start
checking if PSCI OSI mode is supported in the PSCI FW and print a message about
it, as that is quite useful information for the user/developer.

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
