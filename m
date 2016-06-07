From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Tue, 7 Jun 2016 10:03:07 +0200
Message-ID: <20160607080307.GB13858@amd>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>
List-Id: linux-pm@vger.kernel.org

On Mon 2016-06-06 22:19:09, Chen Yu wrote:
> Stress test from Varun Koyyalagunta reports that, the
> nonboot CPU would hang occasionally, when resuming from
> hibernation. Further investigation shows that, the precise
> phase when nonboot CPU hangs, is the time when the nonboot
> CPU been woken up incorrectly, and tries to monitor the
> mwait_ptr for the second time, then an exception is
> triggered due to illegal vaddr access, say, something like,
> 'Unable to handler kernel address of 0xffff8800ba800010...'
> 
> One of the possible scenarios for this issue is illustrated below,
> when the boot CPU tries to resume from hibernation:
> 1. puts the nonboot CPUs offline, so the nonboot CPUs are monitoring
>    at the address of the task_struct.flags.
> 2. boot CPU copies pages to their original address, which includes
>    task_struct.flags, thus wakes up one of the nonboot CPUs.
> 3. nonboot CPU tries to monitor the task_struct.flags again, but since
>    the page table for task_struct.flags has been overwritten by
>    boot CPU, and there is probably a changed across hibernation
>    (because of inconsistence of e820 memory map), an exception is
>    triggered.

If memory map changes between suspend and resume, there'll be fun. If
that's suspected, should we attach md5 sum of e820 to the hibernation
image?

I doubt mwait fix is enough to catch everything in that case...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
