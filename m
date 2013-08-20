From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Tue, 20 Aug 2013 11:00:06 +0100
Message-ID: <52133E26.1000801@arm.com>
References: <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <20130731152925.GP29859@e106331-lin.cambridge.arm.com> <51F9341E.60102@ti.com> <20130731161103.GS29859@e106331-lin.cambridge.arm.com> <51F93AFB.1030104@ti.com> <20130801135422.GA8095@e106331-lin.cambridge.arm.com> <51FA8BE2.9000309@ti.com> <20130802131541.GN2884@e106331-lin.cambridge.arm.com> <20130806134534.GB6603@kahuna> <20130807161722.GJ28558@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130807161722.GJ28558@e106331-lin.cambridge.arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 07/08/13 17:17, Mark Rutland wrote:
> On Tue, Aug 06, 2013 at 02:45:34PM +0100, Nishanth Menon wrote:
>> On 14:15-20130802, Mark Rutland wrote:
>>> On Thu, Aug 01, 2013 at 05:25:06PM +0100, Nishanth Menon wrote:
>>>> On 08/01/2013 08:54 AM, Mark Rutland wrote:
>>>>> On Wed, Jul 31, 2013 at 05:27:39PM +0100, Nishanth Menon wrote:
>>>>>> On 07/31/2013 11:11 AM, Mark Rutland wrote:
>>>>>>> On Wed, Jul 31, 2013 at 04:58:22PM +0100, Nishanth Menon wrote:
>>>>>>>> On 07/31/2013 10:29 AM, Mark Rutland wrote:
>>>>>>>>> On Wed, Jul 31, 2013 at 03:46:34PM +0100, Nishanth Menon wrote:
>>>>>>>>>> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
>>>>>>>>>>> On 30/07/13 21:48, Nishanth Menon wrote:
>>>>>>>>>>>> On 07/30/2013 01:34 PM, Stephen Warren wrote:
>>>>>>>>>>>>> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
>> [...]
>>>>
>>>>>
>>>>> * Performance profiles, in which you have a set of OPP tables for
>>>>>    "performance, "low-power", and whatever else. This arbitrary split
>>>>>    seems like a configuration decision rather than a hardware description
>>>>>    unless there is some hard limit that cannot be detected (e.g. the
>>>>>    processor can function at some arbitrary high speed, but becomes hot
>>>>>    enough to melt something, and there's no temperature sensor to handle
>>>>>    this case dynamically).
>>>>
>>>> precisely -> I think I point this out in this thread:
>>>> http://marc.info/?l=devicetree&m=137535932402560&w=2
>>>
>>> The one thing I don't like is the arbitrary grouping into profiles, as
>>> the division is entirely a configuration decision. The operating points
>>> themselves are a hardware capability, and it may make sense to describe
>>> the feasible points for a device in the dt, but I don't want to have
>>> different profiles exported because it straddles the line of the dt
>>> telling us how to use the hardware rather than what the hardware is, and
>>> will come back to bite us later if we want to handle cpu frequency
>>> decisions differently.
>>
>> I can understand why it seems to wrongly indicate *how* to use the
>> hardware, rather than *what the hardware is* - Lets try it this way:
>> - if Bit X is set in efuse, one cannot use high performance mode
>> - If PDN (Power Distribution Network) guidelines are not met, one cannot
>> use high performance mode.
>>
>> These constrain *hardware capability* you can do on that SoC+Board
>> combination - that is exactly what we have been struggling to describe
>> here. These are not *how to use hardware* profiles, but *hardware
>> capability* profiles whose selection is upto to the System in
>> discussion - example - SoC x will decide on bit based decision and
>> forbid Board file overrides while an SoC y family might choose another
>> path.. Framework and dts should not dictate policy and we dont try to
>> do that here.
>>
>> How to use the hardware within the *capability costraints* is upto
>> drivers, there is no attempt to define that in my proposal.
> 
> I'm happy to have the OPPs, as your arguments certainly make sense. My
> only concern is that if we have them grouped in some fashion in dt (e.g.
> profiles), people will use this as configuration, treating the groups of
> OPPs differnetly (prefering a 'performance' or 'low-power' profile). I'd
> prefer that any decision on how to use the provided OPP values were done
> in the kernel dynamically.
> 
> I suspect even if we remove profile names, people will attempt to read
> some semantics into the groupings. For that reason, I'd prefer to have a
> single OPP table for any device (though this table could be shared by
> devices).
> 

Until we get more feedback and agreement on new proposal can we have
this simple amendment in this patch to the existing binding ? Since the
new proposal[1] is backward compatible(this patch adding support for
option#5 to existing option#1), we will have to add support for other
binding options in [1] later.

This is needed to support shared OPPs with simple/single OPP profile
and also to fix the broken and unused binding
@Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt

Regards,
Sudeep

[1] http://www.spinics.net/lists/cpufreq/msg06563.html


