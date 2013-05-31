From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC PATCHv2 1/2] drivers: power: Add watchdog timer to catch
 drivers which lockup during suspend/resume.
Date: Fri, 31 May 2013 14:13:30 -0700
Message-ID: <CAME+o4kn=xBToxV2xfC5L0b5wVbQ27EA8+tDt9jT44BvBPeSTA@mail.gmail.com>
References: <1368221329-1841-1-git-send-email-zoran.markovic@linaro.org>
	<3006354.hOxNuWCXu4@vostro.rjw.lan>
	<CAME+o4kJYD2K_aL4xNi-jNP1Q8R+seDNZDwsGBhvU00ArR0Skg@mail.gmail.com>
	<1515063.BZy7p4GtyV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47472 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000Ab3EaVNc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2013 17:13:32 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so3883389obb.22
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2013 14:13:30 -0700 (PDT)
In-Reply-To: <1515063.BZy7p4GtyV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Colin Cross <ccross@android.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Benoit Goby <benoit@android.com>, Android Kernel Team <kernel-team@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

>> We could do cancel_work_sync() as a recovery, but that call blocks until the
>> running async task is flushed, which might never happen. So doing a panic()
>> is pretty much the only option for recovering.
>
> Well, its usefulness is quite limited, then.  That said I'm still not convinced
> that this actually is the case.

It does block in my environment, AFAICS. Looking a bit further in the
code, it looks like dpm_suspend() does an async_synchronize_full()
which would wait for all async tasks to complete. This is a
show-stopper because (under the circumstances) the assumption that
every async suspend routine eventually completes doesn't hold.

We could possibly select which async tasks to wait for, but this would
add unnecessary complexity to a feature targeted for debugging. It
seems that this approach - although sounding reasonable - needs to
wait until we have a mechanism to cancel an async task.

Regards, Zoran
