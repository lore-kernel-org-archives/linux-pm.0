From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] x86 smpboot: fix CPU #1 boot timeout
Date: Fri, 16 Oct 2015 00:14:29 -0400
Message-ID: <6dd554ee8945984d85aafb2ad35793174d068af0.1444968087.git.len.brown@intel.com>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444968869-21435-1-git-send-email-lenb@kernel.org>
In-Reply-To: <de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
References: <de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, shrybman@teksavvy.com, dparsons@brightdsl.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Commit a9bcaa02a5104ace6a9d9e4a9cd9192a9e7744d6
("x86/smpboot: Remove SIPI delays from cpu_up()")

Caused some Intel Core2 processors to time-out when bringing up CPU #1.

That patch reduced the SIPI delays from udelay() 300, 200
to udelay() 0, 0 on modern processors.

Several Intel(R) Core(TM)2 systems
failed to bring up CPU #1 10/10 times after that change.

Increasing either of the SIPI delays to udelay(1) results in success.
So here we increase both to udelay(10).  While this may be 20x slower
than the absolute minimum, it is still 20x to 30x faster
than the original code.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 32267cc..892ee2e5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -660,7 +660,9 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 		/*
 		 * Give the other CPU some time to accept the IPI.
 		 */
-		if (init_udelay)
+		if (init_udelay == 0)
+			udelay(10);
+		else
 			udelay(300);
 
 		pr_debug("Startup point 1\n");
@@ -671,7 +673,9 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 		/*
 		 * Give the other CPU some time to accept the IPI.
 		 */
-		if (init_udelay)
+		if (init_udelay == 0)
+			udelay(10);
+		else
 			udelay(200);
 
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP.  */
-- 
2.6.1.145.gb27dacc
