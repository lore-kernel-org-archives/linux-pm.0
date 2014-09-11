From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Thu, 11 Sep 2014 11:02:55 +0530
Message-ID: <CAGAs2Anafp-S+L5B7meg9ET-ckb=MDFupUQk5DnKTTJ9mWWJXA@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
	<23104.1410377100@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38690 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaIKFc4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 01:32:56 -0400
Received: by mail-pd0-f173.google.com with SMTP id ft15so10541926pdb.18
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 22:32:55 -0700 (PDT)
In-Reply-To: <23104.1410377100@turing-police.cc.vt.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: Ran Shalit <ranshalit@gmail.com>, linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

On Thu, Sep 11, 2014 at 12:55 AM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:
>
>> 1. How can I make a process to notice this inactivity ? Do you think
>> it can be implemented by some periodic process who check if there is
>> activity ? It returns to the original question I raised, that I will
>> use some periodic process who checks maybe cpu load or something like
>> that. What do you think ?
>
> That's going to depend on your system and what processes are running.
>
> You may have an MP3 player going that doesn't take much CPU at all - but
> shutting down because the user hasn't hit a button in 47 minutes will probably
> irritate the user no end.  Or there may be a screensaver running that takes
> twice as much CPU as the MP3 player, but is totally OK on the system
> suspending whenever the rest of the system wants it.
>
> You're going to have to look at your system design, and decide for yourself
> what the criteria are.

Please correct me if my understanding is wrong:-

I believe that autosuspend feature (for system suspend) is not present
in kernel. I believe that there is no feature in kernel which checks
for system ( cpu, devices) inactivity and suspends the entire system.
System suspend is caused when :-
1. the user issues a command
2. The system receives some interrupt or event (lid closing event)
3. There is an external process which monitors system inactivity and
suspends the system.

For runtime suspend of a device, I believe it is the driver who has
the complete responsibility to decide when to suspend the device or
resume it.  The driver can take this decision on user intervention (eg
when user writes to   /sys/devices/<my-device>/power/* ) or when the
driver has completed servicing an interrupt and feels it has nothing
more to do, etc
