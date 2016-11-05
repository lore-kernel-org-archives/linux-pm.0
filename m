From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 14:37:19 +0100
Message-ID: <20161105133719.GA3933@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478301649.7947.3.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [...]
>=20
> > So we seem to have thermal or ACPI regression in v4.9-rc3.
> >=20
> It is possible. Can you add either add printk
> in=A0acpi_processor_ppc_has_changed() or use ftrace and see do you get to
> these functions
>=20
> acpi_processor_ppc_init()
> acpi_processor_ppc_has_changed()
> acpi_processor_ppc_notifier()
>=20
> ?

Yes, these seem to be called. Here's the log:

[  825.759661] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  825.761935] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 50 N/A N/A N/A N/A N/A N/A
[  825.762998] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  825.763007] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  825.763012] get_target_state: thermal cooling_device2: cur_state=3D0
[  825.763015] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  825.763019] get_target_state: thermal cooling_device1: cur_state=3D0
[  825.763022] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  825.763026] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  825.763032] ppc_notifier
[  825.763034] ppc_notifier: mutex
[  825.763036] ppc_notifier: verify within
[  825.763038] ppc_notifier
[  825.763049] ppc_notifier
[  825.763050] ppc_notifier: mutex
[  825.763052] ppc_notifier: verify within
[  825.763054] ppc_notifier
[  825.763077] thermal_cdev_update: thermal cooling_device2: set to state 1
[  825.763081] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  825.763088] ppc_notifier
[  825.763090] ppc_notifier: mutex
[  825.763092] ppc_notifier: verify within
[  825.763095] ppc_notifier
[  825.763101] ppc_notifier
[  825.763103] ppc_notifier: mutex
[  825.763105] ppc_notifier: verify within
[  825.763108] ppc_notifier
[  825.763114] thermal_cdev_update: thermal cooling_device1: set to state 1
[  825.787174] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  825.787187] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  825.787192] get_target_state: thermal cooling_device2: cur_state=3D1
[  825.787196] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  825.787202] get_target_state: thermal cooling_device1: cur_state=3D1
[  825.787206] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  825.787211] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  825.787219] ppc_notifier
[  825.787222] ppc_notifier: mutex
[  825.787224] ppc_notifier: verify within
[  825.787228] ppc_notifier
[  825.787235] ppc_notifier
[  825.787237] ppc_notifier: mutex
[  825.787239] ppc_notifier: verify within
[  825.787242] ppc_notifier
[  825.787248] thermal_cdev_update: thermal cooling_device2: set to state 0
[  825.787253] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  825.787259] ppc_notifier
[  825.787261] ppc_notifier: mutex
[  825.787263] ppc_notifier: verify within
[  825.787266] ppc_notifier
[  825.787272] ppc_notifier
[  825.787274] ppc_notifier: mutex
[  825.787276] ppc_notifier: verify within
[  825.787279] ppc_notifier
[  825.787285] thermal_cdev_update: thermal cooling_device1: set to state 0
[  825.834621] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  825.836567] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 50 N/A N/A N/A N/A N/A N/A
[  825.837639] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  825.837650] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  825.837656] get_target_state: thermal cooling_device2: cur_state=3D0
[  825.837659] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  825.837663] get_target_state: thermal cooling_device1: cur_state=3D0
[  825.837666] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  825.837671] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  825.837679] ppc_notifier
[  825.837680] ppc_notifier: mutex
[  825.837682] ppc_notifier: verify within
[  825.837685] ppc_notifier
[  825.837697] ppc_notifier
[  825.837698] ppc_notifier: mutex
[  825.837700] ppc_notifier: verify within
[  825.837702] ppc_notifier
[  825.837724] thermal_cdev_update: thermal cooling_device2: set to state 1
[  825.837729] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  825.837735] ppc_notifier
[  825.837737] ppc_notifier: mutex
[  825.837739] ppc_notifier: verify within
[  825.837742] ppc_notifier
[  825.837749] ppc_notifier
[  825.837751] ppc_notifier: mutex
[  825.837753] ppc_notifier: verify within
[  825.837756] ppc_notifier
[  825.837762] thermal_cdev_update: thermal cooling_device1: set to state 1
[  825.860554] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  825.860567] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  825.860573] get_target_state: thermal cooling_device2: cur_state=3D1
[  825.860577] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  825.860583] get_target_state: thermal cooling_device1: cur_state=3D1
[  825.860587] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  825.860592] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  825.860600] ppc_notifier
[  825.860603] ppc_notifier: mutex
[  825.860605] ppc_notifier: verify within
[  825.860608] ppc_notifier
[  825.860616] ppc_notifier
[  825.860618] ppc_notifier: mutex
[  825.860620] ppc_notifier: verify within
[  825.860623] ppc_notifier
[  825.860629] thermal_cdev_update: thermal cooling_device2: set to state 0
[  825.860634] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  825.860640] ppc_notifier
[  825.860642] ppc_notifier: mutex
[  825.860644] ppc_notifier: verify within
[  825.860647] ppc_notifier
[  825.860654] ppc_notifier
[  825.860655] ppc_notifier: mutex
[  825.860658] ppc_notifier: verify within
[  825.860660] ppc_notifier
[  825.860666] thermal_cdev_update: thermal cooling_device1: set to state 0
[  825.911871] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  825.913915] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 50 N/A N/A N/A N/A N/A N/A
[  825.914979] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  825.914988] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  825.914992] get_target_state: thermal cooling_device2: cur_state=3D0
[  825.914995] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  825.914999] get_target_state: thermal cooling_device1: cur_state=3D0
[  825.915002] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  825.915006] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  825.915013] ppc_notifier
[  825.915014] ppc_notifier: mutex
[  825.915016] ppc_notifier: verify within
[  825.915019] ppc_notifier
[  825.915029] ppc_notifier
[  825.915030] ppc_notifier: mutex
[  825.915032] ppc_notifier: verify within
[  825.915034] ppc_notifier
[  825.915056] thermal_cdev_update: thermal cooling_device2: set to state 1
[  825.915060] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  825.915067] ppc_notifier
[  825.915069] ppc_notifier: mutex
[  825.915071] ppc_notifier: verify within
[  825.915074] ppc_notifier
[  825.915081] ppc_notifier
[  825.915083] ppc_notifier: mutex
[  825.915085] ppc_notifier: verify within
[  825.915088] ppc_notifier
[  825.915093] thermal_cdev_update: thermal cooling_device1: set to state 1
[  825.939390] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  825.939402] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  825.939408] get_target_state: thermal cooling_device2: cur_state=3D1
[  825.939412] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  825.939418] get_target_state: thermal cooling_device1: cur_state=3D1
[  825.939422] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  825.939427] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  825.939435] ppc_notifier
[  825.939438] ppc_notifier: mutex
[  825.939440] ppc_notifier: verify within
[  825.939444] ppc_notifier
[  825.939451] ppc_notifier
[  825.939453] ppc_notifier: mutex
[  825.939455] ppc_notifier: verify within
[  825.939458] ppc_notifier
[  825.939464] thermal_cdev_update: thermal cooling_device2: set to state 0
[  825.939469] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  825.939475] ppc_notifier
[  825.939477] ppc_notifier: mutex
[  825.939479] ppc_notifier: verify within
[  825.939482] ppc_notifier
[  825.939489] ppc_notifier
[  825.939490] ppc_notifier: mutex
[  825.939493] ppc_notifier: verify within
[  825.939496] ppc_notifier
[  825.939501] thermal_cdev_update: thermal cooling_device1: set to state 0
[  825.982839] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  825.984736] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 50 N/A N/A N/A N/A N/A N/A
[  825.985804] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  825.985813] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  825.985817] get_target_state: thermal cooling_device2: cur_state=3D0
[  825.985820] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  825.985825] get_target_state: thermal cooling_device1: cur_state=3D0
[  825.985827] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  825.985832] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  825.985838] ppc_notifier
[  825.985839] ppc_notifier: mutex
[  825.985841] ppc_notifier: verify within
[  825.985844] ppc_notifier
[  825.985854] ppc_notifier
[  825.985855] ppc_notifier: mutex
[  825.985857] ppc_notifier: verify within
[  825.985859] ppc_notifier
[  825.985881] thermal_cdev_update: thermal cooling_device2: set to state 1
[  825.985886] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  825.985892] ppc_notifier
[  825.985894] ppc_notifier: mutex
[  825.985897] ppc_notifier: verify within
[  825.985899] ppc_notifier
[  825.985906] ppc_notifier
[  825.985908] ppc_notifier: mutex
[  825.985910] ppc_notifier: verify within
[  825.985913] ppc_notifier
[  825.985919] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.008055] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.008067] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.008072] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.008076] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.008082] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.008086] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.008092] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.008100] ppc_notifier
[  826.008102] ppc_notifier: mutex
[  826.008105] ppc_notifier: verify within
[  826.008108] ppc_notifier
[  826.008116] ppc_notifier
[  826.008118] ppc_notifier: mutex
[  826.008120] ppc_notifier: verify within
[  826.008123] ppc_notifier
[  826.008129] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.008133] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.008140] ppc_notifier
[  826.008142] ppc_notifier: mutex
[  826.008144] ppc_notifier: verify within
[  826.008147] ppc_notifier
[  826.008154] ppc_notifier
[  826.008156] ppc_notifier: mutex
[  826.008158] ppc_notifier: verify within
[  826.008161] ppc_notifier
[  826.008167] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.055485] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.057473] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.058557] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.058570] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.058576] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.058579] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.058585] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.058588] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.058592] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.058602] ppc_notifier
[  826.058604] ppc_notifier: mutex
[  826.058606] ppc_notifier: verify within
[  826.058608] ppc_notifier
[  826.058622] ppc_notifier
[  826.058624] ppc_notifier: mutex
[  826.058625] ppc_notifier: verify within
[  826.058627] ppc_notifier
[  826.058650] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.058654] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.058661] ppc_notifier
[  826.058663] ppc_notifier: mutex
[  826.058665] ppc_notifier: verify within
[  826.058668] ppc_notifier
[  826.058674] ppc_notifier
[  826.058676] ppc_notifier: mutex
[  826.058678] ppc_notifier: verify within
[  826.058681] ppc_notifier
[  826.058687] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.080595] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.080609] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.080616] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.080620] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.080626] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.080630] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.080636] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.080645] ppc_notifier
[  826.080648] ppc_notifier: mutex
[  826.080650] ppc_notifier: verify within
[  826.080653] ppc_notifier
[  826.080662] ppc_notifier
[  826.080664] ppc_notifier: mutex
[  826.080666] ppc_notifier: verify within
[  826.080669] ppc_notifier
[  826.080675] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.080679] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.080686] ppc_notifier
[  826.080687] ppc_notifier: mutex
[  826.080690] ppc_notifier: verify within
[  826.080693] ppc_notifier
[  826.080699] ppc_notifier
[  826.080701] ppc_notifier: mutex
[  826.080703] ppc_notifier: verify within
[  826.080706] ppc_notifier
[  826.080712] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.135918] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.138085] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.139177] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.139190] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.139196] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.139200] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.139205] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.139208] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.139213] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.139223] ppc_notifier
[  826.139224] ppc_notifier: mutex
[  826.139227] ppc_notifier: verify within
[  826.139229] ppc_notifier
[  826.139244] ppc_notifier
[  826.139245] ppc_notifier: mutex
[  826.139247] ppc_notifier: verify within
[  826.139249] ppc_notifier
[  826.139271] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.139275] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.139282] ppc_notifier
[  826.139284] ppc_notifier: mutex
[  826.139286] ppc_notifier: verify within
[  826.139289] ppc_notifier
[  826.139296] ppc_notifier
[  826.139298] ppc_notifier: mutex
[  826.139300] ppc_notifier: verify within
[  826.139303] ppc_notifier
[  826.139308] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.160291] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.160307] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.160314] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.160318] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.160324] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.160328] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.160334] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.160344] ppc_notifier
[  826.160347] ppc_notifier: mutex
[  826.160350] ppc_notifier: verify within
[  826.160353] ppc_notifier
[  826.160362] ppc_notifier
[  826.160364] ppc_notifier: mutex
[  826.160366] ppc_notifier: verify within
[  826.160369] ppc_notifier
[  826.160375] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.160379] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.160386] ppc_notifier
[  826.160387] ppc_notifier: mutex
[  826.160390] ppc_notifier: verify within
[  826.160393] ppc_notifier
[  826.160399] ppc_notifier
[  826.160401] ppc_notifier: mutex
[  826.160403] ppc_notifier: verify within
[  826.160406] ppc_notifier
[  826.160412] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.213977] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.215658] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.216763] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.216776] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.216782] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.216785] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.216790] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.216793] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.216797] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.216805] ppc_notifier
[  826.216807] ppc_notifier: mutex
[  826.216809] ppc_notifier: verify within
[  826.216811] ppc_notifier
[  826.216824] ppc_notifier
[  826.216825] ppc_notifier: mutex
[  826.216827] ppc_notifier: verify within
[  826.216829] ppc_notifier
[  826.216851] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.216856] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.216862] ppc_notifier
[  826.216864] ppc_notifier: mutex
[  826.216866] ppc_notifier: verify within
[  826.216869] ppc_notifier
[  826.216876] ppc_notifier
[  826.216878] ppc_notifier: mutex
[  826.216880] ppc_notifier: verify within
[  826.216883] ppc_notifier
[  826.216888] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.240799] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.240814] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.240821] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.240825] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.240831] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.240835] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.240841] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.240851] ppc_notifier
[  826.240854] ppc_notifier: mutex
[  826.240857] ppc_notifier: verify within
[  826.240860] ppc_notifier
[  826.240868] ppc_notifier
[  826.240870] ppc_notifier: mutex
[  826.240872] ppc_notifier: verify within
[  826.240875] ppc_notifier
[  826.240881] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.240885] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.240892] ppc_notifier
[  826.240894] ppc_notifier: mutex
[  826.240896] ppc_notifier: verify within
[  826.240899] ppc_notifier
[  826.240905] ppc_notifier
[  826.240907] ppc_notifier: mutex
[  826.240909] ppc_notifier: verify within
[  826.240912] ppc_notifier
[  826.240918] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.286512] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.288597] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.289674] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.289685] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.289690] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.289694] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.289698] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.289701] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.289705] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.289713] ppc_notifier
[  826.289714] ppc_notifier: mutex
[  826.289716] ppc_notifier: verify within
[  826.289719] ppc_notifier
[  826.289731] ppc_notifier
[  826.289732] ppc_notifier: mutex
[  826.289734] ppc_notifier: verify within
[  826.289736] ppc_notifier
[  826.289758] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.289762] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.289769] ppc_notifier
[  826.289771] ppc_notifier: mutex
[  826.289773] ppc_notifier: verify within
[  826.289776] ppc_notifier
[  826.289783] ppc_notifier
[  826.289784] ppc_notifier: mutex
[  826.289787] ppc_notifier: verify within
[  826.289790] ppc_notifier
[  826.289795] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.310839] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.310852] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.310858] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.310862] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.310868] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.310872] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.310877] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.310885] ppc_notifier
[  826.310888] ppc_notifier: mutex
[  826.310890] ppc_notifier: verify within
[  826.310893] ppc_notifier
[  826.310901] ppc_notifier
[  826.310903] ppc_notifier: mutex
[  826.310905] ppc_notifier: verify within
[  826.310908] ppc_notifier
[  826.310914] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.310919] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.310925] ppc_notifier
[  826.310927] ppc_notifier: mutex
[  826.310929] ppc_notifier: verify within
[  826.310932] ppc_notifier
[  826.310939] ppc_notifier
[  826.310940] ppc_notifier: mutex
[  826.310943] ppc_notifier: verify within
[  826.310946] ppc_notifier
[  826.310951] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.363824] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.365760] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.366839] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.366851] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.366857] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.366860] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.366866] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.366868] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.366873] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.366882] ppc_notifier
[  826.366884] ppc_notifier: mutex
[  826.366886] ppc_notifier: verify within
[  826.366888] ppc_notifier
[  826.366902] ppc_notifier
[  826.366903] ppc_notifier: mutex
[  826.366905] ppc_notifier: verify within
[  826.366907] ppc_notifier
[  826.366929] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.366934] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.366940] ppc_notifier
[  826.366942] ppc_notifier: mutex
[  826.366945] ppc_notifier: verify within
[  826.366947] ppc_notifier
[  826.366954] ppc_notifier
[  826.366956] ppc_notifier: mutex
[  826.366958] ppc_notifier: verify within
[  826.366961] ppc_notifier
[  826.366967] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.388156] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.388169] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.388175] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.388179] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.388184] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.388188] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.388194] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.388202] ppc_notifier
[  826.388205] ppc_notifier: mutex
[  826.388207] ppc_notifier: verify within
[  826.388211] ppc_notifier
[  826.388219] ppc_notifier
[  826.388220] ppc_notifier: mutex
[  826.388223] ppc_notifier: verify within
[  826.388226] ppc_notifier
[  826.388231] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.388236] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.388242] ppc_notifier
[  826.388244] ppc_notifier: mutex
[  826.388246] ppc_notifier: verify within
[  826.388249] ppc_notifier
[  826.388256] ppc_notifier
[  826.388257] ppc_notifier: mutex
[  826.388260] ppc_notifier: verify within
[  826.388263] ppc_notifier
[  826.388268] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.445838] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.447796] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.448896] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.448909] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.448915] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.448918] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.448923] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.448926] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.448930] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.448939] ppc_notifier
[  826.448941] ppc_notifier: mutex
[  826.448943] ppc_notifier: verify within
[  826.448945] ppc_notifier
[  826.448959] ppc_notifier
[  826.448961] ppc_notifier: mutex
[  826.448962] ppc_notifier: verify within
[  826.448965] ppc_notifier
[  826.448987] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.448991] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.448998] ppc_notifier
[  826.449000] ppc_notifier: mutex
[  826.449002] ppc_notifier: verify within
[  826.449005] ppc_notifier
[  826.449038] ppc_notifier
[  826.449040] ppc_notifier: mutex
[  826.449042] ppc_notifier: verify within
[  826.449045] ppc_notifier
[  826.449051] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.470926] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.470939] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.470945] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.470949] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.470955] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.470959] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.470964] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.470973] ppc_notifier
[  826.470976] ppc_notifier: mutex
[  826.470978] ppc_notifier: verify within
[  826.470981] ppc_notifier
[  826.470989] ppc_notifier
[  826.470991] ppc_notifier: mutex
[  826.470994] ppc_notifier: verify within
[  826.470996] ppc_notifier
[  826.471002] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.471007] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.471013] ppc_notifier
[  826.471015] ppc_notifier: mutex
[  826.471017] ppc_notifier: verify within
[  826.471020] ppc_notifier
[  826.471026] ppc_notifier
[  826.471028] ppc_notifier: mutex
[  826.471030] ppc_notifier: verify within
[  826.471033] ppc_notifier
[  826.471039] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.522354] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.524847] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.525991] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.526003] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.526010] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.526013] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.526019] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.526022] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.526026] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.526036] ppc_notifier
[  826.526037] ppc_notifier: mutex
[  826.526039] ppc_notifier: verify within
[  826.526042] ppc_notifier
[  826.526055] ppc_notifier
[  826.526057] ppc_notifier: mutex
[  826.526058] ppc_notifier: verify within
[  826.526060] ppc_notifier
[  826.526082] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.526087] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.526093] ppc_notifier
[  826.526095] ppc_notifier: mutex
[  826.526098] ppc_notifier: verify within
[  826.526100] ppc_notifier
[  826.526107] ppc_notifier
[  826.526109] ppc_notifier: mutex
[  826.526111] ppc_notifier: verify within
[  826.526114] ppc_notifier
[  826.526120] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.549860] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.549876] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.549883] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.549887] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.549893] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.549897] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.549903] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.549914] ppc_notifier
[  826.549918] ppc_notifier: mutex
[  826.549921] ppc_notifier: verify within
[  826.549924] ppc_notifier
[  826.549933] ppc_notifier
[  826.549935] ppc_notifier: mutex
[  826.549937] ppc_notifier: verify within
[  826.549940] ppc_notifier
[  826.549946] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.549951] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.549958] ppc_notifier
[  826.549959] ppc_notifier: mutex
[  826.549962] ppc_notifier: verify within
[  826.549964] ppc_notifier
[  826.549974] ppc_notifier
[  826.549976] ppc_notifier: mutex
[  826.549978] ppc_notifier: verify within
[  826.549981] ppc_notifier
[  826.549986] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.617011] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.619171] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.620289] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  826.620302] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  826.620309] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.620312] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  826.620318] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.620321] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  826.620325] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  826.620335] ppc_notifier
[  826.620338] ppc_notifier: mutex
[  826.620340] ppc_notifier: verify within
[  826.620342] ppc_notifier
[  826.620357] ppc_notifier
[  826.620358] ppc_notifier: mutex
[  826.620360] ppc_notifier: verify within
[  826.620362] ppc_notifier
[  826.620384] thermal_cdev_update: thermal cooling_device2: set to state 1
[  826.620389] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  826.620395] ppc_notifier
[  826.620397] ppc_notifier: mutex
[  826.620400] ppc_notifier: verify within
[  826.620403] ppc_notifier
[  826.620409] ppc_notifier
[  826.620411] ppc_notifier: mutex
[  826.620413] ppc_notifier: verify within
[  826.620416] ppc_notifier
[  826.620422] thermal_cdev_update: thermal cooling_device1: set to state 1
[  826.639698] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  826.639712] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  826.639718] get_target_state: thermal cooling_device2: cur_state=3D1
[  826.639722] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  826.639728] get_target_state: thermal cooling_device1: cur_state=3D1
[  826.639732] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  826.639737] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  826.639746] ppc_notifier
[  826.639749] ppc_notifier: mutex
[  826.639752] ppc_notifier: verify within
[  826.639755] ppc_notifier
[  826.639763] ppc_notifier
[  826.639764] ppc_notifier: mutex
[  826.639767] ppc_notifier: verify within
[  826.639770] ppc_notifier
[  826.639775] thermal_cdev_update: thermal cooling_device2: set to state 0
[  826.639780] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  826.639786] ppc_notifier
[  826.639788] ppc_notifier: mutex
[  826.639790] ppc_notifier: verify within
[  826.639793] ppc_notifier
[  826.639800] ppc_notifier
[  826.639801] ppc_notifier: mutex
[  826.639804] ppc_notifier: verify within
[  826.639807] ppc_notifier
[  826.639812] thermal_cdev_update: thermal cooling_device1: set to state 0
[  826.726591] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  826.728692] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  826.729787] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D92000
[  826.729800] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D0
[  826.729807] get_target_state: thermal cooling_device2: cur_state=3D0
[  826.729810] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D0
[  826.729815] get_target_state: thermal cooling_device1: cur_state=3D0
[  826.729817] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D0
[  827.283998] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.285821] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.286911] update_temperature: thermal thermal_zone1: last_temperature=
=3D92000, current_temperature=3D94000
[  827.286923] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.286930] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.286933] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.286939] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.286941] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.286946] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.286956] ppc_notifier
[  827.286958] ppc_notifier: mutex
[  827.286960] ppc_notifier: verify within
[  827.286962] ppc_notifier
[  827.286978] ppc_notifier
[  827.286979] ppc_notifier: mutex
[  827.286981] ppc_notifier: verify within
[  827.286983] ppc_notifier
[  827.287006] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.287010] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.287017] ppc_notifier
[  827.287019] ppc_notifier: mutex
[  827.287021] ppc_notifier: verify within
[  827.287024] ppc_notifier
[  827.287030] ppc_notifier
[  827.287032] ppc_notifier: mutex
[  827.287034] ppc_notifier: verify within
[  827.287037] ppc_notifier
[  827.287043] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.338307] update_temperature: thermal thermal_zone1: last_temperature=
=3D94000, current_temperature=3D91000
[  827.338324] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.338332] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.338336] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.338343] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.338346] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.338353] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.338364] ppc_notifier
[  827.338368] ppc_notifier: mutex
[  827.338370] ppc_notifier: verify within
[  827.338373] ppc_notifier
[  827.338382] ppc_notifier
[  827.338384] ppc_notifier: mutex
[  827.338386] ppc_notifier: verify within
[  827.338389] ppc_notifier
[  827.338395] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.338400] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.338406] ppc_notifier
[  827.338408] ppc_notifier: mutex
[  827.338410] ppc_notifier: verify within
[  827.338413] ppc_notifier
[  827.338420] ppc_notifier
[  827.338421] ppc_notifier: mutex
[  827.338424] ppc_notifier: verify within
[  827.338427] ppc_notifier
[  827.338432] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.371473] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.373416] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.374483] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D92000
[  827.374493] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D0
[  827.374497] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.374500] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D0
[  827.374504] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.374507] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D0
[  827.463669] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.465426] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.466489] update_temperature: thermal thermal_zone1: last_temperature=
=3D92000, current_temperature=3D94000
[  827.466499] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.466503] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.466506] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.466510] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.466513] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.466517] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.466524] ppc_notifier
[  827.466525] ppc_notifier: mutex
[  827.466527] ppc_notifier: verify within
[  827.466529] ppc_notifier
[  827.466540] ppc_notifier
[  827.466541] ppc_notifier: mutex
[  827.466543] ppc_notifier: verify within
[  827.466545] ppc_notifier
[  827.466567] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.466572] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.466579] ppc_notifier
[  827.466581] ppc_notifier: mutex
[  827.466583] ppc_notifier: verify within
[  827.466586] ppc_notifier
[  827.466592] ppc_notifier
[  827.466594] ppc_notifier: mutex
[  827.466596] ppc_notifier: verify within
[  827.466599] ppc_notifier
[  827.466605] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.519569] update_temperature: thermal thermal_zone1: last_temperature=
=3D94000, current_temperature=3D91000
[  827.519581] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.519587] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.519591] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.519597] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.519600] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.519606] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.519614] ppc_notifier
[  827.519616] ppc_notifier: mutex
[  827.519619] ppc_notifier: verify within
[  827.519622] ppc_notifier
[  827.519629] ppc_notifier
[  827.519631] ppc_notifier: mutex
[  827.519633] ppc_notifier: verify within
[  827.519636] ppc_notifier
[  827.519642] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.519647] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.519653] ppc_notifier
[  827.519655] ppc_notifier: mutex
[  827.519657] ppc_notifier: verify within
[  827.519660] ppc_notifier
[  827.519667] ppc_notifier
[  827.519668] ppc_notifier: mutex
[  827.519671] ppc_notifier: verify within
[  827.519674] ppc_notifier
[  827.519679] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.555994] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.557957] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.559027] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.559038] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.559043] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.559046] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.559051] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.559054] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.559058] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.559065] ppc_notifier
[  827.559067] ppc_notifier: mutex
[  827.559069] ppc_notifier: verify within
[  827.559071] ppc_notifier
[  827.559084] ppc_notifier
[  827.559085] ppc_notifier: mutex
[  827.559087] ppc_notifier: verify within
[  827.559089] ppc_notifier
[  827.559111] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.559116] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.559122] ppc_notifier
[  827.559124] ppc_notifier: mutex
[  827.559126] ppc_notifier: verify within
[  827.559129] ppc_notifier
[  827.559136] ppc_notifier
[  827.559138] ppc_notifier: mutex
[  827.559140] ppc_notifier: verify within
[  827.559143] ppc_notifier
[  827.559149] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.581963] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  827.581979] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.581987] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.581991] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.581998] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.582002] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.582008] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.582020] ppc_notifier
[  827.582023] ppc_notifier: mutex
[  827.582026] ppc_notifier: verify within
[  827.582029] ppc_notifier
[  827.582038] ppc_notifier
[  827.582039] ppc_notifier: mutex
[  827.582042] ppc_notifier: verify within
[  827.582045] ppc_notifier
[  827.582051] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.582055] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.582062] ppc_notifier
[  827.582063] ppc_notifier: mutex
[  827.582066] ppc_notifier: verify within
[  827.582069] ppc_notifier
[  827.582075] ppc_notifier
[  827.582077] ppc_notifier: mutex
[  827.582079] ppc_notifier: verify within
[  827.582082] ppc_notifier
[  827.582088] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.637247] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.639122] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.640235] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.640246] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.640253] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.640256] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.640262] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.640265] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.640270] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.640282] ppc_notifier
[  827.640283] ppc_notifier: mutex
[  827.640286] ppc_notifier: verify within
[  827.640288] ppc_notifier
[  827.640303] ppc_notifier
[  827.640305] ppc_notifier: mutex
[  827.640306] ppc_notifier: verify within
[  827.640308] ppc_notifier
[  827.640331] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.640335] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.640342] ppc_notifier
[  827.640344] ppc_notifier: mutex
[  827.640346] ppc_notifier: verify within
[  827.640349] ppc_notifier
[  827.640356] ppc_notifier
[  827.640358] ppc_notifier: mutex
[  827.640360] ppc_notifier: verify within
[  827.640363] ppc_notifier
[  827.640368] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.666299] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  827.666312] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.666318] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.666322] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.666327] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.666331] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.666337] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.666346] ppc_notifier
[  827.666349] ppc_notifier: mutex
[  827.666352] ppc_notifier: verify within
[  827.666355] ppc_notifier
[  827.666362] ppc_notifier
[  827.666364] ppc_notifier: mutex
[  827.666366] ppc_notifier: verify within
[  827.666369] ppc_notifier
[  827.666375] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.666380] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.666386] ppc_notifier
[  827.666388] ppc_notifier: mutex
[  827.666390] ppc_notifier: verify within
[  827.666393] ppc_notifier
[  827.666400] ppc_notifier
[  827.666401] ppc_notifier: mutex
[  827.666404] ppc_notifier: verify within
[  827.666406] ppc_notifier
[  827.666412] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.701857] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.703712] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.704815] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.704825] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.704830] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.704833] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.704837] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.704840] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.704844] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.704850] ppc_notifier
[  827.704852] ppc_notifier: mutex
[  827.704854] ppc_notifier: verify within
[  827.704856] ppc_notifier
[  827.704866] ppc_notifier
[  827.704868] ppc_notifier: mutex
[  827.704869] ppc_notifier: verify within
[  827.704871] ppc_notifier
[  827.704894] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.704898] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.704905] ppc_notifier
[  827.704907] ppc_notifier: mutex
[  827.704909] ppc_notifier: verify within
[  827.704912] ppc_notifier
[  827.704918] ppc_notifier
[  827.704920] ppc_notifier: mutex
[  827.704922] ppc_notifier: verify within
[  827.704925] ppc_notifier
[  827.704931] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.729531] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  827.729544] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.729550] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.729554] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.729559] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.729563] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.729569] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.729578] ppc_notifier
[  827.729580] ppc_notifier: mutex
[  827.729583] ppc_notifier: verify within
[  827.729586] ppc_notifier
[  827.729594] ppc_notifier
[  827.729595] ppc_notifier: mutex
[  827.729598] ppc_notifier: verify within
[  827.729601] ppc_notifier
[  827.729607] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.729611] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.729618] ppc_notifier
[  827.729619] ppc_notifier: mutex
[  827.729622] ppc_notifier: verify within
[  827.729625] ppc_notifier
[  827.729631] ppc_notifier
[  827.729633] ppc_notifier: mutex
[  827.729635] ppc_notifier: verify within
[  827.729638] ppc_notifier
[  827.729643] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.769719] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.771414] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.772512] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.772523] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.772529] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.772531] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.772536] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.772539] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.772543] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.772551] ppc_notifier
[  827.772553] ppc_notifier: mutex
[  827.772555] ppc_notifier: verify within
[  827.772557] ppc_notifier
[  827.772569] ppc_notifier
[  827.772570] ppc_notifier: mutex
[  827.772572] ppc_notifier: verify within
[  827.772574] ppc_notifier
[  827.772596] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.772601] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.772607] ppc_notifier
[  827.772609] ppc_notifier: mutex
[  827.772612] ppc_notifier: verify within
[  827.772614] ppc_notifier
[  827.772621] ppc_notifier
[  827.772623] ppc_notifier: mutex
[  827.772625] ppc_notifier: verify within
[  827.772628] ppc_notifier
[  827.772634] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.795626] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  827.795639] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.795644] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.795648] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.795654] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.795658] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.795664] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.795672] ppc_notifier
[  827.795675] ppc_notifier: mutex
[  827.795677] ppc_notifier: verify within
[  827.795680] ppc_notifier
[  827.795688] ppc_notifier
[  827.795690] ppc_notifier: mutex
[  827.795692] ppc_notifier: verify within
[  827.795695] ppc_notifier
[  827.795701] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.795705] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.795712] ppc_notifier
[  827.795713] ppc_notifier: mutex
[  827.795716] ppc_notifier: verify within
[  827.795719] ppc_notifier
[  827.795725] ppc_notifier
[  827.795727] ppc_notifier: mutex
[  827.795729] ppc_notifier: verify within
[  827.795732] ppc_notifier
[  827.795738] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.834349] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.835988] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.837066] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.837075] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.837079] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.837082] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.837086] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.837089] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.837093] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.837099] ppc_notifier
[  827.837101] ppc_notifier: mutex
[  827.837103] ppc_notifier: verify within
[  827.837105] ppc_notifier
[  827.837116] ppc_notifier
[  827.837117] ppc_notifier: mutex
[  827.837119] ppc_notifier: verify within
[  827.837121] ppc_notifier
[  827.837143] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.837147] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.837154] ppc_notifier
[  827.837156] ppc_notifier: mutex
[  827.837158] ppc_notifier: verify within
[  827.837161] ppc_notifier
[  827.837168] ppc_notifier
[  827.837170] ppc_notifier: mutex
[  827.837172] ppc_notifier: verify within
[  827.837175] ppc_notifier
[  827.837180] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.863443] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  827.863455] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.863461] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.863465] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.863470] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.863474] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.863480] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.863488] ppc_notifier
[  827.863490] ppc_notifier: mutex
[  827.863493] ppc_notifier: verify within
[  827.863496] ppc_notifier
[  827.863503] ppc_notifier
[  827.863505] ppc_notifier: mutex
[  827.863508] ppc_notifier: verify within
[  827.863510] ppc_notifier
[  827.863516] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.863521] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.863527] ppc_notifier
[  827.863529] ppc_notifier: mutex
[  827.863531] ppc_notifier: verify within
[  827.863534] ppc_notifier
[  827.863541] ppc_notifier
[  827.863542] ppc_notifier: mutex
[  827.863545] ppc_notifier: verify within
[  827.863547] ppc_notifier
[  827.863553] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.906106] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.907946] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.909036] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.909045] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.909049] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.909052] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.909056] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.909059] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.909063] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.909069] ppc_notifier
[  827.909070] ppc_notifier: mutex
[  827.909072] ppc_notifier: verify within
[  827.909074] ppc_notifier
[  827.909085] ppc_notifier
[  827.909086] ppc_notifier: mutex
[  827.909088] ppc_notifier: verify within
[  827.909090] ppc_notifier
[  827.909112] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.909116] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.909123] ppc_notifier
[  827.909125] ppc_notifier: mutex
[  827.909127] ppc_notifier: verify within
[  827.909130] ppc_notifier
[  827.909137] ppc_notifier
[  827.909139] ppc_notifier: mutex
[  827.909141] ppc_notifier: verify within
[  827.909144] ppc_notifier
[  827.909149] thermal_cdev_update: thermal cooling_device1: set to state 1
[  827.934466] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  827.934481] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  827.934488] get_target_state: thermal cooling_device2: cur_state=3D1
[  827.934492] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  827.934498] get_target_state: thermal cooling_device1: cur_state=3D1
[  827.934502] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  827.934508] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  827.934517] ppc_notifier
[  827.934521] ppc_notifier: mutex
[  827.934524] ppc_notifier: verify within
[  827.934527] ppc_notifier
[  827.934535] ppc_notifier
[  827.934537] ppc_notifier: mutex
[  827.934539] ppc_notifier: verify within
[  827.934542] ppc_notifier
[  827.934548] thermal_cdev_update: thermal cooling_device2: set to state 0
[  827.934553] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  827.934559] ppc_notifier
[  827.934561] ppc_notifier: mutex
[  827.934563] ppc_notifier: verify within
[  827.934566] ppc_notifier
[  827.934573] ppc_notifier
[  827.934574] ppc_notifier: mutex
[  827.934577] ppc_notifier: verify within
[  827.934579] ppc_notifier
[  827.934585] thermal_cdev_update: thermal cooling_device1: set to state 0
[  827.981866] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  827.983841] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  827.984954] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  827.984965] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  827.984971] get_target_state: thermal cooling_device2: cur_state=3D0
[  827.984973] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  827.984978] get_target_state: thermal cooling_device1: cur_state=3D0
[  827.984981] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  827.984986] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  827.984993] ppc_notifier
[  827.984995] ppc_notifier: mutex
[  827.984997] ppc_notifier: verify within
[  827.984999] ppc_notifier
[  827.985016] ppc_notifier
[  827.985017] ppc_notifier: mutex
[  827.985019] ppc_notifier: verify within
[  827.985021] ppc_notifier
[  827.985049] thermal_cdev_update: thermal cooling_device2: set to state 1
[  827.985053] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  827.985060] ppc_notifier
[  827.985062] ppc_notifier: mutex
[  827.985064] ppc_notifier: verify within
[  827.985067] ppc_notifier
[  827.985074] ppc_notifier
[  827.985076] ppc_notifier: mutex
[  827.985078] ppc_notifier: verify within
[  827.985081] ppc_notifier
[  827.985087] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.011773] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.011788] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.011795] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.011799] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.011805] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.011809] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.011815] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.011825] ppc_notifier
[  828.011829] ppc_notifier: mutex
[  828.011832] ppc_notifier: verify within
[  828.011835] ppc_notifier
[  828.011843] ppc_notifier
[  828.011845] ppc_notifier: mutex
[  828.011847] ppc_notifier: verify within
[  828.011850] ppc_notifier
[  828.011856] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.011861] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.011867] ppc_notifier
[  828.011869] ppc_notifier: mutex
[  828.011871] ppc_notifier: verify within
[  828.011874] ppc_notifier
[  828.011881] ppc_notifier
[  828.011882] ppc_notifier: mutex
[  828.011885] ppc_notifier: verify within
[  828.011888] ppc_notifier
[  828.011893] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.060775] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.062465] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 46 50 N/A N/A N/A N/A N/A N/A
[  828.063535] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.063547] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.063554] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.063557] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.063563] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.063565] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.063570] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.063580] ppc_notifier
[  828.063582] ppc_notifier: mutex
[  828.063584] ppc_notifier: verify within
[  828.063586] ppc_notifier
[  828.063601] ppc_notifier
[  828.063602] ppc_notifier: mutex
[  828.063604] ppc_notifier: verify within
[  828.063606] ppc_notifier
[  828.063629] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.063633] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.063640] ppc_notifier
[  828.063642] ppc_notifier: mutex
[  828.063644] ppc_notifier: verify within
[  828.063647] ppc_notifier
[  828.063653] ppc_notifier
[  828.063655] ppc_notifier: mutex
[  828.063657] ppc_notifier: verify within
[  828.063660] ppc_notifier
[  828.063666] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.083558] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.083576] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.083585] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.083589] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.083596] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.083599] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.083605] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.083618] ppc_notifier
[  828.083622] ppc_notifier: mutex
[  828.083625] ppc_notifier: verify within
[  828.083628] ppc_notifier
[  828.083638] ppc_notifier
[  828.083640] ppc_notifier: mutex
[  828.083642] ppc_notifier: verify within
[  828.083645] ppc_notifier
[  828.083651] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.083655] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.083662] ppc_notifier
[  828.083664] ppc_notifier: mutex
[  828.083666] ppc_notifier: verify within
[  828.083669] ppc_notifier
[  828.083676] ppc_notifier
[  828.083677] ppc_notifier: mutex
[  828.083680] ppc_notifier: verify within
[  828.083683] ppc_notifier
[  828.083688] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.126211] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.127976] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 50 N/A N/A N/A N/A N/A N/A
[  828.129083] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.129095] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.129102] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.129105] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.129110] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.129113] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.129117] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.129127] ppc_notifier
[  828.129129] ppc_notifier: mutex
[  828.129131] ppc_notifier: verify within
[  828.129133] ppc_notifier
[  828.129148] ppc_notifier
[  828.129149] ppc_notifier: mutex
[  828.129151] ppc_notifier: verify within
[  828.129153] ppc_notifier
[  828.129175] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.129179] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.129186] ppc_notifier
[  828.129188] ppc_notifier: mutex
[  828.129190] ppc_notifier: verify within
[  828.129193] ppc_notifier
[  828.129200] ppc_notifier
[  828.129201] ppc_notifier: mutex
[  828.129204] ppc_notifier: verify within
[  828.129206] ppc_notifier
[  828.129212] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.156875] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.156890] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.156897] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.156901] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.156908] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.156911] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.156917] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.156927] ppc_notifier
[  828.156931] ppc_notifier: mutex
[  828.156934] ppc_notifier: verify within
[  828.156937] ppc_notifier
[  828.156945] ppc_notifier
[  828.156947] ppc_notifier: mutex
[  828.156949] ppc_notifier: verify within
[  828.156952] ppc_notifier
[  828.156958] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.156962] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.156969] ppc_notifier
[  828.156971] ppc_notifier: mutex
[  828.156973] ppc_notifier: verify within
[  828.156976] ppc_notifier
[  828.156982] ppc_notifier
[  828.156984] ppc_notifier: mutex
[  828.156987] ppc_notifier: verify within
[  828.156989] ppc_notifier
[  828.156995] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.197938] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.200208] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 50 N/A N/A N/A N/A N/A N/A
[  828.201275] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.201286] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.201291] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.201294] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.201298] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.201301] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.201306] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.201313] ppc_notifier
[  828.201315] ppc_notifier: mutex
[  828.201317] ppc_notifier: verify within
[  828.201319] ppc_notifier
[  828.201332] ppc_notifier
[  828.201333] ppc_notifier: mutex
[  828.201335] ppc_notifier: verify within
[  828.201337] ppc_notifier
[  828.201359] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.201363] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.201370] ppc_notifier
[  828.201372] ppc_notifier: mutex
[  828.201374] ppc_notifier: verify within
[  828.201377] ppc_notifier
[  828.201383] ppc_notifier
[  828.201385] ppc_notifier: mutex
[  828.201387] ppc_notifier: verify within
[  828.201390] ppc_notifier
[  828.201396] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.224688] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.224702] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.224709] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.224713] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.224719] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.224723] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.224729] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.224737] ppc_notifier
[  828.224741] ppc_notifier: mutex
[  828.224743] ppc_notifier: verify within
[  828.224746] ppc_notifier
[  828.224754] ppc_notifier
[  828.224756] ppc_notifier: mutex
[  828.224758] ppc_notifier: verify within
[  828.224761] ppc_notifier
[  828.224767] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.224771] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.224778] ppc_notifier
[  828.224780] ppc_notifier: mutex
[  828.224782] ppc_notifier: verify within
[  828.224785] ppc_notifier
[  828.224791] ppc_notifier
[  828.224793] ppc_notifier: mutex
[  828.224796] ppc_notifier: verify within
[  828.224798] ppc_notifier
[  828.224804] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.270482] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.272281] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.273350] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.273361] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.273366] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.273369] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.273374] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.273377] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.273381] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.273389] ppc_notifier
[  828.273390] ppc_notifier: mutex
[  828.273392] ppc_notifier: verify within
[  828.273394] ppc_notifier
[  828.273406] ppc_notifier
[  828.273408] ppc_notifier: mutex
[  828.273409] ppc_notifier: verify within
[  828.273411] ppc_notifier
[  828.273434] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.273438] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.273445] ppc_notifier
[  828.273447] ppc_notifier: mutex
[  828.273449] ppc_notifier: verify within
[  828.273452] ppc_notifier
[  828.273458] ppc_notifier
[  828.273460] ppc_notifier: mutex
[  828.273462] ppc_notifier: verify within
[  828.273465] ppc_notifier
[  828.273471] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.299572] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.299587] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.299594] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.299598] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.299604] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.299608] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.299614] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.299623] ppc_notifier
[  828.299627] ppc_notifier: mutex
[  828.299630] ppc_notifier: verify within
[  828.299633] ppc_notifier
[  828.299641] ppc_notifier
[  828.299642] ppc_notifier: mutex
[  828.299645] ppc_notifier: verify within
[  828.299648] ppc_notifier
[  828.299654] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.299658] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.299664] ppc_notifier
[  828.299666] ppc_notifier: mutex
[  828.299668] ppc_notifier: verify within
[  828.299671] ppc_notifier
[  828.299678] ppc_notifier
[  828.299680] ppc_notifier: mutex
[  828.299682] ppc_notifier: verify within
[  828.299685] ppc_notifier
[  828.299690] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.337002] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.338880] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.339952] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.339963] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.339969] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.339972] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.339977] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.339980] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.339984] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.339993] ppc_notifier
[  828.339995] ppc_notifier: mutex
[  828.339997] ppc_notifier: verify within
[  828.339999] ppc_notifier
[  828.340034] ppc_notifier
[  828.340036] ppc_notifier: mutex
[  828.340038] ppc_notifier: verify within
[  828.340040] ppc_notifier
[  828.340063] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.340068] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.340075] ppc_notifier
[  828.340077] ppc_notifier: mutex
[  828.340079] ppc_notifier: verify within
[  828.340082] ppc_notifier
[  828.340088] ppc_notifier
[  828.340090] ppc_notifier: mutex
[  828.340092] ppc_notifier: verify within
[  828.340095] ppc_notifier
[  828.340101] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.365077] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.365092] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.365099] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.365103] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.365109] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.365113] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.365119] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.365128] ppc_notifier
[  828.365132] ppc_notifier: mutex
[  828.365135] ppc_notifier: verify within
[  828.365138] ppc_notifier
[  828.365146] ppc_notifier
[  828.365148] ppc_notifier: mutex
[  828.365150] ppc_notifier: verify within
[  828.365153] ppc_notifier
[  828.365159] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.365163] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.365170] ppc_notifier
[  828.365171] ppc_notifier: mutex
[  828.365174] ppc_notifier: verify within
[  828.365177] ppc_notifier
[  828.365183] ppc_notifier
[  828.365185] ppc_notifier: mutex
[  828.365187] ppc_notifier: verify within
[  828.365190] ppc_notifier
[  828.365196] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.402156] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.404050] thinkpad_acpi: temperatures (Celsius):
[  828.404055]  101 49 N/A 78 33 N/A 33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.405118] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.405127] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.405132] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.405134] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.405139] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.405141] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.405146] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.405151] ppc_notifier
[  828.405153] ppc_notifier: mutex
[  828.405155] ppc_notifier: verify within
[  828.405157] ppc_notifier
[  828.405168] ppc_notifier
[  828.405169] ppc_notifier: mutex
[  828.405171] ppc_notifier: verify within
[  828.405173] ppc_notifier
[  828.405195] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.405199] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.405206] ppc_notifier
[  828.405208] ppc_notifier: mutex
[  828.405210] ppc_notifier: verify within
[  828.405213] ppc_notifier
[  828.405219] ppc_notifier
[  828.405221] ppc_notifier: mutex
[  828.405223] ppc_notifier: verify within
[  828.405226] ppc_notifier
[  828.405232] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.428906] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.428919] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.428925] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.428929] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.428934] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.428938] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.428943] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.428952] ppc_notifier
[  828.428954] ppc_notifier: mutex
[  828.428957] ppc_notifier: verify within
[  828.428960] ppc_notifier
[  828.428967] ppc_notifier
[  828.428969] ppc_notifier: mutex
[  828.428971] ppc_notifier: verify within
[  828.428974] ppc_notifier
[  828.428980] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.428984] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.428991] ppc_notifier
[  828.428993] ppc_notifier: mutex
[  828.428995] ppc_notifier: verify within
[  828.428998] ppc_notifier
[  828.429004] ppc_notifier
[  828.429006] ppc_notifier: mutex
[  828.429008] ppc_notifier: verify within
[  828.429011] ppc_notifier
[  828.429017] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.470010] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.471754] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.472852] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.472862] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.472868] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.472871] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.472875] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.472878] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.472883] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.472890] ppc_notifier
[  828.472892] ppc_notifier: mutex
[  828.472894] ppc_notifier: verify within
[  828.472896] ppc_notifier
[  828.472909] ppc_notifier
[  828.472910] ppc_notifier: mutex
[  828.472912] ppc_notifier: verify within
[  828.472914] ppc_notifier
[  828.472936] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.472940] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.472947] ppc_notifier
[  828.472949] ppc_notifier: mutex
[  828.472951] ppc_notifier: verify within
[  828.472954] ppc_notifier
[  828.472960] ppc_notifier
[  828.472962] ppc_notifier: mutex
[  828.472964] ppc_notifier: verify within
[  828.472967] ppc_notifier
[  828.472973] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.500711] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.500725] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.500732] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.500736] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.500742] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.500746] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.500751] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.500760] ppc_notifier
[  828.500764] ppc_notifier: mutex
[  828.500767] ppc_notifier: verify within
[  828.500770] ppc_notifier
[  828.500778] ppc_notifier
[  828.500780] ppc_notifier: mutex
[  828.500782] ppc_notifier: verify within
[  828.500785] ppc_notifier
[  828.500791] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.500795] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.500802] ppc_notifier
[  828.500803] ppc_notifier: mutex
[  828.500806] ppc_notifier: verify within
[  828.500809] ppc_notifier
[  828.500815] ppc_notifier
[  828.500817] ppc_notifier: mutex
[  828.500819] ppc_notifier: verify within
[  828.500822] ppc_notifier
[  828.500827] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.548101] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.549931] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.550992] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.551002] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.551007] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.551010] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.551014] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.551017] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.551021] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.551029] ppc_notifier
[  828.551031] ppc_notifier: mutex
[  828.551033] ppc_notifier: verify within
[  828.551035] ppc_notifier
[  828.551047] ppc_notifier
[  828.551049] ppc_notifier: mutex
[  828.551050] ppc_notifier: verify within
[  828.551052] ppc_notifier
[  828.551075] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.551079] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.551086] ppc_notifier
[  828.551088] ppc_notifier: mutex
[  828.551090] ppc_notifier: verify within
[  828.551093] ppc_notifier
[  828.551099] ppc_notifier
[  828.551101] ppc_notifier: mutex
[  828.551103] ppc_notifier: verify within
[  828.551106] ppc_notifier
[  828.551112] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.577234] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.577247] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.577253] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.577257] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.577263] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.577266] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.577272] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.577280] ppc_notifier
[  828.577283] ppc_notifier: mutex
[  828.577285] ppc_notifier: verify within
[  828.577288] ppc_notifier
[  828.577296] ppc_notifier
[  828.577298] ppc_notifier: mutex
[  828.577300] ppc_notifier: verify within
[  828.577303] ppc_notifier
[  828.577309] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.577313] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.577320] ppc_notifier
[  828.577321] ppc_notifier: mutex
[  828.577324] ppc_notifier: verify within
[  828.577327] ppc_notifier
[  828.577333] ppc_notifier
[  828.577335] ppc_notifier: mutex
[  828.577337] ppc_notifier: verify within
[  828.577340] ppc_notifier
[  828.577346] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.624746] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.626737] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.627812] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.627822] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.627828] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.627831] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.627835] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.627838] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.627843] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.627850] ppc_notifier
[  828.627852] ppc_notifier: mutex
[  828.627854] ppc_notifier: verify within
[  828.627856] ppc_notifier
[  828.627869] ppc_notifier
[  828.627870] ppc_notifier: mutex
[  828.627872] ppc_notifier: verify within
[  828.627874] ppc_notifier
[  828.627896] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.627901] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.627907] ppc_notifier
[  828.627909] ppc_notifier: mutex
[  828.627911] ppc_notifier: verify within
[  828.627914] ppc_notifier
[  828.627921] ppc_notifier
[  828.627923] ppc_notifier: mutex
[  828.627925] ppc_notifier: verify within
[  828.627928] ppc_notifier
[  828.627933] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.655250] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.655265] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.655272] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.655276] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.655282] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.655285] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.655291] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.655301] ppc_notifier
[  828.655304] ppc_notifier: mutex
[  828.655307] ppc_notifier: verify within
[  828.655310] ppc_notifier
[  828.655318] ppc_notifier
[  828.655320] ppc_notifier: mutex
[  828.655322] ppc_notifier: verify within
[  828.655325] ppc_notifier
[  828.655331] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.655336] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.655342] ppc_notifier
[  828.655344] ppc_notifier: mutex
[  828.655346] ppc_notifier: verify within
[  828.655349] ppc_notifier
[  828.655356] ppc_notifier
[  828.655358] ppc_notifier: mutex
[  828.655360] ppc_notifier: verify within
[  828.655363] ppc_notifier
[  828.655368] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.707712] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.709971] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.711069] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.711082] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.711089] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.711092] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.711098] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.711100] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.711105] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.711115] ppc_notifier
[  828.711117] ppc_notifier: mutex
[  828.711119] ppc_notifier: verify within
[  828.711121] ppc_notifier
[  828.711136] ppc_notifier
[  828.711138] ppc_notifier: mutex
[  828.711139] ppc_notifier: verify within
[  828.711142] ppc_notifier
[  828.711164] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.711168] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.711175] ppc_notifier
[  828.711177] ppc_notifier: mutex
[  828.711179] ppc_notifier: verify within
[  828.711182] ppc_notifier
[  828.711189] ppc_notifier
[  828.711190] ppc_notifier: mutex
[  828.711193] ppc_notifier: verify within
[  828.711195] ppc_notifier
[  828.711201] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.735998] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.736048] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.736055] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.736059] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.736066] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.736070] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.736076] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.736086] ppc_notifier
[  828.736090] ppc_notifier: mutex
[  828.736092] ppc_notifier: verify within
[  828.736096] ppc_notifier
[  828.736104] ppc_notifier
[  828.736106] ppc_notifier: mutex
[  828.736108] ppc_notifier: verify within
[  828.736111] ppc_notifier
[  828.736117] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.736121] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.736128] ppc_notifier
[  828.736130] ppc_notifier: mutex
[  828.736132] ppc_notifier: verify within
[  828.736135] ppc_notifier
[  828.736141] ppc_notifier
[  828.736143] ppc_notifier: mutex
[  828.736145] ppc_notifier: verify within
[  828.736148] ppc_notifier
[  828.736154] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.779952] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.782274] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.783364] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.783375] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.783380] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.783383] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.783388] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.783391] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.783396] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.783404] ppc_notifier
[  828.783406] ppc_notifier: mutex
[  828.783408] ppc_notifier: verify within
[  828.783411] ppc_notifier
[  828.783423] ppc_notifier
[  828.783424] ppc_notifier: mutex
[  828.783426] ppc_notifier: verify within
[  828.783428] ppc_notifier
[  828.783450] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.783454] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.783461] ppc_notifier
[  828.783463] ppc_notifier: mutex
[  828.783465] ppc_notifier: verify within
[  828.783468] ppc_notifier
[  828.783475] ppc_notifier
[  828.783476] ppc_notifier: mutex
[  828.783479] ppc_notifier: verify within
[  828.783481] ppc_notifier
[  828.783487] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.807458] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.807472] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.807479] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.807483] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.807489] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.807493] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.807499] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.807509] ppc_notifier
[  828.807512] ppc_notifier: mutex
[  828.807515] ppc_notifier: verify within
[  828.807518] ppc_notifier
[  828.807526] ppc_notifier
[  828.807528] ppc_notifier: mutex
[  828.807531] ppc_notifier: verify within
[  828.807534] ppc_notifier
[  828.807540] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.807544] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.807550] ppc_notifier
[  828.807552] ppc_notifier: mutex
[  828.807555] ppc_notifier: verify within
[  828.807557] ppc_notifier
[  828.807564] ppc_notifier
[  828.807566] ppc_notifier: mutex
[  828.807568] ppc_notifier: verify within
[  828.807571] ppc_notifier
[  828.807576] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.850918] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.852809] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.853884] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.853894] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.853900] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.853903] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.853908] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.853910] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.853915] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.853922] ppc_notifier
[  828.853924] ppc_notifier: mutex
[  828.853926] ppc_notifier: verify within
[  828.853928] ppc_notifier
[  828.853940] ppc_notifier
[  828.853942] ppc_notifier: mutex
[  828.853944] ppc_notifier: verify within
[  828.853946] ppc_notifier
[  828.853968] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.853972] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.853979] ppc_notifier
[  828.853981] ppc_notifier: mutex
[  828.853983] ppc_notifier: verify within
[  828.853986] ppc_notifier
[  828.853992] ppc_notifier
[  828.853994] ppc_notifier: mutex
[  828.853996] ppc_notifier: verify within
[  828.853999] ppc_notifier
[  828.854005] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.879200] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.879214] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.879220] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.879224] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.879229] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.879233] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.879239] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.879247] ppc_notifier
[  828.879249] ppc_notifier: mutex
[  828.879251] ppc_notifier: verify within
[  828.879254] ppc_notifier
[  828.879262] ppc_notifier
[  828.879264] ppc_notifier: mutex
[  828.879266] ppc_notifier: verify within
[  828.879269] ppc_notifier
[  828.879275] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.879279] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.879286] ppc_notifier
[  828.879288] ppc_notifier: mutex
[  828.879290] ppc_notifier: verify within
[  828.879293] ppc_notifier
[  828.879299] ppc_notifier
[  828.879301] ppc_notifier: mutex
[  828.879303] ppc_notifier: verify within
[  828.879306] ppc_notifier
[  828.879312] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.920342] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.922195] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.923261] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.923271] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.923276] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.923279] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.923284] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.923286] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.923291] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.923297] ppc_notifier
[  828.923299] ppc_notifier: mutex
[  828.923301] ppc_notifier: verify within
[  828.923303] ppc_notifier
[  828.923315] ppc_notifier
[  828.923317] ppc_notifier: mutex
[  828.923318] ppc_notifier: verify within
[  828.923320] ppc_notifier
[  828.923343] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.923347] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.923354] ppc_notifier
[  828.923356] ppc_notifier: mutex
[  828.923358] ppc_notifier: verify within
[  828.923361] ppc_notifier
[  828.923367] ppc_notifier
[  828.923369] ppc_notifier: mutex
[  828.923371] ppc_notifier: verify within
[  828.923374] ppc_notifier
[  828.923380] thermal_cdev_update: thermal cooling_device1: set to state 1
[  828.949473] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  828.949488] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  828.949495] get_target_state: thermal cooling_device2: cur_state=3D1
[  828.949499] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  828.949506] get_target_state: thermal cooling_device1: cur_state=3D1
[  828.949509] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  828.949515] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  828.949526] ppc_notifier
[  828.949529] ppc_notifier: mutex
[  828.949532] ppc_notifier: verify within
[  828.949535] ppc_notifier
[  828.949543] ppc_notifier
[  828.949545] ppc_notifier: mutex
[  828.949548] ppc_notifier: verify within
[  828.949550] ppc_notifier
[  828.949557] thermal_cdev_update: thermal cooling_device2: set to state 0
[  828.949561] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  828.949568] ppc_notifier
[  828.949569] ppc_notifier: mutex
[  828.949572] ppc_notifier: verify within
[  828.949574] ppc_notifier
[  828.949581] ppc_notifier
[  828.949583] ppc_notifier: mutex
[  828.949585] ppc_notifier: verify within
[  828.949588] ppc_notifier
[  828.949593] thermal_cdev_update: thermal cooling_device1: set to state 0
[  828.990459] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  828.994276] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  828.995404] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  828.995416] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  828.995423] get_target_state: thermal cooling_device2: cur_state=3D0
[  828.995425] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  828.995431] get_target_state: thermal cooling_device1: cur_state=3D0
[  828.995434] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  828.995438] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  828.995448] ppc_notifier
[  828.995450] ppc_notifier: mutex
[  828.995452] ppc_notifier: verify within
[  828.995454] ppc_notifier
[  828.995469] ppc_notifier
[  828.995471] ppc_notifier: mutex
[  828.995472] ppc_notifier: verify within
[  828.995474] ppc_notifier
[  828.995496] thermal_cdev_update: thermal cooling_device2: set to state 1
[  828.995501] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  828.995508] ppc_notifier
[  828.995510] ppc_notifier: mutex
[  828.995512] ppc_notifier: verify within
[  828.995515] ppc_notifier
[  828.995521] ppc_notifier
[  828.995523] ppc_notifier: mutex
[  828.995525] ppc_notifier: verify within
[  828.995528] ppc_notifier
[  828.995534] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.019585] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.019599] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.019605] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.019609] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.019615] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.019618] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.019625] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.019633] ppc_notifier
[  829.019636] ppc_notifier: mutex
[  829.019638] ppc_notifier: verify within
[  829.019641] ppc_notifier
[  829.019649] ppc_notifier
[  829.019651] ppc_notifier: mutex
[  829.019653] ppc_notifier: verify within
[  829.019656] ppc_notifier
[  829.019662] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.019666] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.019673] ppc_notifier
[  829.019675] ppc_notifier: mutex
[  829.019677] ppc_notifier: verify within
[  829.019680] ppc_notifier
[  829.019686] ppc_notifier
[  829.019688] ppc_notifier: mutex
[  829.019690] ppc_notifier: verify within
[  829.019693] ppc_notifier
[  829.019699] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.059915] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.061717] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.062793] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.062804] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.062810] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.062813] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.062818] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.062821] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.062825] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.062833] ppc_notifier
[  829.062834] ppc_notifier: mutex
[  829.062836] ppc_notifier: verify within
[  829.062839] ppc_notifier
[  829.062851] ppc_notifier
[  829.062852] ppc_notifier: mutex
[  829.062854] ppc_notifier: verify within
[  829.062856] ppc_notifier
[  829.062878] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.062882] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.062889] ppc_notifier
[  829.062891] ppc_notifier: mutex
[  829.062893] ppc_notifier: verify within
[  829.062896] ppc_notifier
[  829.062903] ppc_notifier
[  829.062904] ppc_notifier: mutex
[  829.062907] ppc_notifier: verify within
[  829.062909] ppc_notifier
[  829.062915] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.086625] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.086640] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.086646] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.086650] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.086656] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.086660] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.086666] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.086675] ppc_notifier
[  829.086678] ppc_notifier: mutex
[  829.086681] ppc_notifier: verify within
[  829.086684] ppc_notifier
[  829.086692] ppc_notifier
[  829.086694] ppc_notifier: mutex
[  829.086696] ppc_notifier: verify within
[  829.086699] ppc_notifier
[  829.086705] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.086709] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.086716] ppc_notifier
[  829.086718] ppc_notifier: mutex
[  829.086720] ppc_notifier: verify within
[  829.086723] ppc_notifier
[  829.086729] ppc_notifier
[  829.086731] ppc_notifier: mutex
[  829.086733] ppc_notifier: verify within
[  829.086736] ppc_notifier
[  829.086742] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.120609] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.122718] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.123790] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D92000
[  829.123800] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D0
[  829.123805] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.123808] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D0
[  829.123811] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.123814] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D0
[  829.254628] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.256579] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.257642] update_temperature: thermal thermal_zone1: last_temperature=
=3D92000, current_temperature=3D94000
[  829.257651] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.257655] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.257658] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.257662] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.257665] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.257669] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.257676] ppc_notifier
[  829.257677] ppc_notifier: mutex
[  829.257679] ppc_notifier: verify within
[  829.257681] ppc_notifier
[  829.257693] ppc_notifier
[  829.257694] ppc_notifier: mutex
[  829.257696] ppc_notifier: verify within
[  829.257698] ppc_notifier
[  829.257720] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.257724] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.257731] ppc_notifier
[  829.257733] ppc_notifier: mutex
[  829.257735] ppc_notifier: verify within
[  829.257738] ppc_notifier
[  829.257745] ppc_notifier
[  829.257746] ppc_notifier: mutex
[  829.257749] ppc_notifier: verify within
[  829.257751] ppc_notifier
[  829.257757] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.308166] update_temperature: thermal thermal_zone1: last_temperature=
=3D94000, current_temperature=3D91000
[  829.308179] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.308185] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.308189] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.308194] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.308198] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.308204] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.308212] ppc_notifier
[  829.308214] ppc_notifier: mutex
[  829.308217] ppc_notifier: verify within
[  829.308220] ppc_notifier
[  829.308227] ppc_notifier
[  829.308229] ppc_notifier: mutex
[  829.308231] ppc_notifier: verify within
[  829.308234] ppc_notifier
[  829.308240] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.308245] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.308251] ppc_notifier
[  829.308253] ppc_notifier: mutex
[  829.308255] ppc_notifier: verify within
[  829.308258] ppc_notifier
[  829.308265] ppc_notifier
[  829.308266] ppc_notifier: mutex
[  829.308269] ppc_notifier: verify within
[  829.308271] ppc_notifier
[  829.308277] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.343741] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.345576] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.346635] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.346644] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.346648] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.346651] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.346655] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.346658] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.346662] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.346668] ppc_notifier
[  829.346670] ppc_notifier: mutex
[  829.346672] ppc_notifier: verify within
[  829.346674] ppc_notifier
[  829.346684] ppc_notifier
[  829.346685] ppc_notifier: mutex
[  829.346687] ppc_notifier: verify within
[  829.346689] ppc_notifier
[  829.346711] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.346716] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.346722] ppc_notifier
[  829.346724] ppc_notifier: mutex
[  829.346726] ppc_notifier: verify within
[  829.346729] ppc_notifier
[  829.346736] ppc_notifier
[  829.346738] ppc_notifier: mutex
[  829.346740] ppc_notifier: verify within
[  829.346743] ppc_notifier
[  829.346748] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.372850] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.372863] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.372869] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.372873] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.372878] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.372882] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.372888] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.372895] ppc_notifier
[  829.372898] ppc_notifier: mutex
[  829.372900] ppc_notifier: verify within
[  829.372903] ppc_notifier
[  829.372911] ppc_notifier
[  829.372913] ppc_notifier: mutex
[  829.372915] ppc_notifier: verify within
[  829.372918] ppc_notifier
[  829.372924] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.372929] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.372935] ppc_notifier
[  829.372937] ppc_notifier: mutex
[  829.372939] ppc_notifier: verify within
[  829.372942] ppc_notifier
[  829.372948] ppc_notifier
[  829.372950] ppc_notifier: mutex
[  829.372952] ppc_notifier: verify within
[  829.372955] ppc_notifier
[  829.372961] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.408422] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.410125] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.411183] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.411192] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.411196] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.411199] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.411204] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.411206] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.411210] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.411216] ppc_notifier
[  829.411218] ppc_notifier: mutex
[  829.411220] ppc_notifier: verify within
[  829.411222] ppc_notifier
[  829.411232] ppc_notifier
[  829.411233] ppc_notifier: mutex
[  829.411235] ppc_notifier: verify within
[  829.411237] ppc_notifier
[  829.411259] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.411264] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.411271] ppc_notifier
[  829.411272] ppc_notifier: mutex
[  829.411275] ppc_notifier: verify within
[  829.411278] ppc_notifier
[  829.411284] ppc_notifier
[  829.411286] ppc_notifier: mutex
[  829.411288] ppc_notifier: verify within
[  829.411291] ppc_notifier
[  829.411297] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.438273] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.438285] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.438291] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.438295] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.438301] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.438305] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.438311] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.438318] ppc_notifier
[  829.438321] ppc_notifier: mutex
[  829.438323] ppc_notifier: verify within
[  829.438326] ppc_notifier
[  829.438334] ppc_notifier
[  829.438335] ppc_notifier: mutex
[  829.438338] ppc_notifier: verify within
[  829.438340] ppc_notifier
[  829.438346] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.438351] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.438357] ppc_notifier
[  829.438359] ppc_notifier: mutex
[  829.438361] ppc_notifier: verify within
[  829.438364] ppc_notifier
[  829.438371] ppc_notifier
[  829.438372] ppc_notifier: mutex
[  829.438375] ppc_notifier: verify within
[  829.438377] ppc_notifier
[  829.438383] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.481001] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.482891] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.483951] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.483962] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.483966] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.483969] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.483973] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.483976] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.483981] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.483988] ppc_notifier
[  829.483990] ppc_notifier: mutex
[  829.483992] ppc_notifier: verify within
[  829.483994] ppc_notifier
[  829.484040] ppc_notifier
[  829.484042] ppc_notifier: mutex
[  829.484045] ppc_notifier: verify within
[  829.484048] ppc_notifier
[  829.484070] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.484075] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.484082] ppc_notifier
[  829.484084] ppc_notifier: mutex
[  829.484086] ppc_notifier: verify within
[  829.484089] ppc_notifier
[  829.484095] ppc_notifier
[  829.484097] ppc_notifier: mutex
[  829.484099] ppc_notifier: verify within
[  829.484102] ppc_notifier
[  829.484108] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.511627] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.511640] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.511646] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.511650] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.511655] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.511659] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.511665] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.511673] ppc_notifier
[  829.511676] ppc_notifier: mutex
[  829.511678] ppc_notifier: verify within
[  829.511681] ppc_notifier
[  829.511689] ppc_notifier
[  829.511691] ppc_notifier: mutex
[  829.511693] ppc_notifier: verify within
[  829.511696] ppc_notifier
[  829.511702] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.511706] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.511713] ppc_notifier
[  829.511715] ppc_notifier: mutex
[  829.511717] ppc_notifier: verify within
[  829.511720] ppc_notifier
[  829.511726] ppc_notifier
[  829.511728] ppc_notifier: mutex
[  829.511730] ppc_notifier: verify within
[  829.511733] ppc_notifier
[  829.511739] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.555957] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.557974] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.559053] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.559065] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.559072] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.559075] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.559080] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.559083] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.559087] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.559097] ppc_notifier
[  829.559099] ppc_notifier: mutex
[  829.559101] ppc_notifier: verify within
[  829.559103] ppc_notifier
[  829.559117] ppc_notifier
[  829.559118] ppc_notifier: mutex
[  829.559120] ppc_notifier: verify within
[  829.559122] ppc_notifier
[  829.559144] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.559149] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.559156] ppc_notifier
[  829.559158] ppc_notifier: mutex
[  829.559160] ppc_notifier: verify within
[  829.559163] ppc_notifier
[  829.559169] ppc_notifier
[  829.559171] ppc_notifier: mutex
[  829.559173] ppc_notifier: verify within
[  829.559176] ppc_notifier
[  829.559182] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.581825] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.581838] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.581844] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.581848] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.581854] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.581858] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.581864] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.581872] ppc_notifier
[  829.581874] ppc_notifier: mutex
[  829.581877] ppc_notifier: verify within
[  829.581880] ppc_notifier
[  829.581888] ppc_notifier
[  829.581890] ppc_notifier: mutex
[  829.581892] ppc_notifier: verify within
[  829.581895] ppc_notifier
[  829.581901] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.581905] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.581912] ppc_notifier
[  829.581913] ppc_notifier: mutex
[  829.581916] ppc_notifier: verify within
[  829.581918] ppc_notifier
[  829.581925] ppc_notifier
[  829.581927] ppc_notifier: mutex
[  829.581929] ppc_notifier: verify within
[  829.581932] ppc_notifier
[  829.581938] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.624506] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.626575] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.627639] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.627649] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.627653] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.627656] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.627660] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.627663] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.627667] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.627673] ppc_notifier
[  829.627675] ppc_notifier: mutex
[  829.627677] ppc_notifier: verify within
[  829.627679] ppc_notifier
[  829.627689] ppc_notifier
[  829.627691] ppc_notifier: mutex
[  829.627692] ppc_notifier: verify within
[  829.627694] ppc_notifier
[  829.627717] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.627721] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.627728] ppc_notifier
[  829.627730] ppc_notifier: mutex
[  829.627732] ppc_notifier: verify within
[  829.627735] ppc_notifier
[  829.627741] ppc_notifier
[  829.627743] ppc_notifier: mutex
[  829.627745] ppc_notifier: verify within
[  829.627748] ppc_notifier
[  829.627754] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.650474] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.650489] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.650496] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.650500] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.650506] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.650510] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.650516] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.650526] ppc_notifier
[  829.650529] ppc_notifier: mutex
[  829.650532] ppc_notifier: verify within
[  829.650535] ppc_notifier
[  829.650543] ppc_notifier
[  829.650545] ppc_notifier: mutex
[  829.650547] ppc_notifier: verify within
[  829.650550] ppc_notifier
[  829.650556] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.650561] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.650567] ppc_notifier
[  829.650569] ppc_notifier: mutex
[  829.650571] ppc_notifier: verify within
[  829.650574] ppc_notifier
[  829.650581] ppc_notifier
[  829.650582] ppc_notifier: mutex
[  829.650585] ppc_notifier: verify within
[  829.650587] ppc_notifier
[  829.650593] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.694721] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.696603] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.697730] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.697741] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.697747] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.697750] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.697755] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.697757] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.697762] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.697770] ppc_notifier
[  829.697772] ppc_notifier: mutex
[  829.697774] ppc_notifier: verify within
[  829.697776] ppc_notifier
[  829.697789] ppc_notifier
[  829.697790] ppc_notifier: mutex
[  829.697792] ppc_notifier: verify within
[  829.697794] ppc_notifier
[  829.697816] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.697820] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.697827] ppc_notifier
[  829.697829] ppc_notifier: mutex
[  829.697831] ppc_notifier: verify within
[  829.697834] ppc_notifier
[  829.697841] ppc_notifier
[  829.697842] ppc_notifier: mutex
[  829.697845] ppc_notifier: verify within
[  829.697847] ppc_notifier
[  829.697853] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.720696] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.720711] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.720718] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.720722] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.720728] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.720731] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.720737] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.720747] ppc_notifier
[  829.720750] ppc_notifier: mutex
[  829.720753] ppc_notifier: verify within
[  829.720756] ppc_notifier
[  829.720764] ppc_notifier
[  829.720766] ppc_notifier: mutex
[  829.720768] ppc_notifier: verify within
[  829.720771] ppc_notifier
[  829.720777] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.720781] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.720788] ppc_notifier
[  829.720790] ppc_notifier: mutex
[  829.720792] ppc_notifier: verify within
[  829.720795] ppc_notifier
[  829.720801] ppc_notifier
[  829.720803] ppc_notifier: mutex
[  829.720805] ppc_notifier: verify within
[  829.720808] ppc_notifier
[  829.720814] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.760168] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.761954] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.763013] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.763022] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.763027] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.763030] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.763034] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.763037] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.763041] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.763048] ppc_notifier
[  829.763049] ppc_notifier: mutex
[  829.763051] ppc_notifier: verify within
[  829.763053] ppc_notifier
[  829.763064] ppc_notifier
[  829.763065] ppc_notifier: mutex
[  829.763067] ppc_notifier: verify within
[  829.763069] ppc_notifier
[  829.763091] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.763096] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.763102] ppc_notifier
[  829.763104] ppc_notifier: mutex
[  829.763106] ppc_notifier: verify within
[  829.763109] ppc_notifier
[  829.763116] ppc_notifier
[  829.763118] ppc_notifier: mutex
[  829.763120] ppc_notifier: verify within
[  829.763123] ppc_notifier
[  829.763128] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.784525] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.784537] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.784543] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.784547] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.784553] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.784556] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.784562] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.784570] ppc_notifier
[  829.784573] ppc_notifier: mutex
[  829.784575] ppc_notifier: verify within
[  829.784578] ppc_notifier
[  829.784586] ppc_notifier
[  829.784588] ppc_notifier: mutex
[  829.784590] ppc_notifier: verify within
[  829.784593] ppc_notifier
[  829.784599] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.784603] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.784610] ppc_notifier
[  829.784611] ppc_notifier: mutex
[  829.784614] ppc_notifier: verify within
[  829.784617] ppc_notifier
[  829.784623] ppc_notifier
[  829.784625] ppc_notifier: mutex
[  829.784627] ppc_notifier: verify within
[  829.784630] ppc_notifier
[  829.784636] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.828091] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.831474] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.832662] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.832674] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.832681] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.832684] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.832690] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.832693] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.832697] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.832706] ppc_notifier
[  829.832708] ppc_notifier: mutex
[  829.832710] ppc_notifier: verify within
[  829.832713] ppc_notifier
[  829.832726] ppc_notifier
[  829.832727] ppc_notifier: mutex
[  829.832729] ppc_notifier: verify within
[  829.832731] ppc_notifier
[  829.832753] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.832758] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.832765] ppc_notifier
[  829.832767] ppc_notifier: mutex
[  829.832769] ppc_notifier: verify within
[  829.832772] ppc_notifier
[  829.832778] ppc_notifier
[  829.832780] ppc_notifier: mutex
[  829.832782] ppc_notifier: verify within
[  829.832785] ppc_notifier
[  829.832791] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.853134] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.853147] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.853153] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.853157] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.853163] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.853167] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.853172] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.853181] ppc_notifier
[  829.853184] ppc_notifier: mutex
[  829.853186] ppc_notifier: verify within
[  829.853190] ppc_notifier
[  829.853197] ppc_notifier
[  829.853199] ppc_notifier: mutex
[  829.853201] ppc_notifier: verify within
[  829.853204] ppc_notifier
[  829.853210] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.853215] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.853221] ppc_notifier
[  829.853223] ppc_notifier: mutex
[  829.853225] ppc_notifier: verify within
[  829.853228] ppc_notifier
[  829.853234] ppc_notifier
[  829.853236] ppc_notifier: mutex
[  829.853238] ppc_notifier: verify within
[  829.853241] ppc_notifier
[  829.853247] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.898177] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.900307] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.901375] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.901386] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.901391] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.901394] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.901399] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.901402] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.901406] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.901413] ppc_notifier
[  829.901415] ppc_notifier: mutex
[  829.901417] ppc_notifier: verify within
[  829.901419] ppc_notifier
[  829.901431] ppc_notifier
[  829.901432] ppc_notifier: mutex
[  829.901434] ppc_notifier: verify within
[  829.901436] ppc_notifier
[  829.901458] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.901462] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.901469] ppc_notifier
[  829.901471] ppc_notifier: mutex
[  829.901473] ppc_notifier: verify within
[  829.901476] ppc_notifier
[  829.901483] ppc_notifier
[  829.901484] ppc_notifier: mutex
[  829.901487] ppc_notifier: verify within
[  829.901489] ppc_notifier
[  829.901495] thermal_cdev_update: thermal cooling_device1: set to state 1
[  829.924908] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  829.924920] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  829.924926] get_target_state: thermal cooling_device2: cur_state=3D1
[  829.924930] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  829.924936] get_target_state: thermal cooling_device1: cur_state=3D1
[  829.924939] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  829.924945] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  829.924953] ppc_notifier
[  829.924956] ppc_notifier: mutex
[  829.924958] ppc_notifier: verify within
[  829.924961] ppc_notifier
[  829.924969] ppc_notifier
[  829.924970] ppc_notifier: mutex
[  829.924973] ppc_notifier: verify within
[  829.924976] ppc_notifier
[  829.924982] thermal_cdev_update: thermal cooling_device2: set to state 0
[  829.924986] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  829.924992] ppc_notifier
[  829.924994] ppc_notifier: mutex
[  829.924997] ppc_notifier: verify within
[  829.924999] ppc_notifier
[  829.925006] ppc_notifier
[  829.925008] ppc_notifier: mutex
[  829.925010] ppc_notifier: verify within
[  829.925013] ppc_notifier
[  829.925018] thermal_cdev_update: thermal cooling_device1: set to state 0
[  829.977881] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  829.979638] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  829.980755] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  829.980767] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  829.980773] get_target_state: thermal cooling_device2: cur_state=3D0
[  829.980776] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  829.980782] get_target_state: thermal cooling_device1: cur_state=3D0
[  829.980784] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  829.980789] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  829.980799] ppc_notifier
[  829.980801] ppc_notifier: mutex
[  829.980803] ppc_notifier: verify within
[  829.980805] ppc_notifier
[  829.980819] ppc_notifier
[  829.980821] ppc_notifier: mutex
[  829.980822] ppc_notifier: verify within
[  829.980824] ppc_notifier
[  829.980847] thermal_cdev_update: thermal cooling_device2: set to state 1
[  829.980851] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  829.980858] ppc_notifier
[  829.980860] ppc_notifier: mutex
[  829.980862] ppc_notifier: verify within
[  829.980865] ppc_notifier
[  829.980871] ppc_notifier
[  829.980873] ppc_notifier: mutex
[  829.980875] ppc_notifier: verify within
[  829.980878] ppc_notifier
[  829.980884] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.002225] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.002241] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.002248] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.002252] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.002259] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.002263] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.002269] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.002279] ppc_notifier
[  830.002283] ppc_notifier: mutex
[  830.002285] ppc_notifier: verify within
[  830.002288] ppc_notifier
[  830.002296] ppc_notifier
[  830.002298] ppc_notifier: mutex
[  830.002301] ppc_notifier: verify within
[  830.002304] ppc_notifier
[  830.002310] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.002314] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.002320] ppc_notifier
[  830.002322] ppc_notifier: mutex
[  830.002325] ppc_notifier: verify within
[  830.002327] ppc_notifier
[  830.002334] ppc_notifier
[  830.002336] ppc_notifier: mutex
[  830.002338] ppc_notifier: verify within
[  830.002341] ppc_notifier
[  830.002346] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.045692] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.047358] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  830.048463] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.048474] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.048480] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.048483] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.048488] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.048491] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.048495] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.048504] ppc_notifier
[  830.048506] ppc_notifier: mutex
[  830.048508] ppc_notifier: verify within
[  830.048510] ppc_notifier
[  830.048522] ppc_notifier
[  830.048523] ppc_notifier: mutex
[  830.048524] ppc_notifier: verify within
[  830.048527] ppc_notifier
[  830.048549] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.048553] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.048560] ppc_notifier
[  830.048562] ppc_notifier: mutex
[  830.048564] ppc_notifier: verify within
[  830.048567] ppc_notifier
[  830.048573] ppc_notifier
[  830.048575] ppc_notifier: mutex
[  830.048577] ppc_notifier: verify within
[  830.048580] ppc_notifier
[  830.048586] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.069258] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.069271] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.069278] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.069282] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.069288] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.069292] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.069297] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.069306] ppc_notifier
[  830.069310] ppc_notifier: mutex
[  830.069312] ppc_notifier: verify within
[  830.069316] ppc_notifier
[  830.069324] ppc_notifier
[  830.069325] ppc_notifier: mutex
[  830.069328] ppc_notifier: verify within
[  830.069331] ppc_notifier
[  830.069336] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.069341] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.069347] ppc_notifier
[  830.069349] ppc_notifier: mutex
[  830.069351] ppc_notifier: verify within
[  830.069354] ppc_notifier
[  830.069361] ppc_notifier
[  830.069362] ppc_notifier: mutex
[  830.069365] ppc_notifier: verify within
[  830.069368] ppc_notifier
[  830.069373] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.138788] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.140811] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 47 51 N/A N/A N/A N/A N/A N/A
[  830.141902] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.141972] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.141979] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.141982] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.141987] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.141990] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.141994] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.142005] ppc_notifier
[  830.142006] ppc_notifier: mutex
[  830.142008] ppc_notifier: verify within
[  830.142011] ppc_notifier
[  830.142026] ppc_notifier
[  830.142027] ppc_notifier: mutex
[  830.142029] ppc_notifier: verify within
[  830.142031] ppc_notifier
[  830.142053] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.142058] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.142065] ppc_notifier
[  830.142067] ppc_notifier: mutex
[  830.142069] ppc_notifier: verify within
[  830.142072] ppc_notifier
[  830.142078] ppc_notifier
[  830.142080] ppc_notifier: mutex
[  830.142082] ppc_notifier: verify within
[  830.142085] ppc_notifier
[  830.142091] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.167845] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.167860] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.167867] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.167871] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.167878] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.167881] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.167887] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.167898] ppc_notifier
[  830.167901] ppc_notifier: mutex
[  830.167903] ppc_notifier: verify within
[  830.167907] ppc_notifier
[  830.167915] ppc_notifier
[  830.167917] ppc_notifier: mutex
[  830.167919] ppc_notifier: verify within
[  830.167922] ppc_notifier
[  830.167928] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.167932] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.167939] ppc_notifier
[  830.167941] ppc_notifier: mutex
[  830.167943] ppc_notifier: verify within
[  830.167946] ppc_notifier
[  830.167952] ppc_notifier
[  830.167954] ppc_notifier: mutex
[  830.167956] ppc_notifier: verify within
[  830.167959] ppc_notifier
[  830.167965] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.209690] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.211643] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.212744] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.212754] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.212759] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.212762] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.212766] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.212769] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.212773] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.212780] ppc_notifier
[  830.212782] ppc_notifier: mutex
[  830.212783] ppc_notifier: verify within
[  830.212786] ppc_notifier
[  830.212797] ppc_notifier
[  830.212798] ppc_notifier: mutex
[  830.212800] ppc_notifier: verify within
[  830.212802] ppc_notifier
[  830.212824] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.212829] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.212835] ppc_notifier
[  830.212837] ppc_notifier: mutex
[  830.212840] ppc_notifier: verify within
[  830.212842] ppc_notifier
[  830.212849] ppc_notifier
[  830.212851] ppc_notifier: mutex
[  830.212853] ppc_notifier: verify within
[  830.212856] ppc_notifier
[  830.212861] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.237205] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.237218] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.237223] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.237227] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.237233] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.237237] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.237243] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.237251] ppc_notifier
[  830.237253] ppc_notifier: mutex
[  830.237255] ppc_notifier: verify within
[  830.237258] ppc_notifier
[  830.237266] ppc_notifier
[  830.237268] ppc_notifier: mutex
[  830.237270] ppc_notifier: verify within
[  830.237273] ppc_notifier
[  830.237279] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.237283] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.237290] ppc_notifier
[  830.237292] ppc_notifier: mutex
[  830.237294] ppc_notifier: verify within
[  830.237297] ppc_notifier
[  830.237303] ppc_notifier
[  830.237305] ppc_notifier: mutex
[  830.237307] ppc_notifier: verify within
[  830.237310] ppc_notifier
[  830.237316] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.279061] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.281127] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.282253] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.282263] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.282268] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.282271] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.282275] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.282278] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.282282] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.282288] ppc_notifier
[  830.282290] ppc_notifier: mutex
[  830.282292] ppc_notifier: verify within
[  830.282294] ppc_notifier
[  830.282305] ppc_notifier
[  830.282306] ppc_notifier: mutex
[  830.282308] ppc_notifier: verify within
[  830.282310] ppc_notifier
[  830.282332] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.282337] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.282343] ppc_notifier
[  830.282345] ppc_notifier: mutex
[  830.282347] ppc_notifier: verify within
[  830.282350] ppc_notifier
[  830.282357] ppc_notifier
[  830.282359] ppc_notifier: mutex
[  830.282361] ppc_notifier: verify within
[  830.282364] ppc_notifier
[  830.282369] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.307427] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.307442] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.307449] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.307453] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.307459] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.307463] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.307469] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.307479] ppc_notifier
[  830.307482] ppc_notifier: mutex
[  830.307485] ppc_notifier: verify within
[  830.307488] ppc_notifier
[  830.307496] ppc_notifier
[  830.307498] ppc_notifier: mutex
[  830.307500] ppc_notifier: verify within
[  830.307503] ppc_notifier
[  830.307509] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.307513] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.307520] ppc_notifier
[  830.307522] ppc_notifier: mutex
[  830.307524] ppc_notifier: verify within
[  830.307527] ppc_notifier
[  830.307533] ppc_notifier
[  830.307535] ppc_notifier: mutex
[  830.307537] ppc_notifier: verify within
[  830.307540] ppc_notifier
[  830.307546] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.350067] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.351899] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.352994] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.353005] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.353011] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.353014] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.353019] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.353022] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.353026] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.353033] ppc_notifier
[  830.353035] ppc_notifier: mutex
[  830.353037] ppc_notifier: verify within
[  830.353039] ppc_notifier
[  830.353051] ppc_notifier
[  830.353053] ppc_notifier: mutex
[  830.353054] ppc_notifier: verify within
[  830.353056] ppc_notifier
[  830.353078] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.353083] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.353090] ppc_notifier
[  830.353091] ppc_notifier: mutex
[  830.353094] ppc_notifier: verify within
[  830.353097] ppc_notifier
[  830.353103] ppc_notifier
[  830.353105] ppc_notifier: mutex
[  830.353107] ppc_notifier: verify within
[  830.353110] ppc_notifier
[  830.353116] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.378360] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.378374] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.378381] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.378385] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.378391] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.378394] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.378400] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.378409] ppc_notifier
[  830.378412] ppc_notifier: mutex
[  830.378415] ppc_notifier: verify within
[  830.378418] ppc_notifier
[  830.378426] ppc_notifier
[  830.378427] ppc_notifier: mutex
[  830.378430] ppc_notifier: verify within
[  830.378433] ppc_notifier
[  830.378438] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.378443] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.378449] ppc_notifier
[  830.378451] ppc_notifier: mutex
[  830.378453] ppc_notifier: verify within
[  830.378456] ppc_notifier
[  830.378463] ppc_notifier
[  830.378464] ppc_notifier: mutex
[  830.378467] ppc_notifier: verify within
[  830.378470] ppc_notifier
[  830.378475] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.421851] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.423479] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.424574] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.424585] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.424591] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.424594] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.424599] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.424602] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.424606] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.424614] ppc_notifier
[  830.424616] ppc_notifier: mutex
[  830.424618] ppc_notifier: verify within
[  830.424620] ppc_notifier
[  830.424632] ppc_notifier
[  830.424633] ppc_notifier: mutex
[  830.424635] ppc_notifier: verify within
[  830.424637] ppc_notifier
[  830.424659] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.424664] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.424670] ppc_notifier
[  830.424672] ppc_notifier: mutex
[  830.424675] ppc_notifier: verify within
[  830.424677] ppc_notifier
[  830.424684] ppc_notifier
[  830.424686] ppc_notifier: mutex
[  830.424688] ppc_notifier: verify within
[  830.424691] ppc_notifier
[  830.424697] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.450391] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.450407] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.450414] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.450418] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.450424] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.450428] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.450434] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.450445] ppc_notifier
[  830.450449] ppc_notifier: mutex
[  830.450451] ppc_notifier: verify within
[  830.450454] ppc_notifier
[  830.450463] ppc_notifier
[  830.450465] ppc_notifier: mutex
[  830.450467] ppc_notifier: verify within
[  830.450470] ppc_notifier
[  830.450476] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.450481] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.450487] ppc_notifier
[  830.450489] ppc_notifier: mutex
[  830.450491] ppc_notifier: verify within
[  830.450494] ppc_notifier
[  830.450501] ppc_notifier
[  830.450502] ppc_notifier: mutex
[  830.450505] ppc_notifier: verify within
[  830.450507] ppc_notifier
[  830.450513] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.494363] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.496373] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.497444] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.497455] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.497459] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.497463] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.497467] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.497469] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.497474] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.497481] ppc_notifier
[  830.497483] ppc_notifier: mutex
[  830.497485] ppc_notifier: verify within
[  830.497487] ppc_notifier
[  830.497498] ppc_notifier
[  830.497499] ppc_notifier: mutex
[  830.497501] ppc_notifier: verify within
[  830.497503] ppc_notifier
[  830.497525] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.497530] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.497536] ppc_notifier
[  830.497538] ppc_notifier: mutex
[  830.497541] ppc_notifier: verify within
[  830.497543] ppc_notifier
[  830.497550] ppc_notifier
[  830.497552] ppc_notifier: mutex
[  830.497554] ppc_notifier: verify within
[  830.497557] ppc_notifier
[  830.497563] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.522700] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.522715] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.522722] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.522726] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.522732] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.522736] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.522742] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.522752] ppc_notifier
[  830.522756] ppc_notifier: mutex
[  830.522758] ppc_notifier: verify within
[  830.522761] ppc_notifier
[  830.522770] ppc_notifier
[  830.522772] ppc_notifier: mutex
[  830.522774] ppc_notifier: verify within
[  830.522777] ppc_notifier
[  830.522783] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.522787] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.522794] ppc_notifier
[  830.522796] ppc_notifier: mutex
[  830.522798] ppc_notifier: verify within
[  830.522801] ppc_notifier
[  830.522807] ppc_notifier
[  830.522809] ppc_notifier: mutex
[  830.522811] ppc_notifier: verify within
[  830.522814] ppc_notifier
[  830.522820] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.565384] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.567132] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.568229] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.568241] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.568249] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.568252] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.568256] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.568259] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.568264] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.568271] ppc_notifier
[  830.568273] ppc_notifier: mutex
[  830.568275] ppc_notifier: verify within
[  830.568277] ppc_notifier
[  830.568289] ppc_notifier
[  830.568290] ppc_notifier: mutex
[  830.568292] ppc_notifier: verify within
[  830.568294] ppc_notifier
[  830.568317] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.568321] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.568328] ppc_notifier
[  830.568330] ppc_notifier: mutex
[  830.568332] ppc_notifier: verify within
[  830.568335] ppc_notifier
[  830.568341] ppc_notifier
[  830.568343] ppc_notifier: mutex
[  830.568345] ppc_notifier: verify within
[  830.568348] ppc_notifier
[  830.568354] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.592113] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.592127] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.592133] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.592137] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.592143] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.592147] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.592153] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.592161] ppc_notifier
[  830.592164] ppc_notifier: mutex
[  830.592167] ppc_notifier: verify within
[  830.592170] ppc_notifier
[  830.592177] ppc_notifier
[  830.592179] ppc_notifier: mutex
[  830.592181] ppc_notifier: verify within
[  830.592184] ppc_notifier
[  830.592190] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.592194] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.592201] ppc_notifier
[  830.592203] ppc_notifier: mutex
[  830.592205] ppc_notifier: verify within
[  830.592208] ppc_notifier
[  830.592214] ppc_notifier
[  830.592216] ppc_notifier: mutex
[  830.592218] ppc_notifier: verify within
[  830.592221] ppc_notifier
[  830.592227] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.639526] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.641494] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.642578] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.642590] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.642596] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.642600] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.642605] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.642607] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.642612] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.642621] ppc_notifier
[  830.642623] ppc_notifier: mutex
[  830.642625] ppc_notifier: verify within
[  830.642627] ppc_notifier
[  830.642641] ppc_notifier
[  830.642643] ppc_notifier: mutex
[  830.642644] ppc_notifier: verify within
[  830.642647] ppc_notifier
[  830.642669] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.642674] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.642680] ppc_notifier
[  830.642682] ppc_notifier: mutex
[  830.642684] ppc_notifier: verify within
[  830.642687] ppc_notifier
[  830.642694] ppc_notifier
[  830.642696] ppc_notifier: mutex
[  830.642698] ppc_notifier: verify within
[  830.642701] ppc_notifier
[  830.642707] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.667024] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.667040] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.667048] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.667052] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.667058] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.667062] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.667068] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.667078] ppc_notifier
[  830.667081] ppc_notifier: mutex
[  830.667084] ppc_notifier: verify within
[  830.667087] ppc_notifier
[  830.667095] ppc_notifier
[  830.667097] ppc_notifier: mutex
[  830.667099] ppc_notifier: verify within
[  830.667102] ppc_notifier
[  830.667108] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.667113] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.667119] ppc_notifier
[  830.667121] ppc_notifier: mutex
[  830.667123] ppc_notifier: verify within
[  830.667126] ppc_notifier
[  830.667133] ppc_notifier
[  830.667134] ppc_notifier: mutex
[  830.667137] ppc_notifier: verify within
[  830.667140] ppc_notifier
[  830.667145] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.715250] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.753826] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.754944] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D94000
[  830.754956] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.754963] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.754966] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.754971] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.754974] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.754979] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.754989] ppc_notifier
[  830.754991] ppc_notifier: mutex
[  830.754993] ppc_notifier: verify within
[  830.754995] ppc_notifier
[  830.755010] ppc_notifier
[  830.755011] ppc_notifier: mutex
[  830.755013] ppc_notifier: verify within
[  830.755015] ppc_notifier
[  830.755037] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.755042] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.755048] ppc_notifier
[  830.755050] ppc_notifier: mutex
[  830.755052] ppc_notifier: verify within
[  830.755055] ppc_notifier
[  830.755062] ppc_notifier
[  830.755064] ppc_notifier: mutex
[  830.755066] ppc_notifier: verify within
[  830.755069] ppc_notifier
[  830.755074] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.789249] update_temperature: thermal thermal_zone1: last_temperature=
=3D94000, current_temperature=3D91000
[  830.789265] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.789272] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.789276] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.789283] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.789286] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.789292] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.789303] ppc_notifier
[  830.789306] ppc_notifier: mutex
[  830.789309] ppc_notifier: verify within
[  830.789312] ppc_notifier
[  830.789320] ppc_notifier
[  830.789321] ppc_notifier: mutex
[  830.789324] ppc_notifier: verify within
[  830.789327] ppc_notifier
[  830.789332] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.789337] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.789343] ppc_notifier
[  830.789345] ppc_notifier: mutex
[  830.789347] ppc_notifier: verify within
[  830.789350] ppc_notifier
[  830.789357] ppc_notifier
[  830.789358] ppc_notifier: mutex
[  830.789361] ppc_notifier: verify within
[  830.789363] ppc_notifier
[  830.789369] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.832713] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.834448] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.835516] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.835528] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.835534] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.835537] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.835542] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.835545] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.835549] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.835558] ppc_notifier
[  830.835560] ppc_notifier: mutex
[  830.835562] ppc_notifier: verify within
[  830.835564] ppc_notifier
[  830.835577] ppc_notifier
[  830.835578] ppc_notifier: mutex
[  830.835580] ppc_notifier: verify within
[  830.835582] ppc_notifier
[  830.835604] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.835609] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.835616] ppc_notifier
[  830.835617] ppc_notifier: mutex
[  830.835620] ppc_notifier: verify within
[  830.835623] ppc_notifier
[  830.835629] ppc_notifier
[  830.835631] ppc_notifier: mutex
[  830.835633] ppc_notifier: verify within
[  830.835636] ppc_notifier
[  830.835642] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.859455] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.859471] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.859478] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.859482] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.859488] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.859492] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.859498] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.859508] ppc_notifier
[  830.859511] ppc_notifier: mutex
[  830.859514] ppc_notifier: verify within
[  830.859517] ppc_notifier
[  830.859525] ppc_notifier
[  830.859527] ppc_notifier: mutex
[  830.859529] ppc_notifier: verify within
[  830.859532] ppc_notifier
[  830.859538] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.859542] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.859549] ppc_notifier
[  830.859551] ppc_notifier: mutex
[  830.859553] ppc_notifier: verify within
[  830.859556] ppc_notifier
[  830.859562] ppc_notifier
[  830.859564] ppc_notifier: mutex
[  830.859566] ppc_notifier: verify within
[  830.859569] ppc_notifier
[  830.859575] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.901312] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.903077] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.904177] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.904188] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.904194] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.904197] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.904201] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.904204] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.904208] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.904216] ppc_notifier
[  830.904218] ppc_notifier: mutex
[  830.904220] ppc_notifier: verify within
[  830.904222] ppc_notifier
[  830.904236] ppc_notifier
[  830.904238] ppc_notifier: mutex
[  830.904240] ppc_notifier: verify within
[  830.904242] ppc_notifier
[  830.904264] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.904268] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.904275] ppc_notifier
[  830.904277] ppc_notifier: mutex
[  830.904279] ppc_notifier: verify within
[  830.904282] ppc_notifier
[  830.904289] ppc_notifier
[  830.904291] ppc_notifier: mutex
[  830.904293] ppc_notifier: verify within
[  830.904296] ppc_notifier
[  830.904302] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.926488] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.926506] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.926514] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.926518] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.926525] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.926528] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.926535] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.926547] ppc_notifier
[  830.926550] ppc_notifier: mutex
[  830.926553] ppc_notifier: verify within
[  830.926556] ppc_notifier
[  830.926566] ppc_notifier
[  830.926568] ppc_notifier: mutex
[  830.926570] ppc_notifier: verify within
[  830.926573] ppc_notifier
[  830.926579] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.926583] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.926590] ppc_notifier
[  830.926592] ppc_notifier: mutex
[  830.926594] ppc_notifier: verify within
[  830.926597] ppc_notifier
[  830.926603] ppc_notifier
[  830.926605] ppc_notifier: mutex
[  830.926607] ppc_notifier: verify within
[  830.926610] ppc_notifier
[  830.926616] thermal_cdev_update: thermal cooling_device1: set to state 0
[  830.969163] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  830.971088] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  830.972190] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  830.972202] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  830.972208] get_target_state: thermal cooling_device2: cur_state=3D0
[  830.972211] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  830.972216] get_target_state: thermal cooling_device1: cur_state=3D0
[  830.972219] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  830.972223] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  830.972232] ppc_notifier
[  830.972234] ppc_notifier: mutex
[  830.972236] ppc_notifier: verify within
[  830.972238] ppc_notifier
[  830.972253] ppc_notifier
[  830.972254] ppc_notifier: mutex
[  830.972257] ppc_notifier: verify within
[  830.972259] ppc_notifier
[  830.972281] thermal_cdev_update: thermal cooling_device2: set to state 1
[  830.972285] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  830.972292] ppc_notifier
[  830.972294] ppc_notifier: mutex
[  830.972296] ppc_notifier: verify within
[  830.972299] ppc_notifier
[  830.972306] ppc_notifier
[  830.972308] ppc_notifier: mutex
[  830.972310] ppc_notifier: verify within
[  830.972313] ppc_notifier
[  830.972319] thermal_cdev_update: thermal cooling_device1: set to state 1
[  830.994265] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  830.994279] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  830.994286] get_target_state: thermal cooling_device2: cur_state=3D1
[  830.994290] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  830.994296] get_target_state: thermal cooling_device1: cur_state=3D1
[  830.994300] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  830.994306] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  830.994315] ppc_notifier
[  830.994318] ppc_notifier: mutex
[  830.994321] ppc_notifier: verify within
[  830.994324] ppc_notifier
[  830.994332] ppc_notifier
[  830.994333] ppc_notifier: mutex
[  830.994336] ppc_notifier: verify within
[  830.994339] ppc_notifier
[  830.994345] thermal_cdev_update: thermal cooling_device2: set to state 0
[  830.994349] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  830.994355] ppc_notifier
[  830.994357] ppc_notifier: mutex
[  830.994360] ppc_notifier: verify within
[  830.994362] ppc_notifier
[  830.994369] ppc_notifier
[  830.994371] ppc_notifier: mutex
[  830.994373] ppc_notifier: verify within
[  830.994376] ppc_notifier
[  830.994381] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.032218] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.034053] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.035114] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.035124] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.035128] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.035131] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.035135] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.035137] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.035142] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.035148] ppc_notifier
[  831.035150] ppc_notifier: mutex
[  831.035152] ppc_notifier: verify within
[  831.035154] ppc_notifier
[  831.035165] ppc_notifier
[  831.035166] ppc_notifier: mutex
[  831.035168] ppc_notifier: verify within
[  831.035170] ppc_notifier
[  831.035192] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.035197] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.035204] ppc_notifier
[  831.035205] ppc_notifier: mutex
[  831.035208] ppc_notifier: verify within
[  831.035211] ppc_notifier
[  831.035217] ppc_notifier
[  831.035219] ppc_notifier: mutex
[  831.035221] ppc_notifier: verify within
[  831.035224] ppc_notifier
[  831.035230] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.061300] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.061313] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.061319] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.061322] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.061328] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.061332] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.061338] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.061346] ppc_notifier
[  831.061348] ppc_notifier: mutex
[  831.061350] ppc_notifier: verify within
[  831.061353] ppc_notifier
[  831.061361] ppc_notifier
[  831.061363] ppc_notifier: mutex
[  831.061365] ppc_notifier: verify within
[  831.061368] ppc_notifier
[  831.061374] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.061378] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.061385] ppc_notifier
[  831.061386] ppc_notifier: mutex
[  831.061389] ppc_notifier: verify within
[  831.061392] ppc_notifier
[  831.061398] ppc_notifier
[  831.061400] ppc_notifier: mutex
[  831.061402] ppc_notifier: verify within
[  831.061405] ppc_notifier
[  831.061410] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.105595] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.107463] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.108576] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.108588] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.108594] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.108597] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.108602] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.108605] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.108610] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.108619] ppc_notifier
[  831.108621] ppc_notifier: mutex
[  831.108622] ppc_notifier: verify within
[  831.108625] ppc_notifier
[  831.108638] ppc_notifier
[  831.108640] ppc_notifier: mutex
[  831.108641] ppc_notifier: verify within
[  831.108643] ppc_notifier
[  831.108666] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.108670] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.108677] ppc_notifier
[  831.108679] ppc_notifier: mutex
[  831.108681] ppc_notifier: verify within
[  831.108684] ppc_notifier
[  831.108690] ppc_notifier
[  831.108692] ppc_notifier: mutex
[  831.108694] ppc_notifier: verify within
[  831.108697] ppc_notifier
[  831.108703] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.131480] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.131493] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.131498] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.131502] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.131508] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.131512] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.131518] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.131526] ppc_notifier
[  831.131529] ppc_notifier: mutex
[  831.131531] ppc_notifier: verify within
[  831.131534] ppc_notifier
[  831.131542] ppc_notifier
[  831.131544] ppc_notifier: mutex
[  831.131546] ppc_notifier: verify within
[  831.131549] ppc_notifier
[  831.131555] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.131560] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.131566] ppc_notifier
[  831.131568] ppc_notifier: mutex
[  831.131570] ppc_notifier: verify within
[  831.131573] ppc_notifier
[  831.131579] ppc_notifier
[  831.131581] ppc_notifier: mutex
[  831.131583] ppc_notifier: verify within
[  831.131586] ppc_notifier
[  831.131592] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.176616] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.178286] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.179361] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.179374] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.179380] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.179383] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.179388] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.179390] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.179395] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.179404] ppc_notifier
[  831.179406] ppc_notifier: mutex
[  831.179408] ppc_notifier: verify within
[  831.179410] ppc_notifier
[  831.179424] ppc_notifier
[  831.179425] ppc_notifier: mutex
[  831.179427] ppc_notifier: verify within
[  831.179429] ppc_notifier
[  831.179451] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.179456] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.179463] ppc_notifier
[  831.179464] ppc_notifier: mutex
[  831.179467] ppc_notifier: verify within
[  831.179470] ppc_notifier
[  831.179476] ppc_notifier
[  831.179478] ppc_notifier: mutex
[  831.179480] ppc_notifier: verify within
[  831.179483] ppc_notifier
[  831.179489] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.201715] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.201730] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.201738] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.201742] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.201747] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.201751] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.201757] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.201767] ppc_notifier
[  831.201771] ppc_notifier: mutex
[  831.201773] ppc_notifier: verify within
[  831.201776] ppc_notifier
[  831.201785] ppc_notifier
[  831.201787] ppc_notifier: mutex
[  831.201789] ppc_notifier: verify within
[  831.201792] ppc_notifier
[  831.201798] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.201802] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.201809] ppc_notifier
[  831.201811] ppc_notifier: mutex
[  831.201813] ppc_notifier: verify within
[  831.201816] ppc_notifier
[  831.201822] ppc_notifier
[  831.201824] ppc_notifier: mutex
[  831.201826] ppc_notifier: verify within
[  831.201829] ppc_notifier
[  831.201835] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.250680] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.252638] thinkpad_acpi: temperatures (Celsius): 100 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.253766] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.253777] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.253783] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.253786] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.253790] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.253793] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.253797] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.253804] ppc_notifier
[  831.253806] ppc_notifier: mutex
[  831.253808] ppc_notifier: verify within
[  831.253810] ppc_notifier
[  831.253822] ppc_notifier
[  831.253824] ppc_notifier: mutex
[  831.253825] ppc_notifier: verify within
[  831.253827] ppc_notifier
[  831.253849] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.253854] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.253861] ppc_notifier
[  831.253862] ppc_notifier: mutex
[  831.253865] ppc_notifier: verify within
[  831.253867] ppc_notifier
[  831.253874] ppc_notifier
[  831.253876] ppc_notifier: mutex
[  831.253878] ppc_notifier: verify within
[  831.253881] ppc_notifier
[  831.253887] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.274254] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.274269] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.274276] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.274280] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.274286] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.274290] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.274296] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.274305] ppc_notifier
[  831.274309] ppc_notifier: mutex
[  831.274312] ppc_notifier: verify within
[  831.274315] ppc_notifier
[  831.274323] ppc_notifier
[  831.274325] ppc_notifier: mutex
[  831.274327] ppc_notifier: verify within
[  831.274330] ppc_notifier
[  831.274336] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.274341] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.274347] ppc_notifier
[  831.274349] ppc_notifier: mutex
[  831.274351] ppc_notifier: verify within
[  831.274354] ppc_notifier
[  831.274360] ppc_notifier
[  831.274362] ppc_notifier: mutex
[  831.274364] ppc_notifier: verify within
[  831.274367] ppc_notifier
[  831.274373] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.319309] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.321451] thinkpad_acpi: temperatures (Celsius): 100 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.322535] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.322546] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.322551] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.322554] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.322559] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.322562] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.322566] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.322575] ppc_notifier
[  831.322577] ppc_notifier: mutex
[  831.322578] ppc_notifier: verify within
[  831.322581] ppc_notifier
[  831.322594] ppc_notifier
[  831.322595] ppc_notifier: mutex
[  831.322597] ppc_notifier: verify within
[  831.322599] ppc_notifier
[  831.322621] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.322626] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.322632] ppc_notifier
[  831.322634] ppc_notifier: mutex
[  831.322637] ppc_notifier: verify within
[  831.322639] ppc_notifier
[  831.322646] ppc_notifier
[  831.322648] ppc_notifier: mutex
[  831.322650] ppc_notifier: verify within
[  831.322653] ppc_notifier
[  831.322659] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.345985] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.345998] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.346004] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.346008] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.346014] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.346018] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.346024] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.346032] ppc_notifier
[  831.346035] ppc_notifier: mutex
[  831.346037] ppc_notifier: verify within
[  831.346040] ppc_notifier
[  831.346048] ppc_notifier
[  831.346050] ppc_notifier: mutex
[  831.346052] ppc_notifier: verify within
[  831.346055] ppc_notifier
[  831.346061] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.346065] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.346072] ppc_notifier
[  831.346074] ppc_notifier: mutex
[  831.346076] ppc_notifier: verify within
[  831.346079] ppc_notifier
[  831.346085] ppc_notifier
[  831.346087] ppc_notifier: mutex
[  831.346089] ppc_notifier: verify within
[  831.346092] ppc_notifier
[  831.346098] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.395076] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.397708] thinkpad_acpi: temperatures (Celsius): 100 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.398800] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.398813] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.398820] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.398823] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.398828] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.398831] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.398836] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.398846] ppc_notifier
[  831.398847] ppc_notifier: mutex
[  831.398849] ppc_notifier: verify within
[  831.398852] ppc_notifier
[  831.398867] ppc_notifier
[  831.398869] ppc_notifier: mutex
[  831.398870] ppc_notifier: verify within
[  831.398872] ppc_notifier
[  831.398895] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.398899] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.398906] ppc_notifier
[  831.398908] ppc_notifier: mutex
[  831.398910] ppc_notifier: verify within
[  831.398913] ppc_notifier
[  831.398919] ppc_notifier
[  831.398921] ppc_notifier: mutex
[  831.398923] ppc_notifier: verify within
[  831.398926] ppc_notifier
[  831.398932] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.420302] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.420319] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.420327] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.420331] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.420338] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.420342] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.420348] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.420360] ppc_notifier
[  831.420364] ppc_notifier: mutex
[  831.420366] ppc_notifier: verify within
[  831.420370] ppc_notifier
[  831.420378] ppc_notifier
[  831.420380] ppc_notifier: mutex
[  831.420382] ppc_notifier: verify within
[  831.420385] ppc_notifier
[  831.420391] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.420395] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.420402] ppc_notifier
[  831.420404] ppc_notifier: mutex
[  831.420406] ppc_notifier: verify within
[  831.420409] ppc_notifier
[  831.420415] ppc_notifier
[  831.420417] ppc_notifier: mutex
[  831.420419] ppc_notifier: verify within
[  831.420422] ppc_notifier
[  831.420428] thermal_cdev_update: thermal cooling_device1: set to state 0
[  831.470738] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  831.472821] thinkpad_acpi: temperatures (Celsius): 100 49 N/A 79 33 N/A =
33 N/A 46 51 N/A N/A N/A N/A N/A N/A
[  831.473899] update_temperature: thermal thermal_zone1: last_temperature=
=3D91000, current_temperature=3D93000
[  831.473910] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D1,throttle=3D1
[  831.473915] get_target_state: thermal cooling_device2: cur_state=3D0
[  831.473918] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D0, target=3D1
[  831.473923] get_target_state: thermal cooling_device1: cur_state=3D0
[  831.473926] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D0, target=3D1
[  831.473930] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D1
[  831.473939] ppc_notifier
[  831.473941] ppc_notifier: mutex
[  831.473943] ppc_notifier: verify within
[  831.473945] ppc_notifier
[  831.473959] ppc_notifier
[  831.473960] ppc_notifier: mutex
[  831.473962] ppc_notifier: verify within
[  831.473964] ppc_notifier
[  831.473986] thermal_cdev_update: thermal cooling_device2: set to state 1
[  831.473990] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D1
[  831.473997] ppc_notifier
[  831.473999] ppc_notifier: mutex
[  831.474001] ppc_notifier: verify within
[  831.474004] ppc_notifier
[  831.474011] ppc_notifier
[  831.474013] ppc_notifier: mutex
[  831.474015] ppc_notifier: verify within
[  831.474018] ppc_notifier
[  831.474023] thermal_cdev_update: thermal cooling_device1: set to state 1
[  831.497648] update_temperature: thermal thermal_zone1: last_temperature=
=3D93000, current_temperature=3D91000
[  831.497662] thermal_zone_trip_update: thermal thermal_zone1: Trip1[type=
=3D1,temp=3D92500]:trend=3D2,throttle=3D0
[  831.497668] get_target_state: thermal cooling_device2: cur_state=3D1
[  831.497672] thermal_zone_trip_update: thermal cooling_device2: old_targe=
t=3D1, target=3D0
[  831.497678] get_target_state: thermal cooling_device1: cur_state=3D1
[  831.497682] thermal_zone_trip_update: thermal cooling_device1: old_targe=
t=3D1, target=3D0
[  831.497687] thermal_cdev_update: thermal cooling_device2: zone1->target=
=3D0
[  831.497696] ppc_notifier
[  831.497698] ppc_notifier: mutex
[  831.497701] ppc_notifier: verify within
[  831.497704] ppc_notifier
[  831.497712] ppc_notifier
[  831.497714] ppc_notifier: mutex
[  831.497716] ppc_notifier: verify within
[  831.497719] ppc_notifier
[  831.497725] thermal_cdev_update: thermal cooling_device2: set to state 0
[  831.497729] thermal_cdev_update: thermal cooling_device1: zone1->target=
=3D0
[  831.497736] ppc_notifier
[  831.497738] ppc_notifier: mutex
[  831.497740] ppc_notifier: verify within
[  831.497743] ppc_notifier
[  831.497749] ppc_notifier
[  831.497751] ppc_notifier: mutex
[  831.497753] ppc_notifier: verify within
[  831.497756] ppc_notifier
[  831.497762] thermal_cdev_update: thermal cooling_device1: set to state 0


Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgd4I8ACgkQMOfwapXb+vJtrgCgt4aJ5mUfchc1yaQyX6TpqRFI
VYwAoKOuOAmDV2qCpKnbdBncf+wLrS11
=AtsA
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
