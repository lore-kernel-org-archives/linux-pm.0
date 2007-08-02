From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 13:21:25 +0200
Message-ID: <200708021321.25603.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0708011619050.3174-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708011619050.3174-100000@iolanthe.rowland.org>
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

On Wednesday, 1 August 2007 22:27, Alan Stern wrote:
> On Wed, 1 Aug 2007, Rafael J. Wysocki wrote:
> 
> > > > (The whole list based on registration order thing seems a bit fragile
> > > > to me, but I don't know enough of the PM core and suspend/resume in
> > > > general to make a better suggestion :/)
> > > 
> > > It hasn't been bad in the past.  If A was discovered before B then ipso 
> > > facto it is safe to suspend B before suspending A.  Likewise, in the 
> > > absence of device_move, if A was discovered before B then A cannot 
> > > appear below B in the device tree.  Of course, this assumes devices are 
> > > registered as they are discovered.
> > 
> > Which is a weak assupmtion ...
> > 
> > Well, we seem to have some examples of possible situations in which the
> > design might not be adequate and that's alarming.
> > 
> > Perhaps we should create dpm_active right before the suspend, by really
> > traversing the device tree, when we own all device semaphores and no device
> > objects can be added/removed?
> 
> We're doing okay the way things are.  Changing the order is more likely
> to cause new problems than to solve existing ones.

Well, my idea is not to change the order, but to create the list from scratch
when we need it and not in advance, because creating the list in advance
causes problems to appear.

In fact, if the system is never suspended, the list that we create is not even
useful for anything.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
