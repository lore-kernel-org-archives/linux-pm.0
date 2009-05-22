From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Sat, 23 May 2009 07:32:22 +0900
Message-ID: <4d34a0a70905221532l772d03b6gb6436f0b8eb10274__30398.7473053441$1243031634$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<4d34a0a70905211953r1138a554w3b7aa99770ba15e2@mail.gmail.com>
	<4d34a0a70905220904h6734a8f1y2b2cffe08b6afa8b@mail.gmail.com>
	<200905222325.27950.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905222325.27950.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, May 23, 2009 at 6:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 22 May 2009, Kim Kyuwon wrote:
>> On Fri, May 22, 2009 at 11:53 AM, Kim Kyuwon <chammoru@gmail.com> wrote:
>> > On Wed, May 6, 2009 at 8:27 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> On Wednesday 06 May 2009, Kevin Hilman wrote:
>> >>> Arve Hj=F8nnev=E5g <arve@android.com> writes:
>> >>>
>> >>> > On Tue, May 5, 2009 at 8:52 AM, Kevin Hilman
>> >>> > <khilman@deeprootsystems.com> wrote:
>> >>> >> Andrew Morton <akpm@linux-foundation.org> writes:
>> >>> >>
>> >>> >>> On Mon, =A04 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deepr=
ootsystems.com> wrote:
>> >>> >>>
>> >>> >>>> Interrupts that are flagged as wakeup sources via set_irq_wake()
>> >>> >>>> should not be disabled for suspend.
>> >>> >>>>
>> >>> >>>
>> >>> >>> Why not?
>> >>> >>>
>> >>> >>
>> >>> >> If an interrupt is a wakeup source, and it is disabled at the chip
>> >>> >> level, it will no longer generate interrupts, and thus no longer =
wake
>> >>> >> up the system.
>> >>> >>
>> >>> >> I'd be interested in hearing why wakeup interrupts should be disa=
bled
>> >>> >> during suspend.
>> >>
>> >> That depends on whether or not they are used for anything else than w=
ake-up.
>> >>
>> >>>
>> >>> [...]
>> >>>
>> >>> >>>
>> >>> >>> If this fixes some bug then please provide a description of that=
 bug?
>> >>> >>
>> >>> >> The bug is that on TI OMAP, interrupts that are used for wakeup e=
vents
>> >>> >> are disabled by this code causing the system to no longer wake up.
>> >>> >
>> >>> > What do you do if the interrupt triggers right after your driver h=
as
>> >>> > returned from its late suspend hook?
>> >>>
>> >>> If it's a wakeup IRQ, I assume you want it to prevent suspend.
>> >>>
>> >>> But I don't see how that can happen in the current code. IIUC, by the
>> >>> time your late suspend hook is run, your device IRQ is already
>> >>> disabled, so it won't trigger an interrupt that will be caught by
>> >>> check_wakeup_irqs() anyways.
>> >>
>> >> My understanding of __disable_irq() was that it didn't actually disab=
le the
>> >> IRQ at the hardware level, allowing the CPU to actually receive the i=
nterrupt
>> >> and acknowledge it, but preventing the device driver for receiving it=
. =A0Does
>> >> it work differently on the affected systems?
>> >
>> > Hi, Rafael.
>> > Sorry for bring the old issue but please let me ask you about
>> > suspend_device_irqs() function.
>> >
>> > __disable_irq() disables the IRQ at the hardware level in the
>> > following irq_chips
>> >
>> > i8259A_chip
>> > i8259_pic
>> > i8259A_chip
>> > bfin_internal_irqchip
>> > crisv10_irq_type
>> > crisv32_irq_type
>> > h8300irq_chip
>> > m_irq_chip
>> > mn10300_cpu_pic_level
>> > xtensa_irq_chip
>> > iop13xx_msi_chip
>> > msi_irq
>> >
>> > Because these irq_chips mask interrupts in 'disable' hook.
>> >
>> > Thus, your suspend_device_irqs() function disables all IRQs at the
>> > hardware level on all architectures which use irq_chips listed above
>> > in suspend state.
>> > Is this really what you wanted?
>> >
>> > If interrupt can wake up the system from suspend in some architectures
>> > and if disable_irq_wake is not supported in these architectures, I
>> > wonder if suspend_device_irqs() don't allow waking up by interrupt.
>> >
>> > Regards,
>> > Kyuwon
>> >
>>
>> I saw resume_device_irqs() is invoked after arch_suspend_enable_irqs()
>> in your resume code.
>> So in this gap between resume_device_irqs() and
>> arch_suspend_enable_irqs(), a few interrupts would be discarded.
>> i.e, a few data would be lost.
>>
>> If keypad wake up the system, first key pressed information would be los=
t.
>> If I2C, USB, SPI, UART wake up the system, first a few data would be los=
t.
>>
>> Did you also consider this issue?
>
> I think it would happen anyway with the old code, wouldn't it?

That's not quite right.

For example, let's assume a keypad device is alive in suspend/resume
state to wake up the system. Before arch_suspend_enable_irqs(), none
of keypad irqs is dropped. It is just pending.
But in your code, a few irqs are discarded due to your resume_device_irqs().

Regards,
Kyuwon
