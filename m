From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / OPP: extend DT binding to specify phandle of
 another node for OPP
Date: Mon, 30 Sep 2013 17:46:24 +0100
Message-ID: <5249AAE0.5040609@arm.com>
References: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1379501893-12669-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <20130930085227.GB19738@e106331-lin.cambridge.arm.com> <52496FAC.7000901@arm.com> <20130930155145.GC22259@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130930155145.GC22259-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30/09/13 16:51, Mark Rutland wrote:
> On Mon, Sep 30, 2013 at 01:33:48PM +0100, Sudeep KarkadaNagesha wrote:
>> On 30/09/13 09:52, Mark Rutland wrote:
>>> Hi Sudeep,
>>>
>>> I have a few comments.
>>>
>>> On Wed, Sep 18, 2013 at 11:58:11AM +0100, Sudeep KarkadaNagesha wrote:
[...]
>>>> +
>>>> +2a. Consider a SMP system with 4 CPUs in the same clock domain
>>>> +    (backward compatible style, only CPU0 contains OPP)
>>>> +
>>>> +	cpu0: cpu@0 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <0>;
>>>> +		operating-points = <
>>>> +			/* kHz    uV */
>>>> +			792000  1100000
>>>> +			396000  950000
>>>> +			198000  850000
>>>> +		>;
>>>> +	};
>>>> +
>>>> +	cpu1: cpu@1 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <1>;
>>>> +	};
>>>> +
>>>> +	cpu2: cpu@2 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <2>;
>>>> +	};
>>>> +
>>>> +	cpu3: cpu@3 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <3>;
>>>> +	};
>>>
>>> This "backward compatible style" doesn't seem to actually be described
>>> anywhere, and the paragraph above about phandles makes it somewhat
>>> confusing.
>>>
>> Not sure if this is needed at all here. I must say there's nothing called
>> backward compatible style, the only reason I added it to tell that existing
>> cpufreq-cpu0 DTs continue to work.
>>
>> I would say it's more like some agreement with the existing binding and the
>> cpufreq-cpu0 driver. Do it make sense to drop it from here ?
> 
> It's probably worth adding a paragraph above the example describing
> that, something like:
> 
> Some existing DTs describe homogenous SMP systems by only listing the
> OPPs in the cpu@0 node. For compatiblity with existing DTs, an operating
> system may handle this case specially.
> 
That sounds good, will fix this in next version.

>>
>>>> +
>>>> +2b. Consider a SMP system with 4 CPUs in the same clock domain
>>>> +    (using operating-points-phandle)
>>>> +
>>>> +	cpu0: cpu@0 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <0>;
>>>> +		operating-points-phandle = <&cpu_opp>;
>>>> +	};
>>>> +
>>>> +	cpu1: cpu@1 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <1>;
>>>> +		operating-points-phandle = <&cpu_opp>;
>>>> +	};
>>>> +
>>>> +	cpu2: cpu@2 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <2>;
>>>> +		operating-points-phandle = <&cpu_opp>;
>>>> +	};
>>>> +
>>>> +	cpu3: cpu@3 {
>>>> +		compatible = "arm,cortex-a9";
>>>> +		reg = <3>;
>>>> +		operating-points-phandle = <&cpu_opp>;
>>>> +	};
>>>> +
>>>> +	operating_points {
>>>> +		cpu_opp: cpu_opp {
>>>> +			operating-points = <
>>>> +				/* kHz    uV */
>>>> +				792000  1100000
>>>> +				396000  950000
>>>> +				198000  850000
>>>> +			>;
>>>> +		};
>>>> +		... /* other device OPP nodes */
>>>> +	}
>>>
>>> Is this all inside the /cpus node?
>>>
>> It can be anywhere, if only cpus share OPPs on a system, it can be placed under
>> /cpus. The idea to put all OPP nodes under one node is just for readibility
>> purposes. As along as phandle is correct it doesn't matter where the exact nodes
>> are. Does this need to be mentioned explicity in the binding ?
> 
> I'm not sure what the preferred way of handling container nodes is in
> general. Do we have any examples of existing container nodes (i.e. those
> which aren't devices and don't contain devices) elsewhere?
> 
The closest match I can think of is clocks or pinmux container node in many DTs.
However I see that clock container nodes can hold generic properties like
#address-cell and #size-cells that are applicable for all the nodes in them.
I could not find any documentation on them either :(

>>
>>> Is the "operating_points" name important?
>>>
>>> Are all OPP tables expected to be in the same "operating_points" node?
>>>
>> No for both the above questions, again just for readibilty I chose that name and
>> placed all OPP nodes under same node in the example, it can be named anything
>> and can be scattered.
>> Again does this need to be mentioned explicity in the binding ?
> 
> This would depend on the preferred way of handling container nodes. If
> we want them all in one place, that needs to be documented. If we allow
> them anywhere, that should also be documented (though some guidance
> should probably be given so as to encourage uniform DTs).
> 
Makes sense. I can document recommending to have all the OPPs in single node.
But it's not mandatory as it doesn't matter for OPPs as long as the phandles are
correct. However if it helps for validating DTs, then can we mandate it?

Regards,
Sudeep

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
