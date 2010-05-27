From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] acpi_pad: uses MONITOR/MWAIT,
 so it doesn't need to clear TS_POLLING
Date: Wed, 26 May 2010 22:42:29 -0400
Message-ID: <77a04b66c7da7b2943bb37911db18d5918f299dd.1274926772.git.len.brown__42641.7222283364$1274929185$gmane$org@intel.com>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1274928151-30919-1-git-send-email-lenb@kernel.org>
In-reply-to: <e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
References: <e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

api_pad exclusively uses MONITOR/MWAIT to sleep in idle,
so it does not need the wakeup IPI during idle sleep
that is provoked by clearing TS_POLLING.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/acpi_pad.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 6212213..7edf053 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -168,13 +168,6 @@ static int power_saving_thread(void *data)
 
 		do_sleep = 0;
 
-		current_thread_info()->status &= ~TS_POLLING;
-		/*
-		 * TS_POLLING-cleared state must be visible before we test
-		 * NEED_RESCHED:
-		 */
-		smp_mb();
-
 		expire_time = jiffies + HZ * (100 - idle_pct) / 100;
 
 		while (!need_resched()) {
@@ -200,8 +193,6 @@ static int power_saving_thread(void *data)
 			}
 		}
 
-		current_thread_info()->status |= TS_POLLING;
-
 		/*
 		 * current sched_rt has threshold for rt task running time.
 		 * When a rt task uses 95% CPU time, the rt thread will be
-- 
1.6.0.6
