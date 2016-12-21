From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH DEBUG] x86, pat/mtrr: MTRR/PAT init earlier for each APs
Date: Wed, 21 Dec 2016 14:51:02 +0800
Message-ID: <20161221065102.GA4539@yu-desktop-1.sh.intel.com>
References: <1482229288-30913-1-git-send-email-yu.c.chen@intel.com>
 <20161220105651.GA14419@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8752 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756157AbcLUGlz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 01:41:55 -0500
Content-Disposition: inline
In-Reply-To: <20161220105651.GA14419@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suresh Siddha <sbsiddha@gmail.com>, Borislav Petkov <bp@suse.de>, "Brandt, Todd E" <todd.e.brandt@intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

On Tue, Dec 20, 2016 at 11:56:51AM +0100, Lukas Wunner wrote:
> On Tue, Dec 20, 2016 at 06:21:28PM +0800, Chen Yu wrote:
> > This is a debug patch to descibe/workaround the issue
> > we encountered recently.
> > 
> > Problem and the cause:
> > Currently we are suffering from *extremely* slow CPU online
> > speed during system resuming from S3. Say, the MacBookPro 2015
> > has 4 CPUs, and it took more than 1 second each for both CPU1
> > and CPU3 to be brought back to idle thread again. Further ftrace
> > result showed that, *each* instruction the CPU1 and CPU3 execute
> > will take much longer time than it will take during normal cpu
> > online via sysfs(without S3 involved). And more interesting
> > thing was found that after resumed back, every instruction CPU1 and
> > CPU3 execute is back to its normal speed(unixbench has the same score
> > before/after S3). So it smells like there is something wrong with
> > the cache/tlb settings only during resuming back from S3.
> > Finally we have found this might be related to BIOS who has
> > scribbled the mtrr/pat before it resumed back to the OS, and every
> > instruction seems to be run in an uncached behavior, fortunately
> > later after all the APs have been brought up again, mtrr_aps_init()
> > will be invoked to synchronize the mtrr on these APs to the value
> > once saved by CPU0 before suspended, thus everything is back
> > to normal after resumed.
> 
> I'm seeing the same issue on a MacBookPro9,1 (Ivy Bridge, 2012,
> BIOS MBP91.88Z.00D3.B0C.1509111653 09/11/2015).
> 
> I was already wondering what's going on, so thanks a lot for looking
> into this.
> 
> For me this is a regression because with 4.7.0-rc7 resume was
> sufficiently quick.  The issue only started to appear after
> I rebased my working branch on 4.8.0-rc8.  I can confirm that
> your patch fixes the issue, so FWIW:
> 
> Tested-by: Lukas Wunner <lukas@wunner.de>
>
I've tested on 4.7.0-rc7, and the problem is still there,
it tooks nearly 2 second to bring up these cpus, after the
patch applied on top of 4.7.0-rc7, the time has dropped to 30ms.
Maybe because the mtrr after restored are random, thus we see different
result. Let's wait if other experts would give any clue on this :)

Original 4.7.0-rc7
[ 1895.937202] Enabling non-boot CPUs ...
[ 1895.960590] x86: Booting SMP configuration:
[ 1895.960599] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 1896.042237]  cache: parent cpu1 should not be sleeping
[ 1896.278915] CPU1 is up
[ 1896.326531] hrtimer: interrupt took 21233972 ns
[ 1896.497384] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 2.551 msecs
[ 1896.499428] perf: interrupt took too long (15541 > 2500), lowering kernel.perf_event_max_sample_rate to 12750
[ 1898.533643] smpboot: Booting Node 0 Processor 2 APIC 0x1
[ 1898.539348]  cache: parent cpu2 should not be sleeping
[ 1898.583167] CPU2 is up
[ 1900.938878] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 1901.002698]  cache: parent cpu3 should not be sleeping
[ 1901.584319] perf: interrupt took too long (20241 > 19426), lowering kernel.perf_event_max_sample_rate to 9750
[ 1901.605220] CPU3 is up


After patch applied on 4.7.0-rc7:
[   93.580823] Enabling non-boot CPUs ...
[   93.613049] x86: Booting SMP configuration:
[   93.613057] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   93.620355]  cache: parent cpu1 should not be sleeping
[   93.620773] CPU1 is up
[   93.642325] smpboot: Booting Node 0 Processor 2 APIC 0x1
[   93.646009]  cache: parent cpu2 should not be sleeping
[   93.646293] CPU2 is up
[   93.675439] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   93.679256]  cache: parent cpu3 should not be sleeping
[   93.679573] CPU3 is up
[   93.679582] ACPI: Waking up from system sleep state S3

