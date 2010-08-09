From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 8 Aug 2010 22:09:38 -0700
Message-ID: <AANLkTikiswqaBzrL74zQbnt_+E7LYipOgFfKwt=8dNoj__1052.28912220827$1281330748$gmane$org@mail.gmail.com>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
	<201008071044.37486.rjw@sisk.pl>
	<AANLkTinebiC=9Xd-D_sOwmvA8w_YPWMdhTYz2NRbZ7jH@mail.gmail.com>
	<201008082155.29866.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008082155.29866.rjw@sisk.pl>
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
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/8/8 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
...
>> The suspend blocking work api would have to change so the caller to pass=
es
>> a device in, which I think would make that api less flexible. Mostly the
>> problem is that we need separate stats for wakelocks created by a
>> single driver. For instance we will still need a user-space interface
>> to block suspend on android devices (lower level services than the
>> power manager need to block suspend), with the stats in the device
>> struct we have to create a new device for every wakelock user space
>> creates in the kernel.
>
> Well, what about managing these stats in user space?
>

The java wakelocks have stats in user space, but the lower level
services that use the kernel api do not show up there.

>> There is also the issue of reading the stats. It is a lot easier to
>> read a single stats file, than looping though every device on the
>> system (when most of the devices never block suspend).
>
> It seems you can have a list of the "interesting" ones.
>

I'm not sure what you mean. If you mean add a procfs or debugfs api
that lists the stats for devices that have used the api, then yes that
should work. If I have a devices where the battery drained too
quickly, I run cat /proc/wakelocks which has all the reasons why it
was not suspended.

...
>> >> >> total_time, total time the wake lock has been active. This one sho=
uld
>> >> >> be obvious.
>> >> >
>> >> > Also easily added.
>> >> >
>> >> Only with a handle passed to all the calls.
>> >
>> > Well, I'm kind of tired of this "my solution is the only acceptable on=
e"
>> > mindset. =A0IMHO, it's totally counter productive.
>> >
>>
>> How do you propose to track how long a driver has blocked suspend when
>> you have an unblock call that takes no arguments.
>
> You can extend pm_relax() to take a dev argument and measure the time bet=
ween
> pm_stay_awake() and pm_relax() called for the same device.
>

As long as it is not optional.

>> >> >> sleep_time, total time the wake lock has been active when the scre=
en was off.
>> >> >
>> >> > Not applicable to general systems. =A0Is there anything like it that
>> >> > _would_ apply in general?
>> >> >
>> >>
>> >> The screen off is how it is used on android, the stats is keyed of
>> >> what user space wrote to /sys/power/state. If "on" was written the
>> >> sleep time is not updated.
>> >>
>> >> >> max_time, longest time the wakelock was active uninterrupted. This
>> >> >> used less often, but the battery on a device was draining fast, but
>> >> >> the problem went away before looking at the stats this will show i=
f a
>> >> >> wakelock was active for a long time.
>> >> >
>> >> > Again, easily added. =A0The only drawback is that all these additio=
ns
>> >> > will bloat the size of struct device. =A0Of course, that's why you =
used
>> >> > separately-allocated structures for your wakelocks. =A0Maybe we can
>> >> > change to do the same; it seems likely that the majority of device
>> >> > structures won't ever be used for wakeup events.
>> >> >
>> >>
>> >> Since many wakelocks are not associated with s struct device we need a
>> >> separate object for this anyway.
>> >>
>> >> >> >> and I would prefer that the kernel interfaces would
>> >> >> >> encourage drivers to block suspend until user space has consume=
d the
>> >> >> >> event, which works for the android user space, instead of just =
long
>> >> >> >> enough to work with a hypothetical user space power manager.
>> >> >
>> >> > Rafael doesn't _discourage_ drivers from doing this. =A0However you=
 have
>> >> > to keep in mind that many kernel developers are accustomed to worki=
ng
>> >> > on systems (mostly PCs) with a different range of hardware devices =
from
>> >> > embedded systems like your phones. =A0With PCI devices(*), for exam=
ple,
>> >> > there's no clear point where a wakeup event gets handed off to
>> >> > userspace.
>> >> >
>> >> > On the other hand, there's no reason the input layer shouldn't use
>> >> > pm_stay_awake and pm_relax. =A0It simply hasn't been implemented ye=
t.
>> >> ...
>> >>
>> >> The merged user space interface makes this unclear to me. When I first
>> >> used suspend on android I had a power manager process that opened all
>> >> the input devices and reset a screen off timeout every time there was
>> >> an input event. If the input layer uses pm_stay_awake to block suspend
>> >> when the queue is not empty, this will deadlock with the current
>> >> interface since reading the wake count will block forever if an input
>> >> event occurred right after the power manager decides to suspend.
>> >
>> > No, in that case suspend will be aborted, IIUC.
>> >
>>
>> How? Your pm_get_wakeup_count function loops until events_in_progress be=
comes 0.
>
> So, to deadlock with it you'd have to call pm_stay_awake() and wait for i=
t to
> complete. =A0However, right now there are no means by which user space ca=
n call
> pm_stay_awake(), so this can't happen.
>

No that is not how it deadlocks. The input driver calls pm_stay_awake
which blocks the thread that reads from /sys/power/wakeup_count. If
that threads needs to run before the user-space reads from the input
device (either because it is the same thread, or because it provides a
user-space wakelock api) you have a deadlock.

> Of course, if you add pm_stay_awake() to an ioctl() code path, you should=
 make
> sure that whoever uses that ioctl() won't be waiting for the power manage=
r to
> read from /sys/power/wakeup_count. =A0I guess your point is that this isn=
't
> possible to achieve?
>

My main point is that blocking suspend while the input event queue is
not empty changes what else is safe for the user-space process reading
/sys/power/wakeup_count.

-- =

Arve Hj=F8nnev=E5g
