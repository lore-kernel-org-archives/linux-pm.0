From: Guru Prasad <gurupras@buffalo.edu>
Subject: Userspace program to wake system from suspend
Date: Sun, 29 Sep 2013 12:02:11 -0400
Message-ID: <CAMefCkAsg8sDku-dU+kdYwLfaFbUC=z_4XQnjt3E1LZE21v5aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33741 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3I2QCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2013 12:02:11 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so4565340pbc.29
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2013 09:02:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I'm working with a fairly old version of the Linux kernel (v3.0) on
the Android platform.

I tried searching for examples where I can wake the system using some
of the clocks that continue to tick despite the system being suspended
(CLOCK_REALTIME_ALARM I think?) but couldn't find any.

>From my understanding, it should be possible to do so as long as I can
request an alarm from CLOCK_REALTIME_ALARM..but I don't quite
understand how to do so.

One option on my platform seems to be /sys/class/rtc/rtc0/wakealarm..I
guess I could use this as a last resort.
I would like to know whether there is any way to do this via C using
system calls, rather than writing to the 'wakealarm' file mentioned
above?

Could someone please share some resources on how one can set an alarm
from userspace using these clocks?


Thanks
