From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][v3] mfd: intel-lpss: Avoid resuming runtime-suspended
 lpss unnecessarily
Date: Fri, 30 Sep 2016 02:31:03 +0200
Message-ID: <CAJZ5v0gcoUgiY5ZT0Zam_jyuji=6txqqU0CFQnc11pSo8nJ0Kg@mail.gmail.com>
References: <1475125286-12167-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0h97nq8_aokP9-aQ_bpVDJQ0UBfpAwOf3LJ5MGCdcaMGg@mail.gmail.com> <20160930002943.GC13971@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36118 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbcI3AbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 20:31:06 -0400
In-Reply-To: <20160930002943.GC13971@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Fri, Sep 30, 2016 at 2:29 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 30 Sep 2016, Rafael J. Wysocki wrote:
>
>> Hi Lee,
>>
>> On Thu, Sep 29, 2016 at 7:01 AM, Chen Yu <yu.c.chen@intel.com> wrote:
>> > We have report that the intel_lpss_prepare() takes too much time during
>> > suspend, and this is because we first resume the devices from runtime
>> > suspend by resume_lpss_device(), to make sure they are in proper state
>> > before system suspend, which takes 100ms for each LPSS devices(PCI power
>> > state from D3_cold to D0). And since resume_lpss_device() resumes the
>> > devices synchronously, we might get huge latency if we have many
>> > LPSS devices.
>> >
>> > So first try is to use pm_request_resume() instead, to make the runtime
>> > resume process asynchronously. Unfortunately the asynchronous runtime
>> > resume relies on pm_wq, which is freezed at early stage. So we choose
>> > another method, that is to avoid resuming runtime-suspended devices,
>> > if they are already runtime suspended. This is safe because for LPSS
>> > driver, the runtime suspend and system suspend are of the same
>> > hook - i.e., intel_lpss_suspend(). And moreover, this device is
>> > neither runtime wakeup source nor system wakeup source.
>> >
>> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Cc: Lee Jones <lee.jones@linaro.org>
>> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>
>> If this is fine with you and you'd like to apply it, please feel free
>> to add my ACK to it.
>>
>> Alternatively, if you'd prefer me to apply it, please let me know.
>
> You want this in for v3.9?

I'd rather queue it up for 4.10 (assuming that the above and below
major version numbers are simply off by one by mistake).

> I just started applying patches for v3.10.
>
> If you're certain there are 0% chance of regressions, I will still
> apply this for v3.9 with your Ack.

4.10 should be fine.

>> > ---
>> >  drivers/mfd/intel-lpss.c | 9 +++++++++
>> >  include/linux/pm.h       | 7 +++++++
>> >  2 files changed, 16 insertions(+)
>> >
>> > diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
>> > index 41b1138..2583db8 100644
>> > --- a/drivers/mfd/intel-lpss.c
>> > +++ b/drivers/mfd/intel-lpss.c
>> > @@ -485,6 +485,15 @@ static int resume_lpss_device(struct device *dev, void *data)
>> >  int intel_lpss_prepare(struct device *dev)
>> >  {
>> >         /*
>> > +        * This is safe because:
>> > +        * 1. The runtime suspend and system suspend
>> > +        * are of the same hook.
>> > +        * 2. This device is neither runtime wakeup source
>> > +        * nor system wakeup source.
>> > +        */
>> > +       if (pm_runtime_status_suspended(dev))
>> > +               return DPM_DIRECT_COMPLETE;
>> > +       /*
>> >          * Resume both child devices before entering system sleep. This
>> >          * ensures that they are in proper state before they get suspended.
>> >          */
>> > diff --git a/include/linux/pm.h b/include/linux/pm.h
>> > index 06eb353..4a788b4 100644
>> > --- a/include/linux/pm.h
>> > +++ b/include/linux/pm.h
>> > @@ -786,4 +786,11 @@ enum dpm_order {
>> >         DPM_ORDER_DEV_LAST,
>> >  };
>> >
>> > +/*
>> > + * Return this from system suspend/hibernation ->prepare() callback to
>> > + * request the core to leave the device runtime-suspended during system
>> > + * suspend if possible.
>> > + */
>> > +#define DPM_DIRECT_COMPLETE 1
>> > +
>> >  #endif /* _LINUX_PM_H */
>> > --

Thanks,
Rafael
