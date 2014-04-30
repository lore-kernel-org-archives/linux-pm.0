From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data
Date: Wed, 30 Apr 2014 10:53:58 +0200
Message-ID: <CAPDyKFqH-0rvs6WorcirY+wVMLWnycWHO6=ZcvK1GebcuzaH0w@mail.gmail.com>
References: <1397230004-22306-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFpbX3cdAgvUx=4FbmNxFLH4VO8JqrQqRB3nxXMxZDyXJQ@mail.gmail.com>
	<20140425010651.GC12641@verge.net.au>
	<1469030.SEtTICGcIm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40519 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbaD3Ix7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 04:53:59 -0400
Received: by mail-qa0-f46.google.com with SMTP id w8so1328591qac.5
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2014 01:53:58 -0700 (PDT)
In-Reply-To: <1469030.SEtTICGcIm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 30 April 2014 00:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, April 25, 2014 10:06:51 AM Simon Horman wrote:
>> On Thu, Apr 24, 2014 at 01:25:14PM +0200, Ulf Hansson wrote:
>> > On 14 April 2014 11:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > > On 14 April 2014 03:20, Simon Horman <horms@verge.net.au> wrote:
>> > >> On Fri, Apr 11, 2014 at 05:26:41PM +0200, Ulf Hansson wrote:
>> > >>> There are no active users of these callbacks, thus there are no benefit
>> > >>> of trying to invoke them.
>> > >>>
>> > >>> Cc: Simon Horman <horms@verge.net.au>
>> > >>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> > >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> > >>> ---
>> > >>>
>> > >>> I am seeking ack from the SOC maintainers since this needs to go with the other
>> > >>> patches in this patchset on the PM core.
>> > >>
>> > >> In order to reduce the possibility of conflicts I would prefer
>> > >> to take this patch through my tree.
>> > >
>> > > Okay, go ahead!
>> > >
>> >
>> > Hi Simon,
>> >
>> > Just wanted to know, if you decided to queue this patch in your tree.
>> > Or were there anything else you needed me to fix here?
>>
>> Sorry for dropping the ball. I will queue-up this patch.
>
> OK
>
> Ulf, since the rest of the series depends on this one (or at least that's
> how it looks to me), would you mind resending it when this one gets into the
> Linus' tree?

Well, I would prefer if we could go ahead with the rest of the patches
somehow for 3.16, but I guess it will be hard if Simon picks up this
patch!?

Simon,
I guess the reason for your concern were about conflicts, but the file
this patch touch has actually not been modified since Sep 2012. So,
maybe we could go through Rafaels tree anyway?

I have a bunch of other patches for genpd which I plan to send once
the first part of clean up patches were merged. Those are likely
material for 3.17 though.

Kind regards
Ulf Hansson

>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
