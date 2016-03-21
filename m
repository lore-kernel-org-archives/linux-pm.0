From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Should suspend plug low-level devices?
Date: Mon, 21 Mar 2016 10:38:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603211036360.1708-100000@iolanthe.rowland.org>
References: <20160320182958.GR20028@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60610 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752582AbcCUOi5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 10:38:57 -0400
In-Reply-To: <20160320182958.GR20028@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Sun, 20 Mar 2016, Tejun Heo wrote:

> Hello,
> 
> On Fri, Mar 18, 2016 at 05:06:01PM -0400, Alan Stern wrote:
> > The original problem here was that some unfreezable code was waiting
> > (via flush_delayed_work) on frozen code, and it was blocking the
> > routine that would unfreeze things.  Therefore the order of freezing or
> > thawing has no bearing on this particular problem.
> 
> Yeah, this one is caused by a high-level kernel construct being frozen
> and device resuming as a whole taking place before unfreezing.  The
> eventual goal would be avoiding freezing any high-level kernel
> constructs as it can lead to circular dependencies as shown here.

That's not the point I was trying to make.

Even if we avoid freezing any high-level kernel constructs, there will 
_still_ be problems if a high-level construct blocks waiting for a 
low-level driver that is plugged... which is exactly the sort of thing 
that can happen when you call flush_delayed_work().

Alan Stern

