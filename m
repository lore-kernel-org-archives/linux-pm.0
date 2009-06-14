From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 15:17:25 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906141514120.2800__1807.8014524237$1244985509$gmane$org@localhost.localdomain>
References: <20090614120950.116536fa@pluto-lenny.milky.way>
	<200906141400.27331.rjw@sisk.pl>
	<alpine.LFD.2.00.0906141405450.2800@localhost.localdomain>
	<200906141415.16949.rjw@sisk.pl>
	<20090614143708.32ec250c@pluto-lenny.milky.way>
	<alpine.LFD.2.00.0906141444500.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC4669244187@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <7E82351C108FA840AB1866AC776AEC4669244187@orsmsx505.amr.corp.intel.com>
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

On Sun, 14 Jun 2009, Pallipadi, Venkatesh wrote:
> >On Sun, 14 Jun 2009, Benjamin S. wrote:
> >
> >This is odd as well:
> >>            CPU0       CPU1       
> >>   0:         42          1   IO-APIC-edge      timer
> >>  24:       4830          0  HPET_MSI-edge      hpet2
> >> LOC:         42       5070   Local timer interrupts
> >
> >So we set up only one hpet channel for CPU0 and CPU1 uses the local
> >timer interrupt. Need to look at that as well.
> >
>
 
> Logic in percpu HPET is something like this.
>
> - Number of per cpu HPET channels = total number of HPET channels -
>   1 (global HPET) - 1 (legacy RTC replacement) - 1 (reserved for
>   /dev/hpet).
>
> - So, this number is assigned one per CPU and remaining CPUs use
>   APIC timer + broadcast logic
>
> Looks like there is a slight problem with the above though. We
> should start such per cpu assignment from CPU 1 instead of CPU 0,
> when number of HPET channels is less than number of CPUs. Will send
> a patch for that. But, this suspend resume problem should not be due
> to the percpu HPET logic. It will be good to try with hpet=disable
> to make sure...

Benjamin just confirmed that. The logic in disable_device_interrupts()
already skips interrupts marked with IRQF_TIMER, but I suspect that
the hpet/MSI interupts are not marked that way.

Thanks,

	tglx
