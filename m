From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 18:35:30 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231827310.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503231544550.631-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39485687750160325=="
In-Reply-To: <Pine.LNX.4.44L0.0503231544550.631-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

--===============39485687750160325==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, Alan Stern wrote:

> So what's wrong with changing it into:
>
> 	void suspend_to_ram()
> 	{
> 		lock all devices
> 		suspend all devices
> 		turn off main power
> 		/* Zzzz... */
> 		resume all devices
> 		unlock all devices
> 	}
>
> I agree that your single-semaphore idea would also work to prevent
> unwanted resumes during a system sleep.  But it doesn't protect against
> the possibility of devices being removed or added while the PM core is
> traversing its lists.  Locking does protect against that -- or rather, it
> will once the mechanisms have been added to the driver model core.

That would add a lot of complication. You never want to add more locks
than you need to. Without locking, each suspend operation is a single
discete action with no dependencies on anything else. Having to lock every
device now intertwines them all in a very complicated and disgusting
manner. It would make it potentially very hard to debug and add a lot of
time to the process.

Note that you're locking ideas are at least original, but I'm having a
harder and harder time taking them seriously without any code. I highly
recommend that you at least try to codify the locking changes before
making suggestions. It will weed out a lot of under-cooked ideas and get
us a lot closer to a workable solution. As Linus would say "Show me the
code!"

Take this from someone that has had to make provably correct shotgun
locking changes to code already in the kernel to appease a screaming Al
Viro (whose usual statement is something along the lines of only "There's
a race in function foo(). You idiot."), and a host of people that believe
his word as gospel by default.

Thanks,


	Pat

--===============39485687750160325==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39485687750160325==--
