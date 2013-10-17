From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle
 of another node for OPP
Date: Thu, 17 Oct 2013 12:15:45 +0100
Message-ID: <525FC6E1.5060401@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <5252DAD3.6040903@gmail.com> <525400B4.8060203@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <525400B4.8060203@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Kumar Gala <galak@codeaurora.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi DT-folks,

On 08/10/13 13:55, Sudeep KarkadaNagesha wrote:
> On 07/10/13 17:01, Rob Herring wrote:
>> On 10/01/2013 08:32 AM, Sudeep KarkadaNagesha wrote:
>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>
>>> If more than one similar devices share the same operating points(OPPs)
>>> being in the same clock domain, currently we need to replicate the
>>> OPP entries in all the nodes.
>>>
>>> This patch extends existing binding by adding a new property named
>>> 'operating-points-phandle' to specify the phandle in any device node
>>> pointing to another node which contains the actual OPP tuples.
>>> This helps to avoid replication if multiple devices share the OPPs.
>>>
>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>> ---
>>>  Documentation/devicetree/bindings/power/opp.txt | 161 ++++++++++++++++++++++--
>>>  1 file changed, 149 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
>>> index 74499e5..f59b878 100644
>>> --- a/Documentation/devicetree/bindings/power/opp.txt
>>> +++ b/Documentation/devicetree/bindings/power/opp.txt
>>> @@ -4,22 +4,159 @@ SoCs have a standard set of tuples consisting of frequency and
>>>  voltage pairs that the device will support per voltage domain. These
>>>  are called Operating Performance Points or OPPs.
>>>  
>>> -Properties:
>>> +Required Properties:
>>>  - operating-points: An array of 2-tuples items, and each item consists
>>>    of frequency and voltage like <freq-kHz vol-uV>.
>>>  	freq: clock frequency in kHz
>>>  	vol: voltage in microvolt
>>>  
>>> +- operating-points-phandle: phandle to the device tree node which contains
>>> +	the operating points tuples(recommended to be used if multiple
>>> +	devices are in the same clock domain and hence share OPPs, as it
>>> +	avoids replication of OPPs)
>>> +
>>> +  operating-points and operating-points-phandle are mutually exclusive, only
>>> +  one of them can be present in any device node.
>>> +
>>>  Examples:
>>>  
>>> -cpu@0 {
>>> -	compatible = "arm,cortex-a9";
>>> -	reg = <0>;
>>> -	next-level-cache = <&L2>;
>>> -	operating-points = <
>>> -		/* kHz    uV */
>>> -		792000  1100000
>>> -		396000  950000
>>> -		198000  850000
>>> -	>;
>>> -};
>>> +1. A uniprocessor system (phandle not required)
>>> +
>>> +	cpu0: cpu@0 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <0>;
>>> +		operating-points = <
>>> +			/* kHz    uV */
>>> +			792000  1100000
>>> +			396000  950000
>>> +			198000  850000
>>> +		>;
>>> +	};
>>> +
>>> +2a. Consider a SMP system with 4 CPUs in the same clock domain(no phandle)
>>> +    Some existing DTs describe homogenous SMP systems by only listing the
>>> +    OPPs in the cpu@0 node. For compatiblity with existing DTs, an
>>> +    operating system may handle this case specially.
>>> +
>>> +	cpu0: cpu@0 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <0>;
>>> +		operating-points = <
>>> +			/* kHz    uV */
>>> +			792000  1100000
>>> +			396000  950000
>>> +			198000  850000
>>> +		>;
>>> +	};
>>> +
>>> +	cpu1: cpu@1 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <1>;
>>> +	};
>>> +
>>> +	cpu2: cpu@2 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <2>;
>>> +	};
>>> +
>>> +	cpu3: cpu@3 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <3>;
>>> +	};
>>> +
>>> +2b. Consider a SMP system with 4 CPUs in the same clock domain(with phandle)
>>> +    If more than one device of same type share the same OPPs, for example
>>> +    all the CPUs on a SoC or in a single cluster on a SoC, then we can avoid
>>> +    replicating the OPPs in all the nodes. We can specify the phandle of
>>> +    the node which contains the OPP tuples instead.
>>> +
>>> +	cpu0: cpu@0 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <0>;
>>> +		operating-points-phandle = <&cpu_opp>;
>>> +	};
>>> +
>>> +	cpu1: cpu@1 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <1>;
>>> +		operating-points-phandle = <&cpu_opp>;
>>> +	};
>>> +
>>> +	cpu2: cpu@2 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <2>;
>>> +		operating-points-phandle = <&cpu_opp>;
>>> +	};
>>> +
>>> +	cpu3: cpu@3 {
>>> +		compatible = "arm,cortex-a9";
>>> +		reg = <3>;
>>> +		operating-points-phandle = <&cpu_opp>;
>>> +	};
>>> +
>>> +	opps-table {
>>> +		cpu_opp: cpu_opp {
>>> +			operating-points = <
>>> +				/* kHz    uV */
>>> +				792000  1100000
>>> +				396000  950000
>>> +				198000  850000
>>> +			>;
>>> +		};
>>> +		... /* other device OPP nodes */
>>
>> But this is a subnode of /cpus. IMO, OPPs should be located near what
>> they control.
>>
> No, the idea was to group all the shared OPPs in a container node like clocks or
> pinmux. So opps-table in above example need not be subnode of /cpus.
> 
>>
>>> +	}
>>> +
>>> +4. Consider an AMP(asymmetric multi-processor) sytem with 2 clusters of
>>> +   CPUs. Each cluster has 2 CPUs and all the CPUs within the cluster share
>>> +   the clock domain.
>>> +
>>> +	cpu0: cpu@0 {
>>> +		compatible = "arm,cortex-a15";
>>> +		reg = <0>;
>>> +		operating-points-phandle = <&cluster0_opp>;
>>> +	};
>>> +
>>> +	cpu1: cpu@1 {
>>> +		compatible = "arm,cortex-a15";
>>> +		reg = <1>;
>>> +		operating-points-phandle = <&cluster0_opp>;
>>> +	};
>>> +
>>> +	cpu2: cpu@100 {
>>> +		compatible = "arm,cortex-a7";
>>> +		reg = <100>;
>>> +		operating-points-phandle = <&cluster1_opp>;
>>> +	};
>>> +
>>> +	cpu3: cpu@101 {
>>> +		compatible = "arm,cortex-a7";
>>> +		reg = <101>;
>>> +		operating-points-phandle = <&cluster1_opp>;
>>> +	};
>>> +
>>> +	opps-table {
>>> +		cluster0_opp: cluster0_opp {
>>
>> Why not use the cpu topology? Then the operating point can apply to
>> cores based on the position in the topology. You don't even need a
>> phandle in that case. You can look for OPPs in either a cpu node or in
>> the topology.
>>
> Agreed but few thoughts behind this binding:
> 
> 1. OPPs are not just cpu specific:
>    How do we share OPPs for 2 devices in the same clock domain ?
>    Also moving the OPP into cpu-topo makes parsing specific to cpu.
>    Currently the OPP library fetches the of_node from the device struct
>    which is applicable to any devices.
> 
> 2. Should cpu topology(i.e. cpu-map) just contain the topology info ? and
>    phandles to these nodes should be used to setup any affinity ?
> 
> 3. As part of RFC[1][2], it was also discussed that on some SoCs we need
>    multiple OPP profiles/options which it provides but only one of them can
>    be used based on the board design. phandle to OPP will also help resolve
>    that issue.
> 
> Let me know your thoughts.
> 

(pinging to get this discussion alive again)
Is this extension to the binding to support shared OPPs acceptable ?
If not, any ideas to progress on this is helpful.

Regards,
Sudeep

> 
> [1] http://www.spinics.net/lists/cpufreq/msg06556.html
> [2] http://www.spinics.net/lists/cpufreq/msg06685.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


