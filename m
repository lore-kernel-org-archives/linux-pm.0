From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 10:32:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505151031130.1295-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1505151019470.1295-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1505151019470.1295-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 May 2015, Alan Stern wrote:

> On Fri, 15 May 2015, NeilBrown wrote:
> 
> > Some storage devices don't handle suspend as well as they should and lose
> > requests resulting in corruption.  They should obviously be fixed, but it is
> > you who gets the problem reports and you are not in a position to fix them.
> > So you want a general solution that hides those problems.
> > sys_sync at suspend time is a sort-of solution because it flushes and waits
> > so there  is less in-flight IO immediately after a sys_sync and so less
> > opportunity for a bad device to stuff up.
> > But you seem to suggest that sys_sync isn't a complete solution and it
> > doesn't guarantee that xfs is not doing some background metadata IO.
> > 
> > Maybe a sensible thing to do would be to hook the "disk" devices into suspend
> > and have them flush their queue and possibly send a CACHE_FLUSH command.
> > That would provide more of a guarantee for you, and less of a cost for Len,
> > would it not?
> 
> The sd driver already does this.

Sorry -- I meant that it does send a SYNCHRONIZE CACHE command.  It 
doesn't flush the I/O queue.

Alan Stern
