From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v14 1/4] usb: gadget: Introduce the usb charger framework
Date: Thu, 30 Jun 2016 19:01:06 +0800
Message-ID: <CAMz4kuKk6H1wdMEH4qNt+4-Q+KSq_ScYkZPMLfVCrPzK6Fprtw@mail.gmail.com>
References: <cover.1467264233.git.baolin.wang@linaro.org> <374f15d1aa524a1550ebf757d3e14adba5680c5d.1467264233.git.baolin.wang@linaro.org>
 <87y45nezov.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y45nezov.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Felipe,

On 30 June 2016 at 18:30, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>> +static ssize_t charger_state_show(struct device *dev,
>> +                               struct device_attribute *attr,
>> +                               char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +     int cnt;
>> +
>> +     switch (uchger->state) {
>> +     case USB_CHARGER_PRESENT:
>> +             cnt = sprintf(buf, "%s\n", "PRESENT");
>> +             break;
>> +     case USB_CHARGER_REMOVE:
>> +             cnt = sprintf(buf, "%s\n", "REMOVE");
>> +             break;
>> +     default:
>> +             cnt = sprintf(buf, "%s\n", "UNKNOWN");
>> +             break;
>
> are these the only states we need? Don't we need at least "CHARGING" and
> "ERROR" or something like that? Maybe those are exposed elsewhere,
> dunno.

Present state means we are charging. For charging error, I think it
can be exposed in power driver, which is more proper. Until now I only
see PRESENT and REMOVE state are useful.

>
>> +static int __usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
>> +                                            enum usb_charger_type type,
>> +                                            unsigned int cur_limit)
>> +{
>> +     if (WARN(!uchger, "charger can not be NULL"))
>> +             return -EINVAL;
>
> IIRC, I mentioned that this should assume charger to be a valid
> pointer. Look at this, for a second:
>
> You check that you have a valid pointer here...

Okay. I will remove this.

>
>> +int usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
>> +                                   enum usb_charger_type type,
>> +                                   unsigned int cur_limit)
>> +{
>> +     int ret;
>> +
>> +     if (WARN(!uchger, "charger can not be NULL"))
>> +             return -EINVAL;
>
> ... and here, before calling the other function. This is the only place
> which should check for valid uchger.

Okay.

>
>> +     mutex_lock(&uchger->lock);
>> +     ret = __usb_charger_set_cur_limit_by_type(uchger, type, cur_limit);
>> +     mutex_unlock(&uchger->lock);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_type);
>> +
>> +/*
>> + * usb_charger_set_cur_limit() - Set the current limitation.
>> + * @uchger - the usb charger instance.
>> + * @cur_limit_set - the current limitation.
>> + */
>> +int usb_charger_set_cur_limit(struct usb_charger *uchger,
>> +                           struct usb_charger_cur_limit *cur_limit_set)
>> +{
>> +     if (WARN(!uchger || !cur_limit_set, "charger or setting can't be NULL"))
>> +             return -EINVAL;
>
> I can see a pattern here. Not *all* errors need a splat. Sometimes a
> simple pr_err() or dev_err() (when you have a valid dev pointer) are
> enough.

Make sense.

>
>> diff --git a/include/linux/usb/charger.h b/include/linux/usb/charger.h
>> new file mode 100644
>> index 0000000..d2e745e
>> --- /dev/null
>> +++ b/include/linux/usb/charger.h
>> @@ -0,0 +1,164 @@
>> +#ifndef __LINUX_USB_CHARGER_H__
>> +#define __LINUX_USB_CHARGER_H__
>> +
>> +#include <uapi/linux/usb/ch9.h>
>> +#include <uapi/linux/usb/charger.h>
>> +
>> +#define CHARGER_NAME_MAX 30
>> +
>> +/* Current limitation by charger type */
>> +struct usb_charger_cur_limit {
>> +     unsigned int sdp_cur_limit;
>> +     unsigned int dcp_cur_limit;
>> +     unsigned int cdp_cur_limit;
>> +     unsigned int aca_cur_limit;
>> +};
>> +
>> +struct usb_charger_nb {
>> +     struct notifier_block   nb;
>> +     struct usb_charger      *uchger;
>> +};
>> +
>
> please add KernelDoc here. And mention the fields which aren't supposed
> to be accessed directly but should rely on the accessor functions. At
> least type and state prefer to be accessed by their respective
> getter/setter methods.

Will add kernel doc for struct usb_charger. Thanks for your comments.

>
>> +struct usb_charger {
>> +     char                    name[CHARGER_NAME_MAX];
>> +     struct list_head        list;
>> +     struct raw_notifier_head        uchger_nh;
>> +     /* protect the notifier head and charger */
>> +     struct mutex            lock;
>> +     int                     id;
>> +     enum usb_charger_type   type;
>> +     enum usb_charger_state  state;
>> +
>> +     /* for supporting extcon usb gpio */
>> +     struct extcon_dev       *extcon_dev;
>> +     struct usb_charger_nb   extcon_nb;
>> +
>> +     /* for supporting usb gadget */
>> +     struct usb_gadget       *gadget;
>> +     enum usb_device_state   old_gadget_state;
>> +
>> +     /* for supporting power supply */
>> +     struct power_supply     *psy;
>> +
>> +     /* user can get charger type by implementing this callback */
>> +     enum usb_charger_type   (*get_charger_type)(struct usb_charger *);
>> +     /*
>> +      * charger detection method can be implemented if you need to
>> +      * manually detect the charger type.
>> +      */
>> +     enum usb_charger_type   (*charger_detect)(struct usb_charger *);
>> +
>> +     /* current limitation */
>> +     struct usb_charger_cur_limit    cur_limit;
>> +     /* to check if it is needed to change the SDP charger default current */
>> +     unsigned int            sdp_default_cur_change;
>> +};
>
> --
> balbi



-- 
Baolin.wang
Best Regards
