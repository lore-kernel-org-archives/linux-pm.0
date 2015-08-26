From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH] modify pl011 driver to work as wakeup source
Date: Wed, 26 Aug 2015 19:16:35 +0530
Message-ID: <CAP245DWVg2y4dNuvTJkpfWnbTRN45zDhaQQ2eYjpT8uL+9T4UQ@mail.gmail.com>
References: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>
	<55CDC9D4.3020709@linaro.org>
	<CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33116 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbHZNqg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 09:46:36 -0400
Received: by iods203 with SMTP id s203so18945140iod.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2015 06:46:35 -0700 (PDT)
In-Reply-To: <CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Aug 26, 2015 at 6:32 PM, Zhaoyang Huang
<zhaoyang.huang@linaro.org> wrote:
> The following functions don't work on pl011 for setting it as wakeup irq.
> device_init_wakeup(dev, true); dev_pm_set_wake_irq(dev, irq);

Can you elaborate how it doesn't work?

>
> On 14 August 2015 at 18:58, Daniel Lezcano <daniel.lezcano@linaro.org>
> wrote:
>>
>> On 08/14/2015 12:24 PM, Zhaoyang Huang wrote:
>>>
>>> add IRQF_NO_SUSPEND flag when requiring irq line and call
>>> the pm_system_wakeup when RX interrupt happens
>>>
>>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
>>
>>
>> Did you look at the 'dev_pm_set_wake_irq' function ?
>>
