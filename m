From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Mon, 2 Nov 2015 10:18:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1511021015090.1654-100000@iolanthe.rowland.org>
References: <alpine.LNX.2.00.1511021137310.22567@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40708 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753548AbbKBPSN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 10:18:13 -0500
In-Reply-To: <alpine.LNX.2.00.1511021137310.22567@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 2 Nov 2015, Jiri Kosina wrote:

> On Mon, 2 Nov 2015, Rafael J. Wysocki wrote:

> > BTW, the freezing of filesystems during system suspend (not hibernation) makes
> > sense too, because it will help to address the long-standing issue with storage
> > devices that go away while the system is suspended.
> > 
> > I guess it may also helps to address the case when a device is removed from a
> > suspended system, written to on another system in the meantime and inserted
> > back into the (still suspended) original system which then is resumed.  Today
> > this is an almost guaranteed data corruption scenario, but if the filesystem in
> > question is properly frozen during suspend, the driver should be able to detect
> > superblock changes during unfreeze.

I agree completely; adding filesystem freezing is a great idea.

> > So the approach I'd suggest would be to add the freezing of filesystems to the
> > suspend/resume code paths just for the above reasons and drop the kthreads
> > freezing from the filesystems that support the proper freezing.  The rest
> > should be easier to deal with then.
> 
> That alone makes sense. It'll however leave a load of freezer users in the 
> kernel that make no sense (one example picked completely out of the air: 
> w1_process(); what is the reason for it there?) and are likely broken 
> (completely random examples again: md, xfsaild -- they think they are 
> freezable, but they are not).

If you fix just the kthreads which do this (along with an explanation
in the changelog of why the kthread is wrong), while leaving the others
alone, that ought to be acceptable.

Alan Stern

