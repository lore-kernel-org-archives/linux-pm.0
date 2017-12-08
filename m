From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v4 09/12] clk: qcom: Add Krait clock controller driver
Date: Fri, 8 Dec 2017 14:10:34 +0100
Message-ID: <CAOFm3uErpOH9Sug8q9QQaWqjTT2_ZS99p35oFmiadLP2iiHtsA@mail.gmail.com>
References: <1512725401-4944-1-git-send-email-sricharan@codeaurora.org>
 <1512725401-4944-10-git-send-email-sricharan@codeaurora.org>
 <CAOFm3uHdFn_GxJuQ-HfQpGAM5rWOT7=DyKUGtDz6dadoxdkBcw@mail.gmail.com> <797300f7-d655-8df3-8597-099e44bd209c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35681 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbdLHNLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 08:11:16 -0500
Received: by mail-wm0-f43.google.com with SMTP id f9so3169631wmh.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Dec 2017 05:11:15 -0800 (PST)
In-Reply-To: <797300f7-d655-8df3-8597-099e44bd209c@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, mturquette@linaro.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, viresh.kumar@linaro.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

Sricharan,

On Fri, Dec 8, 2017 at 12:00 PM, Sricharan R <sricharan@codeaurora.org> wrote:
> Hi Philippe,
>
>
> On 12/8/2017 3:53 PM, Philippe Ombredanne wrote:
>> Sricharan, Stephen,
>>
>> On Fri, Dec 8, 2017 at 10:29 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>>> From: Stephen Boyd <sboyd@codeaurora.org>
>>>
>>> The Krait CPU clocks are made up of a primary mux and secondary
>>> mux for each CPU and the L2, controlled via cp15 accessors. For
>>> Kraits within KPSSv1 each secondary mux accepts a different aux
>>> source, but on KPSSv2 each secondary mux accepts the same aux
>>> source.
>>>
>>> Cc: <devicetree@vger.kernel.org>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> []
>>> --- /dev/null
>>> +++ b/drivers/clk/qcom/krait-cc.c
>>> @@ -0,0 +1,350 @@
>>> +/* Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>
>> Have you considered using the new SPDX ids? Something like this:
>>
>> // SPDX-License-Identifier: GPL-2.0
>> // Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>>
>> Beside  being simpler and increasing the code to comment ratio by
>> deleting 9 lines of boilerplate, this will also save a few trees over
>> the long term each time that I print the source code of the kernel ;)
>> (do not worry, I am NOT as insane as to really print the kernel
>> sources, but someone more insane than me may well do it)
>>
>> You may wonder about the C++ // comment style I used here... Please
>> see Linus posts on the topic as well as Thomas doc patches overall for
>> instructions on using the SPDX ids.
>>
>> And if you were to do this for your past, present and future
>> contributions (eventually these of your group), I would be quite
>> grateful.
>>
>> Thank you for your kind consideration
>>
>
> Ha ok. will change it to use this one. Infact saw this feedback on other
> patches, but missed updating to it while sending.

Thanks!
-- 
Cordially
Philippe Ombredanne
