From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
	2.6.25-rc6)
Date: Wed, 26 Mar 2008 16:45:00 +0100
Message-ID: <200803261645.01343.corentincj__5336.30364011532$1206575975$gmane$org@iksaif.net>
References: <200803180510.47670.lenb@kernel.org>
	<20080326081653.GA8247@elte.hu>
	<200803261132.21448.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 March 2008 16:32:20 Len Brown wrote:
> So if this is correct or not depends on what the BIOS programmer
> for the Asus A1x choose to write. =A0Perhaps Corentin 'Iksaif' CHARY
> can confirm if the driver is working properly on that system.

Hi,
Sorry I don't have an A1x to test that, and this was here a long time befor=
e I start working on acpi4asus.
But, see that grep :

chary_c@foo /usr/src/linux/drivers/misc $ grep ISA *
asus-laptop.c:      "\\_SB.PCI0.ISA.EC0._Q10",  /* A1x */
thinkpad_acpi.c:IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",      /* 240, 240=
x */
thinkpad_acpi.c:           "\\_SB.PCI.ISA.EC",  /* 570 */
thinkpad_acpi.c:           "\\_SB.PCI0.ISA0.EC0",       /* 600e/x, 770e, 77=
0x */
thinkpad_acpi.c:           "\\_SB.PCI0.ISA.EC", /* A21e, A2xm/p, T20-22, X2=
0-21 */
thinkpad_acpi.c:           "\\_SB.PCI.ISA.SLCE",        /* 570 */

So it seems to work for thinkpads.
I think this patch isn't needed.

-- =

Corentin 'Iksaif' CHARY
http://xf.iksaif.net
