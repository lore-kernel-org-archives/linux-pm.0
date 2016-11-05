From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 16:34:18 +0100
Message-ID: <20161105153418.GA4566@amd>
References: <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
 <20161105132049.GC10310@amd>
 <1478352782.19557.7.camel@intel.com>
 <20161105135313.GB3933@amd>
 <20161105140434.GA3755@amd>
 <1478355545.22182.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478355545.22182.1.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Yes, this seems to work. scaling_max goes to 1.5, then 1.1. Also
> > > under
> > > load, scaling_max_freq changes. But at that point, we are already
> > > around 98C... and bios_limit stays the same all the time in v4.9.
> >=20
> > ...while in v4.8-rc1, bios limit goes to 1.0 GHz at 90C, and
> > temperature just doesn't go above that.
> >=20
> > Does it make sense to try with v4.8-final?
> I sent some suggestion to try in previous email to add more prints and
> enable debug in acpi-cpufreq. Let's try that first. We need to fix
> anyway even if 4.8-final has this issue.

Ok, you should have results in your mailbox now. If you want me to do
some more testing, let me know.

Thanks,
 								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgd+/oACgkQMOfwapXb+vIZlwCdEYGwvUQVxVgzV3Tov1QFLIlE
sroAn156vaVz2xWCFGo0tBMqAbrXA5Hq
=jM+o
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
