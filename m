From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/8] cpuidle: add cpuidle_unregister_driver()
	error check
Date: Wed, 26 May 2010 22:42:25 -0400
Message-ID: <56b9c89c17c1a85886f6d1928349e35bbb48c856.1274926772.git.len.brown__19028.9992293858$1274932096$gmane$org@intel.com>
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

When cpuidle_unregister_driver() is called with a driver
other than the one that was successfully registered, do nothing.

Previously we'd NULL-out the one that was registered.
But that required the callers to remember what this
routine already remembers.  With this check, the callers
can be simplified.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/driver.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 2257004..30bcd44 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -49,7 +49,8 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 		return;
 
 	spin_lock(&cpuidle_driver_lock);
-	cpuidle_curr_driver = NULL;
+	if (drv == cpuidle_curr_driver)
+		cpuidle_curr_driver = NULL;
 	spin_unlock(&cpuidle_driver_lock);
 }
 
-- 
1.6.0.6
