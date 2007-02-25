From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 25 Feb 2007 11:17:29 +0100
Message-ID: <200702251117.30462.rjw@sisk.pl>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411> <200702242046.20216.rjw@sisk.pl> <200702250226.34877.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200702250226.34877.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 25 February 2007 00:26, Andrey Borzenkov wrote:
> On =D0=A1=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0 24 =D1=84=D0=B5=D0=B2=D1=
=80=D0=B0=D0=BB=D1=8F 2007, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Saturday, 24 February 2007 10:55, Andrey Borzenkov wrote:
> > > On =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA 13 =D1=84=D0=B5=D0=B2=
=D1=80=D0=B0=D0=BB=D1=8F 2007, Andrey Borzenkov wrote:
> > > > On =D0=A7=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3 07 =D0=B4=D0=B5=D0=
=BA=D0=B0=D0=B1=D1=80=D1=8F 2006, Lebedev, Vladimir P wrote:
> > > > > Please register new bug, attach acpidump and dmesg.
> > > >
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=3D7995
> > > >
> > > > regards
> > >
> > > Well, this starts looking like ACPI is not at fault.
> > >
> > > When reporting AC state ACPI just reads contents of system memory=
 (I
> > > presume it gets updated by BIOS/ACPI when AC state changes). It l=
ooks
> > > like this memory area is restored during resume from STD. I updat=
ed
> > > mentioned bug report with more detailed description. Now if someo=
ne could
> > > suggest a way to catch if specific physical address gets saved/re=
stored
> > > this would finally explain it.
> >
> > First, if you want the reserved memory areas to be left alone by sw=
susp,
> > you need to mark them as 'nosave'.  On x86_64 this is done by the f=
unction
> > e820_mark_nosave_range() in arch/x86_64/kernel/e820.c that can be p=
orted to
> > i386 with no problems.  However, we haven't found that very useful,=
 so far,
> > since no one has ever reported any problems with the current approa=
ch,
> > which is to save and restore them.
> >
>=20
> Well, the following proof of concept patch fixes this issue for me. P=
lease=20
> notice that original version of e820_mark_nosave_range() could fail t=
o=20
> exclude some areas due to alignment issues (exactly what happened to =
me on=20
> first try) so it still can explain your problem too.

Great job, thanks for the patch!  It looks good, so I'm going to forwar=
d it for
merging.

I'll also change the x86_64 version to use PFN_UP and PFN_DOWN.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
