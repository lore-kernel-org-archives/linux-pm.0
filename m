From: Todd Poynor <toddpoynor@google.com>
Subject: Re: Userspace program to wake system from suspend
Date: Sun, 29 Sep 2013 12:18:14 -0700
Message-ID: <CAAW3YpY6wi9q+SJNznjNJogJ-dWPzSQMcy38ha_Yqgo-E9UnNQ@mail.gmail.com>
References: <CAMefCkAsg8sDku-dU+kdYwLfaFbUC=z_4XQnjt3E1LZE21v5aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:47791 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3I2TSP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2013 15:18:15 -0400
Received: by mail-qa0-f41.google.com with SMTP id ii20so1756819qab.7
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2013 12:18:14 -0700 (PDT)
In-Reply-To: <CAMefCkAsg8sDku-dU+kdYwLfaFbUC=z_4XQnjt3E1LZE21v5aA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guru Prasad <gurupras@buffalo.edu>
Cc: linux-pm@vger.kernel.org

On Sun, Sep 29, 2013 at 9:02 AM, Guru Prasad <gurupras@buffalo.edu> wrote:
> I'm working with a fairly old version of the Linux kernel (v3.0) on
> the Android platform.
>
> I tried searching for examples where I can wake the system using some
> of the clocks that continue to tick despite the system being suspended
> (CLOCK_REALTIME_ALARM I think?) but couldn't find any.
>
> From my understanding, it should be possible to do so as long as I can
> request an alarm from CLOCK_REALTIME_ALARM..but I don't quite
> understand how to do so.

Later android kernels + bionic support for timerfd can do it with
timerfd_create and timerfd_settime on *_ALARM clocks (kernel support
for this went into upstream linux-3.11), but android-3.0 is too old
(the alarm driver would need significant upgrading and reconciling the
android vs. upstream alarm drivers, prior to merging timerfd support
for alarms).

In android-3.0 you can also use the Android-specific alarm driver
interface in drivers/rtc/alarm-dev.c to set an alarm of type
ANDROID_ALARM_{RTC,ELAPSED_REALTIME}_WAKEUP.


Todd
