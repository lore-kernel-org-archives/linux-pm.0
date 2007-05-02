From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 2 May 2007 15:43:59 +0200
Message-ID: <200705021544.00349.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz>
	<1178094106.13233.39.camel@johannes.berg>
	<20070502091633.GA10245@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070502091633.GA10245@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 May 2007 11:16, Pavel Machek wrote:
> Hi!
> 
> > > Well, having a look on the ACPI spec I'm thinking that what we're trying to do
> > > with this patch is actually wrong.
> > 
> > No idea :)
> > 
> > > Instead, we should rip off all of the invocations of pm_ops->whatever() from
> > > the hibernation code paths (with the below exceptions) and *if* the platform
> > > method is to be used, call pm_ops to make the system go down, in the following
> > > way:
> > > 1) call pm_ops->prepare(PM_SUSPEND_DISK)
> > > 2) suspend devices (ie. call device_suspend() etc.)
> > > 3) call pm_ops->enter(PM_SUSPEND_DISK)
> > > and if that *fails* (ie. pm_ops->enter() returns):
> > > 4) call pm_ops->finish(PM_SUSPEND_DISK)
> > > 5) halt the system
> > 
> > Can we still split that off to another method so we don't use pm_ops? No
> > matter how we invoke hibernation_ops or in what order, imho we shouldn't
> > use pm_ops.
> 
> Well... the powerdown during hibernation... does not have _anything_
> to do with snapshot/restore.

Agreed.

> It is really a very deep sleep; similar to soft powerdown, but not quite.

Yeah, not quite.  For example, we may want to use some devices for waking up
the system, but with the current code it's impossible, because pm_ops->finish()
disables this capability of devices.

I think we shouldn't confuse the quiescing of devices before the image creation
with a power transition.  This is not a power transition, since it's not
completed by calling pm_ops->enter().  Instead, we kinda-sorta abort it with
pm_ops->finish() which confuses the heck out of the ACPI firmware (please
see my reply to Alexey in the same thread for a detailed analysis).

> So this usage of pm_ops seems ok.

To me, it doesn't.  These are the main problems I see with it:
1) device_suspend() should be called before the _PTS method is executed (IMO
it's correct not to execute _PTS at all if we don't want to do a real power
transition)
2) The _GTS method shouldn't be executed in acpi_pm_prepare(), but instead
should be executed in acpi_pm_enter(), right before the transition is completed
3) The _BFS method shouldn't be executed in the resume-during-hibernation
code path
4) The wake-up capability of devices should be enabled before we execute
pm_ops->enter() and shouldn't be enabled before the image creation (what for?).
5) The first part of 4) requires that the transition be started over after the
image has been saved.

Greetings,
Rafael
