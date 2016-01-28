From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v7 0/6] cpufreq: powernv: Redesign the presentation of throttle notification and solve bug-fixes in the driver
Date: Thu, 28 Jan 2016 12:55:35 +0530
Message-ID: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:54535 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbcA1H0t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 02:26:49 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Thu, 28 Jan 2016 17:26:47 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
CPU when the chip crosses its thermal and power limits. Currently,
powernv-cpufreq driver detects and reports this event as a console
message. Some machines may not sustain the max turbo frequency in all
conditions and can be throttled frequently. This can lead to the
flooding of console with throttle messages. So this patchset aims to
redesign the presentation of this event via sysfs counters and
tracepoints. And it also fixes couple of bugs reported in the driver.

- Patch [1] fixes a memory leak bug
- Patch [2] fixes the cpu hot-plug bug in powernv_cpufreq_work_fn().
- Patch [3] solves a bug in powernv_cpufreq_throttle_check(), which
  calls in to cpu_to_chip_id() in hot path which reads DT every time
  to find the chip id.
- Patches [4] to [6] will add a perf trace point
  "power:powernv_throttle" and sysfs throttle counter stats in
  /sys/devices/system/cpu/cpufreq/chipN.

Changes from v6:
- Changes wrt comments from Balbir Singh and Viresh Kumar.

Changes from v5:
- Fix kbuild error:
drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
function 'get_online_cpus' [-Werror=implicit-function-declaration]

Changes from v4:
- Fix a hot-plug bug in powernv_cpufreq_work_fn()
- Changes wrt Gautham's and Shreyas's comments 

Changes from v3:
- Add a fix to replace cpu_to_chip_id() with simpler PIR shift to 
  obtain the chip id.
- Break patch2 in to two patches separating the tracepoint and sysfs
  attribute changes.

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Shilpasri G Bhat (6):
  cpufre: powernv: Free 'chips' on module exit
  cpufreq: powernv: Hot-plug safe the kworker thread
  cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Replace pr_info with trace print for throttle event
  cpufreq: powernv: Add sysfs attributes to show throttle stats

 Documentation/ABI/testing/sysfs-devices-system-cpu |  45 +++
 drivers/cpufreq/powernv-cpufreq.c                  | 313 +++++++++++++++++----
 include/trace/events/power.h                       |  22 ++
 kernel/trace/power-traces.c                        |   1 +
 4 files changed, 326 insertions(+), 55 deletions(-)

-- 
1.9.3

