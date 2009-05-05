From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Wed, 6 May 2009 01:27:23 +0200
Message-ID: <200905060127.24777.rjw__22426.6910845929$1241566206$gmane$org@sisk.pl>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<d6200be20905051358m34c2be02ped84ad4158cd9865@mail.gmail.com>
	<87eiv35eg6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87eiv35eg6.fsf@deeprootsystems.com>
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
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 06 May 2009, Kevin Hilman wrote:
> Arve Hj=F8nnev=E5g <arve@android.com> writes:
> =

> > On Tue, May 5, 2009 at 8:52 AM, Kevin Hilman
> > <khilman@deeprootsystems.com> wrote:
> >> Andrew Morton <akpm@linux-foundation.org> writes:
> >>
> >>> On Mon,  4 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deeprootsyst=
ems.com> wrote:
> >>>
> >>>> Interrupts that are flagged as wakeup sources via set_irq_wake()
> >>>> should not be disabled for suspend.
> >>>>
> >>>
> >>> Why not?
> >>>
> >>
> >> If an interrupt is a wakeup source, and it is disabled at the chip
> >> level, it will no longer generate interrupts, and thus no longer wake
> >> up the system.
> >>
> >> I'd be interested in hearing why wakeup interrupts should be disabled
> >> during suspend.

That depends on whether or not they are used for anything else than wake-up.

> =

> [...]
> =

> >>>
> >>> If this fixes some bug then please provide a description of that bug?
> >>
> >> The bug is that on TI OMAP, interrupts that are used for wakeup events
> >> are disabled by this code causing the system to no longer wake up.
> >
> > What do you do if the interrupt triggers right after your driver has
> > returned from its late suspend hook?  =

> =

> If it's a wakeup IRQ, I assume you want it to prevent suspend.
> =

> But I don't see how that can happen in the current code. IIUC, by the
> time your late suspend hook is run, your device IRQ is already
> disabled, so it won't trigger an interrupt that will be caught by
> check_wakeup_irqs() anyways.

My understanding of __disable_irq() was that it didn't actually disable the
IRQ at the hardware level, allowing the CPU to actually receive the interru=
pt
and acknowledge it, but preventing the device driver for receiving it.  Does
it work differently on the affected systems?

Rafael
