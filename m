From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/1] cpupower: Add cpuidle library
Date: Thu, 28 Apr 2016 17:37:38 +0200
Message-ID: <CAJZ5v0hpwK=G=HCRk17f1v=nNtKGoVqc77cbRPtiGVpy2Tfg2A@mail.gmail.com>
References: <1685056.NeGEfvDZMv@skinner>
	<2574684.bDi1t35TAq@vostro.rjw.lan>
	<9049803.y9XhT0fdX4@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33606 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbcD1Phj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 11:37:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id p64so15863389lfg.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2016 08:37:39 -0700 (PDT)
In-Reply-To: <9049803.y9XhT0fdX4@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Apr 28, 2016 at 3:23 PM, Thomas Renninger <trenn@suse.de> wrote:
> On Tuesday, April 26, 2016 10:20:00 PM Rafael J. Wysocki wrote:
>> On Monday, April 25, 2016 04:30:09 PM Thomas Renninger wrote:
>> > Hi,
>> >
>> > this is a cleanup I wanted to do for a long time.
>
>> > I already added the change to our build service and things
>> > still build against the same archs like arm, ppc, x86:
>> > https://build.opensuse.org/package/show/hardware/cpupower
>> >
>> > It would be nice to get the one or other review.
>> >
>> > Rafael: If you could queue this up for mainline inclusion at some
>> > point of time, I would very much appreciate it!
>>
>> I can do it right now, but there are a few cpupower patches in Patchwork
>> that I'm not sure what to do with.
>
> Where do I find the patchwork stuff?
>
>> Do you want me to drop those on the floor?
>
> No, please not.
>
> I went through the list and found some patches.
> Not critical, but valid fixes.
> The one from Mattia already was in, in another form.
>
> I will send them right now.
>
> This should now more or less match with what patchwork
> gives you?

That's about right.  There is one more patch in Patchwork that is not
present in your series:

https://patchwork.kernel.org/patch/8301391/

I've queued up your series for 4.7, but I'm still unsure about the above one.


>
> Thanks,
>
>      Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
