From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] cpufreq: powernv: Redesign the presentation of throttle notification
Date: Mon,  4 Jan 2016 14:55:25 +0530
Message-ID: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
CPU when the chip crosses its thermal and power limits. Currently,
powernv-cpufreq driver detects and reports this event as a console
message. Some boxes may not sustain the max turbo frequency in all
conditions and can be throttled frequently. This can lead to the
flooding of console with throttle messages. So this patchset aims to
redesign the presentation of this event via sysfs counters and
tracepoints. 

This patchset will add a perf trace point "power:powernv_throttle" and
sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Shilpasri G Bhat (2):
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Redesign the presentation of throttle notification

 drivers/cpufreq/powernv-cpufreq.c | 256 +++++++++++++++++++++++++++++++-------
 include/trace/events/power.h      |  22 ++++
 kernel/trace/power-traces.c       |   1 +
 3 files changed, 236 insertions(+), 43 deletions(-)

-- 
1.9.3
