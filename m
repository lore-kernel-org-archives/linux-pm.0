From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Mon, 4 Apr 2016 07:13:51 +0200
Message-ID: <CA+icZUVhnH563=8zyrsvH86y0HTqeT57OJ1ETES5_ZsDOwae-w@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<1459376311.13525.108.camel@linux.intel.com>
	<003b01d18ad6$831941c0$894bc540$@net>
	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
	<002301d18b59$d208fe50$761afaf0$@net>
	<CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>
	<CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>
	<1459610923.5912.36.camel@linux.intel.com>
	<CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com>
	<CA+icZUUCEgs1-eeRje4zb_Lj=0=hWM8OPvoKrquMCAXAj=Gy4g@mail.gmail.com>
	<001201d18ddb$0102ccd0$03086670$@net>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35531 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbcDDFNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 01:13:53 -0400
In-Reply-To: <001201d18ddb$0102ccd0$03086670$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>

On Sun, Apr 3, 2016 at 8:59 PM, Doug Smythies <dsmythies@telus.net> wro=
te:
> On 2016.04.02 11:21 Sedat Dilek wrote:
>> On Sat, Apr 2, 2016 at 7:19 PM, J=C3=B6rg Otte wrote:
>>> 2016-04-02 17:28 GMT+02:00 Srinivas Pandruvada wrote:
>>>>

Hi Doug,

are you involved in the Ubuntu-OS? Developer for Canonical?

>>>> If you are using Ubuntu, the OS has a script which will automatica=
lly
>>>> change from performance.
>>>> Doug can give more information on this script.
>>
>>> maybe:
>>> /etc/init.d/ondemand
>
> Yes.
>
>> With CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy (linux-pm.git#linux-n=
ext) I get...
>>
>> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
>> acpi-cpufreq
>> acpi-cpufreq
>> acpi-cpufreq
>> acpi-cpufreq
>>
>> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> ondemand
>> ondemand
>> ondemand
>> ondemand
>
> Yes, those are the expected results for the acpi-cpufreq CPU frequenc=
y scaling driver.
> You should be able to observe the governor set to sched util for the =
first minute
> after re-boot and/or if you set it yourself after the /etc/init.d/ond=
emand script
> has finished (i.e. more than 1 minute after re-boot.)
>

I have hardcoded to use "schedutil" driver after one minute in
/etc/init.d/ondemand for testing-purposes and not to fall back to
"ondemand".

>> ...is there a difference when using intel_pstate as scaling_driver?
>
> Yes, but only because there are different available governors for the=
 two drivers.
>
>> Are the scripts of Ubuntu working properly with acpi-cpufreq (only)?
>
> As far as I know the /etc/init.d/ondemand is working properly. It set=
s the acpi-cpufreq
> driver to use the "ondemand" governor and it sets the intel_pstate dr=
iver to use the
> "powersave" governor.
>

I haven't looked at this exactly.
The ondemand-script is not saying to fall back to "powersave" in case
of intel_pstate-driver (here on Ubuntu/precise).

- Sedat -
