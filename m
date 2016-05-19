From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Thu, 19 May 2016 14:53:34 +0200
Message-ID: <CAJZ5v0g1-KT5Jnh2BYOd66GkkvyTkUe0JNJ5_fxQa4wNvr9fAQ@mail.gmail.com>
References: <CA+icZUV0Mxu+fvrmpJmnDjLmxpSd83hDM5od0_1kw4gEm5aaEw@mail.gmail.com>
	<573B4C2A.4010205@intel.com>
	<CA+icZUVXffgzNBAMHUdzHzX3pSDm8j=Uq3CAK8zVqsdT0UunNw@mail.gmail.com>
	<573BA6C6.901@intel.com>
	<CA+icZUVotMFEXSJ1BNY72zQfB-L-PJbyR_31LK8Obje7YjNJsA@mail.gmail.com>
	<CAJZ5v0htU2WyqwNBcfSG1+AH9iB4LDd_tH1GN604rCyrahwbyw@mail.gmail.com>
	<CA+icZUXV3mz9Yr05o5zHLOcXwYRWydtXZOuLnE10Zy3RwzOHUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34901 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbcESMxg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 08:53:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id s63so6235697wme.2
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 05:53:35 -0700 (PDT)
In-Reply-To: <CA+icZUXV3mz9Yr05o5zHLOcXwYRWydtXZOuLnE10Zy3RwzOHUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, May 19, 2016 at 2:10 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, May 19, 2016 at 1:04 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> On 5/18/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>>>> On 5/18/2016 1:16 AM, Sedat Dilek wrote:
>>>>> On 5/17/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>>>>>> On 5/17/2016 5:30 PM, Sedat Dilek wrote:

[cut]

> [ Sorry, forgot to attach my linux-config and dmesg-output ]
>
> No, schedutil is not my default-governor.
>
>> The other way to work around it is to unload acpi-cpufreq and
>> cpufreq_stat and then load the driver again.
>>
>
> I have in my linux-config...
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_STAT_DETAILS=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> CONFIG_X86_PCC_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> CONFIG_X86_POWERNOW_K8=y
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> # CONFIG_X86_P4_CLOCKMOD is not set
>
> Which of the Kconfigs should be compiled as a module (if available as tristate)?
>
> CONFIG_CPU_FREQ_STAT

That needs to be a module.

I guess that should be sufficient, because then you should be able to
simply unload it, but do that before you switch the governor to
schedutil.

> CONFIG_X86_ACPI_CPUFREQ

That can be a module too.

> CONFIG_X86_ACPI_CPUFREQ_CPB

You don't need this one on Intel hardware.
