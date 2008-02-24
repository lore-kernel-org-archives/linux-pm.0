From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 21:11:05 +0100
Message-ID: <20080224201105.GC18908__40204.2382899255$1203883945$gmane$org@elf.ucw.cz>
References: <20080224182120.GB3886@ucw.cz>
	<Pine.LNX.4.44L0.0802241358080.11145-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802241358080.11145-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > @@ -25,6 +25,7 @@
> > >  #include <linux/pm.h>
> > >  #include <linux/resume-trace.h>
> > >  #include <linux/rwsem.h>
> > > +#include <linux/sched.h>
> > >  
> > >  #include "../base.h"
> > >  #include "power.h"
> > > @@ -59,6 +60,13 @@ static DECLARE_RWSEM(pm_sleep_rwsem);
> > >  
> > >  int (*platform_enable_wakeup)(struct device *dev, int is_on);
> > >  
> > > +static struct task_struct *suspending_task;
> > 
> > What locking protects this variable? What happens when suspending_task
> > exits? (Hmm, that would probably be bug, anyway?)
> 
> It's protected by whatever existing locking scheme allows only one
> task to start a system sleep at a time.  For example, the suspending 
> task has to get a write lock on pm_sleep_rwsem.

And readers of suspending_task are protected by?

At the very least, you'd need rmb() before reading it and wmb() after
writing to it, but I'm not sure if that's enough on every obscure
architecture out there.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
