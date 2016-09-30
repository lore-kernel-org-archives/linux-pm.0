From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with
 multiple domains
Date: Fri, 30 Sep 2016 09:05:21 +0100
Message-ID: <f62f7b1c-0df5-1850-ecf7-b6e963520248@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdVc+EjkbcpPKyzbCfDjp65gF3xP3bhkjh6SKLt6KDTtXg@mail.gmail.com>
 <658004af-e4f4-8b0c-cdc1-43661d331d70@nvidia.com>
 <CAMuHMdV9TENEt7y5Opehh1CC5+0=s4nRMvnh=0nTYOUuOOC2uw@mail.gmail.com>
 <1c217cf4-8682-8e6d-6958-419923e995cd@nvidia.com>
 <CAMuHMdWUAQd-sbj51XRPJ5b9By8Aiak6h-F=BcMCR=i8MiZvbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6795 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbcI3IFd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2016 04:05:33 -0400
In-Reply-To: <CAMuHMdWUAQd-sbj51XRPJ5b9By8Aiak6h-F=BcMCR=i8MiZvbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi PM posse!

On 23/09/16 15:27, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Fri, Sep 23, 2016 at 2:57 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 21/09/16 15:57, Geert Uytterhoeven wrote:
>>> On Wed, Sep 21, 2016 at 4:37 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>> On 21/09/16 09:53, Geert Uytterhoeven wrote:
>>>>> On Tue, Sep 20, 2016 at 12:28 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>>> Some devices may require more than one PM domain to operate and this is
>>>>>> not currently by the PM domain framework. Furthermore, the current Linux
>>>>>> 'device' structure only allows devices to be associated with a single PM
>>>>>> domain and so cannot easily be associated with more than one. To allow
>>>>>> devices to be associated with more than one PM domain, if multiple
>>>>>> domains are defined for a given device (eg. via device-tree), then:
>>>>>> 1. Create a new PM domain for this device. The name of the new PM domain
>>>>>>    created matches the device name for which it was created for.
>>>>>> 2. Register the new PM domain as a sub-domain for all PM domains
>>>>>>    required by the device.
>>>>>> 3. Attach the device to the new PM domain.
>>>>>
>>>>> This looks a suboptimal to me: if you have n devices sharing the same PM
>>>>> domains, you would add n new subdomains?
>>>>
>>>> BTW, would this be the case today for some renesas devices or are you
>>>> just pointing this out as something that could be optimised/improved?
>>>
>>> This is the case for all Renesas SoCs that have power areas: devices belong
>>> to both the PM domain for the power area, and to the PM domain for the clock
>>> domain.
>>
>> To quantify this a bit, for the Renesas case, how many of these
>> duplicated domains would there be if you were to use this approach as-is?
> 
> for i in $(git grep -l renesas, -- "*dts*") ; do echo --- $i ---; git
> grep -w power-domains $i | sort | uniq -c | sort -n;done
> 
> tells you how many (supported) devices are (currently) present in each
> PM domain.
> Most of these (all but devices in CPU/SCU power areas) are also part of a
> clock domain.
> The synthetic R8A779*_PD_ALWAYS_ON domains could be dropped again,
> as we could just refer to the CPG/MSSR node for the clock domain instead.
> 
> For older SH/R-Mobile SoCs with lots of hierarchical domains, that gives us,
> after removing the above:
> 
>       1 arch/arm/boot/dts/r8a7740.dtsi:         power-domains = <&pd_a4mp>;
>       1 arch/arm/boot/dts/r8a7740.dtsi:         power-domains = <&pd_d4>;
>       2 arch/arm/boot/dts/r8a7740.dtsi:         power-domains = <&pd_c5>;
>       3 arch/arm/boot/dts/r8a7740.dtsi:         power-domains = <&pd_a4r>;
>       6 arch/arm/boot/dts/r8a7740.dtsi:         power-domains = <&pd_a4s>;
>      15 arch/arm/boot/dts/r8a7740.dtsi:         power-domains = <&pd_a3sp>;
> 
> R-Car Gen1/Gen2 have all devices in the "always on" PM domain, so they're
> not affected.
> 
> R-Car Gen3 again has devices in power areas, mostly for graphics related
> purposes:
> 
>      16 arch/arm64/boot/dts/renesas/r8a7795.dtsi:
>  power-domains = <&sysc R8A7795_PD_A3VP>;

Does anyone have any more inputs comments on this? Does it look complete
bonkers or should I forge ahead with this?

Cheers
Jon

-- 
nvpublic
