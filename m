From: Caesar Wang <sasukewxt@163.com>
Subject: Re: [PATCH v4 0/5] thermal: fixes the rockchip thermal
Date: Tue, 3 Jan 2017 09:02:22 +0800
Message-ID: <c2b13d66-e89e-02c8-3a68-6eb57627aaf2@163.com>
References: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
 <f68125d7-01bb-d0d9-d04f-8d1b5cff19a2@soulik.info>
 <8bdcea3e-0f06-da29-cb17-6b258440900a@rock-chips.com>
 <8e34e000-c1c7-20c9-2168-a31c85b3fa9a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:59408 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdACBGR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Jan 2017 20:06:17 -0500
In-Reply-To: <8e34e000-c1c7-20c9-2168-a31c85b3fa9a@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Randy Li <randy.li@rock-chips.com>, ayaka <ayaka@soulik.info>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com


在 2017年01月03日 07:57, Randy Li 写道:
>
> On 01/02/2017 09:16 PM, Caesar Wang wrote:
>> 在 2016年12月31日 00:11, ayaka 写道:
>>>
>>> BTW, Caesar have you ever met this at RK3288 at booting time?
>>> [    8.430582] thermal thermal_zone1: critical temperature 
>>> reached(125 C),shutting down
>>> [    8.439038] thermal thermal_zone2: critical temperature 
>>> reached(125 C),shutting down
>>> [    8.456344] thermal thermal_zone1: critical temperature 
>>> reached(125 C),shutting down
>>> [    8.465298] thermal thermal_zone2: critical temperature 
>>> reached(125 C),shutting down
>>
>> 125C? the thermal zone isn't the upstream kernel, what's the kernel 
>> version?
> They have been merged into the linux-next.

Really?
I saw the 90 degree is the critical temperature on rk3288 dts .
kernel$ vi arch/arm/boot/dts/rk3288.dtsi
             cpu_crit: cpu_crit {
                     temperature = <90000>; /* millicelsius */
                     hysteresis = <2000>; /* millicelsius */
                     type = "critical";
                 };

>> Anyway, look like,  the TSHUT issue. Do you have the below patches 
>> for your linux kernel?
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380446.html 
>>
> No, could you resubmit those patches ?

These patches had merged for upstream.

-Caesar

