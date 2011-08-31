From: Tejun Heo <tj@kernel.org>
Subject: [PATCH pm-freezer 1/4] cgroup_freezer: fix
 freezer->state setting bug in freezer_change_state()
Date: Wed, 31 Aug 2011 12:21:07 +0200
Message-ID: <20110831102100.GA2828__2778.27269533208$1314909904$gmane$org@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@redhat.com>, Paul Menage <paul@paulmenage.org>
Cc: containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

d02f52811d0e "cgroup_freezer: prepare for removal of TIF_FREEZE" moved
setting of freezer->state into freezer_change_state(); unfortunately,
while doing so, when it's beginning to freeze tasks, it sets the state
to CGROUP_FROZEN instead of CGROUP_FREEZING ending up skipping the
whole freezing state.  Fix it.

-v2: Oleg pointed out that re-freezing FROZEN cgroup could increment
     system_freezing_cnt.  Fixed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Menage <paul@paulmenage.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
I'm in the process of moving and can only use a quite old laptop.  I
tested compile but couldn't really do much else, so please proceed
with caution.  Oleg, can you please ack the patches if you agree with
the updated versions?

Thanks.

 kernel/cgroup_freezer.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

Index: work/kernel/cgroup_freezer.c
===================================================================
--- work.orig/kernel/cgroup_freezer.c
+++ work/kernel/cgroup_freezer.c
@@ -308,24 +308,26 @@ static int freezer_change_state(struct c
 	spin_lock_irq(&freezer->lock);
 
 	update_if_frozen(cgroup, freezer);
-	if (goal_state == freezer->state)
-		goto out;
-
-	freezer->state = goal_state;
 
 	switch (goal_state) {
 	case CGROUP_THAWED:
-		atomic_dec(&system_freezing_cnt);
-		unfreeze_cgroup(cgroup, freezer);
+		if (freezer->state != CGROUP_THAWED) {
+			freezer->state = CGROUP_THAWED;
+			atomic_dec(&system_freezing_cnt);
+			unfreeze_cgroup(cgroup, freezer);
+		}
 		break;
 	case CGROUP_FROZEN:
-		atomic_inc(&system_freezing_cnt);
-		retval = try_to_freeze_cgroup(cgroup, freezer);
+		if (freezer->state == CGROUP_THAWED) {
+			freezer->state = CGROUP_FREEZING;
+			atomic_inc(&system_freezing_cnt);
+			retval = try_to_freeze_cgroup(cgroup, freezer);
+		}
 		break;
 	default:
 		BUG();
 	}
-out:
+
 	spin_unlock_irq(&freezer->lock);
 
 	return retval;
