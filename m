From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 13 Apr 2017 14:43:38 +0100
Message-ID: <854e3f66-6f93-2b90-14a9-7eaea6a0b74c@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <468e756b-7112-4006-b31d-9fcf1c32673d@arm.com>
 <20170413055049.GN5910@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170413055049.GN5910@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 13/04/17 06:50, Viresh Kumar wrote:
> On 12-04-17, 18:05, Sudeep Holla wrote:
>>
>>
>> On 20/03/17 09:32, Viresh Kumar wrote:

[...]

>>
>> Thinking more about this above example, I think you need more
>> explanation. So in the above case you have cpu with clock controller,
>> power-domain and the OPP table info, I can think of few things that need
>> to be explicit:
>>
>> 1. How does the precedence look like ?
> 
> Just think of the power-domain as a regulator here. If we are
> increasing frequency of the device, power-domain needs to be
> programmed first followed by the clock.
> 

Interesting. My understand of power domain and in particular power
domain performance was that it would control both. The abstract number
you introduce would hide clocks and regulators.

But if the concept treats it just as yet another regulator, we do we
need these at all. Why don't we relate this performance to regulator
values and be done with it ?

Sorry if I am missing to understand something here. I would look this as
replacement for both clocks and regulators, something similar to ACPI
CPPC. If not, it looks unnecessary to me with the information I have got
so far.

>> 2. Since power-domains with OPP table control the performance state, do
> 
> They control performance state of the domains, not the devices.
> 
>>    we ignore clock and operating-points-v2 in the above case completely?
> 
> No. They are separate.
>

Understood now, but still trying to understand the complexity introduced
here.

>>
>> 3. Will the power-domain drive the OPP ?
> 
> power-domain will driver its own state using its own OPP table.
> Devices may fine tune within those states.
> 

I fail to understand here. This makes me think this power domain is same
as regulators as you pointed out earlier. So, we do we need all these
extra things. I was hoping this to be something like ACPI CPPC that hide
away clock and regulators.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
