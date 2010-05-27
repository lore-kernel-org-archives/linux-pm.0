From: Len Brown <lenb@kernel.org>
Subject: [PATCH-v2 2/8] cpuidle: add cpuidle_unregister_driver()
	error check
Date: Thu, 27 May 2010 01:11:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005270107360.4039__20280.5297718898$1274937236$gmane$org@localhost.localdomain>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<56b9c89c17c1a85886f6d1928349e35bbb48c856.1274926772.git.len.brown@intel.com>
	<20100526201437.51f5c7f7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20100526201437.51f5c7f7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

BUG_ON() cpuidle_unregister_driver() being called with
a driver not matching the onee that successfully registered.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/driver.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 2257004..5b6fd0f 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -45,8 +45,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
-	if (!drv)
-		return;
+	BUG_ON(drv != cpuidle_curr_driver)
 
 	spin_lock(&cpuidle_driver_lock);
 	cpuidle_curr_driver = NULL;
-- 
1.6.0.6
