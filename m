From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] thunderbolt: icm: Ignore mailbox errors in icm_suspend()
Date: Fri, 28 Jul 2017 01:56:29 +0200
Message-ID: <4219139.ZZxCFtAegj@aspire.rjw.lan>
References: <4063610.TqANq0McE8@aspire.rjw.lan> <4165239.xHgWvuTePe@aspire.rjw.lan> <20170727085011.GY2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59071 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751584AbdG1AEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 20:04:31 -0400
In-Reply-To: <20170727085011.GY2369@lahna.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thursday, July 27, 2017 11:50:11 AM Mika Westerberg wrote:
> On Wed, Jul 26, 2017 at 07:05:01PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 26, 2017 04:12:59 PM Mika Westerberg wrote:
> > > On Wed, Jul 26, 2017 at 02:48:54PM +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, July 26, 2017 11:32:44 AM Mika Westerberg wrote:
> > > > > On Tue, Jul 25, 2017 at 06:10:57PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Tuesday, July 25, 2017 01:00:12 PM Mika Westerberg wrote:
> > > > > > > On Tue, Jul 25, 2017 at 01:31:00AM +0200, Rafael J. Wysocki wrote:
> > > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > > 
> > > > > > > > On one of my test machines nhi_mailbox_cmd() called from icm_suspend()
> > > > > > > > times out and returnes an error which then is propagated to the
> > > > > > > > caller and causes the entire system suspend to be aborted which isn't
> > > > > > > > very useful.
> > > > > > > > 
> > > > > > > > Instead of aborting system suspend, print the error into the log
> > > > > > > > and continue.
> > > > > > > 
> > > > > > > I agree, it should not prevent suspend but I wonder why it fails in the
> > > > > > > first place? Can you check what is the return value?
> > > > > > 
> > > > > > As per the above, the error is a timeout, ie. -ETIMEDOUT.
> > > > > 
> > > > > Ah, right I somehow missed that.
> > > > > 
> > > > > Does it have Falcon Ridge controller or Alpine Ridge?
> > > > 
> > > > I'll check later today, but i guess you'll know (see below).
> > > 
> > > No need to check, it is Alpine Ridge (since it is Dell 9360).
> > > 
> > > > > Just to make sure, can you increase the timeout in nhi_mailbox_cmd()
> > > > > to 1000ms or so. It should not take that long though but better to check.
> > > > 
> > > > Well, I can do that, but I don't think it will help.
> > > > 
> > > > It just looks like the chip is not responding at all at that point.
> > > 
> > > I see.
> > > 
> > > Then I think we should apply your patch now and we can investigate this
> > > further offline and hopefully find the root cause for the problem.
> > > 
> > > For this patch:
> > > 
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > OK
> > 
> > I guess I can apply it, then, or if anyone else in the CC wants to do that,
> > please let me know.
> 
> Greg typically takes these but I'm fine either way.

OK, applied then.
