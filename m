From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 26 Apr 2017 10:02:39 +0530
Message-ID: <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <95aa4b97-4e1a-13bb-f4d8-982b778012ba-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> On 17/04/17 06:27, Viresh Kumar wrote:
>> On 13-04-17, 14:42, Sudeep Holla wrote:
>>> What I was referring is about power domain provider with multiple power
>>> domains(simply #power-domain-cells=<1> case as explained in the
>>> power-domain specification.
>>
>> I am not sure if we should be looking to target such a situation for now, as
>> that would be like this:
>>
>> Device controlled by Domain A. Domain A itself is controlled by Domain B and
>> Domain C.
>>
> 
> No, may be I was not so clear. I am just referring a power controller
> that provides say 3 different power domains and are indexed 0 - 2.
> The consumer just passes the index along with the phandle for the power
> domain info.
> 
>> Though we will end up converting the domain-performance-state property to an
>> array if that is required in near future.
>>
> 
> OK, better to document that so that we know how to extend it. We have
> #power-domain-cells=<1> on Juno with SCPI.
> 
>>> Yes. To simplify what not we just have power-domain for a device and
>>> change state of that domain to change the performance of that device.
>>
>> Consider this case to understand what I have in Mind.
>>
>> The power domain have its states as A, B, C, D. There can be multiple devices
>> regulated by that domain and one of the devices have its power states as: A1,
>> A2, A3, B1, B2, B3, C1, C2, C3, D1, D2, D3 and all these states have different
>> frequency/voltages.
>>
>> IOW, the devices can have regulators as well and may want to fine tune within
>> the domain performance-state.
>>
> 
> Understood. I would incline towards reusing regulators we that's what is
> changed behind the scene. Calling this operating performance point
> is misleading and doesn't align well with existing specs/features.

[]...
 
>>> If we are looking this power-domains with performance as just some
>>> *advanced regulators*, I don't like the complexity added.

+ Mark

I don;t see any public discussions on why we ruled out using regulators to
support this but maybe there were some offline discussions on this.

Mark, this is a long thread, so just summarizing here to give you the context.

At qualcomm, we have an external M3 core (running its own firmware) which controls
a few voltage rails (including AVS on those). The devices vote for the voltage levels
(or performance levels) they need by passing an integer value to the M3 (not actual
voltage values). Since that didn't fit well with the existing regulator apis it was
proposed we look at modeling these as powerdomain performance levels (and reuse genpd
framework) which is what this series from Viresh is about.

Since the discussion now is moving towards 'why not use regulator framework for this
instead of adding all the complexity with powerdomain performance levels since
these are regulators underneath', I looped you in so you can provide some feedback
on can these really be modeled as some *advanced regulators* with some apis to set some
regulator performance levels (instead of voltage levels).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
