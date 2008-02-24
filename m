From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 14:03:02 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802241358080.11145-100000__42429.144078824$1203879887$gmane$org@netrider.rowland.org>
References: <20080224182120.GB3886@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080224182120.GB3886@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Feb 2008, Pavel Machek wrote:

> Hi!
> 
> > Index: usb-2.6/drivers/base/power/main.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/base/power/main.c
> > +++ usb-2.6/drivers/base/power/main.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/resume-trace.h>
> >  #include <linux/rwsem.h>
> > +#include <linux/sched.h>
> >  
> >  #include "../base.h"
> >  #include "power.h"
> > @@ -59,6 +60,13 @@ static DECLARE_RWSEM(pm_sleep_rwsem);
> >  
> >  int (*platform_enable_wakeup)(struct device *dev, int is_on);
> >  
> > +static struct task_struct *suspending_task;
> 
> What locking protects this variable? What happens when suspending_task
> exits? (Hmm, that would probably be bug, anyway?)

It's protected by whatever existing locking scheme allows only one
task to start a system sleep at a time.  For example, the suspending 
task has to get a write lock on pm_sleep_rwsem.

Yes, if the suspending task exits before the system has woken up, 
you're in trouble regardless.

> Or are we running UP when this is accessed? This at least needs a big
> fat comment.
> 
> > +bool in_suspend_context(void)
> > +{
> > +	return (suspending_task == current);
> > +}

We aren't necessarily UP.  But since all that matters is whether or not 
suspend_task is equal to the current task, no extra locking is needed.  

I'll add a comment explaining all this.

Alan Stern
