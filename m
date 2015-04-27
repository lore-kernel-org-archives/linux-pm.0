From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 battery charger
Date: Mon, 27 Apr 2015 22:37:32 +0900
Message-ID: <CAJKOXPcyv+9c_8uxAwAGO_hP3V2GJmyd3+fQGRi61JQc-B4oDg@mail.gmail.com>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
	<CAJKOXPeyNE3q0-rmUHsmD7eb7u=ZStfQtGgmUw19hdB1iU701w@mail.gmail.com>
	<11982715D62E664DBACA4351A418B0581437DA51@IRSMSX107.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11982715D62E664DBACA4351A418B0581437DA51-kPTMFJFq+rFwl47ZQwxUxrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nicolae, Anda-maria" <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

2015-04-27 22:06 GMT+09:00 Nicolae, Anda-maria <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:

(...)

>> +
>> +static void rt9455_batt_presence_work_callback(struct work_struct *work)
>> +{
>> +       struct rt9455_info *info = container_of(work, struct rt9455_info,
>> +                                               batt_presence_work.work);
>> +       struct device *dev = &info->client->dev;
>> +       u8 irq1;
>> +       int ret;
>> +
>> +       ret = rt9455_read(info, RT9455_REG_IRQ1, &irq1);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to read IRQ1 register\n");
>> +               return;
>> +       }
>> +
>> +       /* If the battery is still absent, batt_presence_work is rescheduled.
>> +          Otherwise, max_charging_time is scheduled.
>> +        */
>> +       if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
>> +               schedule_delayed_work(&info->batt_presence_work,
>> +                                     RT9455_BATT_PRESENCE_DELAY * HZ);
>> +       } else {
>> +               schedule_delayed_work(&info->max_charging_time_work,
>> +                                     RT9455_MAX_CHARGING_TIME * HZ);
>> +       }
>
> Do all of these schedules have  to be executed on system_wq? Maybe
> power efficient workqueue could be used? I don't see any locking so
> probably not... but still it is worth investigating.
>
> Ok, I will use  queue_delayed_work(system_power_efficient_wq, ...). I'm not sure if I understand exactly what do you mean by "I don't see any locking so probably not". I can see that __queue_work() uses spinlocks. And other drivers that use system_power_efficient_wq also do not use additional locking.
> I intend to replace schedule_delayed_work() with queue_delayed_work(system_power_efficient_wq, ...), without adding any locking in the driver. Please let me know if I understood correctly what you meant .

You understood me correctly. I was thinking about possibility of
concurrent execution of work callbacks... but actually this should not
be impacted by unbound or bound workqueues. So never mind.

However after looking at the code I got different question. You are
reading here and in few other places the RT9455_REG_IRQ1. Isn't the
register auto-cleared?

(...)

>> +
>> +#if IS_ENABLED(CONFIG_USB_PHY)
>> +       info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
>> +       if (IS_ERR_OR_NULL(info->usb_phy)) {
>> +               dev_err(dev, "Failed to get USB transceiver\n");
>> +       } else {
>> +               info->nb.notifier_call = rt9455_usb_event;
>> +               ret = usb_register_notifier(info->usb_phy, &info->nb);
>> +               if (ret) {
>> +                       dev_err(dev, "Failed to register USB notifier\n");
>> +                       usb_put_phy(info->usb_phy);
>> +               }
>> +       }
>> +#endif
>> +
>> +       INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
>> +       INIT_DELAYED_WORK(&info->max_charging_time_work,
>> +                         rt9455_max_charging_time_work_callback);
>> +       INIT_DELAYED_WORK(&info->batt_presence_work,
>> +                         rt9455_batt_presence_work_callback);
>
> Maybe any of these could be made as DEFERRABLE_WORK? Just thinking out loud...
>
> I cannot use DEFERRABLE_WORK instead of DELAYED_WORK. DEFERRABLE_WORK runs in interrupt context, while DELAYED_WORK runs in process context. All handlers for DELAYED_WORK from the driver perform read/write operations via I2C, which may sleep. This is the reason why DELAYED_WORK is used.

AFAIK, the context is the same. The only difference is the type of
timer used for scheduling the work. In case of deferrable timer it
won't wake up a sleeping CPU. Which means that it may be executed some
unspecified time in the future. This has energy conserving benefits
but may not be appropriate for your case because you could want to
poll the battery status in exact intervals.

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
