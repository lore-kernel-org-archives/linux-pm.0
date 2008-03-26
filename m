From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
	2.6.25-rc6)
Date: Wed, 26 Mar 2008 09:56:53 -0600
Message-ID: <200803260956.55804.bjorn.helgaas__21549.547595396$1206547396$gmane$org@hp.com>
References: <200803180510.47670.lenb@kernel.org>
	<20080326081653.GA8247@elte.hu>
	<200803261132.21448.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803261132.21448.lenb@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Corentin CHARY <corentincj@iksaif.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 March 2008 09:32:20 am Len Brown wrote:
> >  /* Here we go */
> > -#define A1x_PREFIX "\\_SB.PCI0.ISA.EC0."
> > +#define A1x_PREFIX "\\_SB.PCI0.ISA_.EC0."
> 
> From an AML point of view, ISA is just as legal as "ISA_"
> The NameString paramter to Device() can be 1 to 4 characters.
> 
> So if this is correct or not depends on what the BIOS programmer
> for the Asus A1x choose to write.  Perhaps Corentin 'Iksaif' CHARY
> can confirm if the driver is working properly on that system.

I'm curious about how this works.  I disassembled the DSDT from
http://bugzilla.kernel.org/show_bug.cgi?id=4773 (I attached the disassembly
at http://bugzilla.kernel.org/attachment.cgi?id=15448&action=view), and
the _PRT contains "_SB" and "ISA" (no trailing underscores):

                Package (0x04)
                {
                    0x000DFFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNKA, 
                    0x00
                }

But by the time we get to acpi_pci_irq_add_entry(), we've added the
underscores somewhere (see
http://bugzilla.kernel.org/attachment.cgi?id=15423&action=view):

  0000:00:0d[A] -> \_SB_.PCI0.ISA_.LNKA

I don't know where this happens, but it certainly confused me, and
it seems like it could lead to other bugs.

Bjorn
