From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Re: External devices
Date: Mon, 8 Sep 2014 01:52:41 +0530
Message-ID: <CAGAs2AmsawCi72FR1W3Zv-n5dg63wKP4YSyKk=LSZDA6CagLrQ@mail.gmail.com>
References: <CAJ2oMhKRA+0Ge_m=-zFqgTxcZbuGMNAOvBQKP=_GyWRwvfsKFw@mail.gmail.com>
	<CAGAs2Amw1jvmDxL8+uXU4XW3u6Mxr7LKP4EiP8taTNQ2OpnWNw@mail.gmail.com>
	<CAJ2oMhL=wuWA3Ga4bdeqvW0QA-cccLA0BfVRDKyLuykyChqu7w@mail.gmail.com>
	<CAJ2oMhKnQczVwLhO0hHyJHCgc6UkV5g7sc3Gnnoq+ktUVYw+pQ@mail.gmail.com>
	<CAGAs2A=nmNqMYNLvzPsBbysfV3LtkxJQzEpN+SZcL1cMVdMbmQ@mail.gmail.com>
	<CAJ2oMh+EoX+G1wz4X7hBNFE_56=8eq_DVxEy20=nc1vZURu2tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58306 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbaIGUWm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Sep 2014 16:22:42 -0400
Received: by mail-pa0-f54.google.com with SMTP id lj1so2426011pab.41
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2014 13:22:42 -0700 (PDT)
In-Reply-To: <CAJ2oMh+EoX+G1wz4X7hBNFE_56=8eq_DVxEy20=nc1vZURu2tQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

>
> I am required to put some external device (led brightness) into
> minimal brightness when the system gets to idle.
Please elaborate on "System gets to idle state."
Do you mean the system is suspended ? ------- case 1
or the device has moved to idle state?     ------- case 2

> The control on led brightness value is done as part of dedicated
> character device which was written for the purpose of brightness
> control (which uses i2c bus)
> I wander if this is possible using the linux PM capabilities, and how
> this should be done.
In either case it should be possible as per my understanding. You need
to implement
it in the appropriate PM handlers.
case1 ----> write the appropriate code in driver->pm->suspend
case2 ----> write the appropriate code in driver->pm->runtime_idle

Regards,
Ayan Kumar Halder

> Thanks,
> Ran
>
> On Fri, Sep 5, 2014 at 7:13 PM, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
>>> When adding some external device to power management, doesn't it need
>>> to belong to power domain  ( /debug/pm_debug/count ).
>>
>> Power Domains are decided by system designer. A board can be divided
>> into multiple power domains which can be powered on/off or
>> voltage/current regulated independently as each power domain is
>> controlled by a power regulator.
>>
>>> What is the power domain of external device ?
>> The right person to answer this question will be your system designer.
>> You may look into the board schematics to find out power regulator of
>> your external device. Each power domain is controlled by a power
>> regulator.
>>
>> It is not necessary for you to consider power domains if you do not
>> wish to power up/down or regulate the voltage /current while running
>> Linux on the board. Another generic way to do runtime-power management
>> of various devices would be to perform clock scaling/gating (assuming
>> you know the clock domains of your system).
