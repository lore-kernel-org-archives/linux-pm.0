From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 25 Feb 2007 11:51:11 +0100
Message-ID: <200702251151.12107.rjw@sisk.pl>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411> <200702251117.30462.rjw@sisk.pl> <200702251337.08914.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200702251337.08914.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 25 February 2007 11:37, Andrey Borzenkov wrote:
> On =D0=92=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=81=D0=B5=D0=BD=D1=8C=D0=B5=
 25 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2007, Rafael J. Wysocki =
wrote:
> > On Sunday, 25 February 2007 00:26, Andrey Borzenkov wrote:
> > > On =D0=A1=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0 24 =D1=84=D0=B5=D0=B2=
=D1=80=D0=B0=D0=BB=D1=8F 2007, Rafael J. Wysocki wrote:
> > > > Hi,
> > > >
> > > > On Saturday, 24 February 2007 10:55, Andrey Borzenkov wrote:
> > > > > On =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA 13 =D1=84=D0=B5=
=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2007, Andrey Borzenkov wrote:
> > > > > > On =D0=A7=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3 07 =D0=B4=D0=B5=
=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2006, Lebedev, Vladimir P wrote:
> > > > > > > Please register new bug, attach acpidump and dmesg.
> > > > > >
> > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=3D7995
> > > > > >
> > > > > > regards
> > > > >
> > > > > Well, this starts looking like ACPI is not at fault.
> > > > >
> > > > > When reporting AC state ACPI just reads contents of system me=
mory (I
> > > > > presume it gets updated by BIOS/ACPI when AC state changes). =
It looks
> > > > > like this memory area is restored during resume from STD. I u=
pdated
> > > > > mentioned bug report with more detailed description. Now if s=
omeone
> > > > > could suggest a way to catch if specific physical address get=
s
> > > > > saved/restored this would finally explain it.
> > > >
> > > > First, if you want the reserved memory areas to be left alone b=
y
> > > > swsusp, you need to mark them as 'nosave'.  On x86_64 this is d=
one by
> > > > the function e820_mark_nosave_range() in arch/x86_64/kernel/e82=
0.c that
> > > > can be ported to i386 with no problems.  However, we haven't fo=
und that
> > > > very useful, so far, since no one has ever reported any problem=
s with
> > > > the current approach, which is to save and restore them.
> > >
> > > Well, the following proof of concept patch fixes this issue for m=
e.
> > > Please notice that original version of e820_mark_nosave_range() c=
ould
> > > fail to exclude some areas due to alignment issues (exactly what =
happened
> > > to me on first try) so it still can explain your problem too.
> >
> > Great job, thanks for the patch!  It looks good, so I'm going to fo=
rward it
> > for merging.
> >
>=20
> Please no; I'm currently testing slightly more polished version; I wi=
ll send
> it later.

OK

> Could anybody explain (or give pointer to) what happens which region =
that is
> not page-aligned? In particular, the very first one:
>=20
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>=20
> Will the kernel allocate partial page (how?) or will the kernel ignor=
e last
> (first) incomplete page? In the former case how those incomplete page=
s can be
> detected?

Well, on x86_64, if I understand e820_register_active_regions() correct=
ly,
the partial pages won't be registered.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
