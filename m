From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
	2.6.25-rc6)
Date: Wed, 26 Mar 2008 13:33:56 -0300
Message-ID: <20080326163356.GC3562@khazad-dum.debian.net>
References: <200803180510.47670.lenb@kernel.org>
	<20080326081653.GA8247@elte.hu>
	<200803261132.21448.lenb@kernel.org>
	<200803261645.01343.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803261645.01343.corentincj@iksaif.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Corentin CHARY <corentincj@iksaif.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Mar 2008, Corentin CHARY wrote:
> thinkpad_acpi.c:IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",      /* 240, 240x */
> thinkpad_acpi.c:           "\\_SB.PCI.ISA.EC",  /* 570 */
> thinkpad_acpi.c:           "\\_SB.PCI0.ISA0.EC0",       /* 600e/x, 770e, 770x */
> thinkpad_acpi.c:           "\\_SB.PCI0.ISA.EC", /* A21e, A2xm/p, T20-22, X20-21 */
> thinkpad_acpi.c:           "\\_SB.PCI.ISA.SLCE",        /* 570 */
> 
> So it seems to work for thinkpads.

ThinkPads use "ISA" as the node (not ISA_ or anything else like that),
and the ACPICA node match routine works properly.

So please don't touch thinkpad-acpi's ".ISA." stuff.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
