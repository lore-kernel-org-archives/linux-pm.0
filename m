From: tom.leiming@gmail.com
Subject: [PATCH] PM: runtime: add missed pm_request_autosuspend
Date: Mon, 27 Sep 2010 18:54:24 +0800
Message-ID: <1285584864-10972-1-git-send-email-tom.leiming@gmail.com>
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

Commit 5789bdd542c6bfbb662915c67bffc14198aa5dda
[PM / Runtime: Implement autosuspend support] introduces
"autosuspend" facility for runtime PM, but misses
helper function of pm_request_autosuspend, so add it.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/pm_runtime.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 99ed1aa..3ec2358 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -164,6 +164,11 @@ static inline int pm_request_resume(struct device *dev)
 	return __pm_runtime_resume(dev, RPM_ASYNC);
 }
 
+static inline int pm_request_autosuspend(struct device *dev)
+{
+	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
+}
+
 static inline int pm_runtime_get(struct device *dev)
 {
 	return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_ASYNC);
-- 
1.6.2.5
