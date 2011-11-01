From: Tejun Heo <tj@kernel.org>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Tue, 1 Nov 2011 13:19:02 -0700
Message-ID: <20111101201902.GA1763@google.com>
References: <20111101124759.GA1326@zeus> <20111101164235.GS18855@google.com>
	<20111101191459.GA2748@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111101191459.GA2748@zeus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Watts <akwatts@ymail.com>
Cc: linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 02:15:16PM -0500, Andrew Watts wrote:
> On Tue, Nov 01, 2011 at 09:42:35AM -0700, Tejun Heo wrote:
> > 
> > Does the following patch fix the problem?
> > 
> > Thanks.
> 
> Unfortunately, it does not fix the problem.

Odd... how about the following one?  Thanks.

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index ba70058..14d560a 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -299,9 +299,8 @@ static int serio_queue_event(void *object, struct module *owner,
 	event->owner = owner;
 
 	list_add_tail(&event->node, &serio_event_list);
-	queue_work(system_long_wq, &serio_event_work);
-
 out:
+	queue_work(system_long_wq, &serio_event_work);
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 	return retval;
 }
