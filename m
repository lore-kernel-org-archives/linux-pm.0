From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Wed, 9 May 2007 16:04:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705091556520.8586-100000@iolanthe.rowland.org>
References: <200705091235.05613.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705091235.05613.david-b@pacbell.net>
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

> > 			In fact, it is the state the computer enters 
> > 	when you first plug it in (or insert the battery).
> 
> No; again, you're missing the entire point of G3 "mechanical off".
> 
> When you first plug it in, it's going to be in G3.  Then you turn
> on the power switch.  Then you press the "on/off" button.
> 
> From then on you can use only the "on/off" button, but the system
> is vampiric ... when off/dead, it can choose to come alive, and is
> always sucking power/blood at a low level.
> 
> But the "large red switch" option is available to put the system
> into G3 ... driving a bloody stake through its heart, so it can't
> re-activate itself at midnight, and preventing constant power drain.

Sorry.  What I meant to say was that S5 is the state the computer enters 
when you first plug it in and turn on the power switch -- before you press 
the on/off button.

> > From the user's point of view, the differences between S4 and S5 amount to
> > just these: power consumption and availability of wakeup devices.
> 
> And the fact that in S4 there's always a resumable OS image.

Are you sure?  What happens if the OSPM writes a defective, non-resumable 
OS image and then goes into S4?

What happens if the OS writes a resumable OS image and goes into S4, and 
then the user unplugs the computer, plugs it back in, and turns the power 
switch on?  At that point the system must be in S5 (by definition), but 
there's still a resumable image.

Alan Stern
