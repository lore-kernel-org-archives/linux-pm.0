From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 06:12:23 -0700
Message-ID: <7E82351C108FA840AB1866AC776AEC4669244187@orsmsx505.amr.corp.intel.com>
References: <20090614120950.116536fa@pluto-lenny.milky.way>
	<200906141400.27331.rjw@sisk.pl>
	<alpine.LFD.2.00.0906141405450.2800@localhost.localdomain>
	<200906141415.16949.rjw@sisk.pl>
	<20090614143708.32ec250c@pluto-lenny.milky.way>
	<alpine.LFD.2.00.0906141444500.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0906141444500.2800@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, "Benjamin S." <sbenni@gmx.de>
Cc: "js@sig21.net" <js@sig21.net>, Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


>-----Original Message-----
>From: Thomas Gleixner [mailto:tglx@linutronix.de] 
>Sent: Sunday, June 14, 2009 5:46 AM
>To: Benjamin S.
>Cc: Rafael J. Wysocki; Ingo Molnar; LKML; js@sig21.net; Jesse 
>Barnes; pm list; Linux PCI; Matthew Wilcox; Pallipadi, Venkatesh
>Subject: Re: 2.6.30 enabling cpu1 on resume fails after 
>suspend to memory
>
>On Sun, 14 Jun 2009, Benjamin S. wrote:
>
>This is odd as well:
>>            CPU0       CPU1       
>>   0:         42          1   IO-APIC-edge      timer
>>  24:       4830          0  HPET_MSI-edge      hpet2
>> LOC:         42       5070   Local timer interrupts
>
>So we set up only one hpet channel for CPU0 and CPU1 uses the local
>timer interrupt. Need to look at that as well.
>

Logic in percpu HPET is something like this.
- Number of per cpu HPET channels = total number of HPET channels - 1 (global HPET) - 1 (legacy RTC replacement) - 1 (reserved for /dev/hpet).
- So, this number is assigned one per CPU and remaining CPUs use APIC timer + broadcast logic

Looks like there is a slight problem with the above though. We should start such per cpu assignment from CPU 1 instead of CPU 0, when number of HPET channels is less than number of CPUs. Will send a patch for that. But, this suspend resume problem should not be due to the percpu HPET logic. It will be good to try with hpet=disable to make sure...

Thanks,
Venki
