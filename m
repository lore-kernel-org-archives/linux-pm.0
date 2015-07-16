From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 0/6] powernv: cpufreq: Report frequency throttle by OCC
Date: Thu, 16 Jul 2015 13:34:17 +0530
Message-ID: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

This patchset intends to add frequency throttle reporting mechanism
to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
On-Chip-Controller which takes care of the power and thermal safety of
the chip. The CPU frequency can be throttled during an OCC reset or
when OCC tries to limit the max allowed frequency. The patchset will
report such conditions so as to keep the user informed about reason
for the drop in performance of workloads when frequency is throttled.

Changes from v4:
- Taken care of Joel Stanley's comment, modification in patch[3].
  This replaces memcpy() with be64_to_cpu() and no change in 
  functionality of the patch

Changes from v3:
- Rebased on top of 4.2-rc1
- Minor changes in patch 2,3,4,6 this does not change the
  functionality of the code
- 594fcb9ec9e powerpc/powernv: Expose OPAL APIs required by PRD
  interface , this patch fixes the build error due to which this
  series was initially dropped
  ERROR: ".opal_message_notifier_register"
  drivers/cpufreq/powernv-cpufreq.ko] undefined!

Changes from v2:
- Split into multiple patches
- Semantic fixes

Shilpasri G Bhat (6):
  cpufreq: powernv: Handle throttling due to Pmax capping at chip level
  powerpc/powernv: Add definition of OPAL_MSG_OCC message type
  cpufreq: powernv: Register for OCC related opal_message notification
  cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
  cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is
    set
  cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling

 arch/powerpc/include/asm/opal-api.h |  12 +++
 drivers/cpufreq/powernv-cpufreq.c   | 198 +++++++++++++++++++++++++++++++++---
 2 files changed, 195 insertions(+), 15 deletions(-)

-- 
1.9.3
