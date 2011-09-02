From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] cgroup_freezer: fix freezer->state setting
	bug in freezer_change_state()
Date: Sat,  3 Sep 2011 03:27:45 +0900
Message-ID: <1314988070-12244-2-git-send-email-tj__4619.11610696024$1314988194$gmane$org@kernel.org>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314988070-12244-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oleg@redhat.com, matthltc@us.ibm.com, rjw@sisk.pl, paul@paulmenage.org
Cc: Tejun Heo <tj@kernel.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

d02f52811d0e "cgroup_freezer: prepare for removal of TIF_FREEZE" moved
setting of freezer->state into freezer_change_state(); unfortunately,
while doing so, when it's beginning to freeze tasks, it sets the state
to CGROUP_FROZEN instead of CGROUP_FREEZING ending up skipping the
whole freezing state.  Fix it.

-v2: Oleg pointed out that re-freezing FROZEN cgroup could increment
     system_freezing_cnt.  Fixed.

-v3: Matt pointed out that setting CGROUP_FROZEN always invoked
     try_to_freeze_cgroup() regardless of the current state.  Patch
     updated such that the actual freeze/thaw operations are always
     performed on state changes.  This shouldn't make any difference
     unless something is broken.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Menage <paul@paulmenage.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/cgroup_freezer.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup_freezer.c b/kernel/cgroup_freezer.c
index 4e82525..56a457a 100644
--- a/kernel/cgroup_freezer.c
+++ b/kernel/cgroup_freezer.c
@@ -308,24 +308,24 @@ static int freezer_change_state(struct cgroup *cgroup,
 	spin_lock_irq(&freezer->lock);
 
 	update_if_frozen(cgroup, freezer);
-	if (goal_state == freezer->state)
-		goto out;
-
-	freezer->state = goal_state;
 
 	switch (goal_state) {
 	case CGROUP_THAWED:
-		atomic_dec(&system_freezing_cnt);
+		if (freezer->state != CGROUP_THAWED)
+			atomic_dec(&system_freezing_cnt);
+		freezer->state = CGROUP_THAWED;
 		unfreeze_cgroup(cgroup, freezer);
 		break;
 	case CGROUP_FROZEN:
-		atomic_inc(&system_freezing_cnt);
+		if (freezer->state == CGROUP_THAWED)
+			atomic_inc(&system_freezing_cnt);
+		freezer->state = CGROUP_FREEZING;
 		retval = try_to_freeze_cgroup(cgroup, freezer);
 		break;
 	default:
 		BUG();
 	}
-out:
+
 	spin_unlock_irq(&freezer->lock);
 
 	return retval;
-- 
1.7.6
