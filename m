From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: power management regression in linux 3.10?
Date: Tue, 4 Jun 2013 16:19:54 +0200
Message-ID: <20130604141952.GI14973@somewhere>
References: <1370282175.18020.4.camel@localhost>
 <1426816.yLxoxJJ6NX@vostro.rjw.lan>
 <51ACF071.702@gmail.com>
 <2330824.Xqf4iUAbIP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:43018 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073Ab3FDOT6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2013 10:19:58 -0400
Received: by mail-wg0-f52.google.com with SMTP id z11so267392wgg.19
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2013 07:19:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2330824.Xqf4iUAbIP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Michael Karcher <Michael.Karcher@fu-berlin.de>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>

On Mon, Jun 03, 2013 at 10:04:30PM +0200, Rafael J. Wysocki wrote:
> On Monday, June 03, 2013 12:37:21 PM Dirk Brandewie wrote:
> > On 06/03/2013 12:34 PM, Rafael J. Wysocki wrote:
> > > On Monday, June 03, 2013 07:56:15 PM Michael Karcher wrote:
> > >> Hello,
> > >>
> > >> I am using an IBM ThinkPad T60 (i915, Core 2 Duo T7200) and recently
> > >> upgraded from a custom 3.7 kernel to a custom 3.10-rc4 kernel
> > >> (v3.10-rc4-1-gc026d8e).
> > >> After upgrading, I get around 17-20W power usage instead of 12-15W power
> > >> usage as I had with 3.7. powertop show that CPU0 is in state POLL all of
> > >> the idle time, while CPU1 correctly enters C3.

With CONFIG_NO_HZ_FULL it is expected that CPU 0 consumes more power because
it handles the timekeeping for every other CPUs and so it never stop its tick.
Paul McKenney is working on a solution to solve that.

But if you see something similar on the other CPUs it's a bug.

Thanks.
