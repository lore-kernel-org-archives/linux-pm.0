From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Mon, 14 Mar 2005 10:17:17 -0800
Message-ID: <200503141017.17305.david-b@pacbell.net>
References: <20050313101453.GA4820@blackham.com.au>
	<200503132003.27555.david-b@pacbell.net>
	<20050314080827.GG22635@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48673389950817536=="
In-Reply-To: <20050314080827.GG22635-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============48673389950817536==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 March 2005 12:08 am, Pavel Machek wrote:
> 	 I'll really need to make pci_choose_state
> "NOP" in the current code, so that it can be safely added to the
> existing drivers.

There's no point in adding NOPs.  Why bother?

Remember, the original idea behind pci_choose_state() was that
PCI drivers for PM-aware devices could use that instead of their
own dumb mappings between system suspend states (S0, S1, S2, S3,
S4, etc) and PCI states ... which in too many cases was just to
re-use the same numeric value.  That's _never_ going to be a NOP,
unless Linux only ever supports PCI D3hot (ACPI D2) and S3; and
likewise will never be needed for PM-stupid devices, or for those
drivers with actual intelligence (e.g. Ben's video examples).


My original question is unanswered though:  what tree is it that
made these (broken) changes to USB?  It's not BK-current, and it's
not the USB tree...

- Dave

--===============48673389950817536==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48673389950817536==--
