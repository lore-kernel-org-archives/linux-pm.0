From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that require
 multiple domains
Date: Thu, 06 Oct 2016 14:13:42 +0530
Message-ID: <57F60EBE.8010509@codeaurora.org>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com> <57F5E986.40704@codeaurora.org> <8ba7aa10-0c2f-98ca-c7bd-00e1724e5972@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ba7aa10-0c2f-98ca-c7bd-00e1724e5972@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 10/06/2016 01:55 PM, Jon Hunter wrote:
> Hi Rajendra,
> 
> On 06/10/16 07:04, Rajendra Nayak wrote:
>>
>> On 09/20/2016 03:58 PM, Jon Hunter wrote:
>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>>> controllers) is partitioned across 3 PM domains which are:
>>> - XUSBA: Superspeed logic (for USB 3.0)
>>> - XUSBB: Device controller
>>> - XUSBC: Host controller
>>>
>>> These power domains are not nested and can be powered-up and down
>>> independently of one another. In practice different scenarios require
>>> different combinations of the power domains, for example:
>>> - Superspeed host: XUSBA and XUSBC
>>> - Superspeed device: XUSBA and XUSBB
>>>
>>> Although it could be possible to logically nest both the XUSBB and XUSBC
>>> domains under the XUSBA, superspeed may not always be used/required and
>>> so this would keep it on unnecessarily.
>>
>> Hey Jon, so does this RFC provide a way to just specify multiple Powerdomains
>> for a device (which then will *all* be powered on/off together) or does
>> it also provide for more granular control of these powerdomains?
> 
> Only to specify multiple power-domains for a device and not the later.
> 
>> The above statement seems to suggest you would need more granular control
>> of these powerdomains (like keeping XUSBA off in case superspeed it not
>> needed) but I can't seem to figure out how you achieve it with this series.
> 
> It is an interesting point but today we have always kept the superspeed
> partition on if the device is configured for superspeed regardless of
> what is actually connected. I will check to see if the h/w would allow
> us to turn it off if a non-superspeed device is in use but I did not
> think so.
> 
> Do you have any interesting use-cases that would make use of this or
> require other such enhancements?

We do have atleast a few devices which need to control multiple power domains,
I will need to look more to see if any of them can be controlled individually.
The downstream code we have models these (powerdomains) as regulators and
the drivers hence have individual control on each (specifying multiple -supply's
in DT)
Regardless, the idea of being able to specify more than one powerdomain
associated to a device seems quite useful, though providing a way for the
driver to control them individually seems tricky.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
