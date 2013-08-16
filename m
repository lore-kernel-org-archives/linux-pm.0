From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: System suspend states and device driver suspend() callback
Date: Sat, 17 Aug 2013 01:53:36 +0200
Message-ID: <35306580.ZCUI1aZasW@vostro.rjw.lan>
References: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com> <17024788.0xFN8jEV59@vostro.rjw.lan> <02318724-F4F7-4D53-9926-872E9417F672@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <02318724-F4F7-4D53-9926-872E9417F672@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Yang-R58472 <r58472@freescale.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 16, 2013 05:13:42 PM Li Yang-R58472 wrote:
>=20
> =E5=9C=A8 2013-8-16=EF=BC=8C=E4=B8=8B=E5=8D=887:22=EF=BC=8C"Rafael J.=
 Wysocki" <rjw@sisk.pl> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> > On Friday, August 16, 2013 04:06:26 PM Li Yang wrote:
> >> Hi Guys,
> >>=20
> >> Is there a standard way for the device drivers to know if the syst=
em
> >> is going to =E2=80=9Cstandby=E2=80=9D mode or =E2=80=9Cmem=E2=80=9D=
 mode when the suspend() callbacks
> >> are called?
> >=20
> > No, there's none.
> >=20
> > What do you need that for?
>=20
> Some chips like ours are putting the on-chip devices into different l=
ow
> power states when entering different system low power states.  When w=
e enter
> system standby, on-chip devices are clock gated.  While entering susp=
end to
> ram, on-chip devices are power gated.  We want to driver to act diffe=
rently
> too when entering different suspend states.

Can you possibly use platform suspend operations to implement that (in =
analogy
with ACPI suspend operations)?

Rafael
