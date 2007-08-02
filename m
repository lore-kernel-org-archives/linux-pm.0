From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 11:23:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708021114240.2573-100000@iolanthe.rowland.org>
References: <200708021658.12991.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708021658.12991.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Aug 2007, Rafael J. Wysocki wrote:

> > > Well, my idea is not to change the order, but to create the list from scratch
> > > when we need it and not in advance, because creating the list in advance
> > > causes problems to appear.
> > 
> > Doing it that way will almost certainly result in a different order 
> > from the one we have now.
> 
> Yes, but wouldn't that order be more accurate?

I'm not so sure.  There might be hidden dependencies, things we aren't
aware of because they are automatically satisfied by
order-of-discovery.  With an arbitrary parent-first traversal of the
device tree those dependencies could be violated.

And then there are the weird possibilities created by device_move().  
Isn't it possible that if an older child is moved under a younger 
parent, we actually might _want_ to suspend the parent first?  Only the 
driver doing the move would know for sure.

> > And it won't help the EHCI issue, because there the question is which of
> > several siblings should come last. 
> 
> Why not?  If the device can indicate something like "place me after that one"
> to the code creating the list, we can handle that too. 

Yes, but currently we don't have any way of indicating that.  And if we 
did, it work work just as well with the current dpm_active list, right?

Alan Stern
