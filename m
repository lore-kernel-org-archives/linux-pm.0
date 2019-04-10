From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Date: Wed, 10 Apr 2019 12:52:15 +0300
Message-ID: <b94feeea-49d2-6761-11f5-fe2e9a3fa98b@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
 <20190314062312.vwyu3ryeyc6iv55h@vireshk-i7>
 <e462c932-4789-4f59-ad58-98c62266d977@linaro.org>
 <20190410040556.uwnhmhajcasic7hb@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410040556.uwnhmhajcasic7hb@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 4/10/19 07:05, Viresh Kumar wrote:
> On 09-04-19, 17:36, Georgi Djakov wrote:
>> Hi Viresh,
>>
>> On 3/14/19 08:23, Viresh Kumar wrote:
>>> On 13-03-19, 11:00, Georgi Djakov wrote:
>>>> In addition to frequency and voltage, some devices may have bandwidth
>>>> requirements for their interconnect throughput - for example a CPU
>>>> or GPU may also need to increase or decrease their bandwidth to DDR
>>>> memory based on the current operating performance point.
>>>>
>>>> Extend the OPP tables with additional property to describe the bandwidth
>>>> needs of a device. The average and peak bandwidth values depend on the
>>>> hardware and its properties.
>>>>
>>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>>>>  1 file changed, 45 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>>> index 76b6c79604a5..fa598264615f 100644
>>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>>> @@ -129,6 +129,9 @@ Optional properties:
>>>>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>>>>    opp-microvolt-<name> property, but for microamp instead.
>>>>  
>>>> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
>>>> +  the two integer values for average and peak bandwidth in megabytes per second.
>>>> +
>>>>  - opp-level: A value representing the performance level of the device,
>>>>    expressed as a 32-bit integer.
>>>>  
>>>> @@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>>>>  		};
>>>>  	};
>>>>  };
>>>> +
>>>> +Example 7: opp-bw-MBs:
>>>> +(example: average and peak bandwidth values are defined for each OPP and the
>>>> +interconnect between CPU and DDR memory is scaled together with CPU frequency)
>>>> +
>>>> +/ {
>>>> +	cpus {
>>>> +		CPU0: cpu@0 {
>>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>>> +			...
>>>> +			operating-points-v2 = <&cpu_opp_table>;
>>>> +			/* path between the CPU and DDR memory */
>>>> +			interconnects = <&rpm_bimc MASTER_AMPSS_M0
>>>> +					&rpm_bimc SLAVE_EBI_CH0>;
>>>
>>> Can we have multiple paths for a device ?
>>
>> I suppose that this is also a possible scenario. Will propose something
>> to handle multiple paths too.
>>
>>>> +		};
>>>> +	};
>>>> +
>>>> +	cpu_opp_table: cpu_opp_table {
>>>> +		compatible = "operating-points-v2";
>>>> +		opp-shared;
>>>> +
>>>> +		opp-200000000 {
>>>> +			opp-hz = /bits/ 64 <200000000>;
>>>> +			/* 457 MB/s average and 1525 MB/s peak bandwidth */
>>>> +			opp-bw-MBs = <457 1525>;
>>>
>>> In that case fixing this to just 2 entries in the array is incorrect
>>> and we should take care of that in the bindings here.
>>
>> We can encode the path name into the property (when there are multiple
>> paths). We already have opp-microamp-<name> and opp-microamp-<name>, so
>> we can follow the same practice.
>>
>> For example:
>>
>> CPU0: cpu@0 {
>> 	compatible = "arm,cortex-a53", "arm,armv8";
>> 	...
>> 	operating-points-v2 = <&cpu_opp_table>;
>> 	/* path between the CPU and DDR and path between CPU and L3 */
>> 	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
>> 			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
>> 	interconnect-names "cpu-mem", "cpu-l3";
>> };
>>
>> cpu_opp_table: cpu_opp_table {
>> 	compatible = "operating-points-v2";
>> 	opp-shared;
>>
>> 	opp-200000000 {
>> 		opp-hz = /bits/ 64 <200000000>;
>> 		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
>> 		opp-bw-MBps-cpu-mem = <457 1525>;
>> 		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
>> 		opp-bw-MBps-cpu-l3 = <914 3050>;
>> 	};
>> };
> 
> The -<name> property is different as only one of the value is ever used, i.e. we
> can have opp-microvolt-speed0/1/2/3 (4 different values/properties) and only
> opp-microvolt-speed1 will be used eventually and all others are discarded.
> 
> Also I am not sure if this will be actually required. We already have a list of
> interconnects above and the order of that can be taken as reference here. i.e.
> 
> CPU0: cpu@0 {
> 	compatible = "arm,cortex-a53", "arm,armv8";
> 	...
> 	operating-points-v2 = <&cpu_opp_table>;
> 	/* path between the CPU and DDR and path between CPU and L3 */
> 	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
> 			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
> };
> 
> cpu_opp_table: cpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
> 		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
> 		opp-bw-MBps = <457 1525>, <914 3050>;
> 	};
> };

This works too.

> 
> I also strongly believe that "opp-bw-MBps" should be renamed in a way to make it
> independent of the OPPs. For example, we may have devices which also need to add
> their vote for the bandwidth but don't have an OPP table as they don't do DVFS.
> And the same property should be used by them directly as what we will have in
> the individual OPPs in the above example case.
> 
> So maybe something like bw-MBps or something else.

Ok, will make it bandwidth-MBps.

Thanks,
Georgi
