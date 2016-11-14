From: Pavel Machek <pavel@ucw.cz>
Subject: 6ea8c546f3655 breaks thermal management on thinkpad x60 and t40p
Date: Mon, 14 Nov 2016 20:03:43 +0100
Message-ID: <20161114190343.GB20770@amd>
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
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478354115.19557.17.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Robert.Moore@intel.com, acpi_power-processor@kernel-bugs.osdl.org, rankincj@yahoo.com, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, lv.zheng@intel.com, regressions@leemhuis.info
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Bisection was not fun, but I've got the result:

# first bad commit: [6ea8c546f3655a81f82672f24b66dad6095bdd07] ACPICA:
FADT support cleanup

I've reverted the patch on top of 4.9-rc4, and thermal management now works.

More details are in https://bugzilla.kernel.org/show_bug.cgi?id=3D187311

As this breaks thermal management on both thinkpad X60 and T40p, can
I ask for a revert?

If you have other ideas, I can test them, but as this is just a
cleanup, it can wait for 4.10...

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgqCo8ACgkQMOfwapXb+vI0zgCfVeV89QHre8vCQrrkbxwj0s96
18AAnAwYa9wduDaDgYiYzTuTLWKkS/cs
=nYzO
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
