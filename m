From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle
 of another node for OPP
Date: Thu, 17 Oct 2013 18:22:21 +0100
Message-ID: <52601CCD.9020705@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>	<1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>	<5252DAD3.6040903@gmail.com>	<525400B4.8060203@arm.com> <CAL_JsqKPprCKorvfgCH3usvX6hw5moypQYvKTdAznFVoTV-pyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKPprCKorvfgCH3usvX6hw5moypQYvKTdAznFVoTV-pyg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 17/10/13 14:22, Rob Herring wrote:
> On Tue, Oct 8, 2013 at 7:55 AM, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
>> On 07/10/13 17:01, Rob Herring wrote:
>>> On 10/01/2013 08:32 AM, Sudeep KarkadaNagesha wrote:
>>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>
>>>> If more than one similar devices share the same operating points(OPPs)
>>>> being in the same clock domain, currently we need to replicate the
>>>> OPP entries in all the nodes.
>>>>
>>>> This patch extends existing binding by adding a new property named
>>>> 'operating-points-phandle' to specify the phandle in any device node
>>>> pointing to another node which contains the actual OPP tuples.
>>>> This helps to avoid replication if multiple devices share the OPPs.
>>>>
> 
> [snip]
> 
>>>> +    opps-table {
>>>> +            cpu_opp: cpu_opp {
>>>> +                    operating-points = <
>>>> +                            /* kHz    uV */
>>>> +                            792000  1100000
>>>> +                            396000  950000
>>>> +                            198000  850000
>>>> +                    >;
>>>> +            };
>>>> +            ... /* other device OPP nodes */
>>>
>>> But this is a subnode of /cpus. IMO, OPPs should be located near what
>>> they control.
>>>
>> No, the idea was to group all the shared OPPs in a container node like clocks or
>> pinmux. So opps-table in above example need not be subnode of /cpus.
> 
> Clocks are typically defined in a clock controller node. pinmux
> doesn't fit anywhere well so it is an exception. We don't want to
> expand on that. OPP's at least for cpu's would typically follow the
> topology, so put them there.
> 
I agree we don't want OPP to be another exception like pin-mux.

>>>> +    cpu3: cpu@101 {
>>>> +            compatible = "arm,cortex-a7";
>>>> +            reg = <101>;
>>>> +            operating-points-phandle = <&cluster1_opp>;
>>>> +    };
>>>> +
>>>> +    opps-table {
>>>> +            cluster0_opp: cluster0_opp {
>>>
>>> Why not use the cpu topology? Then the operating point can apply to
>>> cores based on the position in the topology. You don't even need a
>>> phandle in that case. You can look for OPPs in either a cpu node or in
>>> the topology.
>>>
>> Agreed but few thoughts behind this binding:
>>
>> 1. OPPs are not just cpu specific:
>>    How do we share OPPs for 2 devices in the same clock domain ?
>>    Also moving the OPP into cpu-topo makes parsing specific to cpu.
>>    Currently the OPP library fetches the of_node from the device struct
>>    which is applicable to any devices.
> 
> But an OPP for a cpu is cpu specific, so put it there. For devices, we
> may need something different. Perhaps it should be part of the clock
> binding in some way.
> 

I still don't understand why we need to handle cpu and other devices
differently. If you think that the devices sharing OPPs can be handled through
clock binding in some way, it should be equally applicable for CPUs too ?
In fact when I started this thread, even I had a similar thought and has asked
on the list[1]

>> 2. Should cpu topology(i.e. cpu-map) just contain the topology info ? and
>>    phandles to these nodes should be used to setup any affinity ?
> 
> Can't the OPP just be in the topology nodes at the appropriate level.
> Then the kernel can look for the OPPs in either place. Perhaps Lorenzo
> has thoughts on this.
> 

Ok will check with Lorenzo. I agree that we can extend topology binding so that
we add OPPs there. But I would like to avoid that if we think we can solve it
through clock bindings as mentioned above.

>> 3. As part of RFC[1][2], it was also discussed that on some SoCs we need
>>    multiple OPP profiles/options which it provides but only one of them can
>>    be used based on the board design. phandle to OPP will also help resolve
>>    that issue.
> 
> Then include the OPP required for that board design. You could have
> dtsi files of OPPs that can be included based on the board.
> 

I will let Nishanth comment on this.

Regards,
Sudeep

[1] http://marc.info/?l=linux-pm&m=137449807414601&w=4

