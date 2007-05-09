From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Wed, 9 May 2007 13:21:39 -0700
Message-ID: <200705091321.39991.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705091556520.8586-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705091556520.8586-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

> > > From the user's point of view, the differences between S4 and S5 amount to
> > > just these: power consumption and availability of wakeup devices.
> > 
> > And the fact that in S4 there's always a resumable OS image.
> 
> Are you sure?  What happens if the OSPM writes a defective, non-resumable 
> OS image and then goes into S4?

The ACPI spec omits all such error transitions.  As well as
a fair number of non-error ones ... like how to enter G3.


> What happens if the OS writes a resumable OS image and goes into S4, and 
> then the user unplugs the computer, plugs it back in, and turns the power 
> switch on?  At that point the system must be in S5 (by definition), but 
> there's still a resumable image.

As allowed by the chapter 2 text I pointed out earlier.
S4 *always* has such an image.

- Dave
