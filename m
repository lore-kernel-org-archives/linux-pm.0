From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 0/12] generic thermal layer enhancement
Date: Tue, 12 Jun 2012 11:01:12 +0800
Message-ID: <1339470072.1492.211.camel@rui.sh.intel.com>
References: <1339384751.1492.153.camel@rui.sh.intel.com>
	 <20120611094940.GA3649@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120611094940.GA3649@besouro>
Sender: linux-acpi-owner@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Amit Kachhap <amit.kachhap@linaro.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Len, Brown" <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On =E4=B8=80, 2012-06-11 at 12:49 +0300, Eduardo Valentin wrote:
> Hello Rui,
>=20
> On Mon, Jun 11, 2012 at 11:19:11AM +0800, Zhang Rui wrote:
> > Hi, all,
> >=20
> > this patch set is made to enhance the current generic thermal layer=
=2E
> > It fixes several gaps discussed in
> > http://marc.info/?l=3Dlinux-acpi&m=3D133836783425764&w=3D2
> > and introduces a simple arbitrator to fix the "one cooling devices
> > referenced by multiple trip points in multiple thermal zones" probl=
em.
>=20
> Thanks for taking this further. With code it is much better to progre=
ss.
>=20
> BTW, are you keeping this series somewhere in a branch?
>=20
Not yet.
But I'm thinking of create one. :)

> > =20
> > The whole idea is
> > 1) make sure we have multiple cooling states for both active coolin=
g and
> >    passive cooling devices. (patch 1,2,3)
>=20
> Nice!
>=20
> > 2) remove passive specific requirement, aka, tc1/tc2, and
> >    introduce .get_trend() instead, for both active and passive cool=
ing
> >    algorithm. (patch 4,5)
>=20
> Cool. The .get_trend() might be also helpful in case there are sensor=
s
> that provide trending computation, or at least, some history buffer.
>=20
> So, I definitely agree with this approach.
>=20
> > 3) introduce new function thermal_zone_trip_update(), this contains=
 the
> >    code for the general cooling algorithm. (patch 6)
>=20
> Ok.
>=20
> > 4) rename some thermal structures. Use thermal_instance instead of
> >    thermal_cooling_device_instance, as this structure is used to
> >    describe the behavior of a certain cooling device for a certain =
trip
> >    point in a certain thermal zone.
> >    thermal_zone_device has a list of all the thermal instances in t=
his
> >    thermal zone so that it can update them when the temperature cha=
nges.
> >    thermal_cooling_device has a list of all the thermal instances f=
or
> >    this cooling device so that it can make decision which cooling s=
tate
> >    should be in when the temperature changes. (patch 7,8,9,10)
>=20
> Ok.
>=20
> > 5) introduce a simple arbitrator. (patch 11)
> >    When temperature changes, we update a thermal zone in two stages=
,
> >    a) thermal_zone_trip_point() is the general cooling algorithm to
> >       update the thermal instances in the thermal zone device
> >    b) thermal_zone_do_update() is the arbitrator for the cooling de=
vice
> >       to choose the deepest cooling state required to enter.
>=20
> The arbitrator is good starting point. I will have a deeper look on i=
t.
>=20
> But we may be careful to solve the constraint issue only at thermal c=
ode
> level. There might be conflicting constraints coming from PM QoS laye=
r,
> for instance.
>=20
hmmm, do you have a link for the discussions/patches mentioned?

I'll take a look at this. :)

> > 6) unify the code for both passive and active cooling.
>=20
> This is good.
>=20
> >=20
> > TODO, add locking mechanism. I know this is important but as this p=
atch
> > set changes the thermal layer a(lot, I just want to make sure I'm i=
n the
> > right direction before going on.
>=20
> Right. I second you on the incremental approach.
>=20
> >=20
> > BTW, in theory, they should make no change to the behavior of the
> > current generic thermal layer users. But I have just done the build
> > test.
>=20
> OK. I will fetch them and give them a trial on my side, then send bet=
ter review.
>=20
Great. That would be really helpful. Thanks for your interest on this,
Eduardo! :)

-rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
