From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Tue, 5 Apr 2016 17:41:44 +0800
Message-ID: <CAMz4kuKxAnYz=KA46B8arKA2jOaAw6WMEc4+5D+kv+W55Ef6=Q@mail.gmail.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
	<6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
	<20160405075612.GB31351@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160405075612.GB31351-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 5 April 2016 at 15:56, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
>> +
>> +int devm_usb_charger_register(struct device *dev,
>> +                           struct usb_charger *uchger)
>> +{
>> +     struct usb_charger **ptr;
>> +     int ret;
>> +
>> +     ptr = devres_alloc(devm_uchger_dev_unreg, sizeof(*ptr), GFP_KERNEL);
>> +     if (!ptr)
>> +             return -ENOMEM;
>> +
>> +     ret = usb_charger_register(dev, uchger);
>> +     if (ret) {
>> +             devres_free(ptr);
>> +             return ret;
>> +     }
>> +
>> +     *ptr = uchger;
>> +     devres_add(dev, ptr);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_usb_charger_register);
>
> When the above API is expected to call? Can we use the USB charger
> without USB gadget?

I think this is open for user to do their specific initialization for
usb charger. That depends on how to initialize your usb charger
structure.

>
>> +
>> +int usb_charger_init(struct usb_gadget *ugadget)
>> +{
>> +     struct usb_charger *uchger;
>> +     struct extcon_dev *edev;
>> +     struct power_supply *psy;
>> +     int ret;
>> +
>> +     uchger = kzalloc(sizeof(struct usb_charger), GFP_KERNEL);
>> +     if (!uchger)
>> +             return -ENOMEM;
>> +
>> +     uchger->type = UNKNOWN_TYPE;
>> +     uchger->state = USB_CHARGER_DEFAULT;
>> +     uchger->id = -1;
>> +
>> +     if (ugadget->speed >= USB_SPEED_SUPER)
>> +             uchger->cur_limit.sdp_cur_limit = DEFAULT_SDP_CUR_LIMIT_SS;
>> +     else
>> +             uchger->cur_limit.sdp_cur_limit = DEFAULT_SDP_CUR_LIMIT;
>
> We still haven't known bus speed here, it is better do it after
> setting configuration has finished.

OK. Make sense.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
