From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Mon, 8 May 2017 14:47:06 +0100
Message-ID: <bd4f93b9-e310-e285-d722-42c4ba76556d@arm.com>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
 <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
 <20170428204803.plu467okibtxga4d@rob-hp-laptop>
 <a307c76d-72c3-eb84-e7d4-d5e47e2af727@arm.com> <m2mvaquxxf.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m2mvaquxxf.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 06/05/17 10:39, Kevin Hilman wrote:
> Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> writes:
> 
>> On 28/04/17 21:48, Rob Herring wrote:
>>> On Wed, Apr 26, 2017 at 04:27:05PM +0530, Viresh Kumar wrote:
>>>> Power-domains need to express their active states in DT and the devices
>>>> within the power-domain need to express their dependency on those active
>>>> states. The power-domains can use the OPP tables without any
>>>> modifications to the bindings.
>>>>
>>>> Add a new property "power-domain-opp", which will contain phandle to the
>>>> OPP node of the parent power domain. This is required for devices which
>>>> have dependency on the configured active state of the power domain for
>>>> their working.
>>>>
>>>> For some platforms the actual frequency and voltages of the power
>>>> domains are managed by the firmware and are so hidden from the high
>>>> level operating system. The "opp-hz" property is relaxed a bit to
>>>> contain indexes instead of actual frequency values to support such
>>>> platforms.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/opp/opp.txt | 74 ++++++++++++++++++++++++++-
>>>>  1 file changed, 73 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>>> index 63725498bd20..6e30cae2a936 100644
>>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>>> @@ -77,7 +77,10 @@ This defines voltage-current-frequency combinations along with other related
>>>>  properties.
>>>>  
>>>>  Required properties:
>>>> -- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
>>>> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. In some
>>>> +  cases the exact frequency in Hz may be hidden from the OS by the firmware and
>>>> +  this field may contain values that represent the frequency in a firmware
>>>> +  dependent way, for example an index of an array in the firmware.
>>>
>>> Not really sure OPP binding makes sense here. What about all the other 
>>> properties. We expose voltage, but not freq?
>>>
>>
>> I completely agree with that and I have been pushing this to be
>> represented as just regulators[0]. Mark B seem to dislike that
>> idea [1]
> 
> And Mark is right, because what's being described is not (simply) a
> voltage regultor.  While it might be "just" voltage on some SoCs (for
> now), it is clearly about performance (a.k.a. OPP) on others.
> 

Agreed. What I was against in this particular case was it was just
voltage for the domain and the devices had their own OPP with clocks
described which looks really weird when both are represented as OPPs.

I am fine with OPP representation in all such cases provide the bindings
are well defined especially if they are hierarchical, what takes
precedence, ...etc.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
