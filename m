From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
	2.6.25-rc6)
Date: Wed, 26 Mar 2008 20:24:41 +0300
Message-ID: <47EA86D9.7040404__41596.0718448789$1206552699$gmane$org@gmail.com>
References: <200803180510.47670.lenb@kernel.org>
	<20080326081653.GA8247@elte.hu>
	<200803261132.21448.lenb@kernel.org>
	<200803260956.55804.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803260956.55804.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Corentin CHARY <corentincj@iksaif.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Bjorn Helgaas wrote:
> I'm curious about how this works.  I disassembled the DSDT from
> http://bugzilla.kernel.org/show_bug.cgi?id=4773 (I attached the disassembly
> at http://bugzilla.kernel.org/attachment.cgi?id=15448&action=view), and
> the _PRT contains "_SB" and "ISA" (no trailing underscores):
>
>                 Package (0x04)
>                 {
>                     0x000DFFFF, 
>                     0x00, 
>                     \_SB.PCI0.ISA.LNKA, 
>                     0x00
>                 }
>
> But by the time we get to acpi_pci_irq_add_entry(), we've added the
> underscores somewhere (see
> http://bugzilla.kernel.org/attachment.cgi?id=15423&action=view):
>
>   0000:00:0d[A] -> \_SB_.PCI0.ISA_.LNKA
>
> I don't know where this happens, but it certainly confused me, and
> it seems like it could lead to other bugs.
>   
ACPI is supposed to add trailing underscore for pad all names to 4 bytes.
So ISA will be padded to ISA_.

Regards,
Alex.
