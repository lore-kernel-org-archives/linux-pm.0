From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 5/5] arm: dts: exynos4: opp-suspend in DMC and
 leftbus
Date: Mon, 3 Dec 2018 18:48:52 +0100
Message-ID: <fed94fcf-74f4-a6e4-1405-12fb67ed5c9f@partner.samsung.com>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1@eucas1p1.samsung.com>
        <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
        <20181203172251.GA15124@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203172251.GA15124@kozik-lap>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 12/3/18 6:22 PM, Krzysztof Kozlowski wrote:
> On Mon, Dec 03, 2018 at 03:31:15PM +0100, Lukasz Luba wrote:
>> Mark the state for devfreq device while entring suspend/resume process.
>>
>> The patch is based on earlier work by Tobias Jakobi.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>>   arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>>   2 files changed, 4 insertions(+)
> 
> Thanks, applied with some minor commit msg changes. In general, please
> take care about title prefix (git log --oneline
> arch/arm/boot/dts/exynos*) and always explain why you are doing this.
Thank you that you have applied and for the hint.

> You just mentioned "what" but that is pretty obvious by looking at
> commit contents. The commit msg should answer why these should be marked
> as opp-suspend and why these values were chosen.
> 
> The cover letter just briefly describes "issue with devfreq devices' frequency
> during suspend/resume"... but what issue?
In the cover letter there is sentence:
'The suspending device has now chance to set proper
state when the system is going for suspend. This phase is the right place
to set needed frequences for the next resume process.'
Generally speaking, there is a need of setting the right
frequency/voltage, because we need that frequency during resume,
i.e. for booting CPUs (which are poked earlier during resume than the 
buses in this design).

Regards,
Lukasz


> 
> Best regards,
> Krzysztof
> 
>>
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
>> index b6091c2..4429b72 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -298,6 +298,7 @@
>>   			opp-400000000 {
>>   				opp-hz = /bits/ 64 <400000000>;
>>   				opp-microvolt = <1150000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   
>> @@ -367,6 +368,7 @@
>>   			};
>>   			opp-200000000 {
>>   				opp-hz = /bits/ 64 <200000000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   	};
>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> index 51f72f0..908c0c4 100644
>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> @@ -432,6 +432,7 @@
>>   			opp-400000000 {
>>   				opp-hz = /bits/ 64 <400000000>;
>>   				opp-microvolt = <1050000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   
>> @@ -520,6 +521,7 @@
>>   			opp-200000000 {
>>   				opp-hz = /bits/ 64 <200000000>;
>>   				opp-microvolt = <1000000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   
>> -- 
>> 2.7.4
>>
> 
> 
