From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 11:27:39 -0500
Message-ID: <51F93AFB.1030104@ti.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <20130731152925.GP29859@e106331-lin.cambridge.arm.com> <51F9341E.60102@ti.com> <20130731161103.GS29859@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130731161103.GS29859@e106331-lin.cambridge.arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 07/31/2013 11:11 AM, Mark Rutland wrote:
> On Wed, Jul 31, 2013 at 04:58:22PM +0100, Nishanth Menon wrote:
>> On 07/31/2013 10:29 AM, Mark Rutland wrote:
>>> On Wed, Jul 31, 2013 at 03:46:34PM +0100, Nishanth Menon wrote:
>>>> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
>>>>> On 30/07/13 21:48, Nishanth Menon wrote:
>>>>>> On 07/30/2013 01:34 PM, Stephen Warren wrote:
>>>>>>> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
>>>>>>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>>>>>
>>>>>>>> If more than one similar devices share the same OPPs, currently we
>>>>>>>> need to replicate the OPP entries in all the nodes.
>>>>>>>>
>>>>>>>> Few drivers like cpufreq depend on physical cpu0 node to specify the
>>>>>>>> OPPs and only that node is referred irrespective of the logical cpu
>>>>>>>> accessing it. Alternatively to support cpuhotplug path, few drivers
>>>>>>>> parse all the cpu nodes for OPPs. Instead we can specify the phandle
>>>>>>>> of the node with which the current node shares the operating points.
>>>>>>>>
>>>>>>>> This patch adds support to specify the phandle in the operating points
>>>>>>>> of any device node, where the node specified by the phandle holds the
>>>>>>>> actual OPPs.
>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
>>>>>>>
>>>>>>>> +Optional properties:
>>>>>>>> +- operating-points-phandle: phandle to the device node with which this
>>>>>>>
>>>>>>> That's a funny name. Bikeshedding a bit, how about shared-operating-points?
>>>>>>>
>>>>>>> I haven't thought at all about whether this change conceptually makes sense.
>>>>>>>
>>>>>>
>>>>>> They may not really be shared- we could have phandle list even. one
>>>>>> might have optional OPP sets for a chip family that one may  - I was
>>>>>> about to suggest something similar to pinctrl
>>>>>>
>>>>> I am not sure if I follow you here, if each chip family has its unique
>>>>> set of OPPs, why do we need to represent all of them together ?
>>>>> IIUC you are thinking about having these in include dts file, used by
>>>>> multiple chip/board dts.
>>>>>
>>>>>> operating-points-names = "default", "performance", "cheapboard-config" ;)
>>>>>> operating-points-0 = <&...>
>>>>>> operating-points-1 = <&...>
>>>>>> operating-points-2 = <&...>
>>>>>>
>>>>> This looks more like a PM policy.
>>>>
>>>> Let me try to explain since SoCs such as OMAP/AM family dont make life
>>>> trivial :)..
>>>>
>>>> An legacy example[1][2]
>>>>
>>>> SoC DM explains that the chip is capable of X opps:
>>>> opp1, 2 - for all devices
>>>> opp1,2, 3 - if efuse bit X@y is set
>>>> opp1,2,3,4 - if efuse bit X@y is set AND Board design meets SoC vendors
>>>> requirements (including additional features A, B is enabled).
>>>>
>>>> So, the same chip family has a hardware feature - not just as a pm
>>>> policy of selecting among a set of OPPs which opp to work on, but the
>>>> actual set of OPPs are actually options in themselves that is selected
>>>> based on board's SoC selection.
>>>
>>> This sounds like we're describing a set of features not applicable to
>>> the device, then removing them, rather than only describing those
>>> features applicable to the device. If you have to probe to figure out
>>> which values in the dt are applicable, I'm not sure I see the benefit of
>>> describing said values in dt.
>>
>> Device has *options* of operating points sets it can operate at. It is
>> not like "these are not applicable" for the device.
>
> I don't follow.
>
> In the example above, if efuse bit X@y is not set, opp3 is not
> applicable, but we're describing it in dt. It's not an option for the
> particular device, yet it appears in the device's dt.
This one is easy - opp_enable/disable as discussed in 
http://marc.info/?l=linux-pm&m=137528631125365&w=2 should probably help.
>
> For opp4, it's even worse, as you're suggesting we describe an option
> for the device that requires the driver to use some additional platform
> knowledge to come to the conclusion that it cannot use. That sounds like

Precisely.. it wont have that knowledge and should not need that 
knowledge. See explanation above.

Specific examples: SoC vendors try to squeeze the max out of the chip, 
when voltage values are defined, they need to consider board markets 
that they try to address, pricepoints etc.. too many vectors.. not all 
board manufacturers care to meet SoC vendor requirements as they may not 
care about picking up the full potential of the chip - example - 
usecases on OMAP where ARM is seldom used and max DSP is used (video 
usecases) and others so they use a high performance chip, refuse to 
optimize vdd_mpu rail, dont care too much about higher ARM OPPs. Yeah, I 
could always tell them to hand edit the OPP entries and maintain kernel 
forks, but that is never the right thing to do.


> device knowledge internal to a driver, not how you describe an instance
> of a device to an OS.

OPP has never been a device - it is a performance point at which to 
operate a device. I am not sure if we are discussing about phandle 
definition of OPP is an issue or options of operating-point sets is an 
issue now.

>
> Have I misunderstood something here?

Are you suggesting we have OPP tables per board?

>
>>
>> DT does have to describe the hardware capability - that was it's entire
>> intent. operating points are valid configurations where it can be
>> operated at - and when you have options of configurations you need to
>> choose from based on the board you are using it on, it still retains
>> "hardware behavior" aspect.
>
> The dt should describe the particular board you're running on. As I see
> it what you're suggesting is equivalent to describing some hardware in
> the dt that isn't actually present, then relying on the OS to poke
> around somewhere else, figure out that the hardware isn't present, and
> then forget that the dt described it.
I will buy that eventual dtb should contain some way to choose the OPP 
that the particular board can operate on.

SoC dtsi is what we define, this allows multiple board dts to use them. 
the moment we start defining OPPs per board, all mayhem breaks loose.

SoC dtsi provides options for the SoC to be operated upon, it is like 
saying I have 10 Uarts, but board dts chooses to enable the ones it 
uses. pinctrl we do the same. why cant we do with operating-points as well?



-- 
Regards,
Nishanth Menon
