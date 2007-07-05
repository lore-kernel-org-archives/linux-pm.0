From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Fri, 06 Jul 2007 08:59:52 +1000
Message-ID: <1183676393.3388.89.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707051014180.3728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707051014180.3728-100000@iolanthe.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-07-05 at 10:23 -0400, Alan Stern wrote:
> 
> How will that help?  Block the kernel thread in the freezer or block it 
> in the driver -- either way it is blocked.  So how do your deadlocks 
> get resolved?

Because nobody is waiting on that kernel thread anyway without a freezer
so there is no deadlock anymore.

> I disagree with your analysis -- not that it's completely wrong, but it 
> points out an existing basic problem in the kernel.  The kernel should 
> never depend on userspace!  More correctly, a task executing in the 
> kernel should never block with any sort of mutex or other lock held (in 
> a way that would preclude it from being frozen, let's say) while 
> waiting for a response from userspace.
> 
> Then the dependency graph would be easy to construct: User tasks can
> depend on whatever they want, and kernel threads never depend on a user
> task.

In an idea world, there would be no hunger...

> If this contradicts the existing implementations and APIs for userspace 
> filesystems, then so be it.  My conclusion would be that the 
> implementations and APIs should be changed.

Why are you guys working so hard and spending so much energy to try to
avoid doing the right thing is beyond my understanding...

> It _does_ apply to kernel threads.  That's exactly why I wrote above 
> that kernel threads which try to do I/O during a suspend will need 
> extra attention.

Ok none at all if you don't have a freezer.

Ben.
