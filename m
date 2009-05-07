From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Thu, 7 May 2009 11:04:06 +0900
Message-ID: <4d34a0a70905061904w338457efna8a3cbb80537e0c9__43701.7828495756$1241662138$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<87y6tb3x6r.fsf@deeprootsystems.com>
	<871vr22upr.fsf@deeprootsystems.com>
	<200905062318.23572.rjw@sisk.pl> <87zldpu5rt.fsf@deeprootsystems.com>
	<d6200be20905061818h58145d5fie5c55ceaf900a196@mail.gmail.com>
	<4d34a0a70905061828l3e35a954k76967b30c1a241ab@mail.gmail.com>
	<d6200be20905061844q8a4945y83daa86b336dc49a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20905061844q8a4945y83daa86b336dc49a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, OMAP <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2009/5/7 Arve Hj=F8nnev=E5g <arve@android.com>:
> 2009/5/6 Kim Kyuwon <chammoru@gmail.com>:
>> 2009/5/7 Arve Hj=F8nnev=E5g <arve@android.com>:
>>> On Wed, May 6, 2009 at 5:16 PM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>>>>
>>>>> On Wednesday 06 May 2009, Kevin Hilman wrote:
>>>>>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>>
>>>> There is at least one problem with that which is why Kyuwon Kim added
>>>> the ->disable hook to OMAP's irq_chip.  The problem is with drivers
>>>> that call disable_irq() in their suspend hook, usually done to prevent
>>>> the device from waking the system since on OMAP, any IRQ can be
>>>> configured to wake the system.
>>>>
>>>
>>> This does not sound correct. disable_irq_wake should be used for this.
>>> A driver may need to mask its interrupt before suspending but this
>>> should not also disable it as a wakeup source.
>>
>> I wish I could use disable_irq_wake(), but it doesn't work in OMAP.
>
> This does not sound like a hardware problem.

We may need advices of TI engineers.
However, as far as I know, It is impossible to disable 'interrupt
wake-up' with interrupt enabled. Because an interrupt itself generate
a system wake-up event in OMAP3430 (Hardware level).
-- =

Kyuwon

> --
> Arve Hj=F8nnev=E5g
