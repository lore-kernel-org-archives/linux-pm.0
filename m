From: vichy <vichy.kuo@gmail.com>
Subject: Re: Auto suspend not working on usb hid devices
Date: Mon, 12 Jan 2015 18:45:21 +0800
Message-ID: <CAOVJa8HHwa-ZmwqgBozVuwWUZaBiVHb3-81sn3tOOp0_x5HNGw@mail.gmail.com>
References: <CAOVJa8Hu5j04UKAPiQwhBYOuxvUdjbz_BASzcuPxJX63kE+Q2A@mail.gmail.com>
	<Pine.LNX.4.44L0.1501111049520.31181-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:58531 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbALKpV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 05:45:21 -0500
Received: by mail-ob0-f172.google.com with SMTP id va8so21606374obc.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2015 02:45:21 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1501111049520.31181-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org

hi alan:

2015-01-11 23:53 GMT+08:00 Alan Stern <stern@rowland.harvard.edu>:
> On Sun, 11 Jan 2015, vichy wrote:
>
>> hi all:
>> I list below environment I have that autosuspend seems doesn't work on
>> my platform.
>> 1. kernel version 3.10.30
>> 2. compile kernel with CONFIG_PM_RUNTIME=y
>> 3. "echo 'rpm:rpm_suspend' > set_event"
>> 4. insert hid devices and "echo auto > /sys/bus/usb/devices/6-1/power/control"
>> 5. there is no any usb related runtime suspend output in trace.
>>
>> Did I miss any kernel configuration to let it work?
>> Or where is the proper debug entry I can check why rpm_suspend isn't
>> been called on my system?
>
> There are lots of reasons why a device might not be runtime suspended.
> There is no single debug entry that presents them.  Some information
> can be seen in the files in the device's /sys/.../power directory.

I found the power/runtime_usage = 2 when device plug in and do nothing.
Except update_autosuspend will increase runtime_usage, is there any
function will increase it when we did not enable runtime
suspend/resume?

Thanks for your kind help,
