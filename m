From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/26] thermal: cpu_cooling: Fixes and cleanups
Date: Thu,  4 Dec 2014 09:41:42 +0530
Message-ID: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56036 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaLDEMp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:12:45 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so1715349pdj.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:12:44 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Hongbo Zhang <hongbo.zhang@linaro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

Hi Eduardo,

Here is the second iteration of my cpu_cooling cleanups to make it work/look
better. As discussed earlier I picked one of your patches as mine were dependent
on it. Have done some fixes to your patch as well.

First few are updates to platform drivers to fix mask present in clip_cpus.
Next ones are cleanups of cpu_cooling.c to get things properly organized.

Tested-on: Exynos5250 (Dual ARM Cortex A15).
Rebased-over: v3.18-rc7
Pushed here: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git
thermal/cpu-cooling-fixes

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>

V1->V2:
- Dropped: cpu_cooling: Drop useless locking around idr_alloc/idr_remove
- Fixed $Subject of patches to prefix with: "thermal: " before "cpu_cooling:"
- Fixed some stupid mistakes highlighted by Eduardo and Javi.
  - s/ERR_PTR(cpufreq_dev->id)/ERR_PTR(ret)
  - s/sizeof(*cool_dev)/sizeof(*cpufreq_dev)

- Rebased over rc7 and that changed lots of things.
  - list of cooling devices was already present in rc7, so my patch to do the
    same is gone.
  - Other modifications done as well to fit with latest updates.

Eduardo Valentin (1):
  thermal: cpu_cooling: check for the readiness of cpufreq layer

Viresh Kumar (25):
  thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
  thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
  thermal: exynos: pass cpu_present_mask to cpufreq_cooling_register()
  thermal: cpu_cooling: random comment fixups
  thermal: cpu_cooling: fix doc comment over struct
    cpufreq_cooling_device
  thermal: cpu_cooling: Add comment to clarify relation between cooling
    state and frequency
  thermal: cpu_cooling: Pass variable instead of its type to sizeof()
  thermal: cpu_cooling: no need to set cpufreq_state to zero
  thermal: cpu_cooling: no need to set cpufreq_dev to NULL
  thermal: cpu_cooling: no need to initialze 'ret'
  thermal: cpu_cooling: propagate error returned by idr_alloc()
  thermal: cpu_cooling: Don't match min/max frequencies for all CPUs on
    cooling register
  thermal: cpu_cooling: don't iterate over all allowed_cpus to update
    cpufreq policy
  thermal: cpu_cooling: Don't check is_cpufreq_valid()
  thermal: cpu_cooling: do error handling at the bottom in
    __cpufreq_cooling_register()
  thermal: cpu_cooling: initialize 'cpufreq_val' on registration
  thermal: cpu_cooling: Merge cpufreq_apply_cooling() into
    cpufreq_set_cur_state()
  thermal: cpu_cooling: remove unnecessary wrapper get_cpu_frequency()
  thermal: cpu_cooling: find max level during device registration
  thermal: cpu_cooling: get_property() doesn't need to support GET_MAXL
    anymore
  thermal: cpu_cooling: use cpufreq_dev_list instead of
    cpufreq_dev_count
  thermal: cpu_cooling: Pass 'cpufreq_dev' to get_property()
  thermal: cpu_cooling: Store frequencies in descending order
  thermal: cpu_cooling: Use cpufreq_dev->freq_table for finding
    level/freq
  thermal: cpu_cooling: update copyright tags

 drivers/thermal/cpu_cooling.c                      | 360 ++++++++-------------
 drivers/thermal/db8500_cpufreq_cooling.c           |  10 +-
 drivers/thermal/imx_thermal.c                      |   9 +-
 drivers/thermal/samsung/exynos_thermal_common.c    |  12 +-
 drivers/thermal/samsung/exynos_tmu.c               |   5 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   6 -
 6 files changed, 148 insertions(+), 254 deletions(-)

-- 
2.0.3.693.g996b0fd

