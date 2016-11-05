From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 20:56:19 +0100
Message-ID: <20161105195619.GB8705@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
 <20161105133719.GA3933@amd>
 <20161105180458.GB17290@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43755 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756462AbcKET4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2016 15:56:23 -0400
Content-Disposition: inline
In-Reply-To: <20161105180458.GB17290@khazad-dum.debian.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2016-11-05 16:04:58, Henrique de Moraes Holschuh wrote:
> On Sat, 05 Nov 2016, Pavel Machek wrote:
> > [  825.759661] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports somet=
hing is extremely hot!
> > [  825.761935] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 =
N/A 33 N/A 47 50 N/A N/A N/A N/A N/A N/A
>=20
> Oh boy, that must be the second time in a decade that I see that
> codepath triggering.  It is the second-level alert that the ThinkPad is
> about to catch fire.
>=20
> It should have logged a "is too hot!" first-level alert earlier, but
> this depends on the EC and not the driver.  Maybe the temperature raised
> too fast.

I don't think I'm seeing the "is too hot" messages. Actually.. even
the "THERMAL EMERGENCY" messages seem to have too low severity, so
they are hidden in syslogs -- they don't go to all the consoles.

> In Windows, the system would attempt to hibernate or shutdown.  I would
> be quite happy to have thinkpad-acpi trigger such behavior as well,
> patches (or guidance) are welcome ;-)

Sorry, just guidance for now:

+#include <linux/reboot.h>
+               orderly_poweroff(true);

[can be called from weird contexts, afaict].=20

> Anyway, if that temperature goes about 1~2=B0C higher, the EC should cut
> power to your motherboard.  Apparently, the built-in thermal protection
> clock modulation on the Intel processor is somehow saving your box from
> that forced power-off.

Actually, the machine _will_ shut down some time after that. It seems
that one of acpi trip points jumps to 128C which forces shutdown.

Thanks and best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgeOWMACgkQMOfwapXb+vIFugCfejXp87Z0QwaNDI9Di+JwDobF
EvsAnip3BimxnbG5SHyC9Yds5pmnYQa4
=4Aua
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
