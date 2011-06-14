From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] power: opp: Fix rcu_dereference_check() without
	protection!
Date: Tue, 14 Jun 2011 18:33:20 +0530
Message-ID: <1308056600-17601-1-git-send-email-santosh.shilimkar__24020.6600436524$1308056684$gmane$org@ti.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With RCU debug options enabled, below warning is observed.

===================================================
[ INFO: suspicious rcu_dereference_check() usage. ]
---------------------------------------------------
drivers/base/power/opp.c:151 invoked rcu_dereference_check() without protection!

other info that might help us debug this:

rcu_scheduler_active = 1, debug_locks = 1
no locks held by swapper/1.
...

---------------------------------------------------

Fix the same by protecting it with rcu_read lock.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/base/power/opp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 56a6899..cbed5e1 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -148,7 +148,9 @@ unsigned long opp_get_voltage(struct opp *opp)
 	struct opp *tmp_opp;
 	unsigned long v = 0;
 
+	rcu_read_lock();
 	tmp_opp = rcu_dereference(opp);
+	rcu_read_unlock();
 	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
-- 
1.6.0.4
