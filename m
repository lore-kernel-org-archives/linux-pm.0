From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 16:45:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906141644190.2800__29049.2408829325$1244990780$gmane$org@localhost.localdomain>
References: <20090614120950.116536fa@pluto-lenny.milky.way>
	<200906141400.27331.rjw@sisk.pl>
	<alpine.LFD.2.00.0906141405450.2800@localhost.localdomain>
	<200906141415.16949.rjw@sisk.pl>
	<20090614143708.32ec250c@pluto-lenny.milky.way>
	<alpine.LFD.2.00.0906141444500.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC4669244187@orsmsx505.amr.corp.intel.com>
	<alpine.LFD.2.00.0906141514120.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC466924418A@orsmsx505.amr.corp.intel.com>
	<alpine.LFD.2.00.0906141548490.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0906141548490.2800@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "js@sig21.net" <js@sig21.net>, Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Benjamin S." <sbenni@gmx.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Benjamin,

On Sun, 14 Jun 2009, Thomas Gleixner wrote:
> On Sun, 14 Jun 2009, Pallipadi, Venkatesh wrote:
> > >Benjamin just confirmed that. The logic in disable_device_interrupts()
> > >already skips interrupts marked with IRQF_TIMER, but I suspect that
> > >the hpet/MSI interupts are not marked that way.
> > >
> > 
> > For percpu hpet at offline we will have
> > - clockevent shutdown which will disable the interrupt
> > - free_irq that will unregister on CPU DEAD
> 
> Well, the interupt in question is on the boot cpu which is not going
> through CPU DEAD :)

can you please test the patch below.

Thanks,

	tglx
------------>
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 81408b9..dedc2bd 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -510,7 +510,8 @@ static int hpet_setup_irq(struct hpet_dev *dev)
 {
 
 	if (request_irq(dev->irq, hpet_interrupt_handler,
-			IRQF_DISABLED|IRQF_NOBALANCING, dev->name, dev))
+			IRQF_TIMER | IRQF_DISABLED | IRQF_NOBALANCING,
+			dev->name, dev))
 		return -1;
 
 	disable_irq(dev->irq);
