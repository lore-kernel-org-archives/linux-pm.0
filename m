From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 17:50:18 -0700
Message-ID: <AANLkTimIq0y9ZtXNJ79qCTg8DKHxDUJAz4VE6pxet21B__3359.3381675475$1277167884$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1006211814370.1687-100000@iolanthe.rowland.org>
	<201006220040.41524.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006220040.41524.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 21, 2010 at 3:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, June 22, 2010, Alan Stern wrote:
>> On Mon, 21 Jun 2010, Florian Mickler wrote:
>>
>> > > In the end you would want to have communication in both directions:
>> > > suspend blockers _and_ callbacks. =A0Polling is bad if done too ofte=
n.
>> > > But I think the idea is a good one.
>> >
>> > Actually, I'm not so shure.
>> >
>> > 1. you have to roundtrip whereas in the suspend_blocker scheme you have
>> > active annotations (i.e. no further action needed)
>>
>> That's why it's best to use both. =A0The normal case is that programs
>> activate and deactivate blockers by sending one-way messages to the PM
>> process. =A0The exceptional case is when the PM process is about to
>> initiate a suspend; that's when it does the round-trip polling. =A0Since
>> the only purpose of the polling is to avoid a race, 90% of the time it
>> will succeed.
>>
>> > 2. it may not be possible for a user to determine if a wake-event is
>> > in-flight. you would have to somehow pass the wake-event-number with
>> > it, so that the userspace process could ack it properly without
>> > confusion. Or... I don't know of anything else...
>> >
>> > =A0 =A0 1. userspace-manager (UM) reads a number (42).
>> >
>> > =A0 =A0 2. it questions userspace program X: is it ok to suspend?
>> >
>> > =A0 =A0 [please fill in how userspace program X determines to block
>> > =A0 =A0 suspend]
>> >
>> > =A0 =A0 3a. UM's roundtrip ends and it proceeds to write "42" to the
>> > =A0 =A0 kernel [suspending]
>> > =A0 =A0 3b. UM's roundtrip ends and it aborts suspend, because a
>> > =A0 =A0 (userspace-)suspend-blocker got activated
>> >
>> > I'm not shure how the userspace program could determine that there is a
>> > wake-event in flight. Perhaps by storing the number of last wake-event.
>> > But then you need per-wake-event-counters... :|
>>
>> Rafael seems to think timeouts will fix this. =A0I'm not so sure.
>>
>> > Do you have some thoughts about the wake-event-in-flight detection?
>>
>> Not really, except for something like the original wakelock scheme in
>> which the kernel tells the PM core when an event is over.
>
> But the kernel doesn't really know that, so it really can't tell the PM c=
ore
> anything useful. =A0What happens with suspend blockers is that a kernel s=
uspend
> cooperates with a user space consumer of the event to get the story strai=
ght.
>
> However, that will only work if the user space is not buggy and doesn't c=
rash,
> for example, before releasing the suspend blocker it's holding.
>
> Apart from this, there are those events withoug user space "handoff" that
> use timeouts.
>
> Also there are events like wake-on-LAN that can be regarded as instantane=
ous
> from the power manager's point of view, so they don't really need all of =
the
> "suspend blockers" machinery and for them we will need to use a cooldown
> timeout anyway.
>
> And if we need to use that cooldown timeout, I don't see why not to use
> timeouts for avoiding the race you're worrying about.
>

Just because some events need to use timeouts, does not mean that all
events should use timeouts. You may even want different timeout for
different events. If I want a 5 minute timeout after a wake-on-lan
packet, I don't want the same timeout after every battery check alarm
(every 10 minutes on the Nexus One).

Also, I don't see how this patch helps with events that never make
reach user-space. Unless each driver blocks suspend by returning and
error from its suspend hook, the driver then becomes dependent on the
user-space power manager to choose a sufficiently long timeout. For
some drivers, like the gpio keypad matrix driver there, is no safe
value for the timeout. The keypad driver has to block suspend if any
keys are held down.

I won't have time to actively follow this discussion, but I don't
think this patch is a good solution.

-- =

Arve Hj=F8nnev=E5g
