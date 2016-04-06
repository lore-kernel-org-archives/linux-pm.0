From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 6 Apr 2016 18:46:36 +0800
Message-ID: <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
	<13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org>
	<20160406071956.GA21101@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32888 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbcDFKqi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 06:46:38 -0400
Received: by mail-yw0-f177.google.com with SMTP id t10so50847304ywa.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 03:46:37 -0700 (PDT)
In-Reply-To: <20160406071956.GA21101@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 6 April 2016 at 15:19, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Fri, Apr 01, 2016 at 03:21:50PM +0800, Baolin Wang wrote:
>>
>> @@ -563,6 +564,8 @@ struct usb_gadget_ops {
>>       struct usb_ep *(*match_ep)(struct usb_gadget *,
>>                       struct usb_endpoint_descriptor *,
>>                       struct usb_ss_ep_comp_descriptor *);
>> +     /* get the charger type */
>> +     enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
>>  };
>
> Since we already have get_charger_type callback at usb_charger
> structure, why we still need this API at usb_gadget_ops?

In case some users want to get charger type at gadget level.

>
>>
>>  /**
>> @@ -635,6 +638,8 @@ struct usb_gadget {
>>       unsigned                        out_epnum;
>>       unsigned                        in_epnum;
>>       struct usb_otg_caps             *otg_caps;
>> +     /* negotiate the power with the usb charger */
>> +     struct usb_charger              *charger;
>>
>>       unsigned                        sg_supported:1;
>>       unsigned                        is_otg:1;
>> @@ -839,10 +844,20 @@ static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
>>   * reporting how much power the device may consume.  For example, this
>>   * could affect how quickly batteries are recharged.
>>   *
>> + * It will also notify the USB charger how much power the device may
>> + * consume if there is a USB charger linking with the gadget.
>> + *
>>   * Returns zero on success, else negative errno.
>>   */
>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
>>  {
>> +     enum usb_charger_type type;
>> +
>> +     if (gadget->charger) {
>> +             type = usb_charger_get_type(gadget->charger);
>> +             usb_charger_set_cur_limit_by_type(gadget->charger, type, mA);
>> +     }
>> +
>
> You may do something redundant.
>
> - Charger detection only occurs at connection period, at other periods,
> we only change the current limit, and notify charger IC. That is to
> say, we may only need to save charger type and current limit at
> usb_charger structure, we don't need to distinguish all chargers
> type from time to time.

That's right. I just want to get the charger type as one parameter to
set current. The function is implemented as below:

enum usb_charger_type usb_charger_get_type(struct usb_charger *uchger)
{
        enum usb_charger_type type;

        mutex_lock(&uchger->lock);
        type = uchger->type;
        mutex_unlock(&uchger->lock);

        return type;
}

>
> - The purpose of usb_gadget_vbus_draw design is notify charger IC too,
> so you can do set current limit and notify charger IC together at this
> API together, it has already covered all situations. We don't need to
> notify charger IC again when the gadget status has changed again.

It did not notify charger IC again. You are right,
usb_gadget_vbus_draw design will notify charger IC, so we want to
record the current in usb charger framework at the same time.

>
>>       if (!gadget->ops->vbus_draw)
>>               return -EOPNOTSUPP;
>>       return gadget->ops->vbus_draw(gadget, mA);
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
>
> Best Regards,
> Peter Chen



-- 
Baolin.wang
Best Regards
