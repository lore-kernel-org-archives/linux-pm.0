From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM / Runtime: Use alloc_workqueue() for
	creating PM workqueue
Date: Thu, 16 Sep 2010 20:24:51 +0200
Message-ID: <201009162024.51520.rjw__44423.9235985608$1284662053$gmane$org@sisk.pl>
References: <201009152156.30749.rjw@sisk.pl> <4C91D132.6090607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C91D132.6090607@kernel.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 16, 2010, Tejun Heo wrote:
> Hello, Rafael.
> 
> On 09/15/2010 09:56 PM, Rafael J. Wysocki wrote:
> > I'm not sure about that WQ_RESCUER thing.  Can you please tell me what
> > exactly it is for?
> 
> It's to guarantee forward progress for workqueues which process work
> items which may be used to reclaim memory.  It reserves a rescue
> worker thread to be used under memory pressure.  I finished workqueue
> documentation a few days ago and sent pull request to Linus.
> 
>   http://git.kernel.org/?p=linux/kernel/git/tj/wq.git;a=blob;f=Documentation/workqueue.txt;h=e4498a2872c37a0b3b156ddc7ad7135d030d224d;hb=c54fce6eff197d9c57c97afbf6c9722ce434fc8f
> 
> So, for pm_wq, there's no reason to use WQ_RESUER.
> alloc_workqueue("pm", WQ_FREEZEABLE, 0) should do it.

Great, thanks!

> Thanks for doing it.

No big deal.  Actually I should thank you for making it possible to use
freezable workqueues that are not singlethread. :-)

Updated patch follows.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Runtime: Use alloc_workqueue() for creating the PM workqueue

Although we need the PM workqueue to be freezable, we don't need it
to be singlethread.  Also, the number of concurrent work items
running on a single CPU need not be constrained.  For these reasons
use alloc_workqueue() directly, with suitable arguments, instead of
create_freezeable_workqueue(), to create the runtime PM workqueue.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -308,7 +308,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
-	pm_wq = create_freezeable_workqueue("pm");
+	pm_wq = alloc_workqueue("pm", WQ_FREEZEABLE, 0);
 
 	return pm_wq ? 0 : -ENOMEM;
 }
