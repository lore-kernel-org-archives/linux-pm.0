From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in disk.c" et al.
Date: Fri, 23 Feb 2007 14:25:36 +0100
Message-ID: <200702231425.38217.rjw@sisk.pl>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702231254.47009.rjw@sisk.pl>
	<1172233076.3870.26.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1172233076.3870.26.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Dave Vasilevsky <djvasi@gmail.com>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 23 February 2007 13:17, Johannes Berg wrote:
> [correcting address for Nigel]
> =

> Hi Rafael,
> =

> > Hm, the only freezable workqueues I was aware of were those in XFS.
> =

> Well, I have an XFS root fs.

I see.

> In fact, the one that was mostly causing it was the xfs one, but I'm not
> sure it was all the time. The same bug happens at resume time (if I manua=
lly
> offline all nonboot CPUs before suspend), at which point I couldn't tell
> whether it was XFS or something else.

Probably XFS too.

> > Moreover, the patch has got _a_ _lot_ of testing on SMP on x86_64
> > and I believe it works for people on i386 too.  So the workqueues in qu=
estion
> > seem to be architecture-specific.  Is that correct?
> =

> There could be some arch-specific workqueues as well, but at least in
> one case I saw xfsdatad causing it.

Yes, that makes sense.

In that case the fastest fix would be to revert the commit in question (and
some others too), but I don't think it will be satisfactory for the people =
with
the ACPI issues related to the resume code ordering.  Moreover, it really
is more reasonable to disable nonboot CPUs after tasks have been frozen
(I think it's also necessary for the CPU hotplugging with the help of the
freezer; see below).

I'll try to find a better solution later today.

[Why, o why people don't test -mm kernels???  The patch that causes the pro=
blem
has been in -mm since 2.6.20-rc2-mm1 and _nobody_ has reported any problem
with it until now.  Sigh.]

> > > (1) would work, but also only punts the problem until someone wants to
> > > do multi-threaded suspend (as if...).
> > =

> > It will also break symmetry with the resume code that has to be like th=
is
> > because of ACPI-related issues.
> =

> Ok. I don't have any ACPI issues due to the lack of ACPI ;)

Lucky you. ;-)

> > > (2a) would sort-of work, but what if someone unplugs a CPU while the
> > > system is suspended [will that even work]? the thread would get really
> > > stuck there, bound to a CPU that no longer exists.
> > =

> > Right now we are working on using the task freezer for CPU hotplugging =
and if
> > that works, this won't be an issue.
> =

> Care to elaborate? It doesn't seem to make sense to freeze tasks that
> are running on some other CPU if that one is going offline, but I'm
> probably misunderstanding you here.

The idea is to freeze tasks every time before CPUs are hot(un)plugged.  This
way we can avoid nasty locking-related issues that have been haunting us
for some time.  And yes, we are going to freeze all tasks for this purpose,
although it seems inefficient at first sight.

Of course if we do it, the suspend code will have to be changed so that the
freezing of tasks related to the CPU hotplug doesn't interfere with the
freezing of tasks related to the suspend in a destructive way.  Then, proba=
bly,
the problem you have discovered will go away automatically.

For this reason I'd like to keep the ordering of code in disk.c as it is no=
w,
because something like

freeze_processes(SUSPEND)
...
freeze_processes(CPU_HOTPLUG)
...
thaw_processes(CPU_HOTPLUG)
...
thaw_processes(SUSPEND)

seems to be more logical than any other ordering.

> > I'd like to first understand why the workqueues in question here are fr=
eezable.
> =

> I don't think that matters much. We can't have freezable per-CPU
> workqueues and then forbid using them.

Yes.

> > Could you please check if the appended patch (on top of the commit you =
have
> > reverted) changes anything?
> =

> I can give it a go, but it doesn't look as though it'd help. It still
> freezes all threads before disabling CPUs, and my debugging certainly
> pinpointed to kthread_stop() in the workqueue.

Yes, you're right.

I wasn't quite sure which workqueues were causing the problem, but if that's
XFS, I know enough.

The fix is needed, because we'd like to make the majority of worqueues
freezable, but the return to the old code ordering doesn't seem to be a good
solution in the long run.

Greetings,
Rafael
