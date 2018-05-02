From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: devfreq: rk3399_dmc: remove
 interrupts as is not required.
Date: Wed, 2 May 2018 18:11:16 +0200
Message-ID: <66622ef7-6b8a-c524-1f6e-e71ccbc72011@collabora.com>
References: <20180424083742.14042-1-enric.balletbo@collabora.com>
 <20180424083742.14042-5-enric.balletbo@collabora.com>
 <20180427200029.elq3drn46nkwbvf2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427200029.elq3drn46nkwbvf2@rob-hp-laptop>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org, kernel@collabora.com, hl@rock-chips.com, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

Thanks for the review.

On 27/04/18 22:00, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 10:37:41AM +0200, Enric Balletbo i Serra wrote:
>> In ATF we already wait for DDR dvfs finish, so don't need to do this in
>> kernel, so remove the interrupts properties as is not longer required.
> 
> If the hardware has an interrupt, then the DT should have one. The 
> partitioning with ATF shouldn't matter.
> 
> Now, if you want to make ATF remove the interrupt, then maybe that is 
> okay. But it's not clear to me why you'd expose some of the h/w and not 
> all.
> 

Ok, sounds good if I move interrupts to be optional then?

Best regards,
 Enric

>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>
>> Changes in v2:
>> - [4/6] Add Reviewed-by Chanwoo Choi.
>>
>>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>> index 834637c7bae7..e7f0ef9548b7 100644
>> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>> @@ -5,10 +5,6 @@ Required properties:
>>  - devfreq-events:	 Node to get DDR loading, Refer to
>>  			 Documentation/devicetree/bindings/devfreq/event/
>>  			 rockchip-dfi.txt
>> -- interrupts:		 The CPU interrupt number. The interrupt specifier
>> -			 format depends on the interrupt controller.
>> -			 It should be a DCF interrupt. When DDR DVFS finishes
>> -			 a DCF interrupt is triggered.
>>  - clocks:		 Phandles for clock specified in "clock-names" property
>>  - clock-names :		 The name of clock used by the DFI, must be
>>  			 "pclk_ddr_mon";
>> @@ -172,7 +168,6 @@ Example:
>>  	dmc: dmc {
>>  		compatible = "rockchip,rk3399-dmc";
>>  		devfreq-events = <&dfi>;
>> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>>  		clocks = <&cru SCLK_DDRCLK>;
>>  		clock-names = "dmc_clk";
>>  		operating-points-v2 = <&dmc_opp_table>;
>> -- 
>> 2.17.0
>>
