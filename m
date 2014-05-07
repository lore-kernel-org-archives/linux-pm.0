From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: pm_runtime_barrier breaks autosuspend
Date: Thu, 08 May 2014 01:54:40 +0200
Message-ID: <2470065.n7pC8cKvYW@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61864 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751568AbaEGXiA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 19:38:00 -0400
In-Reply-To: <Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dan.j.williams@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wednesday, May 07, 2014 11:21:15 AM Alan Stern wrote:
> On Tue, 6 May 2014, Dan Williams wrote:
> 
> > > Why didn't pm_request_resume() result in an autosuspend?
> > 
> > Found it.
> > 
> > The last thing pm_runtime_barrier() does is pm_runtime_put_noidle()
> > which may cause the autosuspend timer to never be reset.
> 
> Rafael, this seems like a bug.  Should pm_runtime_barrier() be changed
> so that just before the spinlock is released, we queue an autosuspend
> request if dev->power.use_autosuspend is set and all the other
> conditions are met?

Well, one of the pm_runtime_barrier() purposes is to flush pending requests
for the device, so queuing up a new one would kind of defeat that purpose.

Rafael

