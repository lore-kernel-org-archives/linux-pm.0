From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/12][RFC v3] x86, hibernate: Fix nosave_regions setup
 for hibernation
Date: Fri, 21 Sep 2018 00:05:02 +0200
Message-ID: <20180920220502.GD27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <9df6959bc2f3776eb512b7964a94bd02639e65eb.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9df6959bc2f3776eb512b7964a94bd02639e65eb.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:37:15, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> On 32bit systems, nosave_regions(non RAM areas) located between
> max_low_pfn and max_pfn are not excluded from hibernation snapshot
> currently, which may result in a machine check exception when
> trying to access these unsafe regions during hibernation:
> 
> [  612.800453] Disabling lock debugging due to kernel taint
> [  612.805786] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank 6: fe00000000801136
> [  612.814344] mce: [Hardware Error]: RIP !INEXACT! 60:<00000000d90be566> {swsusp_save+0x436/0x560}
> [  612.823167] mce: [Hardware Error]: TSC 1f5939fe276 ADDR dd000000 MISC 30e0000086
> [  612.830677] mce: [Hardware Error]: PROCESSOR 0:306c3 TIME 1529487426 SOCKET 0 APIC 0 microcode 24
> [  612.839581] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> [  612.846394] mce: [Hardware Error]: Machine check: Processor context corrupt
> [  612.853380] Kernel panic - not syncing: Fatal machine check
> [  612.858978] Kernel Offset: 0x18000000 from 0xc1000000 (relocation range: 0xc0000000-0xf7ffdfff)
> 
> This is because on 32bit systems, pages above max_low_pfn are regarded
> as high memeory, and accessing unsafe pages might cause expected MCE.
> On the problematic 32bit system, there are reserved memory above low
> memory, which triggered the MCE:
> 
> Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> This fix does not impact 64bit system because on 64bit max_low_pfn
> is the same as max_pfn.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks.

I think this is nasty enough to add Cc: stable.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
