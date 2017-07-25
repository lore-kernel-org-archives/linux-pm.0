From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] thunderbolt: icm: Ignore mailbox errors in icm_suspend()
Date: Tue, 25 Jul 2017 18:10:57 +0200
Message-ID: <2537138.AhdhMFtmoG@aspire.rjw.lan>
References: <4063610.TqANq0McE8@aspire.rjw.lan> <20170725100012.GH2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59418 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752243AbdGYQS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 12:18:56 -0400
In-Reply-To: <20170725100012.GH2369@lahna.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tuesday, July 25, 2017 01:00:12 PM Mika Westerberg wrote:
> On Tue, Jul 25, 2017 at 01:31:00AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > On one of my test machines nhi_mailbox_cmd() called from icm_suspend()
> > times out and returnes an error which then is propagated to the
> > caller and causes the entire system suspend to be aborted which isn't
> > very useful.
> > 
> > Instead of aborting system suspend, print the error into the log
> > and continue.
> 
> I agree, it should not prevent suspend but I wonder why it fails in the
> first place? Can you check what is the return value?

As per the above, the error is a timeout, ie. -ETIMEDOUT.
