From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 16:26:25 -0700
Message-ID: <20100525232625.GB5331__43384.3083134436$1274830054$gmane$org@core.coreip.homeip.net>
References: <201005251124.58017.dmitry.torokhov@gmail.com>
	<Pine.LNX.4.44L0.1005251428090.1634-100000@iolanthe.rowland.org>
	<20100525184740.GA4248@core.coreip.homeip.net>
	<AANLkTik7eKNIqMFGVl6OzpqBnhvjet9puUQDCRkrabkg@mail.gmail.com>
	<20100525223220.GC4928@core.coreip.homeip.net>
	<AANLkTinnSH_egFYowkOQiYHL87QfIH332i1__OaTem-s@mail.gmail.com>
	<20100525225544.GA5331@core.coreip.homeip.net>
	<AANLkTikaoXH5T4FJ5sY9OnAyjhaY8wa7rH6S7_k9F_m8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikaoXH5T4FJ5sY9OnAyjhaY8wa7rH6S7_k9F_m8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 25, 2010 at 04:13:35PM -0700, Arve Hj=F8nnev=E5g wrote:
> 2010/5/25 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Tue, May 25, 2010 at 03:37:48PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> 2010/5/25 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> >> > On Tue, May 25, 2010 at 03:23:23PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> >> On Tue, May 25, 2010 at 11:47 AM, Dmitry Torokhov
> >> >> <dmitry.torokhov@gmail.com> wrote:
> >> >> > On Tue, May 25, 2010 at 02:35:17PM -0400, Alan Stern wrote:
> >> >> >> On Tue, 25 May 2010, Dmitry Torokhov wrote:
> >> >> >>
> >> >> >> > > Here's the scenario:
> >> >> >> > >
> >> >> >> > > The system is awake, and the user presses a key. The keyboar=
d driver
> >> >> >> > > processes the keystroke and puts it in an input queue. =A0A =
user process
> >> >> >> > > reads it from the event queue, thereby emptying the queue.
> >> >> >> > >
> >> >> >> > > At that moment, the system decides to go into opportunistic =
suspend.
> >> >> >> > > Since the input queue is empty, there's nothing to stop it. =
=A0As the
> >> >> >> > > first step, userspace is frozen -- before the process has a =
chance to
> >> >> >> > > do anything with the keystroke it just read. =A0As a result,=
 the system
> >> >> >> > > stays asleep until something else wakes it up, even though t=
he
> >> >> >> > > keystroke was important and should have prevented it from sl=
eeping.
> >> >> >> > >
> >> >> >> > > Suspend blockers protect against this scenario. =A0Here's ho=
w:
> >> >> >> > >
> >> >> >> > > The user process doesn't read the input queue directly; inst=
ead it
> >> >> >> > > does a select or poll. =A0When it sees there is data in the =
queue, it
> >> >> >> > > first acquires a suspend blocker and then reads the data.
> >> >> >> > >
> >> >> >> > > Now the system _can't_ go into opportunistic suspend, becaus=
e a suspend
> >> >> >> > > blocker is active. =A0The user process can do whatever it wa=
nts with the
> >> >> >> > > keystroke. =A0When it is finished, it releases the suspend b=
locker and
> >> >> >> > > loops back to the select/poll call.
> >> >> >> > >
> >> >> >> >
> >> >> >> > What you describe can be done in userspace though, via a "susp=
end manager"
> >> >> >> > process. Tasks reading input events will post "busy" events to=
 stop the
> >> >> >> > manager process from sending system into suspend. But this can=
 be confined to
> >> >> >> > Android userspace, leaving the kernel as is (well, kernel need=
s to be modified
> >> >> >> > to not go into suspend with full queues, but that is using exi=
sting kernel
> >> >> >> > APIs).
> >> >> >>
> >> >> >> I think that could be made to work. =A0And it might remove the n=
eed for
> >> >> >> the userspace suspend-blocker API, which would be an advantage. =
=A0It
> >> >> >> could even remove the need for the opportunistic-suspend workque=
ue --
> >> >> >> opportunistic suspends would be initiated by the "suspend manage=
r"
> >> >> >> process instead of by the kernel.
> >> >> >>
> >> >> >> However you still have the issue of modifying the kernel drivers=
 to
