From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [RFC 4/4] ARM: dts: exynos4x12: add suspend OPP for DMC and
 leftbus
Date: Thu, 24 Nov 2016 15:27:18 +0100
Message-ID: <5836F8C6.4080708@math.uni-bielefeld.de>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <CGME20161123135415epcas4p235d175ffdbbba89e261482b1e7f0e358@epcas4p2.samsung.com>
 <1479909087-22659-5-git-send-email-tjakobi@math.uni-bielefeld.de>
 <58364560.4030904@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <58364560.4030904@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com
List-Id: linux-pm@vger.kernel.org

Hello Chanwoo,

since exynos-bus is not only used for the Exynos4 platform, could you
maybe check if we need to apply this elsewhere?

I see in the exynos5422-odroidxu3-common.dtsi that bus_wcore adjusts the
INT voltage. But MyungJoo mentioned that on newer platform the BL0 might
be "smarter", so we don't need this.

With best wishes,
Tobias


Chanwoo Choi wrote:
> Hi Tobias,
> 
> Looks good to me.
> Because the bus_dmc (MIF) and bus_leftbus (INT) are parent devfreq device.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Best Regards,
> Chanwoo Choi
> 
> On 2016년 11월 23일 22:51, Tobias Jakobi wrote:
>> TODO: write desc
>> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> ---
>>  arch/arm/boot/dts/exynos4x12.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
>> index d5cb433..a00a8b0 100644
>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>> @@ -375,6 +375,7 @@
>>  		opp@400000000 {
>>  			opp-hz = /bits/ 64 <400000000>;
>>  			opp-microvolt = <1050000>;
>> +			opp-suspend;
>>  		};
>>  	};
>>  
>> @@ -463,6 +464,7 @@
>>  		opp@200000000 {
>>  			opp-hz = /bits/ 64 <200000000>;
>>  			opp-microvolt = <1000000>;
>> +			opp-suspend;
>>  		};
>>  	};
>>  
>>
> 
