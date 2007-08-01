From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Wed, 1 Aug 2007 16:27:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708011619050.3174-100000@iolanthe.rowland.org>
References: <200708012125.15755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708012125.15755.rjw@sisk.pl>
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

On Wed, 1 Aug 2007, Rafael J. Wysocki wrote:

> > > (The whole list based on registration order thing seems a bit fragile
> > > to me, but I don't know enough of the PM core and suspend/resume in
> > > general to make a better suggestion :/)
> > 
> > It hasn't been bad in the past.  If A was discovered before B then ipso 
> > facto it is safe to suspend B before suspending A.  Likewise, in the 
> > absence of device_move, if A was discovered before B then A cannot 
> > appear below B in the device tree.  Of course, this assumes devices are 
> > registered as they are discovered.
> 
> Which is a weak assupmtion ...
> 
> Well, we seem to have some examples of possible situations in which the
> design might not be adequate and that's alarming.
> 
> Perhaps we should create dpm_active right before the suspend, by really
> traversing the device tree, when we own all device semaphores and no device
> objects can be added/removed?

We're doing okay the way things are.  Changing the order is more likely
to cause new problems than to solve existing ones.

In fact, I would go even farther.  Let's document the ordering given by
dpm_active (by default, in order of registration) so that drivers can
depend on it, and let's add special routines to change the order for
the few cases that require it -- under driver control.

A "move to the end" routine would solve the EHCI issue.  It ought to 
solve the problems associated with device_move() also, provided the 
device being moved doesn't have any children.

Cornelia and Marcel, is that the case?  When a ccw_device or RFCOMM TTY 
is reparented under a new device, do any children get moved along with 
it?

Alan Stern
