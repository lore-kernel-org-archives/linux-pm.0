From: Jonas Danielsson <jonas@orbital-systems.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date: Tue, 16 Oct 2018 16:19:15 +0200
Message-ID: <CALDOjzh4+gtFk2ezvY4MYCT_rhjUdhfjdYgNFakA=TaXk5Oo2Q@mail.gmail.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org> <4836921.pHbLXnhTfm@ws-140106>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4836921.pHbLXnhTfm@ws-140106>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.stein@systec-electronic.com
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 16, 2018 at 4:03 PM Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
>
> Do you have CONFIG_CPU_ICACHE_DISABLE enabled?
> I wonder why I-cache is disabled. I know about this errata, AT91SAM9G20 i=
s affected as well.
>

Hi Alexander!

I just checked, we do not have CONFIG_CPU_ICACHE_DISABLE enabled.
I wonder as well! If you have any idea I can try them out on my board tomor=
row!

The effect of enabling them is real. I have managed over 1000 reboots
with this patch.
And at the most 20 without.

> Best regards,
> Alexander

Jonas

>
> On Sunday, October 7, 2018, 2:57:45 PM CEST Jonas Danielsson wrote:
> > From: Jonas Danielsson <jonas@orbital-systems.com>
> >
> > This fixes a bug where our embedded system (AT91SAM9260 based) would
> > hang at reboot. At the most we managed 16 boot loops without a hang.
> >
> > With this patch applied the problem has not been observed and the board
> > has managed above 250 boot loops.
> >
> > The AT91SAM9260 datasheet tells us that with the instruction cache
> > disabled all instructions are fetched from SDRAM. And we have an errata
> > telling us we must power down the SDRAM before issuing cpu reset.
> >
> > This means we need the instruction cache enabled in at91sam9260_reset()
> > At the moment it is being disabled in cpu_proc_fin() which is called fr=
om
> > arch/arm/kernel/reboot.c.
> >
> > Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> > ---
> >  drivers/power/reset/at91-reset.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at9=
1-reset.c
> > index f44a9ffcc2ab..78972bba64df 100644
> > --- a/drivers/power/reset/at91-reset.c
> > +++ b/drivers/power/reset/at91-reset.c
> > @@ -50,14 +50,24 @@ static void __iomem *at91_ramc_base[2], *at91_rstc_=
base;
> >  static struct clk *sclk;
> >
> >  /*
> > -* unless the SDRAM is cleanly shutdown before we hit the
> > +* Errata 43.1.7.1 RSTC: Reset during SDRAM Accesses
> > +*
> > +* Unless the SDRAM is cleanly shutdown before we hit the
> >  * reset register it can be left driving the data bus and
> >  * killing the chance of a subsequent boot from NAND
> > +*
> > +* Since we are disabling SDRAM need to make sure that the
> > +* instruction cache is enabled.
> >  */
> >  static int at91sam9260_restart(struct notifier_block *this, unsigned l=
ong mode,
> >                              void *cmd)
> >  {
> >       asm volatile(
> > +             /* Enable I-cache */
> > +             "mrc    p15, 0, r0, c1, c0, 0\n\t"
> > +             "orr    r0, r0, #4096\n\t" /* CR_I (bit 12) */
> > +             "mcr    p15, 0, r0, c1, c0, 0\n\t"
> > +
> >               /* Align to cache lines */
> >               ".balign 32\n\t"
> >
> >
>
>
> --
> SYS TEC electronic GmbH
> Am Windrad 2
> 08468 Heinsdorfergrund
> Germany
> Telefon : +49 (0) 3765 38600-0
> Fax     : +49 (0) 3765 38600-4100
> Email   : alexander.stein@systec-electronic.com
> Website : http://www.systec-electronic.com
>
> Managing Director   : Dipl.-Phys. Siegmar Schmidt
> Commercial registry : Amtsgericht Chemnitz, HRB 28082
> USt.-Id Nr.         : DE150534010
>
> Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtzte=
 Informationen.
> Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=C3=BCmli=
ch erhalten haben, informieren Sie bitte sofort den Absender und vernichten=
 Sie diese Mail.
> Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail sind n=
icht gestattet.
>
> This e-mail may contain confidential and/or privileged information.
> If you are not the intended recipient (or have received this e-mail in er=
ror) please notify the sender immediately and destroy this e-mail.
> Any unauthorized copying, disclosure or distribution of the material in t=
his e-mail is strictly forbidden.
>
>


--=20






JONAS DANIELSSON
Software Developer

+46 72 361 5022
Malm=C3=B6 - Sweden

ORBITAL SYSTEMS
orbital-systems.com




The information contained in this message is intended for the personal
and confidential use of the designated recipients named above and may
contain confidential and/or privileged material. If the reader of this
message is not the intended recipient or an agent responsible for
delivering it to the intended recipient, you are hereby notified that
you have received this document in error, and that any review,
dissemination, distribution, or copying of this message is strictly
prohibited. If you have received this communication in error, please
notify the sender immediately and delete this e-mail from your system.

Although this transmission and any attachments are believed to be free
of any virus or other defect that might affect any computer system
into which it is received and opened, it is the responsibility of the
recipient to ensure that it is virus free and no responsibility is
accepted by ORBITAL SYSTEMS AB, its subsidiaries and affiliates, as
applicable, for any loss or damage arising in any way.
