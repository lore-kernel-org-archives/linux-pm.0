From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Tue, 18 Apr 2017 17:03:11 +0100
Message-ID: <2128c09a-0656-0878-c4e7-c327007021c7@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <468e756b-7112-4006-b31d-9fcf1c32673d@arm.com>
 <20170413055049.GN5910@vireshk-i7>
 <854e3f66-6f93-2b90-14a9-7eaea6a0b74c@arm.com>
 <20170417053303.GG28191@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170417053303.GG28191@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 17/04/17 06:33, Viresh Kumar wrote:
> On 13-04-17, 14:43, Sudeep Holla wrote:
>> Interesting. My understand of power domain and in particular power
>> domain performance was that it would control both. The abstract number
>> you introduce would hide clocks and regulators.
>>
>> But if the concept treats it just as yet another regulator, we do we
>> need these at all. Why don't we relate this performance to regulator
>> values and be done with it ?
>>
>> Sorry if I am missing to understand something here. I would look this as
>> replacement for both clocks and regulators, something similar to ACPI
>> CPPC. If not, it looks unnecessary to me with the information I have got
>> so far.
> 
> I kind of answered that in the other email.
> 
> Some background may be good here. So Qcom tried to solve all this with virtual
> regulators, but the problem was that they need to talk in terms of integer
> values (1, 2, 3..) and not voltages and so they can't use the regulator
> framework straight away. And so we are doing all this.
> 

Was it posted externally ? Was there any objections for that approach ?
IMO that's better approach but if I am late to the party, I would like
to read through the discussions that happened on it(if any)

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
