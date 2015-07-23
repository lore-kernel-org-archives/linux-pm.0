From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] PM / devfreq: exynos-ppmu: Update documentation to
 support PPMUv2
Date: Thu, 23 Jul 2015 16:48:38 +0900
Message-ID: <55B09C56.30701@samsung.com>
References: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
 <1437616639-7448-3-git-send-email-cw00.choi@samsung.com>
 <55B0999E.6070708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <55B0999E.6070708@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, dan.carpenter@oracle.com, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/23/2015 04:37 PM, Krzysztof Kozlowski wrote:
> On 23.07.2015 10:57, Chanwoo Choi wrote:
>> This patch updates the documentation to include the information of PPMUv2.
>> The PPMUv2 is used for Exynos5433 and Exynos7420 to monitor the performance
>> of each IP in Exynos SoC.
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../bindings/devfreq/event/exynos-ppmu.txt         | 42 ++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> index b54bf3a2ff57..e8fa6b6a1827 100644
>> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -11,7 +11,7 @@ to various devfreq devices. The devfreq devices would use the event data when
>>  derterming the current state of each IP.
>>  
>>  Required properties:
>> -- compatible: Should be "samsung,exynos-ppmu".
>> +- compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
> 
> I have doubts about "-v2" suffix. Why not using SoCs compatible suffix?
> Is it related to ARM Performance Monitoring Unit v2 or maybe Samsung
> just labelled it v2 for marketing purposes?

As I knew, the version of PPMU was decided by SoC designer without any dependency.

If we prefer to use the SoC name instead of '-v2' version on compatible name,
we can change them as following:
- samsung,exynos-ppmu -> samsung,exynos4210-ppmu
  (because Exynos4210 used the PPMU v1 for the first time)
- samsung,exynos-ppmu-v2 -> samsung,exynos5433-ppmu
  (because Exynos5433 used the PPMU v2 for the first time)

Best Regards,
Chanwoo Choi

> 
> Best regards,
> Krzysztof
> 
>>  - reg: physical base address of each PPMU and length of memory mapped region.
>>  
>>  Optional properties:
>> @@ -19,7 +19,7 @@ Optional properties:
>>  - clocks : phandles for clock specified in "clock-names" property
>>  - #clock-cells: should be 1.
>>  
>> -Example1 : PPMU nodes in exynos3250.dtsi are listed below.
>> +Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
>>  
>>  		ppmu_dmc0: ppmu_dmc0@106a0000 {
>>  			compatible = "samsung,exynos-ppmu";
>> @@ -108,3 +108,41 @@ Example2 : Events of each PPMU node in exynos3250-rinato.dts are listed below.
>>  			};
>>  		};
>>  	};
>> +
>> +Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>> +
>> +		ppmu_d0_cpu: ppmu_d0_cpu@10480000 {
>> +			compatible = "samsung,exynos-ppmu-v2";
>> +			reg = <0x10480000 0x2000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ppmu_d0_general: ppmu_d0_general@10490000 {
>> +			compatible = "samsung,exynos-ppmu-v2";
>> +			reg = <0x10490000 0x2000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ppmu_d0_rt: ppmu_d0_rt@104a0000 {
>> +			compatible = "samsung,exynos-ppmu-v2";
>> +			reg = <0x104a0000 0x2000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ppmu_d1_cpu: ppmu_d1_cpu@104b0000 {
>> +			compatible = "samsung,exynos-ppmu-v2";
>> +			reg = <0x104b0000 0x2000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ppmu_d1_general: ppmu_d1_general@104c0000 {
>> +			compatible = "samsung,exynos-ppmu-v2";
>> +			reg = <0x104c0000 0x2000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ppmu_d1_rt: ppmu_d1_rt@104d0000 {
>> +			compatible = "samsung,exynos-ppmu-v2";
>> +			reg = <0x104d0000 0x2000>;
>> +			status = "disabled";
>> +		};
>>
> 
> 
