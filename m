From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 battery charger
Date: Wed, 29 Apr 2015 18:49:11 +0900
Message-ID: <CAJKOXPf83AXwsDEv57tA+45L2Cayzqx6FBmq=GtXR=zwgcUB3Q@mail.gmail.com>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
	<CAJKOXPeyNE3q0-rmUHsmD7eb7u=ZStfQtGgmUw19hdB1iU701w@mail.gmail.com>
	<11982715D62E664DBACA4351A418B0581437DA51@IRSMSX107.ger.corp.intel.com>
	<CAJKOXPcyv+9c_8uxAwAGO_hP3V2GJmyd3+fQGRi61JQc-B4oDg@mail.gmail.com>
	<11982715D62E664DBACA4351A418B0581437DA7C@IRSMSX107.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11982715D62E664DBACA4351A418B0581437DA7C@IRSMSX107.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>
Cc: "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2015-04-27 23:02 GMT+09:00 Nicolae, Anda-maria <anda-maria.nicolae@intel.com>:
> However after looking at the code I got different question. You are
> reading here and in few other places the RT9455_REG_IRQ1. Isn't the
> register auto-cleared?
>
> No, RT9455_REG_IRQ1 is not cleared after reading. Let me give you an example. Suppose the battery is missing, so BATAB bit is set. This bit remains set until the battery is reconnected to the charger, independent of the number of i2c_reads over RT9455_REG_IRQ1. Unfortunately, no interrupt is triggered when the battery is reconnected (and BATAB bit is cleared).

OK, I got it.

>
> (...)
>
>>> +
>>> +#if IS_ENABLED(CONFIG_USB_PHY)
>>> +       info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
>>> +       if (IS_ERR_OR_NULL(info->usb_phy)) {
>>> +               dev_err(dev, "Failed to get USB transceiver\n");
>>> +       } else {
>>> +               info->nb.notifier_call = rt9455_usb_event;
>>> +               ret = usb_register_notifier(info->usb_phy, &info->nb);
>>> +               if (ret) {
>>> +                       dev_err(dev, "Failed to register USB notifier\n");
>>> +                       usb_put_phy(info->usb_phy);
>>> +               }
>>> +       }
>>> +#endif
>>> +
>>> +       INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
>>> +       INIT_DELAYED_WORK(&info->max_charging_time_work,
>>> +                         rt9455_max_charging_time_work_callback);
>>> +       INIT_DELAYED_WORK(&info->batt_presence_work,
>>> +                         rt9455_batt_presence_work_callback);
>>
>> Maybe any of these could be made as DEFERRABLE_WORK? Just thinking out loud...
>>
>> I cannot use DEFERRABLE_WORK instead of DELAYED_WORK. DEFERRABLE_WORK runs in interrupt context, while DELAYED_WORK runs in process context. All handlers for DELAYED_WORK from the driver perform read/write operations via I2C, which may sleep. This is the reason why DELAYED_WORK is used.
>
> AFAIK, the context is the same. The only difference is the type of
> timer used for scheduling the work. In case of deferrable timer it
> won't wake up a sleeping CPU. Which means that it may be executed some
> unspecified time in the future. This has energy conserving benefits
> but may not be appropriate for your case because you could want to
> poll the battery status in exact intervals.
>
> Just to understand correctly, you mean that if I use DEFERRABLE_WORK, I will not get kernel panic with message "scheduling while atomic"? This is what happens if I use timers and I thought that I would get the same result with DEFERRABLE_WORK. Actually, the timers are not critical and status of the charger may be checked some fraction of a second later.

You shouldn't get that panic. Deferrable work is used in few other
similar places. As you can check in the include/linux/workqueue.h file
the timers are used in both cases. The INIT_DELAYED_WORK already uses
a flag for timers - TIMER_IRQSAFE. However for deferrable work it uses
additional flag - deferrable timer.

Unfortunately the difference may not be a "fraction of a second
later". Actually the difference may be as much as 1 second later for
the fully non-tickless system. If system is truly idle, the deferrable
timers (and work) may not fire for long time. So this must be
considered.

Best regards,
Krzysztof
