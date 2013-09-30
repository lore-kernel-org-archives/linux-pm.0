From: Todd Poynor <toddpoynor@google.com>
Subject: Re: Userspace program to wake system from suspend
Date: Mon, 30 Sep 2013 12:48:55 -0700
Message-ID: <CAAW3Ypb7R-eny43yRqS348med0-wdKBQkkEZkH_UdOL1E80B8w@mail.gmail.com>
References: <CAMefCkAsg8sDku-dU+kdYwLfaFbUC=z_4XQnjt3E1LZE21v5aA@mail.gmail.com>
	<CAAW3YpY6wi9q+SJNznjNJogJ-dWPzSQMcy38ha_Yqgo-E9UnNQ@mail.gmail.com>
	<CAMefCkDZBBFxFKmNFq1ANd6XuwnMpz3ovf42eYwOyyW0iWLR_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:48849 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215Ab3I3Ts4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 15:48:56 -0400
Received: by mail-qc0-f182.google.com with SMTP id n4so4055735qcx.27
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2013 12:48:55 -0700 (PDT)
In-Reply-To: <CAMefCkDZBBFxFKmNFq1ANd6XuwnMpz3ovf42eYwOyyW0iWLR_g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guru Prasad <gurupras@buffalo.edu>
Cc: linux-pm@vger.kernel.org

On Mon, Sep 30, 2013 at 12:16 AM, Guru Prasad <gurupras@buffalo.edu> wrote:
...
> I'm now trying to set an alarm using something like
> struct timespec ts;
> ts.tv_nsec     = 0;
> ts.tv_sec       = 15;
>
> int alarm_fd = open("/dev/alarm", O_RDWR);
> int result = ioctl(alarm_fd,
> ANDROID_ALARM_SET(ANDROID_ALARM_ELAPSED_REALTIME), &ts);
...
> Is the timespec value expected to be relative to time since epoch?

I haven't used this myself, but looks like an
ANDROID_ALARM_GET_TIME(ANDROID_ALARM_ELAPSED_REALTIME) is needed to
get the current clock value, and generate relative times from that.

> I've also confirmed that the device does not wake up from suspend
> using the above snippet.

Use ANDROID_ALARM_ELAPSED_REALTIME_WAKEUP for the set.

> Currently, I've exported android_alarm.h from aosp kernel-headers.
> Would that be a problem?
> This also means that I'm using sys/ioctl.h instead of aosp's kernel/ioctl.h

Shouldn't be a problem.


Todd
