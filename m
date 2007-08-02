From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 10:24:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708021020370.3611-100000@iolanthe.rowland.org>
References: <200708021321.25603.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708021321.25603.rjw@sisk.pl>
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

> > > Perhaps we should create dpm_active right before the suspend, by really
> > > traversing the device tree, when we own all device semaphores and no device
> > > objects can be added/removed?
> > 
> > We're doing okay the way things are.  Changing the order is more likely
> > to cause new problems than to solve existing ones.
> 
> Well, my idea is not to change the order, but to create the list from scratch
> when we need it and not in advance, because creating the list in advance
> causes problems to appear.

Doing it that way will almost certainly result in a different order 
from the one we have now.  And it won't help the EHCI issue, because 
there the question is which of several siblings should come last.

> In fact, if the system is never suspended, the list that we create is not even
> useful for anything.

True.  But it doesn't take up much space, especially if PM isn't 
configured.  And creating the list doesn't take much time.

Alan Stern
