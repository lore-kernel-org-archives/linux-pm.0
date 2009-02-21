From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 02:32:36 -0800
Message-ID: <d6200be20902210232m71700247k8914ca3735563881__36529.472078155$1235212551$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902210057.27781.rjw@sisk.pl>
	<d6200be20902201708g45540f60ib024c3365c85aef4@mail.gmail.com>
	<200902211047.26787.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902211047.26787.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 21, 2009 at 1:47 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Fri, Feb 20, 2009 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> On Fri, Feb 20, 2009 at 7:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> On Fri, Feb 20, 2009 at 2:49 AM, Rafael J. Wysocki <rjw@sisk.pl> w=
rote:
>> >> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowland.harv=
ard.edu> wrote:
>> >> >> >> >> > It might have to be platform-specific.  The Android people=
 seem to have a
>> >> >> >> >> > pretty good idea of what criteria will work for them.
>> >> >> >> >>
>> >> >> >> >> I'd really like to know in what situations Androind is suppo=
sed to suspend
>> >> >> >> >> automatically.
>> >> >> >> >
>> >> >> >> > It might be better to ask in what situations Android is _not_=
 supposed
>> >> >> >> > to sleep automatically.  In other words, in what situations i=
s a
>> >> >> >> > wakelock acquired?  Since the whole system is only a phone, t=
his
>> >> >> >> > question should have a reasonably well-defined answer.
>> >> >> >>
>> >> >> >> On an android phone, any code that needs to run when the screen=
 is off
>> >> >> >> must hold a wakelock (directly or indirectly). In general if an
>> >> >> >> application or the system is processing an event that may cause=
 a user
>> >> >> >> notification (new email, incoming phone call, alarm, etc.) it n=
eeds to
>> >> >> >> prevent suspend. But, we also use wakelocks to upload stats or
>> >> >> >> download system updates in the background, and for media player=
 or
>> >> >> >> (gps) data logging applications.
>> >> >> >
>> >> >> > All of this doesn't seem to require wakelocks acuired from kerne=
l space.
>> >> >> > What do you need those wakelocks for?
>> >> >>
>> >> >> Most events do not originate in user-space. Alarms start in our al=
arm
>> >> >> driver which locks a wakelock when its timer interrupt occurs. This
>> >> >> wakelock stays locked until the user-space alarm manager calls the
>> >> >> driver to wait for the next alarm. I've described how input events=
 are
>> >> >> handled before. Without kernel wakelocks, if the user space power
>> >> >> manager had already turned off the screen and decided to suspend r=
ight
>> >> >> before a wakeup key is pressed, then that key could sit in the
>> >> >> in-kernel input queue until another key is pressed. Even if the
>> >> >> user-space thread read the key event before being frozen, it cannot
>> >> >> abort the suspend operation that was already started.
>> >> >
>> >> > OK, so what about the following approach:
>> >> >
>> >> > * Keep the decision making logic (power manager etc.) in user space=
.  Reasons:
>> >> >  - It may be arbitrarily complicated
>> >> >  - It may include such things as s2ram quirks or hal quirks needed =
for some
>> >> >    graphics adapters
>> >>
>> >> I don't using wakelocks in any different in this respect. When user
>> >> space decides that it is ok for the kernel to suspend it should have
>> >> performed all theses steps in both cases.
>> >
>> > If automatic suspend is to be started by the kernel, you have to make =
sure
>> > that at least one wakelock is held until these steps are completed.  T=
hat may
>> > be somewhat tricky in general.
>>
>> That is not tricky. If your code holds a wakelock, then at least one
>> wakelock is held.
>
> I meant, if one task releases its wakelock and another one takes a wakelo=
ck,
> you have to make sure there's no window between those events.  Of course,
> you can have a single task holding a wakelock all the time and releasing =
it
> when it makes sure everything is ready, but then it would act as a user s=
pace
> power manager anyway.

If you are turning on and off hardware in user space that cannot
survive a kernel suspend while it is on, then you hold a wakelock when
this hardware is on. It should not matter how many times the kernel
enter and exit suspend while your hardware is off.

