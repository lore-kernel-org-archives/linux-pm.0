From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Thu, 17 Mar 2005 09:55:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503170951110.855-100000@ida.rowland.org>
References: <1111034693.3240.92.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============83675298658450314=="
In-Reply-To: <1111034693.3240.92.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============83675298658450314==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 17 Mar 2005, Nigel Cunningham wrote:

> > Given that on some platforms it's necessary to leave some IRQs enabled for 
> > remote wakeup to work, the definitions of FREEZE and SUSPEND need to be 
> > changed.  A quiesced device does not perform DMA and does not generate 
> > interrupt requests _except_ that it may issue wakeup requests (which may 
> > be IRQs) if it is enabled for remote wakeup.
> 
> I don't think the definition of FREEZE needs to be changed because -
> unless I misunderstand - it is only used when swsusp and Suspend2 are
> doing their atomic copies. Pavel, is this right?

Nevertheless the definition still needs to be changed.  As it stands now, 
moving from FREEZE to SUSPEND might involve an _increase_ in device 
activity -- namely, enabling resume IRQs.  That's not what we want.

> > I don't think this will cause any problems for Suspend To Disk.  If a 
> > wakeup IRQ arrives before the system is asleep and is fielded by an 
> > interrupt handler, the handler will try to start a resume.  But resume 
> > needs a process context to operate, and all processes will be frozen -- so 
> > nothing will happen.
> 
> Does the handler try to start a usermode helper program?

Depends on the details of the driver.  But it's impossible to _fork_ a new 
process from an interrupt handler.  You can try to _wakeup_ an existing 
process, but when the process is frozen it can't wake up.

Alan Stern


--===============83675298658450314==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============83675298658450314==--
