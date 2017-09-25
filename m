From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / core: Drop legacy class suspend/resume operations
Date: Mon, 25 Sep 2017 17:17:58 +0200
Message-ID: <55793765.lp3oEIVgtE@aspire.rjw.lan>
References: <6823681.sfkuFdUyaG@aspire.rjw.lan> <20170925132443.GA5325@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64378 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964908AbdIYP1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 11:27:10 -0400
In-Reply-To: <20170925132443.GA5325@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>

On Monday, September 25, 2017 3:24:43 PM CEST Greg Kroah-Hartman wrote:
> On Mon, Sep 25, 2017 at 02:56:44PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There are no classes using the legacy suspend/resume operations in
> > the tree any more, so drop these operations and update the code
> > referring to them accordingly.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |   32 +++++++++-----------------------
> >  include/linux/device.h    |    5 -----
> >  2 files changed, 9 insertions(+), 28 deletions(-)
> 
> Yeah!!!
> 
> Do you want me to take this now, for -rc2, in my tree (as I'll gladly do
> so, I have some other api removals queued up already), or do you want to
> do it through yours?
> 
> Either is fine with me, if you want to take it:
> 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

There likely will be more patches going in this direction from me shortly, so
I'll handle it. :-)

Thanks,
Rafael
