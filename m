From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Tue, 18 Apr 2017 17:01:03 +0100
Message-ID: <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdDRQBI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 12:01:08 -0400
In-Reply-To: <20170417052758.GF28191@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org



On 17/04/17 06:27, Viresh Kumar wrote:
> On 13-04-17, 14:42, Sudeep Holla wrote:
>> What I was referring is about power domain provider with multiple power
>> domains(simply #power-domain-cells=<1> case as explained in the
>> power-domain specification.
> 
> I am not sure if we should be looking to target such a situation for now, as
> that would be like this:
> 
> Device controlled by Domain A. Domain A itself is controlled by Domain B and
> Domain C.
> 

No, may be I was not so clear. I am just referring a power controller
that provides say 3 different power domains and are indexed 0 - 2.
The consumer just passes the index along with the phandle for the power
domain info.

> Though we will end up converting the domain-performance-state property to an
> array if that is required in near future.
> 

OK, better to document that so that we know how to extend it. We have
#power-domain-cells=<1> on Juno with SCPI.

>> Yes. To simplify what not we just have power-domain for a device and
>> change state of that domain to change the performance of that device.
> 
> Consider this case to understand what I have in Mind.
> 
> The power domain have its states as A, B, C, D. There can be multiple devices
> regulated by that domain and one of the devices have its power states as: A1,
> A2, A3, B1, B2, B3, C1, C2, C3, D1, D2, D3 and all these states have different
> frequency/voltages.
> 
> IOW, the devices can have regulators as well and may want to fine tune within
> the domain performance-state.
> 

Understood. I would incline towards reusing regulators we that's what is
changed behind the scene. Calling this operating performance point
is misleading and doesn't align well with existing specs/features.

>> Then put this in the hierarchy. Some thing similar to what we already
>> have with new domain-idle states. In that way, we can move any
>> performance control to the domain and abstract the clocks and regulators
>> from the devices as the first step and from the OSPM view if there's
>> firmware support.
>>
>> If we are looking this power-domains with performance as just some
>> *advanced regulators*, I don't like the complexity added.
> 
> In the particular case I am trying to solve (Qcom), we have some sort of
> regulators which are only programmed by a M3 core. The M3 core needs integer
> numbers representing state we want the domain to be in and it will put the
> regulators (or whatever) in a particular state.
> 

Understood. We have exactly same thing with SCPI but it controls both
frequency and voltage referred as operating points. In general, this OPP
terminology is used in SCPI/ACPI/SCMI specifications as both frequency
and voltage control. I am bit worried that this binding might introduce
confusions on the definitions. But it can be reworded/renamed easily if
required.

-- 
Regards,
Sudeep
