From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 2/4] power: bq24190_charger: Clean up extcon code
Date: Mon, 3 Apr 2017 08:53:37 +0200
Message-ID: <857a9dd7-8ed3-0afe-d1e2-2420928263aa@redhat.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-3-liam@networkimprov.net>
 <6dbb405d-a840-7216-395f-7e4fa327cd70@redhat.com>
 <CAKvHMgQ6gJ822W_hXO8jGAq_vr4L8NaFJpNHA5sKYJ+kTRtQgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdDCGxw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 02:53:52 -0400
In-Reply-To: <CAKvHMgQ6gJ822W_hXO8jGAq_vr4L8NaFJpNHA5sKYJ+kTRtQgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 03-04-17 00:03, Liam Breck wrote:

<snip>

> Could you adjust your tone to be more collaborative and less cutting?

I'm sorry if I sounded a bit cutting.

I've tried nothing but to be collaborative and work with you
until now, but this patch introduces several changes I already
mentioned were not a good idea in your review of my original
patch and IMHO do nothing to improve the code.

> You only have this code for the Atom device because I designed and
> built hardware with this part and hired Mark to write the driver from
> scratch. I'd like a little goodwill in exchange!

And here we get to the root of the problem, that you keep claiming
ownership of the driver because you paid Mark to write it,
this is not how the Linux kernel works. Yes you paid Mark to write
a driver and in return you get an entire kernel. You no less own
the bq24190_charger driver then other people own other parts of
the kernel.

Your remarks against Sebastian that he MUST wait for your ack
before merging anything are quite frankly completely out of line
and I have been on the verge of saying something about this
several times already but I decided to stay quiet (until now).

So yes I apologize for my tone getting a bit cutting as I never
want that, but TBH I've found the way you're claiming to be
THE authority on the bq24190_charger driver and have been behaving
if everyone needs to do exactly as you say when it comes to that
driver quite off-putting / abrasive.

As for me "only having this code for the Atom devices", it would
have likely taken me way less time to knock out a new driver
(like I've done for the fuel-gauge) then all the coordination with
you is costing me...

> And also gratitude
> for taking time to fix two of your patches.

I reviewed and acked the first fix, which is my way of saying
thank you. As for this set of fixes, I never asked for those
and I think they are a bad idea.

> I expect discussion of charger patches with an experienced kernel
> contributor to look like these threads:
>
> https://patchwork.kernel.org/project/linux-pm/list/?submitter=109&state=*&q=bq24190_charger%3A+Use+PM+runtime+autosuspend&archive=both

So do I and usually conversations I take place in look like that
...

Regards,

Hans
