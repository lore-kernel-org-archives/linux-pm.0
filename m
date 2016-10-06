From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Thu, 6 Oct 2016 09:25:44 +0100
Message-ID: <8ba7aa10-0c2f-98ca-c7bd-00e1724e5972@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <57F5E986.40704@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17707 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbcJFIZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 04:25:56 -0400
In-Reply-To: <57F5E986.40704@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Rajendra,

On 06/10/16 07:04, Rajendra Nayak wrote:
> 
> On 09/20/2016 03:58 PM, Jon Hunter wrote:
>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>> controllers) is partitioned across 3 PM domains which are:
>> - XUSBA: Superspeed logic (for USB 3.0)
>> - XUSBB: Device controller
>> - XUSBC: Host controller
>>
>> These power domains are not nested and can be powered-up and down
>> independently of one another. In practice different scenarios require
>> different combinations of the power domains, for example:
>> - Superspeed host: XUSBA and XUSBC
>> - Superspeed device: XUSBA and XUSBB
>>
>> Although it could be possible to logically nest both the XUSBB and XUSBC
>> domains under the XUSBA, superspeed may not always be used/required and
>> so this would keep it on unnecessarily.
> 
> Hey Jon, so does this RFC provide a way to just specify multiple Powerdomains
> for a device (which then will *all* be powered on/off together) or does
> it also provide for more granular control of these powerdomains?

Only to specify multiple power-domains for a device and not the later.

> The above statement seems to suggest you would need more granular control
> of these powerdomains (like keeping XUSBA off in case superspeed it not
> needed) but I can't seem to figure out how you achieve it with this series.

It is an interesting point but today we have always kept the superspeed
partition on if the device is configured for superspeed regardless of
what is actually connected. I will check to see if the h/w would allow
us to turn it off if a non-superspeed device is in use but I did not
think so.

Do you have any interesting use-cases that would make use of this or
require other such enhancements?

Cheers
Jon

-- 
nvpublic
