From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: API for querying the resume cause
Date: Fri, 21 Aug 2015 11:07:09 +0900
Message-ID: <CAJKOXPe+ud=uCRKbQiggg7tLeShgYJbD16W_26qYo4E4-4mXrw@mail.gmail.com>
References: <55D5BE6B.5070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35342 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbHUCHK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 22:07:10 -0400
Received: by qgj62 with SMTP id 62so39506071qgj.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2015 19:07:09 -0700 (PDT)
In-Reply-To: <55D5BE6B.5070805@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yan Pashkovsky <yanpaso@gmail.com>
Cc: linux-pm@vger.kernel.org, Alexandra Yates <alexandra.yates@linux.intel.com>, Bastien Nocera <hadess@hadess.net>

2015-08-20 20:47 GMT+09:00 Yan Pashkovsky <yanpaso@gmail.com>:
> Dear developers,
>
> My name is Yan and I was redirected here from kernel bugzilla
> (bugzilla.kernel.org/show_bug.cgi?id=102991). I would like to discuss
> API for supporting delayed hibernation.
>
> Original post:
>
>     Please add API for querying the resume cause
>     The purpose of this API - is support of delayed hibernation (feature
>     that works for a long time in Windows). A laptop first Suspend to
>     RAM, then after a time save state to disk and power off completely.
>     But system must know the reason of waking up (was it user or turning
>     into hibernation). RTC wakeup event isn't reliable.
>     SystemD needs such API, see more at
>     github.com/systemd/systemd/issues/926
>
>
> I was discussing it earlier with Lennart Poettering, he said he can't
> rely on rtc timer, he needs some API.
> Lennart(github.com/systemd/systemd/issues/926):
>
>     On Linux we have no API for querying the resume cause. Patching
>     around this sounds like a gigantic hack... Especially as RTC-based
>     wakeups are not really reliable on many systems... On such systems
>     where the RTC wakeup is missed and the user resumes the machine
>     manually later on the system will immediately go to hiberantion,
>     which is clearly not a good idea.
>
>     Sorry, but I am really not convinced this could be any more than a
>     gigantic hack.
>
>     Please before looking into something like this, let's at least get a
>     proper API into the kernel that reports the precise wakeup reason to
>     userspace. If we have that, then we can consider hooking this up
>     from userspace. Will close this for now, as I don't think we should
>     hack something up like this without proper kernel support for such a
>     logic.

A little bit similar work from Alexandra Yates (CC-ed):
Report interrupt(s) that caused system wakeup
http://comments.gmane.org/gmane.linux.power-management.general/63805

The need of such API was also mentioned some time ago by Bastien Nocera (CC-ed):
https://wiki.gnome.org/BastienNocera/KernelWishlist

It seems like a good topic for Kernel Summit... but it's too late I think.

>
> PS I use mailing list system for the first time. Am I to subscribe to it
> somewhere? Will feedback be delivered to my email address after sending
> this email, without any actions?

You sent it correctly. Mail reached the list.

Best regards,
Krzysztof