> >> >> >> disallow opportunistic suspend if their queues are non-empty. =
=A0Doing
> >> >> >> that is more or less equivalent to implementing kernel-level sus=
pend
> >> >> >> blockers. =A0(The suspend blocker approach is slightly more effi=
cient,
> >> >> >> because it will prevent a suspend from starting if a queue is
> >> >> >> non-empty, instead of allowing the suspend to start and then abo=
rting
> >> >> >> it partway through.)
> >> >> >>
> >> >> >> Maybe I'm missing something here... =A0No doubt someone will poi=
nt it out
> >> >> >> if I am.
> >> >> >>
> >> >> >
> >> >> > Well, from my perspective that would limit changes to the evdev d=
river
> >> >> > (well, limited input core plumbing will be needed) but that is us=
ing the
> >> >> > current PM infrastructure. The HW driver changes will be limited =
to what
> >> >> > you described "type 2" in your other e-mail.
> >> >> >
> >> >> > Also, not suspending while events are in progress) is probably
> >> >> > beneficial for platforms other than Android as well. So unless I =
am
> >> >> > missing something this sounds like a win.
> >> >> >
> >> >>
> >> >> How would this limit the changes you need in the evdev driver? It n=
eed
> >> >> to block suspend when there are unprocessed events in some queues.
> >> >> Suspend blockers gives you an api to do this, without it, you check
> >> >> the queues in your suspend hook and abort suspend if they are not
> >> >> empty. Without suspend blockers you have no api to signal that it is
> >> >> OK to suspend again, so you are forcing the thread that tried to
> >> >> suspend to poll until you stop aborting suspend.
> >> >
> >> > No, you do not need to poll. You just set a timeout (short or long,
> >> > depending on your needs) and if no userspace task blocked suspend
> >> > durng that time you attempt to initiate suspend from your manager
> >> > process. If it succeeds - good, if not that means that more events c=
ame
> >> > your way and you have to do it later.
> >> >
> >>
> >> How is that not polling? If the user is holding down a key, the keypad
> >> driver has to block suspend, and user space will try to suspend again
> >> and again and again...
> >>
> >
> > If your userpsace is that stupid - sure. However, you can:
> >
> > 1. Notify the suspend manager process that he rest of your userspace is
> > busy handling keystrokes so that it does not try to suspend while there
> > are events pending.
> =

> You are missing the point. There are no event pending. The kernel
> reported the key down event, it was handled, but the keypad driver is
> still scanning to see if the user presses another key,

Employ reasonable timeout.

> or releases the
> currently held key.
> =


Userspace consumer should wait for the key release and retract "busy"
once event is received and handled.

> >
> > 2. Wait a tiny bit after last application notified you that it finished
> > processing events.
> >
> > So basically the difference is that with in-kernel suspend blockers,
> > there is a tiny window where we haven't started the suspend yet but are
> > about to the driver has a chance to prevent entire system from starting
> > sleep.
> =

> No, the difference is that if a driver needs to prevent suspend for an
> extended period of time, you don't have user space continuously
> polling to see if it can suspend.

Why would a driver, on its own, prevent suspend for extended periods of
time? I think that the decision should originate from userspace, kernel
is here just to serve the requests.

> =

> >
> > Without the blocker we may start suspending and will stop midcycle. We
> > may be even better off in the end since we could leave some devices
> > still powered down after aborting system-wide suspend.
> >
> =

> That does not sound right.

Why doesn't it? If a device implements runtime PM it may chose remain in
powered-down mode even if system is awake.

-- =

Dmitry
