From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that require
 multiple domains
Date: Wed, 02 Nov 2016 14:26:34 +0530
Message-ID: <5819AA42.5060603@codeaurora.org>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com> <57F5E986.40704@codeaurora.org> <8ba7aa10-0c2f-98ca-c7bd-00e1724e5972@nvidia.com> <57F60EBE.8010509@codeaurora.org> <91b96909-64bc-db72-6da5-556272565091@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <91b96909-64bc-db72-6da5-556272565091@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On 10/31/2016 04:14 PM, Jon Hunter wrote:
> Hi Rajendra,
> 
> On 06/10/16 09:43, Rajendra Nayak wrote:
>>
>> On 10/06/2016 01:55 PM, Jon Hunter wrote:
>>> Hi Rajendra,
>>>
>>> On 06/10/16 07:04, Rajendra Nayak wrote:
>>>>
>>>> On 09/20/2016 03:58 PM, Jon Hunter wrote:
>>>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>>>>> controllers) is partitioned across 3 PM domains which are:
>>>>> - XUSBA: Superspeed logic (for USB 3.0)
>>>>> - XUSBB: Device controller
>>>>> - XUSBC: Host controller
>>>>>
>>>>> These power domains are not nested and can be powered-up and down
>>>>> independently of one another. In practice different scenarios require
>>>>> different combinations of the power domains, for example:
>>>>> - Superspeed host: XUSBA and XUSBC
>>>>> - Superspeed device: XUSBA and XUSBB
>>>>>
>>>>> Although it could be possible to logically nest both the XUSBB and XUSBC
>>>>> domains under the XUSBA, superspeed may not always be used/required and
>>>>> so this would keep it on unnecessarily.
>>>>
>>>> Hey Jon, so does this RFC provide a way to just specify multiple Powerdomains
>>>> for a device (which then will *all* be powered on/off together) or does
>>>> it also provide for more granular control of these powerdomains?
>>>
>>> Only to specify multiple power-domains for a device and not the later.
>>>
>>>> The above statement seems to suggest you would need more granular control
>>>> of these powerdomains (like keeping XUSBA off in case superspeed it not
>>>> needed) but I can't seem to figure out how you achieve it with this series.
>>>
>>> It is an interesting point but today we have always kept the superspeed
>>> partition on if the device is configured for superspeed regardless of
>>> what is actually connected. I will check to see if the h/w would allow
>>> us to turn it off if a non-superspeed device is in use but I did not
>>> think so.
>>>
>>> Do you have any interesting use-cases that would make use of this or
>>> require other such enhancements?
>>
>> We do have atleast a few devices which need to control multiple power domains,
>> I will need to look more to see if any of them can be controlled individually.
>> The downstream code we have models these (powerdomains) as regulators and
>> the drivers hence have individual control on each (specifying multiple -supply's
>> in DT)
> 
> Were you able to check to see if you need to have individual control for the power-domains?

I had a look at the Video decode block (for msm8996), which seems to be powered using 3 different
powerdomains, mainly venus, venus_core0 and venus_core1. The venus PD powers the ARM core
which runs the firmware, while the venus_core0 and venus_core1 power the encode/decode logic,
so for things like firmware image loading you ideally need only venus PD to be ON, but during
an encode/decode operation you would need all 3 to be ON.
The downstream driver turns *all* of them together, and does not control them individually.
For upstream, the way we have it working (the driver is not merged) is by having venus be the parent
of venus_core0 and venus_core0 as the parent of venus_core1, and having venus_core1 mentioned as
the powerdomain for the video decode block in DT.

So in summary, there is still no need to control them individually, but given there is no way to
specify more than one powerdomain for a given device, we are ending up hooking up some 
parent/child relations in the powerdomain code.

regards,
Rajendra

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
