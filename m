From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 1/4] PM: Rework handling of interrupts
	during suspend-resume (rev. 4)
Date: Tue, 3 Mar 2009 14:56:11 -0800
Message-ID: <d6200be20903031456r7caa3c42qa7c31dc74768449c__12257.2239292369$1236121229$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200903030013.02805.rjw@sisk.pl>
	<d6200be20903021518r48fe6fb2vd07e9dedc4f5ff44@mail.gmail.com>
	<200903030027.13884.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903030027.13884.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 2, 2009 at 3:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
>> On Mon, Mar 2, 2009 at 3:13 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
>> >> On Sun, Mar 1, 2009 at 2:24 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> > From: Rafael J. Wysocki <rjw@sisk.pl>
>> >> >
>> >> > Introduce two helper functions allowing us to prevent device drivers
>> >> > from getting any interrupts (without disabling interrupts on the CP=
U)
>> >> > during suspend (or hibernation) and to make them start to receive
>> >> > interrupts again during the subsequent resume, respectively. =A0The=
se
>> >> > functions make it possible to keep timer interrupts enabled while t=
he
>> >> > "late" suspend and "early" resume callbacks provided by device
>> >> > drivers are being executed.
>> >> >
>> >> > Use these functions to rework the handling of interrupts during
>> >> > suspend (hibernation) and resume. =A0Namely, interrupts will only be
>> >> > disabled on the CPU right before suspending sysdevs, while device
>> >> > drivers will be prevented from receiving interrupts, with the help =
of
>> >> > the new helper function, before their "late" suspend callbacks run
>> >> > (and analogously during resume).
>> >> >
>> >> > In addition, since the device interrups are now disabled before the
>> >> > CPU has turned all interrupts off and the CPU will ACK the interrup=
ts
>> >> > setting the IRQ_PENDING bit for them, check in sysdev_suspend() if
>> >> > any wake-up interrupts are pending and abort suspend if that's the
>> >> > case.
>> >> >
>> >>
>> >>
>> >> > +void resume_device_irqs(void)
>> >> > +{
>> >> > + =A0 =A0 =A0 struct irq_desc *desc;
>> >> > + =A0 =A0 =A0 int irq;
>> >> > +
>> >> > + =A0 =A0 =A0 for_each_irq_desc(irq, desc)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->status & IRQ_SUSPENDED)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(irq);
>> >> > +}
>> >>
>> >> I think you need to clear IRQ_SUSPENDED here, not in enable_irq.
>> >
>> > enable_irq() clears IRQ_SUSPENDED. =A0This has already been discussed =
btw.
>> >
>>
>> I'm if I missed that discussion, but enable_irq cannot know who is
>> calling it and therefore cannot know if IRQ_SUSPENDED should be
>> cleared.
>
> This change has been requested by Ingo and for a reason.
>
> Ingo, what's your opinion?
>
>> >> > @@ -222,8 +222,9 @@ static void __enable_irq(struct irq_desc
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN(1, KERN_WARNING "Unbalanced ena=
ble for IRQ %d\n", irq);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> >> > =A0 =A0 =A0 =A0case 1: {
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int status =3D desc->status =
& ~IRQ_DISABLED;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int status;
>> >> >
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D desc->status & ~(IRQ_DISAB=
LED | IRQ_SUSPENDED);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Prevent probing on this irq: */
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->status =3D status | IRQ_NOPROB=
E;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_irq_resend(desc, irq);
>> >>
>> >> This only clears IRQ_SUSPENDED if the interrupt was not disabled
>> >> elsewhere. If a driver calls interrupt_disable in suspend_late, but
>> >> calls interrupt_enable lazily, resume_device_irqs will reenable the
>> >> interrupt even though the driver has a disable reference.
>> >
>> > Then I'd regard the driver as buggy.
>>
>> The bug is not in the driver. The driver called disable_irq once. You
>> called disable_irq once, but enable_irq twice.
>
> Please.
>
> Can you show me a _single_ _driver_ currently in the tree doing something
> like you describe in suspend_late and resume_early? =A0If you can't, then=
 please
> give up.

I don't know if any drivers call disable_irq or enable_irq in their
suspend hooks, but your change also allow timers, and I assume kernel
threads, to run during this phase.

There are several drivers (keypad drivers in particular), in tree and
out of tree, that call enable_irq from timers, and disable_irq from
their interrupt handler. If you also apply your later change to
disable non boot cpus after suspend_device_irqs, then on smp systems
the interrupt handler may run at the same time as suspend_device_irqs.
If suspend_device_irqs gets the spinlock first, then IRQ_SUSPENDED
gets set. If another suspend/resume cycle happens before the timer
runs, you will incorrectly enable the interrupt.

-- =

Arve Hj=F8nnev=E5g
