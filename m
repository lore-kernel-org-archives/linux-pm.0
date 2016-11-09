From: Pavel Machek <pavel@ucw.cz>
Subject: thinkpad x60, T40p: overheat with v4.9-rc4 (was Re: v4.8-rc1:
 thinkpad x60: running at low frequency even during kernel build)
Date: Wed, 9 Nov 2016 12:34:06 +0100
Message-ID: <20161109113406.GA1793@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
 <20161105133719.GA3933@amd>
 <1478354115.19557.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478354115.19557.17.camel@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, regressions@leemhuis.info
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks to Srinivas, bug tracking moved to bugzilla at
https://bugzilla.kernel.org/show_bug.cgi?id=3D187311 , it is regression
=66rom v4.8-final.

Easiest way to observe it is that cpufreq/bios_limit does not change
in v4.9, where it goes lower with high temperature on v4.8.

Best regards,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgjCa4ACgkQMOfwapXb+vIdIACgmnJ0ZP8yhI4oAi7H8GW1RejX
U7MAn2FyMjVJH2KQiwRqTKvmu4UmuAOx
=EZsJ
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
