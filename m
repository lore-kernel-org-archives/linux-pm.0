From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with
 multiple domains
Date: Wed, 21 Sep 2016 11:01:19 +0100
Message-ID: <6723a9e3-eef7-489f-0eda-53ca76e89f6e@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdVc+EjkbcpPKyzbCfDjp65gF3xP3bhkjh6SKLt6KDTtXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16650 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbcIUKB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 06:01:26 -0400
In-Reply-To: <CAMuHMdVc+EjkbcpPKyzbCfDjp65gF3xP3bhkjh6SKLt6KDTtXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Geert,

On 21/09/16 09:53, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Tue, Sep 20, 2016 at 12:28 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Some devices may require more than one PM domain to operate and this is
>> not currently by the PM domain framework. Furthermore, the current Linux
>> 'device' structure only allows devices to be associated with a single PM
>> domain and so cannot easily be associated with more than one. To allow
>> devices to be associated with more than one PM domain, if multiple
>> domains are defined for a given device (eg. via device-tree), then:
>> 1. Create a new PM domain for this device. The name of the new PM domain
>>    created matches the device name for which it was created for.
>> 2. Register the new PM domain as a sub-domain for all PM domains
>>    required by the device.
>> 3. Attach the device to the new PM domain.
> 
> This looks a suboptimal to me: if you have n devices sharing the same PM
> domains, you would add n new subdomains?

Yes you would and so in that case it would appear to be suboptimal, I
agree. One option would be to name the new PM domain after its parents
and then see if any PM domains exist that matches the name and verify it
has the required parents. We could even add a prefix to the name to
indicate that this is a PM domain added by the core. Only problem is we
could get some long names!

> Having a clean way to specify multiple PM domains is very useful, though.
> 
> E.g. on Renesas ARM SoCs, devices are usually part of two PM domains:
>   1. A power area (can be "always-on",
>   2. The clock domain.
> 
> As power areas and clock domains are fairly orthogonal (the former use the
> .power_{off,on}() callbacks, the latter set GENPD_FLAG_PM_CLK and use the
> {at,de}tach_dev() callbacks), we currently setup both in the same driver
> (SYSC, for controlling power areas), which forwards the clock domain operations
> to the clock driver (CPG/MSTP or CPG/MSSR).
> Hence we have only single references in the power-domains properties, but
> having two would allow to drop the hardcoded links between the two drivers.

Glad to see others could benefit from this ...

> (Oh no, more DT backwards compatibility issues if this is accepted ;-)

... despite DT compat issues :-(

Jon

-- 
nvpublic
