From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 4 Feb 2009 16:44:30 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0902041642450.7690__3070.67667968131$1233762992$gmane$org@vixen.sonytel.be>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902041628.03675.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, frank@f-seidel.de, shaohuhua.li@intel.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, kristen.c.accardi@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Feb 2009, Frans Pop wrote:
> Frank Seidel wrote:
> > +++ b/drivers/acpi/pci_link.c
> > @@ -593,7 +593,7 @@ static int acpi_pci_link_allocate(struct
> >                 return -ENODEV;
> >         } else {
> >                 acpi_irq_penalty[link->irq.active] +=3D PIRQ_PENALTY_PC=
I_USING;
> > -               printk(PREFIX "%s [%s] enabled at IRQ %d\n",
> > +               printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n=
",
> >                 acpi_device_name(link->device),
> >                 acpi_device_bid(link->device), link->irq.active);
> >         }
> > @@ -751,21 +751,21 @@ static int acpi_pci_link_add(struct acpi
> >         acpi_device_bid(device));
> >         for (i =3D 0; i < link->irq.possible_count; i++) {
> >                 if (link->irq.active =3D=3D link->irq.possible[i]) {
> > -                       printk(" *%d", link->irq.possible[i]);
> > +                       printk(KERN_INFO " *%d", link->irq.possible[i]);
> >                         found =3D 1;
> >                 } else
> > -                       printk(" %d", link->irq.possible[i]);
> > +                       printk(KERN_INFO " %d", link->irq.possible[i]);
> >         }
> > =

> > -       printk(")");
> > +       printk(KERN_INFO ")");
> > =

> >         if (!found)
> > -               printk(" *%d", link->irq.active);
> > +               printk(KERN_INFO " *%d", link->irq.active);
> > =

> =

> This patch looks broken to me, at least for some of your changes.
> For example, in the bit quoted above all printks together make up
> *one single* message, which means that only the _first_ of the
> printks should have the KERN_* prefix. printks that are continuations
> should not have the prefix.

Actually they should, but the right prefix :-)

Quoting include/linux/kernel.h:

| /*
|  * Annotation for a "continued" line of log printout (only done after a
|  * line that had no enclosing \n). Only to be used by core/arch code
|  * during early bootup (a continued line is not SMP-safe otherwise).
|  */
| #define KERN_CONT       ""

Please also consider the note about SMP-safeness.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
