From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sat, 24 Feb 2007 20:46:18 +0100
Message-ID: <200702242046.20216.rjw@sisk.pl>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411> <200702132116.05404.arvidjaar@mail.ru> <200702241255.02073.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200702241255.02073.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday, 24 February 2007 10:55, Andrey Borzenkov wrote:
> On =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA 13 =D1=84=D0=B5=D0=B2=D1=
=80=D0=B0=D0=BB=D1=8F 2007, Andrey Borzenkov wrote:
> > On =D0=A7=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3 07 =D0=B4=D0=B5=D0=BA=
=D0=B0=D0=B1=D1=80=D1=8F 2006, Lebedev, Vladimir P wrote:
> > > Please register new bug, attach acpidump and dmesg.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D7995
> >
> > regards
> >
>=20
> Well, this starts looking like ACPI is not at fault.
>=20
> When reporting AC state ACPI just reads contents of system memory (I =
presume
> it gets updated by BIOS/ACPI when AC state changes). It looks like th=
is
> memory area is restored during resume from STD. I updated mentioned b=
ug
> report with more detailed description. Now if someone could suggest a=
 way to
> catch if specific physical address gets saved/restored this would fin=
ally
> explain it.

=46irst, if you want the reserved memory areas to be left alone by swsu=
sp,
you need to mark them as 'nosave'.  On x86_64 this is done by the funct=
ion
e820_mark_nosave_range() in arch/x86_64/kernel/e820.c that can be porte=
d to
i386 with no problems.  However, we haven't found that very useful, so =
far,
since no one has ever reported any problems with the current approach,
which is to save and restore them.

Second, if you want to know if a suspicious page frame is saved by swsu=
sp,
it's best to stick a test and a printk in kernel/power/pack_pfns() and
artificially fail the suspend, eg. by making swsusp_write() always retu=
rn
an error.

> Gratefully waiting for patches to test :)

Sorry, no patches this time.  I have more urgent problem to fix. :-)

Greetings,
Rafael


> > > -----Original Message-----
> > > From: Alexey Starikovskiy [mailto:alexey.y.starikovskiy@linux.int=
el.com]
> > >
> > > Sent: Thursday, December 07, 2006 10:49 PM
> > > To: Rafael J. Wysocki
> > > Cc: Karasyov, Konstantin A; Andrey Borzenkov;
> > > linux-acpi@vger.kernel.org; Lebedev, Vladimir P
> > > Subject: Re: 2.6.19: ACPI reports AC not present after resume fro=
m STD
> > >
> > > Rafael J. Wysocki wrote:
> > > > Hi,
> > > >
> > > > On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrot=
e:
> > > >> Hi,
> > > >>
> > > >> Unfortunately, I cannot reproduce this bug on my system, but t=
he
> > >
> > > problem
> > >
> > > >> could be solved by adding a resume handler for AC adapter devi=
ce.
> > >
> > > Could
> > >
> > > >> you try the attached patch to see if it helps.
> > > >
> > > > I can reproduce it and the patch doesn't help.
> > > >
> > > > Greetings,
> > > > Rafael
> > >
> > > Any ACPI errors in dmesg?
> > >
> > > Regards,
> > >     Alex.
>=20
>=20
>=20
>=20

--=20
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
