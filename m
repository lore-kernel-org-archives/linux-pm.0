From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: default value of power/wakeup
Date: Fri, 24 Apr 2015 01:57:04 +0800
Message-ID: <CAGnHSEmqadDavg+sU46OD8ndqTe7O2ZhDog_ZuDy5oUNtaydsg@mail.gmail.com>
References: <CAGnHSEnPCL3PgA9-L5ECD=7WW3ykYrd-cDUXcT1dd-zE9WwXcw@mail.gmail.com>
	<Pine.LNX.4.44L0.1504231039180.1529-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36243 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966546AbbDWR5F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 13:57:05 -0400
In-Reply-To: <Pine.LNX.4.44L0.1504231039180.1529-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Chen <Peter.Chen@freescale.com>, Greg KH <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

I know. Honestly I never expect it to be fixed. I just want to draw
some attention so that people can be aware of this problem (some may
be suffering from this without understand what's going on). Though I
did  filed a bug report on bugzilla some time ago to request making
this function a no-op (sounds outrageous doesn't it). Hope that
something will be done for this one day anyway.

On 23 April 2015 at 22:40, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 23 Apr 2015, Tom Yan wrote:
>
>> I'm not saying that the kernel shouldn't initialize the attributes or
>> have a default. But it should only set the default when the attribute
>> is initialized (It doesn't even matter to me whether it's enabled or
>> disabled).
>>
>> It's just there should not be further manipulation from the kernel
>> (e.g. device_set_wakeup_enable) afterwards because
>> 1. it's brings inconsistency because the function is adopted per driver
>> 2. it's a user preference and responsibilty
>> 3. third it prevent udev to apply a rule properly (regression / bug)
>>
>> P.S. Alan for my case, I don't need a patch for logitech-dj, I just
>> need to remove device_set_enable_wakeup from hid_core.c, then I can
>> enable or disable the attribute with a udev rule happily for both
>> devices.
>
> I understand that.  But removing device_set_enable_wakeup from
> hid_core.c would annoy a lot of people.  Linus would probably decide
> that it was a regression and would put the function call back in.
>
> Alan Stern
>
