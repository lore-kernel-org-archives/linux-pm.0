From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 15:21:04 +0100
Message-ID: <20161105142103.GA3705@amd>
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
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478354115.19557.17.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > So we seem to have thermal or ACPI regression in v4.9-rc3.
> > > >=20
> > > It is possible. Can you add either add printk
> > > in=A0acpi_processor_ppc_has_changed() or use ftrace and see do you
> > > get to
> > > these functions
> > >=20
> > > acpi_processor_ppc_init()
> > > acpi_processor_ppc_has_changed()
> > > acpi_processor_ppc_notifier()
> > >=20
> > > ?
> >=20
> > Yes, these seem to be called. Here's the log:

Ok, burnP6 pushes cpu to 102C rather quickly. dmesg is below.

Thanks,
							Pavel

cpu:  scaling 1.0 1.0 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.0 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
temp:  82 [65, 82, 65, 44, 66, 33, 33, 44, 51]
fan:  2874
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  85 [82, 85, 82, 44, 69, 33, 33, 44, 51]
fan:  2874
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  91 [91, 87, 91, 44, 72, 33, 33, 44, 51]
fan:  3151
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  94 [94, 88, 94, 44, 74, 33, 33, 44, 51]
fan:  3151
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  96 [96, 90, 96, 44, 76, 33, 33, 44, 52]
fan:  3531
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  98 [98, 91, 98, 45, 78, 33, 33, 44, 52]
fan:  3566
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  100 [100, 92, 100, 44, 79, 33, 33, 44, 52]
fan:  3575
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  101 [101, 93, 101, 44, 81, 33, 33, 44, 52]
fan:  3594
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  102 [102, 93, 102, 45, 82, 33, 33, 44, 53]
fan:  3596
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  102 [102, 91, 102, 44, 83, 33, 33, 44, 53]
fan:  3598
cpu:  scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
      scaling 1.0 1.8 1.8 cpuinfo 1.0 1.8 1.8 bios 1.8
temp:  101 [101, 78, 101, 45, 83, 33, 33, 44, 54]
fan:  3599
cpu:  scaling 1.0 1.0 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
      scaling 1.0 1.0 1.8 cpuinfo 1.0 1.0 1.8 bios 1.8
temp:  84 [84, 75, 84, 45, 81, 33, 33, 44, 54]


