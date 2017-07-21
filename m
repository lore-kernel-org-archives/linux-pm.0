From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] PM / suspend: Messaging updates
Date: Fri, 21 Jul 2017 22:42:30 +0200
Message-ID: <1598403.3v8fpR9YnQ@aspire.rjw.lan>
References: <1714767.SyJDFOT8Lq@aspire.rjw.lan> <CAHp75VdGUNTU1URWqRW-B1y=2Wrw0YU0U1orC7gcVBuQRYXxZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49378 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753502AbdGUUuZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 16:50:25 -0400
In-Reply-To: <CAHp75VdGUNTU1URWqRW-B1y=2Wrw0YU0U1orC7gcVBuQRYXxZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Friday, July 21, 2017 06:13:45 PM Andy Shevchenko wrote:
> On Fri, Jul 21, 2017 at 3:48 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Hi,
> >
> > The first patch addresses a potential confusion regarding messages printed by
> > the suspend core code to the kernel log and the second one adds a pr_fmt() to
> > kernel/power/suspend.c.
> >
> > The patches are on top of the series I posted yesterday:
> >
> > http://marc.info/?l=linux-pm&m=150059650805506&w=2
> 
> Standardization is what I like.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!
