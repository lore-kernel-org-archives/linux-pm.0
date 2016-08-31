From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Wed, 31 Aug 2016 13:07:31 +0200
Message-ID: <20160831110731.GC12296@amd>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <4324101.BrknapGkIi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60900 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759402AbcHaLHe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 07:07:34 -0400
Content-Disposition: inline
In-Reply-To: <4324101.BrknapGkIi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@vger.kernel.org, Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>

On Wed 2016-08-31 02:27:53, Rafael J. Wysocki wrote:
> On Monday, August 29, 2016 12:35:40 AM Chen Yu wrote:
> > On some platforms, there is occasional panic triggered when trying to
> > resume from hibernation, a typical panic looks like:
> > 
> > "BUG: unable to handle kernel paging request at ffff880085894000
> > IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> > 
> > This is because e820 map has been changed by BIOS across
> > hibernation, and one of the page frames from first kernel
> > is right located in second kernel's unmapped region, so panic
> > comes out when accessing unmapped kernel address.
> > 
> > In order to expose this issue earlier, the md5 hash of e820 map
> > is passed from suspend kernel to resume kernel, and the system will
> > trigger panic once it finds the md5 value of previous kernel is not
> > the same as current resume kernel.
> > 
> > Note:
> > 1. Without this patch applied, it is possible that BIOS has
> >    provided an inconsistent memory map, but the resume kernel is still
> >    able to restore the image anyway(e.g.,  E820_RAM region is the subset
> >    of the previous one), although the system might be unstable. So this
> >    patch tries to treat any inconsistent e820 as illegal.
> > 
> > 2. Another case is, this patch replies on comparing the e820_saved, but
> >    currently the e820_save might not be strictly the same across
> >    hibernation, even if BIOS has provided consistent e820 map - In
> >    theory mptable might modify the BIOS-provided e820_saved dynamically
> >    in early_reserve_e820_mpc_new, which would allocate a buffer from
> >    E820_RAM, and marks it from E820_RAM to E820_RESERVED). 
> >    This is a potential and rare case we need to deal with in OS in
> >    the future.
> > 
> > Suggested-by: Pavel Machek <pavel@ucw.cz>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Lee, Chun-Yi <jlee@suse.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v8:
> >  - Panic the system once the e820 is found to be inconsistent
> >    during resume.
> >    Fix the md5 hash len from 128 bytes to 16 bytes.
> > v7:
> >  - Use md5 hash to compare the e820 map.
> > v6:
> >  - Fix some compiling errors reported by 0day/LKP, adjust
> >    Kconfig/variable namings.
> > v5:
> >  - Rewrite this patch to just warn user of the broken BIOS
> >    when panic.
> > v4:
> >  - Add __attribute__ ((unused)) for swsusp_page_is_valid,
> >    to eliminate the warnning of:
> >    'swsusp_page_is_valid' defined but not used
> >    on non-x86 platforms.
> > 
> > v3:
> >  - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
> >    when invoking mark_valid_pages, because the end_pfn is not
> >    a mapped page frame, we should not regard it as a valid page.
> > 
> >    Move the sanity check of valid pages to a early stage in resuming
> >    process(moved to mark_unsafe_pages), in this way, we can avoid
> >    unnecessarily accessing these invalid pages in later stage(yes,
> >    move to the original position Joey once introduced in:
> >    Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
> >    reserved regions")
> > 
> >    With v3 patch applied, I did 30 cycles on my problematic platform,
> >    no panic triggered anymore(50% reproducible before patched, by
> >    plugging/unplugging memory peripheral during hibernation), and it
> >    just warns of invalid pages.
> > 
> > v2:
> >  - According to Ingo's suggestion, rewrite this patch.
> > 
> >    New version just checks each page frame according to pfn_mapped array.
> >    So that we do not need to touch existing code related to
> >    E820_RESERVED_KERN. And this method can naturely guarantee
> >    that the system before/after hibernation do not need to be of
> >    the same memory size on x86_64.
> > 
> > ---
> >  arch/x86/power/hibernate_64.c | 98 +++++++++++++++++++++++++++++++++++++++++++
> >  kernel/power/Kconfig          |  9 ++++
> >  2 files changed, 107 insertions(+)
> > 
> > diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> > index 9634557..7eb27afd 100644
> > --- a/arch/x86/power/hibernate_64.c
> > +++ b/arch/x86/power/hibernate_64.c
> > @@ -11,6 +11,10 @@
> >  #include <linux/gfp.h>
> >  #include <linux/smp.h>
> >  #include <linux/suspend.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/kdebug.h>
> > +
> > +#include <crypto/hash.h>
> >  
> >  #include <asm/init.h>
> >  #include <asm/proto.h>
> > @@ -177,15 +181,100 @@ int pfn_is_nosave(unsigned long pfn)
> >  	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> >  }
> >  
> > +#define MD5_DIGEST_SIZE 16
> > +
> >  struct restore_data_record {
> >  	unsigned long jump_address;
> >  	unsigned long jump_address_phys;
> >  	unsigned long cr3;
> >  	unsigned long magic;
> > +	u8 e820_digest[MD5_DIGEST_SIZE];
> >  };
> >  
> >  #define RESTORE_MAGIC	0x123456789ABCDEF0UL
> 
> You're changing the image header format, so RESTORE_MAGIC needs to be updated
> too.

With !CONFIG_HIBERNATION_CHECK_E820, magic nothing changes in on-disk
format. (Unused space is now used).

If there's hibernation kernel is CONFIG_HIBERNATION_CHECK_E820, and
restore kernel is !CONFIG_HIBERNATION_CHECK_E820, we won't check the
E820, and that should be acceptable.

If there's hibernation kernel is !CONFIG_HIBERNATION_CHECK_E820, and
restore kernel is CONFIG_HIBERNATION_CHECK_E820, we'll fail the E820
check, and refuse to resume. That is also acceptable (and similar
result we'd get with RESTORE_MAGIC).. but the message will be
confusing.

Ok, so I guess we should change the magic.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
