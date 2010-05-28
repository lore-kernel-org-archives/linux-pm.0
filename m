From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] acpi_pad: uses MONITOR/MWAIT,
 so it doesn't need to clear TS_POLLING
Date: Fri, 28 May 2010 02:01:59 -0400
Message-ID: <a7d27c37533524e23bbdc9ba1d78e3241b7483ea.1275026041.git.len.brown__47445.0593152598$1275030555$gmane$org@intel.com>
References: <1275026521-30835-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1275026521-30835-1-git-send-email-lenb@kernel.org>
In-reply-to: <6b2c676bf32be91f43215d5874c07c1becaba013.1275026041.git.len.brown@intel.com>
References: <6b2c676bf32be91f43215d5874c07c1becaba013.1275026041.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
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
