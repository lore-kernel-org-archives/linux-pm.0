From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 14:28:04 +0800
Message-ID: <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
	<11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
	<87h9foqnur.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h9foqnur.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 March 2016 at 18:09, Felipe Balbi <balbi@kernel.org> wrote:
>> ---
>>  drivers/usb/gadget/Kconfig      |    7 +
>>  drivers/usb/gadget/Makefile     |    1 +
>>  drivers/usb/gadget/charger.c    |  669 +++++++++++++++++++++++++++++++++++++++
>
> It seems to me this should be part of udc-core's functionality. Maybe
> move this to drivers/usb/gadget/udc and statically link it to
> udc-core.ko ?

OK.

>
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index af5d922..82a5b3c 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -133,6 +133,13 @@ config U_SERIAL_CONSOLE
>>       help
>>          It supports the serial gadget can be used as a console.
>>
>> +config USB_CHARGER
>> +     bool "USB charger support"
>> +     help
>> +       The usb charger driver based on the usb gadget that makes an
>> +       enhancement to a power driver which can set the current limitation
>> +       when the usb charger is added or removed.
>
> sure you don't depend on anything ?

It just depends on USB_GADGET.

>
>> +
>> +#define DEFAULT_CUR_PROTECT  (50)
>
> Where is this coming from ? Also, () are not necessary.

Just want to protect the default current limitation. If that does not
need, I'll remove it.

>
>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
>
> According to the spec we should always be talking about unit loads (1
> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
> work for SS capable ports and SS gadgets (we have quite a few of them,
> actually). You're missing the opportunity of charging at 900mA.

I follow the DCP/SDP/CDP/ACA type's default current limitation and
user can set them what they want.

>
>> +#define DEFAULT_DCP_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>> +#define DEFAULT_CDP_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>> +#define DEFAULT_ACA_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>> +#define UCHGER_STATE_LENGTH  (50)
>
> what is this UCHGER_STATE_LENGTH ? And also, why don't you spell it out?
> Is this weird name coming from a spec ? Which spec ?

It is used to indicate the array size to save the charger state to
report to userspace. I should move it to where it is used.

>
>> +static DEFINE_IDA(usb_charger_ida);
>> +static struct bus_type usb_charger_subsys = {
>> +     .name           = "usb-charger",
>> +     .dev_name       = "usb-charger",
>> +};
>> +
>> +static struct usb_charger *dev_to_uchger(struct device *udev)
>
> nit-picking but I'd rather call this struct device *dev. Also, I'm not

OK.

> sure this fits as a bus_type. There's no "usb charger" bus. There's USB
> bus and its VBUS/GND lines. Why are you using a bus_type here ?

I want to use bus structure to manage the charger device. Maybe choose
class to manage them?

>
>> +{
>> +     return container_of(udev, struct usb_charger, dev);
>> +}
>> +
>> +static ssize_t sdp_limit_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +
>> +     return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
>> +}
>> +
>> +static ssize_t sdp_limit_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t count)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +     unsigned int sdp_limit;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 10, &sdp_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     ret = usb_charger_set_cur_limit_by_type(uchger, SDP_TYPE, sdp_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +static DEVICE_ATTR_RW(sdp_limit);
>
> why RW ? Who's going to use these ? Also, you're not documenting this
> new sysfs file.

Cause we have show and store operation for SDP type. If users want to
know or set the SDP current, they can use the sysfs file.
I'll add the documentation for it.

>
>> +static ssize_t dcp_limit_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +
>> +     return sprintf(buf, "%d\n", uchger->cur_limit.dcp_cur_limit);
>> +}
>> +
>> +static ssize_t dcp_limit_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t count)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +     unsigned int dcp_limit;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 10, &dcp_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     ret = usb_charger_set_cur_limit_by_type(uchger, DCP_TYPE, dcp_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +static DEVICE_ATTR_RW(dcp_limit);
>
> likewise, why RW ? Missing doc.

Same reason. I'll add the doc.

>
>> +static ssize_t cdp_limit_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +
>> +     return sprintf(buf, "%d\n", uchger->cur_limit.cdp_cur_limit);
>> +}
>> +
>> +static ssize_t cdp_limit_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t count)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +     unsigned int cdp_limit;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 10, &cdp_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     ret = usb_charger_set_cur_limit_by_type(uchger, CDP_TYPE, cdp_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +static DEVICE_ATTR_RW(cdp_limit);
>
> why RW? Where's doc ?

I'll add the doc in next version.

>
>> +static ssize_t aca_limit_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +
>> +     return sprintf(buf, "%d\n", uchger->cur_limit.aca_cur_limit);
>> +}
>> +
>> +static ssize_t aca_limit_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t count)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +     unsigned int aca_limit;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 10, &aca_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     ret = usb_charger_set_cur_limit_by_type(uchger, ACA_TYPE, aca_limit);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +static DEVICE_ATTR_RW(aca_limit);
>
> why RW ? where's doc ?

