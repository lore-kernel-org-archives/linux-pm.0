From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Thu, 26 Feb 2009 16:00:52 -0800
Message-ID: <d6200be20902261600t7531568ekd9a7aa9215f53263__42191.0702404149$1235693097$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
	<d6200be20902261430w19ea3e6fye014f8443d9ab5ca@mail.gmail.com>
	<200902270010.38291.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902270010.38291.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2009 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 26 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Thu, Feb 26, 2009 at 2:10 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> >
>> > On Thu, 26 Feb 2009, Rafael J. Wysocki wrote:
>> >>
>> >> Well, how exactly the $subject patch does cause this problem to happe=
n?
>> >
>> > Rafael, the problem is that if an interrupt happens while it's disable=
d -
>> > but before the CPU has actually turned all interrupts off - the CPU wi=
ll
>> > ACK the interrupt (but just set a flag for it being PENDING), so now t=
he
>> > chipset logic around it will not see it as pending any more, so now the
>> > chipset won't auto-wake the CPU immediately (or more likely, it won't
>> > even suspend it).
>> >
>> > It's trivial to fix multiple ways, so I wouldn't worry. The most trivi=
al
>> > way is to just have some sysdev drievr code simply do something like
>> >
>> > =A0static int sysdev_suspend()
>> > =A0{
>> > =A0 =A0 =A0 =A0for_each_irq(irq,desc) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(desc->flags & IRQF_WAKE))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc->flags & IRQ_PENDING)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0return 0;
>> > =A0}
>> >
>> > and that should automatically mean that if any irq is pending, the sus=
pend
>> > will fail and we'll immediately wake up again.
>> >
>> > It looks trivial, and I don't understand why Arve can't just do the sy=
sdev
>> > thing.
>>
>> I can. My point is that the patch breaks our existing code.
>
> Is that a mainline kernel code?

No, the msm suspend support has not been merged.

>
>> If anyone else uses edge triggered wakeup interrupt it may break from th=
em as
>> well. The main question if this should be fixed separately for every
>> platform that needs it, or if pending wakeup interrupts should always
>> abort sleep.
>
> Well, I'm not really sure if this is the problem. =A0In fact the problem =
is that
> you have a regular device the interrupt of which can be a wake-up one. =
=A0I think

Is that not a common case and what enable_irq_wake is for?

> the problem wouldn't have existed at all if it had been a sysdev. =A0Is t=
hat
> correct?

How many sysdevs use interrupts?

I found may drivers in the mainline kernel that use enable_irq_wake,
but I did not see any that handle this race condition.

-- =

Arve Hj=F8nnev=E5g
