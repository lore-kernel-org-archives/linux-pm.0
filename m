From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 14:20:49 +0100
Message-ID: <20161105132049.GC10310@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478301649.7947.3.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-11-04 23:20:53, Pandruvada, Srinivas wrote:
> On Fri, 2016-11-04 at 23:16 +0100, Pavel Machek wrote:
> > Hi!
> >=20
>=20
> [...]
>=20
> > So we seem to have thermal or ACPI regression in v4.9-rc3.
> >=20
> It is possible. Can you add either add printk
> in=A0acpi_processor_ppc_has_changed() or use ftrace and see do you get to
> these functions
>=20
> acpi_processor_ppc_init()
> acpi_processor_ppc_has_changed()
> acpi_processor_ppc_notifier()
>=20
> ?

Ok, can do, let me recompile and reboot.

> When temperature limit is reached=A0acpi_processor_ppc_notifier() should
> be called.

No, that's not correct for ACPI passive trip points, is it? If I
recall correctly, those should be monitored even when temperature is
below them so that it does not reach them...?

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgd3LEACgkQMOfwapXb+vIQhgCfWsJumT+4zEoAZpcdI7bIEdwA
PsQAoJZu81tRhyIYKl5AINajKtZCuiAK
=bOP1
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