>
>> >> > * Have a per-process (per-task or per-thread group, but the former =
would be
>> >> >  easier IMO) "I_do_not_want_automatic_suspend_to_occur" flag.
>> >>
>> >> A per-process (thread group) flag allows wakelocks to be implemented
>> >> in a user space library. A per-thread flag does not. However, I don't
>> >> see much benefit in tying this to a process instead of using a file
>> >> descriptor.
>> >
>> > Using a flag would allow us to remove the window between checking the
>> > wakelocks and freezing tasks (in principle a task may take a wakelock =
just
>> > before it's frozen).
>>
>> You can check if there are wakelocks held from the same spot as you
>> check your flag.
>
> That would be _much_ more complicated and much less efficient (browsing a=
 list
> vs checking a flag).  And it would require additional locking if it's to =
be
> done in a non-racy way.

Browsing an empty list is not that inefficient. If you are concerned
about the overhead of the extra spinlock, you could check if the list
is empty before locking the spinlock.

>
>> >> > * Add a new callback, say ->acknowledge(), to the set of each drive=
r's PM
>> >> >  operations, that will be called to check if the driver has anythin=
g against
>> >> >  automatic suspend (true - suspend can happen right now, false - su=
spend can't
>> >> >  happen).
>> >> >
>> >> > * Introduce /sys/power/sleep that will work like /sys/power/state, =
but:
>> >> >  - First, it will call ->acknowledge() for each driver (via bus typ=
es) to
>> >> >    check if any of them wants to postpone the suspend (this will pr=
event tasks
>> >> >    from being frozen unnecessarily if it is known in advance that t=
he suspend
>> >> >    should not happen at the moment).
>> >> >  - Next, it will check the "I_do_not_want_automatic_suspend_to_occu=
r" flag
>> >> >    of each process and the suspend will be aborted if it is true fo=
r any of
>> >> >    them (quite frankly, I think that should be integrated with the =
freezer,
>> >> >    in particular the tasks that have TIF_FREEZE set shouldn't be ab=
le to set
>> >> >    this flag and it should be checked in the freezer loop for every=
 task with
>> >> >    TIF_FREEZE unset).
>> >> >  - Next, it will proceed with suspending just like /sys/power/state=
 does (the
>> >> >    drivers that missed the opportunity to abort the suspend by retu=
rning
>> >> >    'false' from ->acknowledge() can still abort the suspend by fail=
ing their
>> >> >    ->suspend() routines).
>> >> >
>> >> > Then, the decision making logic will be able to use /sys/power/slee=
p whenever
>> >> > it wishes to and the kernel will be able to refuse to suspend if it=
's not
>> >> > desirable at the moment.
>> >> >
>> >> > It seems to be flexible enough to me.
>> >>
>> >> This seems flexible enough to avoid race conditions, but it forces the
>> >> user space power manager to poll when the kernel refuse suspend.
>> >
>> > And if the kernel is supposed to start automatic suspend, it has to mo=
nitor
>> > all of the wakelocks.  IMO, it's better to allow the power manager to =
poll the
>> > kernel if it refuses to suspend.
>>
>> What is better about polling in userspace?
>
> One kernel thread less, for example?
>
>> >> Also, like my original wakelock patches, it breaks sleep requests thr=
ough
>> >> /sys/power/state when there are input events queued.
>> >
>> > The idea is to have both /sys/power/state and /sys/power/sleep at the =
same
>> > time, where /sys/power/state will work just like it does right now.  S=
ure,
>> > there must be mutual exclusion between the two, but that's a matter of
>> > implementation IMO.
>>
>> If you want to only prevent suspend though one interface, you have to
>> also pass information to the driver about its suspend hook is being
>> called so it can conditionally return -EBUSY. The wakelock interface
>> requires less code in each driver.
>
> Well, I don't think so.  Moreover, it requires you to spread wakelocks all
> over the place if you don't use the timeouted ones which, let's face it, =
is
> hardly acceptable.

Your method does not reduce the number of places that has to be
modified. Any component where we add a wakelock, you have to add a
suspend handler to abort suspend when we would have held a wakelock.

-- =

Arve Hj=F8nnev=E5g
