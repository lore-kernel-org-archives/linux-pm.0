From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 12:03:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503241149000.1345-100000@ida.rowland.org>
References: <Pine.LNX.4.50.0503231827310.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32632521414096116=="
In-Reply-To: <Pine.LNX.4.50.0503231827310.15119-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============32632521414096116==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 23 Mar 2005, Patrick Mochel wrote:

> On Wed, 23 Mar 2005, Alan Stern wrote:
> 
> > So what's wrong with changing it into:
> >
> > 	void suspend_to_ram()
> > 	{
> > 		lock all devices
> > 		suspend all devices
> > 		turn off main power
> > 		/* Zzzz... */
> > 		resume all devices
> > 		unlock all devices
> > 	}
> >
> > the possibility of devices being removed or added while the PM core is
> > traversing its lists.  Locking does protect against that -- or rather, it
> > will once the mechanisms have been added to the driver model core.
> 
> That would add a lot of complication. You never want to add more locks
> than you need to.

The semaphores themselves are required for other reasons, but I take your
point.  You never want to lock more items than you need to.

>  Without locking, each suspend operation is a single
> discete action with no dependencies on anything else. Having to lock every
> device now intertwines them all in a very complicated and disgusting
> manner.

Actually the locking rule is quite simple and elegant: Never lock a 
device while holding a descendant's lock.

>  It would make it potentially very hard to debug and add a lot of
> time to the process.

Hard to debug, maybe... we can't tell without actually trying.  Adding a
lot of time to the suspend process, no.  Acquiring the locks would block
only for things that should cause you to block anyway, like trying to
suspend a device while it's being probed.

(Or did you mean it would add a lot of time to the development process?  I 
doubt it, but it would force people to think about issues they would 
prefer to ignore.)

> Note that you're locking ideas are at least original, but I'm having a
> harder and harder time taking them seriously without any code. I highly
> recommend that you at least try to codify the locking changes before
> making suggestions. It will weed out a lot of under-cooked ideas and get
> us a lot closer to a workable solution. As Linus would say "Show me the
> code!"

A large part of the concept is already coded up and part of the kernel
since about 2.6.9, and it works quite well.  Its scope is currently
restricted to the USB layer; I'm proposing to make it more general.

In fact at this stage it's more a matter for discussion under the topic 
of driver-model development, so I'm going to stop talking about it on 
linux-pm.  You indicated that you had some relevant driver-model patches 
-- would you like to send them to me?

Alan Stern


--===============32632521414096116==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32632521414096116==--
