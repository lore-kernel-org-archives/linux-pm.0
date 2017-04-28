From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Fri, 28 Apr 2017 10:44:41 +0100
Message-ID: <b3f5b62c-9423-98e4-d366-78186ab02fb9@arm.com>
References: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
 <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
 <9019aebe-95ba-b1b8-65a9-5be927934218@codeaurora.org>
 <20170428050029.GD21517@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170428050029.GD21517@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 28/04/17 06:00, Viresh Kumar wrote:
> On 27-04-17, 16:20, Rajendra Nayak wrote:
>>
>> On 04/27/2017 03:12 PM, Sudeep Holla wrote:
>> []..
>>
>>>>
>>>>> At qualcomm, we have an external M3 core (running its own firmware) which controls
>>>>> a few voltage rails (including AVS on those). The devices vote for the voltage levels
>>>
>>> Thanks for explicitly mentioning this, but ...
>>>
>>>>> (or performance levels) they need by passing an integer value to the M3 (not actual
>>>
>>> you contradict here, is it just voltage or performance(i.e. frequency)
>>> or both ? We need clarity there to choose the right representation.
>>
>> Its just voltage.
> 
> Right. Its just voltage in this case, but we can't speak of future
> platforms here and we have to consider this thing as an operating
> performance point only. I still think that this thread is moving in
> the right direction, specially after V6 which looks much better.
> 

Just thinking out loud, I can see platforms with have OPPs can move to
this binding in future eliminating the need to specify the clock and
regulators explicitly. So, I am not saying I against this idea, but I
see it might complicate the above case in terms of the precedence that
we consider in DT from backward compatibility.

E.g. if you now use this for just regulators, then I assume you continue
to use clocks. However, that makes it difficult for platforms
implementing *real* OPPs to reuse this binding as they may expect to
skip clock altogether.

Also we may need OPPs(both volt/freq), voltage only and clock only
bindings though all 3 are driven by the firmware and all are at abstract
levels. I am trying to broaden the scope now without having to churn
this binding again in near future.

So I don't totally agree that voltage regulators much have *real*
voltages and not abstract scale. Yes the correct bindings might have
such restrictions but can't we extend it ?

Anyways these are just my opinion.

> If we have anything strong against the way V6 is trying to solve it, I
> want to talk about it right now and get inputs from all the parties
> involved. Scrapping all this work is fine, but I would like to do it
> ASAP in that case :)
> 

As I said I am not against it, but I see it useful for a different
use-case, just not the one you are trying to solve here ;)

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
