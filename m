From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Just fix the bug - Re: [PATCH 1/8] PM: Opportunistic
	suspend support.
Date: Thu, 27 May 2010 23:37:00 -0700
Message-ID: <AANLkTin_aElK9Ruc13Im_cz138Dbu4bqWyiKQBF0eGEV@mail.gmail.com>
References: <1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
	<1274891308.1674.1766.camel@laptop>
	<20100526165919.GB2089@elf.ucw.cz>
	<1274893309.1674.1773.camel@laptop>
	<1274894685.4467.758.camel@mulgrave.site>
	<alpine.LFD.2.00.1005261948290.2995@localhost.localdomain>
	<1274898180.4467.925.camel@mulgrave.site>
	<1274948234.14002.27.camel@thorin>
	<AANLkTilk7FX1Y0uWKyMEpf8uxFPBae3X0hGdLLa5oNUa@mail.gmail.com>
	<20100528135021.3b6acb0b@notabene.brown>
	<AANLkTik8C5sM_YC2QbOIwAhRY-JHo6nChhH3jvsK5bBa@mail.gmail.com>
	<20100528160601.49c023ff@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528160601.49c023ff@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Neil Brown <neilb@suse.de>
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Thomas Gleixner <tglx@linutronix.de>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, Bernd Petrovitsch <bernd@petrovitsch.priv.at>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

2010/5/27 Neil Brown <neilb@suse.de>:
> On Thu, 27 May 2010 21:57:02 -0700
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>
>> 2010/5/27 Neil Brown <neilb@suse.de>:
>> > On Thu, 27 May 2010 02:07:21 -0700
>> > Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>> >
>> >> >
>> >> >> of it into pm QoS stuff and if one day someone solves the rogue app
>> >> >> problem, we can migrate over.
>> >> >
>> >> > If it's so important for Android and no one else, Android can carry=
 it
>> >> > out of tree.
>> >> >
>> >>
>> >> This is not only important for Android. If you use suspend on a
>> >> current Linux system you run the risk of loosing wakeup events. If you
>> >> have wakeup events that you cannot afford to lose your only option is
>> >> to never suspend. On some hardware (e.g. x86) the cost of not
>> >> suspending is always huge, on other hardware (many ARM SOCs) the cost
>> >> is only huge if your apps behave poorly.
>> >>
>> >
>> > So here is my suggestion.
>> > Rather than trying to push a feature that is clearly meeting lots of
>> > resistance, the Android devs should state the problem as a bug that ne=
eds
>> > fixing. =A0As you have.
>> > Upstream is a lot more receptive of fixing bugs than adding features.
>> >
>> > In this case the bug is that you cannot suspend without the risk of lo=
sing
>> > wakeup events. =A0This is a real bug that for your use case is a serio=
us
>> > bug. =A0I've toyed with several ways of fixing this but the one that s=
eems most
>> > promising is to note that in the kernel the suspend process is two-sta=
ge with
>> > a 'prepare' followed by a 'suspend'. Userspace cannot make that distin=
ction
>> > and so ends up with a race.
>> >
>> > Maybe userspace should be able to say "prepare to suspend" with the me=
aning
>> > that after a successful return, any event which would cause a wakeup s=
ets a
>> > flag so that the final suspend returns immediately (without actually g=
oing to
>> > the lower power state).
>> >
>> > Then your opportunistic suspend could be entirely in userspace where y=
ou
>> > wouldn't have to fight with the kernel crowd :-)
>> > The suspend-daemon would:
>> > =A0Wait for all user-space suspend blocks to be dropped.
>> > =A0Tell the kernel to "prepare to suspend".
>> > =A0Tell all userspace programs which have registered for the message t=
hat they
>> > =A0 =A0should prepare to suspend. =A0They have the opportunity at this=
 point to
>> > =A0 =A0take out a new suspend block if they notice an event that has
>> > =A0 =A0just arrived
>> > =A0Wait for all those programs to acknowledge
>> > =A0If there are no new suspend blocks, tell the kernel to suspend
>> > =A0else tell the kernel to abort the suspend.
>> >
>> > This (I think) allows race-free opportunistic suspend in user-space wh=
ere
>> > you can do all the accounting you need.
>> >
>>
>> Perhaps, but it forces all user space programs that get events from
>> the kernel to also receive messages from the suspend-daemon, check for
>> other events again, then respond to the suspend-daemon. The current
>> suspend blocker interface is easier to use.
>
> Maybe so. =A0There are quite possibly better ways to fix the bug. =A0Ther=
e are a
> variety of different tradeoffs possible and I suspect we could have fun
> arguing about those. =A0My main point though is that if we focus on a bug=
 that
