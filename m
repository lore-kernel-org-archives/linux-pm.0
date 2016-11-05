From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 14:53:13 +0100
Message-ID: <20161105135313.GB3933@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
 <20161105132049.GC10310@amd>
 <1478352782.19557.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478352782.19557.7.camel@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, can do, let me recompile and reboot.
> >=20
> > >=20
> > > When temperature limit is reached=A0acpi_processor_ppc_notifier()
> > > should
> > > be called.
> >=20
> > No, that's not correct for ACPI passive trip points, is it? If I
> > recall correctly, those should be monitored even when temperature is
> > below them so that it does not reach them...?
> No if BIOS is sending PPC, it will be called. You can try first in 4.8.
>=20
> Also try
>=20
> Don't run workload, just on an idle system.
>=20
> # echo 1 > /sys/class/thermal/cooling_device2/cur_state
> monitor the scaling_max_freq, it should reduce
>=20
> # echo 2 > /sys/class/thermal/cooling_device2/cur_state
> monitor the scaling_max_freq, it should reduce

Yes, this seems to work. scaling_max goes to 1.5, then 1.1. Also under
load, scaling_max_freq changes. But at that point, we are already
around 98C... and bios_limit stays the same all the time in v4.9.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgd5EkACgkQMOfwapXb+vL3EwCgjFc2H7sAenxAmTiZDF64A5di
0ygAoK+O4/6YjGTwGl2jr6c9aB1IPRhU
=JLfM
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
