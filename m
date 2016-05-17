From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Wed, 18 May 2016 01:16:06 +0200
Message-ID: <CA+icZUVXffgzNBAMHUdzHzX3pSDm8j=Uq3CAK8zVqsdT0UunNw@mail.gmail.com>
References: <CA+icZUV0Mxu+fvrmpJmnDjLmxpSd83hDM5od0_1kw4gEm5aaEw@mail.gmail.com>
	<573B4C2A.4010205@intel.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35183 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcEQXQI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 19:16:08 -0400
Received: by mail-vk0-f66.google.com with SMTP id e126so4625677vkb.2
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2016 16:16:07 -0700 (PDT)
In-Reply-To: <573B4C2A.4010205@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-pm@vger.kernel.org

On 5/17/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
> On 5/17/2016 5:30 PM, Sedat Dilek wrote:
>> Hi,
>
> Hi,
>
> You have a broken address of linux-pm (it leads to nowhere).
>

Grrr, yeah you are right.

>> I wonder if the Kconfig logic is correct when using
>> CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y in combination with
>> intel_pstate driver for X86 architecture
>>
>> The available scaling-governors for intel_pstate are: performance
>> powersave.
>>
>> Only acpi-cpufreq can use the new schedutil governor.
>
> The right way to say that would be that intel_pstate doesn't work with
> cpufreq governors.
>
> scalling_governor is just used by intel_pstate as an interface for
> choosing the mode it works in and it always uses its own built-in
> "governor".  And BTW, intel_pstate "powersave" is not the same as the
> cpufreq's "powersave" even.
>
>> Shouldn't it be prevented from selecting schedutil governor as default
>> when CONFIG_X86_INTEL_PSTATE=y is set?
>
> That should apply to "ondemand" too and it doesn't, so no.
>
> "schedutil" is just a regular cpufreq governor and it doesn't care about
> intel_pstate.
>
>> It makes no real sense to me.
>>
>> Ubuntu has in it's kernels CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y.
>>
>> What are the alternatives?
>> Set CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y.
>
> You can choose every cpufreq governor as the default.  There are 6 of
> then now in the tree.
>
>> BTW, I cannot change my scaling-driver...
>> ...intel_pstate -> acpi-cpufreq...
>>
>> root# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C echo -n
>> acpi-cpufreq > /sys/devices/system/cpu/cpufreq/${p}/scaling_driver ;
>> done
>>
>> Attached is also a modified /etc/init.d/ondemand script from my
>> Ubuntu/precise AMD64 to use and fallback to schedutil governor.
>
> No, you can't change the scaling driver this way.
>
> It actually is not possible to change from intel_pstate to anything else
> now.  To run without intel_pstate, you need to add
> "intel_pstate=disable" to the kernel command line.
>

OK, I will try intel_pstate=disable in my k-c-l.

Is there no way to switch between acpi-cpufreq and intel_pstate on the fly?
Did not look in the Kconfig sections...
Can I built both as modules?
Then unload and load the other?

- Sedat -