> needs to be fixed, we should be able to keep the conversation more focuss=
ed.
> Currently it seems to be branching all over the place which doesn't seem =
very
> helpful.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0I don't see how your
>> suggestion avoids races for events that pass trough several kernel
>> layers though. If a wakeup event happened before the "prepare to
>> suspend" call but has not yet been passed to user-space, the
>> user-space program that needs this event will not know that it needs
>> to block suspend when it gets the prepare-to-suspend message.
>
> Each layer must understand that the event is a wake-up event, and the
> "prepare to suspend call" to each layer should drive all pending events
> through to the next layer. =A0If the layers (drivers) are prepared in the
> "right" order, this will force the event all the way to user-space. =A0If=
 they
> are called in exactly the "Wrong" order, this will require multiple
> prepare/suspend/instant-resume cycles to get the event through, but I sus=
pect
> that this would very rarely result in truly pathological behaviour.
>
> I'm guessing your current code (sorry, I haven't looked at all) already t=
racks
> events up through multiple layers so they can interact with a pending
> opporunistic-suspend request. =A0I suspect that aspect of the code isn't
> particularly controversial.
> Keep that, and use it precisely to implement a race-free "suspend" request
> from user-space.
>
>>
>> > I don't fully understand your requirements for accounting of devices d=
rivers
>> > rejecting or blocking a suspend, so I cannot say precisely how that wo=
uld fit
>> > in. =A0Maybe you just need to know - whenever the 'suspend request' co=
mpletes -
>> > what the wakeup events were. =A0It shouldn't be too hard to export tha=
t to
>> > user-space via sysfs.
>> >
>> > I won't propose an exact enhancement to the user-space interface for
>> > requesting a suspend, but I suspect it should expose each of
>> > =A0suspend_prepare
>> > =A0suspend_devices_and_enter
>> > =A0suspend_finish
>> > (or close analogues there-of) to user-space. =A0It is tempting to map =
those to
>> > "open-for-write", "write", "close", but I'm not sure that suspend_prep=
are
>> > would be appropriate if the app was about to write "disk" - it is a pi=
ty that
>> > both suspend and hibernate use the same sysfs file.
>> >
>> > So just fix the bug, and everyone will be happy :-)
>> >
>>
>> I already have, but everyone do not appear to be happy.
>>
>
> I don't think you have. =A0You have proposed a significant new feature: a
> suspend-as-soon-as-you-can request which *user*space*can*block*. =A0People
> don't like that because it seems like a poor second cousin to something t=
hat
> would be really useful (user-space setting more general latency
> requirements).
>

The ability to block the suspend request is necessary to avoid races
with wakeup events.

> I am suggesting that you stick with the feature we have, which is that
> user-space can request a suspend and the kernel/hardware can cause a
> subsequent (possibly immediate) resume in response to a wake-up event.

Since not all wakeup events propagate to user-space it is very useful
to allow the kernel to reenter suspend when there are no active
suspend blockers remaining.

> Argue that the current definition of "wake-up event" is too weak and does=
 not
> allow the feature to be used safely. =A0Present an implementation (I susp=
ect you
> have most of it already) where a wake-up event is tracked all the way from
> the hardware to user-space and is still a 'wake-up event' until userspace
> actually consumes it.
>
> Then user-space simply has to:
> =A0poll for event to be ready
> =A0request suspend-block in user-space
> =A0consume event
> =A0handle event
> =A0release suspend-block
> =A0loop

This you copy this from the example in the documentation file added by
this patch? This is exactly what we do for input events, but for this
to work the kernel also has to block suspend while an event is ready
but not consumed.

>
> No change to API. =A0No new concepts. =A0Simply a bug and a direct fix.
>
I don't know how you got to that conclusion.

> You probably want the "suspend" request to block until there are no pendi=
ng
> events (and then immediately fail if there were) so that there is no risk=
 of
> the suspend-daemon spinning asking of a suspend which appears to resume
> immediately (until some other process sees an event and blocks suspend.
>
> NeilBrown
>

-- =

Arve Hj=F8nnev=E5g
