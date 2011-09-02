From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
	freezer->state	setting bug in freezer_change_state()
Date: Fri, 2 Sep 2011 19:30:39 +0200
Message-ID: <20110902173039.GA9039__3159.53169852055$1314984933$gmane$org@redhat.com>
References: <20110831102100.GA2828@mtj.dyndns.org>
	<20110902004231.GF1919@count0.beaverton.ibm.com>
	<20110902165839.GA7478@redhat.com>
	<20110902170844.GJ2752@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110902170844.GJ2752@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Paul Menage <paul@paulmenage.org>
List-Id: linux-pm@vger.kernel.org

On 09/03, Tejun Heo wrote:
>
> Can you please wait a bit?

Sure. But just in case, I mean the simple patch below.

Feel free to incorporate into 4/4, or I can resend it later.

Oleg.

------------------------------------------------------------------------------
[PATCH] freezer: remove the pointless/unsafe __thaw_task()->recalc_sigpending_and_wake()

Remove __thaw_task()->recalc_sigpending_and_wake(). It was copied from
cancel_freezing() recently, but it was always wrong.

It is pointless, contary to the comment it can't clear TIF_SIGPENDING.
Not to mention, we must never do this with !current task, this is wrong.

The usage of ->sighand is not safe if the caller is cgroup_freezer, we
can racw with exit.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---

 kernel/freezer.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- 3.1/kernel/freezer.c~kill_rspaw	2011-09-02 18:52:46.000000000 +0200
+++ 3.1/kernel/freezer.c	2011-09-02 19:03:30.000000000 +0200
@@ -150,18 +150,10 @@ void __thaw_task(struct task_struct *p)
 	 * be visible to @p as waking up implies wmb.  Waking up inside
 	 * freezer_lock also prevents wakeups from leaking outside
 	 * refrigerator.
-	 *
-	 * If !FROZEN, @p hasn't reached refrigerator, recalc sigpending to
-	 * avoid leaving dangling TIF_SIGPENDING behind.
 	 */
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (frozen(p)) {
+	if (frozen(p))
 		wake_up_process(p);
-	} else {
-		spin_lock(&p->sighand->siglock);
-		recalc_sigpending_and_wake(p);
-		spin_unlock(&p->sighand->siglock);
-	}
 	spin_unlock_irqrestore(&freezer_lock, flags);
 }
 
