From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 20:36:17 +0100
Message-ID: <20161105193617.GA8705@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <1478293976.1268.15.camel@intel.com>
 <20161105084248.GA664@amd>
 <20161105174612.GA17290@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161105174612.GA17290@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2016-11-05 15:46:12, Henrique de Moraes Holschuh wrote:
> On Sat, 05 Nov 2016, Pavel Machek wrote:
> > Hmm, thanks for the pointer. But it seems like I'll have to build my
> > own, as /proc/acpi/ibm does not follow the usual infrastructure...
>=20
> /proc/acpi/ibm has been deprecated for years.  99% of the functionality
> is available through more modern, standard interfaces.

Right, I see sensors can do it these days. Would it be good to expose
them as /sys/class/thermal/thermal_zone*, too?

Is it known what various fields in /proc/acpi/ibm/thermal measure?
Basically... 100C is okay for semiconductors, but I'd prefer not to
kill the hard drive....

> thinkpad-acpi is supposed to export standard hwmon temperature sensors
> as well.  Try them instead, please.

Heh, I just finished python to work with /proc/acpi/ibm. Oh well.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgeNLEACgkQMOfwapXb+vJnGQCghSkRrVsBIZVF9WbVm33dDNOu
BIYAoKGczciL22BmvI9XJARLJXaEnA0l
=DkYd
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
