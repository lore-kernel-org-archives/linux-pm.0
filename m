From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Thu, 12 May 2016 22:28:22 +0200
Message-ID: <CAJZ5v0jTAM74asCM5gG5wBWn+gvSQ21_W6dY9WQD+cMybUnEEg@mail.gmail.com>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
	<5465506.Z3sjI0lQh6@avalon>
	<CAPDyKFpOxabizwQqhtKb-h0vGpTRtrCa0nPxAKMY22rnjLCouw@mail.gmail.com>
	<4661739.p5SU9QcIps@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35393 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcELU2X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 16:28:23 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so272859809wme.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 13:28:22 -0700 (PDT)
In-Reply-To: <4661739.p5SU9QcIps@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lina Iyer <lina.iyer@linaro.org>, Andy Gross <andy.gross@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 12, 2016 at 9:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello,
>
> On Wednesday 27 Apr 2016 16:23:49 Ulf Hansson wrote:
>> [...]
>>
>> >> Following you reasoning, I agree!
>> >>
>> >> Let's put this patch on hold for a little while. I am already working
>> >> on changing genpd, so it shouldn't take long before I can post some
>> >> additional genpd patches improving the behaviour.
>> >
>> > I'd like to see something merged for v4.7 if possible. I agree that my
>> > patch isn't a long term solution (we want to avoid adding additional
>> > fields to the device power structure), but it has the benefit of being
>> > available now and fixing the problem I ran into with drivers that would
>> > be broken on v4.7 without a fix. Do you think you could get a better fix
>> > ready in time for v4.7 ? If so I'm fine with dropping this patch, but
>> > otherwise I'd prefer to get it merged and reverted as part of your better
>> > implementation for v4.8.
>>
>> My impression was that devices becomes unnecessary resumed when they
>> don't need to. They won't stay resumed as the PM core invokes
>> pm_runtime_put() in the system PM complete phase.
>>
>> So, in the end I think we are trying to optimize a behaviour here, but
>> not fix something that is "broken", correct?
>>
>> Anyway, I have no objections to your proposed solution, so I leave it
>> to Rafael and Kevin to decide what to do.
>
> Kevin, Rafael, any comment ? I need to fix PM support in a driver that is
> currently broken partly due to this issue. Which of "PM / Runtime: Only force-
> resume device if it has been force-suspended" and this patch should we merge,
> if any ?

My and Kevin's assumption was that Ulf would provide a better fix
shortly, but I'm not sure how realistic that is.

Ulf?
