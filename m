From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 15:37:48 -0700
Message-ID: <AANLkTinnSH_egFYowkOQiYHL87QfIH332i1__OaTem-s__3464.71398738704$1274827123$gmane$org@mail.gmail.com>
References: <201005251124.58017.dmitry.torokhov@gmail.com>
	<Pine.LNX.4.44L0.1005251428090.1634-100000@iolanthe.rowland.org>
	<20100525184740.GA4248@core.coreip.homeip.net>
	<AANLkTik7eKNIqMFGVl6OzpqBnhvjet9puUQDCRkrabkg@mail.gmail.com>
	<20100525223220.GC4928@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525223220.GC4928@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/25 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, May 25, 2010 at 03:23:23PM -0700, Arve Hj=F8nnev=E5g wrote:
>> On Tue, May 25, 2010 at 11:47 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, May 25, 2010 at 02:35:17PM -0400, Alan Stern wrote:
>> >> On Tue, 25 May 2010, Dmitry Torokhov wrote:
>> >>
>> >> > > Here's the scenario:
>> >> > >
>> >> > > The system is awake, and the user presses a key. The keyboard dri=
ver
>> >> > > processes the keystroke and puts it in an input queue. =A0A user =
process
>> >> > > reads it from the event queue, thereby emptying the queue.
>> >> > >
>> >> > > At that moment, the system decides to go into opportunistic suspe=
nd.
>> >> > > Since the input queue is empty, there's nothing to stop it. =A0As=
 the
>> >> > > first step, userspace is frozen -- before the process has a chanc=
e to
>> >> > > do anything with the keystroke it just read. =A0As a result, the =
system
>> >> > > stays asleep until something else wakes it up, even though the
>> >> > > keystroke was important and should have prevented it from sleepin=
g.
>> >> > >
>> >> > > Suspend blockers protect against this scenario. =A0Here's how:
>> >> > >
>> >> > > The user process doesn't read the input queue directly; instead it
>> >> > > does a select or poll. =A0When it sees there is data in the queue=
, it
>> >> > > first acquires a suspend blocker and then reads the data.
>> >> > >
>> >> > > Now the system _can't_ go into opportunistic suspend, because a s=
uspend
>> >> > > blocker is active. =A0The user process can do whatever it wants w=
ith the
>> >> > > keystroke. =A0When it is finished, it releases the suspend blocke=
r and
>> >> > > loops back to the select/poll call.
>> >> > >
>> >> >
>> >> > What you describe can be done in userspace though, via a "suspend m=
anager"
>> >> > process. Tasks reading input events will post "busy" events to stop=
 the
>> >> > manager process from sending system into suspend. But this can be c=
onfined to
>> >> > Android userspace, leaving the kernel as is (well, kernel needs to =
be modified
>> >> > to not go into suspend with full queues, but that is using existing=
 kernel
>> >> > APIs).
>> >>
>> >> I think that could be made to work. =A0And it might remove the need f=
or
>> >> the userspace suspend-blocker API, which would be an advantage. =A0It
>> >> could even remove the need for the opportunistic-suspend workqueue --
>> >> opportunistic suspends would be initiated by the "suspend manager"
>> >> process instead of by the kernel.
>> >>
>> >> However you still have the issue of modifying the kernel drivers to
>> >> disallow opportunistic suspend if their queues are non-empty. =A0Doing
>> >> that is more or less equivalent to implementing kernel-level suspend
>> >> blockers. =A0(The suspend blocker approach is slightly more efficient,
>> >> because it will prevent a suspend from starting if a queue is
>> >> non-empty, instead of allowing the suspend to start and then aborting
>> >> it partway through.)
>> >>
>> >> Maybe I'm missing something here... =A0No doubt someone will point it=
 out
>> >> if I am.
>> >>
>> >
>> > Well, from my perspective that would limit changes to the evdev driver
>> > (well, limited input core plumbing will be needed) but that is using t=
he
>> > current PM infrastructure. The HW driver changes will be limited to wh=
at
>> > you described "type 2" in your other e-mail.
>> >
>> > Also, not suspending while events are in progress) is probably
>> > beneficial for platforms other than Android as well. So unless I am
>> > missing something this sounds like a win.
>> >
>>
>> How would this limit the changes you need in the evdev driver? It need
>> to block suspend when there are unprocessed events in some queues.
>> Suspend blockers gives you an api to do this, without it, you check
>> the queues in your suspend hook and abort suspend if they are not
>> empty. Without suspend blockers you have no api to signal that it is
>> OK to suspend again, so you are forcing the thread that tried to
>> suspend to poll until you stop aborting suspend.
>
> No, you do not need to poll. You just set a timeout (short or long,
> depending on your needs) and if no userspace task blocked suspend
> durng that time you attempt to initiate suspend from your manager
> process. If it succeeds - good, if not that means that more events came
> your way and you have to do it later.
>

How is that not polling? If the user is holding down a key, the keypad
driver has to block suspend, and user space will try to suspend again
and again and again...

-- =

Arve Hj=F8nnev=E5g
