From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 09:42:49 +0100
Message-ID: <20161105084248.GA664@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <1478293976.1268.15.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478293976.1268.15.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 4.9-rc2 has bios_limit:
> >=20
> > pavel@duo:~$ cat /sys/devices/system/cpu/cpu0/cpufreq/bios_limit
> > 1833000
> >=20
> > and it has thermal zones:
> >=20
> > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp 127000
> > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_type critical
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp 97000
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_type critical
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_temp 92500
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_type passive
> >=20
> It will not act if there is no binding information. Do you have more
> files in this folder?
>=20
> grep -r . * in /sys/class/thermal will be helpful.

Yes, I do. Here you go:

pavel@duo:/data/l/linux$ sudo grep -ri . /sys/class/thermal/*
/sys/class/thermal/cooling_device0/cur_state:0
/sys/class/thermal/cooling_device0/power/runtime_active_kids:0
/sys/class/thermal/cooling_device0/power/runtime_suspended_time:0
grep: /sys/class/thermal/cooling_device0/power/autosuspend_delay_ms:
Input/output error
/sys/class/thermal/cooling_device0/power/runtime_enabled:disabled
/sys/class/thermal/cooling_device0/power/runtime_active_time:0
/sys/class/thermal/cooling_device0/power/control:auto
/sys/class/thermal/cooling_device0/power/async:disabled
/sys/class/thermal/cooling_device0/power/runtime_usage:0
/sys/class/thermal/cooling_device0/power/runtime_status:unsupported
/sys/class/thermal/cooling_device0/type:LCD
/sys/class/thermal/cooling_device0/max_state:7
/sys/class/thermal/cooling_device1/cur_state:0
/sys/class/thermal/cooling_device1/power/runtime_active_kids:0
/sys/class/thermal/cooling_device1/power/runtime_suspended_time:0
grep: /sys/class/thermal/cooling_device1/power/autosuspend_delay_ms:
Input/output error
/sys/class/thermal/cooling_device1/power/runtime_enabled:disabled
/sys/class/thermal/cooling_device1/power/runtime_active_time:0
/sys/class/thermal/cooling_device1/power/control:auto
/sys/class/thermal/cooling_device1/power/async:disabled
/sys/class/thermal/cooling_device1/power/runtime_usage:0
/sys/class/thermal/cooling_device1/power/runtime_status:unsupported
/sys/class/thermal/cooling_device1/type:Processor
/sys/class/thermal/cooling_device1/max_state:10
/sys/class/thermal/cooling_device2/cur_state:0
/sys/class/thermal/cooling_device2/power/runtime_active_kids:0
/sys/class/thermal/cooling_device2/power/runtime_suspended_time:0
grep: /sys/class/thermal/cooling_device2/power/autosuspend_delay_ms:
Input/output error
/sys/class/thermal/cooling_device2/power/runtime_enabled:disabled
/sys/class/thermal/cooling_device2/power/runtime_active_time:0
/sys/class/thermal/cooling_device2/power/control:auto
/sys/class/thermal/cooling_device2/power/async:disabled
/sys/class/thermal/cooling_device2/power/runtime_usage:0
/sys/class/thermal/cooling_device2/power/runtime_status:unsupported
/sys/class/thermal/cooling_device2/type:Processor
/sys/class/thermal/cooling_device2/max_state:10
/sys/class/thermal/thermal_zone0/passive:0
/sys/class/thermal/thermal_zone0/available_policies:step_wise
/sys/class/thermal/thermal_zone0/policy:step_wise
/sys/class/thermal/thermal_zone0/mode:enabled
grep: /sys/class/thermal/thermal_zone0/offset: Input/output error
grep: /sys/class/thermal/thermal_zone0/integral_cutoff: Input/output
error
/sys/class/thermal/thermal_zone0/power/runtime_active_kids:0
/sys/class/thermal/thermal_zone0/power/runtime_suspended_time:0
grep: /sys/class/thermal/thermal_zone0/power/autosuspend_delay_ms:
Input/output error
/sys/class/thermal/thermal_zone0/power/runtime_enabled:disabled
/sys/class/thermal/thermal_zone0/power/runtime_active_time:0
/sys/class/thermal/thermal_zone0/power/control:auto
/sys/class/thermal/thermal_zone0/power/async:disabled
/sys/class/thermal/thermal_zone0/power/runtime_usage:0
/sys/class/thermal/thermal_zone0/power/runtime_status:unsupported
grep: /sys/class/thermal/thermal_zone0/k_d: Input/output error
/sys/class/thermal/thermal_zone0/trip_point_0_type:critical
/sys/class/thermal/thermal_zone0/type:acpitz
grep: /sys/class/thermal/thermal_zone0/slope: Input/output error
grep: /sys/class/thermal/thermal_zone0/k_po: Input/output error
grep: /sys/class/thermal/thermal_zone0/k_i: Input/output error
grep: /sys/class/thermal/thermal_zone0/sustainable_power: Input/output
error
/sys/class/thermal/thermal_zone0/trip_point_0_temp:127000
grep: /sys/class/thermal/thermal_zone0/k_pu: Input/output error
/sys/class/thermal/thermal_zone0/temp:58000
/sys/class/thermal/thermal_zone1/available_policies:step_wise
/sys/class/thermal/thermal_zone1/policy:step_wise
/sys/class/thermal/thermal_zone1/mode:enabled
/sys/class/thermal/thermal_zone1/trip_point_1_type:passive
grep: /sys/class/thermal/thermal_zone1/offset: Input/output error
grep: /sys/class/thermal/thermal_zone1/integral_cutoff: Input/output
error
/sys/class/thermal/thermal_zone1/power/runtime_active_kids:0
/sys/class/thermal/thermal_zone1/power/runtime_suspended_time:0
grep: /sys/class/thermal/thermal_zone1/power/autosuspend_delay_ms:
Input/output error
/sys/class/thermal/thermal_zone1/power/runtime_enabled:disabled
/sys/class/thermal/thermal_zone1/power/runtime_active_time:0
/sys/class/thermal/thermal_zone1/power/control:auto
/sys/class/thermal/thermal_zone1/power/async:disabled
/sys/class/thermal/thermal_zone1/power/runtime_usage:0
/sys/class/thermal/thermal_zone1/power/runtime_status:unsupported
grep: /sys/class/thermal/thermal_zone1/k_d: Input/output error
/sys/class/thermal/thermal_zone1/trip_point_0_type:critical
/sys/class/thermal/thermal_zone1/type:acpitz
/sys/class/thermal/thermal_zone1/cdev1_weight:0
/sys/class/thermal/thermal_zone1/trip_point_1_temp:92500
grep: /sys/class/thermal/thermal_zone1/slope: Input/output error
grep: /sys/class/thermal/thermal_zone1/k_po: Input/output error
grep: /sys/class/thermal/thermal_zone1/k_i: Input/output error
/sys/class/thermal/thermal_zone1/cdev0_weight:0
grep: /sys/class/thermal/thermal_zone1/sustainable_power: Input/output
error
/sys/class/thermal/thermal_zone1/trip_point_0_temp:97000
/sys/class/thermal/thermal_zone1/cdev0_trip_point:1
grep: /sys/class/thermal/thermal_zone1/k_pu: Input/output error
/sys/class/thermal/thermal_zone1/temp:80000
/sys/class/thermal/thermal_zone1/cdev1_trip_point:1


> > Hmm. bios_limit does not seem to change, even when the temperature is
> > clearly above the trip point. (It is also interestng that acpi/ibm
> > reports bigger temperatures than
> > /sys/devices/virtual/thermal/thermal_zone1/temp . I have seen 103C
> > there.)
> Probably they are showing package and core temperature or have a
> different sampling interval.
>=20
> Try enabling thermald service in Debian. it has access to more knobs to
> control thermals.

Hmm, thanks for the pointer. But it seems like I'll have to build my
own, as /proc/acpi/ibm does not follow the usual infrastructure...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgdm4gACgkQMOfwapXb+vLomQCgkmhyJYhAfVkoVArVjzSIf24a
vPIAnA9TlK5US87huTKBD/FHZ2Ic75Ph
=17Cl
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
