From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Mon, 20 Mar 2017 22:14:46 +0100
Message-ID: <20170320211445.fuvjj25ezons2yjn@earth>
References: <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
 <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
 <12321f48-def6-33cb-1df5-853ecc8f1061@redhat.com>
 <20170320052715.hrgaxsxwdrv7ynbu@earth>
 <6de63319-f30f-cae7-6d7a-0df2edd12859@redhat.com>
 <5e7becad-44e4-8cc8-aabb-cc678b03098b@redhat.com>
 <CAKvHMgTLcgtPCbaTAAbEL+deQpnF-mhszBvQW57jH5AXt5o3iQ@mail.gmail.com>
 <f1d03393-ff94-aef8-b999-9d4438a0c7b3@redhat.com>
 <CAKvHMgScLg4JjQ4sBLetrMCx256dX8HGzq=rWG2KbL-p7NF65Q@mail.gmail.com>
 <325f96e0-e828-1c6f-16cf-770f58f2f8ab@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2by5ul7fxir5fvfo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755268AbdCTVOy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 17:14:54 -0400
Content-Disposition: inline
In-Reply-To: <325f96e0-e828-1c6f-16cf-770f58f2f8ab@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Breck <liam@networkimprov.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--2by5ul7fxir5fvfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 08:22:55PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 20-03-17 19:19, Liam Breck wrote:
> > On Mon, Mar 20, 2017 at 11:01 AM, Hans de Goede <hdegoede@redhat.com> w=
rote:
> > > Hi,
> > >=20
> > >=20
> > > On 20-03-17 18:51, Liam Breck wrote:
> > > >=20
> > > > On Mon, Mar 20, 2017 at 10:04 AM, Hans de Goede <hdegoede@redhat.co=
m>
> > > > wrote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > >=20
> > > > > On 20-03-17 14:54, Hans de Goede wrote:
> > > > > >=20
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > On 20-03-17 06:27, Sebastian Reichel wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On Sun, Mar 19, 2017 at 10:42:00AM +0100, Hans de Goede wrote:
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > <snip>
> > > > > >=20
> > > > > > > > We want one driver which is solidly in control of the charg=
er
> > > > > > > > since getting that wrong is quite bad and we want to extend
> > > > > > > > the information it is exporting to userspace in the form of
> > > > > > > > power_supply properties with some extra info.
> > > > > > > >=20
> > > > > > > > So taking that as a starting point and generalizing that,
> > > > > > > > I think that if we want we can make something more generic =
then
> > > > > > > > my original patch for this. My idea is to introduce somethi=
ng
> > > > > > > > called a power_supply_properties_provider, with an API
> > > > > > > > like this:
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Thanks for thinking about this. From what I can see it should
> > > > > > > be enough to just avoid exposing a battery device at all in
> > > > > > > the charger driver, though. It does not really provide useful
> > > > > > > information anyways.
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > Interesting suggestion, 2 remarks / questions:
> > > > > >=20
> > > > > > 1) Given that we do not want to break existing setups
> > > > > > which may depend on the existing battery interface on the bq241=
90
> > > > > > driver and add a flag to not register it, or are you suggesting
> > > > > > to simply remove it all together? Removing it all together would
> > > > > > be better from a maintenance pov. Liam, you indicated that you
> > > > > > are the main user of the bq24190 driver currently, do you need
> > > > > > the battery power_supply interface for your use case ?
> > > > > >=20
> > > > > > 2) Not using the battery interface of the bq24190 driver at all
> > > > > > means that the fuelgauge driver needs to grow some extra
> > > > > > properties, specifically it will need to start reporting status,
> > > > > > something which the bq24190 driver really has a better idea
> > > > > > of the the fuel gauge.
> > > >=20
> > > >=20
> > > > Our userspace looks at bq24190-battery & -charger. If your userspace
> > > > can work with /sys/class/power_supply/whisky_cove-battery/* can't y=
ou
> > > > leave .bq24190-battery as is?
> > >=20
> > >=20
> > > No, my userspace is a generic distro which uses upower, which as I
> > > explained before will look at *all* battery type power_supply devices
> > > and will consider each of them being a separate battery. There *must*
> > > be only one battery type power_supply per physical battery, that is
> > > simply how the userspace ABI works.
> > >=20
> > > > bq24190-battery's properties could move to -charger, tho health &
> > > > online would have to change name, replace same in -charger, or be
> > > > dropped.
> > >=20
> > >=20
> > > That is one option, I can also simply make the registration dependent
> > > on a device-property, then you do not need to change your userspace.
> > >=20
> > > In that case I would prefer for the behavior to be to not register
> > > the battery power_supply device unless the boolean device(tree)-prope=
rty
> > > named "linux,register-battery-power-supply" is present. But if you
> > > need things to keep working the same with older dtb files which
> > > will not contain that property, we can also go for:
> > > "linux,disable-battery-power-supply"
> >=20
> > Just if (!pdata->x) register(battery). Eventually I'll have to move
> > those properties to charger, as we added a fuel gauge after charger
> > driver was written.
>=20
> Sebastian want to kill the pdata and move to device-properties as
> both you (IIRC) and Andy already suggested. So that is the plan now.
>=20
> So we will end up with something like:
>=20
> 	if (!device_property_read_bool(dev, "disable-battery-power-supply")) {
> 		register(battery)...
> 	}
>=20
> > Or change bq24190_battery_desc.type to not be _BATTERY?
>=20
> That sounds like an ugly hack to me, the above will work fine, if you
> want to you can move the bits you need to the charger power_supply
> (as time permits) and then when they are all gone we can kill of the
> battery one.

=46rom my understanding Liam's platform uses bq27xxx based fuel-gauge,
so it also should not provide the bq24190-battery (since that would
result in two battery devices being exposed for the same battery).
So removing it seems to be the way to go.

Most of the properties should also be available from the fuel-gauge.
I see two exceptions:

 * The battery disable FET
 * The battery temperature monitoring

If that is needed by any of your platforms, something like the
API proposed by Hans to get properties from bq24190 into the
fuel-gauge driver should be introduced. According to my
understanding bq24190 checks temperature itself, so both
features seem to be optional.

-- Sebastian

--2by5ul7fxir5fvfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljQRkMACgkQ2O7X88g7
+prLDg//TgiNZEYFYvQoFlyaK9bR/4byiFbLdni1oEp6Ql22IaxpGY1wizIaK6yk
7Yc/WsvIPJg8S+h/Y6L1QSQzCq94oU3HHfvY1ZVzweKNTjayzVowB9es8ocBVoda
rjW5QoEI7azoFm5a3Bu+JLOA/8kVxHuYoX+JJdYTKtOtLEOrw/z7A7XEh88zngye
Nicn3nzfnPnzggm7Ocfl/3Ss5W3Mt1hiKnYGlUgiY+5999GKGYtQ+MzMswCh4F7R
yXeyWPiQmeYcQjKzC6evIb7HGE4s0x31Qvhuw8kpncalGXLFAxhodGrQ6qhrTVCK
cd2DDe8yFFeOFNKFuLDPOCYiCSSpi0NUty4tE1lOavfZ4831FT9b6bJY3Jx/Bikt
rYi9FoJ1fBqhdeuJSD3UQRZNeEHmCSBXxLiqrV5Ckv0eBiIRdNHg+OUrM62x9y6W
v3qShFjXk0vy4bzyMcAnGbpWHvWKjdzbOtbGEa/0j4b5/BwU8AIfQvY8Rusbq/RB
QP7DxEV5f+RTt1LJlSNvQyd4XWOJosYQPHqHT2kzBTU3QRrIgeLItpJVmkcTqlZj
F4dJO5DqG5A4bM7IVIFzIVTeN2nmaTEDFtVLtjWjwgtCZ3ajcc5KQNoz5rAGA19/
+3mHEAkK0vZ1vp92gZQ4JAmHXnpVTxzerNhEZyyQRbQ9hfdF73U=
=HTBt
-----END PGP SIGNATURE-----

--2by5ul7fxir5fvfo--
