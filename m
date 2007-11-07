From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 7 Nov 2007 11:47:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711071146550.4444-100000@iolanthe.rowland.org>
References: <1194450893.4470.51.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194450893.4470.51.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Nov 2007, Johannes Berg wrote:

> > The icebox would still be useful, however, for user tasks that try to
> > do I/O after a system-sleep transition has begun.  Right now this can't
> > happen, thanks to the freezer (except that it _can_ happen on PPC where
> > the freezer isn't used for suspend).  Once the freezer no longer
> > affects user tasks, kernel drivers will have to do _something_ when a
> > user task submits an I/O request during a system sleep.  That
> > "something" will be to go to the icebox.
> 
> Right, ok. I wish I could change powerpc, I've been maintaining a patch
> for months now, but Paul seems to be dead set against it. Not only does
> that fix these things, but also we get to use the /sys/power/state
> API...

This is just the start.  Nothing will _really_ get fixed until lots of 
drivers actually begin to use the icebox.

Alan Stern
