From: Tejun Heo <tj@kernel.org>
Subject: [PATCH pm-freezer 3/4] freezer: check freezing() before
 leaving FROZEN state
Date: Mon, 29 Aug 2011 16:05:49 +0200
Message-ID: <20110829140549.GD18871__5852.96724825657$1314626967$gmane$org@mtj.dyndns.org>
References: <20110829140418.GB18871@mtj.dyndns.org>
	<20110829140509.GC18871@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110829140509.GC18871@mtj.dyndns.org>
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

If another freeze happens before all tasks leave FROZEN state after
being thawed, the freezer can see the existing FROZEN and consider the
tasks to be frozen but they can clear FROZEN without checking the new
freezing().  Check freezing() while holding freezer_lock before
clearing FROZEN.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/freezer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: work/kernel/freezer.c
===================================================================
--- work.orig/kernel/freezer.c
+++ work/kernel/freezer.c
@@ -60,6 +60,7 @@ bool __refrigerator(bool check_kthr_stop
 	 */
 	spin_lock_irq(&freezer_lock);
 	current->flags |= PF_FROZEN;
+refreeze:
 	spin_unlock_irq(&freezer_lock);
 
 	save = current->state;
@@ -78,8 +79,10 @@ bool __refrigerator(bool check_kthr_stop
 		schedule();
 	}
 
-	/* leave FROZEN */
+	/* leave FROZEN after checking freezing() holding freezer_lock */
 	spin_lock_irq(&freezer_lock);
+	if (freezing(current))
+		goto refreeze;
 	current->flags &= ~PF_FROZEN;
 	spin_unlock_irq(&freezer_lock);
 
