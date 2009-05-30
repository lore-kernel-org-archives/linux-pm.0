From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Sat, 30 May 2009 16:34:38 +0900
Message-ID: <4d34a0a70905300034q1dee8febl60b5213082e3a5d1__11760.9277171598$1243668958$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<200905232214.57186.rjw@sisk.pl> <4A1A4297.50809@samsung.com>
	<200905300135.07103.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905300135.07103.rjw@sisk.pl>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Kim Kyuwon <q1.kim@samsung.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, May 30, 2009 at 8:35 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 25 May 2009, Kim Kyuwon wrote:
>> Rafael J. Wysocki wrote:
>> > On Saturday 23 May 2009, Kim Kyuwon wrote:
>> >> On Sat, May 23, 2009 at 7:29 AM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >>> On Saturday 23 May 2009, Kim Kyuwon wrote:
>> > [--snip--]
>> >>>> You changed the really important part of Linux, which may affect mo=
st
>> >>>> processor architectures. I think you should be careful. If some of
>> >>>> architectures can't take care of it (they can implement
>> >>>> disable_irq_wake correctly in H/W level, will you revert your chang=
es?
>> >>> No, the changes are not going to be reverted. =A0In fact things shou=
ld have been
>> >>> done like this already much earlier.
>> >>>
>> >>> Now, do you have any particular example of a problem related to thes=
e changes
>> >>> or is it only a theoretical issue?
>> >> I'd CCing you when I'm sending a mail for this particular example of =
a example.
>> >> http://markmail.org/thread/fvt7d62arofon5xx
>> >
>> > Well, as I said above, reverting the changes that introduced
>> > [suspend|resume]_device_irqs() is not an option, becuase it was the on=
ly sane
>> > way to achieve the goal they were added for. =A0So, we need to fix the=
 wake-up
>> > problem on your platform with the assumption that
>> > [suspend|resume]_device_irqs() are going to stay.
>> >
>> > For starters, would it be possible to teach the 'disable' hook of your
>> > platform's interrupt controller not to mask the IRQs that have both
>> > IRQ_WAKEUP and IRQ_SUSPENDED set? =A0That apparently would work around=
 the
>> > wake-up interrupts problem.
>>
>> Thank you for considering this issue and spending your time. In order to
>> make your idea work, we need to add a dummy 'set_wake' hook which
>> returns always zero. Anyway, IMO, I think your idea is good to work
>> around this problem. But Kevin Hilman(OMAP PM Maintainer) would make
>> final decision.
>>
>> Buy the way, how can you handle the problem that a few interrupt are
>> discarded in a small window? I can be sure they are discarded, because I
>> have debugged defects which generate in sleep/resume state hundreds of
>> times on ARM Processors(PXA310, S3C6410, OMAP3430). Wake-up interrupts
>> are generated as soon as arch_suspend_enable_irqs() invoked.
>
> Sorry for the delayed response.
>
> If the wake-up interrupts are not masked, they will be delivered to the d=
rivers
> as soon as arch_suspend_enable_irqs() has run. =A0So, if the drivers are =
able to
> handle them at this point (ie. before resume_device_irqs() is called), th=
ey
> won't be lost.

Thank you for your response!

Your suspend_device_irqs() disables all IRQs(except timer IRQ) while
entering suspend. i.e. Before invoking resume_device_irqs() or
resume_noirq callback, all IRQs(except timer IRQ) is in IRQ_DISABLED
status. Right?
But if an IRQ is in  IRQ_DISABLED status, its interrupt handler can be
invoked. (As you know, all IRQs with IRQ_DISABLE are not handled in
handle_level_irq function). Thus, even if the wake-up interrupts are
not masked, the drivers are not able to handle interrupts, because the
interrupt handler can't be invoked due to IRQ_DISABLED set by
suspend_device_irqs().

>=A0The only problem I see is that the drivers may expect their
> ->resume_noirq() callbacks to be executed first.

resume_noirq() callbacks are also invoked after arch_suspend_enable_irqs().

Regards,
Kyuwon
