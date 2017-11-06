From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT][PATCH v2 1/2] PM / domains: Rework governor code to be more consistent
Date: Mon, 6 Nov 2017 13:44:37 +0100
Message-ID: <CAPDyKFpCZov7nJVijToJ7k_YJb_CKAeScpRC5KhrZ8qdiDFSVg@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
 <1780873.Ca3tjQj9XB@aspire.rjw.lan> <CAPDyKFox_5XN1bV1rG_DJvADnpQLqBQcJFDamkEvpRXRMP7mag@mail.gmail.com>
 <CAJZ5v0jmeqxZyws_hS8T8pZdHK2p3kzzAA4-jaJw9+v9gv1DRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:52111 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbdKFMoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 07:44:39 -0500
Received: by mail-it0-f52.google.com with SMTP id o135so4899734itb.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Nov 2017 04:44:39 -0800 (PST)
In-Reply-To: <CAJZ5v0jmeqxZyws_hS8T8pZdHK2p3kzzAA4-jaJw9+v9gv1DRQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

[...]

>>>  static int dev_update_qos_constraint(struct device *dev, void *data)
>>>  {
>>>         s64 *constraint_ns_p = data;
>>> -       s32 constraint_ns = -1;
>>> -
>>> -       if (dev->power.subsys_data && dev->power.subsys_data->domain_data)
>>> -               constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
>>> +       s64 constraint_ns;
>>>
>>> -       if (constraint_ns < 0) {
>>> -               constraint_ns = dev_pm_qos_read_value(dev);
>>> -               constraint_ns *= NSEC_PER_USEC;
>>> -       }
>>> -       if (constraint_ns == 0)
>>> +       if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data)
>>>                 return 0;
>>>
>>>         /*
>>> -        * constraint_ns cannot be negative here, because the device has been
>>> -        * suspended.
>>> +        * Only take suspend-time QoS constraints of devices into account,
>>> +        * because constraints updated after the device has been suspended are
>>> +        * not guaranteed to be taken into account anyway.  In order for them
>>> +        * to take effect, the device has to be resumed and suspended again.
>>>          */
>>
>> This means a change in behavior, because earlier we took into account
>> QoS values for child devices that were not attached to a genpd.
>
> OK
>
> I have overlooked it or rather have forgotten about that.
>
>> Is there any reason you think we should change this, or is it just
>> something you overlooked here?
>>
>> I understand, that if the QoS constraint has been updated after such
>> child device has been suspended, it's tricky to take a correct
>> decision.
>
> Right, but if they are not in a domain, the best we can do is to look
> at the current value.
>
>> To really solve this, we would either have to register a QoS notifier
>> for all children devices that has its parent attached to a genpd, or
>> always runtime resume devices before updating QoS constraints.
>>
>> Non of these options is perfect, so perhaps we should consider a "best
>> effort" approach instead? Whatever that may be.
>
> I think best effort makes most sense.

Okay!

>
> So I guess I'll simply evaluate dev_pm_qos_read_value(dev) if
> subsys_data or subsys_data->domain_data is not there.

Yes.

However, if it returns -1, what value should you pick? 0?

>
> Of course, that doesn't apply to the code in __default_power_down_ok()
> as that only takes device in the domain into account anyway.

Yep, agree!

Kind regards
Uffe