> 
> This is with 4.7.0-rc7, resume was consistently at or below 1 sec:
> 
> [  107.080920] ACPI: Low-level resume complete
> [  107.080965] ACPI : EC: EC started
> [  107.080966] PM: Restoring platform NVS memory
> [  107.081341] Enabling non-boot CPUs ...
> [  107.101059] x86: Booting SMP configuration:
> [  107.101060] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  107.108619]  cache: parent cpu1 should not be sleeping
> [  107.135789] CPU1 is up
> [  107.199203] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [  107.209808]  cache: parent cpu2 should not be sleeping
> [  107.240896] CPU2 is up
> [  107.314086] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [  107.326220]  cache: parent cpu3 should not be sleeping
> [  107.357507] CPU3 is up
> [  107.449002] smpboot: Booting Node 0 Processor 4 APIC 0x1
> [  107.451740]  cache: parent cpu4 should not be sleeping
> [  107.452106] CPU4 is up
> [  107.549902] smpboot: Booting Node 0 Processor 5 APIC 0x3
> [  107.566487]  cache: parent cpu5 should not be sleeping
> [  107.624016] CPU5 is up
> [  107.787000] smpboot: Booting Node 0 Processor 6 APIC 0x5
> [  107.804491]  cache: parent cpu6 should not be sleeping
> [  107.869075] CPU6 is up
> [  108.057328] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  108.075840]  cache: parent cpu7 should not be sleeping
> [  108.149616] CPU7 is up
> [  108.155910] ACPI: Waking up from system sleep state S3
> 
> 
> This is with 4.8.0-rc8 without your patch, around 4 sec:
> 
> [  608.277228] ACPI: Low-level resume complete
> [  608.277273] ACPI : EC: EC started
> [  608.277274] PM: Restoring platform NVS memory
> [  608.277612] Enabling non-boot CPUs ...
> [  608.301165] x86: Booting SMP configuration:
> [  608.301165] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  608.350399]  cache: parent cpu1 should not be sleeping
> [  608.531440] CPU1 is up
> [  608.761943] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [  608.806085]  cache: parent cpu2 should not be sleeping
> [  608.972760] CPU2 is up
> [  609.276436] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [  609.323774]  cache: parent cpu3 should not be sleeping
> [  609.472503] CPU3 is up
> [  609.824707] smpboot: Booting Node 0 Processor 4 APIC 0x1
> [  609.828097]  cache: parent cpu4 should not be sleeping
> [  609.828776] CPU4 is up
> [  610.223620] smpboot: Booting Node 0 Processor 5 APIC 0x3
> [  610.292411]  cache: parent cpu5 should not be sleeping
> [  610.545823] CPU5 is up
> [  610.981127] smpboot: Booting Node 0 Processor 6 APIC 0x5
> [  611.049177]  cache: parent cpu6 should not be sleeping
> [  611.334813] CPU6 is up
> [  612.049163] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  612.123333]  cache: parent cpu7 should not be sleeping
> [  612.427630] CPU7 is up
> [  612.436692] ACPI: Waking up from system sleep state S3
> 
> 
> With your patch I'm back to 1 sec:
> 
> [   98.177541] ACPI: Low-level resume complete
> [   98.177585] ACPI : EC: EC started
> [   98.177585] PM: Restoring platform NVS memory
> [   98.177951] Enabling non-boot CPUs ...
> [   98.201608] x86: Booting SMP configuration:
> [   98.201609] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   98.210412]  cache: parent cpu1 should not be sleeping
> [   98.238198] CPU1 is up
> [   98.307550] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [   98.319788]  cache: parent cpu2 should not be sleeping
> [   98.353269] CPU2 is up
> [   98.428475] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [   98.439979]  cache: parent cpu3 should not be sleeping
> [   98.478572] CPU3 is up
> [   98.585208] smpboot: Booting Node 0 Processor 4 APIC 0x1
> [   98.588040]  cache: parent cpu4 should not be sleeping
> [   98.588412] CPU4 is up
> [   98.702925] smpboot: Booting Node 0 Processor 5 APIC 0x3
> [   98.719564]  cache: parent cpu5 should not be sleeping
> [   98.786342] CPU5 is up
> [   98.959777] smpboot: Booting Node 0 Processor 6 APIC 0x5
> [   98.977120]  cache: parent cpu6 should not be sleeping
> [   99.048355] CPU6 is up
> [   99.241252] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [   99.261368]  cache: parent cpu7 should not be sleeping
> [   99.339541] CPU7 is up
> [   99.345700] ACPI: Waking up from system sleep state S3
> 
> Thanks,
> 
> Lukas
> 
