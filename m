From: vichy <vichy.kuo@gmail.com>
Subject: Re: Auto suspend not working on usb hid devices
Date: Tue, 13 Jan 2015 17:35:41 +0800
Message-ID: <CAOVJa8GkYnT3MV-jgLhoagUL1N3GhTGooho=pbVr7LcUUWXwvQ@mail.gmail.com>
References: <CAOVJa8H1JsarfphiWmTEw8MsJUxDcYi=c5GPJzvbvhziAiDcXA@mail.gmail.com>
	<Pine.LNX.4.44L0.1501121011580.1707-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34966 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbAMJfm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 04:35:42 -0500
Received: by mail-oi0-f46.google.com with SMTP id a3so1511243oib.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2015 01:35:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1501121011580.1707-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org

hi alan:

2015-01-12 23:18 GMT+08:00 Alan Stern <stern@rowland.harvard.edu>:
> On Mon, 12 Jan 2015, vichy wrote:
>
>> hi alan:
>> > I found the power/runtime_usage = 2 when device plug in and do nothing.
>> > Except update_autosuspend will increase runtime_usage, is there any
>> > function will increase it when we did not enable runtime
>> > suspend/resume?
>> We found the runtime_usage will be 2 after calling usb_new_device.
>> in usb_new_device,
>>         pm_runtime_set_active(&udev->dev);
>>         pm_runtime_get_noresume(&udev->dev);  // after calling left
>> function, runtime_usage =1
>>         pm_runtime_use_autosuspend(&udev->dev);
>>         pm_runtime_enable(&udev->dev);
>>
>>        /* By default, forbid autosuspend for all devices.  It will be
>>         * allowed for hubs during binding.
>>         */
>>        usb_disable_autosuspend(udev); // after calling left function,
>> runtime_usage =2
>>
>> Under what circumstance, the runtime_usage will be 1 to let "echo auto
>> > power/control" work?
>
> You need to look farther down in usb_new_device().  Near the end it
> does this:
>
>         (void) usb_create_ep_devs(&udev->dev, &udev->ep0, udev);
>         usb_mark_last_busy(udev);
>         pm_runtime_put_sync_autosuspend(&udev->dev);
>         return err;
>
> The pm_runtime_put_async_autosuspend() call decrements runtime_usage
> back to 1.
I purposely dump runtime_usage after calling
pm_runtime_put_async_autosuspend(), but the value is still 2.
I found the value increase/decrease like below:
pm_runtime_get_noresume => 1
usb_disable_autosuspend => 2
usb_probe_device
    -> usb_autoresume_device => 3
usb_set_configuration
    ->usb_autoresume_device =>4
usb_set_configuration
    ->usb_autosuspend_device =>3
pm_runtime_put_sync_autosuspend => 2

so even after calling pm_runtime_put_async_autosuspend() at end fo
usb_new_device()
the runtime_usage will not be back to 1

Appreciate your kind help,
