From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Sun, 14 Sep 2014 09:11:48 +0300
Message-ID: <CAJ2oMhL1+RBw5ifB_CcuTK2nKRhCfKLXZZd4k6GzT9q6p8RTAA@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
	<23104.1410377100@turing-police.cc.vt.edu>
	<CAGAs2Anafp-S+L5B7meg9ET-ckb=MDFupUQk5DnKTTJ9mWWJXA@mail.gmail.com>
	<CAJ2oMhJdAr0akNJoVXafvW95zzK+MKWbf=b79+EuKm60L3CKdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:61789 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaINGLt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Sep 2014 02:11:49 -0400
Received: by mail-qg0-f52.google.com with SMTP id i50so2623700qgf.39
        for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2014 23:11:48 -0700 (PDT)
In-Reply-To: <CAJ2oMhJdAr0akNJoVXafvW95zzK+MKWbf=b79+EuKm60L3CKdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

On Thu, Sep 11, 2014 at 12:24 PM, Ran Shalit <ranshalit@gmail.com> wrote:
> On Thu, Sep 11, 2014 at 8:32 AM, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
>> On Thu, Sep 11, 2014 at 12:55 AM,  <Valdis.Kletnieks@vt.edu> wrote:
>>> On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:
>>>
>>>> 1. How can I make a process to notice this inactivity ? Do you think
>>>> it can be implemented by some periodic process who check if there is
>>>> activity ? It returns to the original question I raised, that I will
>>>> use some periodic process who checks maybe cpu load or something like
>>>> that. What do you think ?
>>>
>>> That's going to depend on your system and what processes are running.
>>>
>>> You may have an MP3 player going that doesn't take much CPU at all - but
>>> shutting down because the user hasn't hit a button in 47 minutes will probably
>>> irritate the user no end.  Or there may be a screensaver running that takes
>>> twice as much CPU as the MP3 player, but is totally OK on the system
>>> suspending whenever the rest of the system wants it.
>>>
>>> You're going to have to look at your system design, and decide for yourself
>>> what the criteria are.
>>
>> Please correct me if my understanding is wrong:-
>>
>> I believe that autosuspend feature (for system suspend) is not present
>> in kernel. I believe that there is no feature in kernel which checks
>> for system ( cpu, devices) inactivity and suspends the entire system.
>> System suspend is caused when :-
>> 1. the user issues a command
>> 2. The system receives some interrupt or event (lid closing event)
>> 3. There is an external process which monitors system inactivity and
>> suspends the system.
>>
>> For runtime suspend of a device, I believe it is the driver who has
>> the complete responsibility to decide when to suspend the device or
>> resume it.  The driver can take this decision on user intervention (eg
>> when user writes to   /sys/devices/<my-device>/power/* ) or when the
>> driver has completed servicing an interrupt and feels it has nothing
>> more to do, etc
>
> Thanks Vlaid, Ayan,
>
> I am a bit yet struggling for couple of days on this PM issue, and I
> would appreciate your continous advise.
> The system requirement I have is as following:
> 1. make everything as automatic as possible , so that there won't be
> any need to add any userspace application for the matter.
> 2. wakeup from all relevant wakeup sources
> 3. should not use sysfs (it should be disabled from kernel)
> 4. platform is OMAP3530.
>
> Now, As I understand thus far, I have the following options (
> requirement 3 above I will ignore, don't know how to handle it yet,
> and assume for meanwhile that I have sysfs) :
> 1. use suspend scheme (no runtime PM)
>     1.a. create some kernel thread who check cpu load and will decide
> to disable system only if its below some minimum threshold (which
> should indicate no activity)
>     1.b. initialize all HW interrupts (gpio, uart, etc) as wakeup sources
>     with this scheme only this thread is responsible for the suspend,
> and there is no use of the runtime PM, right ?
>
> 2. use runtime PM scheme :
>     With this scheme I don't understand how some device will wake the
> system , or doesn't it need to  ? If a driver wakes up maybe it need
> to deliver some info to system    ?
>
> I think option 1 is also easier to support, what do you think about both ?
>
> Thanks!!
> Ran

Does Anyone have any suggestions and feedback on the above requirements ?

Thank you,
Ran
