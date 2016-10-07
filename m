From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 4/4] x86, hotplug: Use hlt instead of mwait when resuming
 from hibernation
Date: Fri, 7 Oct 2016 12:47:24 -0700
Message-ID: <e2d3e4ce-05df-b416-6f1a-e90a3bf8d63b@kernel.org>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <519377051f98268f41c382d2897ae578b2a743f6.1466844557.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752123AbcJGTr3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Oct 2016 15:47:29 -0400
In-Reply-To: <519377051f98268f41c382d2897ae578b2a743f6.1466844557.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>

On 06/25/2016 09:19 AM, Chen Yu wrote:
> Here's the story of what the problem is, why this
> happened, and why this patch looks like this:
>
> Stress test from Varun Koyyalagunta reports that, the
> nonboot CPU would hang occasionally, when resuming from
> hibernation. Further investigation shows that, the precise
> stage when nonboot CPU hangs, is the time when the nonboot
> CPU been woken up incorrectly, and tries to monitor the
> mwait_ptr for the second time, then an exception is
> triggered due to illegal vaddr access, say, something like,
> 'Unable to handler kernel address of 0xffff8800ba800010...'
>
> Further investigation shows that, the exception is caused
> by accessing a page without PRESENT flag, because the pte entry
> for this vaddr is zero. Here's the scenario how this problem
> happens: Page table for direct mapping is allocated dynamically
> by kernel_physical_mapping_init, it is possible that in the
> resume process, when the boot CPU is trying to write back pages
> to their original address, and just right to writes to the monitor
> mwait_ptr then wakes up one of the nonboot CPUs, since the page
> table currently used by the nonboot CPU might not the same as it
> is before the hibernation, an exception might occur due to
> inconsistent page table.
>
> First try is to get rid of this problem by changing the monitor
> address from task.flag to zero page, because one one would write
> to zero page. But this still have problem because of ping-pong
> wake up situation in mwait_play_dead:
>
> One possible implementation of a clflush is a read-invalidate snoop,
> which is what a store might look like, so cflush might break the mwait.
>
> 1. CPU1 wait at zero page
> 2. CPU2 cflush zero page, wake CPU1 up, then CPU2 waits at zero page
> 3. CPU1 is woken up, and invoke cflush zero page, thus wake up CPU2 again.
> then the nonboot CPUs never sleep for long.
>
> So it's better to monitor different address for each
> nonboot CPUs, however since there is only one zero page, at most:
> PAGE_SIZE/L1_CACHE_LINE CPUs are satisfied, which is usually 64
> on a x86_64, apparently it's not enough for servers, maybe more
> zero pages are required.
>
> So choose the solution as Brian suggested, to put the nonboot CPUs
> into hlt before resuming. But Rafael has mentioned that, if some of
> the CPUs have already been offline before hibernation, then the problem
> is still there. So this patch tries to kick the already offline CPUs woken
> up and fall into hlt, and then put the rest online CPUs into hlt.
> In this way, all the nonboot CPUs will wait at a safe state,
> without touching any memory during s/r. (It's not safe to modify
> mwait_play_dead, because once previous offline CPUs are woken up,
> it will either access text code, whose page table is not safe anymore
> across hibernation, due to:
> Commit ab76f7b4ab23 ("x86/mm: Set NX on gap between __ex_table and
> rodata").
>

I realize I'm extremely late to the party, but I must admit that I don't 
get it.  Sure, hibernation resume can spuriously wake the non-boot CPU, 
but at some point it has to wake up for real.  What ensures that the 
text it was running (native_play_dead or whatever) is still there when 
it wakes up?

Or does the hibernation resume code actually send the remote CPU an 
INIT-SIPI sequence a la wakeup_secondary_cpu_via_init()?  If so, this 
seems a bit odd to me.  Shouldn't we kick the CPU all the way to the 
wait-for-SIPI state rather than getting it to play dead via hlt or 
mwait?  Or perhaps there should be a real hibernation trampoline: 
allocate a safe page, have all CPUs jump there and spin (via hlt or 
mwait), do the resume, and then kick the other CPUs awake and have them 
jump back to real code.

--Andy
