From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Sat, 23 May 2009 00:29:17 +0200
Message-ID: <200905230029.18279.rjw__33696.0766850554$1243031438$gmane$org@sisk.pl>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<200905222323.22390.rjw@sisk.pl>
	<4d34a0a70905221524i1ac5a241k5f0a60ee542d55a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4d34a0a70905221524i1ac5a241k5f0a60ee542d55a5@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday 23 May 2009, Kim Kyuwon wrote:
> On Sat, May 23, 2009 at 6:23 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday 22 May 2009, Kim Kyuwon wrote:
> >> On Wed, May 6, 2009 at 8:27 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Wednesday 06 May 2009, Kevin Hilman wrote:
> >> >> Arve Hj=F8nnev=E5g <arve@android.com> writes:
> >> >>
> >> >> > On Tue, May 5, 2009 at 8:52 AM, Kevin Hilman
> >> >> > <khilman@deeprootsystems.com> wrote:
> >> >> >> Andrew Morton <akpm@linux-foundation.org> writes:
> >> >> >>
> >> >> >>> On Mon,  4 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deepro=
otsystems.com> wrote:
> >> >> >>>
> >> >> >>>> Interrupts that are flagged as wakeup sources via set_irq_wake=
()
> >> >> >>>> should not be disabled for suspend.
> >> >> >>>>
> >> >> >>>
> >> >> >>> Why not?
> >> >> >>>
> >> >> >>
> >> >> >> If an interrupt is a wakeup source, and it is disabled at the ch=
ip
> >> >> >> level, it will no longer generate interrupts, and thus no longer=
 wake
> >> >> >> up the system.
> >> >> >>
> >> >> >> I'd be interested in hearing why wakeup interrupts should be dis=
abled
> >> >> >> during suspend.
> >> >
> >> > That depends on whether or not they are used for anything else than =
wake-up.
> >> >
> >> >>
> >> >> [...]
> >> >>
> >> >> >>>
> >> >> >>> If this fixes some bug then please provide a description of tha=
t bug?
> >> >> >>
> >> >> >> The bug is that on TI OMAP, interrupts that are used for wakeup =
events
> >> >> >> are disabled by this code causing the system to no longer wake u=
p.
> >> >> >
> >> >> > What do you do if the interrupt triggers right after your driver =
has
> >> >> > returned from its late suspend hook?
> >> >>
> >> >> If it's a wakeup IRQ, I assume you want it to prevent suspend.
> >> >>
> >> >> But I don't see how that can happen in the current code. IIUC, by t=
he
> >> >> time your late suspend hook is run, your device IRQ is already
> >> >> disabled, so it won't trigger an interrupt that will be caught by
> >> >> check_wakeup_irqs() anyways.
> >> >
> >> > My understanding of __disable_irq() was that it didn't actually disa=
ble the
> >> > IRQ at the hardware level, allowing the CPU to actually receive the =
interrupt
> >> > and acknowledge it, but preventing the device driver for receiving i=
t.  Does
> >> > it work differently on the affected systems?
> >>
> >> Hi, Rafael.
> >> Sorry for bring the old issue but please let me ask you about
> >> suspend_device_irqs() function.
> >>
> >> __disable_irq() disables the IRQ at the hardware level in the
> >> following irq_chips
> >>
> >> i8259A_chip
> >> i8259_pic
> >> i8259A_chip
> >> bfin_internal_irqchip
> >> crisv10_irq_type
> >> crisv32_irq_type
> >> h8300irq_chip
> >> m_irq_chip
> >> mn10300_cpu_pic_level
> >> xtensa_irq_chip
> >> iop13xx_msi_chip
> >> msi_irq
> >>
> >> Because these irq_chips mask interrupts in 'disable' hook.
> >>
> >> Thus, your suspend_device_irqs() function disables all IRQs at the
> >> hardware level on all architectures which use irq_chips listed above
> >> in suspend state.
> >> Is this really what you wanted?
> >
> > What we wanted was to resolve specific issue related to the handling of
> > interrupts during suspend and resume which caused observable breakage a=
nd
> > from the point of view of fixing this issue it doesn't really matter wh=
ether or
> > not interrupts are masked in the disable hook.
> >
> >> If interrupt can wake up the system from suspend in some architectures
> >> and if disable_irq_wake is not supported in these architectures, I
> >> wonder if suspend_device_irqs() don't allow waking up by interrupt.
> >
> > I think that the platforms that may be affected by this issue will have=
 to take
> > care of it.
> =

> You changed the really important part of Linux, which may affect most
> processor architectures. I think you should be careful. If some of
> architectures can't take care of it (they can implement
> disable_irq_wake correctly in H/W level, will you revert your changes?

No, the changes are not going to be reverted.  In fact things should have b=
een
done like this already much earlier.

Now, do you have any particular example of a problem related to these chang=
es
or is it only a theoretical issue?

Rafael
