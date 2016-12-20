From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH DEBUG] x86, pat/mtrr: MTRR/PAT init earlier for each APs
Date: Tue, 20 Dec 2016 11:56:51 +0100
Message-ID: <20161220105651.GA14419@wunner.de>
References: <1482229288-30913-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:41543 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757735AbcLTLII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2016 06:08:08 -0500
Content-Disposition: inline
In-Reply-To: <1482229288-30913-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suresh Siddha <sbsiddha@gmail.com>, Borislav Petkov <bp@suse.de>, "Brandt, Todd E" <todd.e.brandt@intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

On Tue, Dec 20, 2016 at 06:21:28PM +0800, Chen Yu wrote:
> This is a debug patch to descibe/workaround the issue
> we encountered recently.
> 
> Problem and the cause:
> Currently we are suffering from *extremely* slow CPU online
> speed during system resuming from S3. Say, the MacBookPro 2015
> has 4 CPUs, and it took more than 1 second each for both CPU1
> and CPU3 to be brought back to idle thread again. Further ftrace
> result showed that, *each* instruction the CPU1 and CPU3 execute
> will take much longer time than it will take during normal cpu
> online via sysfs(without S3 involved). And more interesting
> thing was found that after resumed back, every instruction CPU1 and
> CPU3 execute is back to its normal speed(unixbench has the same score
> before/after S3). So it smells like there is something wrong with
> the cache/tlb settings only during resuming back from S3.
> Finally we have found this might be related to BIOS who has
> scribbled the mtrr/pat before it resumed back to the OS, and every
> instruction seems to be run in an uncached behavior, fortunately
> later after all the APs have been brought up again, mtrr_aps_init()
> will be invoked to synchronize the mtrr on these APs to the value
> once saved by CPU0 before suspended, thus everything is back
> to normal after resumed.

I'm seeing the same issue on a MacBookPro9,1 (Ivy Bridge, 2012,
BIOS MBP91.88Z.00D3.B0C.1509111653 09/11/2015).

I was already wondering what's going on, so thanks a lot for looking
into this.

For me this is a regression because with 4.7.0-rc7 resume was
sufficiently quick.  The issue only started to appear after
I rebased my working branch on 4.8.0-rc8.  I can confirm that
your patch fixes the issue, so FWIW:

Tested-by: Lukas Wunner <lukas@wunner.de>


This is with 4.7.0-rc7, resume was consistently at or below 1 sec:

[  107.080920] ACPI: Low-level resume complete
[  107.080965] ACPI : EC: EC started
[  107.080966] PM: Restoring platform NVS memory
[  107.081341] Enabling non-boot CPUs ...
[  107.101059] x86: Booting SMP configuration:
[  107.101060] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  107.108619]  cache: parent cpu1 should not be sleeping
[  107.135789] CPU1 is up
[  107.199203] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  107.209808]  cache: parent cpu2 should not be sleeping
[  107.240896] CPU2 is up
[  107.314086] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  107.326220]  cache: parent cpu3 should not be sleeping
[  107.357507] CPU3 is up
[  107.449002] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  107.451740]  cache: parent cpu4 should not be sleeping
[  107.452106] CPU4 is up
[  107.549902] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  107.566487]  cache: parent cpu5 should not be sleeping
[  107.624016] CPU5 is up
[  107.787000] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  107.804491]  cache: parent cpu6 should not be sleeping
[  107.869075] CPU6 is up
[  108.057328] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  108.075840]  cache: parent cpu7 should not be sleeping
[  108.149616] CPU7 is up
[  108.155910] ACPI: Waking up from system sleep state S3


This is with 4.8.0-rc8 without your patch, around 4 sec:

[  608.277228] ACPI: Low-level resume complete
[  608.277273] ACPI : EC: EC started
[  608.277274] PM: Restoring platform NVS memory
[  608.277612] Enabling non-boot CPUs ...
[  608.301165] x86: Booting SMP configuration:
[  608.301165] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  608.350399]  cache: parent cpu1 should not be sleeping
[  608.531440] CPU1 is up
[  608.761943] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  608.806085]  cache: parent cpu2 should not be sleeping
[  608.972760] CPU2 is up
[  609.276436] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  609.323774]  cache: parent cpu3 should not be sleeping
[  609.472503] CPU3 is up
[  609.824707] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  609.828097]  cache: parent cpu4 should not be sleeping
[  609.828776] CPU4 is up
[  610.223620] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  610.292411]  cache: parent cpu5 should not be sleeping
[  610.545823] CPU5 is up
[  610.981127] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  611.049177]  cache: parent cpu6 should not be sleeping
[  611.334813] CPU6 is up
[  612.049163] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  612.123333]  cache: parent cpu7 should not be sleeping
[  612.427630] CPU7 is up
[  612.436692] ACPI: Waking up from system sleep state S3


With your patch I'm back to 1 sec:

