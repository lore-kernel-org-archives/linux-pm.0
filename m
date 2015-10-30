From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Fri, 30 Oct 2015 18:44:17 +0100
Message-ID: <20151030174417.GA16781@amd>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
 <Pine.LNX.4.44L0.1510301121340.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39712 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbJ3RoU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 13:44:20 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1510301121340.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri 2015-10-30 11:29:08, Alan Stern wrote:
> On Fri, 30 Oct 2015, Jiri Kosina wrote:
> 
> > This series is a followup to my proposal I brought up on Kernel Summit in 
> > Seoul. Noone seemed to had any principal objections, so let's have wider 
> > audience look into it.
> > 
> > In a nuthsell: freezing of kernel threads is horrible interface with 
> > unclear semantics and guarantees, and I am surprised it ever worked 
> > properly. Plus there are a lot of places that simply use it in a 
> > completely wrong way (which is not suprising, given the lack of defined 
> > semantics and requirements).
> > 
> > I've tested this over a series of suspend/resume cycles on several 
> > machines with at least ext4, btrfs and xfs, and it survived the testing 
> > without any harm.
> > 
> > Patch 1/3 	implements the actual change, and has a more detailed 
> > 		explanation on "why?" and "how?" questions in the changelog
> 
> This patch talks about freezing in relation to hibernation.  What about 
> other forms of suspend?
> 
> Also, it replaces kthread freezing with filesystem freezing.  What 
> about kthreads performing I/O that doesn't go through a filesystem?  
> You write:
> 
> > the only facility that is needed during suspend: "no persistent fs
> > changes are allowed from now on"
> 
> I would say instead "no I/O is allowed from now on".  Maybe that's an 
> overstatement, but I think it comes closer to the truth.

Exactly. And I'm pretty sure hardware drivers do use kernel threads,
and do I/O from them.

LEDs are just one example

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
