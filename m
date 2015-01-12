From: vichy <vichy.kuo@gmail.com>
Subject: Re: Auto suspend not working on usb hid devices
Date: Mon, 12 Jan 2015 20:45:23 +0800
Message-ID: <CAOVJa8H1JsarfphiWmTEw8MsJUxDcYi=c5GPJzvbvhziAiDcXA@mail.gmail.com>
References: <CAOVJa8Hu5j04UKAPiQwhBYOuxvUdjbz_BASzcuPxJX63kE+Q2A@mail.gmail.com>
	<Pine.LNX.4.44L0.1501111049520.31181-100000@netrider.rowland.org>
	<CAOVJa8HHwa-ZmwqgBozVuwWUZaBiVHb3-81sn3tOOp0_x5HNGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:51012 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbALMpY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 07:45:24 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so22014640obc.7
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2015 04:45:24 -0800 (PST)
In-Reply-To: <CAOVJa8HHwa-ZmwqgBozVuwWUZaBiVHb3-81sn3tOOp0_x5HNGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org

hi alan:
> I found the power/runtime_usage = 2 when device plug in and do nothing.
> Except update_autosuspend will increase runtime_usage, is there any
> function will increase it when we did not enable runtime
> suspend/resume?
We found the runtime_usage will be 2 after calling usb_new_device.
in usb_new_device,
        pm_runtime_set_active(&udev->dev);
        pm_runtime_get_noresume(&udev->dev);  // after calling left
function, runtime_usage =1
        pm_runtime_use_autosuspend(&udev->dev);
        pm_runtime_enable(&udev->dev);

       /* By default, forbid autosuspend for all devices.  It will be
        * allowed for hubs during binding.
        */
       usb_disable_autosuspend(udev); // after calling left function,
runtime_usage =2

Under what circumstance, the runtime_usage will be 1 to let "echo auto
> power/control" work?
appreciate your kind help,
