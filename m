From: loody <miloody@gmail.com>
Subject: Re: how to know how long it takes on suspend/resume for platform usb driver
Date: Fri, 21 Feb 2014 00:49:21 +0800
Message-ID: <CANudz+ujM_fhOCEKGhMVV3CWg5_zTJM+n5OVTm+7fHcVV8jK9g@mail.gmail.com>
References: <CANudz+sEiQHqkKfcQM_2gKckkNSuv_H6YCfKmaoThQ1xJB=2FQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1402201052030.888-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:61985 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbaBTQtW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 11:49:22 -0500
Received: by mail-we0-f172.google.com with SMTP id u56so1703702wes.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 08:49:21 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1402201052030.888-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>

hi alan:

2014-02-20 23:53 GMT+08:00 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 20 Feb 2014, loody wrote:
>
>> hi all:
>>
>> 2014-01-06 23:10 GMT+08:00 Alan Stern <stern@rowland.harvard.edu>:
>> > On Mon, 6 Jan 2014, loody wrote:
>> >
>> >> >> 2. is it possible to change the order of calling resume callback?
>> >> >>     for example, suppose the original sequence is "ehci -> xhci -> tty
>> >> >> ..." and I want to change as "tty-> ehci -> xhci".
>> >> >
>> >> > It is possible only to a very limited extent.  You can turn async
>> >> > suspend/resume on or off, and this will affect the order.  Of course,
>> >> > when async suspend/resume is off, the total time required will be
>> >> > longer than when it is on.
>> >> >
>> >> > Why do you want to change the order?  It shouldn't make any difference.
>> >> Because I want the GUI and input part of driver resume as earlier as possible.
>> >> Such that user can keep on their previous work more quicker.
>> >
>> > I doubt it will make any noticeable difference.  Remember, userspace
>> > remains frozen until _all_ the devices have been resumed.  Until that
>> > happens, the user can't do anything.
>>
>> after tracing the kernel src, I found the usb resume call back is
>> called in drivers/base/power/main.c -> dpm_resume.
>>
>> is that the only way usb resume functions could be called?
>
> Yes.
I found all usb devices will be register as dev->power.async_suspend
=1 in usb_new_device.

if all usb devices' resume will be finished in
drivers/base/power/main.c -> dpm_resume, what is the difference to
register these devices as async_suspend =1?
Doesn't async_schedule in dpm_resume will let those async_suspend =1
devices resume after calling dpm_resume?

Appreciate your kind help,
