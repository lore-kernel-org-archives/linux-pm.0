From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Tue, 15 Mar 2005 09:22:30 +1100
Message-ID: <1110838950.5673.26.camel@gaston>
References: <20050313101453.GA4820@blackham.com.au>
	<200503132003.27555.david-b@pacbell.net>
	<20050314080827.GG22635@elf.ucw.cz>
	<200503141017.17305.david-b@pacbell.net>
	<20050314184454.GL5461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28787754585437053=="
In-Reply-To: <20050314184454.GL5461-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============28787754585437053==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-03-14 at 19:44 +0100, Pavel Machek wrote:
> Hi!
> 
> > > 	 I'll really need to make pci_choose_state
> > > "NOP" in the current code, so that it can be safely added to the
> > > existing drivers.
> > 
> > There's no point in adding NOPs.  Why bother?
> > 
> > Remember, the original idea behind pci_choose_state() was that
> > PCI drivers for PM-aware devices could use that instead of their
> > own dumb mappings between system suspend states (S0, S1, S2, S3,
> > S4, etc) and PCI states ... which in too many cases was just to
> > re-use the same numeric value.  That's _never_ going to be a NOP,
> > unless Linux only ever supports PCI D3hot (ACPI D2) and S3; and
> > likewise will never be needed for PM-stupid devices, or for those
> > drivers with actual intelligence (e.g. Ben's video examples).
> 
> When I added pci_choose_state to drivers, I commented it as "no code
> changes". I was wrong. pci_choose_state() needs to return d3hot even
> for pmsg_freeze, because that's what old code did, and I did not audit
> all the drivers.

Yes, we should default to D3 I suppose. Only drivers that directly
understand the new semantics may do fancy/different things for
pmsg_freeze.

> > My original question is unanswered though:  what tree is it that
> > made these (broken) changes to USB?  It's not BK-current, and it's
> > not the USB tree...
> 
> suspend2 tree and my personal tree.
> 								Pavel
> _______________________________________________
> linux-pm mailing list
> linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
> http://lists.osdl.org/mailman/listinfo/linux-pm
-- 
Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>


--===============28787754585437053==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28787754585437053==--
