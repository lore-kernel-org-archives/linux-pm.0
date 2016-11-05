From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 13:22:54 +0100
Message-ID: <20161105122254.GA10310@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104221600.GA7007@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Under v4.8-rc, behaviour is different: bios_limit goes to 1GHz there
> when temperature is around 84C at the thermal zone. That keeps
> ibm/thermal temperatures under 90C, and no "thermal emergency"
> messages in syslog.

Argh. So v4.9 thermal management does not work.

v4.8 passive thermal management works _too well_, keeping fan at cca
3200 rpm, far below 3700 rpm it can reach. CPU is getting throttled,
and fan is not even running at full speed.

I can manually control the fan with thinkpad_acpi.fan_control=3D1... I
guess I can write some scripts?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgdzx4ACgkQMOfwapXb+vLH7gCfT1gCZMR0DDW+pg3HFouXk0Iy
NxwAn0p9OIs0d075zrirx0w6baKy2/vT
=miul
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
