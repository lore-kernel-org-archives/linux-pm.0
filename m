From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Tue, 15 Mar 2005 09:21:38 +1100
Message-ID: <1110838898.5863.24.camel@gaston>
References: <20050313101453.GA4820@blackham.com.au>
	<200503132003.27555.david-b@pacbell.net>
	<20050314080827.GG22635@elf.ucw.cz>
	<200503141017.17305.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44387190711490798=="
In-Reply-To: <200503141017.17305.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============44387190711490798==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-03-14 at 10:17 -0800, David Brownell wrote:
> On Monday 14 March 2005 12:08 am, Pavel Machek wrote:
> > 	 I'll really need to make pci_choose_state
> > "NOP" in the current code, so that it can be safely added to the
> > existing drivers.
> 
> There's no point in adding NOPs.  Why bother?
> 
> Remember, the original idea behind pci_choose_state() was that
> PCI drivers for PM-aware devices could use that instead of their
> own dumb mappings between system suspend states (S0, S1, S2, S3,
> S4, etc) and PCI states ... which in too many cases was just to
> re-use the same numeric value.  That's _never_ going to be a NOP,
> unless Linux only ever supports PCI D3hot (ACPI D2) and S3; and
> likewise will never be needed for PM-stupid devices, or for those
> drivers with actual intelligence (e.g. Ben's video examples).

Note that the apple OHCI cell in Apple ASICs, despite beeing a PCI
device, doesn't always expose PCI PM capabilities. We still need to do
the proper suspend stuff on it. So be careful with pci_choose_state().

> My original question is unanswered though:  what tree is it that
> made these (broken) changes to USB?  It's not BK-current, and it's
> not the USB tree...




--===============44387190711490798==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44387190711490798==--
