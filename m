From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Tue, 5 May 2009 13:58:36 -0700
Message-ID: <d6200be20905051358m34c2be02ped84ad4158cd9865__35076.6994212337$1241557368$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<20090504235405.647772ed.akpm@linux-foundation.org>
	<87ocu7a6ng.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87ocu7a6ng.fsf@deeprootsystems.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2009 at 8:52 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> On Mon, =A04 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deeprootsyste=
ms.com> wrote:
>>
>>> Interrupts that are flagged as wakeup sources via set_irq_wake()
>>> should not be disabled for suspend.
>>>
>>
>> Why not?
>>
>
> If an interrupt is a wakeup source, and it is disabled at the chip
> level, it will no longer generate interrupts, and thus no longer wake
> up the system.
>
> I'd be interested in hearing why wakeup interrupts should be disabled
> during suspend.
>
>>>
>>> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
>>> index 638d8be..99113bd 100644
>>> --- a/kernel/irq/pm.c
>>> +++ b/kernel/irq/pm.c
>>> @@ -28,6 +28,9 @@ void suspend_device_irqs(void)
>>> =A0 =A0 =A0for_each_irq_desc(irq, desc) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long flags;
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0if (desc->status & IRQ_WAKEUP)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&desc->lock, flags);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0__disable_irq(desc, irq, true);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&desc->lock, flags);
>>
>> If this fixes some bug then please provide a description of that bug?
>
> The bug is that on TI OMAP, interrupts that are used for wakeup events
> are disabled by this code causing the system to no longer wake up.

What do you do if the interrupt triggers right after your driver has
returned from its late suspend hook? By leaving the interrupt enabled
you prevent check_wakeup_irqs from aborting suspend.

-- =

Arve Hj=F8nnev=E5g
