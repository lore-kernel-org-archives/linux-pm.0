From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Mon, 10 Dec 2007 12:57:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712101247120.5111-100000@iolanthe.rowland.org>
References: <200712092110.23528.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712092110.23528.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Dec 2007, David Brownell wrote:

> > > FWIW the appended patch removes that rude "order of registration"
> > 
> > "Rude"?  What's rude about it?  It seems most logical to me: Since the
> > devices obviously worked in the intermediate stages of registration,
> > ...
> 
> Rude because it keeps things implicit which should be explicit.

Your patch isn't really much better (IMHO).  While its order may be
less "random" in the sense that it is determined by the device tree,
the tree itself is somewhat random and not fully determined by the
physical hardware layout.  It is affected by the order in which drivers
are loaded, or the order in which PCI cards are probed, and so on.

And in any case, having a fixed order doesn't move us any closer to the 
goal of making all the dependencies explicit.

> Such a random visitation seems like a clear problem when a
> goal is to introduce parallelism ...

So does a strict depth-first visitation.  Or indeed, any fixed 
ordering, since parallelism will involve indeterminacy.

> Nope; what we need is the ability to finger "this specific device
> has dependencies that aren't explicit".  Being able to introduce
> random failures isn't really helpful.  It's the difference between
> being able to use lockdep vs. having to wait until a random locking
> failure crops up in a way that can usefully be diagnosed.

I agree.  Even better would be to say "this specific device has this 
specific dependency".  But it's not easy to come up with strategies for 
finding this information.  There's no clear-cut analog to lockdep.

Alan Stern
