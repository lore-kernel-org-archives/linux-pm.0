From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 23:02:27 +1100
Message-ID: <1111233747.3835.208.camel@gaston>
References: <Pine.LNX.4.44L0.0503182205040.30560-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============048853312074190747=="
In-Reply-To: <Pine.LNX.4.44L0.0503182205040.30560-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
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

--===============048853312074190747==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-03-18 at 22:23 -0500, Alan Stern wrote:

> But there might be a different problem.  If a USB driver is not modular,
> then what happens when the swsusp boot kernel loads the memory image?  It
> FREEZEs all the devices first, right?  So that the image kernel gets
> control back with the devices in a known good state.  If you allowed a
> device to continue doing DMA during this FREEZE (even if it's just OUT
> transfers, not writing to memory), it could end up reading arbitrary
> invalid data which would cause a device error.
> 
> This problem would be eliminated if the boot kernel's driver was aware
> that a resume-from-disk was in progress.  I've heard that suspend2 can
> offer such a feature; can it be added to swsusp?  Using a special flags 
> value for the FREEZE would be sufficient.

Oh, I was not talking about letting devices to DMA etc... in general. I
was only talking about the specific case of OHCI not suspending the bus.
All queue processing would still be stopped, and URBs refused etc.., the
only DMA happening there would be the updating of the HCCA which I think
can be managed, but then, again, this is just some optimisation that can
be done later once we have a working & stable setup.

Ben.



--===============048853312074190747==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============048853312074190747==--
