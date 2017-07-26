From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC][PATCH] thunderbolt: icm: Ignore mailbox errors in
 icm_suspend()
Date: Wed, 26 Jul 2017 11:32:44 +0300
Message-ID: <20170726083244.GE2369@lahna.fi.intel.com>
References: <4063610.TqANq0McE8@aspire.rjw.lan>
 <20170725100012.GH2369@lahna.fi.intel.com>
 <2537138.AhdhMFtmoG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbdGZIhI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 04:37:08 -0400
Content-Disposition: inline
In-Reply-To: <2537138.AhdhMFtmoG@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jul 25, 2017 at 06:10:57PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 25, 2017 01:00:12 PM Mika Westerberg wrote:
> > On Tue, Jul 25, 2017 at 01:31:00AM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > On one of my test machines nhi_mailbox_cmd() called from icm_suspend()
> > > times out and returnes an error which then is propagated to the
> > > caller and causes the entire system suspend to be aborted which isn't
> > > very useful.
> > > 
> > > Instead of aborting system suspend, print the error into the log
> > > and continue.
> > 
> > I agree, it should not prevent suspend but I wonder why it fails in the
> > first place? Can you check what is the return value?
> 
> As per the above, the error is a timeout, ie. -ETIMEDOUT.

Ah, right I somehow missed that.

Does it have Falcon Ridge controller or Alpine Ridge? Just to make sure,
can you increase the timeout in nhi_mailbox_cmd() to 1000ms or so. It
should not take that long though but better to check.

Which system this is BTW?
