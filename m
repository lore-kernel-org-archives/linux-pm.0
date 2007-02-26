From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Mon, 26 Feb 2007 22:23:14 +0100
Message-ID: <200702262223.14974.rjw@sisk.pl>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411> <200702251958.37315.rjw@sisk.pl> <200702262335.47874.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200702262335.47874.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 26 February 2007 21:35, Andrey Borzenkov wrote:
> On =D0=92=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=81=D0=B5=D0=BD=D1=8C=D0=B5=
 25 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2007, Rafael J. Wysocki =
wrote:
> >
> > The patch looks good, but the changelog does not.  First, AFAICT, t=
he
> > x86_64 code doesn't touch anything outside the e820 map.  Why do yo=
u think
> > it does?
> >
>=20
> the following code:
>=20
>        paddr =3D round_down(e820.map[0].addr + e820.map[0].size, PAGE=
_SIZE);
>         for (i =3D 1; i < e820.nr_map; i++) {
>                 struct e820entry *ei =3D &e820.map[i];
>=20
>                 if (paddr < ei->addr)
>                         e820_mark_nosave_range(paddr,
>                                         round_up(ei->addr, PAGE_SIZE)=
);
>=20
> obviously will mark region *between* two e820 regions if they are not
> adjacent. I do not say that it is wrong (I have no idea); but exactly=
 because
> I have no idea I tried to avoid it.

Yes, you are right, sorry.  We have to do this for x86_64, because ther=
e are
such holes in there on machines with more than 2 GB of RAM and swsusp c=
hokes
on them if they are not marked.

On i386 we shouldn't really mark reserved areas in the highmem zone(s) =
as
nosave, because they are handled in a different way.

> > Second, it is not true that the region in question is at 0xee00 on =
x86_64.
> > At least on my box it's above the end of RAM.
> >
>=20
> On my box the problem region starts at ee800 :) But you are right, it=
 does not
> belong here.
>=20
> > I think the x86_64 version is correct too.
> >
>=20
> I do not say it is not. I just say that it does something I cannot ve=
rify so I
> better avoid it (i.e. I better change existing behaviour as little as
> possible).

OK

Can you please test your patch with the loop in e820_mark_nosave_region=
s()
restricted to the zones below highmem?

Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
