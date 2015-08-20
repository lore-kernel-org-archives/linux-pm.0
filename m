From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4 3/5] gadget: Support for the usb charger framework
Date: Thu, 20 Aug 2015 09:42:05 +0800
Message-ID: <CAMz4kuJVrav0-aU0CSg8KMEiwFwneZuB6vx53cYu9HDroGJiQg@mail.gmail.com>
References: <cover.1439974219.git.baolin.wang@linaro.org>
	<59a5ba963dc2aaf9b1f59b0e79387b4d9ce3f30a.1439974219.git.baolin.wang@linaro.org>
	<55D47D04.7060104@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33162 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbHTBmH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 21:42:07 -0400
Received: by ykll84 with SMTP id l84so23960139ykl.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 18:42:06 -0700 (PDT)
In-Reply-To: <55D47D04.7060104@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@freescale.com>, sojka@merica.cz, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

On 19 August 2015 at 20:56, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 8/19/2015 12:13 PM, Baolin Wang wrote:
>
>> For supporting the usb charger, it adds the usb_charger_init() and
>> usb_charger_exit() functions for usb charger initialization and exit.
>>
>> Introduce a callback 'get_charger_type' which will implemented by
>> user for usb gadget operations to get the usb charger type.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> [...]
>
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index 755e8bc..44d82f5 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -537,6 +537,7 @@ struct usb_gadget_ops {
>>         struct usb_ep *(*match_ep)(struct usb_gadget *,
>>                         struct usb_endpoint_descriptor *,
>>                         struct usb_ss_ep_comp_descriptor *);
>> +       enum usb_charger_type   (*get_charger_type)(struct usb_gadget *);
>
>                              ^^^ please use space, not tab here

OK.

>
>>   };
>>
>>   /**
>> @@ -611,6 +612,7 @@ struct usb_gadget {
>>         struct usb_otg_caps             *otg_caps;
>>         struct raw_notifier_head        nh;
>>         struct mutex                    lock;
>> +       struct usb_charger              *uchger;
>
>
>    Why not simply call the field 'charger'? :-)

I think 'uchger' is the abbreviation of 'usb charger' which is maybe a
little verbous, I'll change it. Thanks for your comments.

>
> [...]
>
> WBR, Sergei
>



-- 
Baolin.wang
Best Regards
