From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/25] PM / Domains: don't use [delayed_]work_pending()
Date: Fri, 21 Dec 2012 17:57:06 -0800
Message-ID: <1356141435-17340-17-git-send-email-tj@kernel.org>
References: <1356141435-17340-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1356141435-17340-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There's no need to test whether a (delayed) work item in pending
before queueing, flushing or cancelling it.  Most uses are unnecessary
and quite a few of them are buggy.

Remove unnecessary pending tests from power domains.  Only compile
tested.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
Please let me know how this patch should be routed.  I can take it
through the workqueue tree if necessary.

Thanks.

 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index acc3a8d..9a6b05a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -433,8 +433,7 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
  */
 void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 {
-	if (!work_pending(&genpd->power_off_work))
-		queue_work(pm_wq, &genpd->power_off_work);
+	queue_work(pm_wq, &genpd->power_off_work);
 }
 
 /**
-- 
1.8.0.2
