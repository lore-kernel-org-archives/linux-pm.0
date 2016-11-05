From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 14:10:01 +0100
Message-ID: <20161105131001.GB10310@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478344902.2206.8.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35757 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbcKENKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2016 09:10:06 -0400
Content-Disposition: inline
In-Reply-To: <1478344902.2206.8.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So we seem to have thermal or ACPI regression in v4.9-rc3.
> >=20
> To me, there are two problems,
> the first one is a 4.9-rc regression that BIOS limit stops working,
> results in overheating because of high cpu frequency. I agree with
> Srinivas to check acpi_cpufreq driver code for this one.

Ok.

> the second problem is that thermal passive cooling can not prevent the
> system from overheating, when there is no BIOS limit. To debug this,
> you can enable thermal dynamic debug by
> echo 'module thermal_sys +fp' > /sys/kernel/debug/dynamic_debug/control

How is thermal passive cooling different from BIOS limit?

Is this related?

pavel@duo:/sys/class/thermal/cooling_device1$ grep -r . .
=2E/cur_state:0
=2E/power/runtime_active_kids:0
=2E/power/runtime_suspended_time:0
grep: ./power/autosuspend_delay_ms: Input/output error
=2E/power/runtime_enabled:disabled
=2E/power/runtime_active_time:0
=2E/power/control:auto
=2E/power/async:disabled
=2E/power/runtime_usage:0
=2E/power/runtime_status:unsupported
=2E/type:Processor
=2E/max_state:10

Hmm. I seem to get _some_ throttling, even when bios_limit is still
1.8GHz, but I don't understand where it comes from. And yes,
'thermal_sys +fp' seems to produce some output.

[I did not get absolute records in >100C range this time, but still
there are "THERMAL EMERGENCY:" messages from thinkpad_acpi already...]

[14049.733423] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[14049.735412] thinkpad_acpi: temperatures (Celsius): 92 50 N/A 80 32 N/A 3=
2 N/A 50 59 N/A N/A N/A N/A N/A N/A
[14049.736557] update_temperature: thermal thermal_zone1: last_temperature=
=3D92000, current_temperature=3D93000
[14049.736570] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[14049.736577] get_target_state: thermal cooling_device2: cur_state=3D0
[14049.736580] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[14049.736586] get_target_state: thermal cooling_device1: cur_state=3D0
[14049.736589] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[14049.736593] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[14049.736643] thermal_cdev_update: thermal cooling_device2: set to state 1
[14049.736647] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[14049.736666] thermal_cdev_update: thermal cooling_device1: set to state 1
[14049.808333] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[14049.808352] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[14049.808360] get_target_state: thermal cooling_device2: cur_state=3D1
[14049.808364] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[14049.808371] get_target_state: thermal cooling_device1: cur_state=3D1
[14049.808375] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[14049.808381] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[14049.808409] thermal_cdev_update: thermal cooling_device2: set to state 0
[14049.808414] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[14049.808432] thermal_cdev_update: thermal cooling_device1: set to state 0
[14049.888385] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D92000
[14049.888401] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D0
[14049.888408] get_target_state: thermal cooling_device2: cur_state=3D0
[14049.888411] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D0
[14049.888416] get_target_state: thermal cooling_device1: cur_state=3D0
[14049.888419] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D0
[14051.312646] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[14051.314442] thinkpad_acpi: temperatures (Celsius): 93 50 N/A 80 32 N/A 3=
2 N/A 50 59 N/A N/A N/A N/A N/A N/A
[14051.315544] update_temperature: thermal thermal_zone1: last_temperature=
=3D92000, current_temperature=3D94000
[14051.315557] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[14051.315564] get_target_state: thermal cooling_device2: cur_state=3D0
[14051.315567] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[14051.315572] get_target_state: thermal cooling_device1: cur_state=3D0
[14051.315575] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[14051.315579] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[14051.315629] thermal_cdev_update: thermal cooling_device2: set to state 1
[14051.315633] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[14051.315652] thermal_cdev_update: thermal cooling_device1: set to state 1
[14051.334873] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[14051.337322] thinkpad_acpi: temperatures (Celsius): 93 50 N/A 80 32 N/A 3=
2 N/A 50 59 N/A N/A N/A N/A N/A N/A
[14051.338746] update_temperature: thermal thermal_zone1: last_temperature=
=3D94000, current_temperature=3D93000
[14051.338760] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D1
[14051.338767] get_target_state: thermal cooling_device2: cur_state=3D1
[14051.338770] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[14051.338777] get_target_state: thermal cooling_device1: cur_state=3D1
[14051.338781] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[14051.338787] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[14051.338811] thermal_cdev_update: thermal cooling_device2: set to state 0
[14051.338815] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[14051.338834] thermal_cdev_update: thermal cooling_device1: set to state 0
[14051.454544] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[14051.456827] thinkpad_acpi: temperatures (Celsius): 93 50 N/A 80 32 N/A 3=
2 N/A 50 59 N/A N/A N/A N/A N/A N/A
[14051.457944] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D94000
[14051.457957] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[14051.457964] get_target_state: thermal cooling_device2: cur_state=3D0
[14051.457967] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[14051.457973] get_target_state: thermal cooling_device1: cur_state=3D0

=2E..

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgd2ikACgkQMOfwapXb+vJ+fQCfVGQ4HIOarE2jOyGRikfaLm2f
hGMAn3xceSSWhuGXpEx58zMhEUvbGve+
=nlui
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
