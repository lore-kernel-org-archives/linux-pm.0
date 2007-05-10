From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Thu, 10 May 2007 11:17:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705101115310.3498-100000@iolanthe.rowland.org>
References: <200705091321.39991.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705091321.39991.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 May 2007, David Brownell wrote:

> > > > From the user's point of view, the differences between S4 and S5 amount to
> > > > just these: power consumption and availability of wakeup devices.
> > > 
> > > And the fact that in S4 there's always a resumable OS image.

> > What happens if the OS writes a resumable OS image and goes into S4, and 
> > then the user unplugs the computer, plugs it back in, and turns the power 
> > switch on?  At that point the system must be in S5 (by definition), but 
> > there's still a resumable image.
> 
> As allowed by the chapter 2 text I pointed out earlier.
> S4 *always* has such an image.

So the correct statement is that S4 always has a resumable OS image and S5
may have a resumable image.  From a user's point of view that doesn't
sound like much of a difference, especially since the image can be 
successfully restored from either state.

Alan Stern
