From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Fri, 27 Feb 2009 09:59:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902270948540.2926-100000__37501.080815173$1235747005$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0902262039320.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902262039320.3111@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Feb 2009, Linus Torvalds wrote:

> On Thu, 26 Feb 2009, Alan Stern wrote:
> > =

> > What you're missing is that the embedded world is quite a large one.  =

> =

> I'm gpoing to give you one more clue, and if you don't stop sending out =

> these IDIOTIC emails, I'm going to put you into my killfile.
> =

> Got it?

Whoa!!  Hold on there!  You got too angry too quickly.  I'm Alan Stern, =

not Arve Hj=F8nnev=E5g; that was the first email I've sent on this topic.

And while perhaps it was idiotic, you shouldn't put the blame for it on =

Arve.

> So listen up:
>  - the number of ARM chips sold doesn't matter one F*CKING WHIT.
>  - You need to add ONE SINGLE "sysdev" entry for ARM to take care of this =

>    FOR EVERY DAMN SINGLE ONE.
>  - Your inane whining about this AFTER I HAVE TOLD YOU MULTIPLE TIMES HOW =

>    TO DO IT, AND AFTER I HAVE TOLD YOU THAT IT'S A SPECIAL CASE, IS =

>    F*CKING IRRITATING.
> =

> Got it?
> =

> I _grepped_ for that enable_irq_wake() use. It looks like it's only used =

> on ARM and maybe BF. Add the five lines of code (just cut and paste them =

> from my earlier email) to your architecture already, AND STOP WHINING.

Really?  Let's see (this is using Greg KH's development tree):

$ find . -name '*.[ch]' | xargs grep enable_irq_wake
./drivers/serial/serial_core.c:         enable_irq_wake(port->irq);
./drivers/usb/gadget/at91_udc.c:                enable_irq_wake(udc->udp_ir=
q);
./drivers/usb/gadget/at91_udc.c:                enable_irq_wake(udc->board.=
vbus_pin);
./drivers/usb/musb/musb_core.c: if (enable_irq_wake(nIrq) =3D=3D 0) {
./drivers/usb/host/ohci-at91.c:         enable_irq_wake(hcd->irq);
./drivers/input/serio/sa1111ps2.c:      enable_irq_wake(ps2if->dev->irq[0]);
./drivers/input/keyboard/gpio_keys.c:                           enable_irq_=
wake(irq);
./drivers/input/keyboard/pxa27x_keypad.c:               enable_irq_wake(key=
pad->irq);
./drivers/input/keyboard/bf54x-keys.c:          enable_irq_wake(bf54x_kpad-=
>irq);
./drivers/pcmcia/at91_cf.c:             enable_irq_wake(board->det_pin);
./drivers/pcmcia/at91_cf.c:                     enable_irq_wake(board->irq_=
pin);
./drivers/mmc/host/at91_mci.c:          enable_irq_wake(host->board->det_pi=
n);
./drivers/mfd/htc-egpio.c:              enable_irq_wake(ei->chained_irq);
./drivers/mfd/pcf50633-core.c:  if (enable_irq_wake(client->irq) < 0)
./drivers/rtc/rtc-sa1100.c:             enable_irq_wake(IRQ_RTCAlrm);
./drivers/rtc/rtc-omap.c:               enable_irq_wake(omap_rtc_alarm);
./drivers/rtc/rtc-s3c.c:                enable_irq_wake(s3c_rtc_alarmno);
./drivers/rtc/rtc-at91rm9200.c:                 enable_irq_wake(AT91_ID_SYS=
);
./drivers/rtc/rtc-cmos.c:                       enable_irq_wake(cmos->irq);
./drivers/rtc/rtc-bfin.c:               enable_irq_wake(IRQ_RTC);
./drivers/rtc/rtc-ds1374.c:             enable_irq_wake(client->irq);
./drivers/rtc/rtc-at91sam9.c:                   enable_irq_wake(AT91_ID_SYS=
);
./drivers/rtc/rtc-pxa.c:                enable_irq_wake(pxa_rtc->irq_Alrm);
./drivers/power/pda_power.c:                    ac_wakeup_enabled =3D !enab=
le_irq_wake(ac_irq->start);
./drivers/power/pda_power.c:                    usb_wakeup_enabled =3D !ena=
ble_irq_wake(usb_irq->start);
./arch/arm/mach-sa1100/neponset.c:      enable_irq_wake(IRQ_GPIO25);
./arch/arm/mach-s3c2410/mach-amlm5900.c:                enable_irq_wake(IRQ=
_EINT9);
./arch/arm/mach-omap1/board-osk.c:                      enable_irq_wake(irq=
);
./arch/arm/mach-omap1/serial.c: enable_irq_wake(gpio_to_irq(gpio_nr));
./arch/arm/plat-omap/gpio.c:                    enable_irq_wake(bank->irq);
./arch/arm/plat-omap/gpio.c:                    enable_irq_wake(bank->irq);
./arch/arm/plat-omap/gpio.c:/* Use disable_irq_wake() and enable_irq_wake()=
 functions from drivers */
./include/linux/interrupt.h:static inline int enable_irq_wake(unsigned int =
irq)
./include/linux/interrupt.h:static inline int enable_irq_wake(unsigned int =
irq)

Perhaps these aren't all the sort of usage you're talking about, but I
bet most of them are.  It certainly looks like more than just ARM.  =

Maybe not all that much more, but definitely more.  And the number will
only grow in the future.

> It's not a generic case. It's not a problem. You can damn well fix it in =

> the ONE SINGLE ARCHITECTURE (or maybe two) that cares. I've told you how.

I'm not arguing with your suggestion; I'm merely disagreeing with your =

statement that wakeup interrupts are "definitely not the normal case".

Alan Stern
