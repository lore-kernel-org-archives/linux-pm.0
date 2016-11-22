From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Tue, 22 Nov 2016 14:05:50 +0100
Message-ID: <CAPDyKFo4okrLLM+HVKTOn8pDvwO5aRKCYnyznt+Vrokp64yjqQ@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <57F5E986.40704@codeaurora.org> <8ba7aa10-0c2f-98ca-c7bd-00e1724e5972@nvidia.com>
 <57F60EBE.8010509@codeaurora.org> <91b96909-64bc-db72-6da5-556272565091@nvidia.com>
 <5819AA42.5060603@codeaurora.org> <CAPDyKFpdRzDotofr+0F6gfuWg4hHikEfmxS2aM2D+hmq_JpHRA@mail.gmail.com>
 <582D1696.7000601@codeaurora.org> <4bafcd71-edc9-9ddd-d8c4-093e4d9c58db@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4bafcd71-edc9-9ddd-d8c4-093e4d9c58db-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 17 November 2016 at 16:39, Stanimir Varbanov
<stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On 11/17/2016 04:31 AM, Rajendra Nayak wrote:
>>
>>
>> On 11/16/2016 06:41 PM, Ulf Hansson wrote:
>>> On 2 November 2016 at 09:56, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>> Hi Jon,
>>>>
>>>> On 10/31/2016 04:14 PM, Jon Hunter wrote:
>>>>> Hi Rajendra,
>>>>>
>>>>> On 06/10/16 09:43, Rajendra Nayak wrote:
>>>>>>
>>>>>> On 10/06/2016 01:55 PM, Jon Hunter wrote:
>>>>>>> Hi Rajendra,
>>>>>>>
>>>>>>> On 06/10/16 07:04, Rajendra Nayak wrote:
>>>>>>>>
>>>>>>>> On 09/20/2016 03:58 PM, Jon Hunter wrote:
>>>>>>>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>>>>>>>>> controllers) is partitioned across 3 PM domains which are:
>>>>>>>>> - XUSBA: Superspeed logic (for USB 3.0)
>>>>>>>>> - XUSBB: Device controller
>>>>>>>>> - XUSBC: Host controller
>>>>>>>>>
>>>>>>>>> These power domains are not nested and can be powered-up and down
>>>>>>>>> independently of one another. In practice different scenarios require
>>>>>>>>> different combinations of the power domains, for example:
>>>>>>>>> - Superspeed host: XUSBA and XUSBC
>>>>>>>>> - Superspeed device: XUSBA and XUSBB
>>>>>>>>>
>>>>>>>>> Although it could be possible to logically nest both the XUSBB and XUSBC
>>>>>>>>> domains under the XUSBA, superspeed may not always be used/required and
>>>>>>>>> so this would keep it on unnecessarily.
>>>>>>>>
>>>>>>>> Hey Jon, so does this RFC provide a way to just specify multiple Powerdomains
>>>>>>>> for a device (which then will *all* be powered on/off together) or does
>>>>>>>> it also provide for more granular control of these powerdomains?
>>>>>>>
>>>>>>> Only to specify multiple power-domains for a device and not the later.
>>>>>>>
>>>>>>>> The above statement seems to suggest you would need more granular control
>>>>>>>> of these powerdomains (like keeping XUSBA off in case superspeed it not
>>>>>>>> needed) but I can't seem to figure out how you achieve it with this series.
>>>>>>>
>>>>>>> It is an interesting point but today we have always kept the superspeed
>>>>>>> partition on if the device is configured for superspeed regardless of
>>>>>>> what is actually connected. I will check to see if the h/w would allow
>>>>>>> us to turn it off if a non-superspeed device is in use but I did not
>>>>>>> think so.
>>>>>>>
>>>>>>> Do you have any interesting use-cases that would make use of this or
>>>>>>> require other such enhancements?
>>>>>>
>>>>>> We do have atleast a few devices which need to control multiple power domains,
>>>>>> I will need to look more to see if any of them can be controlled individually.
>>>>>> The downstream code we have models these (powerdomains) as regulators and
>>>>>> the drivers hence have individual control on each (specifying multiple -supply's
>>>>>> in DT)
>>>>>
>>>>> Were you able to check to see if you need to have individual control for the power-domains?
>>>>
>>>> I had a look at the Video decode block (for msm8996), which seems to be powered using 3 different
>>>> powerdomains, mainly venus, venus_core0 and venus_core1. The venus PD powers the ARM core
>>>> which runs the firmware, while the venus_core0 and venus_core1 power the encode/decode logic,
>>>> so for things like firmware image loading you ideally need only venus PD to be ON, but during
>>>> an encode/decode operation you would need all 3 to be ON.
>>>
>>> Isn't there a scenario when encoding *or* decoding happens, not always both?
>>>
>>> If so, doesn't that mean you may have venus + venus_core0 powered and
>>> in some other case venus + venus_core1 powered?
>>>
>>>> The downstream driver turns *all* of them together, and does not control them individually.
>>>> For upstream, the way we have it working (the driver is not merged) is by having venus be the parent
>>>> of venus_core0 and venus_core0 as the parent of venus_core1, and having venus_core1 mentioned as
>>>> the powerdomain for the video decode block in DT.
>>>>
>>>> So in summary, there is still no need to control them individually, but given there is no way to
>>>> specify more than one powerdomain for a given device, we are ending up hooking up some
>>>> parent/child relations in the powerdomain code.
>>>>
>>>
>>> I think a better solution would be to model the video decode block as
>>> three struct devices.
>>>
>>> 1) The main ARM device, attached to the venus PM domain.
>>> 2) The encoder device, having the main device assigned as its parent
>>> and being attached to the venus_core0 PM domain.
>>> 3) The decoder device, having the main device assigned as its parent
>>> and being attached to the venus_core1 PM domain.
>>>
>>> Then there is no need to specific a  PM domain hierarchy (which seems
>>> to be the issue here), but instead only the parent/child relationships
>>> between the struct devices.
>>>
>>> Moreover, as you deploy runtime PM for these devices, you can more
>>> easily distinguish which device you need to operate on
>>> (pm_runtime_get|put*()) depending on what particular operations you
>>> want to do (encode, decode etc).
>>
>> Stan, is this something you think is possible to do, given the way the
>> vidc driver is designed? This is mainly for 8996 which has 3 different
>> powerdomains associated with the video decode block.
>
> Even if it is possible it will be difficult for many reasons.
>
> On the other side, current design (firmware) doesn't expect kernel
> driver to have control over venus_core0 and venus_core1 pm domains. The
> firmware manages those two pm domains internally and the only thing
> which we need to do is to prepare those domains (and follow the power up
> sequence) to be in hardware control mode. So I think the best we could
> do is to model those two power domains as genpd subdomains of the parent
> venus pm domain.

Okay, so that was easy then. Why all the fuzz? :-)

Kind regards
Uffe
