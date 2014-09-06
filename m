From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: External devices
Date: Sat, 6 Sep 2014 11:12:35 +0300
Message-ID: <CAJ2oMh+EoX+G1wz4X7hBNFE_56=8eq_DVxEy20=nc1vZURu2tQ@mail.gmail.com>
References: <CAJ2oMhKRA+0Ge_m=-zFqgTxcZbuGMNAOvBQKP=_GyWRwvfsKFw@mail.gmail.com>
	<CAGAs2Amw1jvmDxL8+uXU4XW3u6Mxr7LKP4EiP8taTNQ2OpnWNw@mail.gmail.com>
	<CAJ2oMhL=wuWA3Ga4bdeqvW0QA-cccLA0BfVRDKyLuykyChqu7w@mail.gmail.com>
	<CAJ2oMhKnQczVwLhO0hHyJHCgc6UkV5g7sc3Gnnoq+ktUVYw+pQ@mail.gmail.com>
	<CAGAs2A=nmNqMYNLvzPsBbysfV3LtkxJQzEpN+SZcL1cMVdMbmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:39977 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaIFIMg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Sep 2014 04:12:36 -0400
Received: by mail-qa0-f42.google.com with SMTP id dc16so8080229qab.15
        for <linux-pm@vger.kernel.org>; Sat, 06 Sep 2014 01:12:35 -0700 (PDT)
In-Reply-To: <CAGAs2A=nmNqMYNLvzPsBbysfV3LtkxJQzEpN+SZcL1cMVdMbmQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

Hi,

Thanks very much for the detailed answer. If I may ask one more on
this issue please...

I am required to put some external device (led brightness) into
minimal brightness when the system gets to idle.
The control on led brightness value is done as part of dedicated
character device which was written for the purpose of brightness
control (which uses i2c bus)
I wander if this is possible using the linux PM capabilities, and how
this should be done.

Thanks,
Ran

On Fri, Sep 5, 2014 at 7:13 PM, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
>> When adding some external device to power management, doesn't it need
>> to belong to power domain  ( /debug/pm_debug/count ).
>
> Power Domains are decided by system designer. A board can be divided
> into multiple power domains which can be powered on/off or
> voltage/current regulated independently as each power domain is
> controlled by a power regulator.
>
>> What is the power domain of external device ?
> The right person to answer this question will be your system designer.
> You may look into the board schematics to find out power regulator of
> your external device. Each power domain is controlled by a power
> regulator.
>
> It is not necessary for you to consider power domains if you do not
> wish to power up/down or regulate the voltage /current while running
> Linux on the board. Another generic way to do runtime-power management
> of various devices would be to perform clock scaling/gating (assuming
> you know the clock domains of your system).
