From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] x86 smpboot: remove udelay(100) when polling cpu_initialized_map
Date: Sun, 16 Aug 2015 11:45:45 -0400
Message-ID: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
References: <1439739948-21028-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439739948-21028-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

After the BSP sends the APIC INIT/SIPI/SIPI to the AP,
it waits for the AP to come up and indicate that it is alive
by setting its own bit in the cpu_initialized_mask.

Linux polls for up to 10 seconds for this to happen.
Each polling loop has a udelay(100) and a call to schedule().

The udelay(100) adds no value.

For example, on my desktop, the BSP waits for the
other 3 CPUs to come on line at boot for 305, 404, 405 usec.
For resume from S3, it waits 317, 404, 405 usec.

But when the udelay(100) is removed, the BSP waits
305, 310, 306 for boot, and 305, 307, 306 for resume.

So for both boot and resume, removing the udelay(100)
speeds online by about 100us in 2 of 3 cases.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b1f3ed9c..9ad88fb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -898,7 +898,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 
 	if (!boot_error) {
 		/*
-		 * Wait 10s total for a response from AP
+		 * Wait 10s total for first sign of life from AP
 		 */
 		boot_error = -1;
 		timeout = jiffies + 10*HZ;
@@ -911,7 +911,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 				boot_error = 0;
 				break;
 			}
-			udelay(100);
 			schedule();
 		}
 	}
-- 
2.5.0.330.g130be8e
