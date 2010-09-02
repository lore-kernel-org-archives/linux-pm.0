From: Colin Cross <ccross@android.com>
Subject: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Wed,  1 Sep 2010 19:54:12 -0700
Message-ID: <1283396052-3620-1-git-send-email-ccross__10976.2803571813$1283552261$gmane$org@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Only wait on a parent device during resume if the parent device is
suspended.

Consider three drivers, A, B, and C.  The parent of A is C, and C
has async_suspend set.  On boot, C->power.completion is initialized
to 0.

During the first suspend:
suspend_devices_and_enter(...)
 dpm_resume(...)
  device_suspend(A)
  device_suspend(B) returns error, aborts suspend
 dpm_resume_end(...)
   dpm_resume(...)
    device_resume(A)
     dpm_wait(A->parent == C)
      wait_for_completion(C->power.completion)

The wait_for_completion will never complete, because
complete_all(C->power.completion) will only be called from
device_suspend(C) or device_resume(C), neither of which is called
if suspend is aborted before C.

After a successful suspend->resume cycle, where B doesn't abort
suspend, C->power.completion is left in the completed state by the
call to device_resume(C), and the same call path will work if B
aborts suspend.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/base/power/main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index cb784a0..e159910 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -526,7 +526,8 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
-	dpm_wait(dev->parent, async);
+	if (dev->parent && dev->parent->power.status >= DPM_OFF)
+		dpm_wait(dev->parent, async);
 	device_lock(dev);
 
 	dev->power.status = DPM_RESUMING;
-- 
1.7.1
