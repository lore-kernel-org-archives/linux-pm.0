From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate management
Date: Tue,  3 May 2016 20:49:34 +0530
Message-ID: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
is in Rafael's linux-next.

- Patch [1] fixes WARN_ON in powernv_target_index()
- Patch [2] Deleting any pending timer to saves an unnecessary irq call
 in powernv_target_index()

Akshay Adiga (2):
  cpufreq: powernv: Move smp_call_function_any() out of irq safe block
  cpufreq: powernv: del_timer_sync when global and local pstate are
    equal

 drivers/cpufreq/powernv-cpufreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.5.5
