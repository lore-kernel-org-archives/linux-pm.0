From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 4/4] DT: arm: exynos4412: add event data type which
 is monitored
Date: Tue, 30 Apr 2019 23:24:27 +0200
Message-ID: <f8873863-9524-1ef0-9633-868edc3b56d3@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6@eucas1p1.samsung.com>
        <1555681688-19643-5-git-send-email-l.luba@partner.samsung.com>
        <cee7b5a2-377e-59d6-7c6e-b6f9b3140d4f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cee7b5a2-377e-59d6-7c6e-b6f9b3140d4f@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org



On 4/30/19 8:10 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>> The patch adds new field in the PPMU event which shows explicitly
>> what kind of data the event is monitoring. It is possible to change it
>> using defined values in exynos_ppmu.h file.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>> index 3a3b2fa..549faba 100644
>> --- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>> @@ -6,12 +6,16 @@
>>    * Author: Chanwoo Choi <cw00.choi@samsung.com>
>>    */
>>   
>> +#include <dt-bindings/pmu/exynos_ppmu.h>
>> +
>>   &ppmu_dmc0 {
>>          status = "okay";
>>   
>>          events {
>>   	       ppmu_dmc0_3: ppmu-event3-dmc0 {
>>   		       event-name = "ppmu-event3-dmc0";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>> @@ -22,6 +26,8 @@
>>          events {
>>   	       ppmu_dmc1_3: ppmu-event3-dmc1 {
>>   		       event-name = "ppmu-event3-dmc1";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>> @@ -32,6 +38,8 @@
>>          events {
>>   	       ppmu_leftbus_3: ppmu-event3-leftbus {
>>   		       event-name = "ppmu-event3-leftbus";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>> @@ -42,6 +50,8 @@
>>          events {
>>   	       ppmu_rightbus_3: ppmu-event3-rightbus {
>>   		       event-name = "ppmu-event3-rightbus";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you, added to the patch.

Regards,
Lukasz
> 
> 
