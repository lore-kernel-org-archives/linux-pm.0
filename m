From: Randy Li <randy.li@rock-chips.com>
Subject: Re: [PATCH v4 0/5] thermal: fixes the rockchip thermal
Date: Tue, 3 Jan 2017 09:13:59 +0800
Message-ID: <9ee3d263-8de3-eb95-034d-774ae216329f@rock-chips.com>
References: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
 <f68125d7-01bb-d0d9-d04f-8d1b5cff19a2@soulik.info>
 <8bdcea3e-0f06-da29-cb17-6b258440900a@rock-chips.com>
 <8e34e000-c1c7-20c9-2168-a31c85b3fa9a@rock-chips.com>
 <c2b13d66-e89e-02c8-3a68-6eb57627aaf2@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:54817 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756034AbdACBOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2017 20:14:09 -0500
In-Reply-To: <c2b13d66-e89e-02c8-3a68-6eb57627aaf2@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <sasukewxt@163.com>
Cc: ayaka <ayaka@soulik.info>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com



On 01/03/2017 09:02 AM, Caesar Wang wrote:
>
> 在 2017年01月03日 07:57, Randy Li 写道:
>>
>> On 01/02/2017 09:16 PM, Caesar Wang wrote:
>>> 在 2016年12月31日 00:11, ayaka 写道:
>>>>
>>>> BTW, Caesar have you ever met this at RK3288 at booting time?
>>>> [    8.430582] thermal thermal_zone1: critical temperature
>>>> reached(125 C),shutting down
>>>> [    8.439038] thermal thermal_zone2: critical temperature
>>>> reached(125 C),shutting down
>>>> [    8.456344] thermal thermal_zone1: critical temperature
>>>> reached(125 C),shutting down
>>>> [    8.465298] thermal thermal_zone2: critical temperature
>>>> reached(125 C),shutting down
>>>
>>> 125C? the thermal zone isn't the upstream kernel, what's the kernel
>>> version?
>> They have been merged into the linux-next.
>
> Really?
> I saw the 90 degree is the critical temperature on rk3288 dts .
Yes I do.
> kernel$ vi arch/arm/boot/dts/rk3288.dtsi
>             cpu_crit: cpu_crit {
>                     temperature = <90000>; /* millicelsius */
>                     hysteresis = <2000>; /* millicelsius */
>                     type = "critical";
>                 };
>
>>> Anyway, look like,  the TSHUT issue. Do you have the below patches
>>> for your linux kernel?
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380446.html
>>>
>> No, could you resubmit those patches ?
>
> These patches had merged for upstream.
Sorry, it is my fault, I mistake that commit. Those patches are merged 
in next-20161224. I would bring a board for you later.
>
> -Caesar
>
>

-- 
Randy Li
The third produce department
===========================================================================
This email message, including any attachments, is for the sole
use of the intended recipient(s) and may contain confidential and
privileged information. Any unauthorized review, use, disclosure or
distribution is prohibited. If you are not the intended recipient, please
contact the sender by reply e-mail and destroy all copies of the original
message. [Fuzhou Rockchip Electronics, INC. China mainland]
===========================================================================

