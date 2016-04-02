From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Sat, 2 Apr 2016 19:19:07 +0200
Message-ID: <CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<1459376311.13525.108.camel@linux.intel.com>
	<003b01d18ad6$831941c0$894bc540$@net>
	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
	<002301d18b59$d208fe50$761afaf0$@net>
	<CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>
	<CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>
	<1459610923.5912.36.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459610923.5912.36.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: sedat.dilek@gmail.com, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2016-04-02 17:28 GMT+02:00 Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
>
> On Sat, 2016-04-02 at 08:30 +0200, Sedat Dilek wrote:
>> > I am trying CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy from
>> > linux-pm.git#linux-next out of curiosity...
>> >
>> > $ ./scripts/diffconfig /boot/config-$(uname -r) .config
>> >  CPU_FREQ_DEFAULT_GOV_PERFORMANCE y -> n
>> > +CPU_FREQ_DEFAULT_GOV_SCHEDUTIL y
>> > +CPU_FREQ_GOV_ATTR_SET y
>> > +CPU_FREQ_GOV_SCHEDUTIL y
>> >
>> > ...will report.
>> >
>>
>> Not sure why I see here "powersave".
>> Does Intel-PState driver not support CPU_FREQ_GOV_SCHEDUTIL?
>>
>> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
>> intel_pstate
>> intel_pstate
>> intel_pstate
>> intel_pstate
>>
>> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> powersave
>> powersave
>> powersave
>> powersave
>
> If you are using Ubuntu, the OS has a script which will automatically
> change from performance.
> Doug can give more information on this script.
>
> Thanks,
> Srinivas
>
>
>
>>
>> See also attached files.
>>
>> - sed@ -

maybe:
/etc/init.d/ondemand

Thanks, J=C3=B6rg
