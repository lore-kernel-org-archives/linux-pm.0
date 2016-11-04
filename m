From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Fri, 4 Nov 2016 23:16:00 +0100
Message-ID: <20161104221600.GA7007@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104204439.GA2581@amd>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'd prefer mails over bugzilla for now...
>=20
> 4.9-rc2 has bios_limit:
>=20
> pavel@duo:~$ cat /sys/devices/system/cpu/cpu0/cpufreq/bios_limit
> 1833000
>=20
> and it has thermal zones:
>=20
> /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp 127000
> /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_type critical
> /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp 97000
> /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_type critical
> /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_temp 92500
> /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_type passive
>=20
> ..so it should slow down CPU at 92C.
>=20
> So lets push the temperature up a bit...
>=20
> sudo watch cat /proc/acpi/ibm/thermal
> /sys/devices/system/cpu/cpu0/cpufreq/bios_limit
> /sys/devices/virtual/thermal/thermal_zone1/temp  /sys/devices/system/cpu/=
cpu0/cpufreq/cpuinfo_cur_freq
>=20
> temperatures:   98 49 -128 85 28 -128 28 -128 49 58 -128 -128 -128
> -128 -128 -128
> 1833000
> 95000
> 1833000
>=20
> Hmm. bios_limit does not seem to change, even when the temperature is
> clearly above the trip point. (It is also interestng that acpi/ibm
> reports bigger temperatures than
> /sys/devices/virtual/thermal/thermal_zone1/temp . I have seen 103C
> there.)

Under v4.8-rc, behaviour is different: bios_limit goes to 1GHz there
when temperature is around 84C at the thermal zone. That keeps
ibm/thermal temperatures under 90C, and no "thermal emergency"
messages in syslog.

So we seem to have thermal or ACPI regression in v4.9-rc3.

Best regards,
=20
 									Pavel
=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgdCKAACgkQMOfwapXb+vJSmwCgvJccP+cC1TZ/cZQ4jVjkrc4F
9nkAn2Y3+tJziD1CfRCeMF+h6+6RCTTX
=3j6Q
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
