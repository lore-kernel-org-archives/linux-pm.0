From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: do not use pm_ops (was: Re: suspend2
	merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sun, 29 Apr 2007 14:53:26 +0200
Message-ID: <200704291453.27220.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz>
	<1177605074.6814.93.camel@johannes.berg>
	<200704291448.44855.Rafal.Wysocki@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704291448.44855.Rafal.Wysocki@fuw.edu.pl>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 29 April 2007 14:48, R. J. Wysocki wrote:
> [Trimmed the CC list to a reasonable minimum]
> 
> On Thursday, 26 April 2007 18:31, Johannes Berg wrote:
> > On Thu, 2007-04-26 at 13:30 +0200, Pavel Machek wrote:
> > 
> > > > From looking at pm_ops which I was recently working with a lot, it seems
> > > > that it was designed by somebody who was reading the ACPI documentation
> > > > and was otherwise pretty clueless, even at that level std tries to look
> > > > like suspend. IMHO that is one of the first things that should be ripped
> > > > out, no pm_ops for STD, it's a pain to work with.
> > > 
> > > That code goes back to Patrick, AFAICT. (And yes, ACPI S3 and ACPI S4
> > > low-level enter is pretty similar).
> > > 
> > > Patches would be welcome
> > 
> > That was easier than I thought. This applies on top of a patch that
> > makes kernel/power/user.c optional since I had no idea how to fix it,
> > problems I see:
> >  * it surfaces kernel implementation details about pm_ops and thus makes
> >    the whole thing very fragile
> >  * it has yet another interface (yuck) to determine whether to reboot,
> >    shut down etc, doesn't use /sys/power/disk
> >  * I generally had no idea wtf it is doing in some places
> > 
> > Anyway, this patch is only compile tested, it
> >  * introduces include/linux/hibernate.h with hibernate_ops and
> >    a new hibernate() function to hibernate the system
> >  * rips apart a lot of the suspend code and puts it back together using
> >    the hibernate_ops
> >  * switches ACPI to hibernate_ops (the only user of pm_ops.pm_disk_mode)
> >  * might apply/compile against -mm, I have all my and some of Rafael's
> >    suspend/hibernate work in my tree.
> >  * breaks user suspend as I noted above
> >  * is incomplete, somewhere pm_suspend_disk() is still defined iirc
> 
> OK, I reworked it a bit.
> 
> Main changes:
> 
> - IMHO 'hibernation_ops' sounds better than 'hibernate_ops', for example, so
> now the new names start with 'hibernation_' (or 'HIBERNATION_')
> 
> - Moved the hibernation-related definitions to include/linux/suspend.h, since
> some hibernation-specific definitions are already there.  We can introduce
> hibernation.h in a separate patch (it'll have to #include suspend.h IMO).
> 
> - Changed the names starting from 'pm_disk_' (or 'PM_DISK_').
> 
> - Cleaned up the new ACPI code (it didn't compile and included some things
> unrelated to hibernation).  I'm still not sure about acpi_hibernation_finish()
> (is the code after acpi_disable_wakeup_device() really needed?)
> 
> - Made kernel/power/user.c compile (and hopefully work too)

Forgot to say that hibernation_ops is needed, IMO, because ACPI can be modular.

Greetings,
Rafael