[   98.177541] ACPI: Low-level resume complete
[   98.177585] ACPI : EC: EC started
[   98.177585] PM: Restoring platform NVS memory
[   98.177951] Enabling non-boot CPUs ...
[   98.201608] x86: Booting SMP configuration:
[   98.201609] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   98.210412]  cache: parent cpu1 should not be sleeping
[   98.238198] CPU1 is up
[   98.307550] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   98.319788]  cache: parent cpu2 should not be sleeping
[   98.353269] CPU2 is up
[   98.428475] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   98.439979]  cache: parent cpu3 should not be sleeping
[   98.478572] CPU3 is up
[   98.585208] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   98.588040]  cache: parent cpu4 should not be sleeping
[   98.588412] CPU4 is up
[   98.702925] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   98.719564]  cache: parent cpu5 should not be sleeping
[   98.786342] CPU5 is up
[   98.959777] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   98.977120]  cache: parent cpu6 should not be sleeping
[   99.048355] CPU6 is up
[   99.241252] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   99.261368]  cache: parent cpu7 should not be sleeping
[   99.339541] CPU7 is up
[   99.345700] ACPI: Waking up from system sleep state S3

Thanks,

Lukas

> 
> Workaround:
> So it turns out to be that if we can synchronize the APs with boot CPU
> ASAP, rather than waiting till all CPUS online, it might reduce the
> impact of the bogus BIOS who scribbled the mtrr/pat. So here is the
> hack patch to let the users to synchronize mtrr on APs earlier.
> With the following debug patch applied, the resume time for CPU1 and
> CPU3 have dropped a lot.
> 
> (Notice, the following result were tested with ftrace function_graph enabled
> during suspend/resume, by this tool:
> https://01.org/suspendresume
> 
> 
> Before patch applied:
> [  619.810899] Enabling non-boot CPUs ...
> [  619.825528] x86: Booting SMP configuration:
> [  619.825537] smpboot: Booting Node 0 Processor 1 APIC 0x2
> -------skip--------
> [  621.723809] CPU1 is up
> [  621.762843] smpboot: Booting Node 0 Processor 2 APIC 0x1
> -------skip--------
> [  621.766679] CPU2 is up
> [  621.840228] smpboot: Booting Node 0 Processor 3 APIC 0x3
> -------skip--------
> [  626.690900] CPU3 is up
> 
> So it took CPU1 621.723809 - 619.825537 = 1898.272 ms, and
> CPU3 626.690900 - 621.840228 = 4850.672 ms !
> 
> 
> After patch applied:
> [  106.931790] smpboot: Booting Node 0 Processor 1 APIC 0x2
> -------skip--------
> [  106.948360] CPU1 is up
> [  106.963975] smpboot: Booting Node 0 Processor 2 APIC 0x1
> -------skip--------
> [  106.968087] CPU2 is up
> [  106.986534] smpboot: Booting Node 0 Processor 3 APIC 0x3
> -------skip--------
> [  106.990702] CPU3 is up
> 
> It took CPU1 106.948360 - 106.931790 = 16.57 ms, and
> CPU3 106.990702 - 106.986534 = 4.16 ms
> 
> Question:
> So it turns out to be a BIOS issue, but Linux should also deal with
> this bogus BIOS, right? I studied the commit we delay the synchronization
> until all the APs are brought up, and according to:
> 
> Commit d0af9eed5aa9 ("x86, pat/mtrr: Rendezvous all the cpus
> for MTRR/PAT init")
> 
> It seems that there would be problem if we do not sync APs at the same
> time(some CPUs run with cache disabled will hang the system, because its
> sibling is trying to adjust the mtrr which might disable its cache) on
> some special platforms? But I have a question that, even in our current
> solution which defers the synchronization, the scenario mentioned above
> can not be avoided because at the time CPU3 is trying to restore mtrr,
> its sibling CPU1 might also be doing some kworker or ticking tasks,
> the CPU1 might also run with cache disabled?
> I'm not sure if I understand the code correctly, and it would be
> appreciated if people could give any comments/suggestions on how to deal
> with this situation found on MacProBook, and if you need me to do any test
> please feel free to let me know.
> 
> Thanks,
> Yu
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: "Brandt, Todd E" <todd.e.brandt@intel.com>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/kernel/cpu/mtrr/main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> index 24e87e7..eddaa89 100644
> --- a/arch/x86/kernel/cpu/mtrr/main.c
> +++ b/arch/x86/kernel/cpu/mtrr/main.c
> @@ -813,15 +813,28 @@ void mtrr_save_state(void)
>  	put_online_cpus();
>  }
>  
> +static bool __read_mostly no_aps_delay;
> +
> +static int __init no_aps_setup(char *str)
> +{
> +	no_aps_delay = true;
> +	pr_info("hack: do not delay aps mtrr/pat initialization.\n");
> +
> +	return 0;
> +}
> +
>  void set_mtrr_aps_delayed_init(void)
>  {
>  	if (!mtrr_enabled())
>  		return;
>  	if (!use_intel())
>  		return;
> +	if (no_aps_delay)
> +		return;
>  
>  	mtrr_aps_delayed_init = true;
>  }
> +early_param("no_aps_delay", no_aps_setup);
>  
>  /*
>   * Delayed MTRR initialization for all AP's
> -- 
> 2.7.4
> 
