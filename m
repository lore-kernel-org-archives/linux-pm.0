From: "rocky.hao" <rocky.hao@rock-chips.com>
Subject: Re: [PATCH v2 0/5] thermal: rockchip: add tsadc support in thermal
 driver and IPA thermal control for rk3328 in dts
Date: Fri, 11 Aug 2017 14:22:02 +0800
Message-ID: <f004afe1-f885-68f5-d769-30051f36d9f7@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
 <1502427095.2598.21.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:50445 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdHKGWV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 02:22:21 -0400
In-Reply-To: <1502427095.2598.21.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com

Hi Rui,

Thank you for the patch set acception.

Thanks again,
Rocky

在 2017/8/11 12:51, Zhang Rui 写道:
> On Fri, 2017-08-04 at 16:06 +0800, Rocky Hao wrote:
>> This series patches add the tsadc support in thermal driver and in
>> devicetree for rk3328.
>> Also add thermal control with Intelligent Power Allocation (IPA)
>> policy by default.  Please
>> refer to https://developer.arm.com/open-source/intelligent-power-allo
>> cation for more information
>> about IPA.
>>
>> Rocky Hao (5):
>>    dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
>>    thermal: rockchip: Support the RK3328 SOC in thermal driver
>>    arm64: dts: rockchip: add tsadc node for rk3328 SoC
>>    arm64: dts: rockchip: add thermal nodes for rk3328 SoC
>>    arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation
>> board
>>
> I can take this patch set if we have ACK for patch 3, 4 and 5.
> 
> thanks,
> rui
>>   .../bindings/thermal/rockchip-thermal.txt          |  1 +
>>   arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  4 ++
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 63
>> +++++++++++++++++++++
>>   drivers/thermal/rockchip_thermal.c                 | 65
>> ++++++++++++++++++++++
>>   4 files changed, 133 insertions(+)
>>
> 
> 
> 
