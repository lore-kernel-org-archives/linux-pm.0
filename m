From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [regression,bisected] restore of disks after suspend-to-disk
 broken in 3.9.x
Date: Fri, 21 Jun 2013 15:53:59 +0800
Message-ID: <1371801239.2170.2.camel@rzhang1-mobl4>
References: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com>
	 <1369631226.2159.5.camel@rzhang1-mobl4>
	 <CAPm-kmu4WmAKX4N5GTsG-J+oq95pLxB9=iLMf2dyK-p6RbwFXQ@mail.gmail.com>
	 <1369878386.3368.16.camel@rzhang1-mobl4>
	 <CAPm-kmtwxgDO24UmtmZ44-P2W-80tK11k1aE8M4Ty3t3LKu14Q@mail.gmail.com>
	 <1369911036.2636.5.camel@rzhang1-mobl4>
	 <CAPm-kmtdxjf1J0GUSMo+x1XY0BX7hFBsDQCjuAH=f65TfGHRbQ@mail.gmail.com>
	 <CAPm-kmupuP-MKU5xQuReEagNz1EFzWyzjs1vPhKQYOkxg96_uA@mail.gmail.com>
	 <744357E9AAD1214791ACBA4B0B9092630111E53C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092630111E53C@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Giacomo Perale <giacomo.perale@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-06-05 at 13:23 +0000, Zhang, Rui wrote:
>=20
> > -----Original Message-----
> > From: Giacomo Perale [mailto:giacomo.perale@gmail.com]
> > Sent: Wednesday, June 05, 2013 5:09 PM
> > To: Zhang, Rui
> > Cc: linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org; Rafael J.
> > Wysocki
> > Subject: Re: [regression,bisected] restore of disks after suspend-t=
o-
> > disk broken in 3.9.x
> > Importance: High
> >=20
> > 2013/5/30 Giacomo Perale <giacomo.perale@gmail.com>:
> > > 2013/5/30 Zhang Rui <rui.zhang@intel.com>:
> > >> On Thu, 2013-05-30 at 10:04 +0200, Giacomo Perale wrote:
> > >>> 2013/5/30 Zhang Rui <rui.zhang@intel.com>:
> > >>> > On Mon, 2013-05-27 at 22:07 +0200, Giacomo Perale wrote:
> > >>> >> 2013/5/27 Zhang Rui <rui.zhang@intel.com>:
> > >>> >> > On Sun, 2013-05-26 at 15:51 +0200, Giacomo Perale wrote:
> > >>> >> >> Hello,
> > >>> >> >>
> > >>> >> >> after upgrading from 3.8.7 to 3.9.x I noticed some slight=
ly
> > >>> >> >> longer delays when resuming from suspend-to-disk and a fe=
w
> > new
> > >>> >> >> error messages in the logs:
> > >>> >> >>
> > >>> >> >>
> > >>> >> >> Not having connected the issue with the previous error
> > >>> >> >> messages I initially blamed the disk and replaced it with=
 a
> > >>> >> >> new one thinking it was broken, but the problem persisted=
 so
> > I
> > >>> >> >> started a bisection run that pointed to this commit:
> > >>> >> >>
> > >>> >> >>
> > >>> >> > I do not see how this would affect the sata hibernation/re=
sume.
> > >>> >> > but anyway, would you please try the four patches in comme=
nt
> > >>> >> > #10, #11,
> > >>> >> > #12 and #13 in
> > >>> >> > https://bugzilla.kernel.org/show_bug.cgi?id=3D58301
> > >>> >> > and check if they help?
> > >>> >> >
> > >>> >> > thanks,
> > >>> >> > rui
> > >>> >> >
> > >>> >>
> > >>> >> No luck, with git head and those four patches hibernation is
> > >>> >> completely broken, the system doesn't even shut down, it jus=
t
> > >>> >> loses the disks (I'm attaching what I could get from /proc/k=
msg
> > >>> >> to this email).
> > >>> >>
> > >>> > then can you please try the patch at
> > >>> > https://patchwork.kernel.org/patch/2633071/
> > >>> > on top of the four patches and see if it helps?
> > >>> >
> > >>> > thanks,
> > >>> > rui
> > >>> >
> > >>>
> > >>> Do you mean without Rafael's patch?
> > >>>
> > >> right.
> > >>
> > >> thanks,
> > >> rui
> > >
> > > [cc-ing list]
> > >
> > > No difference, system doesn't shut down and disks become unavaila=
ble.
> > >
> > > Giacomo
> >=20
> > Any news about this?
> >=20
>=20
> I'm proposing a new patch set based on the problem found by Rafael's =
patch.
> And I'll send them out in a day or two, please wait for the update. :=
)
>=20
sorry for the late response.

can you please check if the patch series at=20
https://patchwork.kernel.org/patch/2733361/
https://patchwork.kernel.org/patch/2733371/
https://patchwork.kernel.org/patch/2733391/
https://patchwork.kernel.org/patch/2733401/
https://patchwork.kernel.org/patch/2733411/
https://patchwork.kernel.org/patch/2733421/
helps or not?

thanks,
rui

> Thanks,
> rui
>=20
>=20
> > Thanks.
> >=20
> > Giacomo
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BDh=EF=BF=BD=EF=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=
=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
i=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=
=BF=BD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A2=1Bf


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
