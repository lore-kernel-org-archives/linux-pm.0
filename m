From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 10:58:54 -0800
Message-ID: <200503231058.54311.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<1111465290.27490.34.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============87589283797929496=="
In-Reply-To: <1111465290.27490.34.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============87589283797929496==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 21 March 2005 8:21 pm, Benjamin Herrenschmidt wrote:
> 
> Yup, the model we are desinging now should allow for arbitrary
> transitions I suppose as long  as the target state is legal vs. the
> dependencies.

Leading to the question:  how are the dependencies identified and
enforced?

My current thought is that it's wrong to expect the PM core code to
do all this.  Discussion on this list strongly suggests to me that
we'll never achieve a Grand Unified Theory of PM into which every
device, bus, platform, and board will fit ... unless we give up
on the notion that _everything_ be centrally controlled.  The key
will be having good ways to delegate all the important issues.

So for example it would make sense to have device suspend() logic
verify any dependencies for the target state, and then just fail
cleanly if they're not satisfied.

That'll mostly be an issue for bridge drivers ... like PCI
bridges, host adapters for things like USB, hubs, and so on.
But it also shows a way to handle custom hardware, which may
not be as regular as the PC and server centric developers want
the world to be...


> > The simplest way of handling this is to allow explicitly for such
> > possibilities.  When a device is asked to go from a very-low-power state
> > to a slightly-low-power state, it should be legal for the driver to leave
> > it in the very-low-power state.
> 
> Well... I'm not sure about that one. If the power states represent some
> performance states, the system may want to raise the performance a bit
> at the expensve of power and would stay low perf unless a full
> transition to state "full on" is done ?
> 
> I suspect it's a per driver responsibility here. I suppose common sense
> will dicate what can be allowed and what not.

I'm happy with per-driver responsibilities.  Less so with the notion
of conflating power states and performance modes; they seem a bit more
orthogonal to me.

On the other hand, I've also described the role of a driver suspend()
call as just picking one of potentially many device power states that
are compatible with the target (system) state, and I think there's
common ground there.  If the "very low" device power state is compatible,
nobody should care ... because the request to the driver should have been
"become compatible with this system power state", and only in unusual
cases (sysfs requests) "go into this device power state".

So, two types of request to drivers then.  The main one would be to
become compatible with a given system power state; flexible.  The
inflexible one would be to go into a specific device power state.



> One thing that is important if we deal with partial suspend and tree
> dependencies is the ordering...
> 
> When a device is asked to enter a given state, the dependencies of the
> childs has to be checked in a different order if we are going to lower
> power than if we are going to higher power.
> 
> If going to lower power (that is toward suspend), we must check the
> dependencies of childs and eventually low-power them before the parent
> is actually state changed.
> 
> If going to higher power, it is the opposite.

The handful of drivers that deal with dependencies can be responsible
for that ordering.  They should be able to delegate much of the work
to PM core code (else why have a PM core?).


> So I think we need to have the states in some sort of order at least so
> the core has a notion of what is "lower" and what is "higher" power to
> deal with that. Though I suppose we could also have optional hooks in
> driver (pre-parent-change and post-parent-change) for driver who want to
> be sneaky, but that gets nasty and complicated.

I suspect that having all device states in some sort of order like that
is a problem isomorphic with the Grand Unified Theory of PM, which I
said we shouldn't try to derive.

If the drivers that deal with dependencies -- "bridge" drivers, for
now -- can tell the PM core what to do with a given device (before
me, after me, skip it) the PM core could just ask those bridge drivers
to build a list, then walk the list issuing the right calls.  Instead
of having a single global list, build it on demand.

- Dave

--===============87589283797929496==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============87589283797929496==--
