From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] power:bq27x00: don't fill system log by missing
 battery
Date: Sat, 5 Dec 2015 01:38:34 +0100
Message-ID: <20151205003834.GB22936@earth>
References: <cover.1444243358.git.hns@goldelico.com>
 <73cb8d96728805597ecb50e7e7b51bf6272b6d61.1444243358.git.hns@goldelico.com>
 <201510080023.14795@pali>
 <871td68f9p.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34214 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886AbbLEAij (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:38:39 -0500
Content-Disposition: inline
In-Reply-To: <871td68f9p.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2015 at 09:50:26AM +1100, Neil Brown wrote:
> Pali Roh=E1r <pali.rohar@gmail.com> writes:
>=20
> > On Wednesday 07 October 2015 20:42:38 H. Nikolaus Schaller wrote:
> >> From: NeilBrown <neilb@suse.de>
> >>=20
> >> Print message that battery is not calibrated only during debug build
> >> but not during normal operation.
> >>=20
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >>  drivers/power/bq27x00_battery.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/power/bq27x00_battery.c
> >> b/drivers/power/bq27x00_battery.c index 8287261f..709d1e4 100644
> >> --- a/drivers/power/bq27x00_battery.c
> >> +++ b/drivers/power/bq27x00_battery.c
> >> @@ -491,7 +491,7 @@ static void bq27x00_update(struct
> >> bq27x00_device_info *di) if (cache.flags >=3D 0) {
> >>  		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
> >>  				&& (cache.flags & BQ27000_FLAG_CI)) {
> >> -			dev_info(di->dev, "battery is not calibrated! ignoring=20
> > capacity
> >> values\n"); +			dev_dbg(di->dev, "battery is not calibrated!
> >> ignoring capacity values\n"); cache.capacity =3D -ENODATA;
> >>  			cache.energy =3D -ENODATA;
> >>  			cache.time_to_empty =3D -ENODATA;
> >
> > Hi! I think that better approach would be to use WARN_ONCE or similar=
=20
> > macro. Still use INFO level, just warn about this problem only once...
>=20
> Why do you need any warning?
> The status of whether the battery is calibrated is trivially determined
> From the sysfs attributes (several of which will return ENODATA).
> So if some app is being used to report battery status, then it can
> easily report "not calibrated", and if no such app is being used, who
> will care to know?
>=20
> I'm not exactly against a once-only warning (though not with WARN_ONCE,
> maybe dev_info_once()) but I don't think that it brings any value at
> all.

There is no use in having it printed every time, even for debugging.
It just adds lots of spam to the log/console. Anyone debugging the
driver will know, that the battery requires calibration and returns
-ENODATA in uncalibrated mode.

Users not knowing the bq27xxx chips might wonder why the driver
returns -ENODATA, though. For these users a single print
in the log is probably useful. Thus I will take this patch
with dev_info_once() and the following tags:

=46rom: NeilBrown <neilb@suse.de>
Suggested-By: H. Nikolaus Schaller <hns@goldelico.com>
Suggested-By: Pali Roh=E1r <pali.rohar@gmail.com>

-- Sebastian

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjIHAAoJENju1/PIO/qagOoP/2i5h8R+esc7C/pz3XQqemVl
MFp1UKke+01u8/f0wctuVKAJ6haKlYXhTxjWChgRIDlKmFJV0qCZCdeD3FHTByl5
GGaELQsV7W23heTckJhF5MdbzA1ErwVVtW33gay9vUaY0aHkgZG/ZNTlAtsYA/pK
a85zjZ1/3W5bI4DwUqIt+IVrWTX8M53qAJvtu9Au50ESvg0K8Q3w6lgD+YUlzQFa
mHoD301j4F7mDBnXax4imcjoyNaib/qQcJ5SM/AQq2IyOXtnzw3I1t/zr/YbE9LR
X0KiaiEfMVh2WQKIZrKkagpogxLyd3yDYo3O2Qkt73iqD/6IROVb/7Xlmgi43quR
c0PWoFUrBGNci8jRF/kSNU1TN4CjwVyW4lH4ECArx5BwCYewfW09CUJRU3pVqxc+
2VKCacmT7UunUyYI8uRdXhEmuv3IDDxT9JlTjOPm0btgvq8E4UVjgq9Tzq59XE8s
oXIIz25MO2Z1zVX4cOxRJfmUhqwtl1AvCcJdZRoQq0ueg3UwcoRCfP58lKDHiacV
XEV3UUEx+Y8h59yHUc/9cDrt+NibhZ7gjQFV21P3rpav1T14u57sdaJDDb7o8YTX
y8AO19DUfbPu6VuEBLShB2httrwzkuoX3jxN22h+J38NeJoEWT++8ZZtxeLPZ6Ba
Qy9B69/PSZzEQFAiZKM2
=diz/
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
