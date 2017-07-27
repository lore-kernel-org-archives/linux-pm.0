From: "rocky.hao" <rocky.hao@rock-chips.com>
Subject: Re: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RK3328 SoC
 compatible
Date: Thu, 27 Jul 2017 14:49:37 +0800
Message-ID: <4c4a3974-e841-3d98-9850-131711c40c61@rock-chips.com>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
 <1500973788-14627-2-git-send-email-rocky.hao@rock-chips.com>
 <4621265.xPXIvBV6Fl@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4621265.xPXIvBV6Fl@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Hi Heiko,
Thank you for the quick reply. I will remove the gerrit Change-Ids in my 
v2 patches.

Thanks again,
Rocky

ÔÚ 2017/7/27 14:36, Heiko St¨¹bner Ð´µÀ:
> Hi Rocky,
> 
> Am Dienstag, 25. Juli 2017, 17:09:44 CEST schrieb Rocky Hao:
>> attempt to new compatible for thermal founding on RK3328 SoC.
>>
>> Change-Id: Ie6f6d7b4e545891a0035851a923c0412f584140c
>> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> 
> generally looks good but you should not have gerrit Change-Ids in patches
> for mainline. This is true for all patches in this series.
> 
> 
> Heiko
> 
>> ---
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt index
>> 43003aec94bd..e3a6234fb1ac 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>   - compatible : should be "rockchip,<name>-tsadc"
>>      "rockchip,rk3228-tsadc": found on RK3228 SoCs
>>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>> +   "rockchip,rk3328-tsadc": found on RK3328 SoCs
>>      "rockchip,rk3368-tsadc": found on RK3368 SoCs
>>      "rockchip,rk3399-tsadc": found on RK3399 SoCs
>>   - reg : physical base address of the controller and length of memory mapped
> 
> 
> 
> 
> 
