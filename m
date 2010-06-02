From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 02:12:10 -0700
Message-ID: <AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7__6859.55468002266$1275469979$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100602180614.729246ea@notabene.brown>
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
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

2010/6/2 Neil Brown <neilb@suse.de>:
> On Wed, 2 Jun 2010 00:05:14 -0700
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>
>> On Tue, Jun 1, 2010 at 10:32 PM, Neil Brown <neilb@suse.de> wrote:
>> > On Tue, 1 Jun 2010 12:50:01 +0200 (CEST)
>> > Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> >> On Tue, 1 Jun 2010, Neil Brown wrote:
>> >> >
>> >> > I think you have acknowledged that there is a race with suspend - t=
hanks.
>> >> > Next step was "can it be closed".
>> >> > You seem to suggest that it can, but you describe it as a "work aro=
und"
>> >> > rather than a "bug fix"...
>> >> >
>> >> > Do you agree that the race is a "bug", and therefore it is appropri=
ate to
>> >> > "fix" it assuming an acceptable fix can be found (which I think it =
can)?
>> >>
>> >> If we can fix it, yes we definitely should do and not work around it.
>> >>
>> >> Thanks,
>> >>
>> >> =A0 =A0 =A0 tglx
>> >
>> > OK.
>> > Here is my suggestion.
>> >
>> > While I think this patch would actually work, and hope the ugly aspect=
s are
>> > reasonably balanced by the simplicity, I present it primarily as a bas=
e for
>> > improvement.
>> > The important part is to present how drivers and user-space can co-ope=
rate
>> > to avoid losing wake-events. =A0The details of what happens in the ker=
nel are
>> > certainly up for discussion (as is everything else really of course).
>> >
>> > The user-space suspend daemon avoids losing wake-events by using
>> > fcntl(F_OWNER) to ensure it gets a signal whenever any important wake-=
event
>> > is ready to be read by user-space. =A0This may involve:
>> > =A0- the one daemon processing all wake events
>>
>> Wake up events are not all processed by one daemon.
>
> Not with your current user-space code, no. =A0Are you saying that you are=
 not
> open to any significant change in the Android user-space code? =A0That wo=
uld
> make the situation a lot harder to resolve.
>

Some wakeup events like the an incoming phone may be handled by a
vendor supplied daemon that I do not have the source code for. And, no
I'm not open to a change that would require all wakeup events to go to
a single process.

>>
>> > =A0- Both the suspend daemon and the main event handling daemon openin=
g any
>> > =A0 =A0given device that delivers wake events (this should work with i=
nput
>> > =A0 =A0events ... unless grabbing is needed)
>>
>> Not all wakeup events are broadcast like input events so they cannot
>> be read by both daemons. Not that this really matters, since reading
>> the event from the suspend daemon does not mean that it has been
>> delivered to and processed by the other daemon.
>
> There would still need to be some sort of communication between the the
> suspend daemon on any event daemon to ensure that the events had been
> processed. =A0This could be very light weight interaction. =A0The point t=
hough is
> that with this patch it becomes possible to avoid races. =A0Possible is b=
etter
> than impossible.
>

We already have a solution. I don't think rejecting our solution but
merging a worse solution should be the goal.

>>
>> > =A0- The event handling daemon giving the suspend-daemon's pid as F_OW=
NER, and
>> > =A0 =A0using poll/select to get the events itself.
>>
>> I don't like the idea of using signals for this. Without the hack Alan
>> Stern suggested, you will temporarily block suspend if the wakeup
>> event happened before the suspend daemon thread made it to the kernel,
>> but abort suspend if it happened right after.
>
> I'm not sure why that difference matters. =A0But I'm also not sure that i=
t is
> true.
> When any wakeup event happen, a signal will be delivered to the suspend
> daemon.
> This will interrupt a pending suspend request, or a sleep, or whatever el=
se
> the daemon is doing.
> It can then go back to waiting for a good time to suspend, and then try to
> suspend again.
>

This is inferior to the solution that is in the android kernel and the
suspend blocker patchset. Both suspend as soon as possible and do not
require signal handlers that modify the argument to your kernel call.

>
>>
>> >
>> > When 'mem' is written to /sys/power/state, suspend_prepare waits in an
>> > interruptible wait until any wake-event that might have been initiated=
 before
>> > the suspend was request, has had a chance to be queued for user-space =
and
>> > trigger kill_fasync.
>>
>> And what happens if you are not waiting when this happens?
>
> I'm not sure I understand the question. =A0Could you explain it please?
>

If the thread is not already in the kernel how does your signal
handler abort suspend.

> Either the initial event happens late enough to abort/resume the suspend,=
 or
> the signal happens early enough to abort the suspend, or alert the daemon=
 not
> to do a suspend. =A0Either way we don't get stuck in suspend.
>
>
>>
>> > Currently this wait is a configurable time after the last wake-event w=
as
>> > initiated. =A0This is hackish, but simple and probably adequate.
>>
>> Waiting after a wake event is the same as suspend_block_timeout. This
>> is useful when passing events through layers of code that does no
>> block suspend, but we should strive to avoid it. Other people had much
>> stronger objections to this, which is why it is not included in the
>> last suspend blocker patchset.
>
> Absolutely agree. =A0The idea of of waiting was just a simple way to pres=
ent
> code that actually could work. =A0There are doubtlessly better ways and I
> assume they have been implemented in the suspend-blocker code.
> We just need some way to wait for the suspend-block count to reach zero, =
with
> some confidence that this amount of time is limited.
>
> (though to be honest ... the incredible simplicity of waiting a little wh=
ile
> is very compelling.... :-))
>

Sure, but forcing that as the only way to prevent suspend is taking to too =
far.

>>
>> It also does not work for drivers that need to block suspend for more
>> than a few seconds. For instance the gpio keypad matrix driver needs
>> to block suspend while keys are pressed so it can scan the keypad.
>
> I cannot imagine why it would take multiple seconds to scan a keypad.
> Can you explain that?
>
> Do you mean while keys are held pressed?

Yes.

> =A0Maybe you don't get a wake-up event
> on key-release?

We should.

> =A0In that case your user-space daemon could block suspend
> while there are any pressed keys.... =A0confused.
>

The user-space daemon should not need to know which keys are in a
matrix. We also have other drivers that need to block suspend. For
instance, some devices need to block suspend while connected to a USB
host.

>
> Thanks for the review,
>
> NeilBrown
>
>



-- =

Arve Hj=F8nnev=E5g
