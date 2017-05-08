From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Mon, 8 May 2017 11:06:54 +0530
Message-ID: <fd54a7b8-d88f-af70-61a2-f32befac21be@codeaurora.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
 <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
 <20170428204803.plu467okibtxga4d@rob-hp-laptop> <m2inleux0w.fsf@baylibre.com>
 <20170508041511.GB17010@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170508041511.GB17010@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 05/08/2017 09:45 AM, Viresh Kumar wrote:
> On 06-05-17, 11:58, Kevin Hilman wrote:
>> Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>>
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
>>> Not really sure OPP binding makes sense here.
>>
>> I think OPP makes perfect sense here, because microcontroller firmware
>> is managaging OPPs in hardware.  We just may not know the exact voltage
>> and/or frequency (and the firmware/hardware may even be doing AVS for
>> micro-adjustments.)
> 
> Yes, AVS is being done for the Qcom SoC as well.
> 
>>> What about all the other properties. We expose voltage, but not freq?
>>
>> I had the same question.  Seems the same comment about an abstract
>> "index" is needed for voltage also.
> 
> Why should we do that? Here are the cases that I had in mind while writing this:
> 
> - DT only contains the performance-index and nothing else (i.e. voltages aren't
>   exposed).
> 
>   We wouldn't be required to fill the microvolt property as it is optional.

So the performance-index is specified in opp-hz property?
What if the microcontroller firmware maps the performance-index to voltage but
expects linux to scale the frequency? There is no way to specify a performance-index
*and* a frequency for a OPP now I guess?

> 
> - DT contains both performance-index and voltages.
> 
>   The microvolts property will contain the actual voltages and opp-hz will
>   contain the index.

So this is for cases where the performance-index maps to a freq managed by the
microcontroller and voltages managed by linux? I have a case of exact opposite
and I don't see now how to handle it now with these bindings.

> 
> I don't see why would we like to put some index value in the microvolts
> property. We are setting the index value in the opp-hz property to avoid adding
> extra fields and making sure opp-hz is still the unique property for the nodes.

Maybe to handle the case like what I described above?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
