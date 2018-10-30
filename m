From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
Date: Tue, 30 Oct 2018 18:48:19 +0300
Message-ID: <08a1978a-32b2-0234-a461-a11e1abcff6a@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
 <20181024064123.lbpbeervghp35fe7@vireshk-i7>
 <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
 <20181029065328.6vkbwjnq2zzwxric@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029065328.6vkbwjnq2zzwxric@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/29/18 9:53 AM, Viresh Kumar wrote:
> On 26-10-18, 15:03, Dmitry Osipenko wrote:
>> On 10/24/18 9:41 AM, Viresh Kumar wrote:
>>> On 22-10-18, 15:12, Dmitry Osipenko wrote:
>>>> Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare
>>>> necessary regulators, but we want to have CPU frequency scaling. I couldn't
>>>> find board schematics and so don't know if CPU / CORE voltages are fixed on
>>>> Trim-Slice or it is just preferable not to have DVFS for that board, it is an
>>>> outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy
>>>> regulators when appropriate. 
>>>
>>> We have been using the regulator_get_optional() variant until now in the OPP
>>> core to make sure that we don't do DVFS for the CPU without the mandatory
>>> regulators being present, as that may make things unstable and cause harm to the
>>> SoC if we try to take CPU to frequency range over the currently programmed
>>> regulator can support.
>>>
>>> Now coming back to tegra-20 SoC, which actually requires a regulator normally by
>>> design. On one of the boards (which is outlet powered), you aren't sure if there
>>> is a programmable regulator or not, or if DVFS should really be done or not.
>>> Isn't it worth checking the same from Tegra maintainers, or whomsoever has
>>> information on that board ?
>>
>> I'll try to find out more detailed information for the next revision of the patchset.
> 
> Thanks Dmitry.
> 
>>  What would happen if there actually was a regulator
> 
> Please preserve the '>' from previous replies at the beginning of the
> lines. Otherwise it looks as if you have written the above line. :)
> 
>>> and its default settings aren't good enough for high end frequencies ?
>>
>> Usually this causes kernel/applications crashes and/or machine hang.
> 
> Sure. I also do remember from some guys (maybe TI), where they
> mentioned that such scenarios can harm the hardware as well sometimes.
> Don't remember the details though.
> 
>>  And because you are moving to regulator_get() API for
>>> the entire SoC (i.e. its cpufreq driver), people will never find the missing
>>> regulator.
>>
>> Regulators core prints info message when dummy regulator is being used.
> 
> Sure, but they are easy to miss and they are only seen by developers
> not regular users of a machine.
> 
>>> If we can do it safely for all tegra20 boards, why not migrate to using
>>> regulator_get() instead of regulator_get_optional() in the OPP core API itself
>>> for everyone ?
>>>
>>
>> This should be a platform-specific decision. For Tegra we know that regulators should be in a good state at kernel boot time, I don't think that this applies to other platforms.
> 
> Based on the other discussion with Lucas on this thread, I don't think
> this is correct any more ?
> 
> Don't get me wrong, I am all good for changes and another API change
> doesn't matter much to me. I am just wondering if it would be the
> right approach to fix the issue. Why not rather call
> dev_pm_opp_set_regulators() conditionally and avoid calling it for the
> specific tegra20 board.

The right approach should be to specify device tree correctly. Probably we won't need this change at all with the correct DT, will see.

Calling dev_pm_opp_set_regulators() conditionally should work, but that is extra churning in the driver that I tried to avoid.