[   21.594684] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   21.703638] NFSD: starting 90-second grace period (net c5015600)
[   27.941612] ppc_notifier
[   27.944682] ppc_notifier: mutex
[   27.947639] ppc =3D 0
[   27.950576] ppc_notifier: verify within
[   27.953522] ppc =3D 0 freq-limit 1833000
[   27.956474] ppc_notifier
[   27.961414] ppc_notifier
[   27.963050] ppc_notifier: mutex
[   27.964674] ppc =3D 0
[   27.966246] ppc_notifier: verify within
[   27.967808] ppc =3D 0 freq-limit 1833000
[   27.969404] ppc_notifier
[   32.974593] iwl3945 0000:03:00.0: loaded firmware version 15.32.2.9
[   46.298794] wlan0: authenticate with 00:00:00:00:00:01
[   46.303301] wlan0: send auth to 00:00:00:00:00:01 (try 1/3)
[   46.305173] wlan0: authenticated
[   46.308558] wlan0: associate with 00:00:00:00:00:01 (try 1/3)
[   46.311352] wlan0: RX AssocResp from 00:00:00:00:00:01 (capab=3D0x401 st=
atus=3D0 aid=3D4)
[   46.313568] wlan0: associated
[   80.213718] acpi_cpufreq: get_cur_freq_on_cpu (0)
[   80.213744] acpi_cpufreq: get_cur_val =3D 1555
[   80.213746] acpi_cpufreq: cur freq =3D 1000000
[   80.215276] acpi_cpufreq: get_cur_freq_on_cpu (1)
[   80.215280] acpi_cpufreq: get_cur_val =3D 2077
[   80.215282] acpi_cpufreq: cur freq =3D 1333000
[   85.233419] acpi_cpufreq: get_cur_freq_on_cpu (0)
[   85.233441] acpi_cpufreq: get_cur_val =3D 1555
[   85.233444] acpi_cpufreq: cur freq =3D 1000000
[   85.235230] acpi_cpufreq: get_cur_freq_on_cpu (1)
[   85.235235] acpi_cpufreq: get_cur_val =3D 1555
[   85.235238] acpi_cpufreq: cur freq =3D 1000000
[   90.241835] acpi_cpufreq: get_cur_freq_on_cpu (0)
[   90.241841] acpi_cpufreq: get_cur_val =3D 2860
[   90.241843] acpi_cpufreq: cur freq =3D 1833000
[   90.242820] acpi_cpufreq: get_cur_freq_on_cpu (1)
[   90.242825] acpi_cpufreq: get_cur_val =3D 2860
[   90.242826] acpi_cpufreq: cur freq =3D 1833000
[   95.249622] acpi_cpufreq: get_cur_freq_on_cpu (0)
[   95.249628] acpi_cpufreq: get_cur_val =3D 2860
[   95.249630] acpi_cpufreq: cur freq =3D 1833000
[   95.250608] acpi_cpufreq: get_cur_freq_on_cpu (1)
[   95.250613] acpi_cpufreq: get_cur_val =3D 2860
[   95.250614] acpi_cpufreq: cur freq =3D 1833000
[  100.257505] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  100.257510] acpi_cpufreq: get_cur_val =3D 1555
[  100.257513] acpi_cpufreq: cur freq =3D 1000000
[  100.258490] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  100.258496] acpi_cpufreq: get_cur_val =3D 2860
[  100.258497] acpi_cpufreq: cur freq =3D 1833000
[  105.265742] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  105.265747] acpi_cpufreq: get_cur_val =3D 1555
[  105.265750] acpi_cpufreq: cur freq =3D 1000000
[  105.266727] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  105.266732] acpi_cpufreq: get_cur_val =3D 2860
[  105.266733] acpi_cpufreq: cur freq =3D 1833000
[  110.273478] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  110.273484] acpi_cpufreq: get_cur_val =3D 1555
[  110.273487] acpi_cpufreq: cur freq =3D 1000000
[  110.274465] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  110.274470] acpi_cpufreq: get_cur_val =3D 2860
[  110.274472] acpi_cpufreq: cur freq =3D 1833000
[  115.281809] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  115.281815] acpi_cpufreq: get_cur_val =3D 1555
[  115.281817] acpi_cpufreq: cur freq =3D 1000000
[  115.282794] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  115.282798] acpi_cpufreq: get_cur_val =3D 2860
[  115.282800] acpi_cpufreq: cur freq =3D 1833000
[  116.526026] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  116.527759] thinkpad_acpi: temperatures (Celsius): 99 44 N/A 78 33 N/A 3=
3 N/A 44 52 N/A N/A N/A N/A N/A N/A
[  120.289567] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  120.289573] acpi_cpufreq: get_cur_val =3D 1555
[  120.289575] acpi_cpufreq: cur freq =3D 1000000
[  120.290554] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  120.290559] acpi_cpufreq: get_cur_val =3D 2860
[  120.290560] acpi_cpufreq: cur freq =3D 1833000
[  125.297572] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  125.297578] acpi_cpufreq: get_cur_val =3D 1555
[  125.297580] acpi_cpufreq: cur freq =3D 1000000
[  125.298559] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  125.298564] acpi_cpufreq: get_cur_val =3D 2860
[  125.298565] acpi_cpufreq: cur freq =3D 1833000
[  126.467360] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  126.469369] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  126.470448] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  126.470452] acpi_cpufreq: get_cur_val =3D 1555
[  126.470454] acpi_cpufreq: cur freq =3D 1000000
[  126.470463] ppc_notifier
[  126.470465] ppc_notifier: mutex
[  126.470467] ppc =3D 0
[  126.470468] ppc_notifier: verify within
[  126.470470] ppc =3D 0 freq-limit 1833000
[  126.470472] ppc_notifier
[  126.470477] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  126.470481] acpi_cpufreq: get_cur_val =3D 2860
[  126.470482] acpi_cpufreq: cur freq =3D 1833000
[  126.470484] ppc_notifier
[  126.470485] ppc_notifier: mutex
[  126.470487] ppc =3D 0
[  126.470488] ppc_notifier: verify within
[  126.470490] ppc =3D 0 freq-limit 1833000
[  126.470492] ppc_notifier
[  126.470519] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  126.470521] acpi_cpufreq: get_cur_val =3D 1555
[  126.470523] acpi_cpufreq: cur freq =3D 1000000
[  126.470525] ppc_notifier
[  126.470527] ppc_notifier: mutex
[  126.470529] ppc =3D 0
[  126.470531] ppc_notifier: verify within
[  126.470533] ppc =3D 0 freq-limit 1833000
[  126.470536] ppc_notifier
[  126.470541] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  126.470544] acpi_cpufreq: get_cur_val =3D 2077
[  126.470546] acpi_cpufreq: cur freq =3D 1333000
[  126.470548] ppc_notifier
[  126.470550] ppc_notifier: mutex
[  126.470552] ppc =3D 0
[  126.470554] ppc_notifier: verify within
[  126.470556] ppc =3D 0 freq-limit 1833000
[  126.470559] ppc_notifier
[  126.505093] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  126.505096] acpi_cpufreq: get_cur_val =3D 2077
[  126.505098] acpi_cpufreq: cur freq =3D 1333000
[  126.505101] ppc_notifier
[  126.505103] ppc_notifier: mutex
[  126.505106] ppc =3D 0
[  126.505107] ppc_notifier: verify within
[  126.505110] ppc =3D 0 freq-limit 1833000
[  126.505113] ppc_notifier
[  126.505118] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  126.505122] acpi_cpufreq: get_cur_val =3D 2077
[  126.505124] acpi_cpufreq: cur freq =3D 1333000
[  126.505126] ppc_notifier
[  126.505128] ppc_notifier: mutex
[  126.505130] ppc =3D 0
[  126.505132] ppc_notifier: verify within
[  126.505134] ppc =3D 0 freq-limit 1833000
[  126.505137] ppc_notifier
[  126.505146] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  126.505149] acpi_cpufreq: get_cur_val =3D 2077
[  126.505150] acpi_cpufreq: cur freq =3D 1333000
[  126.505152] ppc_notifier
[  126.505154] ppc_notifier: mutex
[  126.505157] ppc =3D 0
[  126.505158] ppc_notifier: verify within
[  126.505160] ppc =3D 0 freq-limit 1833000
[  126.505163] ppc_notifier
[  126.505168] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  126.505172] acpi_cpufreq: get_cur_val =3D 2077
[  126.505174] acpi_cpufreq: cur freq =3D 1333000
[  126.505176] ppc_notifier
[  126.505177] ppc_notifier: mutex
[  126.505180] ppc =3D 0
[  126.505182] ppc_notifier: verify within
[  126.505184] ppc =3D 0 freq-limit 1833000
[  126.505187] ppc_notifier
[  126.558014] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  126.559687] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  127.005268] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  127.007142] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  127.008228] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.008231] acpi_cpufreq: get_cur_val =3D 2860
[  127.008233] acpi_cpufreq: cur freq =3D 1833000
[  127.008235] ppc_notifier
[  127.008236] ppc_notifier: mutex
[  127.008238] ppc =3D 0
[  127.008240] ppc_notifier: verify within
[  127.008241] ppc =3D 0 freq-limit 1833000
[  127.008244] ppc_notifier
[  127.008252] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.008256] acpi_cpufreq: get_cur_val =3D 2860
[  127.008257] acpi_cpufreq: cur freq =3D 1833000
[  127.008259] ppc_notifier
[  127.008260] ppc_notifier: mutex
[  127.008262] ppc =3D 0
[  127.008263] ppc_notifier: verify within
[  127.008265] ppc =3D 0 freq-limit 1833000
[  127.008267] ppc_notifier
[  127.008292] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.008294] acpi_cpufreq: get_cur_val =3D 2077
[  127.008296] acpi_cpufreq: cur freq =3D 1333000
[  127.008298] ppc_notifier
[  127.008300] ppc_notifier: mutex
[  127.008302] ppc =3D 0
[  127.008304] ppc_notifier: verify within
[  127.008306] ppc =3D 0 freq-limit 1833000
[  127.008309] ppc_notifier
[  127.008314] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.008318] acpi_cpufreq: get_cur_val =3D 2077
[  127.008320] acpi_cpufreq: cur freq =3D 1333000
[  127.008322] ppc_notifier
[  127.008323] ppc_notifier: mutex
[  127.008326] ppc =3D 0
[  127.008328] ppc_notifier: verify within
[  127.008330] ppc =3D 0 freq-limit 1833000
[  127.008333] ppc_notifier
[  127.046234] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.046238] acpi_cpufreq: get_cur_val =3D 2077
[  127.046240] acpi_cpufreq: cur freq =3D 1333000
[  127.046243] ppc_notifier
[  127.046245] ppc_notifier: mutex
[  127.046248] ppc =3D 0
[  127.046250] ppc_notifier: verify within
[  127.046252] ppc =3D 0 freq-limit 1833000
[  127.046255] ppc_notifier
[  127.046261] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.046266] acpi_cpufreq: get_cur_val =3D 2077
[  127.046268] acpi_cpufreq: cur freq =3D 1333000
[  127.046270] ppc_notifier
[  127.046271] ppc_notifier: mutex
[  127.046274] ppc =3D 0
[  127.046275] ppc_notifier: verify within
[  127.046278] ppc =3D 0 freq-limit 1833000
[  127.046281] ppc_notifier
[  127.046290] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.046292] acpi_cpufreq: get_cur_val =3D 2077
[  127.046294] acpi_cpufreq: cur freq =3D 1333000
[  127.046296] ppc_notifier
[  127.046297] ppc_notifier: mutex
[  127.046300] ppc =3D 0
[  127.046302] ppc_notifier: verify within
[  127.046304] ppc =3D 0 freq-limit 1833000
[  127.046307] ppc_notifier
[  127.046312] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.046315] acpi_cpufreq: get_cur_val =3D 2077
[  127.046317] acpi_cpufreq: cur freq =3D 1333000
[  127.046319] ppc_notifier
[  127.046321] ppc_notifier: mutex
[  127.046323] ppc =3D 0
[  127.046325] ppc_notifier: verify within
[  127.046327] ppc =3D 0 freq-limit 1833000
[  127.046330] ppc_notifier
[  127.104690] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  127.106559] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  127.417826] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  127.419836] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  127.420923] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.420926] acpi_cpufreq: get_cur_val =3D 2860
[  127.420927] acpi_cpufreq: cur freq =3D 1833000
[  127.420929] ppc_notifier
[  127.420931] ppc_notifier: mutex
[  127.420933] ppc =3D 0
[  127.420934] ppc_notifier: verify within
[  127.420936] ppc =3D 0 freq-limit 1833000
[  127.420938] ppc_notifier
[  127.420947] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.420950] acpi_cpufreq: get_cur_val =3D 2860
[  127.420951] acpi_cpufreq: cur freq =3D 1833000
[  127.420953] ppc_notifier
[  127.420954] ppc_notifier: mutex
[  127.420956] ppc =3D 0
[  127.420957] ppc_notifier: verify within
[  127.420959] ppc =3D 0 freq-limit 1833000
[  127.420961] ppc_notifier
[  127.420986] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.420989] acpi_cpufreq: get_cur_val =3D 2077
[  127.420991] acpi_cpufreq: cur freq =3D 1333000
[  127.420993] ppc_notifier
[  127.420994] ppc_notifier: mutex
[  127.420997] ppc =3D 0
[  127.420999] ppc_notifier: verify within
[  127.421001] ppc =3D 0 freq-limit 1833000
[  127.421004] ppc_notifier
[  127.421009] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.421012] acpi_cpufreq: get_cur_val =3D 2077
[  127.421014] acpi_cpufreq: cur freq =3D 1333000
[  127.421016] ppc_notifier
[  127.421018] ppc_notifier: mutex
[  127.421020] ppc =3D 0
[  127.421022] ppc_notifier: verify within
[  127.421024] ppc =3D 0 freq-limit 1833000
[  127.421027] ppc_notifier
[  127.457222] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.457226] acpi_cpufreq: get_cur_val =3D 2077
[  127.457228] acpi_cpufreq: cur freq =3D 1333000
[  127.457230] ppc_notifier
[  127.457232] ppc_notifier: mutex
[  127.457235] ppc =3D 0
[  127.457237] ppc_notifier: verify within
[  127.457239] ppc =3D 0 freq-limit 1833000
[  127.457242] ppc_notifier
[  127.457248] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.457252] acpi_cpufreq: get_cur_val =3D 2077
[  127.457254] acpi_cpufreq: cur freq =3D 1333000
[  127.457256] ppc_notifier
[  127.457257] ppc_notifier: mutex
[  127.457260] ppc =3D 0
[  127.457262] ppc_notifier: verify within
[  127.457264] ppc =3D 0 freq-limit 1833000
[  127.457267] ppc_notifier
[  127.457276] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  127.457278] acpi_cpufreq: get_cur_val =3D 2077
[  127.457280] acpi_cpufreq: cur freq =3D 1333000
[  127.457282] ppc_notifier
[  127.457284] ppc_notifier: mutex
[  127.457286] ppc =3D 0
[  127.457288] ppc_notifier: verify within
[  127.457290] ppc =3D 0 freq-limit 1833000
[  127.457293] ppc_notifier
[  127.457298] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  127.457301] acpi_cpufreq: get_cur_val =3D 2077
[  127.457303] acpi_cpufreq: cur freq =3D 1333000
[  127.457305] ppc_notifier
[  127.457307] ppc_notifier: mutex
[  127.457309] ppc =3D 0
[  127.457311] ppc_notifier: verify within
[  127.457313] ppc =3D 0 freq-limit 1833000
[  127.457316] ppc_notifier
[  127.510139] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  127.512244] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  128.090784] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  128.092644] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  128.093720] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.093724] acpi_cpufreq: get_cur_val =3D 2860
[  128.093726] acpi_cpufreq: cur freq =3D 1833000
[  128.093729] ppc_notifier
[  128.093731] ppc_notifier: mutex
[  128.093733] ppc =3D 0
[  128.093734] ppc_notifier: verify within
[  128.093736] ppc =3D 0 freq-limit 1833000
[  128.093738] ppc_notifier
[  128.093751] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.093755] acpi_cpufreq: get_cur_val =3D 2860
[  128.093756] acpi_cpufreq: cur freq =3D 1833000
[  128.093758] ppc_notifier
[  128.093759] ppc_notifier: mutex
[  128.093761] ppc =3D 0
[  128.093762] ppc_notifier: verify within
[  128.093764] ppc =3D 0 freq-limit 1833000
[  128.093766] ppc_notifier
[  128.093792] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.093794] acpi_cpufreq: get_cur_val =3D 2077
[  128.093796] acpi_cpufreq: cur freq =3D 1333000
[  128.093798] ppc_notifier
[  128.093800] ppc_notifier: mutex
[  128.093802] ppc =3D 0
[  128.093804] ppc_notifier: verify within
[  128.093806] ppc =3D 0 freq-limit 1833000
[  128.093809] ppc_notifier
[  128.093814] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.093818] acpi_cpufreq: get_cur_val =3D 2077
[  128.093819] acpi_cpufreq: cur freq =3D 1333000
[  128.093821] ppc_notifier
[  128.093823] ppc_notifier: mutex
[  128.093826] ppc =3D 0
[  128.093827] ppc_notifier: verify within
[  128.093829] ppc =3D 0 freq-limit 1833000
[  128.093832] ppc_notifier
[  128.130842] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.130846] acpi_cpufreq: get_cur_val =3D 2077
[  128.130848] acpi_cpufreq: cur freq =3D 1333000
[  128.130850] ppc_notifier
[  128.130852] ppc_notifier: mutex
[  128.130855] ppc =3D 0
[  128.130857] ppc_notifier: verify within
[  128.130859] ppc =3D 0 freq-limit 1833000
[  128.130862] ppc_notifier
[  128.130868] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.130872] acpi_cpufreq: get_cur_val =3D 2077
[  128.130874] acpi_cpufreq: cur freq =3D 1333000
[  128.130876] ppc_notifier
[  128.130878] ppc_notifier: mutex
[  128.130880] ppc =3D 0
[  128.130882] ppc_notifier: verify within
[  128.130884] ppc =3D 0 freq-limit 1833000
[  128.130887] ppc_notifier
[  128.130896] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.130898] acpi_cpufreq: get_cur_val =3D 2077
[  128.130900] acpi_cpufreq: cur freq =3D 1333000
[  128.130902] ppc_notifier
[  128.130904] ppc_notifier: mutex
[  128.130906] ppc =3D 0
[  128.130908] ppc_notifier: verify within
[  128.130910] ppc =3D 0 freq-limit 1833000
[  128.130913] ppc_notifier
[  128.130918] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.130922] acpi_cpufreq: get_cur_val =3D 2077
[  128.130923] acpi_cpufreq: cur freq =3D 1333000
[  128.130925] ppc_notifier
[  128.130927] ppc_notifier: mutex
[  128.130930] ppc =3D 0
[  128.130931] ppc_notifier: verify within
[  128.130933] ppc =3D 0 freq-limit 1833000
[  128.130936] ppc_notifier
[  128.181419] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  128.183070] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  128.415711] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  128.417636] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  128.418692] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.418695] acpi_cpufreq: get_cur_val =3D 2860
[  128.418697] acpi_cpufreq: cur freq =3D 1833000
[  128.418699] ppc_notifier
[  128.418701] ppc_notifier: mutex
[  128.418703] ppc =3D 0
[  128.418704] ppc_notifier: verify within
[  128.418706] ppc =3D 0 freq-limit 1833000
[  128.418708] ppc_notifier
[  128.418718] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.418721] acpi_cpufreq: get_cur_val =3D 2860
[  128.418723] acpi_cpufreq: cur freq =3D 1833000
[  128.418724] ppc_notifier
[  128.418725] ppc_notifier: mutex
[  128.418727] ppc =3D 0
[  128.418728] ppc_notifier: verify within
[  128.418730] ppc =3D 0 freq-limit 1833000
[  128.418732] ppc_notifier
[  128.418757] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.418760] acpi_cpufreq: get_cur_val =3D 2077
[  128.418762] acpi_cpufreq: cur freq =3D 1333000
[  128.418764] ppc_notifier
[  128.418765] ppc_notifier: mutex
[  128.418768] ppc =3D 0
[  128.418770] ppc_notifier: verify within
[  128.418772] ppc =3D 0 freq-limit 1833000
[  128.418775] ppc_notifier
[  128.418780] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.418783] acpi_cpufreq: get_cur_val =3D 2077
[  128.418785] acpi_cpufreq: cur freq =3D 1333000
[  128.418787] ppc_notifier
[  128.418789] ppc_notifier: mutex
[  128.418791] ppc =3D 0
[  128.418793] ppc_notifier: verify within
[  128.418795] ppc =3D 0 freq-limit 1833000
[  128.418798] ppc_notifier
[  128.457450] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.457454] acpi_cpufreq: get_cur_val =3D 2077
[  128.457456] acpi_cpufreq: cur freq =3D 1333000
[  128.457459] ppc_notifier
[  128.457461] ppc_notifier: mutex
[  128.457464] ppc =3D 0
[  128.457466] ppc_notifier: verify within
[  128.457468] ppc =3D 0 freq-limit 1833000
[  128.457471] ppc_notifier
[  128.457476] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.457480] acpi_cpufreq: get_cur_val =3D 2077
[  128.457482] acpi_cpufreq: cur freq =3D 1333000
[  128.457484] ppc_notifier
[  128.457486] ppc_notifier: mutex
[  128.457489] ppc =3D 0
[  128.457490] ppc_notifier: verify within
[  128.457492] ppc =3D 0 freq-limit 1833000
[  128.457495] ppc_notifier
[  128.457504] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.457507] acpi_cpufreq: get_cur_val =3D 2077
[  128.457509] acpi_cpufreq: cur freq =3D 1333000
[  128.457511] ppc_notifier
[  128.457512] ppc_notifier: mutex
[  128.457515] ppc =3D 0
[  128.457516] ppc_notifier: verify within
[  128.457519] ppc =3D 0 freq-limit 1833000
[  128.457521] ppc_notifier
[  128.457526] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.457530] acpi_cpufreq: get_cur_val =3D 2077
[  128.457532] acpi_cpufreq: cur freq =3D 1333000
[  128.457534] ppc_notifier
[  128.457535] ppc_notifier: mutex
[  128.457538] ppc =3D 0
[  128.457540] ppc_notifier: verify within
[  128.457542] ppc =3D 0 freq-limit 1833000
[  128.457545] ppc_notifier
[  128.508019] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  128.509687] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  128.760441] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  128.762220] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 81 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  128.763263] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.763266] acpi_cpufreq: get_cur_val =3D 2860
[  128.763267] acpi_cpufreq: cur freq =3D 1833000
[  128.763269] ppc_notifier
[  128.763271] ppc_notifier: mutex
[  128.763273] ppc =3D 0
[  128.763274] ppc_notifier: verify within
[  128.763276] ppc =3D 0 freq-limit 1833000
[  128.763278] ppc_notifier
[  128.763286] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.763290] acpi_cpufreq: get_cur_val =3D 2860
[  128.763291] acpi_cpufreq: cur freq =3D 1833000
[  128.763293] ppc_notifier
[  128.763294] ppc_notifier: mutex
[  128.763296] ppc =3D 0
[  128.763297] ppc_notifier: verify within
[  128.763299] ppc =3D 0 freq-limit 1833000
[  128.763301] ppc_notifier
[  128.763326] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.763328] acpi_cpufreq: get_cur_val =3D 2077
[  128.763330] acpi_cpufreq: cur freq =3D 1333000
[  128.763332] ppc_notifier
[  128.763334] ppc_notifier: mutex
[  128.763336] ppc =3D 0
[  128.763338] ppc_notifier: verify within
[  128.763340] ppc =3D 0 freq-limit 1833000
[  128.763343] ppc_notifier
[  128.763348] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.763352] acpi_cpufreq: get_cur_val =3D 2077
[  128.763354] acpi_cpufreq: cur freq =3D 1333000
[  128.763356] ppc_notifier
[  128.763357] ppc_notifier: mutex
[  128.763360] ppc =3D 0
[  128.763362] ppc_notifier: verify within
[  128.763364] ppc =3D 0 freq-limit 1833000
[  128.763367] ppc_notifier
[  128.798203] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.798206] acpi_cpufreq: get_cur_val =3D 2077
[  128.798208] acpi_cpufreq: cur freq =3D 1333000
[  128.798211] ppc_notifier
[  128.798213] ppc_notifier: mutex
[  128.798216] ppc =3D 0
[  128.798217] ppc_notifier: verify within
[  128.798220] ppc =3D 0 freq-limit 1833000
[  128.798223] ppc_notifier
[  128.798228] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.798232] acpi_cpufreq: get_cur_val =3D 2077
[  128.798234] acpi_cpufreq: cur freq =3D 1333000
[  128.798236] ppc_notifier
[  128.798238] ppc_notifier: mutex
[  128.798240] ppc =3D 0
[  128.798242] ppc_notifier: verify within
[  128.798244] ppc =3D 0 freq-limit 1833000
[  128.798247] ppc_notifier
[  128.798256] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  128.798258] acpi_cpufreq: get_cur_val =3D 2077
[  128.798260] acpi_cpufreq: cur freq =3D 1333000
[  128.798262] ppc_notifier
[  128.798264] ppc_notifier: mutex
[  128.798266] ppc =3D 0
[  128.798268] ppc_notifier: verify within
[  128.798270] ppc =3D 0 freq-limit 1833000
[  128.798273] ppc_notifier
[  128.798278] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  128.798282] acpi_cpufreq: get_cur_val =3D 2077
[  128.798284] acpi_cpufreq: cur freq =3D 1333000
[  128.798286] ppc_notifier
[  128.798287] ppc_notifier: mutex
[  128.798290] ppc =3D 0
[  128.798291] ppc_notifier: verify within
[  128.798294] ppc =3D 0 freq-limit 1833000
[  128.798296] ppc_notifier
[  128.850394] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  128.852036] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  129.142309] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  129.143992] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  129.145083] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.145087] acpi_cpufreq: get_cur_val =3D 2860
[  129.145089] acpi_cpufreq: cur freq =3D 1833000
[  129.145092] ppc_notifier
[  129.145094] ppc_notifier: mutex
[  129.145096] ppc =3D 0
[  129.145097] ppc_notifier: verify within
[  129.145099] ppc =3D 0 freq-limit 1833000
[  129.145101] ppc_notifier
[  129.145114] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.145118] acpi_cpufreq: get_cur_val =3D 2860
[  129.145119] acpi_cpufreq: cur freq =3D 1833000
[  129.145121] ppc_notifier
[  129.145122] ppc_notifier: mutex
[  129.145124] ppc =3D 0
[  129.145125] ppc_notifier: verify within
[  129.145127] ppc =3D 0 freq-limit 1833000
[  129.145129] ppc_notifier
[  129.145155] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.145157] acpi_cpufreq: get_cur_val =3D 2077
[  129.145159] acpi_cpufreq: cur freq =3D 1333000
[  129.145161] ppc_notifier
[  129.145163] ppc_notifier: mutex
[  129.145165] ppc =3D 0
[  129.145167] ppc_notifier: verify within
[  129.145169] ppc =3D 0 freq-limit 1833000
[  129.145172] ppc_notifier
[  129.145177] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.145180] acpi_cpufreq: get_cur_val =3D 2077
[  129.145182] acpi_cpufreq: cur freq =3D 1333000
[  129.145184] ppc_notifier
[  129.145186] ppc_notifier: mutex
[  129.145188] ppc =3D 0
[  129.145190] ppc_notifier: verify within
[  129.145192] ppc =3D 0 freq-limit 1833000
[  129.145195] ppc_notifier
[  129.182378] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.182382] acpi_cpufreq: get_cur_val =3D 2077
[  129.182384] acpi_cpufreq: cur freq =3D 1333000
[  129.182386] ppc_notifier
[  129.182389] ppc_notifier: mutex
[  129.182391] ppc =3D 0
[  129.182393] ppc_notifier: verify within
[  129.182395] ppc =3D 0 freq-limit 1833000
[  129.182399] ppc_notifier
[  129.182404] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.182408] acpi_cpufreq: get_cur_val =3D 2077
[  129.182410] acpi_cpufreq: cur freq =3D 1333000
[  129.182412] ppc_notifier
[  129.182414] ppc_notifier: mutex
[  129.182416] ppc =3D 0
[  129.182418] ppc_notifier: verify within
[  129.182420] ppc =3D 0 freq-limit 1833000
[  129.182423] ppc_notifier
[  129.182432] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.182434] acpi_cpufreq: get_cur_val =3D 2077
[  129.182436] acpi_cpufreq: cur freq =3D 1333000
[  129.182438] ppc_notifier
[  129.182440] ppc_notifier: mutex
[  129.182442] ppc =3D 0
[  129.182444] ppc_notifier: verify within
[  129.182446] ppc =3D 0 freq-limit 1833000
[  129.182449] ppc_notifier
[  129.182454] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.182458] acpi_cpufreq: get_cur_val =3D 2077
[  129.182460] acpi_cpufreq: cur freq =3D 1333000
[  129.182461] ppc_notifier
[  129.182463] ppc_notifier: mutex
[  129.182466] ppc =3D 0
[  129.182467] ppc_notifier: verify within
[  129.182470] ppc =3D 0 freq-limit 1833000
[  129.182472] ppc_notifier
[  129.229804] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  129.231923] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  129.461729] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  129.463402] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  129.464492] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.464495] acpi_cpufreq: get_cur_val =3D 2860
[  129.464496] acpi_cpufreq: cur freq =3D 1833000
[  129.464499] ppc_notifier
[  129.464500] ppc_notifier: mutex
[  129.464503] ppc =3D 0
[  129.464504] ppc_notifier: verify within
[  129.464506] ppc =3D 0 freq-limit 1833000
[  129.464508] ppc_notifier
[  129.464517] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.464521] acpi_cpufreq: get_cur_val =3D 2860
[  129.464522] acpi_cpufreq: cur freq =3D 1833000
[  129.464524] ppc_notifier
[  129.464525] ppc_notifier: mutex
[  129.464527] ppc =3D 0
[  129.464528] ppc_notifier: verify within
[  129.464530] ppc =3D 0 freq-limit 1833000
[  129.464532] ppc_notifier
[  129.464557] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.464559] acpi_cpufreq: get_cur_val =3D 2077
[  129.464561] acpi_cpufreq: cur freq =3D 1333000
[  129.464563] ppc_notifier
[  129.464565] ppc_notifier: mutex
[  129.464568] ppc =3D 0
[  129.464569] ppc_notifier: verify within
[  129.464572] ppc =3D 0 freq-limit 1833000
[  129.464574] ppc_notifier
[  129.464580] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.464583] acpi_cpufreq: get_cur_val =3D 2077
[  129.464585] acpi_cpufreq: cur freq =3D 1333000
[  129.464587] ppc_notifier
[  129.464589] ppc_notifier: mutex
[  129.464591] ppc =3D 0
[  129.464593] ppc_notifier: verify within
[  129.464595] ppc =3D 0 freq-limit 1833000
[  129.464598] ppc_notifier
[  129.503434] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.503437] acpi_cpufreq: get_cur_val =3D 2077
[  129.503440] acpi_cpufreq: cur freq =3D 1333000
[  129.503442] ppc_notifier
[  129.503444] ppc_notifier: mutex
[  129.503447] ppc =3D 0
[  129.503449] ppc_notifier: verify within
[  129.503451] ppc =3D 0 freq-limit 1833000
[  129.503454] ppc_notifier
[  129.503460] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.503464] acpi_cpufreq: get_cur_val =3D 2077
[  129.503466] acpi_cpufreq: cur freq =3D 1333000
[  129.503468] ppc_notifier
[  129.503469] ppc_notifier: mutex
[  129.503472] ppc =3D 0
[  129.503474] ppc_notifier: verify within
[  129.503476] ppc =3D 0 freq-limit 1833000
[  129.503479] ppc_notifier
[  129.503488] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.503490] acpi_cpufreq: get_cur_val =3D 2077
[  129.503492] acpi_cpufreq: cur freq =3D 1333000
[  129.503494] ppc_notifier
[  129.503496] ppc_notifier: mutex
[  129.503498] ppc =3D 0
[  129.503500] ppc_notifier: verify within
[  129.503502] ppc =3D 0 freq-limit 1833000
[  129.503505] ppc_notifier
[  129.503510] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.503513] acpi_cpufreq: get_cur_val =3D 2077
[  129.503515] acpi_cpufreq: cur freq =3D 1333000
[  129.503517] ppc_notifier
[  129.503519] ppc_notifier: mutex
[  129.503521] ppc =3D 0
[  129.503523] ppc_notifier: verify within
[  129.503525] ppc =3D 0 freq-limit 1833000
[  129.503528] ppc_notifier
[  129.554808] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  129.556865] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  129.832480] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  129.834230] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  129.835276] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.835278] acpi_cpufreq: get_cur_val =3D 2860
[  129.835280] acpi_cpufreq: cur freq =3D 1833000
[  129.835282] ppc_notifier
[  129.835283] ppc_notifier: mutex
[  129.835285] ppc =3D 0
[  129.835286] ppc_notifier: verify within
[  129.835288] ppc =3D 0 freq-limit 1833000
[  129.835290] ppc_notifier
[  129.835299] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.835302] acpi_cpufreq: get_cur_val =3D 2860
[  129.835304] acpi_cpufreq: cur freq =3D 1833000
[  129.835305] ppc_notifier
[  129.835307] ppc_notifier: mutex
[  129.835308] ppc =3D 0
[  129.835310] ppc_notifier: verify within
[  129.835311] ppc =3D 0 freq-limit 1833000
[  129.835313] ppc_notifier
[  129.835339] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.835341] acpi_cpufreq: get_cur_val =3D 2077
[  129.835343] acpi_cpufreq: cur freq =3D 1333000
[  129.835345] ppc_notifier
[  129.835347] ppc_notifier: mutex
[  129.835349] ppc =3D 0
[  129.835351] ppc_notifier: verify within
[  129.835353] ppc =3D 0 freq-limit 1833000
[  129.835356] ppc_notifier
[  129.835361] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.835365] acpi_cpufreq: get_cur_val =3D 2077
[  129.835367] acpi_cpufreq: cur freq =3D 1333000
[  129.835368] ppc_notifier
[  129.835370] ppc_notifier: mutex
[  129.835373] ppc =3D 0
[  129.835374] ppc_notifier: verify within
[  129.835377] ppc =3D 0 freq-limit 1833000
[  129.835379] ppc_notifier
[  129.874979] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.874982] acpi_cpufreq: get_cur_val =3D 2077
[  129.874985] acpi_cpufreq: cur freq =3D 1333000
[  129.874987] ppc_notifier
[  129.874989] ppc_notifier: mutex
[  129.874992] ppc =3D 0
[  129.874994] ppc_notifier: verify within
[  129.874996] ppc =3D 0 freq-limit 1833000
[  129.874999] ppc_notifier
[  129.875005] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.875008] acpi_cpufreq: get_cur_val =3D 2077
[  129.875011] acpi_cpufreq: cur freq =3D 1333000
[  129.875012] ppc_notifier
[  129.875014] ppc_notifier: mutex
[  129.875017] ppc =3D 0
[  129.875018] ppc_notifier: verify within
[  129.875021] ppc =3D 0 freq-limit 1833000
[  129.875023] ppc_notifier
[  129.875033] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  129.875035] acpi_cpufreq: get_cur_val =3D 2077
[  129.875037] acpi_cpufreq: cur freq =3D 1333000
[  129.875039] ppc_notifier
[  129.875040] ppc_notifier: mutex
[  129.875043] ppc =3D 0
[  129.875045] ppc_notifier: verify within
[  129.875047] ppc =3D 0 freq-limit 1833000
[  129.875050] ppc_notifier
[  129.875055] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  129.875058] acpi_cpufreq: get_cur_val =3D 2077
[  129.875060] acpi_cpufreq: cur freq =3D 1333000
[  129.875062] ppc_notifier
[  129.875064] ppc_notifier: mutex
[  129.875066] ppc =3D 0
[  129.875068] ppc_notifier: verify within
[  129.875070] ppc =3D 0 freq-limit 1833000
[  129.875073] ppc_notifier
[  129.923990] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  129.925910] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.090447] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.092317] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.093374] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.093377] acpi_cpufreq: get_cur_val =3D 2860
[  130.093379] acpi_cpufreq: cur freq =3D 1833000
[  130.093381] ppc_notifier
[  130.093382] ppc_notifier: mutex
[  130.093385] ppc =3D 0
[  130.093386] ppc_notifier: verify within
[  130.093388] ppc =3D 0 freq-limit 1833000
[  130.093390] ppc_notifier
[  130.093400] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.093403] acpi_cpufreq: get_cur_val =3D 2860
[  130.093405] acpi_cpufreq: cur freq =3D 1833000
[  130.093406] ppc_notifier
[  130.093408] ppc_notifier: mutex
[  130.093409] ppc =3D 0
[  130.093411] ppc_notifier: verify within
[  130.093412] ppc =3D 0 freq-limit 1833000
[  130.093414] ppc_notifier
[  130.093440] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.093442] acpi_cpufreq: get_cur_val =3D 2077
[  130.093444] acpi_cpufreq: cur freq =3D 1333000
[  130.093446] ppc_notifier
[  130.093448] ppc_notifier: mutex
[  130.093450] ppc =3D 0
[  130.093452] ppc_notifier: verify within
[  130.093454] ppc =3D 0 freq-limit 1833000
[  130.093457] ppc_notifier
[  130.093462] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.093466] acpi_cpufreq: get_cur_val =3D 2077
[  130.093468] acpi_cpufreq: cur freq =3D 1333000
[  130.093470] ppc_notifier
[  130.093471] ppc_notifier: mutex
[  130.093474] ppc =3D 0
[  130.093475] ppc_notifier: verify within
[  130.093478] ppc =3D 0 freq-limit 1833000
[  130.093480] ppc_notifier
[  130.131365] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.131369] acpi_cpufreq: get_cur_val =3D 2077
[  130.131371] acpi_cpufreq: cur freq =3D 1333000
[  130.131373] ppc_notifier
[  130.131376] ppc_notifier: mutex
[  130.131378] ppc =3D 0
[  130.131380] ppc_notifier: verify within
[  130.131382] ppc =3D 0 freq-limit 1833000
[  130.131386] ppc_notifier
[  130.131391] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.131395] acpi_cpufreq: get_cur_val =3D 2077
[  130.131397] acpi_cpufreq: cur freq =3D 1333000
[  130.131399] ppc_notifier
[  130.131401] ppc_notifier: mutex
[  130.131403] ppc =3D 0
[  130.131405] ppc_notifier: verify within
[  130.131407] ppc =3D 0 freq-limit 1833000
[  130.131410] ppc_notifier
[  130.131419] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.131421] acpi_cpufreq: get_cur_val =3D 2077
[  130.131423] acpi_cpufreq: cur freq =3D 1333000
[  130.131425] ppc_notifier
[  130.131427] ppc_notifier: mutex
[  130.131429] ppc =3D 0
[  130.131431] ppc_notifier: verify within
[  130.131433] ppc =3D 0 freq-limit 1833000
[  130.131436] ppc_notifier
[  130.131441] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.131444] acpi_cpufreq: get_cur_val =3D 2077
[  130.131446] acpi_cpufreq: cur freq =3D 1333000
[  130.131448] ppc_notifier
[  130.131450] ppc_notifier: mutex
[  130.131452] ppc =3D 0
[  130.131454] ppc_notifier: verify within
[  130.131456] ppc =3D 0 freq-limit 1833000
[  130.131459] ppc_notifier
[  130.181154] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.182965] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.305521] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.305524] acpi_cpufreq: get_cur_val =3D 2860
[  130.305526] acpi_cpufreq: cur freq =3D 1833000
[  130.306505] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.306509] acpi_cpufreq: get_cur_val =3D 2860
[  130.306511] acpi_cpufreq: cur freq =3D 1833000
[  130.417883] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.419923] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.421030] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.421034] acpi_cpufreq: get_cur_val =3D 2860
[  130.421036] acpi_cpufreq: cur freq =3D 1833000
[  130.421039] ppc_notifier
[  130.421040] ppc_notifier: mutex
[  130.421043] ppc =3D 0
[  130.421044] ppc_notifier: verify within
[  130.421046] ppc =3D 0 freq-limit 1833000
[  130.421048] ppc_notifier
[  130.421060] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.421064] acpi_cpufreq: get_cur_val =3D 2860
[  130.421065] acpi_cpufreq: cur freq =3D 1833000
[  130.421067] ppc_notifier
[  130.421068] ppc_notifier: mutex
[  130.421070] ppc =3D 0
[  130.421071] ppc_notifier: verify within
[  130.421072] ppc =3D 0 freq-limit 1833000
[  130.421075] ppc_notifier
[  130.421100] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.421102] acpi_cpufreq: get_cur_val =3D 2077
[  130.421104] acpi_cpufreq: cur freq =3D 1333000
[  130.421106] ppc_notifier
[  130.421108] ppc_notifier: mutex
[  130.421111] ppc =3D 0
[  130.421112] ppc_notifier: verify within
[  130.421115] ppc =3D 0 freq-limit 1833000
[  130.421118] ppc_notifier
[  130.421123] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.421126] acpi_cpufreq: get_cur_val =3D 2077
[  130.421128] acpi_cpufreq: cur freq =3D 1333000
[  130.421130] ppc_notifier
[  130.421132] ppc_notifier: mutex
[  130.421134] ppc =3D 0
[  130.421136] ppc_notifier: verify within
[  130.421138] ppc =3D 0 freq-limit 1833000
[  130.421141] ppc_notifier
[  130.462694] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.462697] acpi_cpufreq: get_cur_val =3D 2077
[  130.462699] acpi_cpufreq: cur freq =3D 1333000
[  130.462702] ppc_notifier
[  130.462704] ppc_notifier: mutex
[  130.462707] ppc =3D 0
[  130.462709] ppc_notifier: verify within
[  130.462711] ppc =3D 0 freq-limit 1833000
[  130.462714] ppc_notifier
[  130.462720] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.462724] acpi_cpufreq: get_cur_val =3D 2077
[  130.462726] acpi_cpufreq: cur freq =3D 1333000
[  130.462728] ppc_notifier
[  130.462729] ppc_notifier: mutex
[  130.462732] ppc =3D 0
[  130.462733] ppc_notifier: verify within
[  130.462736] ppc =3D 0 freq-limit 1833000
[  130.462739] ppc_notifier
[  130.462748] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.462750] acpi_cpufreq: get_cur_val =3D 2077
[  130.462752] acpi_cpufreq: cur freq =3D 1333000
[  130.462754] ppc_notifier
[  130.462755] ppc_notifier: mutex
[  130.462758] ppc =3D 0
[  130.462760] ppc_notifier: verify within
[  130.462762] ppc =3D 0 freq-limit 1833000
[  130.462765] ppc_notifier
[  130.462770] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.462773] acpi_cpufreq: get_cur_val =3D 2077
[  130.462775] acpi_cpufreq: cur freq =3D 1333000
[  130.462777] ppc_notifier
[  130.462779] ppc_notifier: mutex
[  130.462781] ppc =3D 0
[  130.462783] ppc_notifier: verify within
[  130.462785] ppc =3D 0 freq-limit 1833000
[  130.462788] ppc_notifier
[  130.516434] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.518127] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.748371] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.750380] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.751443] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.751446] acpi_cpufreq: get_cur_val =3D 2860
[  130.751447] acpi_cpufreq: cur freq =3D 1833000
[  130.751450] ppc_notifier
[  130.751451] ppc_notifier: mutex
[  130.751453] ppc =3D 0
[  130.751454] ppc_notifier: verify within
[  130.751456] ppc =3D 0 freq-limit 1833000
[  130.751458] ppc_notifier
[  130.751468] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.751472] acpi_cpufreq: get_cur_val =3D 2860
[  130.751473] acpi_cpufreq: cur freq =3D 1833000
[  130.751475] ppc_notifier
[  130.751476] ppc_notifier: mutex
[  130.751478] ppc =3D 0
[  130.751479] ppc_notifier: verify within
[  130.751481] ppc =3D 0 freq-limit 1833000
[  130.751483] ppc_notifier
[  130.751509] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.751511] acpi_cpufreq: get_cur_val =3D 2077
[  130.751513] acpi_cpufreq: cur freq =3D 1333000
[  130.751515] ppc_notifier
[  130.751517] ppc_notifier: mutex
[  130.751519] ppc =3D 0
[  130.751521] ppc_notifier: verify within
[  130.751523] ppc =3D 0 freq-limit 1833000
[  130.751526] ppc_notifier
[  130.751531] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.751534] acpi_cpufreq: get_cur_val =3D 2077
[  130.751536] acpi_cpufreq: cur freq =3D 1333000
[  130.751538] ppc_notifier
[  130.751540] ppc_notifier: mutex
[  130.751542] ppc =3D 0
[  130.751544] ppc_notifier: verify within
[  130.751546] ppc =3D 0 freq-limit 1833000
[  130.751549] ppc_notifier
[  130.789293] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.789297] acpi_cpufreq: get_cur_val =3D 2077
[  130.789299] acpi_cpufreq: cur freq =3D 1333000
[  130.789301] ppc_notifier
[  130.789304] ppc_notifier: mutex
[  130.789306] ppc =3D 0
[  130.789308] ppc_notifier: verify within
[  130.789310] ppc =3D 0 freq-limit 1833000
[  130.789313] ppc_notifier
[  130.789319] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.789323] acpi_cpufreq: get_cur_val =3D 2077
[  130.789325] acpi_cpufreq: cur freq =3D 1333000
[  130.789327] ppc_notifier
[  130.789329] ppc_notifier: mutex
[  130.789331] ppc =3D 0
[  130.789333] ppc_notifier: verify within
[  130.789335] ppc =3D 0 freq-limit 1833000
[  130.789338] ppc_notifier
[  130.789347] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.789349] acpi_cpufreq: get_cur_val =3D 2077
[  130.789351] acpi_cpufreq: cur freq =3D 1333000
[  130.789353] ppc_notifier
[  130.789355] ppc_notifier: mutex
[  130.789357] ppc =3D 0
[  130.789359] ppc_notifier: verify within
[  130.789361] ppc =3D 0 freq-limit 1833000
[  130.789364] ppc_notifier
[  130.789369] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.789372] acpi_cpufreq: get_cur_val =3D 2077
[  130.789374] acpi_cpufreq: cur freq =3D 1333000
[  130.789376] ppc_notifier
[  130.789378] ppc_notifier: mutex
[  130.789380] ppc =3D 0
[  130.789382] ppc_notifier: verify within
[  130.789384] ppc =3D 0 freq-limit 1833000
[  130.789387] ppc_notifier
[  130.835912] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.837873] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.991315] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  130.993350] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  130.994407] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.994410] acpi_cpufreq: get_cur_val =3D 2860
[  130.994412] acpi_cpufreq: cur freq =3D 1833000
[  130.994414] ppc_notifier
[  130.994415] ppc_notifier: mutex
[  130.994417] ppc =3D 0
[  130.994418] ppc_notifier: verify within
[  130.994420] ppc =3D 0 freq-limit 1833000
[  130.994422] ppc_notifier
[  130.994431] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.994435] acpi_cpufreq: get_cur_val =3D 2860
[  130.994437] acpi_cpufreq: cur freq =3D 1833000
[  130.994438] ppc_notifier
[  130.994439] ppc_notifier: mutex
[  130.994441] ppc =3D 0
[  130.994442] ppc_notifier: verify within
[  130.994444] ppc =3D 0 freq-limit 1833000
[  130.994446] ppc_notifier
[  130.994471] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  130.994474] acpi_cpufreq: get_cur_val =3D 2077
[  130.994476] acpi_cpufreq: cur freq =3D 1333000
[  130.994478] ppc_notifier
[  130.994479] ppc_notifier: mutex
[  130.994482] ppc =3D 0
[  130.994484] ppc_notifier: verify within
[  130.994486] ppc =3D 0 freq-limit 1833000
[  130.994489] ppc_notifier
[  130.994494] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  130.994497] acpi_cpufreq: get_cur_val =3D 2077
[  130.994499] acpi_cpufreq: cur freq =3D 1333000
[  130.994501] ppc_notifier
[  130.994503] ppc_notifier: mutex
[  130.994505] ppc =3D 0
[  130.994507] ppc_notifier: verify within
[  130.994509] ppc =3D 0 freq-limit 1833000
[  130.994512] ppc_notifier
[  131.033069] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.033073] acpi_cpufreq: get_cur_val =3D 2077
[  131.033075] acpi_cpufreq: cur freq =3D 1333000
[  131.033077] ppc_notifier
[  131.033079] ppc_notifier: mutex
[  131.033082] ppc =3D 0
[  131.033084] ppc_notifier: verify within
[  131.033086] ppc =3D 0 freq-limit 1833000
[  131.033089] ppc_notifier
[  131.033095] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.033099] acpi_cpufreq: get_cur_val =3D 2077
[  131.033101] acpi_cpufreq: cur freq =3D 1333000
[  131.033103] ppc_notifier
[  131.033105] ppc_notifier: mutex
[  131.033107] ppc =3D 0
[  131.033109] ppc_notifier: verify within
[  131.033111] ppc =3D 0 freq-limit 1833000
[  131.033114] ppc_notifier
[  131.033123] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.033125] acpi_cpufreq: get_cur_val =3D 2077
[  131.033127] acpi_cpufreq: cur freq =3D 1333000
[  131.033129] ppc_notifier
[  131.033131] ppc_notifier: mutex
[  131.033133] ppc =3D 0
[  131.033135] ppc_notifier: verify within
[  131.033137] ppc =3D 0 freq-limit 1833000
[  131.033140] ppc_notifier
[  131.033145] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.033148] acpi_cpufreq: get_cur_val =3D 2077
[  131.033150] acpi_cpufreq: cur freq =3D 1333000
[  131.033152] ppc_notifier
[  131.033154] ppc_notifier: mutex
[  131.033156] ppc =3D 0
[  131.033158] ppc_notifier: verify within
[  131.033160] ppc =3D 0 freq-limit 1833000
[  131.033163] ppc_notifier
[  131.078897] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.080882] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  131.272940] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.274812] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  131.275872] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.275875] acpi_cpufreq: get_cur_val =3D 2860
[  131.275877] acpi_cpufreq: cur freq =3D 1833000
[  131.275879] ppc_notifier
[  131.275880] ppc_notifier: mutex
[  131.275882] ppc =3D 0
[  131.275884] ppc_notifier: verify within
[  131.275885] ppc =3D 0 freq-limit 1833000
[  131.275888] ppc_notifier
[  131.275897] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.275901] acpi_cpufreq: get_cur_val =3D 2860
[  131.275903] acpi_cpufreq: cur freq =3D 1833000
[  131.275904] ppc_notifier
[  131.275905] ppc_notifier: mutex
[  131.275907] ppc =3D 0
[  131.275908] ppc_notifier: verify within
[  131.275910] ppc =3D 0 freq-limit 1833000
[  131.275912] ppc_notifier
[  131.275937] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.275940] acpi_cpufreq: get_cur_val =3D 2077
[  131.275942] acpi_cpufreq: cur freq =3D 1333000
[  131.275944] ppc_notifier
[  131.275945] ppc_notifier: mutex
[  131.275948] ppc =3D 0
[  131.275950] ppc_notifier: verify within
[  131.275952] ppc =3D 0 freq-limit 1833000
[  131.275955] ppc_notifier
[  131.275960] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.275963] acpi_cpufreq: get_cur_val =3D 2077
[  131.275965] acpi_cpufreq: cur freq =3D 1333000
[  131.275967] ppc_notifier
[  131.275969] ppc_notifier: mutex
[  131.275971] ppc =3D 0
[  131.275973] ppc_notifier: verify within
[  131.275975] ppc =3D 0 freq-limit 1833000
[  131.275978] ppc_notifier
[  131.316271] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.316275] acpi_cpufreq: get_cur_val =3D 2077
[  131.316278] acpi_cpufreq: cur freq =3D 1333000
[  131.316280] ppc_notifier
[  131.316282] ppc_notifier: mutex
[  131.316285] ppc =3D 0
[  131.316286] ppc_notifier: verify within
[  131.316289] ppc =3D 0 freq-limit 1833000
[  131.316292] ppc_notifier
[  131.316297] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.316302] acpi_cpufreq: get_cur_val =3D 2077
[  131.316304] acpi_cpufreq: cur freq =3D 1333000
[  131.316306] ppc_notifier
[  131.316307] ppc_notifier: mutex
[  131.316310] ppc =3D 0
[  131.316312] ppc_notifier: verify within
[  131.316314] ppc =3D 0 freq-limit 1833000
[  131.316317] ppc_notifier
[  131.316326] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.316328] acpi_cpufreq: get_cur_val =3D 2077
[  131.316330] acpi_cpufreq: cur freq =3D 1333000
[  131.316332] ppc_notifier
[  131.316334] ppc_notifier: mutex
[  131.316336] ppc =3D 0
[  131.316338] ppc_notifier: verify within
[  131.316340] ppc =3D 0 freq-limit 1833000
[  131.316343] ppc_notifier
[  131.316348] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.316351] acpi_cpufreq: get_cur_val =3D 2077
[  131.316353] acpi_cpufreq: cur freq =3D 1333000
[  131.316355] ppc_notifier
[  131.316357] ppc_notifier: mutex
[  131.316359] ppc =3D 0
[  131.316361] ppc_notifier: verify within
[  131.316363] ppc =3D 0 freq-limit 1833000
[  131.316366] ppc_notifier
[  131.376311] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.377960] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  131.541142] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.542821] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  131.543868] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.543871] acpi_cpufreq: get_cur_val =3D 2860
[  131.543872] acpi_cpufreq: cur freq =3D 1833000
[  131.543874] ppc_notifier
[  131.543876] ppc_notifier: mutex
[  131.543878] ppc =3D 0
[  131.543879] ppc_notifier: verify within
[  131.543881] ppc =3D 0 freq-limit 1833000
[  131.543883] ppc_notifier
[  131.543892] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.543895] acpi_cpufreq: get_cur_val =3D 2860
[  131.543896] acpi_cpufreq: cur freq =3D 1833000
[  131.543898] ppc_notifier
[  131.543899] ppc_notifier: mutex
[  131.543901] ppc =3D 0
[  131.543902] ppc_notifier: verify within
[  131.543904] ppc =3D 0 freq-limit 1833000
[  131.543906] ppc_notifier
[  131.543931] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.543933] acpi_cpufreq: get_cur_val =3D 2077
[  131.543935] acpi_cpufreq: cur freq =3D 1333000
[  131.543937] ppc_notifier
[  131.543939] ppc_notifier: mutex
[  131.543941] ppc =3D 0
[  131.543943] ppc_notifier: verify within
[  131.543945] ppc =3D 0 freq-limit 1833000
[  131.543948] ppc_notifier
[  131.543954] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.543957] acpi_cpufreq: get_cur_val =3D 2077
[  131.543959] acpi_cpufreq: cur freq =3D 1333000
[  131.543961] ppc_notifier
[  131.543963] ppc_notifier: mutex
[  131.543965] ppc =3D 0
[  131.543967] ppc_notifier: verify within
[  131.543969] ppc =3D 0 freq-limit 1833000
[  131.543972] ppc_notifier
[  131.581321] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.581325] acpi_cpufreq: get_cur_val =3D 2077
[  131.581327] acpi_cpufreq: cur freq =3D 1333000
[  131.581330] ppc_notifier
[  131.581332] ppc_notifier: mutex
[  131.581335] ppc =3D 0
[  131.581336] ppc_notifier: verify within
[  131.581339] ppc =3D 0 freq-limit 1833000
[  131.581342] ppc_notifier
[  131.581347] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.581351] acpi_cpufreq: get_cur_val =3D 2077
[  131.581353] acpi_cpufreq: cur freq =3D 1333000
[  131.581355] ppc_notifier
[  131.581357] ppc_notifier: mutex
[  131.581360] ppc =3D 0
[  131.581361] ppc_notifier: verify within
[  131.581363] ppc =3D 0 freq-limit 1833000
[  131.581366] ppc_notifier
[  131.581375] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.581378] acpi_cpufreq: get_cur_val =3D 2077
[  131.581380] acpi_cpufreq: cur freq =3D 1333000
[  131.581382] ppc_notifier
[  131.581383] ppc_notifier: mutex
[  131.581386] ppc =3D 0
[  131.581387] ppc_notifier: verify within
[  131.581390] ppc =3D 0 freq-limit 1833000
[  131.581392] ppc_notifier
[  131.581397] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.581401] acpi_cpufreq: get_cur_val =3D 2077
[  131.581403] acpi_cpufreq: cur freq =3D 1333000
[  131.581405] ppc_notifier
[  131.581406] ppc_notifier: mutex
[  131.581409] ppc =3D 0
[  131.581411] ppc_notifier: verify within
[  131.581413] ppc =3D 0 freq-limit 1833000
[  131.581416] ppc_notifier
[  131.627941] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.629863] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  131.847226] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.849305] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  131.850361] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.850364] acpi_cpufreq: get_cur_val =3D 2860
[  131.850366] acpi_cpufreq: cur freq =3D 1833000
[  131.850368] ppc_notifier
[  131.850369] ppc_notifier: mutex
[  131.850371] ppc =3D 0
[  131.850373] ppc_notifier: verify within
[  131.850374] ppc =3D 0 freq-limit 1833000
[  131.850377] ppc_notifier
[  131.850386] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.850389] acpi_cpufreq: get_cur_val =3D 2860
[  131.850391] acpi_cpufreq: cur freq =3D 1833000
[  131.850392] ppc_notifier
[  131.850393] ppc_notifier: mutex
[  131.850395] ppc =3D 0
[  131.850397] ppc_notifier: verify within
[  131.850398] ppc =3D 0 freq-limit 1833000
[  131.850400] ppc_notifier
[  131.850426] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.850428] acpi_cpufreq: get_cur_val =3D 2077
[  131.850430] acpi_cpufreq: cur freq =3D 1333000
[  131.850432] ppc_notifier
[  131.850434] ppc_notifier: mutex
[  131.850436] ppc =3D 0
[  131.850438] ppc_notifier: verify within
[  131.850440] ppc =3D 0 freq-limit 1833000
[  131.850443] ppc_notifier
[  131.850448] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.850452] acpi_cpufreq: get_cur_val =3D 2077
[  131.850453] acpi_cpufreq: cur freq =3D 1333000
[  131.850455] ppc_notifier
[  131.850457] ppc_notifier: mutex
[  131.850460] ppc =3D 0
[  131.850461] ppc_notifier: verify within
[  131.850463] ppc =3D 0 freq-limit 1833000
[  131.850466] ppc_notifier
[  131.889769] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.889773] acpi_cpufreq: get_cur_val =3D 2077
[  131.889776] acpi_cpufreq: cur freq =3D 1333000
[  131.889778] ppc_notifier
[  131.889781] ppc_notifier: mutex
[  131.889783] ppc =3D 0
[  131.889785] ppc_notifier: verify within
[  131.889787] ppc =3D 0 freq-limit 1833000
[  131.889790] ppc_notifier
[  131.889796] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.889800] acpi_cpufreq: get_cur_val =3D 2077
[  131.889802] acpi_cpufreq: cur freq =3D 1333000
[  131.889804] ppc_notifier
[  131.889806] ppc_notifier: mutex
[  131.889809] ppc =3D 0
[  131.889810] ppc_notifier: verify within
[  131.889812] ppc =3D 0 freq-limit 1833000
[  131.889815] ppc_notifier
[  131.889825] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  131.889827] acpi_cpufreq: get_cur_val =3D 2077
[  131.889829] acpi_cpufreq: cur freq =3D 1333000
[  131.889831] ppc_notifier
[  131.889832] ppc_notifier: mutex
[  131.889835] ppc =3D 0
[  131.889836] ppc_notifier: verify within
[  131.889839] ppc =3D 0 freq-limit 1833000
[  131.889842] ppc_notifier
[  131.889847] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  131.889850] acpi_cpufreq: get_cur_val =3D 2077
[  131.889852] acpi_cpufreq: cur freq =3D 1333000
[  131.889854] ppc_notifier
[  131.889855] ppc_notifier: mutex
[  131.889858] ppc =3D 0
[  131.889860] ppc_notifier: verify within
[  131.889862] ppc =3D 0 freq-limit 1833000
[  131.889865] ppc_notifier
[  131.937965] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  131.939831] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  132.119381] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  132.121414] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  132.122471] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.122473] acpi_cpufreq: get_cur_val =3D 2860
[  132.122475] acpi_cpufreq: cur freq =3D 1833000
[  132.122477] ppc_notifier
[  132.122478] ppc_notifier: mutex
[  132.122480] ppc =3D 0
[  132.122481] ppc_notifier: verify within
[  132.122483] ppc =3D 0 freq-limit 1833000
[  132.122485] ppc_notifier
[  132.122494] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.122498] acpi_cpufreq: get_cur_val =3D 2860
[  132.122499] acpi_cpufreq: cur freq =3D 1833000
[  132.122501] ppc_notifier
[  132.122502] ppc_notifier: mutex
[  132.122504] ppc =3D 0
[  132.122505] ppc_notifier: verify within
[  132.122507] ppc =3D 0 freq-limit 1833000
[  132.122509] ppc_notifier
[  132.122534] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.122536] acpi_cpufreq: get_cur_val =3D 2077
[  132.122538] acpi_cpufreq: cur freq =3D 1333000
[  132.122540] ppc_notifier
[  132.122542] ppc_notifier: mutex
[  132.122545] ppc =3D 0
[  132.122546] ppc_notifier: verify within
[  132.122549] ppc =3D 0 freq-limit 1833000
[  132.122551] ppc_notifier
[  132.122557] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.122560] acpi_cpufreq: get_cur_val =3D 2077
[  132.122562] acpi_cpufreq: cur freq =3D 1333000
[  132.122564] ppc_notifier
[  132.122566] ppc_notifier: mutex
[  132.122568] ppc =3D 0
[  132.122570] ppc_notifier: verify within
[  132.122572] ppc =3D 0 freq-limit 1833000
[  132.122575] ppc_notifier
[  132.160355] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.160359] acpi_cpufreq: get_cur_val =3D 2077
[  132.160361] acpi_cpufreq: cur freq =3D 1333000
[  132.160363] ppc_notifier
[  132.160366] ppc_notifier: mutex
[  132.160368] ppc =3D 0
[  132.160370] ppc_notifier: verify within
[  132.160372] ppc =3D 0 freq-limit 1833000
[  132.160376] ppc_notifier
[  132.160381] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.160385] acpi_cpufreq: get_cur_val =3D 2077
[  132.160387] acpi_cpufreq: cur freq =3D 1333000
[  132.160389] ppc_notifier
[  132.160391] ppc_notifier: mutex
[  132.160393] ppc =3D 0
[  132.160395] ppc_notifier: verify within
[  132.160397] ppc =3D 0 freq-limit 1833000
[  132.160400] ppc_notifier
[  132.160409] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.160411] acpi_cpufreq: get_cur_val =3D 2077
[  132.160413] acpi_cpufreq: cur freq =3D 1333000
[  132.160415] ppc_notifier
[  132.160417] ppc_notifier: mutex
[  132.160419] ppc =3D 0
[  132.160421] ppc_notifier: verify within
[  132.160423] ppc =3D 0 freq-limit 1833000
[  132.160426] ppc_notifier
[  132.160431] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.160434] acpi_cpufreq: get_cur_val =3D 2077
[  132.160436] acpi_cpufreq: cur freq =3D 1333000
[  132.160438] ppc_notifier
[  132.160440] ppc_notifier: mutex
[  132.160442] ppc =3D 0
[  132.160444] ppc_notifier: verify within
[  132.160446] ppc =3D 0 freq-limit 1833000
[  132.160449] ppc_notifier
[  132.212508] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  132.214378] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  132.401787] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  132.403732] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  132.404821] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.404824] acpi_cpufreq: get_cur_val =3D 2860
[  132.404825] acpi_cpufreq: cur freq =3D 1833000
[  132.404827] ppc_notifier
[  132.404829] ppc_notifier: mutex
[  132.404831] ppc =3D 0
[  132.404832] ppc_notifier: verify within
[  132.404834] ppc =3D 0 freq-limit 1833000
[  132.404836] ppc_notifier
[  132.404844] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.404847] acpi_cpufreq: get_cur_val =3D 2860
[  132.404849] acpi_cpufreq: cur freq =3D 1833000
[  132.404850] ppc_notifier
[  132.404852] ppc_notifier: mutex
[  132.404853] ppc =3D 0
[  132.404855] ppc_notifier: verify within
[  132.404856] ppc =3D 0 freq-limit 1833000
[  132.404858] ppc_notifier
[  132.404884] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.404886] acpi_cpufreq: get_cur_val =3D 2077
[  132.404888] acpi_cpufreq: cur freq =3D 1333000
[  132.404890] ppc_notifier
[  132.404892] ppc_notifier: mutex
[  132.404894] ppc =3D 0
[  132.404896] ppc_notifier: verify within
[  132.404898] ppc =3D 0 freq-limit 1833000
[  132.404901] ppc_notifier
[  132.404906] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.404910] acpi_cpufreq: get_cur_val =3D 2077
[  132.404912] acpi_cpufreq: cur freq =3D 1333000
[  132.404914] ppc_notifier
[  132.404915] ppc_notifier: mutex
[  132.404918] ppc =3D 0
[  132.404919] ppc_notifier: verify within
[  132.404922] ppc =3D 0 freq-limit 1833000
[  132.404924] ppc_notifier
[  132.444327] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.444331] acpi_cpufreq: get_cur_val =3D 2077
[  132.444333] acpi_cpufreq: cur freq =3D 1333000
[  132.444335] ppc_notifier
[  132.444338] ppc_notifier: mutex
[  132.444340] ppc =3D 0
[  132.444342] ppc_notifier: verify within
[  132.444344] ppc =3D 0 freq-limit 1833000
[  132.444347] ppc_notifier
[  132.444353] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.444357] acpi_cpufreq: get_cur_val =3D 2077
[  132.444359] acpi_cpufreq: cur freq =3D 1333000
[  132.444361] ppc_notifier
[  132.444363] ppc_notifier: mutex
[  132.444365] ppc =3D 0
[  132.444367] ppc_notifier: verify within
[  132.444369] ppc =3D 0 freq-limit 1833000
[  132.444372] ppc_notifier
[  132.444381] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.444383] acpi_cpufreq: get_cur_val =3D 2077
[  132.444385] acpi_cpufreq: cur freq =3D 1333000
[  132.444387] ppc_notifier
[  132.444389] ppc_notifier: mutex
[  132.444391] ppc =3D 0
[  132.444393] ppc_notifier: verify within
[  132.444395] ppc =3D 0 freq-limit 1833000
[  132.444398] ppc_notifier
[  132.444403] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.444406] acpi_cpufreq: get_cur_val =3D 2077
[  132.444408] acpi_cpufreq: cur freq =3D 1333000
[  132.444410] ppc_notifier
[  132.444412] ppc_notifier: mutex
[  132.444414] ppc =3D 0
[  132.444416] ppc_notifier: verify within
[  132.444418] ppc =3D 0 freq-limit 1833000
[  132.444421] ppc_notifier
[  132.491751] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  132.493723] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  132.654998] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  132.657066] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  132.658117] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.658120] acpi_cpufreq: get_cur_val =3D 2860
[  132.658121] acpi_cpufreq: cur freq =3D 1833000
[  132.658124] ppc_notifier
[  132.658125] ppc_notifier: mutex
[  132.658127] ppc =3D 0
[  132.658128] ppc_notifier: verify within
[  132.658130] ppc =3D 0 freq-limit 1833000
[  132.658133] ppc_notifier
[  132.658142] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.658145] acpi_cpufreq: get_cur_val =3D 2860
[  132.658147] acpi_cpufreq: cur freq =3D 1833000
[  132.658148] ppc_notifier
[  132.658150] ppc_notifier: mutex
[  132.658151] ppc =3D 0
[  132.658153] ppc_notifier: verify within
[  132.658154] ppc =3D 0 freq-limit 1833000
[  132.658156] ppc_notifier
[  132.658182] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.658184] acpi_cpufreq: get_cur_val =3D 2077
[  132.658186] acpi_cpufreq: cur freq =3D 1333000
[  132.658188] ppc_notifier
[  132.658190] ppc_notifier: mutex
[  132.658192] ppc =3D 0
[  132.658194] ppc_notifier: verify within
[  132.658196] ppc =3D 0 freq-limit 1833000
[  132.658199] ppc_notifier
[  132.658204] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.658208] acpi_cpufreq: get_cur_val =3D 2077
[  132.658210] acpi_cpufreq: cur freq =3D 1333000
[  132.658211] ppc_notifier
[  132.658213] ppc_notifier: mutex
[  132.658216] ppc =3D 0
[  132.658217] ppc_notifier: verify within
[  132.658220] ppc =3D 0 freq-limit 1833000
[  132.658222] ppc_notifier
[  132.699891] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.699894] acpi_cpufreq: get_cur_val =3D 2077
[  132.699896] acpi_cpufreq: cur freq =3D 1333000
[  132.699899] ppc_notifier
[  132.699901] ppc_notifier: mutex
[  132.699904] ppc =3D 0
[  132.699905] ppc_notifier: verify within
[  132.699908] ppc =3D 0 freq-limit 1833000
[  132.699911] ppc_notifier
[  132.699916] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.699920] acpi_cpufreq: get_cur_val =3D 2077
[  132.699922] acpi_cpufreq: cur freq =3D 1333000
[  132.699924] ppc_notifier
[  132.699926] ppc_notifier: mutex
[  132.699928] ppc =3D 0
[  132.699930] ppc_notifier: verify within
[  132.699932] ppc =3D 0 freq-limit 1833000
[  132.699935] ppc_notifier
[  132.699944] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  132.699947] acpi_cpufreq: get_cur_val =3D 2077
[  132.699948] acpi_cpufreq: cur freq =3D 1333000
[  132.699950] ppc_notifier
[  132.699952] ppc_notifier: mutex
[  132.699955] ppc =3D 0
[  132.699956] ppc_notifier: verify within
[  132.699958] ppc =3D 0 freq-limit 1833000
[  132.699961] ppc_notifier
[  132.699966] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  132.699970] acpi_cpufreq: get_cur_val =3D 2077
[  132.699972] acpi_cpufreq: cur freq =3D 1333000
[  132.699974] ppc_notifier
[  132.699975] ppc_notifier: mutex
[  132.699978] ppc =3D 0
[  132.699980] ppc_notifier: verify within
[  132.699982] ppc =3D 0 freq-limit 1833000
[  132.699985] ppc_notifier
[  132.752078] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  132.753730] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 82 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.024309] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.026059] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.027130] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.027134] acpi_cpufreq: get_cur_val =3D 2860
[  133.027136] acpi_cpufreq: cur freq =3D 1833000
[  133.027139] ppc_notifier
[  133.027140] ppc_notifier: mutex
[  133.027142] ppc =3D 0
[  133.027144] ppc_notifier: verify within
[  133.027146] ppc =3D 0 freq-limit 1833000
[  133.027148] ppc_notifier
[  133.027160] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.027164] acpi_cpufreq: get_cur_val =3D 2860
[  133.027166] acpi_cpufreq: cur freq =3D 1833000
[  133.027167] ppc_notifier
[  133.027169] ppc_notifier: mutex
[  133.027170] ppc =3D 0
[  133.027172] ppc_notifier: verify within
[  133.027173] ppc =3D 0 freq-limit 1833000
[  133.027175] ppc_notifier
[  133.027201] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.027203] acpi_cpufreq: get_cur_val =3D 2077
[  133.027205] acpi_cpufreq: cur freq =3D 1333000
[  133.027207] ppc_notifier
[  133.027209] ppc_notifier: mutex
[  133.027212] ppc =3D 0
[  133.027213] ppc_notifier: verify within
[  133.027216] ppc =3D 0 freq-limit 1833000
[  133.027218] ppc_notifier
[  133.027224] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.027227] acpi_cpufreq: get_cur_val =3D 2077
[  133.027229] acpi_cpufreq: cur freq =3D 1333000
[  133.027231] ppc_notifier
[  133.027233] ppc_notifier: mutex
[  133.027235] ppc =3D 0
[  133.027237] ppc_notifier: verify within
[  133.027239] ppc =3D 0 freq-limit 1833000
[  133.027242] ppc_notifier
[  133.065924] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.065928] acpi_cpufreq: get_cur_val =3D 2077
[  133.065930] acpi_cpufreq: cur freq =3D 1333000
[  133.065932] ppc_notifier
[  133.065935] ppc_notifier: mutex
[  133.065937] ppc =3D 0
[  133.065939] ppc_notifier: verify within
[  133.065941] ppc =3D 0 freq-limit 1833000
[  133.065945] ppc_notifier
[  133.065950] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.065954] acpi_cpufreq: get_cur_val =3D 2077
[  133.065957] acpi_cpufreq: cur freq =3D 1333000
[  133.065958] ppc_notifier
[  133.065960] ppc_notifier: mutex
[  133.065963] ppc =3D 0
[  133.065964] ppc_notifier: verify within
[  133.065967] ppc =3D 0 freq-limit 1833000
[  133.065970] ppc_notifier
[  133.065979] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.065981] acpi_cpufreq: get_cur_val =3D 2077
[  133.065983] acpi_cpufreq: cur freq =3D 1333000
[  133.065985] ppc_notifier
[  133.065986] ppc_notifier: mutex
[  133.065989] ppc =3D 0
[  133.065991] ppc_notifier: verify within
[  133.065993] ppc =3D 0 freq-limit 1833000
[  133.065996] ppc_notifier
[  133.066001] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.066004] acpi_cpufreq: get_cur_val =3D 2077
[  133.066006] acpi_cpufreq: cur freq =3D 1333000
[  133.066008] ppc_notifier
[  133.066010] ppc_notifier: mutex
[  133.066012] ppc =3D 0
[  133.066014] ppc_notifier: verify within
[  133.066016] ppc =3D 0 freq-limit 1833000
[  133.066019] ppc_notifier
[  133.108624] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.110233] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.252949] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.254621] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.255665] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.255668] acpi_cpufreq: get_cur_val =3D 2860
[  133.255669] acpi_cpufreq: cur freq =3D 1833000
[  133.255671] ppc_notifier
[  133.255673] ppc_notifier: mutex
[  133.255675] ppc =3D 0
[  133.255676] ppc_notifier: verify within
[  133.255678] ppc =3D 0 freq-limit 1833000
[  133.255680] ppc_notifier
[  133.255688] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.255692] acpi_cpufreq: get_cur_val =3D 2860
[  133.255693] acpi_cpufreq: cur freq =3D 1833000
[  133.255695] ppc_notifier
[  133.255696] ppc_notifier: mutex
[  133.255698] ppc =3D 0
[  133.255699] ppc_notifier: verify within
[  133.255700] ppc =3D 0 freq-limit 1833000
[  133.255703] ppc_notifier
[  133.255728] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.255730] acpi_cpufreq: get_cur_val =3D 2077
[  133.255732] acpi_cpufreq: cur freq =3D 1333000
[  133.255734] ppc_notifier
[  133.255736] ppc_notifier: mutex
[  133.255738] ppc =3D 0
[  133.255740] ppc_notifier: verify within
[  133.255742] ppc =3D 0 freq-limit 1833000
[  133.255745] ppc_notifier
[  133.255750] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.255754] acpi_cpufreq: get_cur_val =3D 2077
[  133.255756] acpi_cpufreq: cur freq =3D 1333000
[  133.255758] ppc_notifier
[  133.255759] ppc_notifier: mutex
[  133.255762] ppc =3D 0
[  133.255763] ppc_notifier: verify within
[  133.255766] ppc =3D 0 freq-limit 1833000
[  133.255769] ppc_notifier
[  133.293900] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.293904] acpi_cpufreq: get_cur_val =3D 2077
[  133.293906] acpi_cpufreq: cur freq =3D 1333000
[  133.293908] ppc_notifier
[  133.293911] ppc_notifier: mutex
[  133.293913] ppc =3D 0
[  133.293915] ppc_notifier: verify within
[  133.293917] ppc =3D 0 freq-limit 1833000
[  133.293921] ppc_notifier
[  133.293926] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.293930] acpi_cpufreq: get_cur_val =3D 2077
[  133.293932] acpi_cpufreq: cur freq =3D 1333000
[  133.293934] ppc_notifier
[  133.293936] ppc_notifier: mutex
[  133.293938] ppc =3D 0
[  133.293940] ppc_notifier: verify within
[  133.293942] ppc =3D 0 freq-limit 1833000
[  133.293945] ppc_notifier
[  133.293954] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.293956] acpi_cpufreq: get_cur_val =3D 2077
[  133.293958] acpi_cpufreq: cur freq =3D 1333000
[  133.293960] ppc_notifier
[  133.293962] ppc_notifier: mutex
[  133.293964] ppc =3D 0
[  133.293966] ppc_notifier: verify within
[  133.293968] ppc =3D 0 freq-limit 1833000
[  133.293971] ppc_notifier
[  133.293976] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.293979] acpi_cpufreq: get_cur_val =3D 2077
[  133.293981] acpi_cpufreq: cur freq =3D 1333000
[  133.293983] ppc_notifier
[  133.293985] ppc_notifier: mutex
[  133.293987] ppc =3D 0
[  133.293989] ppc_notifier: verify within
[  133.293991] ppc =3D 0 freq-limit 1833000
[  133.293994] ppc_notifier
[  133.335819] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.337828] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.482515] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.484451] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.485501] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.485503] acpi_cpufreq: get_cur_val =3D 2860
[  133.485505] acpi_cpufreq: cur freq =3D 1833000
[  133.485507] ppc_notifier
[  133.485509] ppc_notifier: mutex
[  133.485511] ppc =3D 0
[  133.485512] ppc_notifier: verify within
[  133.485514] ppc =3D 0 freq-limit 1833000
[  133.485516] ppc_notifier
[  133.485525] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.485528] acpi_cpufreq: get_cur_val =3D 2860
[  133.485530] acpi_cpufreq: cur freq =3D 1833000
[  133.485531] ppc_notifier
[  133.485533] ppc_notifier: mutex
[  133.485534] ppc =3D 0
[  133.485536] ppc_notifier: verify within
[  133.485537] ppc =3D 0 freq-limit 1833000
[  133.485539] ppc_notifier
[  133.485565] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.485567] acpi_cpufreq: get_cur_val =3D 2077
[  133.485569] acpi_cpufreq: cur freq =3D 1333000
[  133.485571] ppc_notifier
[  133.485573] ppc_notifier: mutex
[  133.485575] ppc =3D 0
[  133.485577] ppc_notifier: verify within
[  133.485579] ppc =3D 0 freq-limit 1833000
[  133.485582] ppc_notifier
[  133.485587] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.485591] acpi_cpufreq: get_cur_val =3D 2077
[  133.485593] acpi_cpufreq: cur freq =3D 1333000
[  133.485595] ppc_notifier
[  133.485596] ppc_notifier: mutex
[  133.485599] ppc =3D 0
[  133.485600] ppc_notifier: verify within
[  133.485603] ppc =3D 0 freq-limit 1833000
[  133.485606] ppc_notifier
[  133.523464] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.523468] acpi_cpufreq: get_cur_val =3D 2077
[  133.523470] acpi_cpufreq: cur freq =3D 1333000
[  133.523472] ppc_notifier
[  133.523475] ppc_notifier: mutex
[  133.523477] ppc =3D 0
[  133.523479] ppc_notifier: verify within
[  133.523482] ppc =3D 0 freq-limit 1833000
[  133.523485] ppc_notifier
[  133.523490] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.523494] acpi_cpufreq: get_cur_val =3D 2077
[  133.523496] acpi_cpufreq: cur freq =3D 1333000
[  133.523498] ppc_notifier
[  133.523500] ppc_notifier: mutex
[  133.523502] ppc =3D 0
[  133.523504] ppc_notifier: verify within
[  133.523506] ppc =3D 0 freq-limit 1833000
[  133.523509] ppc_notifier
[  133.523518] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.523520] acpi_cpufreq: get_cur_val =3D 2077
[  133.523522] acpi_cpufreq: cur freq =3D 1333000
[  133.523524] ppc_notifier
[  133.523526] ppc_notifier: mutex
[  133.523528] ppc =3D 0
[  133.523530] ppc_notifier: verify within
[  133.523532] ppc =3D 0 freq-limit 1833000
[  133.523535] ppc_notifier
[  133.523540] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.523544] acpi_cpufreq: get_cur_val =3D 2077
[  133.523546] acpi_cpufreq: cur freq =3D 1333000
[  133.523548] ppc_notifier
[  133.523549] ppc_notifier: mutex
[  133.523552] ppc =3D 0
[  133.523553] ppc_notifier: verify within
[  133.523556] ppc =3D 0 freq-limit 1833000
[  133.523558] ppc_notifier
[  133.563792] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.565859] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.746852] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.749049] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  133.750118] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.750121] acpi_cpufreq: get_cur_val =3D 2860
[  133.750123] acpi_cpufreq: cur freq =3D 1833000
[  133.750126] ppc_notifier
[  133.750128] ppc_notifier: mutex
[  133.750130] ppc =3D 0
[  133.750131] ppc_notifier: verify within
[  133.750133] ppc =3D 0 freq-limit 1833000
[  133.750135] ppc_notifier
[  133.750147] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.750151] acpi_cpufreq: get_cur_val =3D 2860
[  133.750153] acpi_cpufreq: cur freq =3D 1833000
[  133.750154] ppc_notifier
[  133.750155] ppc_notifier: mutex
[  133.750157] ppc =3D 0
[  133.750158] ppc_notifier: verify within
[  133.750160] ppc =3D 0 freq-limit 1833000
[  133.750162] ppc_notifier
[  133.750188] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.750190] acpi_cpufreq: get_cur_val =3D 2077
[  133.750192] acpi_cpufreq: cur freq =3D 1333000
[  133.750194] ppc_notifier
[  133.750196] ppc_notifier: mutex
[  133.750198] ppc =3D 0
[  133.750200] ppc_notifier: verify within
[  133.750202] ppc =3D 0 freq-limit 1833000
[  133.750205] ppc_notifier
[  133.750210] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.750214] acpi_cpufreq: get_cur_val =3D 2077
[  133.750216] acpi_cpufreq: cur freq =3D 1333000
[  133.750218] ppc_notifier
[  133.750219] ppc_notifier: mutex
[  133.750222] ppc =3D 0
[  133.750224] ppc_notifier: verify within
[  133.750226] ppc =3D 0 freq-limit 1833000
[  133.750229] ppc_notifier
[  133.790096] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.790100] acpi_cpufreq: get_cur_val =3D 2077
[  133.790102] acpi_cpufreq: cur freq =3D 1333000
[  133.790105] ppc_notifier
[  133.790107] ppc_notifier: mutex
[  133.790110] ppc =3D 0
[  133.790111] ppc_notifier: verify within
[  133.790114] ppc =3D 0 freq-limit 1833000
[  133.790117] ppc_notifier
[  133.790122] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.790126] acpi_cpufreq: get_cur_val =3D 2077
[  133.790128] acpi_cpufreq: cur freq =3D 1333000
[  133.790130] ppc_notifier
[  133.790132] ppc_notifier: mutex
[  133.790135] ppc =3D 0
[  133.790136] ppc_notifier: verify within
[  133.790139] ppc =3D 0 freq-limit 1833000
[  133.790141] ppc_notifier
[  133.790151] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  133.790153] acpi_cpufreq: get_cur_val =3D 2077
[  133.790155] acpi_cpufreq: cur freq =3D 1333000
[  133.790157] ppc_notifier
[  133.790158] ppc_notifier: mutex
[  133.790161] ppc =3D 0
[  133.790162] ppc_notifier: verify within
[  133.790165] ppc =3D 0 freq-limit 1833000
[  133.790168] ppc_notifier
[  133.790173] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  133.790176] acpi_cpufreq: get_cur_val =3D 2077
[  133.790178] acpi_cpufreq: cur freq =3D 1333000
[  133.790180] ppc_notifier
[  133.790182] ppc_notifier: mutex
[  133.790184] ppc =3D 0
[  133.790186] ppc_notifier: verify within
[  133.790188] ppc =3D 0 freq-limit 1833000
[  133.790191] ppc_notifier
[  133.835165] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  133.837075] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.044313] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.045973] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.047045] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.047049] acpi_cpufreq: get_cur_val =3D 2860
[  134.047051] acpi_cpufreq: cur freq =3D 1833000
[  134.047055] ppc_notifier
[  134.047056] ppc_notifier: mutex
[  134.047058] ppc =3D 0
[  134.047060] ppc_notifier: verify within
[  134.047062] ppc =3D 0 freq-limit 1833000
[  134.047064] ppc_notifier
[  134.047077] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.047081] acpi_cpufreq: get_cur_val =3D 2860
[  134.047082] acpi_cpufreq: cur freq =3D 1833000
[  134.047084] ppc_notifier
[  134.047085] ppc_notifier: mutex
[  134.047087] ppc =3D 0
[  134.047088] ppc_notifier: verify within
[  134.047089] ppc =3D 0 freq-limit 1833000
[  134.047092] ppc_notifier
[  134.047117] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.047120] acpi_cpufreq: get_cur_val =3D 2077
[  134.047122] acpi_cpufreq: cur freq =3D 1333000
[  134.047124] ppc_notifier
[  134.047125] ppc_notifier: mutex
[  134.047128] ppc =3D 0
[  134.047129] ppc_notifier: verify within
[  134.047132] ppc =3D 0 freq-limit 1833000
[  134.047135] ppc_notifier
[  134.047140] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.047143] acpi_cpufreq: get_cur_val =3D 2077
[  134.047145] acpi_cpufreq: cur freq =3D 1333000
[  134.047147] ppc_notifier
[  134.047149] ppc_notifier: mutex
[  134.047151] ppc =3D 0
[  134.047153] ppc_notifier: verify within
[  134.047155] ppc =3D 0 freq-limit 1833000
[  134.047158] ppc_notifier
[  134.086722] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.086726] acpi_cpufreq: get_cur_val =3D 2077
[  134.086728] acpi_cpufreq: cur freq =3D 1333000
[  134.086731] ppc_notifier
[  134.086733] ppc_notifier: mutex
[  134.086736] ppc =3D 0
[  134.086738] ppc_notifier: verify within
[  134.086740] ppc =3D 0 freq-limit 1833000
[  134.086743] ppc_notifier
[  134.086748] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.086753] acpi_cpufreq: get_cur_val =3D 2077
[  134.086755] acpi_cpufreq: cur freq =3D 1333000
[  134.086757] ppc_notifier
[  134.086759] ppc_notifier: mutex
[  134.086761] ppc =3D 0
[  134.086763] ppc_notifier: verify within
[  134.086765] ppc =3D 0 freq-limit 1833000
[  134.086768] ppc_notifier
[  134.086777] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.086779] acpi_cpufreq: get_cur_val =3D 2077
[  134.086781] acpi_cpufreq: cur freq =3D 1333000
[  134.086783] ppc_notifier
[  134.086785] ppc_notifier: mutex
[  134.086787] ppc =3D 0
[  134.086789] ppc_notifier: verify within
[  134.086791] ppc =3D 0 freq-limit 1833000
[  134.086794] ppc_notifier
[  134.086799] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.086802] acpi_cpufreq: get_cur_val =3D 2077
[  134.086804] acpi_cpufreq: cur freq =3D 1333000
[  134.086806] ppc_notifier
[  134.086808] ppc_notifier: mutex
[  134.086810] ppc =3D 0
[  134.086812] ppc_notifier: verify within
[  134.086814] ppc =3D 0 freq-limit 1833000
[  134.086817] ppc_notifier
[  134.135719] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.137657] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.280111] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.281919] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.282971] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.282974] acpi_cpufreq: get_cur_val =3D 2860
[  134.282976] acpi_cpufreq: cur freq =3D 1833000
[  134.282978] ppc_notifier
[  134.282980] ppc_notifier: mutex
[  134.282982] ppc =3D 0
[  134.282983] ppc_notifier: verify within
[  134.282985] ppc =3D 0 freq-limit 1833000
[  134.282987] ppc_notifier
[  134.282997] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.283000] acpi_cpufreq: get_cur_val =3D 2860
[  134.283002] acpi_cpufreq: cur freq =3D 1833000
[  134.283003] ppc_notifier
[  134.283004] ppc_notifier: mutex
[  134.283006] ppc =3D 0
[  134.283007] ppc_notifier: verify within
[  134.283009] ppc =3D 0 freq-limit 1833000
[  134.283011] ppc_notifier
[  134.283037] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.283039] acpi_cpufreq: get_cur_val =3D 2077
[  134.283041] acpi_cpufreq: cur freq =3D 1333000
[  134.283043] ppc_notifier
[  134.283045] ppc_notifier: mutex
[  134.283047] ppc =3D 0
[  134.283049] ppc_notifier: verify within
[  134.283051] ppc =3D 0 freq-limit 1833000
[  134.283054] ppc_notifier
[  134.283059] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.283063] acpi_cpufreq: get_cur_val =3D 2077
[  134.283064] acpi_cpufreq: cur freq =3D 1333000
[  134.283066] ppc_notifier
[  134.283068] ppc_notifier: mutex
[  134.283071] ppc =3D 0
[  134.283072] ppc_notifier: verify within
[  134.283074] ppc =3D 0 freq-limit 1833000
[  134.283077] ppc_notifier
[  134.323375] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.323378] acpi_cpufreq: get_cur_val =3D 2077
[  134.323381] acpi_cpufreq: cur freq =3D 1333000
[  134.323383] ppc_notifier
[  134.323385] ppc_notifier: mutex
[  134.323388] ppc =3D 0
[  134.323390] ppc_notifier: verify within
[  134.323392] ppc =3D 0 freq-limit 1833000
[  134.323395] ppc_notifier
[  134.323401] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.323405] acpi_cpufreq: get_cur_val =3D 2077
[  134.323407] acpi_cpufreq: cur freq =3D 1333000
[  134.323409] ppc_notifier
[  134.323411] ppc_notifier: mutex
[  134.323413] ppc =3D 0
[  134.323415] ppc_notifier: verify within
[  134.323417] ppc =3D 0 freq-limit 1833000
[  134.323420] ppc_notifier
[  134.323429] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.323431] acpi_cpufreq: get_cur_val =3D 2077
[  134.323433] acpi_cpufreq: cur freq =3D 1333000
[  134.323435] ppc_notifier
[  134.323437] ppc_notifier: mutex
[  134.323439] ppc =3D 0
[  134.323441] ppc_notifier: verify within
[  134.323443] ppc =3D 0 freq-limit 1833000
[  134.323446] ppc_notifier
[  134.323451] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.323454] acpi_cpufreq: get_cur_val =3D 2077
[  134.323456] acpi_cpufreq: cur freq =3D 1333000
[  134.323458] ppc_notifier
[  134.323460] ppc_notifier: mutex
[  134.323462] ppc =3D 0
[  134.323464] ppc_notifier: verify within
[  134.323466] ppc =3D 0 freq-limit 1833000
[  134.323469] ppc_notifier
[  134.370882] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.372984] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.504172] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.505961] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.507019] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.507023] acpi_cpufreq: get_cur_val =3D 2860
[  134.507025] acpi_cpufreq: cur freq =3D 1833000
[  134.507027] ppc_notifier
[  134.507029] ppc_notifier: mutex
[  134.507031] ppc =3D 0
[  134.507032] ppc_notifier: verify within
[  134.507034] ppc =3D 0 freq-limit 1833000
[  134.507036] ppc_notifier
[  134.507048] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.507052] acpi_cpufreq: get_cur_val =3D 2860
[  134.507054] acpi_cpufreq: cur freq =3D 1833000
[  134.507055] ppc_notifier
[  134.507056] ppc_notifier: mutex
[  134.507058] ppc =3D 0
[  134.507059] ppc_notifier: verify within
[  134.507061] ppc =3D 0 freq-limit 1833000
[  134.507063] ppc_notifier
[  134.507089] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.507091] acpi_cpufreq: get_cur_val =3D 2077
[  134.507093] acpi_cpufreq: cur freq =3D 1333000
[  134.507095] ppc_notifier
[  134.507097] ppc_notifier: mutex
[  134.507099] ppc =3D 0
[  134.507101] ppc_notifier: verify within
[  134.507103] ppc =3D 0 freq-limit 1833000
[  134.507106] ppc_notifier
[  134.507111] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.507114] acpi_cpufreq: get_cur_val =3D 2077
[  134.507116] acpi_cpufreq: cur freq =3D 1333000
[  134.507118] ppc_notifier
[  134.507120] ppc_notifier: mutex
[  134.507122] ppc =3D 0
[  134.507124] ppc_notifier: verify within
[  134.507126] ppc =3D 0 freq-limit 1833000
[  134.507129] ppc_notifier
[  134.544332] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.544336] acpi_cpufreq: get_cur_val =3D 2077
[  134.544339] acpi_cpufreq: cur freq =3D 1333000
[  134.544341] ppc_notifier
[  134.544343] ppc_notifier: mutex
[  134.544346] ppc =3D 0
[  134.544348] ppc_notifier: verify within
[  134.544350] ppc =3D 0 freq-limit 1833000
[  134.544353] ppc_notifier
[  134.544359] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.544363] acpi_cpufreq: get_cur_val =3D 2077
[  134.544365] acpi_cpufreq: cur freq =3D 1333000
[  134.544367] ppc_notifier
[  134.544368] ppc_notifier: mutex
[  134.544371] ppc =3D 0
[  134.544372] ppc_notifier: verify within
[  134.544375] ppc =3D 0 freq-limit 1833000
[  134.544378] ppc_notifier
[  134.544387] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.544389] acpi_cpufreq: get_cur_val =3D 2077
[  134.544391] acpi_cpufreq: cur freq =3D 1333000
[  134.544393] ppc_notifier
[  134.544394] ppc_notifier: mutex
[  134.544397] ppc =3D 0
[  134.544399] ppc_notifier: verify within
[  134.544401] ppc =3D 0 freq-limit 1833000
[  134.544404] ppc_notifier
[  134.544409] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.544412] acpi_cpufreq: get_cur_val =3D 2077
[  134.544414] acpi_cpufreq: cur freq =3D 1333000
[  134.544416] ppc_notifier
[  134.544418] ppc_notifier: mutex
[  134.544420] ppc =3D 0
[  134.544422] ppc_notifier: verify within
[  134.544424] ppc =3D 0 freq-limit 1833000
[  134.544427] ppc_notifier
[  134.592554] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.594299] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.743183] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.745158] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  134.746225] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.746229] acpi_cpufreq: get_cur_val =3D 2860
[  134.746231] acpi_cpufreq: cur freq =3D 1833000
[  134.746233] ppc_notifier
[  134.746235] ppc_notifier: mutex
[  134.746237] ppc =3D 0
[  134.746238] ppc_notifier: verify within
[  134.746240] ppc =3D 0 freq-limit 1833000
[  134.746242] ppc_notifier
[  134.746254] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.746258] acpi_cpufreq: get_cur_val =3D 2860
[  134.746259] acpi_cpufreq: cur freq =3D 1833000
[  134.746261] ppc_notifier
[  134.746262] ppc_notifier: mutex
[  134.746264] ppc =3D 0
[  134.746265] ppc_notifier: verify within
[  134.746267] ppc =3D 0 freq-limit 1833000
[  134.746269] ppc_notifier
[  134.746294] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.746297] acpi_cpufreq: get_cur_val =3D 2077
[  134.746299] acpi_cpufreq: cur freq =3D 1333000
[  134.746301] ppc_notifier
[  134.746302] ppc_notifier: mutex
[  134.746305] ppc =3D 0
[  134.746307] ppc_notifier: verify within
[  134.746309] ppc =3D 0 freq-limit 1833000
[  134.746312] ppc_notifier
[  134.746317] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.746320] acpi_cpufreq: get_cur_val =3D 2077
[  134.746322] acpi_cpufreq: cur freq =3D 1333000
[  134.746324] ppc_notifier
[  134.746326] ppc_notifier: mutex
[  134.746328] ppc =3D 0
[  134.746330] ppc_notifier: verify within
[  134.746332] ppc =3D 0 freq-limit 1833000
[  134.746335] ppc_notifier
[  134.784922] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.784925] acpi_cpufreq: get_cur_val =3D 2077
[  134.784927] acpi_cpufreq: cur freq =3D 1333000
[  134.784930] ppc_notifier
[  134.784933] ppc_notifier: mutex
[  134.784935] ppc =3D 0
[  134.784937] ppc_notifier: verify within
[  134.784940] ppc =3D 0 freq-limit 1833000
[  134.784943] ppc_notifier
[  134.784948] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.784953] acpi_cpufreq: get_cur_val =3D 2077
[  134.784955] acpi_cpufreq: cur freq =3D 1333000
[  134.784956] ppc_notifier
[  134.784958] ppc_notifier: mutex
[  134.784961] ppc =3D 0
[  134.784962] ppc_notifier: verify within
[  134.784965] ppc =3D 0 freq-limit 1833000
[  134.784968] ppc_notifier
[  134.784977] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  134.784979] acpi_cpufreq: get_cur_val =3D 2077
[  134.784981] acpi_cpufreq: cur freq =3D 1333000
[  134.784983] ppc_notifier
[  134.784984] ppc_notifier: mutex
[  134.784987] ppc =3D 0
[  134.784989] ppc_notifier: verify within
[  134.784991] ppc =3D 0 freq-limit 1833000
[  134.784994] ppc_notifier
[  134.784999] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  134.785002] acpi_cpufreq: get_cur_val =3D 2077
[  134.785004] acpi_cpufreq: cur freq =3D 1333000
[  134.785006] ppc_notifier
[  134.785008] ppc_notifier: mutex
[  134.785010] ppc =3D 0
[  134.785012] ppc_notifier: verify within
[  134.785014] ppc =3D 0 freq-limit 1833000
[  134.785017] ppc_notifier
[  134.828362] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  134.830018] thinkpad_acpi: temperatures (Celsius): 102 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.053251] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.055115] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.056288] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.056293] acpi_cpufreq: get_cur_val =3D 2860
[  135.056295] acpi_cpufreq: cur freq =3D 1833000
[  135.056298] ppc_notifier
[  135.056300] ppc_notifier: mutex
[  135.056302] ppc =3D 0
[  135.056303] ppc_notifier: verify within
[  135.056305] ppc =3D 0 freq-limit 1833000
[  135.056307] ppc_notifier
[  135.056320] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.056324] acpi_cpufreq: get_cur_val =3D 2860
[  135.056325] acpi_cpufreq: cur freq =3D 1833000
[  135.056327] ppc_notifier
[  135.056328] ppc_notifier: mutex
[  135.056330] ppc =3D 0
[  135.056331] ppc_notifier: verify within
[  135.056333] ppc =3D 0 freq-limit 1833000
[  135.056335] ppc_notifier
[  135.056360] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.056363] acpi_cpufreq: get_cur_val =3D 2077
[  135.056365] acpi_cpufreq: cur freq =3D 1333000
[  135.056367] ppc_notifier
[  135.056368] ppc_notifier: mutex
[  135.056371] ppc =3D 0
[  135.056373] ppc_notifier: verify within
[  135.056375] ppc =3D 0 freq-limit 1833000
[  135.056378] ppc_notifier
[  135.056383] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.056386] acpi_cpufreq: get_cur_val =3D 2077
[  135.056388] acpi_cpufreq: cur freq =3D 1333000
[  135.056390] ppc_notifier
[  135.056392] ppc_notifier: mutex
[  135.056394] ppc =3D 0
[  135.056396] ppc_notifier: verify within
[  135.056398] ppc =3D 0 freq-limit 1833000
[  135.056401] ppc_notifier
[  135.096549] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.096554] acpi_cpufreq: get_cur_val =3D 2077
[  135.096556] acpi_cpufreq: cur freq =3D 1333000
[  135.096559] ppc_notifier
[  135.096562] ppc_notifier: mutex
[  135.096565] ppc =3D 0
[  135.096567] ppc_notifier: verify within
[  135.096569] ppc =3D 0 freq-limit 1833000
[  135.096572] ppc_notifier
[  135.096578] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.096582] acpi_cpufreq: get_cur_val =3D 2077
[  135.096584] acpi_cpufreq: cur freq =3D 1333000
[  135.096586] ppc_notifier
[  135.096588] ppc_notifier: mutex
[  135.096591] ppc =3D 0
[  135.096592] ppc_notifier: verify within
[  135.096595] ppc =3D 0 freq-limit 1833000
[  135.096597] ppc_notifier
[  135.096607] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.096609] acpi_cpufreq: get_cur_val =3D 2077
[  135.096611] acpi_cpufreq: cur freq =3D 1333000
[  135.096613] ppc_notifier
[  135.096614] ppc_notifier: mutex
[  135.096617] ppc =3D 0
[  135.096619] ppc_notifier: verify within
[  135.096621] ppc =3D 0 freq-limit 1833000
[  135.096624] ppc_notifier
[  135.096629] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.096632] acpi_cpufreq: get_cur_val =3D 2077
[  135.096634] acpi_cpufreq: cur freq =3D 1333000
[  135.096636] ppc_notifier
[  135.096638] ppc_notifier: mutex
[  135.096640] ppc =3D 0
[  135.096642] ppc_notifier: verify within
[  135.096644] ppc =3D 0 freq-limit 1833000
[  135.096647] ppc_notifier
[  135.143130] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.145086] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.259099] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.261152] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.262222] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.262226] acpi_cpufreq: get_cur_val =3D 2860
[  135.262228] acpi_cpufreq: cur freq =3D 1833000
[  135.262230] ppc_notifier
[  135.262232] ppc_notifier: mutex
[  135.262234] ppc =3D 0
[  135.262235] ppc_notifier: verify within
[  135.262237] ppc =3D 0 freq-limit 1833000
[  135.262239] ppc_notifier
[  135.262251] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.262255] acpi_cpufreq: get_cur_val =3D 2860
[  135.262256] acpi_cpufreq: cur freq =3D 1833000
[  135.262258] ppc_notifier
[  135.262259] ppc_notifier: mutex
[  135.262261] ppc =3D 0
[  135.262262] ppc_notifier: verify within
[  135.262264] ppc =3D 0 freq-limit 1833000
[  135.262266] ppc_notifier
[  135.262291] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.262293] acpi_cpufreq: get_cur_val =3D 2077
[  135.262295] acpi_cpufreq: cur freq =3D 1333000
[  135.262297] ppc_notifier
[  135.262299] ppc_notifier: mutex
[  135.262302] ppc =3D 0
[  135.262303] ppc_notifier: verify within
[  135.262306] ppc =3D 0 freq-limit 1833000
[  135.262309] ppc_notifier
[  135.262314] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.262317] acpi_cpufreq: get_cur_val =3D 2077
[  135.262319] acpi_cpufreq: cur freq =3D 1333000
[  135.262321] ppc_notifier
[  135.262323] ppc_notifier: mutex
[  135.262325] ppc =3D 0
[  135.262327] ppc_notifier: verify within
[  135.262329] ppc =3D 0 freq-limit 1833000
[  135.262332] ppc_notifier
[  135.301640] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.301645] acpi_cpufreq: get_cur_val =3D 2077
[  135.301647] acpi_cpufreq: cur freq =3D 1333000
[  135.301650] ppc_notifier
[  135.301653] ppc_notifier: mutex
[  135.301656] ppc =3D 0
[  135.301658] ppc_notifier: verify within
[  135.301660] ppc =3D 0 freq-limit 1833000
[  135.301663] ppc_notifier
[  135.301669] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.301673] acpi_cpufreq: get_cur_val =3D 2077
[  135.301675] acpi_cpufreq: cur freq =3D 1333000
[  135.301677] ppc_notifier
[  135.301679] ppc_notifier: mutex
[  135.301681] ppc =3D 0
[  135.301683] ppc_notifier: verify within
[  135.301685] ppc =3D 0 freq-limit 1833000
[  135.301688] ppc_notifier
[  135.301697] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.301700] acpi_cpufreq: get_cur_val =3D 2077
[  135.301701] acpi_cpufreq: cur freq =3D 1333000
[  135.301703] ppc_notifier
[  135.301705] ppc_notifier: mutex
[  135.301708] ppc =3D 0
[  135.301709] ppc_notifier: verify within
[  135.301711] ppc =3D 0 freq-limit 1833000
[  135.301714] ppc_notifier
[  135.301719] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.301723] acpi_cpufreq: get_cur_val =3D 2077
[  135.301725] acpi_cpufreq: cur freq =3D 1333000
[  135.301727] ppc_notifier
[  135.301728] ppc_notifier: mutex
[  135.301731] ppc =3D 0
[  135.301732] ppc_notifier: verify within
[  135.301735] ppc =3D 0 freq-limit 1833000
[  135.301738] ppc_notifier
[  135.313501] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.313505] acpi_cpufreq: get_cur_val =3D 2860
[  135.313506] acpi_cpufreq: cur freq =3D 1833000
[  135.314485] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.314490] acpi_cpufreq: get_cur_val =3D 2860
[  135.314491] acpi_cpufreq: cur freq =3D 1833000
[  135.353026] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.354733] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.486268] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.487950] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.489035] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.489039] acpi_cpufreq: get_cur_val =3D 2860
[  135.489041] acpi_cpufreq: cur freq =3D 1833000
[  135.489045] ppc_notifier
[  135.489046] ppc_notifier: mutex
[  135.489048] ppc =3D 0
[  135.489050] ppc_notifier: verify within
[  135.489051] ppc =3D 0 freq-limit 1833000
[  135.489054] ppc_notifier
[  135.489066] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.489070] acpi_cpufreq: get_cur_val =3D 2860
[  135.489072] acpi_cpufreq: cur freq =3D 1833000
[  135.489073] ppc_notifier
[  135.489075] ppc_notifier: mutex
[  135.489076] ppc =3D 0
[  135.489078] ppc_notifier: verify within
[  135.489079] ppc =3D 0 freq-limit 1833000
[  135.489081] ppc_notifier
[  135.489107] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.489109] acpi_cpufreq: get_cur_val =3D 2077
[  135.489111] acpi_cpufreq: cur freq =3D 1333000
[  135.489113] ppc_notifier
[  135.489115] ppc_notifier: mutex
[  135.489117] ppc =3D 0
[  135.489119] ppc_notifier: verify within
[  135.489121] ppc =3D 0 freq-limit 1833000
[  135.489124] ppc_notifier
[  135.489130] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.489133] acpi_cpufreq: get_cur_val =3D 2077
[  135.489135] acpi_cpufreq: cur freq =3D 1333000
[  135.489137] ppc_notifier
[  135.489138] ppc_notifier: mutex
[  135.489141] ppc =3D 0
[  135.489143] ppc_notifier: verify within
[  135.489145] ppc =3D 0 freq-limit 1833000
[  135.489148] ppc_notifier
[  135.529638] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.529643] acpi_cpufreq: get_cur_val =3D 2077
[  135.529646] acpi_cpufreq: cur freq =3D 1333000
[  135.529649] ppc_notifier
[  135.529652] ppc_notifier: mutex
[  135.529655] ppc =3D 0
[  135.529656] ppc_notifier: verify within
[  135.529659] ppc =3D 0 freq-limit 1833000
[  135.529662] ppc_notifier
[  135.529668] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.529672] acpi_cpufreq: get_cur_val =3D 2077
[  135.529674] acpi_cpufreq: cur freq =3D 1333000
[  135.529676] ppc_notifier
[  135.529678] ppc_notifier: mutex
[  135.529680] ppc =3D 0
[  135.529682] ppc_notifier: verify within
[  135.529684] ppc =3D 0 freq-limit 1833000
[  135.529687] ppc_notifier
[  135.529696] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.529699] acpi_cpufreq: get_cur_val =3D 2077
[  135.529701] acpi_cpufreq: cur freq =3D 1333000
[  135.529703] ppc_notifier
[  135.529704] ppc_notifier: mutex
[  135.529707] ppc =3D 0
[  135.529708] ppc_notifier: verify within
[  135.529711] ppc =3D 0 freq-limit 1833000
[  135.529713] ppc_notifier
[  135.529718] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.529722] acpi_cpufreq: get_cur_val =3D 2077
[  135.529724] acpi_cpufreq: cur freq =3D 1333000
[  135.529726] ppc_notifier
[  135.529728] ppc_notifier: mutex
[  135.529730] ppc =3D 0
[  135.529732] ppc_notifier: verify within
[  135.529734] ppc =3D 0 freq-limit 1833000
[  135.529737] ppc_notifier
[  135.574647] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.576838] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.706347] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.708293] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.709349] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.709352] acpi_cpufreq: get_cur_val =3D 2860
[  135.709354] acpi_cpufreq: cur freq =3D 1833000
[  135.709356] ppc_notifier
[  135.709357] ppc_notifier: mutex
[  135.709359] ppc =3D 0
[  135.709361] ppc_notifier: verify within
[  135.709362] ppc =3D 0 freq-limit 1833000
[  135.709365] ppc_notifier
[  135.709375] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.709379] acpi_cpufreq: get_cur_val =3D 2860
[  135.709380] acpi_cpufreq: cur freq =3D 1833000
[  135.709382] ppc_notifier
[  135.709383] ppc_notifier: mutex
[  135.709385] ppc =3D 0
[  135.709386] ppc_notifier: verify within
[  135.709388] ppc =3D 0 freq-limit 1833000
[  135.709390] ppc_notifier
[  135.709415] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.709417] acpi_cpufreq: get_cur_val =3D 2077
[  135.709419] acpi_cpufreq: cur freq =3D 1333000
[  135.709421] ppc_notifier
[  135.709423] ppc_notifier: mutex
[  135.709426] ppc =3D 0
[  135.709427] ppc_notifier: verify within
[  135.709430] ppc =3D 0 freq-limit 1833000
[  135.709432] ppc_notifier
[  135.709438] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.709441] acpi_cpufreq: get_cur_val =3D 2077
[  135.709443] acpi_cpufreq: cur freq =3D 1333000
[  135.709445] ppc_notifier
[  135.709447] ppc_notifier: mutex
[  135.709449] ppc =3D 0
[  135.709451] ppc_notifier: verify within
[  135.709453] ppc =3D 0 freq-limit 1833000
[  135.709456] ppc_notifier
[  135.752036] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.752040] acpi_cpufreq: get_cur_val =3D 2077
[  135.752042] acpi_cpufreq: cur freq =3D 1333000
[  135.752044] ppc_notifier
[  135.752046] ppc_notifier: mutex
[  135.752049] ppc =3D 0
[  135.752051] ppc_notifier: verify within
[  135.752053] ppc =3D 0 freq-limit 1833000
[  135.752056] ppc_notifier
[  135.752062] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.752066] acpi_cpufreq: get_cur_val =3D 2077
[  135.752068] acpi_cpufreq: cur freq =3D 1333000
[  135.752070] ppc_notifier
[  135.752071] ppc_notifier: mutex
[  135.752074] ppc =3D 0
[  135.752076] ppc_notifier: verify within
[  135.752078] ppc =3D 0 freq-limit 1833000
[  135.752081] ppc_notifier
[  135.752090] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.752092] acpi_cpufreq: get_cur_val =3D 2077
[  135.752094] acpi_cpufreq: cur freq =3D 1333000
[  135.752096] ppc_notifier
[  135.752098] ppc_notifier: mutex
[  135.752100] ppc =3D 0
[  135.752102] ppc_notifier: verify within
[  135.752104] ppc =3D 0 freq-limit 1833000
[  135.752107] ppc_notifier
[  135.752112] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.752115] acpi_cpufreq: get_cur_val =3D 2077
[  135.752117] acpi_cpufreq: cur freq =3D 1333000
[  135.752119] ppc_notifier
[  135.752121] ppc_notifier: mutex
[  135.752123] ppc =3D 0
[  135.752125] ppc_notifier: verify within
[  135.752127] ppc =3D 0 freq-limit 1833000
[  135.752130] ppc_notifier
[  135.804258] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.805874] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.937547] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  135.939234] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  135.940334] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.940338] acpi_cpufreq: get_cur_val =3D 2860
[  135.940339] acpi_cpufreq: cur freq =3D 1833000
[  135.940342] ppc_notifier
[  135.940344] ppc_notifier: mutex
[  135.940346] ppc =3D 0
[  135.940347] ppc_notifier: verify within
[  135.940349] ppc =3D 0 freq-limit 1833000
[  135.940352] ppc_notifier
[  135.940364] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.940367] acpi_cpufreq: get_cur_val =3D 2860
[  135.940369] acpi_cpufreq: cur freq =3D 1833000
[  135.940370] ppc_notifier
[  135.940372] ppc_notifier: mutex
[  135.940373] ppc =3D 0
[  135.940375] ppc_notifier: verify within
[  135.940376] ppc =3D 0 freq-limit 1833000
[  135.940378] ppc_notifier
[  135.940404] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.940406] acpi_cpufreq: get_cur_val =3D 2077
[  135.940408] acpi_cpufreq: cur freq =3D 1333000
[  135.940410] ppc_notifier
[  135.940412] ppc_notifier: mutex
[  135.940415] ppc =3D 0
[  135.940416] ppc_notifier: verify within
[  135.940419] ppc =3D 0 freq-limit 1833000
[  135.940421] ppc_notifier
[  135.940427] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.940430] acpi_cpufreq: get_cur_val =3D 2077
[  135.940432] acpi_cpufreq: cur freq =3D 1333000
[  135.940434] ppc_notifier
[  135.940436] ppc_notifier: mutex
[  135.940438] ppc =3D 0
[  135.940440] ppc_notifier: verify within
[  135.940442] ppc =3D 0 freq-limit 1833000
[  135.940445] ppc_notifier
[  135.982394] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.982397] acpi_cpufreq: get_cur_val =3D 2077
[  135.982400] acpi_cpufreq: cur freq =3D 1333000
[  135.982402] ppc_notifier
[  135.982405] ppc_notifier: mutex
[  135.982408] ppc =3D 0
[  135.982409] ppc_notifier: verify within
[  135.982412] ppc =3D 0 freq-limit 1833000
[  135.982415] ppc_notifier
[  135.982420] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.982425] acpi_cpufreq: get_cur_val =3D 2077
[  135.982427] acpi_cpufreq: cur freq =3D 1333000
[  135.982429] ppc_notifier
[  135.982431] ppc_notifier: mutex
[  135.982433] ppc =3D 0
[  135.982435] ppc_notifier: verify within
[  135.982437] ppc =3D 0 freq-limit 1833000
[  135.982440] ppc_notifier
[  135.982449] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  135.982451] acpi_cpufreq: get_cur_val =3D 2077
[  135.982453] acpi_cpufreq: cur freq =3D 1333000
[  135.982455] ppc_notifier
[  135.982457] ppc_notifier: mutex
[  135.982459] ppc =3D 0
[  135.982461] ppc_notifier: verify within
[  135.982463] ppc =3D 0 freq-limit 1833000
[  135.982466] ppc_notifier
[  135.982471] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  135.982474] acpi_cpufreq: get_cur_val =3D 2077
[  135.982476] acpi_cpufreq: cur freq =3D 1333000
[  135.982478] ppc_notifier
[  135.982480] ppc_notifier: mutex
[  135.982482] ppc =3D 0
[  135.982484] ppc_notifier: verify within
[  135.982486] ppc =3D 0 freq-limit 1833000
[  135.982489] ppc_notifier
[  136.028275] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.029913] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.161575] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.163662] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.164769] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.164773] acpi_cpufreq: get_cur_val =3D 2860
[  136.164775] acpi_cpufreq: cur freq =3D 1833000
[  136.164778] ppc_notifier
[  136.164779] ppc_notifier: mutex
[  136.164781] ppc =3D 0
[  136.164783] ppc_notifier: verify within
[  136.164784] ppc =3D 0 freq-limit 1833000
[  136.164787] ppc_notifier
[  136.164798] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.164803] acpi_cpufreq: get_cur_val =3D 2860
[  136.164804] acpi_cpufreq: cur freq =3D 1833000
[  136.164806] ppc_notifier
[  136.164807] ppc_notifier: mutex
[  136.164809] ppc =3D 0
[  136.164810] ppc_notifier: verify within
[  136.164811] ppc =3D 0 freq-limit 1833000
[  136.164814] ppc_notifier
[  136.164839] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.164841] acpi_cpufreq: get_cur_val =3D 2077
[  136.164843] acpi_cpufreq: cur freq =3D 1333000
[  136.164845] ppc_notifier
[  136.164847] ppc_notifier: mutex
[  136.164850] ppc =3D 0
[  136.164851] ppc_notifier: verify within
[  136.164854] ppc =3D 0 freq-limit 1833000
[  136.164856] ppc_notifier
[  136.164862] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.164865] acpi_cpufreq: get_cur_val =3D 2077
[  136.164867] acpi_cpufreq: cur freq =3D 1333000
[  136.164869] ppc_notifier
[  136.164871] ppc_notifier: mutex
[  136.164873] ppc =3D 0
[  136.164875] ppc_notifier: verify within
[  136.164877] ppc =3D 0 freq-limit 1833000
[  136.164880] ppc_notifier
[  136.205644] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.205648] acpi_cpufreq: get_cur_val =3D 2077
[  136.205650] acpi_cpufreq: cur freq =3D 1333000
[  136.205653] ppc_notifier
[  136.205655] ppc_notifier: mutex
[  136.205658] ppc =3D 0
[  136.205660] ppc_notifier: verify within
[  136.205662] ppc =3D 0 freq-limit 1833000
[  136.205665] ppc_notifier
[  136.205671] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.205675] acpi_cpufreq: get_cur_val =3D 2077
[  136.205677] acpi_cpufreq: cur freq =3D 1333000
[  136.205679] ppc_notifier
[  136.205681] ppc_notifier: mutex
[  136.205683] ppc =3D 0
[  136.205685] ppc_notifier: verify within
[  136.205687] ppc =3D 0 freq-limit 1833000
[  136.205690] ppc_notifier
[  136.205699] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.205702] acpi_cpufreq: get_cur_val =3D 2077
[  136.205704] acpi_cpufreq: cur freq =3D 1333000
[  136.205706] ppc_notifier
[  136.205707] ppc_notifier: mutex
[  136.205710] ppc =3D 0
[  136.205711] ppc_notifier: verify within
[  136.205714] ppc =3D 0 freq-limit 1833000
[  136.205716] ppc_notifier
[  136.205721] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.205725] acpi_cpufreq: get_cur_val =3D 2077
[  136.205727] acpi_cpufreq: cur freq =3D 1333000
[  136.205729] ppc_notifier
[  136.205730] ppc_notifier: mutex
[  136.205733] ppc =3D 0
[  136.205735] ppc_notifier: verify within
[  136.205737] ppc =3D 0 freq-limit 1833000
[  136.205740] ppc_notifier
[  136.249907] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.252025] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.349327] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.351170] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.352265] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.352268] acpi_cpufreq: get_cur_val =3D 2860
[  136.352270] acpi_cpufreq: cur freq =3D 1833000
[  136.352272] ppc_notifier
[  136.352274] ppc_notifier: mutex
[  136.352276] ppc =3D 0
[  136.352278] ppc_notifier: verify within
[  136.352279] ppc =3D 0 freq-limit 1833000
[  136.352282] ppc_notifier
[  136.352294] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.352297] acpi_cpufreq: get_cur_val =3D 2860
[  136.352299] acpi_cpufreq: cur freq =3D 1833000
[  136.352300] ppc_notifier
[  136.352301] ppc_notifier: mutex
[  136.352303] ppc =3D 0
[  136.352305] ppc_notifier: verify within
[  136.352306] ppc =3D 0 freq-limit 1833000
[  136.352308] ppc_notifier
[  136.352334] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.352336] acpi_cpufreq: get_cur_val =3D 2077
[  136.352338] acpi_cpufreq: cur freq =3D 1333000
[  136.352340] ppc_notifier
[  136.352342] ppc_notifier: mutex
[  136.352344] ppc =3D 0
[  136.352346] ppc_notifier: verify within
[  136.352348] ppc =3D 0 freq-limit 1833000
[  136.352351] ppc_notifier
[  136.352356] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.352359] acpi_cpufreq: get_cur_val =3D 2077
[  136.352361] acpi_cpufreq: cur freq =3D 1333000
[  136.352363] ppc_notifier
[  136.352365] ppc_notifier: mutex
[  136.352367] ppc =3D 0
[  136.352369] ppc_notifier: verify within
[  136.352371] ppc =3D 0 freq-limit 1833000
[  136.352374] ppc_notifier
[  136.392630] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.392634] acpi_cpufreq: get_cur_val =3D 2077
[  136.392636] acpi_cpufreq: cur freq =3D 1333000
[  136.392638] ppc_notifier
[  136.392641] ppc_notifier: mutex
[  136.392644] ppc =3D 0
[  136.392645] ppc_notifier: verify within
[  136.392648] ppc =3D 0 freq-limit 1833000
[  136.392651] ppc_notifier
[  136.392656] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.392661] acpi_cpufreq: get_cur_val =3D 2077
[  136.392663] acpi_cpufreq: cur freq =3D 1333000
[  136.392665] ppc_notifier
[  136.392666] ppc_notifier: mutex
[  136.392669] ppc =3D 0
[  136.392671] ppc_notifier: verify within
[  136.392673] ppc =3D 0 freq-limit 1833000
[  136.392676] ppc_notifier
[  136.392685] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.392687] acpi_cpufreq: get_cur_val =3D 2077
[  136.392689] acpi_cpufreq: cur freq =3D 1333000
[  136.392691] ppc_notifier
[  136.392693] ppc_notifier: mutex
[  136.392695] ppc =3D 0
[  136.392697] ppc_notifier: verify within
[  136.392699] ppc =3D 0 freq-limit 1833000
[  136.392702] ppc_notifier
[  136.392707] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.392711] acpi_cpufreq: get_cur_val =3D 2077
[  136.392712] acpi_cpufreq: cur freq =3D 1333000
[  136.392714] ppc_notifier
[  136.392716] ppc_notifier: mutex
[  136.392719] ppc =3D 0
[  136.392720] ppc_notifier: verify within
[  136.392722] ppc =3D 0 freq-limit 1833000
[  136.392725] ppc_notifier
[  136.440810] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.442914] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.644420] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.646045] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.647115] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.647118] acpi_cpufreq: get_cur_val =3D 2860
[  136.647120] acpi_cpufreq: cur freq =3D 1833000
[  136.647123] ppc_notifier
[  136.647125] ppc_notifier: mutex
[  136.647127] ppc =3D 0
[  136.647128] ppc_notifier: verify within
[  136.647130] ppc =3D 0 freq-limit 1833000
[  136.647132] ppc_notifier
[  136.647144] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.647148] acpi_cpufreq: get_cur_val =3D 2860
[  136.647149] acpi_cpufreq: cur freq =3D 1833000
[  136.647151] ppc_notifier
[  136.647152] ppc_notifier: mutex
[  136.647154] ppc =3D 0
[  136.647155] ppc_notifier: verify within
[  136.647157] ppc =3D 0 freq-limit 1833000
[  136.647159] ppc_notifier
[  136.647184] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.647187] acpi_cpufreq: get_cur_val =3D 2077
[  136.647188] acpi_cpufreq: cur freq =3D 1333000
[  136.647190] ppc_notifier
[  136.647192] ppc_notifier: mutex
[  136.647195] ppc =3D 0
[  136.647196] ppc_notifier: verify within
[  136.647199] ppc =3D 0 freq-limit 1833000
[  136.647201] ppc_notifier
[  136.647207] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.647210] acpi_cpufreq: get_cur_val =3D 2077
[  136.647212] acpi_cpufreq: cur freq =3D 1333000
[  136.647214] ppc_notifier
[  136.647216] ppc_notifier: mutex
[  136.647218] ppc =3D 0
[  136.647220] ppc_notifier: verify within
[  136.647222] ppc =3D 0 freq-limit 1833000
[  136.647225] ppc_notifier
[  136.682938] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.682942] acpi_cpufreq: get_cur_val =3D 2077
[  136.682945] acpi_cpufreq: cur freq =3D 1333000
[  136.682948] ppc_notifier
[  136.682950] ppc_notifier: mutex
[  136.682953] ppc =3D 0
[  136.682955] ppc_notifier: verify within
[  136.682957] ppc =3D 0 freq-limit 1833000
[  136.682960] ppc_notifier
[  136.682966] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.682971] acpi_cpufreq: get_cur_val =3D 2077
[  136.682973] acpi_cpufreq: cur freq =3D 1333000
[  136.682975] ppc_notifier
[  136.682976] ppc_notifier: mutex
[  136.682979] ppc =3D 0
[  136.682980] ppc_notifier: verify within
[  136.682983] ppc =3D 0 freq-limit 1833000
[  136.682986] ppc_notifier
[  136.682995] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.682997] acpi_cpufreq: get_cur_val =3D 2077
[  136.682999] acpi_cpufreq: cur freq =3D 1333000
[  136.683001] ppc_notifier
[  136.683002] ppc_notifier: mutex
[  136.683005] ppc =3D 0
[  136.683007] ppc_notifier: verify within
[  136.683009] ppc =3D 0 freq-limit 1833000
[  136.683012] ppc_notifier
[  136.683017] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.683020] acpi_cpufreq: get_cur_val =3D 2077
[  136.683022] acpi_cpufreq: cur freq =3D 1333000
[  136.683024] ppc_notifier
[  136.683026] ppc_notifier: mutex
[  136.683028] ppc =3D 0
[  136.683030] ppc_notifier: verify within
[  136.683032] ppc =3D 0 freq-limit 1833000
[  136.683035] ppc_notifier
[  136.723227] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.725176] thinkpad_acpi: temperatures (Celsius): 102 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.858107] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.859995] thinkpad_acpi: temperatures (Celsius): 101 44 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  136.861066] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.861069] acpi_cpufreq: get_cur_val =3D 2860
[  136.861070] acpi_cpufreq: cur freq =3D 1833000
[  136.861072] ppc_notifier
[  136.861074] ppc_notifier: mutex
[  136.861076] ppc =3D 0
[  136.861077] ppc_notifier: verify within
[  136.861079] ppc =3D 0 freq-limit 1833000
[  136.861081] ppc_notifier
[  136.861090] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.861094] acpi_cpufreq: get_cur_val =3D 2860
[  136.861095] acpi_cpufreq: cur freq =3D 1833000
[  136.861097] ppc_notifier
[  136.861098] ppc_notifier: mutex
[  136.861100] ppc =3D 0
[  136.861101] ppc_notifier: verify within
[  136.861103] ppc =3D 0 freq-limit 1833000
[  136.861105] ppc_notifier
[  136.861130] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.861132] acpi_cpufreq: get_cur_val =3D 2077
[  136.861134] acpi_cpufreq: cur freq =3D 1333000
[  136.861136] ppc_notifier
[  136.861138] ppc_notifier: mutex
[  136.861141] ppc =3D 0
[  136.861142] ppc_notifier: verify within
[  136.861145] ppc =3D 0 freq-limit 1833000
[  136.861147] ppc_notifier
[  136.861153] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.861156] acpi_cpufreq: get_cur_val =3D 2077
[  136.861158] acpi_cpufreq: cur freq =3D 1333000
[  136.861160] ppc_notifier
[  136.861162] ppc_notifier: mutex
[  136.861164] ppc =3D 0
[  136.861166] ppc_notifier: verify within
[  136.861168] ppc =3D 0 freq-limit 1833000
[  136.861171] ppc_notifier
[  136.902990] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.902994] acpi_cpufreq: get_cur_val =3D 2077
[  136.902996] acpi_cpufreq: cur freq =3D 1333000
[  136.902998] ppc_notifier
[  136.903001] ppc_notifier: mutex
[  136.903003] ppc =3D 0
[  136.903005] ppc_notifier: verify within
[  136.903007] ppc =3D 0 freq-limit 1833000
[  136.903011] ppc_notifier
[  136.903016] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.903020] acpi_cpufreq: get_cur_val =3D 2077
[  136.903022] acpi_cpufreq: cur freq =3D 1333000
[  136.903024] ppc_notifier
[  136.903026] ppc_notifier: mutex
[  136.903028] ppc =3D 0
[  136.903030] ppc_notifier: verify within
[  136.903032] ppc =3D 0 freq-limit 1833000
[  136.903035] ppc_notifier
[  136.903044] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  136.903047] acpi_cpufreq: get_cur_val =3D 2077
[  136.903048] acpi_cpufreq: cur freq =3D 1333000
[  136.903050] ppc_notifier
[  136.903052] ppc_notifier: mutex
[  136.903055] ppc =3D 0
[  136.903056] ppc_notifier: verify within
[  136.903058] ppc =3D 0 freq-limit 1833000
[  136.903061] ppc_notifier
[  136.903066] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  136.903070] acpi_cpufreq: get_cur_val =3D 2077
[  136.903072] acpi_cpufreq: cur freq =3D 1333000
[  136.903074] ppc_notifier
[  136.903075] ppc_notifier: mutex
[  136.903078] ppc =3D 0
[  136.903079] ppc_notifier: verify within
[  136.903082] ppc =3D 0 freq-limit 1833000
[  136.903085] ppc_notifier
[  136.948071] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  136.949897] thinkpad_acpi: temperatures (Celsius): 101 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  137.086936] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  137.088983] thinkpad_acpi: temperatures (Celsius): 101 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  137.090111] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.090114] acpi_cpufreq: get_cur_val =3D 2860
[  137.090116] acpi_cpufreq: cur freq =3D 1833000
[  137.090119] ppc_notifier
[  137.090120] ppc_notifier: mutex
[  137.090122] ppc =3D 0
[  137.090124] ppc_notifier: verify within
[  137.090125] ppc =3D 0 freq-limit 1833000
[  137.090128] ppc_notifier
[  137.090139] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.090143] acpi_cpufreq: get_cur_val =3D 2860
[  137.090144] acpi_cpufreq: cur freq =3D 1833000
[  137.090146] ppc_notifier
[  137.090147] ppc_notifier: mutex
[  137.090149] ppc =3D 0
[  137.090150] ppc_notifier: verify within
[  137.090152] ppc =3D 0 freq-limit 1833000
[  137.090154] ppc_notifier
[  137.090179] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.090181] acpi_cpufreq: get_cur_val =3D 2077
[  137.090183] acpi_cpufreq: cur freq =3D 1333000
[  137.090185] ppc_notifier
[  137.090187] ppc_notifier: mutex
[  137.090190] ppc =3D 0
[  137.090191] ppc_notifier: verify within
[  137.090194] ppc =3D 0 freq-limit 1833000
[  137.090196] ppc_notifier
[  137.090202] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.090205] acpi_cpufreq: get_cur_val =3D 2077
[  137.090207] acpi_cpufreq: cur freq =3D 1333000
[  137.090209] ppc_notifier
[  137.090211] ppc_notifier: mutex
[  137.090213] ppc =3D 0
[  137.090215] ppc_notifier: verify within
[  137.090217] ppc =3D 0 freq-limit 1833000
[  137.090220] ppc_notifier
[  137.130201] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.130205] acpi_cpufreq: get_cur_val =3D 2077
[  137.130207] acpi_cpufreq: cur freq =3D 1333000
[  137.130209] ppc_notifier
[  137.130212] ppc_notifier: mutex
[  137.130215] ppc =3D 0
[  137.130216] ppc_notifier: verify within
[  137.130219] ppc =3D 0 freq-limit 1833000
[  137.130222] ppc_notifier
[  137.130227] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.130232] acpi_cpufreq: get_cur_val =3D 2077
[  137.130234] acpi_cpufreq: cur freq =3D 1333000
[  137.130236] ppc_notifier
[  137.130237] ppc_notifier: mutex
[  137.130240] ppc =3D 0
[  137.130242] ppc_notifier: verify within
[  137.130244] ppc =3D 0 freq-limit 1833000
[  137.130247] ppc_notifier
[  137.130256] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.130258] acpi_cpufreq: get_cur_val =3D 2077
[  137.130260] acpi_cpufreq: cur freq =3D 1333000
[  137.130262] ppc_notifier
[  137.130264] ppc_notifier: mutex
[  137.130266] ppc =3D 0
[  137.130268] ppc_notifier: verify within
[  137.130270] ppc =3D 0 freq-limit 1833000
[  137.130273] ppc_notifier
[  137.130278] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.130281] acpi_cpufreq: get_cur_val =3D 2077
[  137.130283] acpi_cpufreq: cur freq =3D 1333000
[  137.130285] ppc_notifier
[  137.130287] ppc_notifier: mutex
[  137.130289] ppc =3D 0
[  137.130291] ppc_notifier: verify within
[  137.130293] ppc =3D 0 freq-limit 1833000
[  137.130296] ppc_notifier
[  137.174462] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  137.176644] thinkpad_acpi: temperatures (Celsius): 101 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  137.307761] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  137.309825] thinkpad_acpi: temperatures (Celsius): 101 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  137.310877] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.310879] acpi_cpufreq: get_cur_val =3D 2860
[  137.310881] acpi_cpufreq: cur freq =3D 1833000
[  137.310883] ppc_notifier
[  137.310884] ppc_notifier: mutex
[  137.310886] ppc =3D 0
[  137.310887] ppc_notifier: verify within
[  137.310889] ppc =3D 0 freq-limit 1833000
[  137.310891] ppc_notifier
[  137.310900] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.310903] acpi_cpufreq: get_cur_val =3D 2860
[  137.310905] acpi_cpufreq: cur freq =3D 1833000
[  137.310906] ppc_notifier
[  137.310908] ppc_notifier: mutex
[  137.310910] ppc =3D 0
[  137.310911] ppc_notifier: verify within
[  137.310912] ppc =3D 0 freq-limit 1833000
[  137.310914] ppc_notifier
[  137.310940] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.310942] acpi_cpufreq: get_cur_val =3D 2077
[  137.310944] acpi_cpufreq: cur freq =3D 1333000
[  137.310946] ppc_notifier
[  137.310948] ppc_notifier: mutex
[  137.310950] ppc =3D 0
[  137.310952] ppc_notifier: verify within
[  137.310954] ppc =3D 0 freq-limit 1833000
[  137.310957] ppc_notifier
[  137.310962] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.310966] acpi_cpufreq: get_cur_val =3D 2077
[  137.310968] acpi_cpufreq: cur freq =3D 1333000
[  137.310970] ppc_notifier
[  137.310971] ppc_notifier: mutex
[  137.310974] ppc =3D 0
[  137.310975] ppc_notifier: verify within
[  137.310978] ppc =3D 0 freq-limit 1833000
[  137.310981] ppc_notifier
[  137.351933] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.351938] acpi_cpufreq: get_cur_val =3D 2077
[  137.351941] acpi_cpufreq: cur freq =3D 1333000
[  137.351944] ppc_notifier
[  137.351947] ppc_notifier: mutex
[  137.351950] ppc =3D 0
[  137.351952] ppc_notifier: verify within
[  137.351954] ppc =3D 0 freq-limit 1833000
[  137.351957] ppc_notifier
[  137.351963] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.351967] acpi_cpufreq: get_cur_val =3D 2077
[  137.351969] acpi_cpufreq: cur freq =3D 1333000
[  137.351971] ppc_notifier
[  137.351973] ppc_notifier: mutex
[  137.351976] ppc =3D 0
[  137.351977] ppc_notifier: verify within
[  137.351979] ppc =3D 0 freq-limit 1833000
[  137.351982] ppc_notifier
[  137.351991] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.351994] acpi_cpufreq: get_cur_val =3D 2077
[  137.351995] acpi_cpufreq: cur freq =3D 1333000
[  137.351997] ppc_notifier
[  137.351999] ppc_notifier: mutex
[  137.352032] ppc =3D 0
[  137.352034] ppc_notifier: verify within
[  137.352036] ppc =3D 0 freq-limit 1833000
[  137.352040] ppc_notifier
[  137.352046] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.352050] acpi_cpufreq: get_cur_val =3D 2860
[  137.352052] acpi_cpufreq: cur freq =3D 1833000
[  137.352054] ppc_notifier
[  137.352056] ppc_notifier: mutex
[  137.352058] ppc =3D 0
[  137.352060] ppc_notifier: verify within
[  137.352062] ppc =3D 0 freq-limit 1833000
[  137.352065] ppc_notifier
[  137.408105] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something=
 is extremely hot!
