From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 15:03:01 -0800
Message-ID: <d6200be20902201503m59a13cddn59adfc47d0c2ed1e__3268.52325019917$1235171221$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902201149.37921.rjw@sisk.pl>
	<d6200be20902200326g6caa211ai388d4aa9fc270a28@mail.gmail.com>
	<200902201657.01145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902201657.01145.rjw@sisk.pl>
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

On Fri, Feb 20, 2009 at 7:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Fri, Feb 20, 2009 at 2:49 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>> >> >> > It might have to be platform-specific.  The Android people seem =
to have a
>> >> >> > pretty good idea of what criteria will work for them.
>> >> >>
>> >> >> I'd really like to know in what situations Androind is supposed to=
 suspend
>> >> >> automatically.
>> >> >
>> >> > It might be better to ask in what situations Android is _not_ suppo=
sed
>> >> > to sleep automatically.  In other words, in what situations is a
>> >> > wakelock acquired?  Since the whole system is only a phone, this
>> >> > question should have a reasonably well-defined answer.
>> >>
>> >> On an android phone, any code that needs to run when the screen is off
>> >> must hold a wakelock (directly or indirectly). In general if an
>> >> application or the system is processing an event that may cause a user
>> >> notification (new email, incoming phone call, alarm, etc.) it needs to
>> >> prevent suspend. But, we also use wakelocks to upload stats or
>> >> download system updates in the background, and for media player or
>> >> (gps) data logging applications.
>> >
>> > All of this doesn't seem to require wakelocks acuired from kernel spac=
e.
>> > What do you need those wakelocks for?
>>
>> Most events do not originate in user-space. Alarms start in our alarm
>> driver which locks a wakelock when its timer interrupt occurs. This
>> wakelock stays locked until the user-space alarm manager calls the
>> driver to wait for the next alarm. I've described how input events are
>> handled before. Without kernel wakelocks, if the user space power
>> manager had already turned off the screen and decided to suspend right
>> before a wakeup key is pressed, then that key could sit in the
>> in-kernel input queue until another key is pressed. Even if the
>> user-space thread read the key event before being frozen, it cannot
>> abort the suspend operation that was already started.
>
> OK, so what about the following approach:
>
> * Keep the decision making logic (power manager etc.) in user space.  Rea=
sons:
>  - It may be arbitrarily complicated
>  - It may include such things as s2ram quirks or hal quirks needed for so=
me
>    graphics adapters

I don't using wakelocks in any different in this respect. When user
space decides that it is ok for the kernel to suspend it should have
performed all theses steps in both cases.

>
> * Have a per-process (per-task or per-thread group, but the former would =
be
>  easier IMO) "I_do_not_want_automatic_suspend_to_occur" flag.

A per-process (thread group) flag allows wakelocks to be implemented
in a user space library. A per-thread flag does not. However, I don't
see much benefit in tying this to a process instead of using a file
descriptor.

>
> * Add a new callback, say ->acknowledge(), to the set of each driver's PM
>  operations, that will be called to check if the driver has anything agai=
nst
>  automatic suspend (true - suspend can happen right now, false - suspend =
can't
>  happen).
>
> * Introduce /sys/power/sleep that will work like /sys/power/state, but:
>  - First, it will call ->acknowledge() for each driver (via bus types) to
>    check if any of them wants to postpone the suspend (this will prevent =
tasks
>    from being frozen unnecessarily if it is known in advance that the sus=
pend
>    should not happen at the moment).
>  - Next, it will check the "I_do_not_want_automatic_suspend_to_occur" flag
>    of each process and the suspend will be aborted if it is true for any =
of
>    them (quite frankly, I think that should be integrated with the freeze=
r,
>    in particular the tasks that have TIF_FREEZE set shouldn't be able to =
set
>    this flag and it should be checked in the freezer loop for every task =
with
>    TIF_FREEZE unset).
>  - Next, it will proceed with suspending just like /sys/power/state does =
(the
>    drivers that missed the opportunity to abort the suspend by returning
>    'false' from ->acknowledge() can still abort the suspend by failing th=
eir
>    ->suspend() routines).
>
> Then, the decision making logic will be able to use /sys/power/sleep when=
ever
> it wishes to and the kernel will be able to refuse to suspend if it's not
> desirable at the moment.
>
> It seems to be flexible enough to me.

This seems flexible enough to avoid race conditions, but it forces the
user space power manager to poll when the kernel refuse suspend. Also,
like my original wakelock patches, it breaks sleep requests through
/sys/power/state when there are input events queued.

-- =

Arve Hj=F8nnev=E5g