I'll add the doc in next version.

>
>> +static struct attribute *usb_charger_attrs[] = {
>
> const ?

OK.

>
>> +     &dev_attr_sdp_limit.attr,
>> +     &dev_attr_dcp_limit.attr,
>> +     &dev_attr_cdp_limit.attr,
>> +     &dev_attr_aca_limit.attr,
>> +     NULL
>> +};
>> +ATTRIBUTE_GROUPS(usb_charger);
>
> static ?

This macro will add 'static' automatically. So don't need to add.

>
>> +struct usb_charger *usb_charger_find_by_name(const char *name)
>> +{
>> +     struct device *udev;
>> +
>> +     if (!name)
>> +             return ERR_PTR(-EINVAL);
>
> quite frankly, this deserves, at a minimum, a big fat WARN():
>
>         if (WARN(!name, "can't work with NULL name"))
>                 return .....

OK.

>
>> +     udev = bus_find_device_by_name(&usb_charger_subsys, NULL, name);
>> +     if (!udev)
>> +             return ERR_PTR(-ENODEV);
>
> still not convinced this deserves to be a bus_type.

I'll re-consider about the bus type things.

>> +int usb_charger_unregister_notify(struct usb_charger *uchger,
>> +                               struct notifier_block *nb)
>> +{
>> +     int ret;
>> +
>> +     if (!uchger || !nb)
>
> WARN() ?

OK.


>> +static int usb_charger_unregister(struct usb_charger *uchger)
>> +{
>> +     if (!uchger)
>
> WARN()

OK.

>
>> +             return -EINVAL;
>> +
>> +     device_unregister(&uchger->dev);
>> +     return 0;
>> +}
>> +
>> +static void devm_uchger_dev_unreg(struct device *dev, void *res)
>> +{
>> +     usb_charger_unregister(*(struct usb_charger **)res);
>> +}
>> +
>> +void devm_usb_charger_unregister(struct device *dev,
>> +                              struct usb_charger *uchger)
>> +{
>> +     devres_release(dev, devm_uchger_dev_unreg,
>> +                    devm_uchger_dev_match, uchger);
>> +}
>
> does this need EXPORT_SYMBOL_GPL() too ?

OK. I'll add it.

>
>> +/*
>> + * usb_charger_register() - Register a new usb charger device
>> + * which is created by the usb charger framework.
>> + * @parent - the parent device of the new usb charger.
>> + * @uchger - the new usb charger device.
>> + */
>> +static int usb_charger_register(struct device *parent,
>> +                             struct usb_charger *uchger)
>> +{
>> +     int ret;
>> +
>> +     if (!uchger)
>
> WARN()

OK.

>
>> +int usb_charger_init(struct usb_gadget *ugadget)
>> +{
>> +     struct usb_charger *uchger;
>> +     struct extcon_dev *edev;
>> +     struct power_supply *psy;
>> +     int ret;
>> +
>> +     if (!ugadget)
>
> WARN()

OK.

>
> but I don't like this. This should be done from udc-core.c itself when
> the UDC registers itself.

Make sense.

>
>> +
>> +static int __init usb_charger_sysfs_init(void)
>> +{
>> +     return subsys_system_register(&usb_charger_subsys, NULL);
>> +}
>> +core_initcall(usb_charger_sysfs_init);
>
> please don't. This should be indication that there's something wrong
> with your patchset.

I'll modify the bus things.

>
>> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
>> +MODULE_DESCRIPTION("USB charger driver");
>> +MODULE_LICENSE("GPL");
>
> GPLv2 or GPLv2+ ??

OK.

>
>> diff --git a/include/linux/usb/usb_charger.h b/include/linux/usb/usb_charger.h
>> new file mode 100644
>> index 0000000..eed422f
>> --- /dev/null
>> +++ b/include/linux/usb/usb_charger.h
>
> usb_ is redundant. I'd prefer to:
>
> #include <linux/usb/charger.h>

Got it.

>
>> +
>> +/* USB charger state */
>> +enum usb_charger_state {
>> +     USB_CHARGER_DEFAULT,
>> +     USB_CHARGER_PRESENT,
>> +     USB_CHARGER_REMOVE,
>> +};
>
> userland really doesn't need these two ?

We've reported to userspace by kobject_uevent in
'usb_charger_notify_others()' function.

>
> --
> balbi



-- 
Baolin.wang
Best Regards
