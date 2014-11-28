From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/26] thermal: cpu_cooling: Fixes and cleanups
Date: Fri, 28 Nov 2014 15:13:54 +0530
Message-ID: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35206 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaK1Jog (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:44:36 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so6568092pad.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:44:36 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hongbo Zhang <hongbo.zhang@linaro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

Hi Eduardo,

As you know I got into fixing cpu_cooling.c due to some cpufreq issues you and
Lukasz were struggling with. I found some issues in cpu_cooling then and here
are the fixes/cleanups.

Sorry for the long list. Haven't broken them into smaller sets as most of the
patches are very small, easy to review and inter-dependent. Only few of them
should take more time to review. If this doesn't work out, let me know and I
will try to send separate inter-dependent sets.

Just apply whatever looks fine and I will update/resend the ones left in V2 if
at required.

First few are updates to platform drivers. Exynos fails to register after few
patches in this series as it doesn't handle -EPROBE_DEFER properly (reported
that in reply to your patch as well). Others weren't setting clip_cpus properly
and are fixed.

Next ones are cleanups of cpu_cooling.c to get things properly organized.

Let me know if I screwed it up completely.

Tested-on: Exynos5250 (Dual ARM Cortex A15).
Rebased-over: v3.18-rc6
Pushed here: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git
thermal/cpu-cooling-fixes

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>

Viresh Kumar (26):
  thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
  thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
  thermal: exynos: pass cpu_present_mask to cpufreq_cooling_register()
  thermal: exynos: Handle -EPROBE_DEFER properly
  cpu_cooling: random comment fixups
  cpu_cooling: fix doc comment over struct cpufreq_cooling_device
  cpu_cooling: Add comment to clarify relation between cooling state and
    frequency
  cpu_cooling: Pass variable instead of its type to sizeof()
  cpu_cooling: no need to set cpufreq_state to zero
  cpu_cooling: no need to set cpufreq_dev to NULL
  cpu_cooling: propagate error returned by idr_alloc()
  cpu_cooling: Don't match min/max frequencies for all CPUs on cooling
    register
  cpu_cooling: don't iterate over all allowed_cpus to update cpufreq
    policy
  cpu_cooling: Don't check is_cpufreq_valid()
  cpu_cooling: do error handling at the bottom in
    __cpufreq_cooling_register()
  cpu_cooling: Drop useless locking around idr_alloc/idr_remove
  cpu_cooling: Merge cpufreq_apply_cooling() into
    cpufreq_set_cur_state()
  cpu_cooling: Merge get_cpu_frequency() into cpufreq_set_cur_state()
  cpu_cooling: find max level during device registration
  cpu_cooling: get_property() doesn't need to support GET_MAXL anymore
  cpu_cooling: create list of cpufreq_cooling_devices
  cpu_cooling: use cpufreq_dev_list instead of cpufreq_dev_count
  cpu_cooling: Pass 'cpufreq_dev' to get_property()
  cpu_cooling: Store frequencies in descending order
  cpu_cooling: Use cpufreq_dev->freq_table for finding level/freq
  cpu_cooling: update copyright tags

 drivers/thermal/cpu_cooling.c                   | 405 +++++++++---------------
 drivers/thermal/db8500_cpufreq_cooling.c        |   5 +-
 drivers/thermal/imx_thermal.c                   |   4 +-
 drivers/thermal/samsung/exynos_thermal_common.c |  11 +-
 drivers/thermal/samsung/exynos_tmu.c            |   4 +-
 5 files changed, 153 insertions(+), 276 deletions(-)

-- 
2.0.3.693.g996b0fd

