From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 3/3] Documentation: devicetree: add PPMU events
 description
Date: Thu, 18 Apr 2019 11:50:46 +0200
Message-ID: <ec6c7ce1-ee13-6921-2656-8a027c3c0686@partner.samsung.com>
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074835eucas1p19319bedd176d55e10b272881b7c68919@eucas1p1.samsung.com>
        <1555487288-4777-4-git-send-email-l.luba@partner.samsung.com>
        <0d867843-ec56-f30b-8a3f-b3172f325bef@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0d867843-ec56-f30b-8a3f-b3172f325bef@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/17/19 10:26 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
>> Extend the documenation by events description with new 'event-data-type'
>> field. Add example how the event might be defined in DT.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> index 3e36c1d..47feb5f 100644
>> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>>   			reg = <0x104d0000 0x2000>;
>>   			status = "disabled";
>>   		};
>> +
>> +The 'event' type specified in the PPMU node defines 'event-name'
>> +which also contains 'id' number and optionally 'event-data-type'.
>> +
>> +Example:
>> +
>> +		events {
>> +			ppmu_leftbus_0: ppmu-event0-leftbus {
>> +				event-name = "ppmu-event0-leftbus";
>> +				event-data-type = <PPMU_RO_DATA_CNT>;
>> +			};
>> +		};
>> +
>> +The 'event-data-type' defines the type of data which shell be counted
>> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> 
> I replied about 'pmu' name on patch2. Please check it.
Yes, I've seen it and responded.
> 
>> +all possible type, i.e. count read requests, count write data in bytes,
>> +etc. This field is optional and when it is missing, the driver code will
>> +use default data type.
>>
> Looks good to me.
> But, If you want to add the new 'event-data-type' property,
> you better to add 'event-data-type' to Exynos dts file including
> PPMU device.
> 
> If the dts file contain the data type information,
> I think it is easy to understand for the user
> what is monitoring on PPMU device.

Make sense, I will do that. It will be explicitly telling the user what
is currently monitored in the PPMU device event.

Regards,
Lukasz
> 
> 
