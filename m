From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Thu, 19 May 2016 18:16:27 +0200
Message-ID: <CA+icZUVse8j8HYnjcYTK7YFaUXwZCLL321yTdwqcMoEN7o+=Eg@mail.gmail.com>
References: <CA+icZUV0Mxu+fvrmpJmnDjLmxpSd83hDM5od0_1kw4gEm5aaEw@mail.gmail.com>
	<573B4C2A.4010205@intel.com>
	<CA+icZUVXffgzNBAMHUdzHzX3pSDm8j=Uq3CAK8zVqsdT0UunNw@mail.gmail.com>
	<573BA6C6.901@intel.com>
	<CA+icZUVotMFEXSJ1BNY72zQfB-L-PJbyR_31LK8Obje7YjNJsA@mail.gmail.com>
	<CAJZ5v0htU2WyqwNBcfSG1+AH9iB4LDd_tH1GN604rCyrahwbyw@mail.gmail.com>
	<CA+icZUXV3mz9Yr05o5zHLOcXwYRWydtXZOuLnE10Zy3RwzOHUg@mail.gmail.com>
	<CAJZ5v0g1-KT5Jnh2BYOd66GkkvyTkUe0JNJ5_fxQa4wNvr9fAQ@mail.gmail.com>
	<CA+icZUU3wJ7PFiYgr2DW_Q4vak13TNhzw8AySkFFkuTigZk16g@mail.gmail.com>
	<CAJZ5v0iMfT6WPx_ighZ7WTRjTo=qz9EjYmxBoc_YNCLVL3JOZw@mail.gmail.com>
	<CA+icZUWJhEVp4GwHQsMTeLLPqbZw7de8vfwtgm2=r6wbiStMFw@mail.gmail.com>
	<CAJZ5v0izrrssFwjtNTVAhHVywcfL9OzdiTPnSOPEFXWCGuxR3A@mail.gmail.com>
	<CAJZ5v0hWDKmd=8U-EHMMCYV3_8NgwKxbXs6sQL0Hiu3ghMW6Dw@mail.gmail.com>
	<CA+icZUVq5wGwM2kyLo3cnRxN7kH9F_h+fzVeELJx7ytZR60M-g@mail.gmail.com>
	<CAJZ5v0j+sshsUrVcTOpu5ORoNrafw4UKo=Eu_gi50Ckb7qLYYw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34980 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbcESQQ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 12:16:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id e126so12636648vkb.2
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 09:16:28 -0700 (PDT)
In-Reply-To: <CAJZ5v0j+sshsUrVcTOpu5ORoNrafw4UKo=Eu_gi50Ckb7qLYYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, May 19, 2016 at 4:50 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Thu, May 19, 2016 at 4:04 PM, Rafael J. Wysocki <rafael@kernel.org>
>>> wrote:
>>>> On Thu, May 19, 2016 at 3:54 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>>> wrote:
>>>>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>> On Thu, May 19, 2016 at 3:41 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>>>>> wrote:
>>>>>>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>>> On Thu, May 19, 2016 at 2:10 PM, Sedat Dilek
>>>>>>>> <sedat.dilek@gmail.com>
>>>>>>>> wrote:
>>>>>>>>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>>>>> On Thu, May 19, 2016 at 1:04 PM, Sedat Dilek
>>>>>>>>>> <sedat.dilek@gmail.com>
>>>>>>>>>> wrote:
>>>>>>
>>>>>> [cut]
>>>>>>
>>>>>>>
>>>>>>> With these changes...
>>>>>>>
>>>>>>> $ ./scripts/diffconfig /boot/config-4.6.0-4-iniza-small
>>>>>>> /boot/config-4.6.0-5-iniza-small
>>>>>>>  CPU_FREQ_STAT y -> m
>>>>>>>  X86_ACPI_CPUFREQ y -> m
>>>>>>>  X86_POWERNOW_K8 y -> m
>>>>>>>
>>>>>>> ...I still see "Fast frequency switching not enabled"...
>>>>>>>
>>>>>>> $ sudo modprobe -r -v acpi_cpufreq
>>>>>>> [sudo] password for wearefam:
>>>>>>> rmmod acpi_cpufreq
>>>>>>> $ sudo modprobe -r -v cpufreq_stats
>>>>>>> rmmod cpufreq_stats
>>>>>>>
>>>>>>> $ sudo modprobe -v cpufreq_stats
>>>>>>> insmod
>>>>>>> /lib/modules/4.6.0-5-iniza-small/kernel/drivers/cpufreq/cpufreq_stats.ko
>>>>>>
>>>>>> Skip the above modprobe. :-)
>>>>>>
>>>>>
>>>>> If I do not insmod cpufreq_stats (only insmod acpi_cpufreq) then I do
>>>>> not see anything with "cpu fast switching" in my logs.
>>>>> ( I double-checked to have schedutil as running cpufreq-governor. )
>>>>
>>>> That means it has been enabled.
>>>
>>> Actually, you can check if it has been enabled by looking and the
>>> wakeups statistics from powertop.
>>>
>>> Without fast switching you'll see kWork with sugov_work under
>>> "Description" somewhere close to the top of the list.
>>>
>>
>> The software-repos for Ubuntu/precise lists me a PowerTOP version 1.97.
>> Not sure if this version has all bits to show me cpu fast switching
>> (short: c-f-s).
>
> Any version of powertop should be sufficient.  You just need to go
> into the "wakups" screen and look for "sugov_work" in the output.  If
> it's not there, you have fast switching enabled.
>

I needed to hack Makefile.am and configure.ac of powertop v2.8 to be
buildable with my old autoconf/automake installed here.

With *no cpu-fast-switching* I can see *sugov_work* in the Overview section.

PowerTOP 2.8      Overview   Idle stats   Frequency stats   Device
stats   Tunables

Summary: 237.6 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec
and 7.2% CPU use

                Usage       Events/s    Category       Description
            100.0%                      Device         Audio codec
hwC0D0: Realtek
            100.0%                      Device         Audio codec hwC0D3: Intel
              1.1 ms/s     103.4        kWork          sugov_work
...

>> IOW, it is a bit uncool to see it "not enabled" in my logs.
>> I would expect also to see the successful initialization/availibility
>> in my logs.
>
> The reason why "not enabled" is visible is because that indicates some
> conflict with cpufreq transition notifiers and we want to know about
> those.
>

Anyway, I expect both status to see for cpu-fast-switching.

>>
>> Does turbostats (shipped with the kernel-sources) support c-f-s?
>
> That's not a hardware feature, so why would it?
>
> Why do you care so much about the fast switching in the first place?
>

I know zero about it - in this minute and before this minute :-).

- Sedat -
