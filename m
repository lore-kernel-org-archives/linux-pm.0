From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
Date: Thu, 2 May 2019 12:11:28 +0200
Message-ID: <869966ae-6349-a1db-59cf-eba7c0c23aee@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
        <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
        <52204c4b-80fa-1a87-2e00-1cfb774478f6@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52204c4b-80fa-1a87-2e00-1cfb774478f6@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/30/19 8:16 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
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
>> +all possible type, i.e. count read requests, count write data in bytes,
>> +etc. This field is optional and when it is missing, the driver code will
>> +use default data type.
>>
> 
> How about editing it as following?
> 
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -10,14 +10,23 @@ The Exynos PPMU driver uses the devfreq-event class to provide event data
>   to various devfreq devices. The devfreq devices would use the event data when
>   derterming the current state of each IP.
>   
> -Required properties:
> +Required properties for PPMU device:
>   - compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
>   - reg: physical base address of each PPMU and length of memory mapped region.
>   
> -Optional properties:
> +Optional properties for PPMU device:
>   - clock-names : the name of clock used by the PPMU, "ppmu"
>   - clocks : phandles for clock specified in "clock-names" property
>   
> +Required properties for 'events' child node of PPMU device:
> +- event-name : the unique event name among PPMU device
> +Optional properties for 'events' child node of PPMU device:
> +- event-data-type : Define the type of data which shell be counted
> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> +all possible type, i.e. count read requests, count write data in bytes,
> +etc. This field is optional and when it is missing, the driver code
> +will use default data type.
> +
>   Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
>   
>                  ppmu_dmc0: ppmu_dmc0@106a0000 {
> @@ -145,3 +154,16 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>                          reg = <0x104d0000 0x2000>;
>                          status = "disabled";
>                  };
> +
> +Example4 : 'event-data-type' in exynos4412-ppmu-common.dtsi are listed below.
> +
> +       &ppmu_dmc0 {
> +               status = "okay";
> +               events {
> +                       ppmu_dmc0_3: ppmu-event3-dmc0 {
> +                               event-name = "ppmu-event3-dmc0";
> +                               event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                       };
> +               };
> +       };
> 
> 
I will also add your Signed-off-by to this patch, similar to what we
have agreed for patch 'PATCH v3 2/4'.

Regards,
Lukasz
