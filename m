From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Thu, 19 May 2016 16:25:44 +0200
Message-ID: <CAJZ5v0hAMSBJoUCpYSsNN6H3nJMyToE9q1LKfBbhWECSYYsctQ@mail.gmail.com>
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
	<CA+icZUWWJ-G0SuOPmkOe9W7f+fctB14dFigRGWpNjcB6N5CfHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34381 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbcESOZp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 10:25:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so21534677wmn.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 07:25:44 -0700 (PDT)
In-Reply-To: <CA+icZUWWJ-G0SuOPmkOe9W7f+fctB14dFigRGWpNjcB6N5CfHg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, May 19, 2016 at 4:24 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, May 19, 2016 at 3:54 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Thu, May 19, 2016 at 3:41 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>>> wrote:
>>>>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>> On Thu, May 19, 2016 at 2:10 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>>>>> wrote:
>>>>>>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>>> On Thu, May 19, 2016 at 1:04 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>>>>>>> wrote:
>>>>
>>>> [cut]
>>>>
>>>>>
>>>>> With these changes...
>>>>>
>>>>> $ ./scripts/diffconfig /boot/config-4.6.0-4-iniza-small
>>>>> /boot/config-4.6.0-5-iniza-small
>>>>>  CPU_FREQ_STAT y -> m
>>>>>  X86_ACPI_CPUFREQ y -> m
>>>>>  X86_POWERNOW_K8 y -> m
>>>>>
>>>>> ...I still see "Fast frequency switching not enabled"...
>>>>>
>>>>> $ sudo modprobe -r -v acpi_cpufreq
>>>>> [sudo] password for wearefam:
>>>>> rmmod acpi_cpufreq
>>>>> $ sudo modprobe -r -v cpufreq_stats
>>>>> rmmod cpufreq_stats
>>>>>
>>>>> $ sudo modprobe -v cpufreq_stats
>>>>> insmod
>>>>> /lib/modules/4.6.0-5-iniza-small/kernel/drivers/cpufreq/cpufreq_stats.ko
>>>>
>>>> Skip the above modprobe. :-)
>>>>
>>>
>>> If I do not insmod cpufreq_stats (only insmod acpi_cpufreq) then I do
>>> not see anything with "cpu fast switching" in my logs.
>>> ( I double-checked to have schedutil as running cpufreq-governor. )
>>
>> That means it has been enabled.
>>
>
> How can I check if cpu fast switching is really enabled?
> I checked with the dmesg before.

Please see the message I've just sent:
http://marc.info/?l=linux-pm&m=146366787406347&w=2
