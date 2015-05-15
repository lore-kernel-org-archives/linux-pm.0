From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 10:20:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505151019470.1295-100000@iolanthe.rowland.org>
References: <20150515110417.1e3bbe12@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46950 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933641AbbEOOUR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 10:20:17 -0400
In-Reply-To: <20150515110417.1e3bbe12@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 15 May 2015, NeilBrown wrote:

> Some storage devices don't handle suspend as well as they should and lose
> requests resulting in corruption.  They should obviously be fixed, but it is
> you who gets the problem reports and you are not in a position to fix them.
> So you want a general solution that hides those problems.
> sys_sync at suspend time is a sort-of solution because it flushes and waits
> so there  is less in-flight IO immediately after a sys_sync and so less
> opportunity for a bad device to stuff up.
> But you seem to suggest that sys_sync isn't a complete solution and it
> doesn't guarantee that xfs is not doing some background metadata IO.
> 
> Maybe a sensible thing to do would be to hook the "disk" devices into suspend
> and have them flush their queue and possibly send a CACHE_FLUSH command.
> That would provide more of a guarantee for you, and less of a cost for Len,
> would it not?

The sd driver already does this.

Alan Stern

