From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation fails from kexec'ed kernel
Date: Sat, 12 Jan 2013 21:06:28 +0100
Message-ID: <50F1C244.9000209@gmail.com>
References: <50F18577.3030506@gmail.com> <50F19CC3.9060104@gmail.com> <4354889.LUp82ppzIy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:52801 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab3ALUGd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jan 2013 15:06:33 -0500
Received: by mail-ea0-f177.google.com with SMTP id c10so1139983eaa.22
        for <linux-pm@vger.kernel.org>; Sat, 12 Jan 2013 12:06:31 -0800 (PST)
In-Reply-To: <4354889.LUp82ppzIy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On 01/12/2013 09:06 PM, Rafael J. Wysocki wrote:
> On Saturday, January 12, 2013 06:26:27 PM Jiri Slaby wrote:
>> On 01/12/2013 04:47 PM, Jiri Slaby wrote:
>>> Hi,
>>>
>>> when I try to hibernate and resume from a kexec'ed kernel, the resume
>>> fails with:
>>> PM: Image not found (code -22)
>>>
>>> I dumped sig and orig_sig from swsusp_check and it looks like this:
>>> 53 57 41 50 53 50 41 43 45 32                    SWAPSPACE2
>>> 53 57 41 50 53 50 41 43 45 32                    SWAPSPACE2
>>>
>>> So it looks like the image (or only the signature) did not land to the disk.
>>
>> Note that I see "PM: S|" and the error returned from mark_swapfiles is 0.
>>
>>> I use only the in-kernel hibernation, I do not even have the suspend
>>> package installed. This is with 3.7.2 and happens this way for some time
>>> already. When I boot the kernel normally, hib+resume works just fine.
>>>
>>> Any ideas?
> 
> Quite frankly, I'm not really surprised, because this is the first time I know
> of anybody has tested hibernate and resume from a kexec'ed kernel.

It's quite usual and natural, that people kexec to a new kernel, I
think. I used to do that for a long time, but it stopped workign at some
point.

> I have no idea why exactly it doesn't work, though.

I'm trying to debug that ATM...

> Did you use s2disk or the internal hibernation?

As I write above, I don't have suspend package installed. This is a pure
in-kernel implementation.

-- 
js
