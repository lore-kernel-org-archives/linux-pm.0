From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 09:51:47 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503240949410.13683-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503241149000.1345-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503240904570.13683-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============093500188096171222=="
In-Reply-To: <Pine.LNX.4.50.0503240904570.13683-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
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

--===============093500188096171222==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 24 Mar 2005, Patrick Mochel wrote:

>
> On Thu, 24 Mar 2005, Alan Stern wrote:
>
> > On Wed, 23 Mar 2005, Patrick Mochel wrote:
>
> > >  It would make it potentially very hard to debug and add a lot of
> > > time to the process.
> >
> > Hard to debug, maybe... we can't tell without actually trying.  Adding a
> > lot of time to the suspend process, no.  Acquiring the locks would block
> > only for things that should cause you to block anyway, like trying to
> > suspend a device while it's being probed.
>
> It would change the locking from an O(1) operation to an O(n) operation,
> where n is the number of devices. Taking any lock is not cheap, so taking
> N locks, when is N is large is going to be grossly inefficient.

Ok, I'm a hypocrit. :)

The first patch in the series that I posted adds a semaphore to struct
device that is taken before each driver operation, including suspend and
resume. It is dropped, though, when the operation is complete. I think
that's the right way to do it, and I'm interested to hear if that will
work for what you guys want to do.

I *do* realize that it is equivalent in terms of time spent acquiring and
releasing locks that I bashed above. I will eat my words now.

Thanks,


	Pat


--===============093500188096171222==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============093500188096171222==--
