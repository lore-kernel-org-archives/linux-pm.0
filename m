From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Wed, 27 Apr 2016 16:23:49 +0200
Message-ID: <CAPDyKFpOxabizwQqhtKb-h0vGpTRtrCa0nPxAKMY22rnjLCouw@mail.gmail.com>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
	<3340490.Br5NVWnCR9@avalon>
	<CAPDyKFoQp+-t=c8-Y6+f9U+WJHMEtwGUQ=+PaVNc1-vUkV8CEw@mail.gmail.com>
	<5465506.Z3sjI0lQh6@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35600 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbcD0OXv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 10:23:51 -0400
Received: by mail-wm0-f42.google.com with SMTP id e201so41381285wme.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 07:23:50 -0700 (PDT)
In-Reply-To: <5465506.Z3sjI0lQh6@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lina Iyer <lina.iyer@linaro.org>, Andy Gross <andy.gross@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

>
>> Following you reasoning, I agree!
>>
>> Let's put this patch on hold for a little while. I am already working
>> on changing genpd, so it shouldn't take long before I can post some
>> additional genpd patches improving the behaviour.
>
> I'd like to see something merged for v4.7 if possible. I agree that my patch
> isn't a long term solution (we want to avoid adding additional fields to the
> device power structure), but it has the benefit of being available now and
> fixing the problem I ran into with drivers that would be broken on v4.7
> without a fix. Do you think you could get a better fix ready in time for v4.7
> ? If so I'm fine with dropping this patch, but otherwise I'd prefer to get it
> merged and reverted as part of your better implementation for v4.8.

My impression was that devices becomes unnecessary resumed when they
don't need to. They won't stay resumed as the PM core invokes
pm_runtime_put() in the system PM complete phase.

So, in the end I think we are trying to optimize a behaviour here, but
not fix something that is "broken", correct?

Anyway, I have no objections to your proposed solution, so I leave it
to Rafael and Kevin to decide what to do.

>From my side I will continue with the improvements for the system PM
support in genpd.

Kind regards
Uffe
