From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT][PATCH] swsusp: Change code ordering related to
	ACPI
Date: Fri, 4 May 2007 21:43:23 +0200
Message-ID: <200705042143.24467.rjw__33458.7292200469$1178307601$gmane$org@sisk.pl>
References: <200705041143.02451.rjw@sisk.pl>
	<8f8ff01d0705041136r18315079w13f95dc3c627a53b@mail.gmail.com>
	<8f8ff01d0705041137q28720f76j15b0b4abf585302f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f8ff01d0705041137q28720f76j15b0b4abf585302f@mail.gmail.com>
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
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 20:37, Alexey Starikovskiy wrote:
> Sorry, I meant executing _WAK _after_ resume of devices...

Somehow, that's what we've done for several months at the very least.
Moreover, my test boxes apparently don't care.

OTOH, evidently, some systems have been broken by moving the call to
acpi_pm_finish() before device_resume().  This seems to implicate that there
are two parts of code in acpi_pm_finish(), one that should be executed before
device_resume(), including the _WAK method, and the other that should be
executed after device_resume().  Now, the question is how to split it into
these parts.

Greetings,
Rafael


> On 5/4/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> > Doing _WAK (from pm_finish) before device_resume will brake almost all
> > ACPI devices.
> >
> > Regards,
> > Alex.
> >
> > On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > Hi,
> > >
> > > The change of the hibernation/suspend code ordering made before 2.6.21 has
> > > caused some systems to have problems related to ACPI.  In particular, the
> > > 'platform' hibernation mode doesn't work any more on some systems.
> > >
> > > It has been confirmed that the appended patch fixes the problem, but it's not
> > > certain if this changes don't break some other systems.  For this reason, all
> > > users of hibernation (swsusp, uswsusp) are gently requested to verify if this
> > > patch doesn't break their systems.
> > >
> > > Greetings,
> > > Rafael
> > >
> > > ---
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >
> > > The current code ordering in the hibernation code paths causes some systems to
> > > have problems.  It has been confirmed by testers that these problems do not
> > > appear if the acpi_pm_finish() function (called via platform_finish()) is
> > > executed after device_suspend().
> > >
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  kernel/power/disk.c |    4 ++--
> > >  kernel/power/user.c |    8 ++++----
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > Index: linux-2.6.21/kernel/power/disk.c
> > > ===================================================================
> > > --- linux-2.6.21.orig/kernel/power/disk.c       2007-05-04 10:31:51.000000000 +0200
> > > +++ linux-2.6.21/kernel/power/disk.c    2007-05-04 10:32:12.000000000 +0200
> > > @@ -195,9 +195,9 @@ int hibernate(void)
> > >
> > >         if (in_suspend) {
> > >                 enable_nonboot_cpus();
> > > -               platform_finish();
> > >                 device_resume();
> > >                 resume_console();
> > > +               platform_finish();
> > >                 pr_debug("PM: writing image.\n");
> > >                 error = swsusp_write();
> > >                 if (!error)
> > > @@ -214,9 +214,9 @@ int hibernate(void)
> > >   Enable_cpus:
> > >         enable_nonboot_cpus();
> > >   Resume_devices:
> > > -       platform_finish();
> > >         device_resume();
> > >         resume_console();
> > > +       platform_finish();
> > >   Thaw:
> > >         mutex_unlock(&pm_mutex);
> > >         unprepare_processes();
> > > Index: linux-2.6.21/kernel/power/user.c
> > > ===================================================================
> > > --- linux-2.6.21.orig/kernel/power/user.c       2007-05-04 10:31:51.000000000 +0200
> > > +++ linux-2.6.21/kernel/power/user.c    2007-05-04 10:32:12.000000000 +0200
> > > @@ -169,11 +169,11 @@ static inline int snapshot_suspend(int p
> > >         }
> > >         enable_nonboot_cpus();
> > >   Resume_devices:
> > > +       device_resume();
> > > +       resume_console();
> > >         if (platform_suspend)
> > >                 platform_finish();
> > >
> > > -       device_resume();
> > > -       resume_console();
> > >   Finish:
> > >         mutex_unlock(&pm_mutex);
> > >         return error;
> > > @@ -201,11 +201,11 @@ static inline int snapshot_restore(int p
> > >
> > >         enable_nonboot_cpus();
> > >   Resume_devices:
> > > +       device_resume();
> > > +       resume_console();
> > >         if (platform_suspend)
> > >                 platform_finish();
> > >
> > > -       device_resume();
> > > -       resume_console();
> > >   Finish:
> > >         pm_restore_console();
> > >         mutex_unlock(&pm_mutex);
> > > _______________________________________________
> > > linux-pm mailing list
> > > linux-pm@lists.linux-foundation.org
> > > https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> > >
> >
> 
> 

-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
