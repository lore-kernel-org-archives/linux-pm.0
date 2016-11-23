From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [BUG] genpd: domains can suspend asynchronously
Date: Wed, 23 Nov 2016 14:08:39 +0100
Message-ID: <CAPDyKFo+MMBhgFYWDGsyWF0+4RvdehSK8452Z_wqATayqO8mRA@mail.gmail.com>
References: <20161122230724.GA86250@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36926 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbcKWNIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 08:08:42 -0500
Received: by mail-wm0-f48.google.com with SMTP id t79so22988773wmt.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2016 05:08:41 -0800 (PST)
In-Reply-To: <20161122230724.GA86250@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 23 November 2016 at 00:07, Brian Norris <briannorris@chromium.org> wrote:
> Hi,
>
> I reported this previously in the midst of another tangentially-related
> thread, so it could easily have gotten lost. I thought I'd repeat it
> here.
>
> ---
>
> I noticed the genpd code has comments like this scattered all over:
>
>  * This function is only called in "noirq" and "syscore" stages of system power
>  * transitions, so it need not acquire locks (all of the "noirq" callbacks are
>  * executed sequentially, so it is guaranteed that it will never run twice in
>  * parallel).
>
> Isn't that no longer true, now that noirq suspend can be asynchronous?
> Maybe we should grep for the phrase "need not acquire locks" throughout
> the kernel, in order to find low-hanging fruit for race conditions :)

Thanks for the reminder. I have been starring at the comment for
several times, but never come around to send a patch. I will fix it
asap.

Moreover, genpd should also respect driver's ->suspend|resume_noirq()
callbacks(), which is another related change that should be done.
Let's me fix this as well.

>
> ---
>
> Anyway, I was considering hacking my way through the subsystem here
> sometime, but there's no guarantee. And in case someone else wanted to
> fix this up, I figured I'd least put the report out there.

I can deal with, and allow me to add your reported-by/suggested-by tag.

>
> NB: I noticed there are more drivers enabling asynchronous suspend these
> days. Some USB, SDIO, and MMC host controllers seem ripe for triggering
> bugs here.
>
> Brian

Kind regards
Uffe
