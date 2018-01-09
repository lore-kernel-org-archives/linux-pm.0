From: Samuel Morris <samorris@lexmark.com>
Subject: Re: question: concerning disabling suspend of individual devices
Date: Tue, 9 Jan 2018 17:40:18 -0500
Message-ID: <CAFY_6qpTLzgCDGd8ZpK09cbK4g3i0Z7eci6nR11ohtRhXR+ptQ@mail.gmail.com>
References: <CAFY_6qoHuBUJ=SqWGKLb=QRm+RqQ0sY_LYiT4h-5Yi1HXz=LZw@mail.gmail.com>
 <CAJZ5v0j-mzNZvgnToiyGt7CuumF1_Ap_1QQ30W+YLbuXPCkDiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:39826 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbeAIWlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 17:41:00 -0500
Received: by mail-qt0-f174.google.com with SMTP id k19so19872450qtj.6
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 14:41:00 -0800 (PST)
In-Reply-To: <CAJZ5v0j-mzNZvgnToiyGt7CuumF1_Ap_1QQ30W+YLbuXPCkDiw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>

On Tue, Jan 9, 2018 at 5:08 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 9, 2018 at 10:28 PM, Samuel Morris <samorris@lexmark.com> wrote:
>> Hello,
>>
>> Unless I am mistaken, there does not seem to be a way to disable system suspend
>> of an individual device, either through sysfs or a probe time config.
>
> The only way you could do that would be for the device to fail one of
> its callbacks, but that would abort the entire suspend transition of
> the system.
>
>> I've encountered cases in the past where either the suspend behavior of a device is
>> buggy, or functionally it just does not do what I want. For example, I had an
>> led I wanted to keep on during system suspend.
>
> That may ot may not be doable depending on the configuration of the
> whole platform.
>
> The whole idea of system suspend is that everything suspends and
> devices depend on each other in general, so it may not be possible to
> avoid suspending just one of them.

Okay, that makes sense. I was thinking in terms of just getting to the
STR state, and
from that perspective the led being on didn't seem important. But it
makes sense that
each device should at least report that it has made the necessary
preparations even
if there are none.

>
> But it seems that what you really would like to do is to be able to
> say that power should be provided to the device while suspended (which
> is different from disabling suspend).

Yes.

>
>> Nearly all LED class devices turn
>> off during suspend, and offer userspace no method of preventing that. This
>> doesn't seem like a quality of service thing,
>
> But it may be regarded as such.
>
> We have a PM QoS flag for similar things which currently is used for
> runtime PM only, but in principle it may also be used during
> system-wide transitions.  It is called PM_QOS_FLAG_NO_POWER_OFF.
>
>> the led just does not have the
>> suspend behavior I want. I am in the process of making that particular case
>> configurable, but why not just add the option to disable suspend for each
>> individual device as with runtime_pm?
>
> I'm afraid that that can't work the way you seem to be wanting it to work.
>
>>  Would this be a worthwhile feature to work on?
>
> Not really.
>
> I'd rather think about maybe using PM_QOS_FLAG_NO_POWER_OFF.

Will do.

>
> Thanks,
> Rafael

thanks,
Sam
