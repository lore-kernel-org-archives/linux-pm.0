From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
 and hibernation callbacks
Date: Thu, 20 Mar 2008 10:45:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803201037590.9468-100000__8603.89427184618$1206024532$gmane$org@netrider.rowland.org>
References: <1205984008.26869.408.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1205984008.26869.408.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Mar 2008, Benjamin Herrenschmidt wrote:

> > An important point I tried to make in the earlier email is that drivers
> > will want a simple way to know when it is illegal for them to register
> > new children.  For example, suppose the registration is done by a
> > workqueue routine.  The most reliable way for the driver to insure that
> > the routine won't try to register new children improperly is to have
> > the routine check a flag which gets set _before_ prepare() is called.
> 
> I don't totally agree here. Drivers could have their own flag set
> internally with appropriate locking. The problem with your approach is
> locking. Just setting a flag is mostly useless, -unless- there
> appropriate locking between setter and testers. 

I didn't mention locking because it seemed obvious that locking is
needed.  Of course a flag alone is mostly useless.

But we already _do_ have a lock (dev->sem) and we _don't_ have a flag.  
I was pointing out that some drivers will want to have a flag added.
Maybe so many drivers will want it that the flag should be added to the
PM structure, where it will be available for every device.  If only a
few drivers want this new flag, then yes, they can put it in their
private data structures.

> However, I think this is mostly a non-issue, because the core _does_
> provide something here that is useful for drivers who don't want to
> bother with the above: The failure return from device_add. If drivers
> don't want to do something akin to what I described, they can just be
> made to deal gracefully with the failure from device_add that would
> happen due to the core internal flag being set after the return from
> prepare().

Relying on a registration failure to handle this sort of thing is _not_
a good idea.  For example, how would the driver distinguish failure
caused by impending suspend from other sorts of failure?

Alan Stern
