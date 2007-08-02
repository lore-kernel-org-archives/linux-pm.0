From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 10:19:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708021012410.3611-100000@iolanthe.rowland.org>
References: <20070802100633.2bd6f72c@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070802100633.2bd6f72c@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Aug 2007, Cornelia Huck wrote:

> > A "move to the end" routine would solve the EHCI issue.  It ought to 
> > solve the problems associated with device_move() also, provided the 
> > device being moved doesn't have any children.
> 
> The device drivers need to be given more control; they could just walk
> the children list in this case then.

Come to think of it, "move to the end" won't solve the EHCI issue.  I 
would need a "move A up so that it comes before B" routine.  For this 
special case we wouldn't need to worry about ancestors of A because A 
and B will have the same parent, but in general A's ancestors would 
have to be moved also.  That's a little worrisome because the ancestors 
might have dependencies of their own.

> > Cornelia and Marcel, is that the case?  When a ccw_device or RFCOMM TTY 
> > is reparented under a new device, do any children get moved along with 
> > it?
> 
> Hm, device_move() just drags around the children with it (and
> ccw_devices may have children as added by the driver; zfcp does that,
> for example).

So you would want to move the sub-channel plus its ancestors in front
of the ccw_device, right?  Can you think of a safe way to satisfy 
everybody?

Alan Stern
