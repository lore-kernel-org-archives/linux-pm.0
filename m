From: tom.leiming@gmail.com
Subject: [PATCH] PM / Runtime: pm_runtime_idle can be called in
	atomic context
Date: Fri,  9 Sep 2011 00:06:01 +0800
Message-ID: <1315497961-15481-1-git-send-email-tom.leiming@gmail.com>
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
To: rjw@sisk.pl, stern@rowland.harvard.edu
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Ming Lei <tom.leiming@gmail.com>

Add to pm_runtime_idle the list of functions that can be called
in atomic context if pm_runtime_irq_safe() has been called for the
device.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 Documentation/power/runtime_pm.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 08d70e4..1f05404 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -477,6 +477,7 @@ pm_runtime_autosuspend_expiration()
 If pm_runtime_irq_safe() has been called for a device then the following helper
 functions may also be used in interrupt context:
 
+pm_runtime_idle()
 pm_runtime_suspend()
 pm_runtime_autosuspend()
 pm_runtime_resume()
-- 
1.7.4.1
