From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 11:54:51 +0800
Message-ID: <1338436491.1472.223.camel@rui.sh.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
	 <20120530125035.GA17379@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120530125035.GA17379@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amit.kachhap@linaro.org
List-Id: linux-pm@vger.kernel.org

On =E4=B8=89, 2012-05-30 at 13:50 +0100, Matthew Garrett wrote:
> On Wed, May 30, 2012 at 04:49:02PM +0800, Zhang Rui wrote:
>=20
> > G1. supporting multiple cooling states for active cooling devices.
>=20
> Sounds fine.
>=20
Great!

> > G2. introduce cooling states range for a certain trip point
>=20
> Again, no problem here.
>=20
Again, great!

> > G3. kernel thermal passive cooling algorithm
>=20
> >     Currently, tc1 and tc2 are hard requirements for kernel passive
> >     cooling. But non-ACPI platforms do not have this information
> >     (please correct me if I'm wrong).
> >     Say, for the patches here
> >     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
> >     They just want to slow down the processor when current temperat=
ure
> >     is higher than the trip point and speed up the processor when t=
he
> >     temperature is lower than the trip point.
>=20
> Just slowing the CPU down above a certain temperature is a pretty awf=
ul=20
> approach to passive cooling. You want to maximise performance while=20
> staying within your thermal envelope, so you need a more advanced=20
> approach.

Agreed.

> The existing algorithm provides a generic mechanism for=20
> balancing performance and thermal output, with the only requirement=20
> being that the platform provide constants that represent the heating =
and=20
> cooling properties of the system.
>=20
I'm not sure if this could work on their platforms. So I'm just looking
for an easier way to handle this, i.e. make generic thermal layer
simple, and provide the flexibility for platform drivers to do their ow=
n
tricks.

> I don't fundamentally object to adding support for platform-specific=20
> passive formulae, but I'd like an explanation for how they're better=20
> than the existing one.
>=20
Hmmm, I'd like to see if it is possible for them to make use of the
current passive cooling implementation.. if no...

how about this?

we can provide an API for the current algorithm in thermal_sys.c

thermal_passive_get_trend(int tc1, int tc2)
{
}
EXPORT_SYMBOL(...);

and in platform driver, they can choose to use this default algorithm i=
f
they are able to.

=2Eget_trend()
{
   return thermal_passive_get_trend(platform_tc1, platform_tc2);
}

> > G4. Multiple passive trip points
>=20
> It would be good to have an explanation of the use case here. If it's=
=20
> acceptable for the device to be at the lower passive trip point, why =
are=20
> we slowing it down at all?
>=20
acceptable does not equal comfortable?
Say, I'd like to use the computer at 30C skin temperature.
I'm okay with the temperature at 50C, but it would be nice if it can be
lower, even if the system would be slower, but not too slow (T-state).
If the temperature is higher than 60, it is not usable for me, I'll wai=
t
for a while, the system can do everything they want do cool the system
down (but hibernate/shutdown would be not a good idea at this time
because it is hot enough for some hardware damage).

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
