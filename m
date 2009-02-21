From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 10:47:25 +0100
Message-ID: <200902211047.26787.rjw__33333.1967042342$1235209799$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902210057.27781.rjw@sisk.pl>
	<d6200be20902201708g45540f60ib024c3365c85aef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902201708g45540f60ib024c3365c85aef4@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Fri, Feb 20, 2009 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Fri, Feb 20, 2009 at 7:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> On Fri, Feb 20, 2009 at 2:49 AM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
> >> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> >> On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> >> >> >> >> > It might have to be platform-specific.  The Android people =
seem to have a
> >> >> >> >> > pretty good idea of what criteria will work for them.
> >> >> >> >>
> >> >> >> >> I'd really like to know in what situations Androind is suppos=
ed to suspend
> >> >> >> >> automatically.
> >> >> >> >
> >> >> >> > It might be better to ask in what situations Android is _not_ =
supposed
> >> >> >> > to sleep automatically.  In other words, in what situations is=
 a
> >> >> >> > wakelock acquired?  Since the whole system is only a phone, th=
is
> >> >> >> > question should have a reasonably well-defined answer.
> >> >> >>
> >> >> >> On an android phone, any code that needs to run when the screen =
is off
> >> >> >> must hold a wakelock (directly or indirectly). In general if an
> >> >> >> application or the system is processing an event that may cause =
a user
> >> >> >> notification (new email, incoming phone call, alarm, etc.) it ne=
eds to
> >> >> >> prevent suspend. But, we also use wakelocks to upload stats or
> >> >> >> download system updates in the background, and for media player =
or
> >> >> >> (gps) data logging applications.
> >> >> >
> >> >> > All of this doesn't seem to require wakelocks acuired from kernel=
 space.
> >> >> > What do you need those wakelocks for?
> >> >>
> >> >> Most events do not originate in user-space. Alarms start in our ala=
rm
> >> >> driver which locks a wakelock when its timer interrupt occurs. This
> >> >> wakelock stays locked until the user-space alarm manager calls the
> >> >> driver to wait for the next alarm. I've described how input events =
are
> >> >> handled before. Without kernel wakelocks, if the user space power
> >> >> manager had already turned off the screen and decided to suspend ri=
ght
> >> >> before a wakeup key is pressed, then that key could sit in the
> >> >> in-kernel input queue until another key is pressed. Even if the
> >> >> user-space thread read the key event before being frozen, it cannot
> >> >> abort the suspend operation that was already started.
> >> >
> >> > OK, so what about the following approach:
> >> >
> >> > * Keep the decision making logic (power manager etc.) in user space.=
  Reasons:
> >> >  - It may be arbitrarily complicated
> >> >  - It may include such things as s2ram quirks or hal quirks needed f=
or some
> >> >    graphics adapters
> >>
> >> I don't using wakelocks in any different in this respect. When user
> >> space decides that it is ok for the kernel to suspend it should have
> >> performed all theses steps in both cases.
> >
> > If automatic suspend is to be started by the kernel, you have to make s=
ure
> > that at least one wakelock is held until these steps are completed.  Th=
at may
> > be somewhat tricky in general.
> =

> That is not tricky. If your code holds a wakelock, then at least one
> wakelock is held.

I meant, if one task releases its wakelock and another one takes a wakelock,
you have to make sure there's no window between those events.  Of course,
you can have a single task holding a wakelock all the time and releasing it
when it makes sure everything is ready, but then it would act as a user spa=
ce
power manager anyway.

> >> > * Have a per-process (per-task or per-thread group, but the former w=
ould be
> >> >  easier IMO) "I_do_not_want_automatic_suspend_to_occur" flag.
> >>
> >> A per-process (thread group) flag allows wakelocks to be implemented
> >> in a user space library. A per-thread flag does not. However, I don't
> >> see much benefit in tying this to a process instead of using a file
> >> descriptor.
> >
> > Using a flag would allow us to remove the window between checking the
> > wakelocks and freezing tasks (in principle a task may take a wakelock j=
ust
> > before it's frozen).
> =

> You can check if there are wakelocks held from the same spot as you
> check your flag.

That would be _much_ more complicated and much less efficient (browsing a l=
ist
vs checking a flag).  And it would require additional locking if it's to be
done in a non-racy way.

> >> > * Add a new callback, say ->acknowledge(), to the set of each driver=
's PM
> >> >  operations, that will be called to check if the driver has anything=
 against
> >> >  automatic suspend (true - suspend can happen right now, false - sus=
pend can't
> >> >  happen).
> >> >
> >> > * Introduce /sys/power/sleep that will work like /sys/power/state, b=
ut:
> >> >  - First, it will call ->acknowledge() for each driver (via bus type=
s) to
> >> >    check if any of them wants to postpone the suspend (this will pre=
vent tasks
> >> >    from being frozen unnecessarily if it is known in advance that th=
e suspend
> >> >    should not happen at the moment).
> >> >  - Next, it will check the "I_do_not_want_automatic_suspend_to_occur=
" flag
> >> >    of each process and the suspend will be aborted if it is true for=
 any of
> >> >    them (quite frankly, I think that should be integrated with the f=
reezer,
> >> >    in particular the tasks that have TIF_FREEZE set shouldn't be abl=
e to set
> >> >    this flag and it should be checked in the freezer loop for every =
task with
> >> >    TIF_FREEZE unset).
> >> >  - Next, it will proceed with suspending just like /sys/power/state =
does (the
> >> >    drivers that missed the opportunity to abort the suspend by retur=
ning
> >> >    'false' from ->acknowledge() can still abort the suspend by faili=
ng their
> >> >    ->suspend() routines).
> >> >
> >> > Then, the decision making logic will be able to use /sys/power/sleep=
 whenever
> >> > it wishes to and the kernel will be able to refuse to suspend if it'=
s not
> >> > desirable at the moment.
> >> >
> >> > It seems to be flexible enough to me.
> >>
> >> This seems flexible enough to avoid race conditions, but it forces the
> >> user space power manager to poll when the kernel refuse suspend.
> >
> > And if the kernel is supposed to start automatic suspend, it has to mon=
itor
> > all of the wakelocks.  IMO, it's better to allow the power manager to p=
oll the
> > kernel if it refuses to suspend.
> =

> What is better about polling in userspace?

One kernel thread less, for example?

> >> Also, like my original wakelock patches, it breaks sleep requests thro=
ugh
> >> /sys/power/state when there are input events queued.
> >
> > The idea is to have both /sys/power/state and /sys/power/sleep at the s=
ame
> > time, where /sys/power/state will work just like it does right now.  Su=
re,
> > there must be mutual exclusion between the two, but that's a matter of
> > implementation IMO.
> =

> If you want to only prevent suspend though one interface, you have to
> also pass information to the driver about its suspend hook is being
> called so it can conditionally return -EBUSY. The wakelock interface
> requires less code in each driver.

Well, I don't think so.  Moreover, it requires you to spread wakelocks all
over the place if you don't use the timeouted ones which, let's face it, is
hardly acceptable.

Thanks,
Rafael
