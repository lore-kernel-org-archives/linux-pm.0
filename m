From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Possible problem with device_move()
Date: Fri, 3 Aug 2007 23:39:31 +0200
Message-ID: <200708032339.32161.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0708031042440.2597-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708031042440.2597-100000@iolanthe.rowland.org>
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 3 August 2007 16:56, Alan Stern wrote:
> On Fri, 3 Aug 2007, Rafael J. Wysocki wrote:
> 
> > > > Why not?  If the device can indicate something like "place me after that one"
> > > > to the code creating the list, we can handle that too. 
> > > 
> > > Yes, but currently we don't have any way of indicating that.  And if we 
> > > did, it work work just as well with the current dpm_active list, right?
> > 
> > Well, I don't know. :-)
> > 
> > It seems the problem is _exactly_ that we have no means to represent the
> > dependencies between devices other than the order of registration and/or
> > the parent-child relationships.
> 
> Yes.
> 
> > Now, the simplest things that comes to mind is to do what we're doing (ie.
> > use the order of registration) with a modification allowing the exceptional
> > devices to have a "please move me to the end of list" flag set.  The PM core
> > would then browse the list during suspend and move the devices marked like
> > this to the end of dpm_active along with their children, if need be.
> 
> Code is more flexible than flags.  Why not export a function drivers
> can call, or better yet, a handful of functions to do different things?  

Yes, we can do that.

> It ought to suffice for drivers to call them during probing or
> registration, rather than every time the system is suspended.  They
> also could be called after device_move() -- and to prevent races we
> should export pm_sleep_[un]lock().

Yes, we should.

> Suggested functions:
> 
>      1. Move A in front of B, together with all of A's ancestors which
> 	aren't already ahead of B (or maybe require that A's parent be
> 	ahead of B already).
> 
>      2. Move device A to the end (A must not have any children).
> 
> Anything else?

Nothing more comes to mind at the moment.

> I think this will cover all the cases we currently are concerned about.

I agree.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
