From: vichy <vichy.kuo@gmail.com>
Subject: Re: Auto suspend not working on usb hid devices
Date: Fri, 16 Jan 2015 19:21:48 +0800
Message-ID: <CAOVJa8E28LTMMUa7tjNSitYb33VZNiWH9Nob=Zt_J81fmV8TUw@mail.gmail.com>
References: <CAOVJa8GkYnT3MV-jgLhoagUL1N3GhTGooho=pbVr7LcUUWXwvQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1501131029040.1520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57716 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbAPLVt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 06:21:49 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so18437076obb.12
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2015 03:21:48 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1501131029040.1520-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org

hi alan:

2015-01-13 23:37 GMT+08:00 Alan Stern <stern@rowland.harvard.edu>:
> On Tue, 13 Jan 2015, vichy wrote:
>
>> I purposely dump runtime_usage after calling
>> pm_runtime_put_async_autosuspend(), but the value is still 2.
>> I found the value increase/decrease like below:
>
> In usb_new_device():
>> pm_runtime_get_noresume => 1
>> usb_disable_autosuspend => 2
>> usb_probe_device
>>     -> usb_autoresume_device => 3
>
> That's where you go wrong.  usb_probe_device() does this:
>
>         if (!udriver->supports_autosuspend)
>                 error = usb_autoresume_device(udev);
>
> and udriver->supports_autosuspend should be 1.  See the definition of
> usb_generic_driver at the end of generic.c.
>
>> usb_set_configuration
>>     ->usb_autoresume_device =>4
>> usb_set_configuration
>>     ->usb_autosuspend_device =>3
>> pm_runtime_put_sync_autosuspend => 2
>>
>> so even after calling pm_runtime_put_async_autosuspend() at end fo
>> usb_new_device()
>> the runtime_usage will not be back to 1
>
> It would be 1 if udriver in usb_probe_device() was equal to
> usb_generic_driver.
>
>> is there any rule for us to determine where we add those
>> usb_autoresume_device/usb_autosuspend_device in usb driver?
>
> The rule is very simple: You autoresume in places where you need the
> device to be active, and you autosuspend when you don't need the device
> to be active any more.
>
I found the usb storage interface driver also set supports_autosuspend
=1 and I found the runtime_usage =1 .
But the device doesn't go into runtime suspend, even I put control as auto.
is there any condition purposely abandon usb storage device to do so?
sincerely thanks for your help,
