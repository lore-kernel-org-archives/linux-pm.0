From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Wed, 16 Mar 2005 23:11:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503162259320.7210-100000@netrider.rowland.org>
References: <200503161350.02426.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45124693447411812=="
In-Reply-To: <200503161350.02426.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============45124693447411812==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 16 Mar 2005, David Brownell wrote:

> > Wether the system IRQs must be masked or not is one thing that is
> > platform specific during suspend. Wether devices must stop their IRQ
> > emission, well... 
> 
> What's a "system IRQ" as opposed to any other kind?  Drivers don't
> generally know or care how their IRQs are routed, they just care
> that they get a callback.

Given that on some platforms it's necessary to leave some IRQs enabled for 
remote wakeup to work, the definitions of FREEZE and SUSPEND need to be 
changed.  A quiesced device does not perform DMA and does not generate 
interrupt requests _except_ that it may issue wakeup requests (which may 
be IRQs) if it is enabled for remote wakeup.

I don't think this will cause any problems for Suspend To Disk.  If a 
wakeup IRQ arrives before the system is asleep and is fielded by an 
interrupt handler, the handler will try to start a resume.  But resume 
needs a process context to operate, and all processes will be frozen -- so 
nothing will happen.

The case of Suspend To Ram, where processes may not be frozen, can be
solved by suitable device locking.  If the PM core locks all devices
before initiating the sleep transition -- which it should in any case --
and unlocks them after waking up, and if resume processing involves
acquiring the device lock, then again nothing will happen.

Does this help clarify things?

Alan Stern


--===============45124693447411812==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45124693447411812==--
