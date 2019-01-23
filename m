From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 0/3] Move pm_runtime accounted time to raw nsec
Date: Wed, 23 Jan 2019 08:50:12 +0100
Message-ID: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc: ulf.hansson@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Move pm_runtime accounted time to raw nsec. The subject of the patchset
has changed as 1st patch o the previous versions has been queued by
Rafael.

Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable.
So we remove ordering constraint between timekeeping_init and pm_runtime_init

Patch 2 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktime.

Change since v6:
- move code that set accounting_timestamp in pm_runtime_enable

Changes since v5:
- removed patches already queued.
- set accounting_timestamp to 0 in pm_runtime_init and update it when enable

Changes since v4:
-Update commit message

Changes since v3:
- Rebase on v4.20-rc7 without patch that has been queued by Rafael
- Simplify the new interface pm_runtime_suspended_time()

Changes since v2:
- remove patch1 that has been queued by rafael
- add new interface in pm_runtime to get accounted time
- reorder patchset to prevent compilation error

Changes since v1:
- updated commit message of patch 1
- Added patches 2 & 3 to move runtime_pm accounting on raw ns
  
Thara Gopinath (1):
  PM-runtime: Replace jiffies based accounting with ktime-based
    accounting

Vincent Guittot (1):
  PM-runtime: update accounting_timestamp only when enable

 drivers/base/power/runtime.c | 26 ++++++++++++++++----------
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.7.4
