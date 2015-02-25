From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] bq27x00_battery: register as non-wakeup power supply.
Date: Wed, 25 Feb 2015 21:37:35 +0100
Message-ID: <20150225203734.GE13695@earth>
References: <20150224141732.5c937402@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224141732.5c937402@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-pm@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 24, 2015 at 02:17:32PM +1100, NeilBrown wrote:
> power_supply status changes for the bq27x00 are only noticed via
> polling, not via interrupts.  So they are never the source of
> events which should reliably wake the system from suspend.  So it
> is appropriate to register as a no_ws power source, just like the
> ACPI battery.
>=20
> This removes some debugging messages which occasionally
> confusingly identify bq27x00 as a wakeup source.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

pulled into battery-2.6.git.

-- Sebastian

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jKOAAoJENju1/PIO/qa/48P/jxu5sZz84zA72sjxiVz4ASC
97J9vF0iBmVj5Pdel9egPS2Mg3n2mn+pdov2exUzWTrHr4pFhyyDEwqMZ6H/kgAZ
uhky5Vbs7LUtVxjX1N/llzU0KzFgRFbyzeqA6Kp7yLHhcqFWivd/yv/FBbqW/dsp
ZXIxqR8Qvzmo9STO6r+Df0hkGZlIU2GScEDJtPI/QYeXNQvttywTapN/ktqI8tsR
EMsX6agAUiB9KoP7ImuC5jqnU3ndIdCgV4Y6FfWVDKc08zfUxKlmhhUpnih5MHBm
QDKIZs2sN+0jyjPEXPR/i7q2c9zPhg73IvxsFaMn6OY9GJlv5VqyUTSK8qptj/ud
QZDTcS3s0Tv61r2zCLJznWcXBUNYNktlCa9bAXLY+RIuvGVQSmJmgZrpgNO3Rzan
iTdkB+Gui/D1MegNHKM7/eJur69J6Ar9Qx5qr3F7uBJYgh2RIlPxFWOh1vn94i0s
bqCNq0KzDUHZA3DMQtO8SON8o/+N9MDN8OdwRUM3duvx/GSl+R/hxqXPz9wMg0+m
40xqi/Cchi95JZ9ZzA7n4UMJRCwtPgIDT4h+zeCZVgjVv7qW8FWzo9O2vRJktYZ/
l+boYe12FNv+DBb6dfLdVow17RGWeJmwcOWECM37C0Xuf+f82P7OnOvV5WAKSoYC
81bn7QW/uAJ/M0RFW5Im
=l3Rc
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
