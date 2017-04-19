From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 19 Apr 2017 14:58:00 +0100
Message-ID: <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <20170419114740.GD5436@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934582AbdDSN6H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Apr 2017 09:58:07 -0400
In-Reply-To: <20170419114740.GD5436@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org



On 19/04/17 12:47, Viresh Kumar wrote:
> On 18-04-17, 17:01, Sudeep Holla wrote:
>> Understood. I would incline towards reusing regulators we that's what is
> 
> It can be just a regulator, but it can be anything else as well. That
> entity may have its own clock/volt/current tunables, etc.
> 

Agreed.

>> changed behind the scene. Calling this operating performance point
>> is misleading and doesn't align well with existing specs/features.
> 
> Yeah, but there are no voltage levels available here and that doesn't
> fit as a regulator then.
> 

We can't dismiss just based on that. We do have systems where
performance index is mapped to clocks though it may not be 1:1 mapping.
I am not disagreeing here, just trying to understand it better.

>> Understood. We have exactly same thing with SCPI but it controls both
>> frequency and voltage referred as operating points. In general, this OPP
>> terminology is used in SCPI/ACPI/SCMI specifications as both frequency
>> and voltage control. I am bit worried that this binding might introduce
>> confusions on the definitions. But it can be reworded/renamed easily if
>> required.
> 
> Yeah, so far we have been looking at OPPs as freq-voltage pairs ONLY
> and that is changing. I am not sure if it going in the wrong
> direction really. Without frequency also it is an operating point for
> the domain. Isn't it?
> 

Yes, I completely agree. I am not saying the direction is wrong. I am
saying it's confusing and binding needs to be more clear.

On the contrary(playing devil's advocate here), we can treat all
existing regulators alone as OPP then if you strip the voltages and
treat it as abstract number. So if the firmware handles more than just
regulators, I agree. At the same time, I would have preferred firmware
to even abstract the frequency like ACPI CPPC. It would be good to get
more information on what exactly that firmware handles.

I am just more cautious here since we are designing generic bindings and
changing generic code, we need to understand what that firmware supports
and how it may evolve(so that we can maintain DT compatibility)

I did a brief check and wanted to check if this is SMD/RPM regulators ?

-- 
Regards,
Sudeep
