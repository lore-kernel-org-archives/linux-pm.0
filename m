From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] genirq: ensure IRQs are lazy disabled before
	suspend
Date: Fri, 08 May 2009 16:33:25 -0700
Message-ID: <8763gbmapm.fsf__26039.8852210075$1241826136$gmane$org@deeprootsystems.com>
References: <1241655468-5750-1-git-send-email-khilman@deeprootsystems.com>
	<1241655468-5750-2-git-send-email-khilman@deeprootsystems.com>
	<20090507111548.GH28398@elte.hu> <87k54ssx65.fsf@deeprootsystems.com>
	<d6200be20905071452t3efb67gffd4de5332e83e73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20905071452t3efb67gffd4de5332e83e73@mail.gmail.com>
	("Arve =?iso-8859-1?Q?Hj=F8nnev=E5g=22's?= message of "Thu\, 7 May 2009
	14\:52\:03 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Arve Hj=F8nnev=E5g <arve@android.com> writes:

> On Thu, May 7, 2009 at 9:19 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From a3f359c66bd0ae1bb2603e7cf120d9d4d68591b7 Mon Sep 17 00:00:00 2001
>> From: Kevin Hilman <khilman@deeprootsystems.com>
>> Date: Wed, 6 May 2009 16:00:07 -0700
>> Subject: [PATCH] genirq: ensure IRQs are lazy disabled before suspend
>>
>> In commit 76d2160147f43f982dfe881404cfde9fd0a9da21, the default
>> behavior of disable_irq() was changed to delay the disable until it is
>> next handled.
>>
>> However, this leaves open the possibility that the system can go into
>> suspend with an interrupt enabled. =A0For example, if a driver calls
>> disable_irq() in its suspend_hook there's now a possibility that the
>> system is suspended before the lazy disable happens.
>>
>> The result is an unwanted wakeup from suspend if the IRQ is capable of
>> waking the system (common on embedded SoCs.)
>
> If the interrupt contoller uses the same enable register for wakeup
> and interrupts, I think it is the responsibility of the platform code,
> not individual drivers, to disable the interrupts that are not marked
> for wakeup before entering suspend.

I agree, for wakeup interrupts, drivers should use
[set|disable]_irq_wake() and the platform code should handle this.

I used wakeup interrupts in this description as an example which
turned out to be a bad example.  The 2nd version of this patch I
posted, I removed the reference to wakeup interrupts in favor of just
talking about the delayed disable piece.

But ignoring wakup interrupts, would you agree that the delayed
disable of an interrupt should not wait until after resume?

>> This patch ensures that the lazy disable is done, and masked by
>> the irq_chip before the system goes into suspend.
>
> This will create a window where wakeup interrupts can be lost if the
> driver has masked the interrupt (by calling disable_irq). If the
> hardware does not allow edge detection on disabled interrupts (the msm
> platform has this limitation) then this change will turn off the edge
> detection. If suspend_ops->enter does not turn the interrupt (and edge
> detection) back on (without this change it may never need to turn on
> any interrupt) it will not wakeup at all.

Not sure I follow you here...

It seems like you're relying on the delayed disable to wait until
after resume so that disabled interrupts can wake the system.  How
did this work before the delayed disable patch?

If the interrupt is being used as a wakeup, why would anyone be
calling disable_irq()?

Kevin
