From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Thu, 17 Mar 2005 15:44:53 +1100
Message-ID: <1111034693.3240.92.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0503162259320.7210-100000@netrider.rowland.org>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============68665310107997457=="
In-Reply-To: <Pine.LNX.4.44L0.0503162259320.7210-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============68665310107997457==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-03-17 at 15:11, Alan Stern wrote:
> On Wed, 16 Mar 2005, David Brownell wrote:
> 
> > > Wether the system IRQs must be masked or not is one thing that is
> > > platform specific during suspend. Wether devices must stop their IRQ
> > > emission, well... 
> > 
> > What's a "system IRQ" as opposed to any other kind?  Drivers don't
> > generally know or care how their IRQs are routed, they just care
> > that they get a callback.
> 
> Given that on some platforms it's necessary to leave some IRQs enabled for 
> remote wakeup to work, the definitions of FREEZE and SUSPEND need to be 
> changed.  A quiesced device does not perform DMA and does not generate 
> interrupt requests _except_ that it may issue wakeup requests (which may 
> be IRQs) if it is enabled for remote wakeup.

I don't think the definition of FREEZE needs to be changed because -
unless I misunderstand - it is only used when swsusp and Suspend2 are
doing their atomic copies. Pavel, is this right?

> I don't think this will cause any problems for Suspend To Disk.  If a 
> wakeup IRQ arrives before the system is asleep and is fielded by an 
> interrupt handler, the handler will try to start a resume.  But resume 
> needs a process context to operate, and all processes will be frozen -- so 
> nothing will happen.

Does the handler try to start a usermode helper program?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============68665310107997457==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============68665310107997457==--
