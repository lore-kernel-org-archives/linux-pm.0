From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 10:36:41 +1100
Message-ID: <1111534601.16201.27.camel@gaston>
References: <Pine.LNX.4.44L0.0503221143460.954-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2629198055681119=="
In-Reply-To: <Pine.LNX.4.44L0.0503221143460.954-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============2629198055681119==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-03-22 at 12:04 -0500, Alan Stern wrote:

> We can enforce the system sleep states by device locking as described 
> above.  For STD no enforcement is needed, because no processes other than 
> the PM thread will be running.  (Except for things with PF_NOFREEZE -- 
> they are in a position to cause some trouble.)

I'm not fan of this "locking" concept... Well, we are effectively
locking the PM state of the device, true, but I'm not sure it should act
as a lock, it should rather reject transitions no ? Or maybe you are
right, and we should just have a high level lock set when starting
STD/STR that blocks any user originated action ?
 
> 
> > If the driver is in a user-originated or idle-originated "suspend" state
> > (with auto-wakeup on activity) and gets a FREEZE (or another SUSPEND)
> > from the system, it must make sure not to auto-wakeup anymore from that
> > state. There is a bit of policy to implement here, and I'm not sure how
> > much of that can be put in the core to help drivers, and how much has to
> > remain driver specific.
> 
> Locking should take care of this, once it's available.

I'm not sure, but maybe ... I need to think about this "locking" concept
a bit more.

> I'm not sure either.  I guess we shouldn't worry about adding these flags 
> unless it becomes clear that they are needed.

Agreed.

> > So I think we need to have the states in some sort of order at least so
> > the core has a notion of what is "lower" and what is "higher" power to
> > deal with that. Though I suppose we could also have optional hooks in
> > driver (pre-parent-change and post-parent-change) for driver who want to
> > be sneaky, but that gets nasty and complicated.
> 
> I agree.  This is the sort of boilerplate computation that is best done in
> one single place -- the PM core.  Unfortunately it means that the core has
> to understand what combinations of parent-state/child-state are legal.  I
> don't know how that knowledge can best be represented.

Well, I had this idea of expressing dependencies with bitmasks of
states, that is a device would express for each state what parent states
it is compatible with (since parent states are de-facto bus-states, it
is ok for a device to know the semantics of the bus it's living on. PCI
busses (and thus parent -> pci bridges) will have a well defined set of
states, only leaf devices can have 'fancy' states).

EIther that, or we need more callbacks for validating states, but I'm
afraid that would become a mess... Most devices will only have 2 states
anyway, and we can probably provide shortcut macros for defining simple
2 state tables which will make things easy for most drivers.

Ben.



--===============2629198055681119==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2629198055681119==--
