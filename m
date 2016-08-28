From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Sun, 28 Aug 2016 18:36:59 +0200
Message-ID: <20160828163659.GA19306@amd>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@amd.karlin.mff.cuni.cz, Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Mon 2016-08-29 00:35:40, Chen Yu wrote:
> On some platforms, there is occasional panic triggered when trying to
> resume from hibernation, a typical panic looks like:
> 
> "BUG: unable to handle kernel paging request at ffff880085894000
> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> 
> This is because e820 map has been changed by BIOS across
> hibernation, and one of the page frames from first kernel
> is right located in second kernel's unmapped region, so panic
> comes out when accessing unmapped kernel address.
> 
> In order to expose this issue earlier, the md5 hash of e820 map
> is passed from suspend kernel to resume kernel, and the system will
> trigger panic once it finds the md5 value of previous kernel is not
> the same as current resume kernel.
> 
> Note:
> 1. Without this patch applied, it is possible that BIOS has
>    provided an inconsistent memory map, but the resume kernel is still
>    able to restore the image anyway(e.g.,  E820_RAM region is the subset
>    of the previous one), although the system might be unstable. So this
>    patch tries to treat any inconsistent e820 as illegal.
> 
> 2. Another case is, this patch replies on comparing the e820_saved, but
>    currently the e820_save might not be strictly the same across
>    hibernation, even if BIOS has provided consistent e820 map - In
>    theory mptable might modify the BIOS-provided e820_saved dynamically
>    in early_reserve_e820_mpc_new, which would allocate a buffer from
>    E820_RAM, and marks it from E820_RAM to E820_RESERVED). 
>    This is a potential and rare case we need to deal with in OS in
>    the future.
> 
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Lee, Chun-Yi <jlee@suse.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

You might want to verify that panic is actually visible on affected
platform. Thanks for your patience ;-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
