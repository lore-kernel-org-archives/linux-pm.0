From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/3] PM/pm_runtime: move on hrtimer and nsec
Date: Fri, 14 Dec 2018 15:22:24 +0100
Message-ID: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: ulf.hansson@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Move pm_runtime on hrtimer and raw ns time to get finer granularity

Patch 1 moves runtime_pm autosuspend on hrtimer framework

Patch 2 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktime

Patch 3 fixes drm/i915 driver that uses PM core fields

Changes since v1:
- updated commit message of patch 1
- Added patches 2 & 3 to move runtime_pm accounting on raw ns
  
Thara Gopinath (1):
  PM/runtime:Replace jiffies based accouting with ktime based accounting

Vincent Guittot (2):
  PM/pm_runtime: move autosuspend on hrtimer
  drm/i915: Move to new PM core fields

 drivers/base/power/runtime.c    | 73 ++++++++++++++++++++++-------------------
 drivers/base/power/sysfs.c      | 11 +++++--
 drivers/gpu/drm/i915/i915_pmu.c | 12 +++----
 drivers/gpu/drm/i915/i915_pmu.h |  4 +--
 include/linux/pm.h              | 11 ++++---
 include/linux/pm_runtime.h      |  6 ++--
 6 files changed, 64 insertions(+), 53 deletions(-)

-- 
2.7.4
