From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 2 May 2007 11:16:33 +0200
Message-ID: <20070502091633.GA10245@elf.ucw.cz>
References: <20070425072350.GA6866@ucw.cz>
	<1177945191.5102.93.camel@johannes.berg>
	<200705011605.16993.rjw@sisk.pl> <200705020002.55331.rjw@sisk.pl>
	<1178094106.13233.39.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178094106.13233.39.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Well, having a look on the ACPI spec I'm thinking that what we're trying to do
> > with this patch is actually wrong.
> 
> No idea :)
> 
> > Instead, we should rip off all of the invocations of pm_ops->whatever() from
> > the hibernation code paths (with the below exceptions) and *if* the platform
> > method is to be used, call pm_ops to make the system go down, in the following
> > way:
> > 1) call pm_ops->prepare(PM_SUSPEND_DISK)
> > 2) suspend devices (ie. call device_suspend() etc.)
> > 3) call pm_ops->enter(PM_SUSPEND_DISK)
> > and if that *fails* (ie. pm_ops->enter() returns):
> > 4) call pm_ops->finish(PM_SUSPEND_DISK)
> > 5) halt the system
> 
> Can we still split that off to another method so we don't use pm_ops? No
> matter how we invoke hibernation_ops or in what order, imho we shouldn't
> use pm_ops.

Well... the powerdown during hibernation... does not have _anything_
to do with snapshot/restore. It is really a very deep sleep; similar
to soft powerdown, but not quite.

So this usage of pm_ops seems ok.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
