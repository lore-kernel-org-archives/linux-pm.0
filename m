From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 1/4] PM: Rework handling of interrupts
	during suspend-resume (rev. 4)
Date: Mon, 2 Mar 2009 15:01:33 -0800
Message-ID: <d6200be20903021501x4ad710fbr834b11b8a6647d2c__23725.1153252602$1236035180$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200903012321.40328.rjw@sisk.pl>
	<200903012324.39327.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903012324.39327.rjw@sisk.pl>
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

On Sun, Mar 1, 2009 at 2:24 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Introduce two helper functions allowing us to prevent device drivers
> from getting any interrupts (without disabling interrupts on the CPU)
> during suspend (or hibernation) and to make them start to receive
> interrupts again during the subsequent resume, respectively. =A0These
> functions make it possible to keep timer interrupts enabled while the
> "late" suspend and "early" resume callbacks provided by device
> drivers are being executed.
>
> Use these functions to rework the handling of interrupts during
> suspend (hibernation) and resume. =A0Namely, interrupts will only be
> disabled on the CPU right before suspending sysdevs, while device
> drivers will be prevented from receiving interrupts, with the help of
> the new helper function, before their "late" suspend callbacks run
> (and analogously during resume).
>
> In addition, since the device interrups are now disabled before the
> CPU has turned all interrupts off and the CPU will ACK the interrupts
> setting the IRQ_PENDING bit for them, check in sysdev_suspend() if
> any wake-up interrupts are pending and abort suspend if that's the
> case.
>


> +void resume_device_irqs(void)
> +{
> + =A0 =A0 =A0 struct irq_desc *desc;
> + =A0 =A0 =A0 int irq;
> +
> + =A0 =A0 =A0 for_each_irq_desc(irq, desc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->status & IRQ_SUSPENDED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(irq);
> +}

I think you need to clear IRQ_SUSPENDED here, not in enable_irq.

> @@ -222,8 +222,9 @@ static void __enable_irq(struct irq_desc
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN(1, KERN_WARNING "Unbalanced enable fo=
r IRQ %d\n", irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 1: {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int status =3D desc->status & ~IRQ=
_DISABLED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int status;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D desc->status & ~(IRQ_DISABLED | =
IRQ_SUSPENDED);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Prevent probing on this irq: */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->status =3D status | IRQ_NOPROBE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_irq_resend(desc, irq);

This only clears IRQ_SUSPENDED if the interrupt was not disabled
elsewhere. If a driver calls interrupt_disable in suspend_late, but
calls interrupt_enable lazily, resume_device_irqs will reenable the
interrupt even though the driver has a disable reference.

The rest of the patch looks good.

-- =

Arve Hj=F8nnev=E5g
