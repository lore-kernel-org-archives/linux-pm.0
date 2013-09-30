From: Guru Prasad <gurupras@buffalo.edu>
Subject: Re: Userspace program to wake system from suspend
Date: Mon, 30 Sep 2013 03:16:21 -0400
Message-ID: <CAMefCkDZBBFxFKmNFq1ANd6XuwnMpz3ovf42eYwOyyW0iWLR_g@mail.gmail.com>
References: <CAMefCkAsg8sDku-dU+kdYwLfaFbUC=z_4XQnjt3E1LZE21v5aA@mail.gmail.com>
	<CAAW3YpY6wi9q+SJNznjNJogJ-dWPzSQMcy38ha_Yqgo-E9UnNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34611 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab3I3HQW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 03:16:22 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so5196816pbc.22
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2013 00:16:22 -0700 (PDT)
In-Reply-To: <CAAW3YpY6wi9q+SJNznjNJogJ-dWPzSQMcy38ha_Yqgo-E9UnNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-pm@vger.kernel.org

Hi Todd,

Thanks for your response.

I'm trying to look at the Android platform AlarmManager code; both
Java and native, to try and figure out exactly how I'm supposed to use
this interface.

I'm now trying to set an alarm using something like
struct timespec ts;
ts.tv_nsec     = 0;
ts.tv_sec       = 15;

int alarm_fd = open("/dev/alarm", O_RDWR);
int result = ioctl(alarm_fd,
ANDROID_ALARM_SET(ANDROID_ALARM_ELAPSED_REALTIME), &ts);


However, upon execution, kmsg shows me the following
[  430.304171] alarm_release: clear alarm, pending 0

Is the timespec value expected to be relative to time since epoch?

I've also confirmed that the device does not wake up from suspend
using the above snippet.


Currently, I've exported android_alarm.h from aosp kernel-headers.
Would that be a problem?
This also means that I'm using sys/ioctl.h instead of aosp's kernel/ioctl.h


Thanks and Regards
Guru

On Sun, Sep 29, 2013 at 3:18 PM, Todd Poynor <toddpoynor@google.com> wrote:
> On Sun, Sep 29, 2013 at 9:02 AM, Guru Prasad <gurupras@buffalo.edu> wrote:
>> I'm working with a fairly old version of the Linux kernel (v3.0) on
>> the Android platform.
>>
>> I tried searching for examples where I can wake the system using some
>> of the clocks that continue to tick despite the system being suspended
>> (CLOCK_REALTIME_ALARM I think?) but couldn't find any.
>>
>> From my understanding, it should be possible to do so as long as I can
>> request an alarm from CLOCK_REALTIME_ALARM..but I don't quite
>> understand how to do so.
>
> Later android kernels + bionic support for timerfd can do it with
> timerfd_create and timerfd_settime on *_ALARM clocks (kernel support
> for this went into upstream linux-3.11), but android-3.0 is too old
> (the alarm driver would need significant upgrading and reconciling the
> android vs. upstream alarm drivers, prior to merging timerfd support
> for alarms).
>
> In android-3.0 you can also use the Android-specific alarm driver
> interface in drivers/rtc/alarm-dev.c to set an alarm of type
> ANDROID_ALARM_{RTC,ELAPSED_REALTIME}_WAKEUP.
>
>
> Todd
