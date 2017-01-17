From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 5/6] power: bq24190_charger: Don't read fault register
 outside irq_handle_thread()
Date: Mon, 16 Jan 2017 18:59:12 -0700
Message-ID: <20170117015912.GC2926@animalcreek.com>
References: <CAKvHMgQgEEhmbVgTHk6VuQB=tbN+nZV5F=if1_2CzVKb5TpYnA@mail.gmail.com>
 <20170116185404.GF27262@animalcreek.com>
 <CAKvHMgQC2im2HoN0RLnqa1-_7voAPhNy_1E-XeqkbA-idXv6uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60391 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750787AbdAQB7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 20:59:14 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgQC2im2HoN0RLnqa1-_7voAPhNy_1E-XeqkbA-idXv6uA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Mon, Jan 16, 2017 at 12:25:41PM -0800, Liam Breck wrote:
> On Mon, Jan 16, 2017 at 10:54 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> > On Sun, Jan 15, 2017 at 10:08:25PM -0800, Liam Breck wrote:

> >>       if (f_reg != bdi->f_reg) {
> >> +             dev_info(bdi->dev, "Fault: boost %d, charge %d, battery %d, ntc %d\n",
> >
> > Please break the line above into two after the first comma.
> 
> Will do. I wish the kernel crowd counted a tab as one char :-p

Thanks.  FYI, there are lots of ways to do it but an easy way to check is:

	expand <filename> | grep -n '.\{81\}'

Mark
--
