From: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>
Subject: RE: [PATCH] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Mon, 27 Apr 2015 14:02:17 +0000
Message-ID: <11982715D62E664DBACA4351A418B0581437DA7C@IRSMSX107.ger.corp.intel.com>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
	<CAJKOXPeyNE3q0-rmUHsmD7eb7u=ZStfQtGgmUw19hdB1iU701w@mail.gmail.com>
	<11982715D62E664DBACA4351A418B0581437DA51@IRSMSX107.ger.corp.intel.com>,<CAJKOXPcyv+9c_8uxAwAGO_hP3V2GJmyd3+fQGRi61JQc-B4oDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16855 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692AbbD0OCp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 10:02:45 -0400
In-Reply-To: <CAJKOXPcyv+9c_8uxAwAGO_hP3V2GJmyd3+fQGRi61JQc-B4oDg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-2?Q?Krzysztof_Koz=B3owski?= <k.kozlowski.k@gmail.com>
Cc: "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello Krzysztof,

Thank you for your prompt answer :).
More comments inline.

Thanks,
Anda

________________________________________
=46rom: Krzysztof Koz=B3owski [k.kozlowski.k@gmail.com]
Sent: Monday, April 27, 2015 4:37 PM
To: Nicolae, Anda-maria
Cc: sre@kernel.org; dbaryshkov@gmail.com; robh+dt@kernel.org; pawel.mol=
l@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@c=
odeaurora.org; dwmw2@infradead.org; linux-pm@vger.kernel.org; linux-ker=
nel@vger.kernel.org; devicetree@vger.kernel.org
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 batte=
ry charger

2015-04-27 22:06 GMT+09:00 Nicolae, Anda-maria <anda-maria.nicolae@inte=
l.com>:

(...)

>> +
>> +static void rt9455_batt_presence_work_callback(struct work_struct *=
work)
>> +{
>> +       struct rt9455_info *info =3D container_of(work, struct rt945=
5_info,
>> +                                               batt_presence_work.w=
ork);
>> +       struct device *dev =3D &info->client->dev;
>> +       u8 irq1;
>> +       int ret;
>> +
>> +       ret =3D rt9455_read(info, RT9455_REG_IRQ1, &irq1);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to read IRQ1 register\n");
>> +               return;
>> +       }
>> +
>> +       /* If the battery is still absent, batt_presence_work is res=
cheduled.
>> +          Otherwise, max_charging_time is scheduled.
>> +        */
>> +       if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
>> +               schedule_delayed_work(&info->batt_presence_work,
>> +                                     RT9455_BATT_PRESENCE_DELAY * H=
Z);
>> +       } else {
>> +               schedule_delayed_work(&info->max_charging_time_work,
>> +                                     RT9455_MAX_CHARGING_TIME * HZ)=
;
>> +       }
>
> Do all of these schedules have  to be executed on system_wq? Maybe
> power efficient workqueue could be used? I don't see any locking so
> probably not... but still it is worth investigating.
>
> Ok, I will use  queue_delayed_work(system_power_efficient_wq, ...). I=
'm not sure if I understand exactly what do you mean by "I don't see an=
y locking so probably not". I can see that __queue_work() uses spinlock=
s. And other drivers that use system_power_efficient_wq also do not use=
 additional locking.
> I intend to replace schedule_delayed_work() with queue_delayed_work(s=
ystem_power_efficient_wq, ...), without adding any locking in the drive=
r. Please let me know if I understood correctly what you meant .

You understood me correctly. I was thinking about possibility of
concurrent execution of work callbacks... but actually this should not
be impacted by unbound or bound workqueues. So never mind.

So, I will stick to replacing schedule_delayed_work() with queue_delaye=
d_work(system_power_efficient_wq, ...), without adding any locking in t=
he driver.

However after looking at the code I got different question. You are
reading here and in few other places the RT9455_REG_IRQ1. Isn't the
register auto-cleared?

No, RT9455_REG_IRQ1 is not cleared after reading. Let me give you an ex=
ample. Suppose the battery is missing, so BATAB bit is set. This bit re=
mains set until the battery is reconnected to the charger, independent =
of the number of i2c_reads over RT9455_REG_IRQ1. Unfortunately, no inte=
rrupt is triggered when the battery is reconnected (and BATAB bit is cl=
eared).

(...)

>> +
>> +#if IS_ENABLED(CONFIG_USB_PHY)
>> +       info->usb_phy =3D usb_get_phy(USB_PHY_TYPE_USB2);
>> +       if (IS_ERR_OR_NULL(info->usb_phy)) {
>> +               dev_err(dev, "Failed to get USB transceiver\n");
>> +       } else {
>> +               info->nb.notifier_call =3D rt9455_usb_event;
>> +               ret =3D usb_register_notifier(info->usb_phy, &info->=
nb);
>> +               if (ret) {
>> +                       dev_err(dev, "Failed to register USB notifie=
r\n");
>> +                       usb_put_phy(info->usb_phy);
>> +               }
>> +       }
>> +#endif
>> +
>> +       INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_c=
allback);
>> +       INIT_DELAYED_WORK(&info->max_charging_time_work,
>> +                         rt9455_max_charging_time_work_callback);
>> +       INIT_DELAYED_WORK(&info->batt_presence_work,
>> +                         rt9455_batt_presence_work_callback);
>
> Maybe any of these could be made as DEFERRABLE_WORK? Just thinking ou=
t loud...
>
> I cannot use DEFERRABLE_WORK instead of DELAYED_WORK. DEFERRABLE_WORK=
 runs in interrupt context, while DELAYED_WORK runs in process context.=
 All handlers for DELAYED_WORK from the driver perform read/write opera=
tions via I2C, which may sleep. This is the reason why DELAYED_WORK is =
used.

AFAIK, the context is the same. The only difference is the type of
timer used for scheduling the work. In case of deferrable timer it
won't wake up a sleeping CPU. Which means that it may be executed some
unspecified time in the future. This has energy conserving benefits
but may not be appropriate for your case because you could want to
poll the battery status in exact intervals.

Just to understand correctly, you mean that if I use DEFERRABLE_WORK, I=
 will not get kernel panic with message "scheduling while atomic"? This=
 is what happens if I use timers and I thought that I would get the sam=
e result with DEFERRABLE_WORK. Actually, the timers are not critical an=
d status of the charger may be checked some fraction of a second later.

Best regards,
Krzysztof
