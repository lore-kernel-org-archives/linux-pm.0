From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v1 1/2] PM/devfreq: add suspend frequency support
Date: Tue, 22 Nov 2016 21:48:14 +0900
Message-ID: <CAJ0PZbSYZYF6xJ-ut23G+tTXYLCDNpQ8_AJpjTdDGO7VnECMvg@mail.gmail.com>
References: <1477990029-11062-1-git-send-email-hl@rock-chips.com>
 <CGME20161101084721epcas4p471cc74df8b12d042d1fac542e5371db8@epcas4p4.samsung.com>
 <422077764.570918.1478068526663.JavaMail.weblogic@ep1ml102b> <581AE13C.9070706@rock-chips.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34177 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932335AbcKVMsa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 07:48:30 -0500
Received: by mail-io0-f194.google.com with SMTP id r94so277044ioe.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 04:48:30 -0800 (PST)
In-Reply-To: <581AE13C.9070706@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: hl <hl@rock-chips.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "dianders@chromium.org" <dianders@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>

On Thu, Nov 3, 2016 at 4:03 PM, hl <hl@rock-chips.com> wrote:
> Hi MyungJoo Ham,
>
>
> On 2016=E5=B9=B411=E6=9C=8802=E6=97=A5 14:35, MyungJoo Ham wrote:
>>>
>>> Add suspend frequency support and if needed set it to
>>> the frequency obtained from the suspend opp (can be defined
>>> using opp-v2 bindings and is optional).
>>>
>>> Change-Id: Iaa0d3848d63d9ce03f65ea76f263e4685a4c295e
>>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 17 ++++++++++++++++-
>>>   include/linux/devfreq.h   |  9 +++++++++
>>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index bf3ea76..d1152eb 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -364,7 +364,10 @@ void devfreq_monitor_suspend(struct devfreq
>>> *devfreq)
>>>                 return;
>>>         }
>>>   -     devfreq_update_status(devfreq, devfreq->previous_freq);
>>> +       if (devfreq->suspend_freq)
>>> +               devfreq_update_status(devfreq, devfreq->suspend_freq);
>>> +       else
>>> +               devfreq_update_status(devfreq, devfreq->previous_freq);
>>
>> This is incorrect.
>>
>> devfreq_update_status is to record the statistics.
>> This code intends to record the current status before entering suspend;
>> thus you should not record "suspend_freq" here.
>>
>> If you really need to record the frequency during suspended state
>> for the statistics, you need to do that at resume; however, I object to
>> that idea either.
>>
>> If you really want to set a predefined suspend-to-RAM mode frequency,
>> (probably because of HW instability during resume process)
>> you need to update, not udpate_status (statistics).
>>
> Thanks for pointing it, but if i use update_devfreq(), it can not specify
> the
> frequency, it call the get_target_freq() to get the frequency and setting=
,
> use now devfreq framework, it seems hard to set the specific freqeuency
> when suspend. Do you have any idea, thanks.


It appears that we need to set the frequency directly with target() functio=
n
at suspend/resume after it is assured that related routines are
already suspended.

Plus, you might need to consider using devfreq_suspend/resume_device instea=
d
of monitor. monitor functions are for the governor-specific behaviors.
You'll need such capabilities regardless of governors. (even userspace-gove=
rnor
needs this)

Cheers,
MyungJoo

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
