From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 09:13:35 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503240904570.13683-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503241149000.1345-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14437404686112076=="
In-Reply-To: <Pine.LNX.4.44L0.0503241149000.1345-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

--===============14437404686112076==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 24 Mar 2005, Alan Stern wrote:

> On Wed, 23 Mar 2005, Patrick Mochel wrote:

> >  It would make it potentially very hard to debug and add a lot of
> > time to the process.
>
> Hard to debug, maybe... we can't tell without actually trying.  Adding a
> lot of time to the suspend process, no.  Acquiring the locks would block
> only for things that should cause you to block anyway, like trying to
> suspend a device while it's being probed.

It would change the locking from an O(1) operation to an O(n) operation,
where n is the number of devices. Taking any lock is not cheap, so taking
N locks, when is N is large is going to be grossly inefficient.

> (Or did you mean it would add a lot of time to the development process?  I
> doubt it, but it would force people to think about issues they would
> prefer to ignore.)

Uh, I hadn't thought about it, but yes, that's true as well. While in
theory it's good to make people think about what they're doing, you want
to make things as simple as possible for people to implement ("Make it
impossible to get wrong."). Especially for driver writers, who typically
have the least experience with the Linux kernel, and in many cases, very
little experience with multi-processor systems and race conditions.

[ Note that it's still easy to get things wrong in the driver model, but
that's specifically where the effort is going - to make it harder to mess
up. ]

> > Note that you're locking ideas are at least original, but I'm having a
> > harder and harder time taking them seriously without any code. I highly
> > recommend that you at least try to codify the locking changes before
> > making suggestions. It will weed out a lot of under-cooked ideas and get
> > us a lot closer to a workable solution. As Linus would say "Show me the
> > code!"
>
> A large part of the concept is already coded up and part of the kernel
> since about 2.6.9, and it works quite well.  Its scope is currently
> restricted to the USB layer; I'm proposing to make it more general.

Really? And it works well? Greg, David? What do you guys think of it?

> In fact at this stage it's more a matter for discussion under the topic
> of driver-model development, so I'm going to stop talking about it on
> linux-pm.  You indicated that you had some relevant driver-model patches
> -- would you like to send them to me?

I apologize, I assumed you had seen them. You can find them here:

http://article.gmane.org/gmane.linux.kernel/289092

specifically the klist patch:

http://article.gmane.org/gmane.linux.kernel/289090


	Pat

--===============14437404686112076==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14437404686112076==--
