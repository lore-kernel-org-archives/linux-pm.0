From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Sat, 02 Apr 2016 08:28:43 -0700
Message-ID: <1459610923.5912.36.camel@linux.intel.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	 <1459376311.13525.108.camel@linux.intel.com>
	 <003b01d18ad6$831941c0$894bc540$@net>
	 <CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
	 <002301d18b59$d208fe50$761afaf0$@net>
	 <CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>
	 <CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@gmail.com, Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Sat, 2016-04-02 at 08:30 +0200, Sedat Dilek wrote:
> > I am trying CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy from
> > linux-pm.git#linux-next out of curiosity...
> >=20
> > $ ./scripts/diffconfig /boot/config-$(uname -r) .config
> > =C2=A0CPU_FREQ_DEFAULT_GOV_PERFORMANCE y -> n
> > +CPU_FREQ_DEFAULT_GOV_SCHEDUTIL y
> > +CPU_FREQ_GOV_ATTR_SET y
> > +CPU_FREQ_GOV_SCHEDUTIL y
> >=20
> > ...will report.
> >=20
>=20
> Not sure why I see here "powersave".
> Does Intel-PState driver not support CPU_FREQ_GOV_SCHEDUTIL?
>=20
> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
> intel_pstate
> intel_pstate
> intel_pstate
> intel_pstate
>=20
> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> powersave
> powersave
> powersave
> powersave

If you are using Ubuntu, the OS has a script which will automatically
change from performance.
Doug can give more information on this script.

Thanks,
Srinivas



>=20
> See also attached files.
>=20
> - sed@ -
