From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Fri, 4 Nov 2016 21:44:39 +0100
Message-ID: <20161104204439.GA2581@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478268311.26953.17.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Let me try v4.9-rc2... that works ok (cpus at the high frequency
> > during the kernel build). Unfortunately that sends my cpus to 99C
> > temperature range (and eventually forces emergency shutdown).
>=20
> This we have to debug. Do you see same line like=A0
> "
> /sys/devices/system/cpu/cpu0/cpufreq/bios_limit:1000000
> "
> If not we need
> to find out why.

I'd prefer mails over bugzilla for now...

4.9-rc2 has bios_limit:

pavel@duo:~$ cat /sys/devices/system/cpu/cpu0/cpufreq/bios_limit
1833000

and it has thermal zones:

/sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp 127000
/sys/devices/virtual/thermal/thermal_zone0/trip_point_0_type critical
/sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp 97000
/sys/devices/virtual/thermal/thermal_zone1/trip_point_0_type critical
/sys/devices/virtual/thermal/thermal_zone1/trip_point_1_temp 92500
/sys/devices/virtual/thermal/thermal_zone1/trip_point_1_type passive

=2E.so it should slow down CPU at 92C.

So lets push the temperature up a bit...

sudo watch cat /proc/acpi/ibm/thermal
/sys/devices/system/cpu/cpu0/cpufreq/bios_limit
/sys/devices/virtual/thermal/thermal_zone1/temp  /sys/devices/system/cpu/cp=
u0/cpufreq/cpuinfo_cur_freq

temperatures:   98 49 -128 85 28 -128 28 -128 49 58 -128 -128 -128
-128 -128 -128
1833000
95000
1833000

Hmm. bios_limit does not seem to change, even when the temperature is
clearly above the trip point. (It is also interestng that acpi/ibm
reports bigger temperatures than
/sys/devices/virtual/thermal/thermal_zone1/temp . I have seen 103C there.)



									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgc8zcACgkQMOfwapXb+vIiBACfR2NCMD3lw8jwCCIxZGIhKdRf
22cAmwbcf1BggSaejszcLv1pFJTYaxLm
=F4Fy
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
