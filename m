From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/5] thermal: imx: Add support for reading OCOTP
 through nvmem
Date: Tue, 8 Aug 2017 12:44:45 +0100
Message-ID: <9732c524-fbdc-d1be-cd03-089dbb2266c4@linaro.org>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <faf9c3e5f970b9609073c4c191a7af03d647ea51.1500041281.git.leonard.crestez@nxp.com>
 <20170725080835.GD20064@dragon> <1502176915.4296.1.camel@intel.com>
 <26407dd5-a9b1-67c0-c4ab-d97fa0b88b79@linaro.org>
 <1502192287.24350.9.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34886 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdHHLos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 07:44:48 -0400
Received: by mail-wm0-f49.google.com with SMTP id m85so4988006wma.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2017 04:44:48 -0700 (PDT)
In-Reply-To: <1502192287.24350.9.camel@nxp.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org



On 08/08/17 12:38, Leonard Crestez wrote:
> On Tue, 2017-08-08 at 12:00 +0100, Srinivas Kandagatla wrote:
>> On 08/08/17 08:21, Zhang Rui wrote:
>>> On Tue, 2017-07-25 at 16:08 +0800, Shawn Guo wrote:
>>>> On Fri, Jul 14, 2017 at 05:11:08PM +0300, Leonard Crestez wrote:
> 
>>>>> On newer imx SOCs accessing OCOTP directly is wrong because the
>>>>> ocotp clock
>>>>> needs to be enabled first. Add support for reading those same
>>>>> values through
>>>>> the nvmem API instead.
>>>>>
>>>>> The older path is preserved for compatibility with older dts and
>>>>> because it
>>>>> works correctly on imx6qdl chips.
>>>>>
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
>>> I'm okay with the thermal change.
>>> We still need ACK for the nvmem changes in this patch series.
> 
>> NVMEM changes are already sent to Greg K H with other patches
>> (https://lkml.org/lkml/2017/7/26/164), should appear in next.
> 
> These patches have a compile-time dependency on each other. Wouldn't it
> make more sense for the whole series to go through a single maintainer
> tree, atomically? Most of the changes are in driver/thermal.

I was expecting that the nvmem change go in as fix in a rc release so 
that you could apply the other patches after that.

Let me ping Greg about this!!
> 
> I'm really very confused about how series that touch multiple areas are
> applied. It seems to be a mostly ad-hoc process.
> 
> --
> Regards,
> Leonard
> 
