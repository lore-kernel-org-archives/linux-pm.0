From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 09/12] clk: qcom: Add Krait clock controller driver
Date: Fri, 8 Dec 2017 16:30:02 +0530
Message-ID: <797300f7-d655-8df3-8597-099e44bd209c@codeaurora.org>
References: <1512725401-4944-1-git-send-email-sricharan@codeaurora.org>
 <1512725401-4944-10-git-send-email-sricharan@codeaurora.org>
 <CAOFm3uHdFn_GxJuQ-HfQpGAM5rWOT7=DyKUGtDz6dadoxdkBcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOFm3uHdFn_GxJuQ-HfQpGAM5rWOT7=DyKUGtDz6dadoxdkBcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Philippe,


On 12/8/2017 3:53 PM, Philippe Ombredanne wrote:
> Sricharan, Stephen,
> 
> On Fri, Dec 8, 2017 at 10:29 AM, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> The Krait CPU clocks are made up of a primary mux and secondary
>> mux for each CPU and the L2, controlled via cp15 accessors. For
>> Kraits within KPSSv1 each secondary mux accepts a different aux
>> source, but on KPSSv2 each secondary mux accepts the same aux
>> source.
>>
>> Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Signed-off-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> []
>> --- /dev/null
>> +++ b/drivers/clk/qcom/krait-cc.c
>> @@ -0,0 +1,350 @@
>> +/* Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
> 
> Have you considered using the new SPDX ids? Something like this:
> 
> // SPDX-License-Identifier: GPL-2.0
> // Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> 
> Beside  being simpler and increasing the code to comment ratio by
> deleting 9 lines of boilerplate, this will also save a few trees over
> the long term each time that I print the source code of the kernel ;)
> (do not worry, I am NOT as insane as to really print the kernel
> sources, but someone more insane than me may well do it)
> 
> You may wonder about the C++ // comment style I used here... Please
> see Linus posts on the topic as well as Thomas doc patches overall for
> instructions on using the SPDX ids.
> 
> And if you were to do this for your past, present and future
> contributions (eventually these of your group), I would be quite
> grateful.
> 
> Thank you for your kind consideration
> 

Ha ok. will change it to use this one. Infact saw this feedback on other
patches, but missed updating to it while sending.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
