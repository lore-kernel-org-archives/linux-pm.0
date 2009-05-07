From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] genirq: ensure IRQs are lazy disabled before
	suspend
Date: Thu, 7 May 2009 14:52:03 -0700
Message-ID: <d6200be20905071452t3efb67gffd4de5332e83e73__28704.3253229514$1241733403$gmane$org@mail.gmail.com>
References: <1241655468-5750-1-git-send-email-khilman@deeprootsystems.com>
	<1241655468-5750-2-git-send-email-khilman@deeprootsystems.com>
	<20090507111548.GH28398@elte.hu> <87k54ssx65.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k54ssx65.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 7, 2009 at 9:19 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> From a3f359c66bd0ae1bb2603e7cf120d9d4d68591b7 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Wed, 6 May 2009 16:00:07 -0700
> Subject: [PATCH] genirq: ensure IRQs are lazy disabled before suspend
>
> In commit 76d2160147f43f982dfe881404cfde9fd0a9da21, the default
> behavior of disable_irq() was changed to delay the disable until it is
> next handled.
>
> However, this leaves open the possibility that the system can go into
> suspend with an interrupt enabled. =A0For example, if a driver calls
> disable_irq() in its suspend_hook there's now a possibility that the
> system is suspended before the lazy disable happens.
>
> The result is an unwanted wakeup from suspend if the IRQ is capable of
> waking the system (common on embedded SoCs.)

If the interrupt contoller uses the same enable register for wakeup
and interrupts, I think it is the responsibility of the platform code,
not individual drivers, to disable the interrupts that are not marked
for wakeup before entering suspend.

> This patch ensures that the lazy disable is done, and masked by
> the irq_chip before the system goes into suspend.

This will create a window where wakeup interrupts can be lost if the
driver has masked the interrupt (by calling disable_irq). If the
hardware does not allow edge detection on disabled interrupts (the msm
platform has this limitation) then this change will turn off the edge
detection. If suspend_ops->enter does not turn the interrupt (and edge
detection) back on (without this change it may never need to turn on
any interrupt) it will not wakeup at all.

> Note that even though __disable_irq() also calls irq_chip->disable, it
> is quite common for the irq_chip not to provide a disable hook in
> which case the IRQ is never masked/disabled in hardware before going
> into suspend.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0kernel/irq/manage.c | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2734eca..c786820 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -190,6 +190,13 @@ void __disable_irq(struct irq_desc *desc, unsigned i=
nt irq, bool suspend)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!desc->action || (desc->action->flags =
& IRQF_TIMER))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->status |=3D IRQ_SUSPENDED;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Lazy disable: handles case where lazy =
disable in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* handler doesn't happen before suspend.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->status & IRQ_DISABLED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->chip->mask(irq);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!desc->depth++) {
> --
> 1.6.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Arve Hj=F8nnev=E5g
