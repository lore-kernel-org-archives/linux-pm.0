From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 10:49:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503191041110.11225-100000@netrider.rowland.org>
References: <20050319103351.GM24449@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32244796368733208=="
In-Reply-To: <20050319103351.GM24449-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============32244796368733208==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 19 Mar 2005, Pavel Machek wrote:

> Hi!
> 
> > This problem would be eliminated if the boot kernel's driver was aware
> > that a resume-from-disk was in progress.  I've heard that suspend2 can
> > offer such a feature; can it be added to swsusp?  Using a special flags 
> > value for the FREEZE would be sufficient.
> 
> Flag certainly can be added, but it seems to me solution is to stop
> the DMA in this case.

On Sat, 19 Mar 2005, Benjamin Herrenschmidt wrote:

> Oh, I was not talking about letting devices to DMA etc... in general. I
> was only talking about the specific case of OHCI not suspending the bus.
> All queue processing would still be stopped, and URBs refused etc.., the
> only DMA happening there would be the updating of the HCCA which I think
> can be managed, but then, again, this is just some optimisation that can
> be done later once we have a working & stable setup.

Certainly the easiest solution for now is always to stop DMA and just live 
with the fact that for UHCI, FREEZE->ON will be a little slow.

Ultimately, if uhci-hcd can tell apart the two types of FREEZE (preparing
to create snaphot vs. preparing to restore snapshot) then it could know to
leave DMA on for the first but not the second.  I agree it's too early to 
implement this -- a minimum requirement is that CONFIG_USB_SUSPEND should 
always be true and not a configurable option.

Alan Stern


--===============32244796368733208==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32244796368733208==--
