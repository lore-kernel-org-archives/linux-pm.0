From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Sun, 3 Apr 2016 11:59:51 -0700
Message-ID: <001201d18ddb$0102ccd0$03086670$@net>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>	<1459376311.13525.108.camel@linux.intel.com>	<003b01d18ad6$831941c0$894bc540$@net>	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>	<002301d18b59$d208fe50$761afaf0$@net>	<CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>	<CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>	<1459610923.5912.36.camel@linux.intel.com>	<CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com> <CA+icZUUCEgs1-eeRje4zb_Lj=0=hWM8OPvoKrquMCAXAj=Gy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta5.telus.net ([209.171.16.78]:56128 "EHLO cmta5.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbcDCS7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2016 14:59:54 -0400
In-Reply-To: <CA+icZUUCEgs1-eeRje4zb_Lj=0=hWM8OPvoKrquMCAXAj=Gy4g@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>

On 2016.04.02 11:21 Sedat Dilek wrote:
> On Sat, Apr 2, 2016 at 7:19 PM, J=C3=B6rg Otte wrote:
>> 2016-04-02 17:28 GMT+02:00 Srinivas Pandruvada wrote:
>>>
>>> If you are using Ubuntu, the OS has a script which will automatical=
ly
>>> change from performance.
>>> Doug can give more information on this script.
>
>> maybe:
>> /etc/init.d/ondemand

Yes.

> With CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy (linux-pm.git#linux-ne=
xt) I get...
>
> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
> acpi-cpufreq
> acpi-cpufreq
> acpi-cpufreq
> acpi-cpufreq
>
> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> ondemand
> ondemand
> ondemand
> ondemand

Yes, those are the expected results for the acpi-cpufreq CPU frequency =
scaling driver.
You should be able to observe the governor set to sched util for the fi=
rst minute
after re-boot and/or if you set it yourself after the /etc/init.d/ondem=
and script
has finished (i.e. more than 1 minute after re-boot.)

> ...is there a difference when using intel_pstate as scaling_driver?

Yes, but only because there are different available governors for the t=
wo drivers.

> Are the scripts of Ubuntu working properly with acpi-cpufreq (only)?

As far as I know the /etc/init.d/ondemand is working properly. It sets =
the acpi-cpufreq
driver to use the "ondemand" governor and it sets the intel_pstate driv=
er to use the
"powersave" governor.

=2E.. Doug


