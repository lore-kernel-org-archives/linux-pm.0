From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 4/5] PM / devfreq: rockchip: add devfreq driver for rk3399
 dmc
Date: Fri, 02 Sep 2016 10:46:09 +0900
Message-ID: <57C8D9E1.4070700@samsung.com>
References: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
 <1472769085-20715-5-git-send-email-hl@rock-chips.com>
 <CGME20160901231806epcas1p4c0184a2d47af524a99d162b3a5a5bf59@epcas1p4.samsung.com>
 <8339852.vAWNvCSMju@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49091 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcIBBqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 21:46:13 -0400
In-reply-to: <8339852.vAWNvCSMju@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Lin Huang <hl@rock-chips.com>
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Heiko,

On 2016년 09월 02일 08:17, Heiko Stübner wrote:
> Am Freitag, 2. September 2016, 06:31:24 schrieb Lin Huang:
>> base on dfi result, we do ddr frequency scaling, register
>> dmc driver to devfreq framework, and use simple-ondemand
>> policy.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> Signed-off-by: MyngJoo Ham <myngjoo.ham@samsung.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
> 
> [...]
> 
>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>> new file mode 100644
>> index 0000000..54d65f2
>> --- /dev/null
>> +++ b/drivers/devfreq/rk3399_dmc.c
>> @@ -0,0 +1,480 @@
>> +/*
>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd.
>> + * Author: Lin Huang <hl@rock-chips.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> for + * more details.
>> + */
>> +
>> +#include <linux/arm-smccc.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/devfreq-event.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/suspend.h>
>> +
>> +#include <soc/rockchip/rockchip_sip.h>
> 
> (Repeated from previous version)
> For the shared sip-interface header I've prepared a signed, stable tag
> which can be pulled from
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/rockchip-ddr-sip
> 
> for you to fetch changes up to 97dd82682f1a6174698fbea149a04b4cabc58c4f:
> 
>   soc: rockchip: add header for ddr rate SIP interface (2016-08-31 18:53:24 +0200)
> 
> ----------------------------------------------------------------
> Header file defining the SIP-interface to the ATF for DDR frequency changes
> 
> ----------------------------------------------------------------
> Lin Huang (1):
>       soc: rockchip: add header for ddr rate SIP interface
> 
>  include/soc/rockchip/rockchip_sip.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/soc/rockchip/rockchip_sip.h
> 
> 
> 

Thanks for creating the immutable branch.

-- 
Best Regards,
Chanwoo Choi
