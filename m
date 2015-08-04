From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 3/8] ACPI: Decouple ACPI idle and ACPI processor drivers
Date: Tue, 04 Aug 2015 18:00:19 +0100
Message-ID: <55C0EFA3.2040006@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>	<da1eb99c0e128a4c8160537295045164d8fde00d.1436464513.git.ashwin.chaugule@linaro.org>	<55AD03F7.60108@arm.com>	<CAJ5Y-eYqfpdC2EvEO5gRm7zRbzr0+KwhiL4MUY23uXM91y=MJA@mail.gmail.com>	<55C0D156.9090808@arm.com>	<CAJ5Y-eaibuK0c_wSsRjM68vOfuRdRSChRdzR=2qtwVYwQcAzVQ@mail.gmail.com>	<55C0D7DC.2060709@arm.com> <CAJ5Y-eZo07qVMS37eo=OShCLcgpURfyRA=dOQhtF0Y6_fvR=1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-eZo07qVMS37eo=OShCLcgpURfyRA=dOQhtF0Y6_fvR=1Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 04/08/15 16:44, Ashwin Chaugule wrote:
> On 4 August 2015 at 11:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 04/08/15 15:58, Ashwin Chaugule wrote:
>>>
>>> On 4 August 2015 at 10:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>
>>>> On 03/08/15 18:40, Ashwin Chaugule wrote:
>>>>>
>>>>>
>>>>> On 20 July 2015 at 10:21, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>>>
>>>>>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> In general, you need to split this series so that initially few patches
>>>>>> deal with all the existing Kconfig fix-ups and then introduce
>>>>>> PCC/PSS/CPPC related stuffs. That would help me rebase and test _LPI
>>>>>> support.
>>>>>
>>>>>
>>>>>
>>>>> Hm. I tried to maintain bisectability and make it easier for you to
>>>>> rebase LPI patchwork too. Let me see if I can revisit now that I'm
>>>>> back from vacation. :)
>>>>>
>>>>
>>>> How about you just drop any idle related changes so that I will handle
>>>> that to keep it simple.
>>>
>>>
>>> Unfortunately I can't skip idle changes completely since it is tightly
>>> coupled with the acpi_processor driver as well.
>>>
>>
>> True, but only for ARM64 where we haven't enabled ACPI_PROCESSOR yet in
>> mainline. So from that perspective, it should not cause any issue for
>> keeping changes bisectable on x86/ia64. You can keep these idle changes
>> locally for your testing. Trying to get everything at once will
>> definitely be problematic IMO.
>
> Bisectability aside, without the idle changes to decouple it from
> ACPI_PROCESSOR, the CPPC code will be non-functional. CPPC code has
> been around for review publicly for almost a year and we need it to be
> mainlined soon. So, given that we've converged on a solution for new
> Kconfigs for Idle and PSS and that they're separate patches, why not
> let it progress forwards as part of this series?
>

Sorry, I didn't mean to block this series in anyway. I was just thinking
on how to post the preparatory changes to introduce _LPI. I prefer to
base it on mainline rather than this patch series and hence I made that
request.

Regards,
Sudeep
