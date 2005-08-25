From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Toward runtime power management in Linux
Date: Thu, 25 Aug 2005 11:27:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508251107280.4918-100000@iolanthe.rowland.org>
References: <1124939576.7876.4.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33036470774906368=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1124939576.7876.4.camel@gaston>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Brown, Len" <len.brown@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============33036470774906368==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 25 Aug 2005, Benjamin Herrenschmidt wrote:

> > Recursion: A consequence of doing things this way is that the
> > notifications can potentially use a lot of stack space as they
> > progress up the device tree.  (I can't think of any simple
> > non-recursive technique for implementing the scheme.)  Fortunately
> > this probably won't be too bad; the notifications will stop when they
> > reach a device that doesn't want to change its state (because it has
> > other children).  So the recursion should not involve too many levels.
> > Still, it is something to watch out for.
> 
> I think the locking is unmanageable if we do synchronous notification. I
> think devices should issue a "request for link state change" and be
> asynchronously notified of the actual change, though they might be
> allowed to block if they are doing that from process and/or probe()
> context (most of the time). I think the actual tree walking should be
> done by a separate thread. That simplifies locking tremendously by
> suppressing most deadlock conditions.

But it complicates the structure of drivers by forcing them to use a
state-machine approach with a bunch of tedious intermediate states ("link
change request issued, waiting for notification").  It also introduces
complications from the possible arrival of several change requests or
notifications at once, since there's no locking to guarantee mutual
exclusion among them.

> Another problem is the whole racyness of tree & list walking vs.
> add/remove. We try to work around it in various ways that I think can't
> work. See the small thread about pci_walk_bus() on lkml that exposes
> that kind of races vs. device removal. I think we really need to
> indroduce proper iterator objects that get notified on removal.
> 
> Racing with device addition is a different issue altogether. It means we
> may add devices to already-walked part of the tree, thus have
> inconsistent states... unless drivers are made properly aware that the
> link state may not be full-on at probe time and deal with that.

I think these races can be handled without too much trouble.  Consider the 
two cases you mentioned.

	Device addition racing with parent suspend: adding a device to
	an already-suspended parent.  The parent's driver should be
	written in such a way that it hold's the parent's PM lock
	while determining that a new child has been found.  If the parent
	is capable of detecting a new child while suspended, then it
	should also be capable of adding the child device.  If it's not
	capable of detecting new children while suspended then the issue
	doesn't arise.

	Device removal racing with power state changes.  During device
	removal the PM lock should be held; this will prevent the two
	operations from overlapping.  You might end up trying to carry
	out a power-state change on an already-removed device; that's
	not a problem -- it will simply fail.


On Thu, 25 Aug 2005, Brown, Len wrote:

> >I think the locking is unmanageable if we do synchronous
> >notification.
>
> Hmmm, good point.
> But how frequent do we expect walks and add/remove to be?
> If they almost never happen then it sounds like over-design
> to have more than a single lock.

RTPM changes won't be terribly frequent.  But add/remove, while maybe not
very frequent in an average sense, do occur in clusters.  The lock you're
proposing would end up being a single chokepoint for all devices.  That's
exactly the sort of thing removal of the bus subsystem's rwsem was
intended to eliminate.

Alan Stern


--===============33036470774906368==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33036470774906368==--
