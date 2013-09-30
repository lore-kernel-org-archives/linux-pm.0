From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH 1/3] PM / OPP: extend DT binding to specify phandle of
 another node for OPP
Date: Mon, 30 Sep 2013 13:33:48 +0100
Message-ID: <52496FAC.7000901@arm.com>
References: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1379501893-12669-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <20130930085227.GB19738@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47771 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab3I3Mdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 08:33:32 -0400
In-Reply-To: <20130930085227.GB19738@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>

On 30/09/13 09:52, Mark Rutland wrote:
> Hi Sudeep,
> 
> I have a few comments.
> 
> On Wed, Sep 18, 2013 at 11:58:11AM +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> If more than one similar devices share the same operating points(OPPs)
>> being in the same clock domain, currently we need to replicate the
>> OPP entries in all the nodes.
>>
>> This patch extends existing binding by adding a new property named
>> 'operating-points-phandle' to specify the phandle in any device node
>> pointing to another node which contains the actual OPP tuples.
>> This helps to avoid replication if multiple devices share the OPPs.
>>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> ---
>>  Documentation/devicetree/bindings/power/opp.txt | 152 ++++++++++++++++++++++--
>>  1 file changed, 140 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
>> index 74499e5..e9fea65 100644
>> --- a/Documentation/devicetree/bindings/power/opp.txt
>> +++ b/Documentation/devicetree/bindings/power/opp.txt
>> @@ -4,22 +4,150 @@ SoCs have a standard set of tuples consisting of frequency and
>>  voltage pairs that the device will support per voltage domain. These
>>  are called Operating Performance Points or OPPs.
>>  
>> -Properties:
>> +Required Properties:
>>  - operating-points: An array of 2-tuples items, and each item consists
>>    of frequency and voltage like <freq-kHz vol-uV>.
>>  	freq: clock frequency in kHz
>>  	vol: voltage in microvolt
>>  
>> +Optional properties:
>> +- operating-points-phandle: phandle to the device tree node which contains
>> +	the operating points tuples(recommended to be used if multiple
>> +	devices are in the same clock domain and hence share OPPs, as it
>> +	avoids replication of OPPs)
>> +
> 
> I assume if you have an operating-points-phandle property,
> operating-points it no longer required. That should probably be
> described.
> 
Correct, infact do it make sense to list both operating-points and
operating-points-phandle as required property but they are mutually exclusive ?

>>  Examples:
>>  
>> -cpu@0 {
>> -	compatible = "arm,cortex-a9";
>> -	reg = <0>;
>> -	next-level-cache = <&L2>;
>> -	operating-points = <
>> -		/* kHz    uV */
>> -		792000  1100000
>> -		396000  950000
>> -		198000  850000
>> -	>;
>> -};
>> +1. A uniprocessor system (phandle not required)
>> +
>> +	cpu0: cpu@0 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <0>;
>> +		operating-points = <
>> +			/* kHz    uV */
>> +			792000  1100000
>> +			396000  950000
>> +			198000  850000
>> +		>;
>> +	};
>> +
>> +If more than one device of same type share the same OPPs, for example
>> +all the CPUs on a SoC or in a single cluster on a SoC, then we need to
>> +avoid replicating the OPPs in all the nodes. We can specify the phandle
>> +of the node which contains the OPP tuples
> 
> This seems a bit out of place given the example immediately below.
> 
Sorry carried from previous version, will fix it.

>> +
>> +2a. Consider a SMP system with 4 CPUs in the same clock domain
>> +    (backward compatible style, only CPU0 contains OPP)
>> +
>> +	cpu0: cpu@0 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <0>;
>> +		operating-points = <
>> +			/* kHz    uV */
>> +			792000  1100000
>> +			396000  950000
>> +			198000  850000
>> +		>;
>> +	};
>> +
>> +	cpu1: cpu@1 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <1>;
>> +	};
>> +
>> +	cpu2: cpu@2 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <2>;
>> +	};
>> +
>> +	cpu3: cpu@3 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <3>;
>> +	};
> 
> This "backward compatible style" doesn't seem to actually be described
> anywhere, and the paragraph above about phandles makes it somewhat
> confusing.
> 
Not sure if this is needed at all here. I must say there's nothing called
backward compatible style, the only reason I added it to tell that existing
cpufreq-cpu0 DTs continue to work.

I would say it's more like some agreement with the existing binding and the
cpufreq-cpu0 driver. Do it make sense to drop it from here ?

>> +
>> +2b. Consider a SMP system with 4 CPUs in the same clock domain
>> +    (using operating-points-phandle)
>> +
>> +	cpu0: cpu@0 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <0>;
>> +		operating-points-phandle = <&cpu_opp>;
>> +	};
>> +
>> +	cpu1: cpu@1 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <1>;
>> +		operating-points-phandle = <&cpu_opp>;
>> +	};
>> +
>> +	cpu2: cpu@2 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <2>;
>> +		operating-points-phandle = <&cpu_opp>;
>> +	};
>> +
>> +	cpu3: cpu@3 {
>> +		compatible = "arm,cortex-a9";
>> +		reg = <3>;
>> +		operating-points-phandle = <&cpu_opp>;
>> +	};
>> +
>> +	operating_points {
>> +		cpu_opp: cpu_opp {
>> +			operating-points = <
>> +				/* kHz    uV */
>> +				792000  1100000
>> +				396000  950000
>> +				198000  850000
>> +			>;
>> +		};
>> +		... /* other device OPP nodes */
>> +	}
> 
> Is this all inside the /cpus node?
> 
It can be anywhere, if only cpus share OPPs on a system, it can be placed under
/cpus. The idea to put all OPP nodes under one node is just for readibility
purposes. As along as phandle is correct it doesn't matter where the exact nodes
are. Does this need to be mentioned explicity in the binding ?

> Is the "operating_points" name important?
> 
> Are all OPP tables expected to be in the same "operating_points" node?
> 
No for both the above questions, again just for readibilty I chose that name and
placed all OPP nodes under same node in the example, it can be named anything
and can be scattered.
Again does this need to be mentioned explicity in the binding ?

Regards,
Sudeep