[  137.410251] thinkpad_acpi: temperatures (Celsius): 101 45 N/A 83 33 N/A =
33 N/A 44 53 N/A N/A N/A N/A N/A N/A
[  137.411327] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.411331] acpi_cpufreq: get_cur_val =3D 2860
[  137.411333] acpi_cpufreq: cur freq =3D 1833000
[  137.411336] ppc_notifier
[  137.411337] ppc_notifier: mutex
[  137.411340] ppc =3D 0
[  137.411341] ppc_notifier: verify within
[  137.411343] ppc =3D 0 freq-limit 1833000
[  137.411345] ppc_notifier
[  137.411357] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.411362] acpi_cpufreq: get_cur_val =3D 2860
[  137.411363] acpi_cpufreq: cur freq =3D 1833000
[  137.411365] ppc_notifier
[  137.411366] ppc_notifier: mutex
[  137.411368] ppc =3D 0
[  137.411369] ppc_notifier: verify within
[  137.411371] ppc =3D 0 freq-limit 1833000
[  137.411373] ppc_notifier
[  137.411399] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.411401] acpi_cpufreq: get_cur_val =3D 2077
[  137.411403] acpi_cpufreq: cur freq =3D 1333000
[  137.411405] ppc_notifier
[  137.411407] ppc_notifier: mutex
[  137.411409] ppc =3D 0
[  137.411411] ppc_notifier: verify within
[  137.411413] ppc =3D 0 freq-limit 1833000
[  137.411416] ppc_notifier
[  137.411421] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.411425] acpi_cpufreq: get_cur_val =3D 2077
[  137.411426] acpi_cpufreq: cur freq =3D 1333000
[  137.411428] ppc_notifier
[  137.411430] ppc_notifier: mutex
[  137.411433] ppc =3D 0
[  137.411434] ppc_notifier: verify within
[  137.411436] ppc =3D 0 freq-limit 1833000
[  137.411439] ppc_notifier
[  137.432420] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.432426] acpi_cpufreq: get_cur_val =3D 2077
[  137.432428] acpi_cpufreq: cur freq =3D 1333000
[  137.432431] ppc_notifier
[  137.432434] ppc_notifier: mutex
[  137.432437] ppc =3D 0
[  137.432439] ppc_notifier: verify within
[  137.432441] ppc =3D 0 freq-limit 1833000
[  137.432444] ppc_notifier
[  137.432450] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.432455] acpi_cpufreq: get_cur_val =3D 2077
[  137.432457] acpi_cpufreq: cur freq =3D 1333000
[  137.432459] ppc_notifier
[  137.432460] ppc_notifier: mutex
[  137.432463] ppc =3D 0
[  137.432465] ppc_notifier: verify within
[  137.432467] ppc =3D 0 freq-limit 1833000
[  137.432470] ppc_notifier
[  137.432479] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.432481] acpi_cpufreq: get_cur_val =3D 2077
[  137.432483] acpi_cpufreq: cur freq =3D 1333000
[  137.432485] ppc_notifier
[  137.432486] ppc_notifier: mutex
[  137.432489] ppc =3D 0
[  137.432491] ppc_notifier: verify within
[  137.432493] ppc =3D 0 freq-limit 1833000
[  137.432496] ppc_notifier
[  137.432501] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.432504] acpi_cpufreq: get_cur_val =3D 2077
[  137.432506] acpi_cpufreq: cur freq =3D 1333000
[  137.432508] ppc_notifier
[  137.432510] ppc_notifier: mutex
[  137.432512] ppc =3D 0
[  137.432514] ppc_notifier: verify within
[  137.432516] ppc =3D 0 freq-limit 1833000
[  137.432519] ppc_notifier
[  137.519360] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.519368] acpi_cpufreq: get_cur_val =3D 1555
[  137.519371] acpi_cpufreq: cur freq =3D 1000000
[  137.519376] ppc_notifier
[  137.519380] ppc_notifier: mutex
[  137.519384] ppc =3D 0
[  137.519386] ppc_notifier: verify within
[  137.519390] ppc =3D 0 freq-limit 1833000
[  137.519394] ppc_notifier
[  137.519402] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.519418] acpi_cpufreq: get_cur_val =3D 1555
[  137.519421] acpi_cpufreq: cur freq =3D 1000000
[  137.519424] ppc_notifier
[  137.519426] ppc_notifier: mutex
[  137.519429] ppc =3D 0
[  137.519432] ppc_notifier: verify within
[  137.519435] ppc =3D 0 freq-limit 1833000
[  137.519439] ppc_notifier
[  137.519451] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  137.519453] acpi_cpufreq: get_cur_val =3D 1555
[  137.519456] acpi_cpufreq: cur freq =3D 1000000
[  137.519459] ppc_notifier
[  137.519461] ppc_notifier: mutex
[  137.519464] ppc =3D 0
[  137.519467] ppc_notifier: verify within
[  137.519470] ppc =3D 0 freq-limit 1833000
[  137.519473] ppc_notifier
[  137.519480] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  137.519494] acpi_cpufreq: get_cur_val =3D 1555
[  137.519497] acpi_cpufreq: cur freq =3D 1000000
[  137.519499] ppc_notifier
[  137.519502] ppc_notifier: mutex
[  137.519505] ppc =3D 0
[  137.519507] ppc_notifier: verify within
[  137.519510] ppc =3D 0 freq-limit 1833000
[  137.519514] ppc_notifier
[  140.328890] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  140.328898] acpi_cpufreq: get_cur_val =3D 1555
[  140.328902] acpi_cpufreq: cur freq =3D 1000000
[  140.330699] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  140.330716] acpi_cpufreq: get_cur_val =3D 1555
[  140.330719] acpi_cpufreq: cur freq =3D 1000000
[  145.348754] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  145.348760] acpi_cpufreq: get_cur_val =3D 1555
[  145.348763] acpi_cpufreq: cur freq =3D 1000000
[  145.350109] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  145.350123] acpi_cpufreq: get_cur_val =3D 2077
[  145.350126] acpi_cpufreq: cur freq =3D 1333000
[  150.364673] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  150.364697] acpi_cpufreq: get_cur_val =3D 2077
[  150.364699] acpi_cpufreq: cur freq =3D 1333000
[  150.366043] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  150.366046] acpi_cpufreq: get_cur_val =3D 1555
[  150.366049] acpi_cpufreq: cur freq =3D 1000000
[  155.381086] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  155.381107] acpi_cpufreq: get_cur_val =3D 1555
[  155.381111] acpi_cpufreq: cur freq =3D 1000000
[  155.382906] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  155.382911] acpi_cpufreq: get_cur_val =3D 1555
[  155.382914] acpi_cpufreq: cur freq =3D 1000000
[  160.393065] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  160.393087] acpi_cpufreq: get_cur_val =3D 1555
[  160.393090] acpi_cpufreq: cur freq =3D 1000000
[  160.394879] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  160.394884] acpi_cpufreq: get_cur_val =3D 1555
[  160.394887] acpi_cpufreq: cur freq =3D 1000000
[  165.405693] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  165.405722] acpi_cpufreq: get_cur_val =3D 1555
[  165.405725] acpi_cpufreq: cur freq =3D 1000000
[  165.407516] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  165.407520] acpi_cpufreq: get_cur_val =3D 1555
[  165.407523] acpi_cpufreq: cur freq =3D 1000000
[  170.424930] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  170.424954] acpi_cpufreq: get_cur_val =3D 1555
[  170.424956] acpi_cpufreq: cur freq =3D 1000000
[  170.426303] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  170.426307] acpi_cpufreq: get_cur_val =3D 2077
[  170.426309] acpi_cpufreq: cur freq =3D 1333000
[  175.441594] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  175.441622] acpi_cpufreq: get_cur_val =3D 1555
[  175.441626] acpi_cpufreq: cur freq =3D 1000000
[  175.443413] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  175.443418] acpi_cpufreq: get_cur_val =3D 1555
[  175.443421] acpi_cpufreq: cur freq =3D 1000000
[  180.461261] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  180.461288] acpi_cpufreq: get_cur_val =3D 1555
[  180.461292] acpi_cpufreq: cur freq =3D 1000000
[  180.463076] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  180.463081] acpi_cpufreq: get_cur_val =3D 1555
[  180.463084] acpi_cpufreq: cur freq =3D 1000000
[  185.481592] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  185.481620] acpi_cpufreq: get_cur_val =3D 1555
[  185.481623] acpi_cpufreq: cur freq =3D 1000000
[  185.483408] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  185.483413] acpi_cpufreq: get_cur_val =3D 1555
[  185.483416] acpi_cpufreq: cur freq =3D 1000000
[  190.501516] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  190.501527] acpi_cpufreq: get_cur_val =3D 1555
[  190.501531] acpi_cpufreq: cur freq =3D 1000000
[  190.505037] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  190.505041] acpi_cpufreq: get_cur_val =3D 2860
[  190.505043] acpi_cpufreq: cur freq =3D 1833000
[  195.521440] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  195.521460] acpi_cpufreq: get_cur_val =3D 1555
[  195.521463] acpi_cpufreq: cur freq =3D 1000000
[  195.523250] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  195.523255] acpi_cpufreq: get_cur_val =3D 1555
[  195.523258] acpi_cpufreq: cur freq =3D 1000000
[  200.541525] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  200.541533] acpi_cpufreq: get_cur_val =3D 1555
[  200.541537] acpi_cpufreq: cur freq =3D 1000000
[  200.543321] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  200.543346] acpi_cpufreq: get_cur_val =3D 1555
[  200.543349] acpi_cpufreq: cur freq =3D 1000000
[  205.554335] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  205.554341] acpi_cpufreq: get_cur_val =3D 2077
[  205.554343] acpi_cpufreq: cur freq =3D 1333000
[  205.555333] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  205.555338] acpi_cpufreq: get_cur_val =3D 2860
[  205.555340] acpi_cpufreq: cur freq =3D 1833000
[  210.572978] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  210.573002] acpi_cpufreq: get_cur_val =3D 2077
[  210.573005] acpi_cpufreq: cur freq =3D 1333000
[  210.574346] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  210.574350] acpi_cpufreq: get_cur_val =3D 1555
[  210.574352] acpi_cpufreq: cur freq =3D 1000000
[  215.593519] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  215.593540] acpi_cpufreq: get_cur_val =3D 1555
[  215.593544] acpi_cpufreq: cur freq =3D 1000000
[  215.595329] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  215.595333] acpi_cpufreq: get_cur_val =3D 1555
[  215.595336] acpi_cpufreq: cur freq =3D 1000000
[  220.613320] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  220.613347] acpi_cpufreq: get_cur_val =3D 1555
[  220.613351] acpi_cpufreq: cur freq =3D 1000000
[  220.615138] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  220.615143] acpi_cpufreq: get_cur_val =3D 1555
[  220.615146] acpi_cpufreq: cur freq =3D 1000000
[  225.633772] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  225.633799] acpi_cpufreq: get_cur_val =3D 1555
[  225.633803] acpi_cpufreq: cur freq =3D 1000000
[  225.635590] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  225.635595] acpi_cpufreq: get_cur_val =3D 1555
[  225.635598] acpi_cpufreq: cur freq =3D 1000000
[  230.653179] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  230.653199] acpi_cpufreq: get_cur_val =3D 1555
[  230.653203] acpi_cpufreq: cur freq =3D 1000000
[  230.654987] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  230.654992] acpi_cpufreq: get_cur_val =3D 1555
[  230.654995] acpi_cpufreq: cur freq =3D 1000000
[  235.673724] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  235.673752] acpi_cpufreq: get_cur_val =3D 1555
[  235.673756] acpi_cpufreq: cur freq =3D 1000000
[  235.675544] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  235.675549] acpi_cpufreq: get_cur_val =3D 1555
[  235.675552] acpi_cpufreq: cur freq =3D 1000000
[  240.693593] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  240.693613] acpi_cpufreq: get_cur_val =3D 1555
[  240.693617] acpi_cpufreq: cur freq =3D 1000000
[  240.695404] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  240.695409] acpi_cpufreq: get_cur_val =3D 1555
[  240.695412] acpi_cpufreq: cur freq =3D 1000000
[  245.702164] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  245.702171] acpi_cpufreq: get_cur_val =3D 2860
[  245.702173] acpi_cpufreq: cur freq =3D 1833000
[  245.703153] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  245.703156] acpi_cpufreq: get_cur_val =3D 1555
[  245.703157] acpi_cpufreq: cur freq =3D 1000000
[  250.717440] acpi_cpufreq: get_cur_freq_on_cpu (0)
[  250.717469] acpi_cpufreq: get_cur_val =3D 1555
[  250.717473] acpi_cpufreq: cur freq =3D 1000000
[  250.719259] acpi_cpufreq: get_cur_freq_on_cpu (1)
[  250.719263] acpi_cpufreq: get_cur_val =3D 1555
[  250.719266] acpi_cpufreq: cur freq =3D 1000000


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgd6s8ACgkQMOfwapXb+vIJ3gCfdTl0pp/tyrueP+Z7mwHOxop4
DLgAn3Y3DB/m1dls80ncOAFBgdJQP0+i
=4CuK
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
