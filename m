From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Sat, 2 Apr 2016 20:20:32 +0200
Message-ID: <CA+icZUUCEgs1-eeRje4zb_Lj=0=hWM8OPvoKrquMCAXAj=Gy4g@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<1459376311.13525.108.camel@linux.intel.com>
	<003b01d18ad6$831941c0$894bc540$@net>
	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
	<002301d18b59$d208fe50$761afaf0$@net>
	<CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>
	<CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>
	<1459610923.5912.36.camel@linux.intel.com>
	<CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34663 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbcDBSUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2016 14:20:33 -0400
In-Reply-To: <CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Apr 2, 2016 at 7:19 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wro=
te:
> 2016-04-02 17:28 GMT+02:00 Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>:
>>
>> On Sat, 2016-04-02 at 08:30 +0200, Sedat Dilek wrote:
>>> > I am trying CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy from
>>> > linux-pm.git#linux-next out of curiosity...
>>> >
>>> > $ ./scripts/diffconfig /boot/config-$(uname -r) .config
>>> >  CPU_FREQ_DEFAULT_GOV_PERFORMANCE y -> n
>>> > +CPU_FREQ_DEFAULT_GOV_SCHEDUTIL y
>>> > +CPU_FREQ_GOV_ATTR_SET y
>>> > +CPU_FREQ_GOV_SCHEDUTIL y
>>> >
>>> > ...will report.
>>> >
>>>
>>> Not sure why I see here "powersave".
>>> Does Intel-PState driver not support CPU_FREQ_GOV_SCHEDUTIL?
>>>
>>> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
>>> intel_pstate
>>> intel_pstate
>>> intel_pstate
>>> intel_pstate
>>>
>>> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>>> powersave
>>> powersave
>>> powersave
>>> powersave
>>
>> If you are using Ubuntu, the OS has a script which will automaticall=
y
>> change from performance.
>> Doug can give more information on this script.
>>
>> Thanks,
>> Srinivas
>>
>>
>>
>>>
>>> See also attached files.
>>>
>>> - sed@ -
>
> maybe:
> /etc/init.d/ondemand
>

With CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy (linux-pm.git#linux-next=
) I get...

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
acpi-cpufreq
acpi-cpufreq
acpi-cpufreq
acpi-cpufreq

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
ondemand
ondemand
ondemand
ondemand

=2E..is there a difference when using intel_pstate as scaling_driver?
Are the scripts of Ubuntu working properly with acpi-cpufreq (only)?

- Sedat -
