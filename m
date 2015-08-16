From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4] x86 smpboot: remove udelay(100) when polling cpu_callin_map
Date: Sun, 16 Aug 2015 11:45:46 -0400
Message-ID: <0aade12eabeb89a688c929fe80856eaea0544bb7.1439739165.git.len.brown@intel.com>
References: <1439739948-21028-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439739948-21028-1-git-send-email-lenb@kernel.org>
In-Reply-To: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
References: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

After the BSP sends INIT/SIPI/SIP to the AP and sees the AP
in the cpu_initialized_map, it sets the AP loose via the
cpu_callout_map, and waits for it via the cpu_callin_map.

The BSP polls the cpu_callin_map with a udelay(100)
and a schedule() in each iteration.

The udelay(100) adds no value.

For example, on my 4-CPU dekstop, the AP finishes
cpu_callin() in under 70 usec and sets the cpu_callin_mask.
The BSP, however, doesn't see that setting until over 30 usec
later, because it was still running its udelay(100)
when the AP finished.

Deleting the udelay(100) in the cpu_callin_mask polling loop,
saves from 0 to 100 usec per Application Processor.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9ad88fb..310b6f0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -926,7 +926,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 			 * for the MTRR work(triggered by the AP coming online)
 			 * to be completed in the stop machine context.
 			 */
-			udelay(100);
 			schedule();
 		}
 	}
-- 
2.5.0.330.g130be8e
