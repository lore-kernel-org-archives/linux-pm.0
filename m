From: "Joonwoo Park" <joonwpark81@gmail.com>
Subject: Re: [PATCH] kexec: fix pci device initialization fail
	after kexec (2.6.23-rc2). (Related to e1000 doesn't resume
	properly from standby)
Date: Tue, 7 Aug 2007 13:30:20 +0900
Message-ID: <b25c3fa70708062130v5176fa9fu4b9300e6a313cf2f__33249.4822367609$1186461162$gmane$org@mail.gmail.com>
References: <b25c3fa70708060642w1b3a326q792a81fdaa3036c5@mail.gmail.com>
	<200708061650.16555.rjw@sisk.pl>
	<b25c3fa70708060850p26b7b3e6yb8a523a479c714c0@mail.gmail.com>
	<200708062048.37160.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708062048.37160.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Simon Arlott <simon@fire.lp0.eu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2007/8/7, Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday, 6 August 2007 17:50, Joonwoo Park wrote:
> > 2007/8/6, Rafael J. Wysocki <rjw@sisk.pl>:
> > > On Monday, 6 August 2007 15:42, Joonwoo Park wrote:
> > > > Hi.
> > > > I think that the pci_set_power_state() has bug.
> > > > The specification says that some delays is required.
> > >
> > > And they are in place, AFAICS (from drivers/pci/pci.c):
> > >
> > >        /* Mandatory power management transition delays */
> > >        /* see PCI PM 1.1 5.6.1 table 18 */
> > >        if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> > >                msleep(pci_pm_d3_delay);
> > >        else if (state == PCI_D2 || dev->current_state == PCI_D2)
> > >                udelay(200);
> > >
> >
> > The problem is occurred when state is 'PCI_D0', so those codes can't cover it.
> > But pci pm specification 5.4.1 says that when programmed to D0 the
> > equivalent of a warm reset, delay for the duration of the D3hot to D0
> > Uninitialized state
> > transition (10ms) to pci signal drivers remain disabled is required.
>
> Section 5.4.1 of PCI PM 1.1. spec is about D3_hot.  Specifically, it says
> that if a device in D3_hot is programmed to D0, it performs the equivalent of
> a warm reset.  IOW, this is supposed to happen if the current state is D3_hot
> and the targed state is D0, which is covered by the code snippet above.

IMHO, it is seems to the spec says just *programmed  to D0* not
*programmed from D3hot to D0*.
Actually, I got current_state UNKNOWN and state PCI_D0 after kexec's
start new kernel with dual port 82546EB fiber ethernet card.

>
> Greetings,
> Rafael
>
>
> --
> "Premature optimization is the root of all evil." - Donald Knuth
>

Simon, this patch was checked with checkpatch.pl and fixed some fault.

Signed-off-by: Joonwoo Park <joonwpark81@gmail.com>

---
 drivers/pci/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 37c00f6..0f086d9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -467,7 +467,8 @@ pci_set_power_state(struct pci_dev *dev, pci_power_t state)

 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+	if (state == PCI_D3hot || dev->current_state == PCI_D3hot ||
+	    state == PCI_D0)
 		msleep(pci_pm_d3_delay);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
-


Best regards,
Joonwoo Park.
