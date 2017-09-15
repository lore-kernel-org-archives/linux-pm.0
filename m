From: "rocky.hao" <rocky.hao@rock-chips.com>
Subject: Re: [PATCH 3/5] arm: dts: rockchip: add tsadc node for RV1108 SoC
Date: Fri, 15 Sep 2017 11:52:37 +0800
Message-ID: <8ae300de-b1a0-c399-fcd1-cdbaf408ab1b@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
 <89384e20-94d8-c698-135e-f48924c20493@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:47773 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdIODxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2017 23:53:03 -0400
In-Reply-To: <89384e20-94d8-c698-135e-f48924c20493@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, cl@rock-chips.com, william.wu@rock-chips.com, jay.xu@rock-chips.com, xxx@rock-chips.com, linux-arm-kernel@lists.infradead.org

Hi Caesar,

Thanks for the reply.

在 2017/9/15 10:25, Caesar Wang 写道:
> Rocky,
> 
> 在 2017年08月24日 18:27, Rocky Hao 写道:
>> Add tsadc needed main information for RV1108 SoC.
>> 750000Hz is the max clock rate supported by tsadc module.
>>
>> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rv1108.dtsi | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rv1108.dtsi 
>> b/arch/arm/boot/dts/rv1108.dtsi
>> index 25fab0b80f53..dbdd8c2180e7 100644
>> --- a/arch/arm/boot/dts/rv1108.dtsi
>> +++ b/arch/arm/boot/dts/rv1108.dtsi
>> @@ -275,6 +275,25 @@
>>           status = "disabled";
>>       };
>> +    tsadc: tsadc@10370000 {
>> +        compatible = "rockchip,rv1108-tsadc";
>> +        reg = <0x10370000 0x100>;
>> +        interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>> +        assigned-clocks = <&cru SCLK_TSADC>;
>> +        assigned-clock-rates = <750000>;
>> +        clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +        clock-names = "tsadc", "apb_pclk";
>> +        pinctrl-names = "init", "default", "sleep";
>> +        pinctrl-0 = <&otp_gpio>;
>> +        pinctrl-1 = <&otp_out>;
>> +        pinctrl-2 = <&otp_gpio>;
>> +        resets = <&cru SRST_TSADC>;
>> +        reset-names = "tsadc-apb";
>> +        rockchip,hw-tshut-temp = <120000>;
> 
>  From the Patch[4/5], you set the critial temperature is 95 degree. I 
> will suggest the Tshut temperature is 100 degree.
Setting rockchip,hw-tshut-temp = <120000>; is not a problem.
Maybe we should change the critial temperature (soc_crit: soc-crit) to 
115 degree. I will explain more in another thread Patch[4/5] arm: dts: 
rockchip: add thermal nodes for RV1108 SoC @ 
https://patchwork.kernel.org/patch/9919757/
> Think about the the peripherial devices,  the 120 degree will damage 
> some chips.
> 
>> +        #thermal-sensor-cells = <1>;
>> +        status = "disabled";
>> +    };
>> +
>>       adc: adc@1038c000 {
>>           compatible = "rockchip,rv1108-saradc", 
>> "rockchip,rk3399-saradc";
>>           reg = <0x1038c000 0x100>;
>> @@ -642,6 +661,16 @@
>>               };
>>           };
>> +        tsadc {
>> +            otp_out: otp-out {
>> +                rockchip,pins = <0 RK_PB7 RK_FUNC_1 &pcfg_pull_none>;
>> +            };
>> +
>> +            otp_gpio: otp-gpio {
>> +                rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
>> +            };
>> +        };
>> +
>>           uart0 {
>>               uart0_xfer: uart0-xfer {
>>                   rockchip,pins = <3 RK_PA6 RK_FUNC_1 &pcfg_pull_up>,
> 
> 
> 
> 
