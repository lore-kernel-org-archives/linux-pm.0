From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Sat, 06 May 2017 11:58:39 +0200
Message-ID: <m2inleux0w.fsf@baylibre.com>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
        <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
        <20170428204803.plu467okibtxga4d@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170428204803.plu467okibtxga4d@rob-hp-laptop> (Rob Herring's
        message of "Fri, 28 Apr 2017 15:48:03 -0500")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Wed, Apr 26, 2017 at 04:27:05PM +0530, Viresh Kumar wrote:
>> Power-domains need to express their active states in DT and the devices
>> within the power-domain need to express their dependency on those active
>> states. The power-domains can use the OPP tables without any
>> modifications to the bindings.
>> 
>> Add a new property "power-domain-opp", which will contain phandle to the
>> OPP node of the parent power domain. This is required for devices which
>> have dependency on the configured active state of the power domain for
>> their working.
>> 
>> For some platforms the actual frequency and voltages of the power
>> domains are managed by the firmware and are so hidden from the high
>> level operating system. The "opp-hz" property is relaxed a bit to
>> contain indexes instead of actual frequency values to support such
>> platforms.
>> 
>> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/opp/opp.txt | 74 ++++++++++++++++++++++++++-
>>  1 file changed, 73 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index 63725498bd20..6e30cae2a936 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -77,7 +77,10 @@ This defines voltage-current-frequency combinations along with other related
>>  properties.
>>  
>>  Required properties:
>> -- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
>> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. In some
>> +  cases the exact frequency in Hz may be hidden from the OS by the firmware and
>> +  this field may contain values that represent the frequency in a firmware
>> +  dependent way, for example an index of an array in the firmware.
>
> Not really sure OPP binding makes sense here.

I think OPP makes perfect sense here, because microcontroller firmware
is managaging OPPs in hardware.  We just may not know the exact voltage
and/or frequency (and the firmware/hardware may even be doing AVS for
micro-adjustments.)

> What about all the other properties. We expose voltage, but not freq?

I had the same question.  Seems the same comment about an abstract
"index" is needed for voltage also.

>>  
>>  Optional properties:
>>  - opp-microvolt: voltage in micro Volts.
>> @@ -154,6 +157,13 @@ properties.
>>  
>>  - status: Marks the node enabled/disabled.
>>  
>> +- power-domain-opp: Phandle to the OPP node of the parent power-domain. The
>> +  parent power-domain should be configured to the OPP whose node is pointed by
>> +  the phandle, in order to configure the device for the OPP node that contains
>> +  this property. The order in which the device and power domain should be
>> +  configured is implementation defined. The OPP table of a device can set this
>> +  property only if the device node contains "power-domains" property.
>> +

I do understand the need to map a device OPP to a parent power-domain
OPP, but I really don't like another phandle.

First, just because a device OPP changes does not mean that a
power-domain OPP has to change.  What really needs to be specified is a
minimum requirement, not an exact OPP.  IOW, if a device changes OPP,
the power-domain OPP has to be *at least* an OPP that can guarantee that
level of performance, but could also be a more performant OPP, right?

Also, the parent power-domain driver will have a list of all its
devices, and be able to get OPPs from those devices.

IMO, we should do the first (few) implementations of this feature from
the power-domain driver itself, and not try to figure out how to define
this for everyone in DT until we have a better handle on it (pun
intended) ;)

> I don't even know what to say on this. The continual evolution of 
> OPP bindings continues. This seems like further abuse of DT 
> power-domains (being a region in a chip that can be powergated) with 
> Linux PM domains.

Agreed.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
