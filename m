From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Fri, 30 Oct 2015 16:41:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
References: <alpine.LNX.2.00.1510302036140.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39766 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760820AbbJ3Uli (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 16:41:38 -0400
In-Reply-To: <alpine.LNX.2.00.1510302036140.17538@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 30 Oct 2015, Jiri Kosina wrote:

> On Fri, 30 Oct 2015, Pavel Machek wrote:
> 
> > > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > > overstatement, but I think it comes closer to the truth.
> 
> But that's what PM callbacks are for.

Why are PM callbacks any more suitable than the freezer?  The most 
natural implementation would be for the callback routine to set a flag; 
at various strategic points the kthread would check the flag and if it 
was set, call a routine that sits around and waits for the suspend to 
be over.  How does that differ from using the freezer, apart from being 
more cumbersome and involving more code?

Also, you never replied to my question about suspend vs. hibernation.

Alan Stern

