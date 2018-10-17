From: Jonas Danielsson <jonas@orbital-systems.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date: Wed, 17 Oct 2018 14:17:14 +0200
Message-ID: <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com> <2351196.3BzoFE0xYq@ws-140106>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2351196.3BzoFE0xYq@ws-140106>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.stein@systec-electronic.com
Cc: Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Nicolas Ferre <Nicolas.Ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 16, 2018 at 4:52 PM Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
>
> On Tuesday, October 16, 2018, 3:30:24 PM CEST Claudiu.Beznea@microchip.co=
m wrote:
> > Hi Jonas,
> >
> > On 07.10.2018 15:57, Jonas Danielsson wrote:
> > > From: Jonas Danielsson <jonas@orbital-systems.com>
> > >
> > > This fixes a bug where our embedded system (AT91SAM9260 based) would
> > > hang at reboot. At the most we managed 16 boot loops without a hang.
> > >
> > > With this patch applied the problem has not been observed and the boa=
rd
> > > has managed above 250 boot loops.
> > >
> > > The AT91SAM9260 datasheet tells us that with the instruction cache
> > > disabled all instructions are fetched from SDRAM. And we have an erra=
ta
> > > telling us we must power down the SDRAM before issuing cpu reset.
> > >
> > > This means we need the instruction cache enabled in at91sam9260_reset=
()
> > > At the moment it is being disabled in cpu_proc_fin() which is called =
from
> > > arch/arm/kernel/reboot.c.
> >
> > Are you using kexec reboot or implemented hibernate mode on this machin=
e?
> > I'm seeing cpu_proc_fin() is called only in case of kexec reboot or
> > switching to hibernate mode.
> >
> > In case of normal reboot (e.g. reboot command) machine_restart() from
> > arch/arm/kernel/reboot.c is called. Please correct me if I'm wrong.
>
> Another location is cpu_reset() aka cpu_arm926_reset() in proc-arm926.S
> which also disables I-cache. But I can't track down a callstack
> ending there.
>

We take the normal path of sys_reboot =3D> kernel_restart =3D> machine_rest=
art ...

I added code to print the c1 register in different paths. And I-cache
is enabled.
So now I am really confused about why the patch worked.

> Best regards,
> Alexander

Jonas

>
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
