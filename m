From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH 6/6] USB / PM: Allow USB devices to remain
 runtime-suspended when sleeping
Date: Fri, 3 Apr 2015 15:05:55 +0200
Message-ID: <CAAObsKB4O8K3MCXfYgkA55A9VT-ugX7jvtNS+0BaqsiDOivzGw@mail.gmail.com>
References: <1427818501-10201-7-git-send-email-tomeu.vizoso@collabora.com> <Pine.LNX.4.44L0.1503311259340.1453-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34982 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbbDCNGS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 09:06:18 -0400
In-Reply-To: <Pine.LNX.4.44L0.1503311259340.1453-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scot Doyle <lkml14@scotdoyle.com>, Dan Williams <dan.j.williams@intel.com>, Julius Werner <jwerner@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Pratyush Anand <pratyush.anand@st.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

On 31 March 2015 at 19:09, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 31 Mar 2015, Tomeu Vizoso wrote:
>
>> Have dev_pm_ops.prepare return 1 for USB devices, interfaces, endpoints
>> and ports so that USB devices can remain runtime-suspended when the
>> system goes to a sleep state.
>>
>> Also enable runtime PM for endpoints, which is another requirement for
>> the above to work.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> ...
>
>> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
>> index b1fb9ae..1498faa 100644
>> --- a/drivers/usb/core/usb.c
>> +++ b/drivers/usb/core/usb.c
>> @@ -300,7 +300,7 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
>>
>>  static int usb_dev_prepare(struct device *dev)
>>  {
>> -     return 0;               /* Implement eventually? */
>> +     return 1;               /* Implement eventually? */
>>  }
>
> The rest of the patch is okay, but this part is wrong.  The documented
> requirement is that the prepare callback should return 1 if the device
> is already in the appropriate state.  This means it has to have the
> right wakeup setting.
>
> In other words, if the device is currently in runtime suspend with
> remote wakeup enabled, but device_may_wakeup() returns 0 (so that the
> device should be disabled for wakeup when the system goes into
> suspend), then the prepare callback has to return 0.
>
> Therefore what you need to do here is something like this:
>
>         struct usb_device       *udev = to_usb_device(dev);
>
>         /* Return 0 if the current wakeup setting is wrong, otherwise 1 */
>         if (udev->do_remote_wakeup && !device_may_wakeup(dev))
>                 return 0;
>         return 1;

Thanks, in v2 I have also covered the other case, as suggested by Oliver.

> Aside from this issue, I like the patch set.  Do you think you can do
> something similar for drivers/scsi/scsi_pm.c?  I'm not aware of any
> wakeup-capable SCSI devices -- not disk or CD/DVD drives, anyway.

I think I will be able to allocate some time on monday to look at this.

Thanks,

Tomeu

> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
