From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 17:17:44 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503221709080.16154-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503221143460.954-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8898764083770403=="
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

--===============8898764083770403==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 22 Mar 2005, Alan Stern wrote:

> When per-device locking gets added to the driver model, this can be
> handled by making the PM core lock all devices before starting STR and
> unlock them all after waking up.  Then any user process trying to resume a
> device in the middle will block until the system is fully awake.

That's not a sane design. You do not want 1 function locking and another
unlocking. That's trouble waiting to happen. We can solve that problem
today using a single semaphore to synchronize all PM calls. If a runtime
PM request comes in while a system PM request is being processed, that
process will block until the semaphore is dropped (when the system is
resumed). It will serialize all runtime PM calls, but those are not
performance-critical operations, and it shouldn't matter too much.

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

This shouldn't go in the core. The core cannot keep track of every
parent/child power state possibility. That sounds like a nightmare. It's
up to the driver for the parent (i.e. bridge device) to know and
understand. If anything, we could provide a child_suspended() method to
the parent drivers. But, I think even that is a hack. We just need a
simple mechanism for parents to monitor the power state of their children.
Can't be that hard to come up with something clean.


	Pat

--===============8898764083770403==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8898764083770403==--
