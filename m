From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 16:50:24 +0200
Message-ID: <20070802165024.09cd6a13@gondolin.boeblingen.de.ibm.com>
References: <20070802100633.2bd6f72c@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0708021012410.3611-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708021012410.3611-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Aug 2007 10:19:32 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Come to think of it, "move to the end" won't solve the EHCI issue.  I 
> would need a "move A up so that it comes before B" routine.  For this 
> special case we wouldn't need to worry about ancestors of A because A 
> and B will have the same parent, but in general A's ancestors would 
> have to be moved also.  That's a little worrisome because the ancestors 
> might have dependencies of their own.

In bad cases, we would need to touch the whole tree. This sounds like
people are likely to mess the tree up if given the power :(

> So you would want to move the sub-channel plus its ancestors in front
> of the ccw_device, right?  Can you think of a safe way to satisfy 
> everybody?

Unless I'm confused, I would need to have the order
(children of ccw_device) -> ccw_device -> subchannel -> channel_subsystem,
no? (Note that currently all subchannels are children of the same
channel subsystem.)

Correct order for moved devices could be most easily obtained by
Rafael's suggestion of generating the list just before it is needed;
but as this doesn't help with other dependencies, we would additionally
need a way to specify those at device registration time (or when it is
already registered), which doesn't sound like a terribly good solution
either...
