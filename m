From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 0/4] cpufreq: powernv: Redesign the presentation of throttle notification
Date: Mon, 11 Jan 2016 14:54:36 -0600
Message-ID: <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: stable-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, stable@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
CPU when the chip crosses its thermal and power limits. Currently,
powernv-cpufreq driver detects and reports this event as a console
message. Some machines may not sustain the max turbo frequency in all
conditions and can be throttled frequently. This can lead to the
flooding of console with throttle messages. So this patchset aims to
redesign the presentation of this event via sysfs counters and
tracepoints. 

Patches [2] to [4] will add a perf trace point "power:powernv_throttle" and
sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.
Patch [1] solves a bug in powernv_cpufreq_throttle_check(), which calls in to
cpu_to_chip_id() in hot path which reads DT every time to find the chip id.

Changes from v3:
- Add a fix to replace cpu_to_chip_id() with simpler PIR shift to obtain the
  chip id.
- Break patch2 in to two patches separating the tracepoint and sysfs attribute
  changes.

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Shilpasri G Bhat (4):
  cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Add a trace print for the throttle event
  cpufreq: powernv: Add sysfs attributes to show throttle stats

 drivers/cpufreq/powernv-cpufreq.c | 279 +++++++++++++++++++++++++++++++-------
 include/trace/events/power.h      |  22 +++
 kernel/trace/power-traces.c       |   1 +
 3 files changed, 250 insertions(+), 52 deletions(-)

-- 
1.9.1
